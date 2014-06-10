Return-Path: <cyrus@holtmann.org>
From: Szymon Janc <szymon.janc@tieto.com>
To: linux-bluetooth@vger.kernel.org
Subject: Re: [PATCH] android/README: Update information about GATT HAL support
Date: Tue, 10 Jun 2014 15:02:08 +0200
Message-ID: <1491984.URZc1pCphU@uw000953>
In-Reply-To: <1402392729-29775-1-git-send-email-szymon.janc@tieto.com>
References: <1402392729-29775-1-git-send-email-szymon.janc@tieto.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

On Tuesday 10 of June 2014 11:32:09 Szymon Janc wrote:
> ---
>  android/README | 15 ++++++++++++---
>  1 file changed, 12 insertions(+), 3 deletions(-)
> 
> diff --git a/android/README b/android/README
> index 91fc545..435cf56 100644
> --- a/android/README
> +++ b/android/README
> @@ -222,9 +222,9 @@ Profile ID    HAL header         Status
>  ---------------------------------------
>  core          bluetooth.h        complete
>  a2dp          bt_av.h            complete
> -gatt          bt_gatt.h          partial
> -              bt_gatt_client.h   partial
> -              bt_gatt_server.h   initial
> +gatt          bt_gatt.h          complete
> +              bt_gatt_client.h   complete
> +              bt_gatt_server.h   complete
>  handsfree     bt_hf.h            complete
>  hidhost       bt_hh.h            complete
>  health        bt_hl.h            initial
> @@ -293,6 +293,14 @@ get_player_app_values_text_cb      NULL JNI implementation
>  set_player_app_value_cb            NULL JNI implementation
>  
>  
> +HAL GATT
> +--------
> +
> +methods:
> +client->set_adv_data               missing kernel support for vendor data
> +client->connect                    is_direct parameter is ignored
> +
> +
>  Known Android issues
>  ====================
>  
> @@ -324,3 +332,4 @@ HFP		Response and Hold		AT+BTRH, +BTRH
>  HFP		In-band Ring Tone		+BSIR
>  AVRCP		Player Settings			HAL API present but not used
>  AVRCP		Browsing			No HAL API
> +GATT		Read multiple characteristics	No HAL API
> 

Applied.

-- 
Best regards, 
Szymon Janc
