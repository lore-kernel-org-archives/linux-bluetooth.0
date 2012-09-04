Return-Path: <cyrus@holtmann.org>
Message-ID: <1346772105.21200.2.camel@aeonflux>
Subject: Re: [RFC v4 15/18] Refactor bt_get_unaligned macro
From: Marcel Holtmann <marcel@holtmann.org>
To: Szymon Janc <szymon.janc@tieto.com>
Cc: linux-bluetooth@vger.kernel.org
Date: Tue, 04 Sep 2012 08:21:45 -0700
In-Reply-To: <1346769697-9930-16-git-send-email-szymon.janc@tieto.com>
References: <1346769697-9930-1-git-send-email-szymon.janc@tieto.com>
	 <1346769697-9930-16-git-send-email-szymon.janc@tieto.com>
Content-Type: text/plain; charset="UTF-8"
Mime-Version: 1.0
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Szymon,

> Use extra parameter type for bt_get_unaligned to avoid pointer casting
> which might trigger compile time errors due to unaligned memory access.
> 
> ---
>  attrib/att.h       |    6 +++---
>  lib/bluetooth.h    |   28 ++++++++++++++--------------
>  lib/sdp.c          |   22 +++++++++++-----------
>  src/sdpd-request.c |    4 ++--
>  4 files changed, 30 insertions(+), 30 deletions(-)
> 
> diff --git a/attrib/att.h b/attrib/att.h
> index a563255..6101dac 100644
> --- a/attrib/att.h
> +++ b/attrib/att.h
> @@ -115,19 +115,19 @@ struct att_range {
>  static inline uint8_t att_get_u8(const void *ptr)
>  {
>  	const uint8_t *u8_ptr = ptr;
> -	return bt_get_unaligned(u8_ptr);
> +	return bt_get_unaligned(u8_ptr, uint8_t);
>  }
>  
>  static inline uint16_t att_get_u16(const void *ptr)
>  {
>  	const uint16_t *u16_ptr = ptr;
> -	return btohs(bt_get_unaligned(u16_ptr));
> +	return btohs(bt_get_unaligned(u16_ptr, uint16_t));
>  }
>  
>  static inline uint32_t att_get_u32(const void *ptr)
>  {
>  	const uint32_t *u32_ptr = ptr;
> -	return btohl(bt_get_unaligned(u32_ptr));
> +	return btohl(bt_get_unaligned(u32_ptr, uint32_t));
>  }
>  
>  static inline uint128_t att_get_u128(const void *ptr)
> diff --git a/lib/bluetooth.h b/lib/bluetooth.h
> index 161b7bd..898a122 100644
> --- a/lib/bluetooth.h
> +++ b/lib/bluetooth.h
> @@ -137,10 +137,10 @@ enum {
>  #endif
>  
>  /* Bluetooth unaligned access */
> -#define bt_get_unaligned(ptr)			\
> +#define bt_get_unaligned(ptr, type)		\
>  ({						\
>  	struct __attribute__((packed)) {	\
> -		typeof(*(ptr)) __v;		\
> +		type __v;			\
>  	} *__p = (typeof(__p)) (ptr);		\
>  	__p->__v;				\
>  })

I am not in favor of this change at all. We should not need such a
change. And in addition, it break the API.

Regards

Marcel


