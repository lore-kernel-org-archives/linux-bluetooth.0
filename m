Return-Path: <cyrus@holtmann.org>
From: Szymon Janc <szymon.janc@tieto.com>
To: Lukasz Rymanowski <lukasz.rymanowski@tieto.com>
Cc: linux-bluetooth@vger.kernel.org, luiz.dentz@gmail.com
Subject: Re: [PATCH v2 01/16] android/hf-client: Add hf-client ID
Date: Thu, 11 Sep 2014 13:43:53 +0200
Message-ID: <5855798.7j4VXT9nGs@uw000953>
In-Reply-To: <1410348854-26249-2-git-send-email-lukasz.rymanowski@tieto.com>
References: <1410348854-26249-1-git-send-email-lukasz.rymanowski@tieto.com> <1410348854-26249-2-git-send-email-lukasz.rymanowski@tieto.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Łukasz,

On Wednesday 10 of September 2014 13:33:59 Lukasz Rymanowski wrote:
> ---
>  android/hal-msg.h | 3 ++-
>  1 file changed, 2 insertions(+), 1 deletion(-)
> 
> diff --git a/android/hal-msg.h b/android/hal-msg.h
> index 3d95e10..5781c09 100644
> --- a/android/hal-msg.h
> +++ b/android/hal-msg.h
> @@ -35,8 +35,9 @@ static const char BLUEZ_HAL_SK_PATH[] = "\0bluez_hal_socket";
>  #define HAL_SERVICE_ID_HEALTH		7
>  #define HAL_SERVICE_ID_AVRCP		8
>  #define HAL_SERVICE_ID_GATT		9
> +#define HAL_SERVICE_ID_HF_CLIENT	10

To follow convention this should be named HAL_SERVICE_ID_HANDSFREE_CLIENT.

>  
> -#define HAL_SERVICE_ID_MAX HAL_SERVICE_ID_GATT
> +#define HAL_SERVICE_ID_MAX HAL_SERVICE_ID_HF_CLIENT
>  
>  /* Core Service */
>  
> 

-- 
Best regards, 
Szymon Janc
