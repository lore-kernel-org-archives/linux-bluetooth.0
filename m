Return-Path: <cyrus@holtmann.org>
Content-Type: text/plain; charset=us-ascii
Mime-Version: 1.0 (Mac OS X Mail 8.0 \(1990.1\))
Subject: Re: [PATCH BlueZ] lib: Change bluetooth.h to compile using strict C
From: Marcel Holtmann <marcel@holtmann.org>
In-Reply-To: <1414458592-11844-1-git-send-email-gabrielfrancosouza@gmail.com>
Date: Tue, 28 Oct 2014 09:26:32 -0700
Cc: linux-bluetooth@vger.kernel.org
Message-Id: <A6A9B75B-1238-4B6C-A9CD-C9E76F306DE7@holtmann.org>
References: <1414458592-11844-1-git-send-email-gabrielfrancosouza@gmail.com>
To: Gabriel Souza Franco <gabrielfrancosouza@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Gabriel,

> 
> Signed-off-by: Gabriel Souza Franco <gabrielfrancosouza@gmail.com>

no signed-off-by for userspace patches please.

> ---
> 
> This change enables programs writen with strict C syntax
> (e.g. "-std=c11 -pedantic") to compile when including
> bluetooth.h. Also changed src/shared/util.h to match.
> 
> lib/bluetooth.h   | 10 +++++-----
> src/shared/util.h | 10 +++++-----
> 2 files changed, 10 insertions(+), 10 deletions(-)

Split this into two patches. lib/ and src/shared/ should always be patched independently.

> 
> diff --git a/lib/bluetooth.h b/lib/bluetooth.h
> index 61c1f9a..f214d81 100644
> --- a/lib/bluetooth.h
> +++ b/lib/bluetooth.h
> @@ -156,18 +156,18 @@ enum {
> 
> /* Bluetooth unaligned access */
> #define bt_get_unaligned(ptr)			\
> -({						\
> +__extension__ ({				\
> 	struct __attribute__((packed)) {	\
> -		typeof(*(ptr)) __v;		\
> -	} *__p = (typeof(__p)) (ptr);		\
> +		__typeof__(*(ptr)) __v;		\
> +	} *__p = (__typeof__(__p)) (ptr);	\
> 	__p->__v;				\
> })
> 
> #define bt_put_unaligned(val, ptr)		\
> do {						\
> 	struct __attribute__((packed)) {	\
> -		typeof(*(ptr)) __v;		\
> -	} *__p = (typeof(__p)) (ptr);		\
> +		__typeof__(*(ptr)) __v;		\
> +	} *__p = (__typeof__(__p)) (ptr);	\
> 	__p->__v = (val);			\
> } while(0)
> 
> diff --git a/src/shared/util.h b/src/shared/util.h
> index 04c600f..8437662 100644
> --- a/src/shared/util.h
> +++ b/src/shared/util.h
> @@ -57,18 +57,18 @@
> #endif
> 
> #define get_unaligned(ptr)			\
> -({						\
> +__extension__ ({				\
> 	struct __attribute__((packed)) {	\
> -		typeof(*(ptr)) __v;		\
> -	} *__p = (typeof(__p)) (ptr);		\
> +		__typeof__(*(ptr)) __v;		\
> +	} *__p = (__typeof__(__p)) (ptr);	\
> 	__p->__v;				\
> })
> 
> #define put_unaligned(val, ptr)			\
> do {						\
> 	struct __attribute__((packed)) {	\
> -		typeof(*(ptr)) __v;		\
> -	} *__p = (typeof(__p)) (ptr);		\
> +		__typeof__(*(ptr)) __v;		\
> +	} *__p = (__typeof__(__p)) (ptr);	\
> 	__p->__v = (val);			\
> } while (0)

Regards

Marcel

