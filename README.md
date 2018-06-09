# Dummy PKI

In order to keep myself from manually creating these over and over (yes, this is
a problem), I've decided to make a set for the world. This set should outlive
me.

I would not recommend using these for anything other than testing.

To generate your own from this repo, then do this:
```bash
rm -rf output
./generate.sh
```

To verify signatures, do this:
```bash
(
    cd output
    openssl verify -CAfile root.pem intermediate.pem
    openssl verify -CAfile root.pem -untrusted intermediate.pem server.pem
    openssl verify -CAfile root.pem -untrusted intermediate.pem client.pem
)
```

To generate a set that you can actually use for something, I would recommend:
* bringing the expiration date around 99 years closer
* making the key sizes bigger ([I go by 128-bit equivalents](https://www.keylength.com/en/4/))
* changing the subject fields
* changing the hostnames

I probably didn't write this for you unless I'm reading this. I just seriously
needed to stop solving this problem.
