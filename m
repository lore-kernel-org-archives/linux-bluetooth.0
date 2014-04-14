Return-Path: <cyrus@holtmann.org>
MIME-Version: 1.0
In-Reply-To: <1397027234-12003-4-git-send-email-marcin.kraglak@tieto.com>
References: <1397027234-12003-1-git-send-email-marcin.kraglak@tieto.com>
	<1397027234-12003-4-git-send-email-marcin.kraglak@tieto.com>
Date: Mon, 14 Apr 2014 11:14:15 -0300
Message-ID: <CAKT1EBcDG8_j2K0Hbr=TLHvf+A6W3SZ+-fxiO4xwByRH2ZnqFA@mail.gmail.com>
Subject: Re: [RFC 03/16] gatt: Add method for creating services in gatt_db
From: Claudio Takahasi <claudio.takahasi@openbossa.org>
To: Marcin Kraglak <marcin.kraglak@tieto.com>
Cc: BlueZ development <linux-bluetooth@vger.kernel.org>
Content-Type: text/plain; charset=UTF-8
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Marcin,

On Wed, Apr 9, 2014 at 4:07 AM, Marcin Kraglak <marcin.kraglak@tieto.com> wrote:
> This function will reserve number of handles and create service attribute. Allowed
> service types are PRIMARY and SECONDARY.
> ---
>  src/shared/gatt-db.c | 92 ++++++++++++++++++++++++++++++++++++++++++++++++++++
>  src/shared/gatt-db.h |  9 +++++
>  2 files changed, 101 insertions(+)
>
> diff --git a/src/shared/gatt-db.c b/src/shared/gatt-db.c
> index 47915c7..15e2f95 100644
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
> +static const bt_uuid_t primary_service_uuid  = { .type = BT_UUID16,
> +                                       .value.u16 = GATT_PRIM_SVC_UUID };
> +static const bt_uuid_t secondary_service_uuid  = { .type = BT_UUID16,
> +                                       .value.u16 = GATT_SND_SVC_UUID };
> +
>  struct gatt_db {
>         uint16_t next_handle;
>         struct queue *services;
>  };
>
>  struct gatt_db_attribute {
> +       uint16_t handle;
> +       bt_uuid_t uuid;
> +       uint16_t val_len;
> +       uint8_t value[0];
>  };
>
>  struct gatt_db_service {
> @@ -77,3 +87,85 @@ void gatt_db_destroy(struct gatt_db *db)
>         queue_destroy(db->services, gatt_db_service_destroy);
>         free(db);
>  }
> +
> +static struct gatt_db_attribute *new_attribute(const bt_uuid_t *type,
> +                                                       const uint8_t *val,
> +                                                       uint16_t len)
> +{
> +       struct gatt_db_attribute *attribute;
> +
> +       attribute = malloc0(sizeof(struct gatt_db_attribute) + len);
> +       if (!attribute)
> +               return NULL;
> +
> +       attribute->uuid = *type;
> +       memcpy(&attribute->value, val, len);
> +       attribute->val_len = len;
> +
> +       return attribute;
> +}
> +
> +static int uuid_to_le(const bt_uuid_t *uuid, uint8_t *dst)
> +{
> +       switch (uuid->type) {
> +       case BT_UUID16:
> +               put_le16(uuid->value.u16, dst);
> +               break;
> +       case BT_UUID32:
> +               put_le32(uuid->value.u32, dst);
> +               break;
> +       default:
> +               bswap_128(&uuid->value.u128, dst);
> +               break;
> +       }
> +
> +       return bt_uuid_len(uuid);
> +}
> +
> +uint16_t gatt_db_new_service(struct gatt_db *db, const bt_uuid_t *uuid,
> +                                       enum gatt_db_service_type service_type,
> +                                       uint16_t num_handles)

Just one suggestion, not sure if it will be possible. Plug-ins or
other files using this function should have access to gatt_db, *maybe*
it could be hidden.

<snip>

> +       if (!queue_push_tail(db->services, service)) {
> +               gatt_db_service_destroy(service);
> +               return 0;
> +       }
> +
> +       service->attributes[0]->handle = db->next_handle;
> +       db->next_handle += num_handles;
> +       service->num_handles = num_handles;
> +
> +       return service->attributes[0]->handle;
> +}
> diff --git a/src/shared/gatt-db.h b/src/shared/gatt-db.h
> index 2901afb..7c03013 100644
> --- a/src/shared/gatt-db.h
> +++ b/src/shared/gatt-db.h
> @@ -23,5 +23,14 @@
>
>  struct gatt_db;
>
> +enum gatt_db_service_type {
> +       GATT_DB_SERVICE_PRIMARY,
> +       GATT_DB_SERVICE_SECONDARY
> +};

"bool" should be enough to inform if the service is primary or secondary.


<snip>

Claudio
