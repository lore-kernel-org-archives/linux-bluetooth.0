Return-Path: <cyrus@holtmann.org>
MIME-Version: 1.0
In-Reply-To: <CABBYNZ+jVSGXYNwyZ687N0SFhdgVXbYDJTZp4mjVDzutuirPKQ@mail.gmail.com>
References: <1416878384-18148-1-git-send-email-armansito@chromium.org>
	<CABBYNZ+jVSGXYNwyZ687N0SFhdgVXbYDJTZp4mjVDzutuirPKQ@mail.gmail.com>
Date: Tue, 25 Nov 2014 09:48:26 -0800
Message-ID: <CAHrH25Tsh-2yd=NV5526f_=5R5zpPLM-xLPmQk-45c+nRj6Q=Q@mail.gmail.com>
Subject: Re: [RFC BlueZ] shared/gatt-db: Add high-level functions for client
From: Arman Uguray <armansito@chromium.org>
To: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Cc: "linux-bluetooth@vger.kernel.org" <linux-bluetooth@vger.kernel.org>
Content-Type: text/plain; charset=UTF-8
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Luiz,

> On Tue, Nov 25, 2014 at 8:22 AM, Luiz Augusto von Dentz <luiz.dentz@gmail.com> wrote:
> Hi Arman,
>
> On Tue, Nov 25, 2014 at 3:19 AM, Arman Uguray <armansito@chromium.org> wrote:
>> This patch introduces foreach functions to gatt-db for enumerating
>> service, characteristic, and decriptors stored in the database as
>> gatt_db_attribute pointers. This patch also adds functions for
>> extracting service, characteristic, and include declaration data out of
>> matching attributes.
>>
>> This is in preparation for using gatt-db as the attribute cache in
>> shared/gatt-client.
>> ---
>
> At first glance it looked good but then I started thinking about it,
> these would be called once bt_gatt_client ready callback is called but
> what if we have callbacks for when an attribute is added/removed, at
> the first time bt_gatt_client will cause every single attribute to be
> notified since they are being added but then the next time it will
> just notify if anything has changed so we don't need to reiterate in
> every attribute.
>

What is your exact concern, that these will be invoked too many times
unnecessarily? As you said, we can have some general events when
attributes are added/removed though for client a service added/removed
would make more sense and at the time the service added event happens
all of its attributes would have been inserted in the db. Either way I
think it's useful to have these foreach functions. for instance, even
with added/removed events the d-bus api implementation will need to
enumerate all of the affected attributes to register/unregister
objects. They will also be useful from within gatt-client during
discovery.

So I don't see any harm in having these. If they prove to be not that
useful we can remove them eventually and these should at least get us
going. Also, for services we could also add a foreach with match
functions to allow iterating through say services within a certain
handle range or those matching a certain UUID and so on. This way when
the bt_gatt_client_service_changed callback gets called, the upper
layer would only look through the services within the affected range.

>>  src/shared/gatt-db.c | 219 +++++++++++++++++++++++++++++++++++++++++++++++++++
>>  src/shared/gatt-db.h |  32 ++++++++
>>  2 files changed, 251 insertions(+)
>>
>> diff --git a/src/shared/gatt-db.c b/src/shared/gatt-db.c
>> index ab08c69..9bf06f6 100644
>> --- a/src/shared/gatt-db.c
>> +++ b/src/shared/gatt-db.c
>> @@ -193,6 +193,29 @@ static int uuid_to_le(const bt_uuid_t *uuid, uint8_t *dst)
>>         return bt_uuid_len(&uuid128);
>>  }
>>
>> +static bool le_to_uuid(const uint8_t *src, size_t len, bt_uuid_t *uuid)
>> +{
>> +       uint128_t u128;
>> +
>> +       if (len == 2) {
>> +               bt_uuid16_create(uuid, get_le16(src));
>> +               return true;
>> +       }
>> +
>> +       if (len == 4) {
>> +               bt_uuid32_create(uuid, get_le32(src));
>> +               return true;
>> +       }
>> +
>> +       if (len != 16)
>> +               return false;
>> +
>> +       bswap_128(src, &u128);
>> +       bt_uuid128_create(uuid, u128);
>> +
>> +       return true;
>> +}
>> +
>>  struct gatt_db_attribute *gatt_db_add_service(struct gatt_db *db,
>>                                                 const bt_uuid_t *uuid,
>>                                                 bool primary,
>> @@ -665,6 +688,116 @@ void gatt_db_find_information(struct gatt_db *db, uint16_t start_handle,
>>         queue_foreach(db->services, find_information, &data);
>>  }
>>
>> +struct foreach_data {
>> +       gatt_db_foreach_t func;
>> +       void *user_data;
>> +};
>> +
>> +static void foreach_service(void *data, void *user_data)
>> +{
>> +       struct gatt_db_service *service = data;
>> +       struct foreach_data *foreach_data = user_data;
>> +
>> +       foreach_data->func(service->attributes[0], foreach_data->user_data);
>> +}
>> +
>> +void gatt_db_foreach_service(struct gatt_db *db, gatt_db_foreach_t func,
>> +                                                       void *user_data)
>> +{
>> +       struct foreach_data data;
>> +
>> +       if (!db || !func)
>> +               return;
>> +
>> +       data.func = func;
>> +       data.user_data = user_data;
>> +
>> +       queue_foreach(db->services, foreach_service, &data);
>> +}
>> +
>> +void gatt_db_attribute_foreach_charac(struct gatt_db_attribute *attrib,
>> +                                                       gatt_db_foreach_t func,
>> +                                                       void *user_data)
>> +{
>> +       struct gatt_db_service *service;
>> +       struct gatt_db_attribute *attr;
>> +       uint16_t i;
>> +
>> +       if (!attrib || !func)
>> +               return;
>> +
>> +       service = attrib->service;
>> +
>> +       for (i = 0; i < service->num_handles; i++) {
>> +               attr = service->attributes[i];
>> +               if (!attr)
>> +                       continue;
>> +
>> +               if (bt_uuid_cmp(&characteristic_uuid, &attr->uuid))
>> +                       continue;
>> +
>> +               func(attr, user_data);
>> +       }
>> +}
>> +
>> +void gatt_db_attribute_foreach_descr(struct gatt_db_attribute *attrib,
>> +                                                       gatt_db_foreach_t func,
>> +                                                       void *user_data)
>> +{
>> +       struct gatt_db_service *service;
>> +       struct gatt_db_attribute *attr;
>> +       uint16_t i;
>> +
>> +       if (!attrib || !func)
>> +               return;
>> +
>> +       /* Return if this attribute is not a characteristic declaration */
>> +       if (bt_uuid_cmp(&characteristic_uuid, &attrib->uuid))
>> +               return;
>> +
>> +       service = attrib->service;
>> +
>> +       /* Start from the attribute following the value handle */
>> +       i = attrib->handle - service->attributes[0]->handle + 2;
>> +       for (; i < service->num_handles; i++) {
>> +               attr = service->attributes[i];
>> +               if (!attr)
>> +                       continue;
>> +
>> +               /* Return if we reached the end of this characteristic */
>> +               if (!bt_uuid_cmp(&characteristic_uuid, &attr->uuid) ||
>> +                       !bt_uuid_cmp(&included_service_uuid, &attr->uuid))
>> +                       return;
>> +
>> +               func(attr, user_data);
>> +       }
>> +}
>> +
>> +void gatt_db_attribute_foreach_incl(struct gatt_db_attribute *attrib,
>> +                                                       gatt_db_foreach_t func,
>> +                                                       void *user_data)
>> +{
>> +       struct gatt_db_service *service;
>> +       struct gatt_db_attribute *attr;
>> +       uint16_t i;
>> +
>> +       if (!attrib || !func)
>> +               return;
>> +
>> +       service = attrib->service;
>> +
>> +       for (i = 0; i < service->num_handles; i++) {
>> +               attr = service->attributes[i];
>> +               if (!attr)
>> +                       continue;
>> +
>> +               if (bt_uuid_cmp(&included_service_uuid, &attr->uuid))
>> +                       continue;
>> +
>> +               func(attr, user_data);
>> +       }
>> +}
>> +
>>  static bool find_service_for_handle(const void *data, const void *user_data)
>>  {
>>         const struct gatt_db_service *service = data;
>> @@ -769,6 +902,92 @@ bool gatt_db_attribute_get_service_handles(struct gatt_db_attribute *attrib,
>>         return true;
>>  }
>>
>> +bool gatt_db_attribute_get_service_data(struct gatt_db_attribute *attrib,
>> +                                                       uint16_t *start_handle,
>> +                                                       uint16_t *end_handle,
>> +                                                       bool *primary,
>> +                                                       bt_uuid_t *uuid)
>> +{
>> +       struct gatt_db_service *service;
>> +       struct gatt_db_attribute *decl;
>> +
>> +       if (!attrib || !start_handle || !end_handle || !primary || !uuid)
>> +               return false;
>> +
>> +       service = attrib->service;
>> +       decl = service->attributes[0];
>> +
>> +       *start_handle = decl->handle;
>> +       *end_handle = decl->handle + service->num_handles - 1;
>> +       *primary = bt_uuid_cmp(&decl->uuid, &secondary_service_uuid);
>> +
>> +       /*
>> +        * The service declaration attribute value is the 16 or 128 bit service
>> +        * UUID.
>> +        */
>> +       return le_to_uuid(decl->value, decl->value_len, uuid);
>> +}
>> +
>> +bool gatt_db_attribute_get_characteristic_data(struct gatt_db_attribute *attrib,
>> +                                                       uint16_t *handle,
>> +                                                       uint16_t *value_handle,
>> +                                                       uint8_t *properties,
>> +                                                       bt_uuid_t *uuid)
>> +{
>> +       if (!attrib || !handle || !value_handle || !properties || !uuid)
>> +               return false;
>> +
>> +       if (bt_uuid_cmp(&characteristic_uuid, &attrib->uuid))
>> +               return false;
>> +
>> +       /*
>> +        * Characteristic declaration value:
>> +        * 1 octet: Characteristic properties
>> +        * 2 octets: Characteristic value handle
>> +        * 2 or 16 octets: characteristic UUID
>> +        */
>> +       if (!attrib->value || (attrib->value_len != 5 &&
>> +                                               attrib->value_len != 19))
>> +               return false;
>> +
>> +       *handle = attrib->handle;
>> +       *properties = attrib->value[0];
>> +       *value_handle = get_le16(attrib->value + 1);
>> +
>> +       return le_to_uuid(attrib->value + 3, attrib->value_len - 3, uuid);
>> +}
>> +
>> +bool gatt_db_attribute_get_include_data(struct gatt_db_attribute *attrib,
>> +                                                       uint16_t *handle,
>> +                                                       uint16_t *start_handle,
>> +                                                       uint16_t *end_handle)
>> +{
>> +       if (!attrib || !handle || !start_handle || !end_handle)
>> +               return false;
>> +
>> +       if (bt_uuid_cmp(&included_service_uuid, &attrib->uuid))
>> +               return false;
>> +
>> +       /*
>> +        * Include definition value:
>> +        * 2 octets: start handle of included service
>> +        * 2 octets: end handle of included service
>> +        * optional 2 octets: 16-bit Bluetooth UUID
>> +        */
>> +       if (!attrib->value || attrib->value_len < 4 || attrib->value_len > 6)
>> +               return false;
>> +
>> +       /*
>> +        * We only return the handles since the UUID can be easily obtained
>> +        * from the corresponding attribute.
>> +        */
>> +       *handle = attrib->handle;
>> +       *start_handle = get_le16(attrib->value);
>> +       *end_handle = get_le16(attrib->value + 2);
>> +
>> +       return true;
>> +}
>> +
>>  bool gatt_db_attribute_get_permissions(struct gatt_db_attribute *attrib,
>>                                                         uint32_t *permissions)
>>  {
>> diff --git a/src/shared/gatt-db.h b/src/shared/gatt-db.h
>> index 9c71814..a87d7f9 100644
>> --- a/src/shared/gatt-db.h
>> +++ b/src/shared/gatt-db.h
>> @@ -89,6 +89,21 @@ void gatt_db_find_information(struct gatt_db *db, uint16_t start_handle,
>>                                                         struct queue *queue);
>>
>>
>> +typedef void (*gatt_db_foreach_t)(struct gatt_db_attribute *attrib,
>> +                                                       void *user_data);
>> +void gatt_db_foreach_service(struct gatt_db *db, gatt_db_foreach_t func,
>> +                                                       void *user_data);
>> +void gatt_db_attribute_foreach_charac(struct gatt_db_attribute *attrib,
>> +                                                       gatt_db_foreach_t func,
>> +                                                       void *user_data);
>> +void gatt_db_attribute_foreach_descr(struct gatt_db_attribute *attrib,
>> +                                                       gatt_db_foreach_t func,
>> +                                                       void *user_data);
>> +void gatt_db_attribute_foreach_incl(struct gatt_db_attribute *attrib,
>> +                                                       gatt_db_foreach_t func,
>> +                                                       void *user_data);
>> +
>> +
>>  struct gatt_db_attribute *gatt_db_get_attribute(struct gatt_db *db,
>>                                                         uint16_t handle);
>>
>> @@ -103,6 +118,23 @@ bool gatt_db_attribute_get_service_handles(struct gatt_db_attribute *attrib,
>>                                                 uint16_t *start_handle,
>>                                                 uint16_t *end_handle);
>>
>> +bool gatt_db_attribute_get_service_data(struct gatt_db_attribute *attrib,
>> +                                                       uint16_t *start_handle,
>> +                                                       uint16_t *end_handle,
>> +                                                       bool *primary,
>> +                                                       bt_uuid_t *uuid);
>> +
>> +bool gatt_db_attribute_get_characteristic_data(struct gatt_db_attribute *attrib,
>> +                                                       uint16_t *handle,
>> +                                                       uint16_t *value_handle,
>> +                                                       uint8_t *properties,
>> +                                                       bt_uuid_t *uuid);
>> +
>> +bool gatt_db_attribute_get_include_data(struct gatt_db_attribute *attrib,
>> +                                                       uint16_t *handle,
>> +                                                       uint16_t *start_handle,
>> +                                                       uint16_t *end_handle);
>
> This seems useful either way so I think we should start with these first.
>
>>  bool gatt_db_attribute_get_permissions(struct gatt_db_attribute *attrib,
>>                                                         uint32_t *permissions);
>>
>> --
>> 2.1.0.rc2.206.gedb03e5
>>
>> --
>> To unsubscribe from this list: send the line "unsubscribe linux-bluetooth" in
>> the body of a message to majordomo@vger.kernel.org
>> More majordomo info at  http://vger.kernel.org/majordomo-info.html
>
>
>
> --
> Luiz Augusto von Dentz
> --
> To unsubscribe from this list: send the line "unsubscribe linux-bluetooth" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html

Arman
