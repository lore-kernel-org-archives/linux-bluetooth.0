Return-Path: <cyrus@holtmann.org>
From: Szymon Janc <szymon.janc@tieto.com>
To: Andrei Emeltchenko <Andrei.Emeltchenko.news@gmail.com>
Cc: linux-bluetooth@vger.kernel.org
Subject: Re: [PATCH] android/hal: Fix last service id number
Date: Wed, 12 Nov 2014 09:48:35 +0100
Message-ID: <2168188.VBOHE1YtLx@uw000953>
In-Reply-To: <1415780526-20367-1-git-send-email-Andrei.Emeltchenko.news@gmail.com>
References: <1415780526-20367-1-git-send-email-Andrei.Emeltchenko.news@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Andrei,

On Wednesday 12 of November 2014 10:22:06 Andrei Emeltchenko wrote:
> From: Andrei Emeltchenko <andrei.emeltchenko@intel.com>
> 
> ---
>  android/hal-msg.h | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/android/hal-msg.h b/android/hal-msg.h
> index eedd37b..773af5b 100644
> --- a/android/hal-msg.h
> +++ b/android/hal-msg.h
> @@ -39,7 +39,7 @@ static const char BLUEZ_HAL_SK_PATH[] = "\0bluez_hal_socket";
>  #define HAL_SERVICE_ID_MAP_CLIENT	11
>  #define HAL_SERVICE_ID_AVRCP_CTRL	12
>  
> -#define HAL_SERVICE_ID_MAX HAL_SERVICE_ID_MAP_CLIENT
> +#define HAL_SERVICE_ID_MAX HAL_SERVICE_ID_AVRCP_CTRL
>  
>  /* Core Service */
>  

Pushed, thanks. 

-- 
Best regards, 
Szymon Janc
