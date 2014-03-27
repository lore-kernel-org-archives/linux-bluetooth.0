Return-Path: <cyrus@holtmann.org>
From: Szymon Janc <szymon.janc@gmail.com>
To: Marcin Kraglak <marcin.kraglak@tieto.com>
Cc: linux-bluetooth@vger.kernel.org
Subject: Re: [PATCHv2 08/11] android/gatt: Add initial implementation of register_for_notification
Date: Thu, 27 Mar 2014 23:20:39 +0100
Message-ID: <1419037.jsmEW2LMJS@athlon>
In-Reply-To: <1395954789-32459-8-git-send-email-marcin.kraglak@tieto.com>
References: <1395954789-32459-1-git-send-email-marcin.kraglak@tieto.com> <1395954789-32459-8-git-send-email-marcin.kraglak@tieto.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

On Thursday 27 March 2014 22:13:06 Marcin Kraglak wrote:
> It will register notification and indication handler for given parameters.
> Proper callback should be send with status of registration.
> ---
>  android/gatt.c | 159
> ++++++++++++++++++++++++++++++++++++++++++++++++++++++++- 1 file changed,
> 157 insertions(+), 2 deletions(-)
> 
> diff --git a/android/gatt.c b/android/gatt.c
> index 2cd0731..0a7bca0 100644
> --- a/android/gatt.c
> +++ b/android/gatt.c
> @@ -215,6 +215,54 @@ static bool match_char_by_higher_inst_id(const void
> *data, return inst_id < ch->id.instance;
>  }
> 
> +static bool match_char_by_instance(const void *data, const void *user_data)
> +{
> +	const struct characteristic *ch = data;
> +	uint8_t inst_id = PTR_TO_INT(user_data);
> +
> +	return inst_id == ch->id.instance;
> +}
> +
> +static bool match_notification(const void *a, const void *b)
> +{
> +	const struct notification_data *a1 = a;
> +	const struct notification_data *b1 = b;
> +
> +	if (bacmp(&a1->dev->bdaddr, &b1->dev->bdaddr))
> +		return false;
> +	if (memcmp(&a1->ch, &b1->ch, sizeof(a1->ch)))
> +		return false;
> +	if (memcmp(&a1->service, &b1->service, sizeof(a1->service)))
> +		return false;
> +
> +	return true;
> +}
> +
> +static void destroy_notification(void *data)
> +{
> +	struct notification_data *notification = data;
> +
> +	if (--notification->ref)
> +		return;
> +
> +	queue_remove_if(notification->client->notifications, match_notification,
> +								notification);
> +	free(notification);
> +}
> +
> +static void unregister_notification(void *data)
> +{
> +	struct notification_data *notification = data;
> +
> +	if (notification->notif_id)
> +		g_attrib_unregister(notification->dev->attrib,
> +							notification->notif_id);
> +
> +	if (notification->ind_id)
> +		g_attrib_unregister(notification->dev->attrib,
> +							notification->ind_id);
> +}
> +
>  static void destroy_device(void *data)
>  {
>  	struct gatt_device *dev = data;
> @@ -231,8 +279,16 @@ static void destroy_gatt_client(void *data)
>  {
>  	struct gatt_client *client = data;
> 
> -	if (client->notifications)
> +	if (client->notifications) {
> +		while (queue_peek_head(client->notifications)) {
> +			struct notification_data *notification;
> +
> +			notification = queue_pop_head(client->notifications);
> +			unregister_notification(notification);
> +		}
> +
>  		queue_destroy(client->notifications, free);
> +	}
> 
>  	free(client);
>  }
> @@ -1350,11 +1406,110 @@ static void handle_client_execute_write(const void
> *buf, uint16_t len) static void
> handle_client_register_for_notification(const void *buf, uint16_t len)
>  {
> +	const struct hal_cmd_gatt_client_register_for_notification *cmd = buf;
> +	struct notification_data *notification;
> +	char uuid[MAX_LEN_UUID_STR];
> +	struct gatt_client *client;
> +	struct characteristic *c;
> +	struct element_id match_id;
> +	struct gatt_device *dev;
> +	struct service *service;
> +	char addr_str[18];
> +	uint8_t status;
> +	bdaddr_t addr;
> +
>  	DBG("");
> 
> +	client = find_client_by_id(cmd->client_if);
> +	if (!client) {
> +		error("gatt: client %d not registered", cmd->client_if);
> +		status = HAL_STATUS_FAILED;
> +		goto failed;
> +	}
> +
> +	android2bdaddr((bdaddr_t *)&cmd->bdaddr, &addr);
> +	ba2str(&addr, addr_str);
> +
> +	dev = queue_find(conn_list, match_dev_by_bdaddr, &addr);
> +	if (!dev) {
> +		error("gatt: device %s not found in connected devices list",
> +								addr_str);
> +		status = HAL_STATUS_FAILED;
> +		goto failed;
> +	}
> +
> +	hal_srvc_id_to_element_id(&cmd->srvc_id, &match_id);
> +	service = queue_find(dev->services, match_srvc_by_element_id,
> +								&match_id);
> +	bt_uuid_to_string(&match_id.uuid, uuid, MAX_LEN_UUID_STR);
> +	if (!service) {
> +		error("gatt: can't register notification, service not found");
> +		status = HAL_STATUS_FAILED;
> +		goto failed;
> +	}
> +
> +	c = queue_find(service->chars, match_char_by_instance,
> +					INT_TO_PTR(cmd->char_id.inst_id));
> +	if (!c) {
> +		error("gatt: can't register notification: no characteristic");
> +		status = HAL_STATUS_FAILED;
> +		goto failed;
> +	}
> +
> +	notification = new0(struct notification_data, 1);
> +	if (!notification) {
> +		error("gatt: failed to allocate memory for notification");
> +		status = HAL_STATUS_FAILED;
> +		goto failed;
> +	}
> +
> +	memcpy(&notification->ch, &cmd->char_id, sizeof(notification->ch));
> +	memcpy(&notification->service, &cmd->srvc_id,
> +						sizeof(notification->service));
> +	notification->dev = dev;
> +	notification->client = client;
> +
> +	if (queue_find(client->notifications, match_notification,
> +			notification)) {
> +		DBG("can't register for notification, already registered");
> +		free(notification);
> +		status = HAL_STATUS_SUCCESS;
> +		goto failed;
> +	}
> +
> +	notification->notif_id = g_attrib_register(dev->attrib,
> +							ATT_OP_HANDLE_NOTIFY,
> +							c->ch.value_handle,
> +							NULL, notification,
> +							destroy_notification);
> +	if (!notification->notif_id) {
> +		free(notification);
> +		status = HAL_STATUS_FAILED;
> +		goto failed;
> +	}
> +
> +	notification->ind_id = g_attrib_register(dev->attrib, ATT_OP_HANDLE_IND,
> +							c->ch.value_handle,
> +							NULL, notification,
> +							destroy_notification);
> +	if (!notification->ind_id) {
> +		g_attrib_unregister(dev->attrib, notification->notif_id);
> +		free(notification);
> +		status = HAL_STATUS_FAILED;
> +		goto failed;
> +	}
> +
> +	notification->ref = 2;

As we discussed before, that needs comment why it is done this way.

> +
> +	queue_push_tail(client->notifications, notification);

This may fail.

> +
> +	status = HAL_STATUS_SUCCESS;
> +
> +failed:
> +	/* TODO: send callback with notification enabled/disabled */
>  	ipc_send_rsp(hal_ipc, HAL_SERVICE_ID_GATT,
>  				HAL_OP_GATT_CLIENT_REGISTER_FOR_NOTIFICATION,
> -				HAL_STATUS_FAILED);
> +				status);
>  }
> 
>  static void handle_client_deregister_for_notification(const void *buf,

-- 
Szymon K. Janc
szymon.janc@gmail.com
