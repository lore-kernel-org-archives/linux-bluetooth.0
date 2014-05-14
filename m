Return-Path: <cyrus@holtmann.org>
Content-Type: text/plain; charset=us-ascii
Mime-Version: 1.0 (Mac OS X Mail 7.2 \(1874\))
Subject: Re: [PATCH 2/3] shared/crypto: Add support to sign data with AES-CMAC
From: Marcel Holtmann <marcel@holtmann.org>
In-Reply-To: <1400058266-31790-2-git-send-email-lukasz.rymanowski@tieto.com>
Date: Wed, 14 May 2014 08:07:15 -0700
Cc: linux-bluetooth@vger.kernel.org
Message-Id: <B1BB1461-49E6-41AA-9409-B0A53377F7E1@holtmann.org>
References: <1400058266-31790-1-git-send-email-lukasz.rymanowski@tieto.com> <1400058266-31790-2-git-send-email-lukasz.rymanowski@tieto.com>
To: Lukasz Rymanowski <lukasz.rymanowski@tieto.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Lukas,

> This patch adds support to generate hash using AES-CMAC algorithm
> ---
> src/shared/crypto.c | 37 +++++++++++++++++++++++++++++++++++++
> src/shared/crypto.h |  4 ++++
> 2 files changed, 41 insertions(+)
> 
> diff --git a/src/shared/crypto.c b/src/shared/crypto.c
> index f0b2979..a0bcc7b 100644
> --- a/src/shared/crypto.c
> +++ b/src/shared/crypto.c
> @@ -256,6 +256,43 @@ static inline void swap128(const uint8_t src[16], uint8_t dst[16])
> 		dst[15 - i] = src[i];
> }
> 
> +bool bt_crypto_cmac_aes_hash(struct bt_crypto *crypto,
> +					const uint8_t key[16],
> +					const uint8_t *m, uint16_t m_len,
> +					uint8_t hash[12])
> +{
> +	int fd;
> +	int len;
> +	uint8_t tmp[16], out[16];
> +
> +	if (!crypto)
> +		return false;
> +
> +	/* The most significant octet of key corresponds to key[0] */
> +	swap128(key, tmp);
> +
> +	fd = alg_new(crypto->cmac_aes, tmp, 16);
> +	if (fd < 0)
> +		return false;
> +
> +	len = send(fd, m, m_len, 0);
> +	if (len < 0)
> +		return false;
> +
> +	len = read(fd, out, 16);
> +	if (len < 0)
> +		return false;
> +
> +	/*
> +	 * The most significant octet of hash corresponds to out[0]  - swap it.
> +	 * Then truncate in most significant bit first order to a length of
> +	 * 12 octets
> +	 */
> +	swap128(out, tmp);
> +	memcpy(hash, tmp + 4, 12);
> +
> +	return true;
> +}
> /*
>  * Security function e
>  *
> diff --git a/src/shared/crypto.h b/src/shared/crypto.h
> index cae8daa..05888b9 100644
> --- a/src/shared/crypto.h
> +++ b/src/shared/crypto.h
> @@ -46,3 +46,7 @@ bool bt_crypto_c1(struct bt_crypto *crypto, const uint8_t k[16],
> bool bt_crypto_s1(struct bt_crypto *crypto, const uint8_t k[16],
> 			const uint8_t r1[16], const uint8_t r2[16],
> 			uint8_t res[16]);
> +bool bt_crypto_cmac_aes_hash(struct bt_crypto *crypto,
> +					const uint8_t key[16],
> +					const uint8_t *m, uint16_t m_len,
> +					uint8_t hash[12]);

we are using the cryptographic names from the Bluetooth specification cryptographic toolbox. I bet this one has a proper function name as well. So lets use that one.

Regards

Marcel

