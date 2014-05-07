Return-Path: <cyrus@holtmann.org>
From: Szymon Janc <szymon.janc@tieto.com>
To: Lukasz Rymanowski <lukasz.rymanowski@tieto.com>
Cc: linux-bluetooth@vger.kernel.org
Subject: Re: [PATCH] android: Add possibility to start android daemon on PC in single mode
Date: Wed, 07 May 2014 16:15:13 +0200
Message-ID: <6364532.x448p36TxV@uw000953>
In-Reply-To: <1399420934-30409-1-git-send-email-lukasz.rymanowski@tieto.com>
References: <1399420934-30409-1-git-send-email-lukasz.rymanowski@tieto.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Łukasz,

On Wednesday 07 of May 2014 02:02:14 Lukasz Rymanowski wrote:
> With this patch it is possible to start android daemon on PC in
> BREDR or LE or BREDR/LE mode by setting system environment variable
> named BLUETOOTH_MODE to appropriate value according to README.
> 
> This is useful for testing purposes.
> ---
>  android/cutils/properties.h | 13 +++++++++++++
>  1 file changed, 13 insertions(+)
> 
> diff --git a/android/cutils/properties.h b/android/cutils/properties.h
> index 66a4a84..b9c59a5 100644
> --- a/android/cutils/properties.h
> +++ b/android/cutils/properties.h
> @@ -29,9 +29,22 @@
>  
>  #define PROPERTY_VALUE_MAX 32
>  
> +#define BLUETOOTH_MODE_PROPERTY_NAME "persist.sys.bluetooth.mode"
> +
>  static inline int property_get(const char *key, char *value,
>  						const char *default_value)
>  {
> +	if (!strcmp(key, BLUETOOTH_MODE_PROPERTY_NAME)) {
> +		char *mode;
> +
> +		mode = getenv("BLUETOOTH_MODE");
> +		if (!mode)
> +			return 0;
> +
> +		memcpy(value, mode, strlen(mode));
> +		return 1;
> +	}
> +
>  	return 0;
>  }
>  
> 

Pushed with changes we discussed offline, thanks.

-- 
Best regards, 
Szymon Janc
