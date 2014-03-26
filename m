Return-Path: <cyrus@holtmann.org>
From: Szymon Janc <szymon.janc@tieto.com>
To: Grzegorz Kolodziejczyk <grzegorz.kolodziejczyk@tieto.com>
Cc: linux-bluetooth@vger.kernel.org
Subject: Re: [PATCH v2] android/gatt: Handle get characteristic client command
Date: Wed, 26 Mar 2014 13:42:58 +0100
Message-ID: <1670875.0VZkm9H515@uw000953>
In-Reply-To: <1395757590-19599-1-git-send-email-grzegorz.kolodziejczyk@tieto.com>
References: <1395757590-19599-1-git-send-email-grzegorz.kolodziejczyk@tieto.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Grzegorz,

On Tuesday 25 of March 2014 15:26:30 Grzegorz Kolodziejczyk wrote:
> This adds get characteristic client command handling. If characteristic
> id is given, then next characteristic after given is returned. In case of
> no initial characteristic, first characteristic in given service is
> returned. Characteristics are cached on first get characteristic command
> call for service.
> ---
>  android/gatt.c | 236 +++++++++++++++++++++++++++++++++++++++++++++++++++++++--
>  1 file changed, 230 insertions(+), 6 deletions(-)
> 
> diff --git a/android/gatt.c b/android/gatt.c
> index 0414c4f..d2eda9e 100644
> --- a/android/gatt.c
> +++ b/android/gatt.c
> @@ -53,6 +53,28 @@ struct gatt_client {
>  	uint8_t uuid[16];
>  };
>  
> +struct gatt_id {
> +	bt_uuid_t uuid;
> +	uint8_t inst_id;
> +};
> +
> +struct gatt_srvc_char {
> +	struct gatt_id id;
> +	struct gatt_char ch;
> +};
> +
> +struct gatt_srvc {
> +	struct gatt_id id;
> +	struct gatt_primary service;
> +
> +	struct queue *chars;
> +};
> +
> +struct generic_call_data {
> +	struct gatt_device *dev;
> +	struct gatt_srvc *gatt_srvc;
> +};
> +
>  struct gatt_device {
>  	bdaddr_t bdaddr;
>  	uint8_t bdaddr_type;
> @@ -66,6 +88,7 @@ struct gatt_device {
>  	GIOChannel *att_io;
>  	struct queue *services;
>  
> +	uint8_t char_inst_id;
>  	guint watch_id;
>  };
>  
> @@ -79,6 +102,14 @@ static struct queue *conn_wait_queue = NULL;	/* Devs waiting to connect */
>  
>  static void bt_le_discovery_stop_cb(void);
>  
> +static void free_gatt_service(void *data)
> +{
> +	struct gatt_srvc *srvc = data;
> +
> +	queue_destroy(srvc->chars, free);
> +	free(srvc);
> +}
> +
>  static bool match_client_by_uuid(const void *data, const void *user_data)
>  {
>  	const uint8_t *exp_uuid = user_data;
> @@ -123,12 +154,35 @@ static bool match_dev_by_conn_id(const void *data, const void *user_data)
>  	return dev->conn_id == conn_id;
>  }
>  
> +static bool match_srvc_by_gatt_id(const void *data, const void *user_data)
> +{
> +	const struct gatt_id *exp_id = user_data;
> +	const struct gatt_srvc *service = data;
> +	bt_uuid_t uuid;
> +
> +	bt_string_to_uuid(&uuid, service->service.uuid);
> +	if (service->id.inst_id == exp_id->inst_id)
> +		return !bt_uuid_cmp(&uuid, &exp_id->uuid);
> +
> +	return false;
> +}
> +
> +static bool match_char_by_higher_inst_id(const void *data,
> +							const void *user_data)
> +{
> +	const struct gatt_srvc_char *chars = data;
> +	uint8_t inst_id = PTR_TO_INT(user_data);
> +
> +	/* For now we match inst_id as it is unique, we'll match uuids later */
> +	return inst_id < chars->id.inst_id;
> +}
> +
>  static void destroy_device(void *data)
>  {
>  	struct gatt_device *dev = data;
>  
>  	queue_destroy(dev->clients, NULL);
> -	queue_destroy(dev->services, free);
> +	queue_destroy(dev->services, free_gatt_service);
>  	free(dev);
>  }
>  
> @@ -224,19 +278,26 @@ static void primary_cb(uint8_t status, GSList *services, void *user_data)
>  	for (l = services; l; l = l->next) {
>  		struct hal_ev_gatt_client_search_result ev_res;
>  		struct gatt_primary *prim = l->data;
> -		struct gatt_primary *p;
> +		struct gatt_srvc *p;
>  		bt_uuid_t uuid;
>  
> -		p = new0(struct gatt_primary, 1);
> +		p = new0(struct gatt_srvc, 1);
>  		if (!p) {
>  			error("gatt: Cannot allocate memory for gatt_primary");
>  			continue;
>  		}
>  
> +		p->chars = queue_new();
> +		if (!p->chars) {
> +			error("gatt: Cannot allocate memory for char cache");
> +			free(p);
> +			continue;
> +		}
> +
>  		memset(&ev_res, 0, sizeof(ev_res));
>  
>  		/* Put primary service to our local list */
> -		memcpy(p, prim, sizeof(*p));
> +		memcpy(&p->service, prim, sizeof(p->service));
>  		if (!queue_push_tail(dev->services, p)) {
>  			error("gatt: Cannot push primary service to the list");
>  			free(p);
> @@ -862,13 +923,176 @@ static void handle_client_get_included_service(const void *buf, uint16_t len)
>  					HAL_STATUS_FAILED);
>  }
>  
> +static void send_client_char_notify(const struct gatt_srvc_char *chars,
> +						struct generic_call_data *data,
> +						uint8_t status)
> +{
> +	struct hal_ev_gatt_client_get_characteristic ev;
> +	bt_uuid_t uuid;
> +
> +	memset(&ev, 0, sizeof(ev));
> +	ev.status = status;
> +
> +	if (chars) {
> +		ev.char_prop = chars->ch.properties;
> +		ev.char_id.inst_id = chars->id.inst_id;
> +		bt_string_to_uuid(&uuid, chars->ch.uuid);
> +		memcpy(&ev.char_id.uuid, &uuid.value.u128.data,
> +						sizeof(ev.char_id.uuid));
> +	}
> +
> +	ev.conn_id = data->dev->conn_id;
> +	/* TODO need to be handled for included services too */
> +	ev.srvc_id.is_primary = 1;
> +	ev.srvc_id.inst_id = data->gatt_srvc->id.inst_id;
> +	bt_string_to_uuid(&uuid, data->gatt_srvc->service.uuid);
> +	memcpy(&ev.srvc_id.uuid, &uuid.value.u128.data,
> +					sizeof(ev.srvc_id.uuid));
> +
> +	ipc_send_notif(hal_ipc, HAL_SERVICE_ID_GATT,
> +					HAL_EV_GATT_CLIENT_GET_CHARACTERISTIC,
> +					sizeof(ev), &ev);
> +}
> +
> +static void cache_all_srvc_chars(GSList *characteristics, struct queue *q)
> +{
> +	uint16_t inst_id = 0;
> +	bt_uuid_t uuid;
> +
> +	/* Refresh characteristics cache if already exist */
> +	if (!queue_isempty(q))
> +		queue_remove_all(q, NULL, NULL, free);
> +
> +	for (; characteristics; characteristics = characteristics->next) {
> +		struct gatt_srvc_char *chars;
> +
> +		chars = new0(struct gatt_srvc_char, 1);
> +		if (!chars) {
> +			error("gatt: Could not allocate characteristic");
> +			continue;
> +		}
> +
> +		memcpy(&chars->ch, characteristics->data, sizeof(chars->ch));
> +
> +		bt_string_to_uuid(&uuid, chars->ch.uuid);
> +		bt_uuid_to_uuid128(&chars->id.uuid, &uuid);
> +
> +		/* For now we increment inst_id and use it as characteristic
> +		 * handle
> +		 */
> +		chars->id.inst_id = ++inst_id;
> +
> +		if (!queue_push_tail(q, chars)) {
> +			error("gatt: Error while caching characteristic");
> +			free(chars);
> +		}
> +	}
> +}
> +
> +static void gatt_discover_char_cb(uint8_t status, GSList *characteristics,
> +								void *user_data)
> +{
> +	struct generic_call_data *call_data = user_data;
> +
> +	cache_all_srvc_chars(characteristics, call_data->gatt_srvc->chars);
> +
> +	if (!call_data)
> +		return;
> +
> +	if (!queue_isempty(call_data->gatt_srvc->chars))
> +		send_client_char_notify(queue_peek_head(
> +					call_data->gatt_srvc->chars),
> +					call_data, HAL_STATUS_SUCCESS);
> +	else
> +		send_client_char_notify(NULL, call_data, HAL_STATUS_FAILED);
> +
> +	free(call_data);
> +}
> +
> +static void hal_srvc_id_to_gatt_id(const struct hal_gatt_srvc_id *from,
> +							struct gatt_id *to)
> +{
> +	uint128_t uuid128;
> +
> +	to->inst_id = from->inst_id;
> +
> +	memcpy(&uuid128.data, &from->uuid, sizeof(uuid128));
> +	bt_uuid128_create(&to->uuid, uuid128);
> +}
> +
>  static void handle_client_get_characteristic(const void *buf, uint16_t len)
>  {
> +	const struct hal_cmd_gatt_client_get_characteristic *cmd = buf;
> +	struct generic_call_data *call_data;
> +	struct gatt_srvc_char *chars = NULL;
> +	struct gatt_id match_id;
> +	struct gatt_device *dev;
> +	struct gatt_srvc *srvc;
> +	uint8_t status;
> +
>  	DBG("");
>  
> +	if (len != sizeof(*cmd) + cmd->number*sizeof(cmd->gatt_id[0])) {
> +		error("Invalid hid set info size (%u bytes), terminating", len);
> +		raise(SIGTERM);
> +		return;
> +	}
> +
> +	dev = queue_find(conn_list, match_dev_by_conn_id,
> +						INT_TO_PTR(cmd->conn_id));
> +	if (!dev) {
> +		error("gatt: conn_id=%d not found", cmd->conn_id);
> +		status = HAL_STATUS_FAILED;
> +		goto done;
> +	}
> +
> +	hal_srvc_id_to_gatt_id(&cmd->srvc_id, &match_id);
> +	srvc = queue_find(dev->services, match_srvc_by_gatt_id, &match_id);
> +	if (!srvc) {
> +		error("gatt: Service with inst_id: %d not found",
> +							match_id.inst_id);
> +		status = HAL_STATUS_FAILED;
> +		goto done;
> +	}
> +
> +	call_data = new0(struct generic_call_data, 1);
> +	if (!call_data) {
> +		error("gatt: Cannot allocate call data");
> +		status = HAL_STATUS_FAILED;
> +		goto done;
> +	}
> +
> +	call_data->gatt_srvc = srvc;
> +	call_data->dev = dev;
> +
> +	/* Discover all characteristics for services if not cached yet */
> +	if (queue_isempty(srvc->chars)) {
> +		gatt_discover_char(dev->attrib, srvc->service.range.start,
> +					srvc->service.range.end, NULL,
> +					gatt_discover_char_cb, call_data);
> +
> +		status = HAL_STATUS_SUCCESS;
> +		goto done;
> +	}
> +
> +	if (cmd->number)
> +		chars = queue_find(srvc->chars, match_char_by_higher_inst_id,
> +					INT_TO_PTR(cmd->gatt_id[0].inst_id));
> +	else
> +		chars = queue_peek_head(srvc->chars);
> +
> +	if (chars)
> +		send_client_char_notify(chars, call_data, HAL_STATUS_SUCCESS);
> +	else
> +		send_client_char_notify(NULL, call_data, HAL_STATUS_FAILED);
> +
> +	free(call_data);
> +
> +	status = HAL_STATUS_SUCCESS;
> +
> +done:
>  	ipc_send_rsp(hal_ipc, HAL_SERVICE_ID_GATT,
> -					HAL_OP_GATT_CLIENT_GET_CHARACTERISTIC,
> -					HAL_STATUS_FAILED);
> +				HAL_OP_GATT_CLIENT_GET_CHARACTERISTIC, status);
>  }
>  
>  static void handle_client_get_descriptor(const void *buf, uint16_t len)
> 

A heavily modified version of this patch is now pushed. For future please try
avoiding such big single commits as those are quite hard to review. Thanks.

-- 
Best regards, 
Szymon Janc
