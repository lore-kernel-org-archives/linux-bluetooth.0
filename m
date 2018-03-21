Return-Path: <gustavo@embeddedor.com>
Subject: Re: [PATCH] Bluetooth: Remove VLA usage in aes_cmac
To: "Gustavo A. R. Silva" <garsilva@embeddedor.com>,
 Marcel Holtmann <marcel@holtmann.org>,
 Johan Hedberg <johan.hedberg@gmail.com>,
 "David S. Miller" <davem@davemloft.net>
Cc: linux-bluetooth@vger.kernel.org, netdev@vger.kernel.org,
 linux-kernel@vger.kernel.org
References: <20180320233444.GA14446@embeddedor.com>
From: "Gustavo A. R. Silva" <gustavo@embeddedor.com>
Message-ID: <1d334ec6-5188-f786-f136-fd7d418acbd8@embeddedor.com>
Date: Tue, 20 Mar 2018 19:57:54 -0500
MIME-Version: 1.0
In-Reply-To: <20180320233444.GA14446@embeddedor.com>
Content-Type: text/plain; charset=utf-8; format=flowed
List-ID: <linux-bluetooth.vger.kernel.org>

Hi,

I've just discovered an issue in this patch. Please, drop it. I'll send 
v2 shortly.

Thanks
--
Gustavo

On 03/20/2018 06:34 PM, Gustavo A. R. Silva wrote:
> In preparation to enabling -Wvla, remove VLA and replace it
> with dynamic memory allocation instead.
> 
> The use of stack Variable Length Arrays needs to be avoided, as they
> can be a vector for stack exhaustion, which can be both a runtime bug
> or a security flaw. Also, in general, as code evolves it is easy to
> lose track of how big a VLA can get. Thus, we can end up having runtime
> failures that are hard to debug.
> 
> Also, fixed as part of the directive to remove all VLAs from
> the kernel: https://lkml.org/lkml/2018/3/7/621
> 
> Signed-off-by: Gustavo A. R. Silva <garsilva@embeddedor.com>
> ---
>   net/bluetooth/smp.c | 16 +++++++++++-----
>   1 file changed, 11 insertions(+), 5 deletions(-)
> 
> diff --git a/net/bluetooth/smp.c b/net/bluetooth/smp.c
> index a2ddae2..23c694d 100644
> --- a/net/bluetooth/smp.c
> +++ b/net/bluetooth/smp.c
> @@ -173,7 +173,7 @@ static int aes_cmac(struct crypto_shash *tfm, const u8 k[16], const u8 *m,
>   		    size_t len, u8 mac[16])
>   {
>   	uint8_t tmp[16], mac_msb[16], msg_msb[CMAC_MSG_MAX];
> -	SHASH_DESC_ON_STACK(desc, tfm);
> +	struct shash_desc *shash;
>   	int err;
>   
>   	if (len > CMAC_MSG_MAX)
> @@ -184,8 +184,13 @@ static int aes_cmac(struct crypto_shash *tfm, const u8 k[16], const u8 *m,
>   		return -EINVAL;
>   	}
>   
> -	desc->tfm = tfm;
> -	desc->flags = 0;
> +	shash = kzalloc(sizeof(*shash) + crypto_shash_descsize(tfm),
> +			GFP_KERNEL);
> +	if (!shash)
> +		return -ENOMEM;
> +
> +	shash->tfm = tfm;
> +	shash->flags = 0;
>   
>   	/* Swap key and message from LSB to MSB */
>   	swap_buf(k, tmp, 16);
> @@ -200,8 +205,9 @@ static int aes_cmac(struct crypto_shash *tfm, const u8 k[16], const u8 *m,
>   		return err;
>   	}
>   
> -	err = crypto_shash_digest(desc, msg_msb, len, mac_msb);
> -	shash_desc_zero(desc);
> +	err = crypto_shash_digest(shash, msg_msb, len, mac_msb);
> +	shash_desc_zero(shash);
> +	kfree(shash);
>   	if (err) {
>   		BT_ERR("Hash computation error %d", err);
>   		return err;
> 
