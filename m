Return-Path: <cyrus@holtmann.org>
From: Szymon Janc <szymon.janc@tieto.com>
To: Jakub Tyszkowski <jakub.tyszkowski@tieto.com>
Cc: linux-bluetooth@vger.kernel.org
Subject: Re: [PATCH 1/2] android/gatt: Set proper primary flag for sending characteristics
Date: Fri, 11 Apr 2014 16:17:30 +0200
Message-ID: <1619050.hvZinmgAR9@uw000953>
In-Reply-To: <1397220026-27177-1-git-send-email-jakub.tyszkowski@tieto.com>
References: <1397220026-27177-1-git-send-email-jakub.tyszkowski@tieto.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Jakub,

On Friday 11 of April 2014 14:40:25 Jakub Tyszkowski wrote:
> Fix sending included service's characteristics.
> ---
>  android/gatt.c | 3 +--
>  1 file changed, 1 insertion(+), 2 deletions(-)
> 
> diff --git a/android/gatt.c b/android/gatt.c
> index aa2a5fd..13ae340 100644
> --- a/android/gatt.c
> +++ b/android/gatt.c
> @@ -1510,8 +1510,7 @@ static void send_client_char_notify(const struct characteristic *ch,
>  	}
>  
>  	ev.conn_id = conn_id;
> -	/* TODO need to be handled for included services too */
> -	element_id_to_hal_srvc_id(&service->id, 1, &ev.srvc_id);
> +	element_id_to_hal_srvc_id(&service->id, service->primary, &ev.srvc_id);
>  
>  	ipc_send_notif(hal_ipc, HAL_SERVICE_ID_GATT,
>  					HAL_EV_GATT_CLIENT_GET_CHARACTERISTIC,
> 

Both patches applied, thanks.

-- 
Best regards, 
Szymon Janc
