Return-Path: <cyrus@holtmann.org>
From: Szymon Janc <szymon.janc@tieto.com>
To: Marcin Kraglak <marcin.kraglak@tieto.com>
Cc: linux-bluetooth@vger.kernel.org
Subject: Re: [PATCH 5/8] shared/gatt: Refactor find information
Date: Tue, 13 May 2014 15:41:23 +0200
Message-ID: <1692084.2AfmRjfcVW@uw000953>
In-Reply-To: <1399899758-4944-6-git-send-email-marcin.kraglak@tieto.com>
References: <1399899758-4944-1-git-send-email-marcin.kraglak@tieto.com> <1399899758-4944-6-git-send-email-marcin.kraglak@tieto.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi,

On Monday 12 of May 2014 15:02:35 Marcin Kraglak wrote:
> Now find information will fill queue with handles of found attributes.
> ---
>  android/gatt.c       | 66 ++++++++++++++++++----------------------------------
>  src/shared/gatt-db.c | 32 ++++++++++++++++++-------
>  src/shared/gatt-db.h | 12 ++++------

Please keep android and shared changes separate patches.

>  3 files changed, 50 insertions(+), 60 deletions(-)
> 
> diff --git a/android/gatt.c b/android/gatt.c
> index f107b41..e53787e 100644
> --- a/android/gatt.c
> +++ b/android/gatt.c
> @@ -3963,31 +3963,6 @@ static void copy_to_att_list(void *data, void *user_data)
>  	memcpy(&value[4], group->value, group->len);
>  }
>  
> -static void copy_to_att_list_info(void *data, void *user_data)
> -{
> -	struct copy_att_list_data *l = user_data;
> -	struct gatt_db_find_information *info = data;
> -	uint8_t *value;
> -
> -	value = l->adl->data[l->iterator++];
> -
> -	put_le16(info->handle, value);
> -
> -	switch (info->uuid.type) {
> -	case BT_UUID16:
> -		memcpy(&value[2], &info->uuid.value.u16,
> -						bt_uuid_len(&info->uuid));
> -		break;
> -	case BT_UUID128:
> -		memcpy(&value[2], &info->uuid.value.u128,
> -						bt_uuid_len(&info->uuid));
> -		break;
> -	default:
> -		error("gatt: Unexpected UUID type");
> -		break;
> -	}
> -}
> -
>  static uint8_t read_by_group_type(const uint8_t *cmd, uint16_t cmd_len,
>  						uint8_t *rsp, size_t rsp_size,
>  						uint16_t *length)
> @@ -4296,12 +4271,9 @@ static uint8_t find_info_handle(const uint8_t *cmd, uint16_t cmd_len,
>  						uint16_t *length)
>  {
>  	struct queue *q;
> -	struct gatt_db_find_information *last_element;
> -	struct copy_att_list_data l;
>  	struct att_data_list *adl;
> +	int iterator = 0;
>  	uint16_t start, end;
> -	uint16_t num;
> -	uint8_t format;
>  	uint16_t len;
>  
>  	DBG("");
> @@ -4322,29 +4294,35 @@ static uint8_t find_info_handle(const uint8_t *cmd, uint16_t cmd_len,
>  	}
>  
>  	len = queue_length(q);
> +	adl = att_data_list_alloc(len, 2 * sizeof(uint16_t));
> +	if (!adl) {
> +		queue_destroy(q, NULL);
> +		return ATT_ECODE_INSUFF_RESOURCES;
> +	}
> +
> +	while (queue_peek_head(q)) {
> +		uint8_t *value;
> +		const bt_uuid_t *type;
> +		uint16_t handle = PTR_TO_UINT(queue_pop_head(q));
>  
> -	last_element = queue_peek_head(q);
> +		type = gatt_db_get_attribute_type(gatt_db, handle);
> +		if (!type)
> +			break;
> +
> +		value = adl->data[iterator++];
> +
> +		put_le16(handle, value);
> +		memcpy(&value[2], &type->value.u16, bt_uuid_len(type));
>  
> -	if (last_element->uuid.type == BT_UUID16) {
> -		num = sizeof(uint16_t);
> -		format = ATT_FIND_INFO_RESP_FMT_16BIT;
> -	} else {
> -		num = sizeof(uint128_t);
> -		format = ATT_FIND_INFO_RESP_FMT_128BIT;
>  	}
>  
> -	adl = att_data_list_alloc(len, num + sizeof(uint16_t));
>  	if (!adl) {
> -		queue_destroy(q, free);
> +		queue_destroy(q, NULL);
>  		return ATT_ECODE_INSUFF_RESOURCES;
>  	}
>  
> -	l.iterator = 0;
> -	l.adl = adl;
> -
> -	queue_foreach(q, copy_to_att_list_info, &l);
> -
> -	len = enc_find_info_resp(format, adl, rsp, rsp_size);
> +	len = enc_find_info_resp(ATT_FIND_INFO_RESP_FMT_16BIT, adl, rsp,
> +								rsp_size);
>  	if (!len)
>  		return ATT_ECODE_UNLIKELY;
>  
> diff --git a/src/shared/gatt-db.c b/src/shared/gatt-db.c
> index 324a532..532e0b7 100644
> --- a/src/shared/gatt-db.c
> +++ b/src/shared/gatt-db.c
> @@ -614,7 +614,6 @@ static void find_information(void *data, void *user_data)
>  	struct find_information_data *search_data = user_data;
>  	struct gatt_db_service *service = data;
>  	struct gatt_db_attribute *attribute;
> -	struct gatt_db_find_information *value;
>  	int i;
>  
>  	if (!service->active)
> @@ -636,14 +635,8 @@ static void find_information(void *data, void *user_data)
>  		if (attribute->handle > search_data->end_handle)
>  			return;
>  
> -		value = new0(struct gatt_db_find_information, 1);
> -		if (!value)
> -			return;
> -
> -		value->handle = attribute->handle;
> -		value->uuid = attribute->uuid;
> -		if (!queue_push_tail(search_data->queue, value))
> -			free(value);
> +		queue_push_tail(search_data->queue,
> +						UINT_TO_PTR(attribute->handle));
>  	}
>  }
>  
> @@ -730,3 +723,24 @@ bool gatt_db_write(struct gatt_db *db, uint16_t handle, uint16_t offset,
>  
>  	return true;
>  }
> +
> +const bt_uuid_t *gatt_db_get_attribute_type(struct gatt_db *db,
> +							uint16_t handle)
> +{
> +	struct gatt_db_service *service;
> +	struct gatt_db_attribute *attribute;
> +	uint16_t service_handle;
> +
> +	service = queue_find(db->services, find_service_for_handle,
> +						INT_TO_PTR(handle));
> +	if (!service)
> +		return NULL;
> +
> +	service_handle = service->attributes[0]->handle;
> +
> +	attribute = service->attributes[handle - service_handle];
> +	if (!attribute)
> +		return NULL;
> +
> +	return &attribute->uuid;
> +}
> diff --git a/src/shared/gatt-db.h b/src/shared/gatt-db.h
> index 6c9216d..cc9120c 100644
> --- a/src/shared/gatt-db.h
> +++ b/src/shared/gatt-db.h
> @@ -84,17 +84,12 @@ void gatt_db_find_by_type_value(struct gatt_db *db, uint16_t start_handle,
>  							const uint8_t *value,
>  							uint16_t length,
>  							struct queue *queue);
> -
> +/* List of handles */

Use full sentence here as now this is a bit unclear what this comment refers to.

>  void gatt_db_read_by_type(struct gatt_db *db, uint16_t start_handle,
>  							uint16_t end_handle,
>  							const bt_uuid_t type,
>  							struct queue *queue);
> -
> -struct gatt_db_find_information {
> -	uint16_t handle;
> -	bt_uuid_t uuid;
> -};
> -

This should be in separate patch.

> +/* List of handles */
>  void gatt_db_find_information(struct gatt_db *db, uint16_t start_handle,
>  							uint16_t end_handle,
>  							struct queue *queue);
> @@ -106,3 +101,6 @@ bool gatt_db_read(struct gatt_db *db, uint16_t handle, uint16_t offset,
>  bool gatt_db_write(struct gatt_db *db, uint16_t handle, uint16_t offset,
>  					const uint8_t *value, size_t len,
>  					uint8_t att_opcode, bdaddr_t *bdaddr);
> +
> +const bt_uuid_t *gatt_db_get_attribute_type(struct gatt_db *db,
> +							uint16_t handle);
> 

-- 
Best regards, 
Szymon Janc
