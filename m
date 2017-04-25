Return-Path: <szymon.janc@codecoup.pl>
From: Szymon Janc <szymon.janc@codecoup.pl>
To: Salvatore Benedetto <salvatore.benedetto@intel.com>
Cc: gustavo@padovan.org, linux-bluetooth@vger.kernel.org, herbert@gondor.apana.org.au, marcel@holtmann.org, johan.hedberg@gmail.com
Subject: Re: [PATCH] Bluetooth: allocate data for kpp on heap
Date: Tue, 25 Apr 2017 10:38:05 -0700
Message-ID: <1899161.UMzm0Rcsma@ix>
In-Reply-To: <1493135987-2618-1-git-send-email-salvatore.benedetto@intel.com>
References: <1493135987-2618-1-git-send-email-salvatore.benedetto@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
List-ID: <linux-bluetooth.vger.kernel.org>

Hi,

On Tuesday, 25 April 2017 08:59:47 PDT Salvatore Benedetto wrote:
> Bluetooth would crash when computing ECDH keys with kpp
> if VMAP_STACK is enabled. Fix by allocating data passed
> to kpp on heap.
> 
> Fixes: 58771c1c ("Bluetooth: convert smp and selftest to crypto kpp
> API")
> Signed-off-by: Salvatore Benedetto <salvatore.benedetto@intel.com>
> ---
>  net/bluetooth/ecdh_helper.c |  6 ++++--
>  net/bluetooth/selftest.c    | 16 +++++++++++-----
>  2 files changed, 15 insertions(+), 7 deletions(-)
> 
> diff --git a/net/bluetooth/ecdh_helper.c b/net/bluetooth/ecdh_helper.c
> index b6d9aa1..8018447 100644
> --- a/net/bluetooth/ecdh_helper.c
> +++ b/net/bluetooth/ecdh_helper.c
> @@ -59,7 +59,7 @@ bool compute_ecdh_secret(const u8 public_key[64], const u8
> private_key[32], struct ecdh p;
>  	struct ecdh_completion result;
>  	struct scatterlist src, dst;
> -	u8 tmp[64];
> +	u8 *tmp = kmalloc(64, GFP_KERNEL);

Should this be checked for null?

>  	u8 *buf;
>  	unsigned int buf_len;
>  	int err = -ENOMEM;
> @@ -68,7 +68,7 @@ bool compute_ecdh_secret(const u8 public_key[64], const u8
> private_key[32], if (IS_ERR(tfm)) {
>  		pr_err("alg: kpp: Failed to load tfm for kpp: %ld\n",
>  		       PTR_ERR(tfm));
> -		return false;
> +		goto free_tmp;
>  	}
> 
>  	req = kpp_request_alloc(tfm, GFP_KERNEL);
> @@ -128,6 +128,8 @@ bool compute_ecdh_secret(const u8 public_key[64], const
> u8 private_key[32], kpp_request_free(req);
>  free_kpp:
>  	crypto_free_kpp(tfm);
> +free_tmp:
> +	kfree(tmp);
>  	return (err == 0);
>  }
> 
> diff --git a/net/bluetooth/selftest.c b/net/bluetooth/selftest.c
> index efef281..9a72f8f 100644
> --- a/net/bluetooth/selftest.c
> +++ b/net/bluetooth/selftest.c
> @@ -142,18 +142,24 @@ static int __init test_ecdh_sample(const u8
> priv_a[32], const u8 priv_b[32], const u8 pub_a[64], const u8 pub_b[64],
>  				   const u8 dhkey[32])
>  {
> -	u8 dhkey_a[32], dhkey_b[32];
> +	u8 *dhkey_a = kmalloc(64, GFP_KERNEL);
> +	u8 *dhkey_b = &dhkey_a[32];
> +	int ret = 0;
> 
>  	compute_ecdh_secret(pub_b, priv_a, dhkey_a);
>  	compute_ecdh_secret(pub_a, priv_b, dhkey_b);
> 
> -	if (memcmp(dhkey_a, dhkey, 32))
> -		return -EINVAL;
> +	if (memcmp(dhkey_a, dhkey, 32)) {
> +		ret = -EINVAL;
> +		goto out;
> +	}
> 
>  	if (memcmp(dhkey_b, dhkey, 32))
> -		return -EINVAL;
> +		ret = -EINVAL;
> 
> -	return 0;
> +out:
> +	kfree(dhkey_a);
> +	return ret;
>  }
> 
>  static char test_ecdh_buffer[32];


-- 
pozdrawiam
Szymon Janc
