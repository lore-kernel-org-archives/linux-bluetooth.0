Return-Path: <cyrus@holtmann.org>
From: Szymon Janc <szymon.janc@tieto.com>
To: Andrei Emeltchenko <Andrei.Emeltchenko.news@gmail.com>
Cc: linux-bluetooth@vger.kernel.org
Subject: Re: [PATCH] android/client: Set default handsfree mode for host
Date: Mon, 28 Jul 2014 12:46:23 +0200
Message-ID: <1625661.E497b1LD2C@uw000953>
In-Reply-To: <1406201574-11891-1-git-send-email-Andrei.Emeltchenko.news@gmail.com>
References: <1406201574-11891-1-git-send-email-Andrei.Emeltchenko.news@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Andrei,

On Thursday 24 of July 2014 14:32:54 Andrei Emeltchenko wrote:
> From: Andrei Emeltchenko <andrei.emeltchenko@intel.com>
> 
> For testing set default handsfree mode to HF
> ---
>  android/cutils/properties.h | 4 ++++
>  1 file changed, 4 insertions(+)
> 
> diff --git a/android/cutils/properties.h b/android/cutils/properties.h
> index ef40f01..8b3d84d 100644
> --- a/android/cutils/properties.h
> +++ b/android/cutils/properties.h
> @@ -31,6 +31,7 @@
>  #define PROPERTY_VALUE_MAX 32
>  
>  #define BLUETOOTH_MODE_PROPERTY_NAME "persist.sys.bluetooth.mode"
> +#define BLUETOOTH_MODE_PROPERTY_HANDSFREE "persist.sys.bluetooth.handsfree"
>  
>  static inline int property_get(const char *key, char *value,
>  						const char *default_value)
> @@ -40,6 +41,9 @@ static inline int property_get(const char *key, char *value,
>  	if (!strcmp(key, BLUETOOTH_MODE_PROPERTY_NAME))
>  		prop = getenv("BLUETOOTH_MODE");
>  
> +	if (!strcmp(key, BLUETOOTH_MODE_PROPERTY_HANDSFREE))
> +		prop = "hfp";

I'd prefer to not have this hardcoded. So please use getenv() for getting
handsfree mode (similar to what is now with bluetooth mode).

This will allow for easy testing of all configurations on Linux host.

> +
>  	if (!prop)
>  		prop = default_value;
>  
> 

-- 
Best regards, 
Szymon Janc
