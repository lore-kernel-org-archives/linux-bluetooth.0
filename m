Return-Path: <cyrus@holtmann.org>
From: Szymon Janc <szymon.janc@tieto.com>
To: Marcin Kraglak <marcin.kraglak@tieto.com>
Cc: linux-bluetooth@vger.kernel.org
Subject: Re: [PATCH 1/4] gatt: Add new sharacteristic functionality
Date: Fri, 25 Apr 2014 12:46:20 +0200
Message-ID: <2240045.GfjqklEvTV@leonov>
In-Reply-To: <1398416472-7852-1-git-send-email-marcin.kraglak@tieto.com>
References: <1398416472-7852-1-git-send-email-marcin.kraglak@tieto.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

On Friday 25 of April 2014 11:01:09 Marcin Kraglak wrote:
> It will attach characteristic declaration and value, and return value
> handle. It is needed to pass service handle to which this characteristic
> will be added. If there is not enough free handles in service, 0 will be
> returned.
> ---

There is a typo in commit title 'sharacteristic'.

>  src/shared/gatt-db.c | 95
> ++++++++++++++++++++++++++++++++++++++++++++++++++++ src/shared/gatt-db.h |
> 15 +++++++++
>  2 files changed, 110 insertions(+)
> 
> diff --git a/src/shared/gatt-db.c b/src/shared/gatt-db.c
> index a211cda..91590d3 100644
> --- a/src/shared/gatt-db.c
> +++ b/src/shared/gatt-db.c
> @@ -28,10 +28,14 @@
>  #include "src/shared/queue.h"
>  #include "src/shared/gatt-db.h"
> 
> +#define MAX_CHAR_DECL_VALUE_LEN 19
> +
>  static const bt_uuid_t primary_service_uuid = { .type = BT_UUID16,
>  					.value.u16 = GATT_PRIM_SVC_UUID };
>  static const bt_uuid_t secondary_service_uuid = { .type = BT_UUID16,
>  					.value.u16 = GATT_SND_SVC_UUID };
> +static const bt_uuid_t characteristic_uuid = { .type = BT_UUID16,
> +					.value.u16 = GATT_CHARAC_UUID };
> 
>  struct gatt_db {
>  	uint16_t next_handle;
> @@ -43,6 +47,10 @@ struct gatt_db_attribute {
>  	bt_uuid_t uuid;
>  	uint16_t val_len;
>  	uint8_t value[0];
> +	uint8_t permissions;
> +	gatt_db_read_t read_func;
> +	gatt_db_write_t write_func;
> +	void *user_data;
>  };
> 
>  struct gatt_db_service {
> @@ -191,3 +199,90 @@ bool gatt_db_remove_service(struct gatt_db *db,
> uint16_t handle)
> 
>  	return true;
>  }
> +
> +static uint16_t get_attribute_index(struct gatt_db_service *service,
> +							int end_offset)
> +{
> +	int i = 0;
> +
> +	while (i < service->num_handles - end_offset && service->attributes[i])
> +		i++;

Some braces here would improve really readability. Also a comment here would 
be nice.

> +
> +	return i == service->num_handles - end_offset ? 0 : i;
> +}

Same here.

> +
> +static uint16_t get_handle_at_index(struct gatt_db_service *service,
> +								int index)
> +{
> +	return service->attributes[index]->handle;
> +}
> +
> +static uint16_t update_attribute_handle(struct gatt_db_service *service,
> +								int index)
> +{
> +	uint16_t previous_handle;
> +
> +	previous_handle = service->attributes[index - 1]->handle;

Add a comment why this is safe.

> +	service->attributes[index]->handle = previous_handle + 1;
> +
> +	return service->attributes[index]->handle;
> +}
> +
> +static void set_attribute_data(struct gatt_db_attribute *attribute,
> +						gatt_db_read_t read_func,
> +						gatt_db_write_t write_func,
> +						uint8_t permissions,
> +						void *user_data)
> +{
> +	attribute->permissions = permissions;
> +	attribute->read_func = read_func;
> +	attribute->write_func = write_func;
> +	attribute->user_data = user_data;
> +}
> +
> +uint16_t gatt_db_new_characteristic(struct gatt_db *db, uint16_t handle,
> +						const bt_uuid_t *uuid,
> +						uint8_t permissions,
> +						uint8_t properties,
> +						gatt_db_read_t read_func,
> +						gatt_db_write_t write_func,
> +						void *user_data)
> +{
> +	uint8_t value[MAX_CHAR_DECL_VALUE_LEN];
> +	struct gatt_db_service *service;
> +	uint16_t len = 0;
> +	int i;
> +
> +	service = queue_find(db->services, match_service_by_handle,
> +							INT_TO_PTR(handle));
> +	if (!service)
> +		return 0;
> +
> +	i = get_attribute_index(service, 1);
> +	if (!i)
> +		return 0;
> +
> +	value[0] = properties;
> +	len += sizeof(properties);
> +	put_le16(get_handle_at_index(service, i - 1) + 2, &value[1]);

Comment.

> +	len += sizeof(uint16_t);
> +	len += uuid_to_le(uuid, &value[3]);
> +
> +	service->attributes[i] = new_attribute(&characteristic_uuid, value,
> +									len);
> +	if (!service->attributes[i])
> +		return 0;
> +
> +	update_attribute_handle(service, i++);
> +
> +	service->attributes[i] = new_attribute(uuid, NULL, 0);
> +	if (!service->attributes[i]) {
> +		free(service->attributes[i - 1]);
> +		return 0;
> +	}
> +
> +	set_attribute_data(service->attributes[i], read_func, write_func,
> +							permissions, user_data);
> +
> +	return update_attribute_handle(service, i);
> +}
> diff --git a/src/shared/gatt-db.h b/src/shared/gatt-db.h
> index b014b17..9ee1a08 100644
> --- a/src/shared/gatt-db.h
> +++ b/src/shared/gatt-db.h
> @@ -29,3 +29,18 @@ void gatt_db_destroy(struct gatt_db *db);
>  uint16_t gatt_db_add_service(struct gatt_db *db, const bt_uuid_t *uuid,
>  					bool primary, uint16_t num_handles);
>  bool gatt_db_remove_service(struct gatt_db *db, uint16_t handle);
> +
> +typedef void (*gatt_db_read_t) (uint16_t handle, const bdaddr_t *bdaddr,
> +				uint16_t request_id, void *user_data);
> +
> +typedef void (*gatt_db_write_t)  (uint16_t handle, const bdaddr_t *bdaddr,
> +				uint16_t request_id, const uint8_t *value,
> +								size_t len);
> +
> +uint16_t gatt_db_new_characteristic(struct gatt_db *db, uint16_t handle,
> +						const bt_uuid_t *uuid,
> +						uint8_t permissions,
> +						uint8_t properties,
> +						gatt_db_read_t read_func,
> +						gatt_db_write_t write_func,
> +						void *user_data);

-- 
BR
Szymon Janc
