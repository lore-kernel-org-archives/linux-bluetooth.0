Return-Path: <cyrus@holtmann.org>
From: Szymon Janc <szymon.janc@tieto.com>
To: Grzegorz Kolodziejczyk <grzegorz.kolodziejczyk@tieto.com>
Cc: linux-bluetooth@vger.kernel.org
Subject: Re: [PATCH] android/gatt: Remove redundant gatt_status variable set
Date: Tue, 13 May 2014 18:54:44 +0200
Message-ID: <6338159.189E78TCoT@uw000953>
In-Reply-To: <1399380495-27102-1-git-send-email-grzegorz.kolodziejczyk@tieto.com>
References: <1399380495-27102-1-git-send-email-grzegorz.kolodziejczyk@tieto.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Grzegorz,

On Tuesday 06 of May 2014 14:48:15 Grzegorz Kolodziejczyk wrote:
> This patch changes and unifies redundant variable gatt_status to
> conditional operators.
> ---
>  android/gatt.c | 32 +++++++++++++-------------------
>  1 file changed, 13 insertions(+), 19 deletions(-)
> 
> diff --git a/android/gatt.c b/android/gatt.c
> index 9e17b35..5300e21 100644
> --- a/android/gatt.c
> +++ b/android/gatt.c
> @@ -1502,11 +1502,9 @@ reply:
>  							status);
>  
>  	/* In case of early success or error, just send notification up */
> -	if (!req_sent) {
> -		int32_t gatt_status = status == HAL_STATUS_SUCCESS ?
> -						GATT_SUCCESS : GATT_FAILURE;
> -		send_client_listen_notify(cmd->client_if, gatt_status);
> -	}
> +	if (!req_sent)
> +		send_client_listen_notify(cmd->client_if, status ?
> +						GATT_FAILURE : GATT_SUCCESS);
>  }
>  
>  static void handle_client_refresh(const void *buf, uint16_t len)
> @@ -2401,10 +2399,9 @@ failed:
>  	 */
>  	if (status != HAL_STATUS_SUCCESS ||
>  			cmd->write_type == GATT_WRITE_TYPE_NO_RESPONSE) {
> -		int32_t gatt_status = (status == HAL_STATUS_SUCCESS) ?
> -						GATT_SUCCESS : GATT_FAILURE;
>  
> -		send_client_write_char_notify(gatt_status, cmd->conn_id,
> +		send_client_write_char_notify(status ? GATT_FAILURE :
> +						GATT_SUCCESS, cmd->conn_id,
>  						&srvc_id, &char_id,
>  						cmd->srvc_id.is_primary);
>  		free(cb_data);
> @@ -2708,10 +2705,9 @@ static void handle_client_write_descriptor(const void *buf, uint16_t len)
>  failed:
>  	if (status != HAL_STATUS_SUCCESS ||
>  			cmd->write_type == GATT_WRITE_TYPE_NO_RESPONSE) {
> -		int32_t gatt_status = (status == HAL_STATUS_SUCCESS) ?
> -						GATT_SUCCESS : GATT_FAILURE;
>  
> -		send_client_descr_write_notify(gatt_status, conn_id, &srvc_id,
> +		send_client_descr_write_notify(status ? GATT_FAILURE :
> +						GATT_SUCCESS, conn_id, &srvc_id,
>  						&char_id, &descr_id, primary);
>  		free(cb_data);
>  	}
> @@ -2840,7 +2836,6 @@ static void handle_client_register_for_notification(const void *buf,
>  	int32_t conn_id = 0;
>  	struct service *service;
>  	uint8_t status;
> -	int32_t gatt_status;
>  	bdaddr_t addr;
>  
>  	DBG("");
> @@ -2930,9 +2925,9 @@ static void handle_client_register_for_notification(const void *buf,
>  	status = HAL_STATUS_SUCCESS;
>  
>  failed:
> -	gatt_status = status ? GATT_FAILURE : GATT_SUCCESS;
> -	send_register_for_notification_ev(conn_id, 1, gatt_status,
> -						&cmd->srvc_id, &cmd->char_id);
> +	send_register_for_notification_ev(conn_id, 1, status ? GATT_FAILURE :
> +						GATT_SUCCESS, &cmd->srvc_id,
> +						&cmd->char_id);

I find original code a bit easier to read so I'd just leave this as is.

>  	ipc_send_rsp(hal_ipc, HAL_SERVICE_ID_GATT,
>  			HAL_OP_GATT_CLIENT_REGISTER_FOR_NOTIFICATION, status);
>  }
> @@ -2945,7 +2940,6 @@ static void handle_client_deregister_for_notification(const void *buf,
>  	struct app_connection *conn;
>  	int32_t conn_id = 0;
>  	uint8_t status;
> -	int32_t gatt_status;
>  	bdaddr_t addr;
>  
>  	DBG("");
> @@ -2976,9 +2970,9 @@ static void handle_client_deregister_for_notification(const void *buf,
>  	status = HAL_STATUS_SUCCESS;
>  
>  failed:
> -	gatt_status = status ? GATT_FAILURE : GATT_SUCCESS;
> -	send_register_for_notification_ev(conn_id, 0, gatt_status,
> -						&cmd->srvc_id, &cmd->char_id);
> +	send_register_for_notification_ev(conn_id, 0, status ? GATT_FAILURE :
> +						GATT_SUCCESS, &cmd->srvc_id,
> +						&cmd->char_id);
>  
>  	ipc_send_rsp(hal_ipc, HAL_SERVICE_ID_GATT,
>  			HAL_OP_GATT_CLIENT_DEREGISTER_FOR_NOTIFICATION, status);
> 

-- 
Best regards, 
Szymon Janc
