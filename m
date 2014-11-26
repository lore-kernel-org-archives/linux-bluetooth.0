Return-Path: <cyrus@holtmann.org>
MIME-Version: 1.0
In-Reply-To: <1416979609-3056-2-git-send-email-armansito@chromium.org>
References: <1416979609-3056-1-git-send-email-armansito@chromium.org>
	<1416979609-3056-2-git-send-email-armansito@chromium.org>
Date: Wed, 26 Nov 2014 12:37:00 +0200
Message-ID: <CABBYNZLGpGOYezB7zLoDUAf-18HCge7f=BUgPnAjKsOeg76dWw@mail.gmail.com>
Subject: Re: [PATCH BlueZ 1/5] shared/gatt-db: Add high-level functions for client
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
To: Arman Uguray <armansito@chromium.org>
Cc: "linux-bluetooth@vger.kernel.org" <linux-bluetooth@vger.kernel.org>
Content-Type: text/plain; charset=UTF-8
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Arman,

On Wed, Nov 26, 2014 at 7:26 AM, Arman Uguray <armansito@chromium.org> wrote:
> This patch introduces foreach functions to gatt-db for enumerating
> service, characteristic, and decriptors stored in the database as
> gatt_db_attribute pointers. This patch also adds functions for
> extracting service, characteristic, and include declaration data out of
> matching attributes.
>
> This is in preparation for using gatt-db as the attribute cache in
> shared/gatt-client.
> ---
>  src/shared/gatt-db.c | 279 +++++++++++++++++++++++++++++++++++++++++++++++++++
>  src/shared/gatt-db.h |  37 +++++++
>  2 files changed, 316 insertions(+)
>
> diff --git a/src/shared/gatt-db.c b/src/shared/gatt-db.c
> index ab08c69..272ca31 100644
> --- a/src/shared/gatt-db.c
> +++ b/src/shared/gatt-db.c
> @@ -193,6 +193,29 @@ static int uuid_to_le(const bt_uuid_t *uuid, uint8_t *dst)
>         return bt_uuid_len(&uuid128);
>  }
>
> +static bool le_to_uuid(const uint8_t *src, size_t len, bt_uuid_t *uuid)
> +{
> +       uint128_t u128;
> +
> +       if (len == 2) {
> +               bt_uuid16_create(uuid, get_le16(src));
> +               return true;
> +       }
> +
> +       if (len == 4) {
> +               bt_uuid32_create(uuid, get_le32(src));
> +               return true;
> +       }
> +
> +       if (len != 16)
> +               return false;
> +
> +       bswap_128(src, &u128);
> +       bt_uuid128_create(uuid, u128);
> +
> +       return true;
> +}
> +
>  struct gatt_db_attribute *gatt_db_add_service(struct gatt_db *db,
>                                                 const bt_uuid_t *uuid,
>                                                 bool primary,
> @@ -665,6 +688,155 @@ void gatt_db_find_information(struct gatt_db *db, uint16_t start_handle,
>         queue_foreach(db->services, find_information, &data);
>  }
>
> +struct foreach_data {
> +       gatt_db_foreach_t func;
> +       void *user_data;
> +};
> +
> +static void foreach_service(void *data, void *user_data)
> +{
> +       struct gatt_db_service *service = data;
> +       struct foreach_data *foreach_data = user_data;
> +
> +       foreach_data->func(service->attributes[0], foreach_data->user_data);
> +}
> +
> +void gatt_db_foreach_service(struct gatt_db *db, gatt_db_foreach_t func,
> +                                                       void *user_data)
> +{
> +       struct foreach_data data;
> +
> +       if (!db || !func)
> +               return;
> +
> +       data.func = func;
> +       data.user_data = user_data;
> +
> +       queue_foreach(db->services, foreach_service, &data);
> +}

You could actually make gatt_db_foreach_service call
gatt_db_foreach_service_in_range with the maximum range here so we
have less code to maintain.

> +struct foreach_in_range_data {
> +       gatt_db_foreach_t func;
> +       void *user_data;
> +       uint16_t start, end;
> +};
> +
> +static void foreach_service_in_range(void *data, void *user_data)
> +{
> +       struct gatt_db_service *service = data;
> +       struct foreach_in_range_data *foreach_data = user_data;
> +       uint16_t svc_start;
> +
> +       svc_start = get_handle_at_index(service, 0);
> +
> +       if (svc_start > foreach_data->end || svc_start < foreach_data->start)
> +               return;
> +
> +       foreach_data->func(service->attributes[0], foreach_data->user_data);
> +}
> +
> +void gatt_db_foreach_service_in_range(struct gatt_db *db,
> +                                                       gatt_db_foreach_t func,
> +                                                       void *user_data,
> +                                                       uint16_t start_handle,
> +                                                       uint16_t end_handle)
> +{
> +       struct foreach_in_range_data data;
> +
> +       if (!db || !func || start_handle > end_handle)
> +               return;
> +
> +       data.func = func;
> +       data.user_data = user_data;
> +       data.start = start_handle;
> +       data.end = end_handle;
> +
> +       queue_foreach(db->services, foreach_service_in_range, &data);
> +}
> +
> +void gatt_db_attribute_foreach_charac(struct gatt_db_attribute *attrib,
> +                                                       gatt_db_foreach_t func,
> +                                                       void *user_data)
> +{
> +       struct gatt_db_service *service;
> +       struct gatt_db_attribute *attr;
> +       uint16_t i;
> +
> +       if (!attrib || !func)
> +               return;
> +
> +       service = attrib->service;
> +
> +       for (i = 0; i < service->num_handles; i++) {
> +               attr = service->attributes[i];
> +               if (!attr)
> +                       continue;
> +
> +               if (bt_uuid_cmp(&characteristic_uuid, &attr->uuid))
> +                       continue;
> +
> +               func(attr, user_data);
> +       }
> +}
> +
> +void gatt_db_attribute_foreach_descr(struct gatt_db_attribute *attrib,
> +                                                       gatt_db_foreach_t func,
> +                                                       void *user_data)
> +{
> +       struct gatt_db_service *service;
> +       struct gatt_db_attribute *attr;
> +       uint16_t i;
> +
> +       if (!attrib || !func)
> +               return;
> +
> +       /* Return if this attribute is not a characteristic declaration */
> +       if (bt_uuid_cmp(&characteristic_uuid, &attrib->uuid))
> +               return;
> +
> +       service = attrib->service;
> +
> +       /* Start from the attribute following the value handle */
> +       i = attrib->handle - service->attributes[0]->handle + 2;
> +       for (; i < service->num_handles; i++) {
> +               attr = service->attributes[i];
> +               if (!attr)
> +                       continue;
> +
> +               /* Return if we reached the end of this characteristic */
> +               if (!bt_uuid_cmp(&characteristic_uuid, &attr->uuid) ||
> +                       !bt_uuid_cmp(&included_service_uuid, &attr->uuid))
> +                       return;
> +
> +               func(attr, user_data);
> +       }
> +}
> +
> +void gatt_db_attribute_foreach_incl(struct gatt_db_attribute *attrib,
> +                                                       gatt_db_foreach_t func,
> +                                                       void *user_data)
> +{
> +       struct gatt_db_service *service;
> +       struct gatt_db_attribute *attr;
> +       uint16_t i;
> +
> +       if (!attrib || !func)
> +               return;
> +
> +       service = attrib->service;
> +
> +       for (i = 0; i < service->num_handles; i++) {
> +               attr = service->attributes[i];
> +               if (!attr)
> +                       continue;
> +
> +               if (bt_uuid_cmp(&included_service_uuid, &attr->uuid))
> +                       continue;
> +
> +               func(attr, user_data);
> +       }
> +}

These also seems very similar, perhaps we could have
gatt_db_attribute_foreach that takes the uuid in addition to these
which btw could just call it with the right uuid well except for
descriptors which seems a bit different, actually we need something
that can replace gatt_db_find_by_type anyway since it exposes queues
and makes us iterate twice.

>  static bool find_service_for_handle(const void *data, const void *user_data)
>  {
>         const struct gatt_db_service *service = data;
> @@ -769,6 +941,113 @@ bool gatt_db_attribute_get_service_handles(struct gatt_db_attribute *attrib,
>         return true;
>  }
>
> +bool gatt_db_attribute_get_service_data(struct gatt_db_attribute *attrib,
> +                                                       uint16_t *start_handle,
> +                                                       uint16_t *end_handle,
> +                                                       bool *primary,
> +                                                       bt_uuid_t *uuid)
> +{
> +       struct gatt_db_service *service;
> +       struct gatt_db_attribute *decl;
> +
> +       if (!attrib)
> +               return false;
> +
> +       service = attrib->service;
> +       decl = service->attributes[0];
> +
> +       if (start_handle)
> +               *start_handle = decl->handle;
> +
> +       if (end_handle)
> +               *end_handle = decl->handle + service->num_handles - 1;
> +
> +       if (primary)
> +               *primary = bt_uuid_cmp(&decl->uuid, &secondary_service_uuid);
> +
> +       if (!uuid)
> +               return true;
> +
> +       /*
> +        * The service declaration attribute value is the 16 or 128 bit service
> +        * UUID.
> +        */
> +       return le_to_uuid(decl->value, decl->value_len, uuid);
> +}
> +
> +bool gatt_db_attribute_get_characteristic_data(struct gatt_db_attribute *attrib,
> +                                                       uint16_t *handle,
> +                                                       uint16_t *value_handle,
> +                                                       uint8_t *properties,
> +                                                       bt_uuid_t *uuid)
> +{
> +       if (!attrib)
> +               return false;
> +
> +       if (bt_uuid_cmp(&characteristic_uuid, &attrib->uuid))
> +               return false;
> +
> +       /*
> +        * Characteristic declaration value:
> +        * 1 octet: Characteristic properties
> +        * 2 octets: Characteristic value handle
> +        * 2 or 16 octets: characteristic UUID
> +        */
> +       if (!attrib->value || (attrib->value_len != 5 &&
> +                                               attrib->value_len != 19))
> +               return false;
> +
> +       if (handle)
> +               *handle = attrib->handle;
> +
> +       if (properties)
> +               *properties = attrib->value[0];
> +
> +       if (value_handle)
> +               *value_handle = get_le16(attrib->value + 1);
> +
> +       if (!uuid)
> +               return true;
> +
> +       return le_to_uuid(attrib->value + 3, attrib->value_len - 3, uuid);
> +}
> +
> +bool gatt_db_attribute_get_include_data(struct gatt_db_attribute *attrib,
> +                                                       uint16_t *handle,
> +                                                       uint16_t *start_handle,
> +                                                       uint16_t *end_handle)
> +{
> +       if (!attrib)
> +               return false;
> +
> +       if (bt_uuid_cmp(&included_service_uuid, &attrib->uuid))
> +               return false;
> +
> +       /*
> +        * Include definition value:
> +        * 2 octets: start handle of included service
> +        * 2 octets: end handle of included service
> +        * optional 2 octets: 16-bit Bluetooth UUID
> +        */
> +       if (!attrib->value || attrib->value_len < 4 || attrib->value_len > 6)
> +               return false;
> +
> +       /*
> +        * We only return the handles since the UUID can be easily obtained
> +        * from the corresponding attribute.
> +        */
> +       if (handle)
> +               *handle = attrib->handle;
> +
> +       if (start_handle)
> +               *start_handle = get_le16(attrib->value);
> +
> +       if (end_handle)
> +               *end_handle = get_le16(attrib->value + 2);
> +
> +       return true;
> +}

These Im fine

>  bool gatt_db_attribute_get_permissions(struct gatt_db_attribute *attrib,
>                                                         uint32_t *permissions)
>  {
> diff --git a/src/shared/gatt-db.h b/src/shared/gatt-db.h
> index 9c71814..73bb8d9 100644
> --- a/src/shared/gatt-db.h
> +++ b/src/shared/gatt-db.h
> @@ -89,6 +89,26 @@ void gatt_db_find_information(struct gatt_db *db, uint16_t start_handle,
>                                                         struct queue *queue);
>
>
> +typedef void (*gatt_db_foreach_t)(struct gatt_db_attribute *attrib,
> +                                                       void *user_data);
> +void gatt_db_foreach_service(struct gatt_db *db, gatt_db_foreach_t func,
> +                                                       void *user_data);
> +void gatt_db_foreach_service_in_range(struct gatt_db *db,
> +                                                       gatt_db_foreach_t func,
> +                                                       void *user_data,
> +                                                       uint16_t start_handle,
> +                                                       uint16_t end_handle);
> +void gatt_db_attribute_foreach_charac(struct gatt_db_attribute *attrib,
> +                                                       gatt_db_foreach_t func,
> +                                                       void *user_data);
> +void gatt_db_attribute_foreach_descr(struct gatt_db_attribute *attrib,
> +                                                       gatt_db_foreach_t func,
> +                                                       void *user_data);
> +void gatt_db_attribute_foreach_incl(struct gatt_db_attribute *attrib,
> +                                                       gatt_db_foreach_t func,
> +                                                       void *user_data);
> +
> +
>  struct gatt_db_attribute *gatt_db_get_attribute(struct gatt_db *db,
>                                                         uint16_t handle);
>
> @@ -103,6 +123,23 @@ bool gatt_db_attribute_get_service_handles(struct gatt_db_attribute *attrib,
>                                                 uint16_t *start_handle,
>                                                 uint16_t *end_handle);
>
> +bool gatt_db_attribute_get_service_data(struct gatt_db_attribute *attrib,
> +                                                       uint16_t *start_handle,
> +                                                       uint16_t *end_handle,
> +                                                       bool *primary,
> +                                                       bt_uuid_t *uuid);
> +
> +bool gatt_db_attribute_get_characteristic_data(struct gatt_db_attribute *attrib,
> +                                                       uint16_t *handle,
> +                                                       uint16_t *value_handle,
> +                                                       uint8_t *properties,
> +                                                       bt_uuid_t *uuid);
> +
> +bool gatt_db_attribute_get_include_data(struct gatt_db_attribute *attrib,
> +                                                       uint16_t *handle,
> +                                                       uint16_t *start_handle,
> +                                                       uint16_t *end_handle);
> +
>  bool gatt_db_attribute_get_permissions(struct gatt_db_attribute *attrib,
>                                                         uint32_t *permissions);
>
> --
> 2.2.0.rc0.207.ga3a616c
>
> --
> To unsubscribe from this list: send the line "unsubscribe linux-bluetooth" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html



-- 
Luiz Augusto von Dentz
