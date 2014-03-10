Return-Path: <cyrus@holtmann.org>
From: Szymon Janc <szymon.janc@tieto.com>
To: Lukasz Rymanowski <lukasz.rymanowski@tieto.com>
Cc: linux-bluetooth@vger.kernel.org
Subject: Re: [PATCH 1/3] android: Change property name for valgrind
Date: Mon, 10 Mar 2014 10:27:03 +0100
Message-ID: <3116881.z1IPYBI2Sp@uw000953>
In-Reply-To: <1394098681-18983-1-git-send-email-lukasz.rymanowski@tieto.com>
References: <1394098681-18983-1-git-send-email-lukasz.rymanowski@tieto.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Łukasz,

On Thursday 06 of March 2014 10:37:59 Lukasz Rymanowski wrote:
> ---
>  android/bluetoothd-wrapper.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/android/bluetoothd-wrapper.c b/android/bluetoothd-wrapper.c
> index 122e6b0..3a9f32e 100644
> --- a/android/bluetoothd-wrapper.c
> +++ b/android/bluetoothd-wrapper.c
> @@ -22,7 +22,7 @@
>  
>  #include <cutils/properties.h>
>  
> -#define PROPERTY_NAME "persist.sys.bluetooth.valgrind"
> +#define PROPERTY_VALGRIND_NAME "persist.sys.bluetooth.valgrind"
>  
>  #define VALGRIND_BIN "/system/bin/valgrind"
>  
> @@ -62,7 +62,7 @@ int main(int argc, char *argv[])
>  {
>  	char value[PROPERTY_VALUE_MAX];
>  
> -	if (property_get(PROPERTY_NAME, value, "") > 0 &&
> +	if (property_get(PROPERTY_VALGRIND_NAME, value, "") > 0 &&
>  			(!strcasecmp(value, "true") || atoi(value) > 0))
>  		run_valgrind();
>  
> 

All patches applied, thanks.

-- 
Best regards, 
Szymon Janc
