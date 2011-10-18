Return-Path: <cyrus@holtmann.org>
Date: Tue, 18 Oct 2011 11:19:55 +0300
From: Andrei Emeltchenko <andrei.emeltchenko.news@gmail.com>
To: =?iso-8859-1?Q?Fr=E9d=E9ric?= Danis
	<frederic.danis@linux.intel.com>
Cc: linux-bluetooth@vger.kernel.org
Subject: Re: [PATCH v3] fix build
Message-ID: <20111018081952.GA8054@aemeltch-MOBL1>
References: <1318866965-11091-1-git-send-email-frederic.danis@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
In-Reply-To: <1318866965-11091-1-git-send-email-frederic.danis@linux.intel.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

On Mon, Oct 17, 2011 at 05:56:05PM +0200, Frédéric Danis wrote:
> src/eir.c: In function 'eir_parse':
> src/eir.c:72: error: 'name_len' may be used uninitialized in this function
> 
> and
> 
> thermometer/thermometer.c: In function 'destroy_char':
> thermometer/thermometer.c:79: error: implicit declaration of function 'g_slist_free_full'
> ---
>  src/eir.c                 |    2 +-
>  thermometer/thermometer.c |    5 +++++
>  2 files changed, 6 insertions(+), 1 deletions(-)
> 
> diff --git a/src/eir.c b/src/eir.c
> index 8772191..8ada364 100644
> --- a/src/eir.c
> +++ b/src/eir.c
> @@ -69,7 +69,7 @@ int eir_parse(struct eir_data *eir, uint8_t *eir_data)
>  	uuid_t service;
>  	char *uuid_str;
>  	const char *name = NULL;
> -	size_t name_len;
> +	size_t name_len = 0;

BTW: shall we change build flags otherwise bluez is not building anymore.

make
make --no-print-directory all-am
  CC     src/eir.o
cc1: warnings being treated as errors
src/eir.c: In function ‘eir_parse’:
src/eir.c:73:9: error: ‘name_len’ may be used uninitialized in this
function
make[1]: *** [src/eir.o] Ошибка 1
make: *** [all] Ошибка 2

Best regards 
Andrei Emeltchenko 


>  	unsigned int i;
>  
>  	eir->flags = -1;
> diff --git a/thermometer/thermometer.c b/thermometer/thermometer.c
> index 7621926..653ec76 100644
> --- a/thermometer/thermometer.c
> +++ b/thermometer/thermometer.c
> @@ -20,6 +20,10 @@
>   *
>   */
>  
> +#ifdef HAVE_CONFIG_H
> +#include <config.h>
> +#endif
> +
>  #include <gdbus.h>
>  #include <errno.h>
>  #include <bluetooth/uuid.h>
> @@ -34,6 +38,7 @@
>  #include "att.h"
>  #include "gatt.h"
>  #include "thermometer.h"
> +#include "glib-helper.h"
>  
>  #define THERMOMETER_INTERFACE "org.bluez.Thermometer"
>  
> -- 
> 1.7.1
> 
> --
> To unsubscribe from this list: send the line "unsubscribe linux-bluetooth" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
