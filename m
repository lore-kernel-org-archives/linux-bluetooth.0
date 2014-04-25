Return-Path: <cyrus@holtmann.org>
From: Szymon Janc <szymon.janc@tieto.com>
To: Marcin Kraglak <marcin.kraglak@tieto.com>
Cc: linux-bluetooth@vger.kernel.org
Subject: Re: [PATCHv2 3/4] gatt: Add method for creating services in gatt_db
Date: Fri, 25 Apr 2014 09:53:28 +0200
Message-ID: <1528862.bPs8654V6Y@leonov>
In-Reply-To: <1398343492-19874-1-git-send-email-marcin.kraglak@tieto.com>
References: <1398343492-19874-1-git-send-email-marcin.kraglak@tieto.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Marcin,

On Thursday 24 of April 2014 14:44:51 Marcin Kraglak wrote:
> This function will reserve number of handles and create service attribute.
> Both types of service can be created, PRIMARY or SECONDARy, user can select
> type with primary flag.
> ---
>  src/shared/gatt-db.c | 94
> ++++++++++++++++++++++++++++++++++++++++++++++++++++ src/shared/gatt-db.h |
>  3 ++
>  2 files changed, 97 insertions(+)
> 
> diff --git a/src/shared/gatt-db.c b/src/shared/gatt-db.c
> index b057c15..672c11c 100644
> --- a/src/shared/gatt-db.c
> +++ b/src/shared/gatt-db.c
> @@ -23,16 +23,26 @@
> 
>  #include <stdbool.h>
> 
> +#include "lib/uuid.h"
>  #include "src/shared/util.h"
>  #include "src/shared/queue.h"
>  #include "src/shared/gatt-db.h"
> 
> +static const bt_uuid_t primary_service_uuid = { .type = BT_UUID16,
> +					.value.u16 = GATT_PRIM_SVC_UUID };
> +static const bt_uuid_t secondary_service_uuid = { .type = BT_UUID16,
> +					.value.u16 = GATT_SND_SVC_UUID };
> +
>  struct gatt_db {
>  	uint16_t next_handle;
>  	struct queue *services;
>  };
> 
>  struct gatt_db_attribute {
> +	uint16_t handle;
> +	bt_uuid_t uuid;
> +	uint16_t val_len;
> +	uint8_t value[0];
>  };
> 
>  struct gatt_db_service {
> @@ -76,3 +86,87 @@ void gatt_db_destroy(struct gatt_db *db)
>  	queue_destroy(db->services, gatt_db_service_destroy);
>  	free(db);
>  }
> +
> +static struct gatt_db_attribute *new_attribute(const bt_uuid_t *type,
> +							const uint8_t *val,
> +							uint16_t len)
> +{
> +	struct gatt_db_attribute *attribute;
> +
> +	attribute = malloc0(sizeof(struct gatt_db_attribute) + len);
> +	if (!attribute)
> +		return NULL;
> +
> +	attribute->uuid = *type;
> +	memcpy(&attribute->value, val, len);
> +	attribute->val_len = len;
> +
> +	return attribute;
> +}
> +
> +static int uuid_to_le(const bt_uuid_t *uuid, uint8_t *dst)
> +{
> +	switch (uuid->type) {
> +	case BT_UUID16:
> +		put_le16(uuid->value.u16, dst);
> +		break;
> +	case BT_UUID32:
> +		put_le32(uuid->value.u32, dst);
> +		break;
> +	default:
> +		bswap_128(&uuid->value.u128, dst);
> +		break;
> +	}
> +
> +	return bt_uuid_len(uuid);
> +}
> +
> +uint16_t gatt_db_add_service(struct gatt_db *db, const bt_uuid_t *uuid,
> +					bool primary, uint16_t num_handles)
> +{
> +	struct gatt_db_service *service;
> +	const bt_uuid_t *type;
> +	uint8_t value[16];
> +	uint16_t len;
> +
> +	if (num_handles < 1)
> +		return 0;
> +
> +	service = new0(struct gatt_db_service, 1);
> +	if (!service)
> +		return 0;
> +
> +	service->attributes = new0(struct gatt_db_attribute *, num_handles);
> +	if (!service->attributes) {
> +		free(service);
> +		return 0;
> +	}
> +
> +	if (primary)
> +		type = &primary_service_uuid;
> +	else
> +		type = &secondary_service_uuid;
> +
> +	len = uuid_to_le(uuid, value);
> +
> +	service->attributes[0] = new_attribute(type, value, len);
> +	if (!service->attributes[0]) {
> +		gatt_db_service_destroy(service);
> +		return 0;
> +	}
> +
> +	if (!queue_push_tail(db->services, service)) {
> +		gatt_db_service_destroy(service);
> +		return 0;
> +	}
> +
> +	/* TODO now we get next handle from database. We should first look
> +	 * for 'holes' between existing services first, and assign next_handle
> +	 * only if enough space was not found.
> +	 */
> +	service->attributes[0]->handle = db->next_handle;
> +	db->next_handle += num_handles;
> +	service->num_handles = num_handles;
> +
> +	return service->attributes[0]->handle;
> +}
> diff --git a/src/shared/gatt-db.h b/src/shared/gatt-db.h
> index 2901afb..7cae6b1 100644
> --- a/src/shared/gatt-db.h
> +++ b/src/shared/gatt-db.h
> @@ -25,3 +25,6 @@ struct gatt_db;
> 
>  struct gatt_db *gatt_db_new(void);
>  void gatt_db_destroy(struct gatt_db *db);
> +
> +uint16_t gatt_db_add_service(struct gatt_db *db, const bt_uuid_t *uuid,
> +					bool primary, uint16_t num_handles);

Both patches applied, thanks.

-- 
BR
Szymon Janc
