Return-Path: <cyrus@holtmann.org>
From: Szymon Janc <szymon.janc@tieto.com>
To: Marcin Kraglak <marcin.kraglak@tieto.com>
Cc: linux-bluetooth@vger.kernel.org
Subject: Re: [PATCH 4/8] shared/gatt: Make read by type use response queue
Date: Tue, 13 May 2014 15:35:45 +0200
Message-ID: <2586320.MCuHY6ysTE@uw000953>
In-Reply-To: <1399899758-4944-5-git-send-email-marcin.kraglak@tieto.com>
References: <1399899758-4944-1-git-send-email-marcin.kraglak@tieto.com> <1399899758-4944-5-git-send-email-marcin.kraglak@tieto.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi,

On Monday 12 of May 2014 15:02:34 Marcin Kraglak wrote:
> This makes read by type use response queue as plain read do.
> ---
>  android/gatt.c       | 99 ++++++++++++++++++++++++++++++++++------------------
>  src/shared/gatt-db.c | 15 ++------
>  src/shared/gatt-db.h |  6 ----
>  3 files changed, 67 insertions(+), 53 deletions(-)
> 
> diff --git a/android/gatt.c b/android/gatt.c
> index f8539d2..f107b41 100644
> --- a/android/gatt.c
> +++ b/android/gatt.c
> @@ -3963,19 +3963,6 @@ static void copy_to_att_list(void *data, void *user_data)
>  	memcpy(&value[4], group->value, group->len);
>  }
>  
> -static void copy_to_att_list_type(void *data, void *user_data)
> -{
> -	struct copy_att_list_data *l = user_data;
> -	struct gatt_db_handle_value *hdl_val = data;
> -	uint8_t *value;
> -
> -	value = l->adl->data[l->iterator++];
> -
> -	put_le16(hdl_val->handle, value);
> -
> -	memcpy(&value[2], hdl_val->value, hdl_val->length);
> -}
> -
>  static void copy_to_att_list_info(void *data, void *user_data)
>  {
>  	struct copy_att_list_data *l = user_data;
> @@ -4055,6 +4042,7 @@ static uint8_t read_by_group_type(const uint8_t *cmd, uint16_t cmd_len,
>  static void send_pending_response(uint8_t opcode, struct gatt_device *device)
>  {
>  	uint8_t rsp[ATT_DEFAULT_LE_MTU];
> +	struct att_data_list *adl;
>  	struct response_data *val;
>  	uint16_t len = 0;
>  
> @@ -4062,6 +4050,33 @@ static void send_pending_response(uint8_t opcode, struct gatt_device *device)
>  		goto done;
>  
>  	switch (opcode) {
> +	case ATT_OP_READ_BY_TYPE_REQ: {
> +		int iterator = 0;
> +
> +		/* FIXME: do proper allocation as val->length may vary */

As discussed offline, if this vary just send response.

> +		val = queue_peek_head(device->pending_requests);
> +		adl = att_data_list_alloc(queue_length(
> +						device->pending_requests),
> +						sizeof(uint16_t) + val->length);
> +
> +		val = queue_pop_head(device->pending_requests);
> +		while (val) {
> +			uint8_t *value = adl->data[iterator++];
> +
> +			put_le16(val->handle, value);
> +			memcpy(&value[2], val->value, val->length);
> +
> +			destroy_response_data(val);
> +
> +			val = queue_pop_head(device->pending_requests);
> +		}
> +
> +		len = enc_read_by_type_resp(adl, rsp, sizeof(rsp));
> +
> +		att_data_list_free(adl);
> +
> +		break;
> +	}
>  	case ATT_OP_READ_BLOB_REQ:
>  		val = queue_pop_head(device->pending_requests);
>  		if (!val)
> @@ -4109,16 +4124,12 @@ static bool match_handle_val_by_handle(const void *data, const void *user_data)
>  }
>  
>  static uint8_t read_by_type(const uint8_t *cmd, uint16_t cmd_len,
> -						uint8_t *rsp, size_t rsp_size,
> -						uint16_t *length)
> +						struct gatt_device *device)
>  {
>  	uint16_t start, end;
>  	uint16_t len;
>  	bt_uuid_t uuid;
>  	struct queue *q;
> -	struct att_data_list *adl;
> -	struct copy_att_list_data l;
> -	struct gatt_db_handle_value *h;
>  
>  	DBG("");
>  
> @@ -4137,26 +4148,46 @@ static uint8_t read_by_type(const uint8_t *cmd, uint16_t cmd_len,
>  		return ATT_ECODE_ATTR_NOT_FOUND;
>  	}
>  
> -	len = queue_length(q);
> -	h = queue_peek_tail(q);
> +	while (queue_peek_head(q)) {
> +		struct response_data *data;
> +		uint16_t handle = PTR_TO_UINT(queue_pop_head(q));
> +		uint8_t *value;
> +		uint16_t value_len;
>  
> -	/* Element here is handle + value*/
> -	adl = att_data_list_alloc(len, sizeof(uint16_t) + h->length);
> -	if (!adl) {
> -		queue_destroy(q, free);
> -		return ATT_ECODE_INSUFF_RESOURCES;
> -	}
> +		data = new0(struct response_data, 1);
> +		if (!data) {
> +			queue_destroy(q, NULL);
> +			return ATT_ECODE_INSUFF_RESOURCES;
> +		}
>  
> -	l.iterator = 0;
> -	l.adl = adl;
> +		data->handle = handle;
> +		queue_push_tail(device->pending_requests, data);
>  
> -	queue_foreach(q, copy_to_att_list_type, &l);
> +		if (!gatt_db_read(gatt_db, handle, 0, ATT_OP_READ_BY_TYPE_REQ,
> +					&device->bdaddr, &value, &value_len)) {
> +			queue_remove(device->pending_requests, data);
> +			free(data);
>  
> -	len = enc_read_by_type_resp(adl, rsp, rsp_size);
> -	*length = len;
> +			continue;
> +		}
>  
> -	att_data_list_free(adl);
> -	queue_destroy(q, free);
> +		/* We have value here already if no callback will be called */
> +		if (value_len) {
> +			data->value = malloc0(value_len);
> +			if (!data->value) {
> +				queue_destroy(q, NULL);
> +				return ATT_ECODE_INSUFF_RESOURCES;
> +			}
> +
> +			memcpy(data->value, value, value_len);
> +			data->length = value_len;
> +		}
> +	}
> +
> +	/* We send immediate if no data left to be filled by async callbacks */
> +	if (!queue_find(device->pending_requests, match_handle_val_by_empty_len,
> +									NULL))
> +		send_pending_response(ATT_OP_READ_BY_TYPE_REQ, device);
>  
>  	return 0;
>  }
> @@ -4406,7 +4437,7 @@ static void att_handler(const uint8_t *ipdu, uint16_t len, gpointer user_data)
>  								&length);
>  		break;
>  	case ATT_OP_READ_BY_TYPE_REQ:
> -		status = read_by_type(ipdu, len, opdu, sizeof(opdu), &length);
> +		status = read_by_type(ipdu, len, dev);
>  		break;
>  	case ATT_OP_READ_REQ:
>  	case ATT_OP_READ_BLOB_REQ:
> diff --git a/src/shared/gatt-db.c b/src/shared/gatt-db.c
> index adce153..324a532 100644
> --- a/src/shared/gatt-db.c
> +++ b/src/shared/gatt-db.c
> @@ -564,7 +564,6 @@ static void read_by_type(void *data, void *user_data)
>  	struct read_by_type_data *search_data = user_data;
>  	struct gatt_db_service *service = data;
>  	struct gatt_db_attribute *attribute;
> -	struct gatt_db_handle_value *value;
>  	int i;
>  
>  	if (!service->active)
> @@ -584,18 +583,8 @@ static void read_by_type(void *data, void *user_data)
>  		if (bt_uuid_cmp(&search_data->uuid, &attribute->uuid))
>  			continue;
>  
> -		value = malloc0(sizeof(struct gatt_db_handle_value) +
> -							attribute->value_len);
> -		if (!value)
> -			return;
> -
> -		value->handle = attribute->handle;
> -		value->length = attribute->value_len;
> -		if (attribute->value_len)
> -			memcpy(value->value, attribute->value, value->length);
> -
> -		if (!queue_push_tail(search_data->queue, value))
> -			free(value);
> +		queue_push_tail(search_data->queue,
> +						UINT_TO_PTR(attribute->handle));
>  	}
>  }
>  
> diff --git a/src/shared/gatt-db.h b/src/shared/gatt-db.h
> index a5a5f41..6c9216d 100644
> --- a/src/shared/gatt-db.h
> +++ b/src/shared/gatt-db.h
> @@ -85,12 +85,6 @@ void gatt_db_find_by_type_value(struct gatt_db *db, uint16_t start_handle,
>  							uint16_t length,
>  							struct queue *queue);
>  
> -struct gatt_db_handle_value {
> -	uint16_t handle;
> -	uint16_t length;
> -	uint8_t value[0];
> -};
> -

Please keep changes to shared/ folder in separate patches if possible (ie. here
you can remove unused type in separate patch with proper commit msg)

>  void gatt_db_read_by_type(struct gatt_db *db, uint16_t start_handle,
>  							uint16_t end_handle,
>  							const bt_uuid_t type,
> 

-- 
Best regards, 
Szymon Janc
