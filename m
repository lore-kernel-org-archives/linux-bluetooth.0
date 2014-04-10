Return-Path: <cyrus@holtmann.org>
From: Szymon Janc <szymon.janc@tieto.com>
To: Marcin Kraglak <marcin.kraglak@tieto.com>
Cc: linux-bluetooth@vger.kernel.org
Subject: Re: [PATCH] android/gatt: Fix incorrect event status
Date: Thu, 10 Apr 2014 10:54:34 +0200
Message-ID: <11455563.3Ct9QDaxCl@uw000953>
In-Reply-To: <1397111398-18137-1-git-send-email-marcin.kraglak@tieto.com>
References: <1397111398-18137-1-git-send-email-marcin.kraglak@tieto.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Marcin,

On Thursday 10 of April 2014 08:29:58 Marcin Kraglak wrote:
> Return proper gatt_status in register_for_notification event.
> ---
>  android/gatt.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/android/gatt.c b/android/gatt.c
> index 15e788a..971e2dd 100644
> --- a/android/gatt.c
> +++ b/android/gatt.c
> @@ -2482,7 +2482,7 @@ static void handle_client_register_for_notification(const void *buf,
>  	status = HAL_STATUS_SUCCESS;
>  
>  failed:
> -	gatt_status  = status ? GATT_SUCCESS : GATT_FAILURE;
> +	gatt_status = status ? GATT_FAILURE : GATT_SUCCESS;
>  	send_register_for_notification_ev(conn_id, 1, gatt_status,
>  						&cmd->srvc_id, &cmd->char_id);
>  	ipc_send_rsp(hal_ipc, HAL_SERVICE_ID_GATT,
> @@ -2535,7 +2535,7 @@ static void handle_client_deregister_for_notification(const void *buf,
>  	status = HAL_STATUS_SUCCESS;
>  
>  failed:
> -	gatt_status  = status ? GATT_SUCCESS : GATT_FAILURE;
> +	gatt_status = status ? GATT_FAILURE : GATT_SUCCESS;
>  	send_register_for_notification_ev(conn_id, 0, gatt_status,
>  						&cmd->srvc_id, &cmd->char_id);
>  
> 

Patch applied. Thanks.

-- 
Best regards, 
Szymon Janc
