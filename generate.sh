#!/bin/bash

set -euo pipefail

if [ -d output ]; then
  >&2 echo 'output directory exists. aborting.'
  exit 1
fi

mkdir output

function generate_root {
  cfssl gencert -initca source/root.json |
    cfssljson -bare output/root
}

function generate_cert {
  cfssl gencert -ca output/"$1.pem" \
                -ca-key output/"${1}-key.pem" \
                -config config.json \
                -profile "$2" \
                source/"$2.json" |
    cfssljson -bare output/"$2"
}

function generate_intermediate {
  generate_cert root intermediate
}

function generate_chain {
  cat output/intermediate.pem output/root.pem > output/chain.pem
}

function generate_server {
  generate_cert intermediate server
}

function generate_client {
  generate_cert intermediate client
}

generate_root
generate_intermediate
generate_chain
generate_server
generate_client
