Return-Path: <cyrus@holtmann.org>
From: Szymon Janc <szymon.janc@tieto.com>
To: Grzegorz Kolodziejczyk <grzegorz.kolodziejczyk@tieto.com>
Cc: linux-bluetooth@vger.kernel.org
Subject: Re: [PATCH] android/gatt: Fix sending notification for register gatt client
Date: Mon, 07 Apr 2014 11:17:20 +0200
Message-ID: <15525889.u89ISmxBm2@uw000953>
In-Reply-To: <1396622758-24846-1-git-send-email-grzegorz.kolodziejczyk@tieto.com>
References: <1396622758-24846-1-git-send-email-grzegorz.kolodziejczyk@tieto.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Grzegorz,

On Friday 04 of April 2014 16:45:58 Grzegorz Kolodziejczyk wrote:
> This patch adds missing send notification in case of errors for gatt
> client registration. In case of error status GATT_FAILURE with given in
> cmd UUID is send in notification.
> ---
>  android/gatt.c | 34 ++++++++++++++++++++++++----------
>  1 file changed, 24 insertions(+), 10 deletions(-)
> 
> diff --git a/android/gatt.c b/android/gatt.c
> index 4f0a656..372acec 100644
> --- a/android/gatt.c
> +++ b/android/gatt.c
> @@ -413,6 +413,8 @@ static void handle_client_register(const void *buf, uint16_t len)
>  
>  	DBG("");
>  
> +	memset(&ev, 0, sizeof(ev));
> +
>  	if (queue_find(gatt_clients, match_client_by_uuid, &cmd->uuid)) {
>  		error("gatt: client uuid is already on list");
>  		status = HAL_STATUS_FAILED;
> @@ -422,12 +424,10 @@ static void handle_client_register(const void *buf, uint16_t len)
>  	client = new0(struct gatt_client, 1);
>  	if (!client) {
>  		error("gatt: cannot allocate memory for registering client");
> -		status = HAL_STATUS_FAILED;
> +		status = HAL_STATUS_NOMEM;
>  		goto failed;
>  	}
>  
> -	memcpy(client->uuid, cmd->uuid, sizeof(client->uuid));
> -
>  	client->notifications = queue_new();
>  	if (!client->notifications) {
>  		error("gatt: couldn't allocate notifications queue");
> @@ -436,22 +436,36 @@ static void handle_client_register(const void *buf, uint16_t len)
>  		goto failed;
>  	}
>  
> -	client->id = client_cnt++;
> +	memcpy(client->uuid, cmd->uuid, sizeof(client->uuid));
>  
> -	queue_push_head(gatt_clients, client);
> +	client->id = client_cnt++;
>  
> -	status = HAL_STATUS_SUCCESS;
> +	if (!queue_push_head(gatt_clients, client)) {
> +		error("gatt: Cannot push client on the list");
> +		free(client);

This will leak notifications. Use destroy_gatt_client() here.

> +		status = HAL_STATUS_FAILED;
> +		goto failed;
> +	}
>  
>  	ev.status = GATT_SUCCESS;
>  	ev.client_if = client->id;
> -	memcpy(ev.app_uuid, client->uuid, sizeof(client->uuid));
> +
> +	status = HAL_STATUS_SUCCESS;
> +
> +failed:
> +	if (status != HAL_STATUS_SUCCESS)
> +		ev.status = GATT_FAILURE;
> +
> +	/* We should send notification with given in cmd UUID
> +	 * in case of errors
> +	 */
> +	memcpy(ev.app_uuid, cmd->uuid, sizeof(ev.app_uuid));

This is send also for success scenario, so comment is bogus.
Reword it ie. remove part about errors.

>  
>  	ipc_send_notif(hal_ipc, HAL_SERVICE_ID_GATT,
>  			HAL_EV_GATT_CLIENT_REGISTER_CLIENT, sizeof(ev), &ev);
>  
> -failed:
> -	ipc_send_rsp(hal_ipc, HAL_SERVICE_ID_GATT,
> -					HAL_OP_GATT_CLIENT_REGISTER, status);
> +	ipc_send_rsp(hal_ipc, HAL_SERVICE_ID_GATT, HAL_OP_GATT_CLIENT_REGISTER,
> +									status);
>  }
>  
>  static void handle_client_unregister(const void *buf, uint16_t len)
> 

-- 
Best regards, 
Szymon Janc
