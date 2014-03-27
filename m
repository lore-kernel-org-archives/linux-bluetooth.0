Return-Path: <cyrus@holtmann.org>
From: Szymon Janc <szymon.janc@tieto.com>
To: Grzegorz Kolodziejczyk <grzegorz.kolodziejczyk@tieto.com>
Cc: linux-bluetooth@vger.kernel.org
Subject: Re: [PATCH] android/gatt: Fix incorrect usage of bt_uuid_to_uuid128
Date: Thu, 27 Mar 2014 15:51:16 +0100
Message-ID: <2742319.EvBRQBAv4r@uw000953>
In-Reply-To: <1395850086-26154-1-git-send-email-grzegorz.kolodziejczyk@tieto.com>
References: <1395850086-26154-1-git-send-email-grzegorz.kolodziejczyk@tieto.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Grzegorz,

On Wednesday 26 of March 2014 17:08:06 Grzegorz Kolodziejczyk wrote:
> ---
>  android/gatt.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/android/gatt.c b/android/gatt.c
> index 6354ac6..04e9729 100644
> --- a/android/gatt.c
> +++ b/android/gatt.c
> @@ -970,7 +970,7 @@ static void cache_all_srvc_chars(GSList *characteristics, struct queue *q)
>  		memcpy(&ch->ch, characteristics->data, sizeof(ch->ch));
>  
>  		bt_string_to_uuid(&uuid, ch->ch.uuid);
> -		bt_uuid_to_uuid128(&ch->id.uuid, &uuid);
> +		bt_uuid_to_uuid128(&uuid, &ch->id.uuid);
>  
>  		/* For now we increment inst_id and use it as characteristic
>  		 * handle
> 

Applied, thanks.

-- 
Best regards, 
Szymon Janc
