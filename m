Return-Path: <cyrus@holtmann.org>
From: Szymon Janc <szymon.janc@tieto.com>
To: Grzegorz Kolodziejczyk <grzegorz.kolodziejczyk@tieto.com>
Cc: linux-bluetooth@vger.kernel.org
Subject: Re: [PATCH 1/2] android/gatt: Handle register gatt server command
Date: Tue, 01 Apr 2014 13:54:34 +0200
Message-ID: <1659645.FUfLQENYST@uw000953>
In-Reply-To: <1396347239-944-1-git-send-email-grzegorz.kolodziejczyk@tieto.com>
References: <1396347239-944-1-git-send-email-grzegorz.kolodziejczyk@tieto.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Grzegorz,

On Tuesday 01 of April 2014 12:13:58 Grzegorz Kolodziejczyk wrote:
> This adds register gatt server command handling.
> ---
>  android/gatt.c | 74 +++++++++++++++++++++++++++++++++++++++++++++++++++++++++-
>  1 file changed, 73 insertions(+), 1 deletion(-)
> 
> diff --git a/android/gatt.c b/android/gatt.c
> index 61746b1..5ca3fe7 100644
> --- a/android/gatt.c
> +++ b/android/gatt.c
> @@ -57,6 +57,11 @@ struct gatt_client {
>  	struct queue *notifications;
>  };
>  
> +struct gatt_server {
> +	int32_t id;
> +	uint8_t uuid[16];
> +};
> +
>  struct element_id {
>  	bt_uuid_t uuid;
>  	uint8_t instance;
> @@ -105,6 +110,7 @@ static bdaddr_t adapter_addr;
>  static bool scanning = false;
>  
>  static struct queue *gatt_clients = NULL;
> +static struct queue *gatt_servers = NULL;
>  static struct queue *conn_list	= NULL;		/* Connected devices */
>  static struct queue *conn_wait_queue = NULL;	/* Devs waiting to connect */
>  
> @@ -154,6 +160,14 @@ static bool match_client_by_uuid(const void *data, const void *user_data)
>  	return !memcmp(exp_uuid, client->uuid, sizeof(client->uuid));
>  }
>  
> +static bool match_server_by_uuid(const void *data, const void *user_data)
> +{
> +	const uint8_t *exp_uuid = user_data;
> +	const struct gatt_server *server = data;
> +
> +	return !memcmp(exp_uuid, server->uuid, sizeof(server->uuid));
> +}
> +
>  static bool match_client_by_id(const void *data, const void *user_data)
>  {
>  	int32_t exp_id = PTR_TO_INT(user_data);
> @@ -1883,10 +1897,61 @@ static void handle_client_test_command(const void *buf, uint16_t len)
>  
>  static void handle_server_register(const void *buf, uint16_t len)
>  {
> +	const struct hal_cmd_gatt_server_register *cmd = buf;
> +	struct hal_ev_gatt_server_register ev;
> +	struct gatt_server *server;
> +	static int32_t server_cnt = 1;
> +	uint32_t status;
> +
>  	DBG("");
>  
> +	memset(&ev, 0, sizeof(ev));
> +
> +	if (!cmd->uuid) {
> +		error("gatt: No uuid received");
> +		status = GATT_FAILURE;
> +		goto failed;
> +	}

This is not needed.

> +
> +	if (queue_find(gatt_servers, match_server_by_uuid, &cmd->uuid)) {
> +		error("gatt: Server uuid is already on list");
> +		status = HAL_STATUS_FAILED;
> +		goto failed;
> +	}
> +
> +	server = new0(struct gatt_server, 1);
> +	if (!server) {
> +		error("gatt: Cannot allocate memory for registering server");
> +		status = HAL_STATUS_NOMEM;
> +		goto failed;
> +	}
> +
> +	memcpy(server->uuid, cmd->uuid, sizeof(server->uuid));
> +
> +	server->id = server_cnt++;
> +
> +	if (!queue_push_head(gatt_servers, server)) {
> +		error("gatt: Cannot push server on the list");
> +		free(server);
> +		status = HAL_STATUS_FAILED;
> +		goto failed;
> +	}
> +
> +	ev.status = GATT_SUCCESS;
> +	ev.server_if = server->id;
> +	memcpy(ev.uuid, server->uuid, sizeof(server->uuid));
> +
> +	status = HAL_STATUS_SUCCESS;
> +
> +failed:
> +	if (status != HAL_STATUS_SUCCESS)
> +		ev.status = GATT_FAILURE;
> +
> +	ipc_send_notif(hal_ipc, HAL_SERVICE_ID_GATT,
> +				HAL_EV_GATT_SERVER_REGISTER, sizeof(ev), &ev);
> +
>  	ipc_send_rsp(hal_ipc, HAL_SERVICE_ID_GATT, HAL_OP_GATT_SERVER_REGISTER,
> -							HAL_STATUS_FAILED);
> +									status);
>  }
>  
>  static void handle_server_unregister(const void *buf, uint16_t len)
> @@ -2123,6 +2188,12 @@ bool bt_gatt_register(struct ipc *ipc, const bdaddr_t *addr)
>  		return false;
>  	}
>  
> +	gatt_servers = queue_new();
> +	if (!gatt_servers) {
> +		error("gatt: Cannot allocate gatt_servers");
> +		return false;
> +	}
> +
>  	return true;
>  }
>  
> @@ -2131,6 +2202,7 @@ void bt_gatt_unregister(void)
>  	DBG("");
>  
>  	queue_destroy(gatt_clients, free);
> +	queue_destroy(gatt_servers, free);
>  
>  	ipc_unregister(hal_ipc, HAL_SERVICE_ID_GATT);
>  	hal_ipc = NULL;
> 

-- 
Best regards, 
Szymon Janc
