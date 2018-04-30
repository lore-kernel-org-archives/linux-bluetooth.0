Return-Path: <linux-bluetooth-owner@vger.kernel.org>
Content-Type: text/plain;
        charset=utf-8
Mime-Version: 1.0 (Mac OS X Mail 11.3 \(3445.6.18\))
Subject: Re: [PATCH BlueZ v2 1/1] shared/ecc: Allow pre-composed Private Keys
From: Marcel Holtmann <marcel@holtmann.org>
In-Reply-To: <20180427171049.2250-2-brian.gix@intel.com>
Date: Mon, 30 Apr 2018 10:46:08 +0200
Cc: Luiz Augusto von Dentz <luiz.dentz@gmail.com>,
        linux-bluetooth@vger.kernel.org
Message-Id: <B8AE2E0F-864A-4289-BCDC-60CBBAED12F3@holtmann.org>
References: <20180427171049.2250-1-brian.gix@intel.com>
 <20180427171049.2250-2-brian.gix@intel.com>
To: Brian Gix <brian.gix@intel.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Brian,

> Add function ecc_make_public_key() which takes a const private_key
> and generates a validated public_key to complete the pair.
> 
> Non-ephemeral key sets are required to support Bluetooth Mesh.
> ---
> src/shared/ecc.c | 42 +++++++++++++++++++++++++++++-------------
> src/shared/ecc.h | 17 ++++++++++++++---
> 2 files changed, 43 insertions(+), 16 deletions(-)
> 
> diff --git a/src/shared/ecc.c b/src/shared/ecc.c
> index eb2cc005d..47f229ca9 100644
> --- a/src/shared/ecc.c
> +++ b/src/shared/ecc.c
> @@ -856,33 +856,49 @@ static void ecc_native2bytes(const uint64_t native[NUM_ECC_DIGITS],
> 	}
> }
> 
> -bool ecc_make_key(uint8_t public_key[64], uint8_t private_key[32])
> +bool ecc_make_public_key(const uint8_t private_key[32], uint8_t public_key[64])
> {
> 	struct ecc_point pk;
> 	uint64_t priv[NUM_ECC_DIGITS];
> -	unsigned tries = 0;
> 
> -	do {
> -		if (!get_random_number(priv) || (tries++ >= MAX_TRIES))
> -			return false;
> +	ecc_bytes2native(private_key, priv);
> 
> -		if (vli_is_zero(priv))
> -			continue;
> +	if (vli_is_zero(priv))
> +		return false;
> 
> -		/* Make sure the private key is in the range [1, n-1]. */
> -		if (vli_cmp(curve_n, priv) != 1)
> -			continue;
> +	/* Make sure the private key is in the range [1, n-1]. */
> +	if (vli_cmp(curve_n, priv) != 1)
> +		return false;
> +
> +	ecc_point_mult(&pk, &curve_g, priv, NULL, vli_num_bits(priv));
> 
> -		ecc_point_mult(&pk, &curve_g, priv, NULL, vli_num_bits(priv));
> -	} while (ecc_point_is_zero(&pk));
> +	if (ecc_point_is_zero(&pk))
> +		return false;
> 
> -	ecc_native2bytes(priv, private_key);
> 	ecc_native2bytes(pk.x, public_key);
> 	ecc_native2bytes(pk.y, &public_key[32]);
> 
> 	return true;
> }
> 
> +bool ecc_make_key(uint8_t public_key[64], uint8_t private_key[32])
> +{
> +	uint64_t priv[NUM_ECC_DIGITS];
> +	unsigned tries = 0;
> +	bool result = false;
> +
> +	for (tries = 0; !result && tries < MAX_TRIES; tries++) {
> +		if (!get_random_number(priv))
> +			continue;
> +
> +		ecc_native2bytes(priv, private_key);
> +
> +		result = ecc_make_public_key(private_key, public_key);
> +	}

this is actually a functional change. On result == false, the private_key return value is now populated. Also the !result in the for-loop check is rather complicated. That is hard to follow code. In addition setting tries = 0 on declaration is pointless. Just blindly trying to swap a do-while with a for-loop is not going to work.

I would have preferred you didn’t touch ecc_make_key at all and just create a new ecc_make_public_key. I think you tried to over-optimize here.

> +
> +	return result;
> +}
> +
> bool ecc_valid_public_key(const uint8_t public_key[64])
> {
> 	struct ecc_point pk;
> diff --git a/src/shared/ecc.h b/src/shared/ecc.h
> index f89f2b0c3..a88e735c7 100644
> --- a/src/shared/ecc.h
> +++ b/src/shared/ecc.h
> @@ -27,14 +27,25 @@
> #include <stdbool.h>
> #include <stdint.h>
> 
> +/* Create a public key from a private key.
> + *
> + * Outputs:
> + *	private_key - Const private key

This so wrong.

It is Inputs: private_key and the word “Const” has nothing to do here.

> + *	public_key  - Will be filled in with the public key.
> + *
> + * Returns true if the public key was generated successfully, false
> + * if an error occurred. The keys are with the LSB first.
> + */
> +bool ecc_make_public_key(const uint8_t private_key[32], uint8_t public_key[64]);
> +
> /* Create a public/private key pair.
>  *
>  * Outputs:
>  *	public_key  - Will be filled in with the public key.
> - *	private_Key - Will be filled in with the private key.
> + *	private_key - Will be filled in with the private key.
>  *
>  * Returns true if the key pair was generated successfully, false
> - * if an error occurred. They keys are with the LSB first.
> + * if an error occurred. The keys are with the LSB first.
>  */
> bool ecc_make_key(uint8_t public_key[64], uint8_t private_key[32]);
> 
> @@ -54,7 +65,7 @@ bool ecc_valid_public_key(const uint8_t public_key[64]);
>  *
>  * Inputs:
>  *	public_key  - The public key of the remote party.
> - *	private_Key - Your private key.
> + *	private_key - Your private key.
>  *
>  * Outputs:
>  *	secret - Will be filled in with the shared secret value.

Regards

Marcel

