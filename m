Return-Path: <cyrus@holtmann.org>
Date: Sun, 23 Oct 2011 22:32:06 +0200
From: Johan Hedberg <johan.hedberg@gmail.com>
To: Emeltchenko Andrei <Andrei.Emeltchenko.news@gmail.com>,
	linux-bluetooth@vger.kernel.org
Subject: Re: [PATCHv6 hcidump 2/4] add fixed channel definitions
Message-ID: <20111023203206.GA7538@fusion.localdomain>
References: <1319099414-27993-1-git-send-email-Andrei.Emeltchenko.news@gmail.com>
 <1319099414-27993-3-git-send-email-Andrei.Emeltchenko.news@gmail.com>
 <20111021083653.GA1800@fusion.localdomain>
 <20111021104818.GA3934@aemeltch-MOBL1>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20111021104818.GA3934@aemeltch-MOBL1>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Andrei,

On Fri, Oct 21, 2011, Emeltchenko Andrei wrote:
> Would the following code be OK?
> 
> diff --git a/lib/bluetooth.h b/lib/bluetooth.h
> index b0680e2..158103b 100644
> --- a/lib/bluetooth.h
> +++ b/lib/bluetooth.h
> @@ -125,6 +125,30 @@ do {                                               \
>         __p->__v = (val);                       \
>  } while(0)
>  
> +#if __BYTE_ORDER == __LITTLE_ENDIAN
> +inline uint64_t bt_get_le64(void *ptr)
> +{
> +       return bt_get_unaligned((uint64_t *) ptr);
> +}
> +
> +inline uint64_t bt_get_be64(void *ptr)
> +{
> +       return bswap_64(bt_get_unaligned((uint64_t *) ptr));
> +}
> +#elif __BYTE_ORDER == __BIG_ENDIAN
> +inline uint64_t bt_get_le64(void *ptr)
> +{
> +       return bswap_64(bt_get_unaligned((uint64_t *) ptr));
> +}
> +
> +inline uint64_t bt_get_be64(void *ptr)
> +{
> +       return bt_get_unaligned((uint64_t *) ptr);
> +}
> +#else
> +#error "Unknown byte order"
> +#endif
> +

Yes, I think that would be fine, but please also add the same for 32 and
16 bit integers.

Johan
