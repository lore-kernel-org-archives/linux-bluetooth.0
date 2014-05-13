Return-Path: <cyrus@holtmann.org>
From: Szymon Janc <szymon.janc@tieto.com>
To: Marcin Kraglak <marcin.kraglak@tieto.com>
Cc: linux-bluetooth@vger.kernel.org
Subject: Re: [PATCH 8/8] shared/gatt: Refactor read_by_group_type
Date: Tue, 13 May 2014 15:50:41 +0200
Message-ID: <3266694.rLNFDbaCPU@uw000953>
In-Reply-To: <1399899758-4944-9-git-send-email-marcin.kraglak@tieto.com>
References: <1399899758-4944-1-git-send-email-marcin.kraglak@tieto.com> <1399899758-4944-9-git-send-email-marcin.kraglak@tieto.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi,

On Monday 12 of May 2014 15:02:38 Marcin Kraglak wrote:
> It will return list of service's handles which have given type
> and are placed in given range.
> ---
>  android/gatt.c       | 60 ++++++++++++++++++++++++++--------------------------
>  src/shared/gatt-db.c | 16 ++------------
>  src/shared/gatt-db.h |  8 -------

Keep android and shared changes separated if possible.

>  3 files changed, 32 insertions(+), 52 deletions(-)
> 
> diff --git a/android/gatt.c b/android/gatt.c
> index e53787e..c9a16cf 100644
> --- a/android/gatt.c
> +++ b/android/gatt.c
> @@ -3944,36 +3944,17 @@ static const struct ipc_handler cmd_handlers[] = {
>  		sizeof(struct hal_cmd_gatt_server_send_response) },
>  };
>  
> -struct copy_att_list_data {
> -	int iterator;
> -	struct att_data_list *adl;
> -};
> -
> -static void copy_to_att_list(void *data, void *user_data)
> -{
> -	struct copy_att_list_data *l = user_data;
> -	struct gatt_db_group *group = data;
> -	uint8_t *value;
> -
> -	value = l->adl->data[l->iterator++];
> -
> -	put_le16(group->handle, value);
> -	put_le16(group->end_group, &value[2]);
> -
> -	memcpy(&value[4], group->value, group->len);
> -}
> -
>  static uint8_t read_by_group_type(const uint8_t *cmd, uint16_t cmd_len,
>  						uint8_t *rsp, size_t rsp_size,
> -						uint16_t *length)
> +						uint16_t *length,
> +						struct gatt_device *device)
>  {
>  	uint16_t start, end;
>  	uint16_t len;
>  	bt_uuid_t uuid;
>  	struct queue *q;
>  	struct att_data_list *adl;
> -	struct copy_att_list_data l;
> -	struct gatt_db_group *d;
> +	int iterator = 0;
>  
>  	len = dec_read_by_grp_req(cmd, cmd_len, &start, &end, &uuid);
>  	if (!len)
> @@ -3991,25 +3972,44 @@ static uint8_t read_by_group_type(const uint8_t *cmd, uint16_t cmd_len,
>  	}
>  
>  	len = queue_length(q);
> -	d = queue_peek_head(q);
>  
>  	/* Element contains start/end handle + size of uuid */
> -	adl = att_data_list_alloc(len, 2 * sizeof(uint16_t) + d->len);
> +	adl = att_data_list_alloc(len, 3 * sizeof(uint16_t));

Is this change due to UUID being always 16bit here? If so please
update comment.

>  	if (!adl) {
> -		queue_destroy(q, free);
> +		queue_destroy(q, NULL);
>  		return ATT_ECODE_INSUFF_RESOURCES;
>  	}
>  
> -	l.iterator = 0;
> -	l.adl = adl;
> +	while (queue_peek_head(q)) {
> +		uint16_t handle = PTR_TO_UINT(queue_pop_head(q));
> +		uint16_t end_handle;
> +		uint8_t *value;
> +		uint16_t value_len;
> +		uint8_t *val;
> +
> +		if (!gatt_db_read(gatt_db, handle, 0, ATT_OP_READ_BY_TYPE_REQ,
> +					&device->bdaddr, &value, &value_len))
> +			break;
>  
> -	queue_foreach(q, copy_to_att_list, &l);
> +		if (!value_len) {
> +			/* It should never happen. service's attribut value
> +			 * must be set when creating service */

/*
 * foo
 * bar
 */


> +			break;
> +		}
> +
> +		end_handle = gatt_db_get_end_handle(gatt_db, handle);
> +
> +		val = adl->data[iterator++];
> +		put_le16(handle, val);
> +		put_le16(end_handle, &val[2]);
> +		memcpy(&val[4], value, value_len);
> +	}
>  
>  	len = enc_read_by_grp_resp(adl, rsp, rsp_size);
>  	*length = len;
>  
>  	att_data_list_free(adl);
> -	queue_destroy(q, free);
> +	queue_destroy(q, NULL);
>  
>  	return 0;
>  }
> @@ -4412,7 +4412,7 @@ static void att_handler(const uint8_t *ipdu, uint16_t len, gpointer user_data)
>  	switch (ipdu[0]) {
>  	case ATT_OP_READ_BY_GROUP_REQ:
>  		status = read_by_group_type(ipdu, len, opdu, sizeof(opdu),
> -								&length);
> +								&length, dev);
>  		break;
>  	case ATT_OP_READ_BY_TYPE_REQ:
>  		status = read_by_type(ipdu, len, dev);
> diff --git a/src/shared/gatt-db.c b/src/shared/gatt-db.c
> index 3869d4f..d44e70c 100644
> --- a/src/shared/gatt-db.c
> +++ b/src/shared/gatt-db.c
> @@ -423,7 +423,6 @@ static void read_by_group_type(void *data, void *user_data)
>  {
>  	struct read_by_group_type_data *search_data = user_data;
>  	struct gatt_db_service *service = data;
> -	struct gatt_db_group *group;
>  
>  	if (!service->active)
>  		return;
> @@ -448,19 +447,8 @@ static void read_by_group_type(void *data, void *user_data)
>  		return;
>  	}
>  
> -	group = malloc0(sizeof(struct gatt_db_group) +
> -					service->attributes[0]->value_len);
> -	if (!group)
> -		return;
> -
> -	group->len = service->attributes[0]->value_len;
> -	memcpy(group->value, service->attributes[0]->value, group->len);
> -	group->handle = service->attributes[0]->handle;
> -	group->end_group = service->attributes[0]->handle +
> -						service->num_handles - 1;
> -
> -	if (!queue_push_tail(search_data->queue, group))
> -		free(group);
> +	queue_push_tail(search_data->queue,
> +			UINT_TO_PTR(service->attributes[0]->handle));
>  }
>  
>  void gatt_db_read_by_group_type(struct gatt_db *db, uint16_t start_handle,
> diff --git a/src/shared/gatt-db.h b/src/shared/gatt-db.h
> index 5b2a17c..747c73b 100644
> --- a/src/shared/gatt-db.h
> +++ b/src/shared/gatt-db.h
> @@ -60,14 +60,6 @@ uint16_t gatt_db_add_included_service(struct gatt_db *db, uint16_t handle,
>  bool gatt_db_service_set_active(struct gatt_db *db, uint16_t handle,
>  								bool active);
>  
> -struct gatt_db_group {
> -	uint16_t handle;
> -	uint16_t end_group;
> -	uint16_t len;
> -	uint8_t value[0];
> -};
> -
> -/* Returns queue with struct gatt_db_group */
>  void gatt_db_read_by_group_type(struct gatt_db *db, uint16_t start_handle,
>  							uint16_t end_handle,
>  							const bt_uuid_t type,
> 

-- 
Best regards, 
Szymon Janc
