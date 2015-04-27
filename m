Return-Path: <cyrus@holtmann.org>
MIME-Version: 1.0
In-Reply-To: <1430140475-20349-7-git-send-email-luiz.dentz@gmail.com>
References: <1430140475-20349-1-git-send-email-luiz.dentz@gmail.com>
	<1430140475-20349-7-git-send-email-luiz.dentz@gmail.com>
Date: Mon, 27 Apr 2015 13:17:36 -0700
Message-ID: <CAHrH25QuAeXzu5EAjmm_aAn8UL8XSiULT7xBpFPJqRoP-2jLwA@mail.gmail.com>
Subject: Re: [PATCH BlueZ 6/8] shared/gatt: Drop CHRC term of properties define
From: Arman Uguray <armansito@chromium.org>
To: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Cc: BlueZ development <linux-bluetooth@vger.kernel.org>
Content-Type: text/plain; charset=UTF-8
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Luiz,

> On Mon, Apr 27, 2015 at 6:14 AM, Luiz Augusto von Dentz <luiz.dentz@gmail.com> wrote:
> From: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>
>
> Some of the properties will be reused by descriptors.

This patch doesn't make sense to me. Descriptors shouldn't reuse any
of these properties as they are defined by the CS to be characteristic
specific. Descriptors don't have such "properties" definitions.

> ---
>  src/gatt-client.c        |  32 +++++------
>  src/gatt-database.c      |  80 +++++++++++++-------------
>  src/shared/att-types.h   |  36 ++++++------
>  src/shared/gatt-client.c |   4 +-
>  tools/btgatt-server.c    |  14 ++---
>  unit/test-gatt.c         | 146 +++++++++++++++++++++++------------------------
>  6 files changed, 156 insertions(+), 156 deletions(-)
>
> diff --git a/src/gatt-client.c b/src/gatt-client.c
> index 2e26ed7..efb046b 100644
> --- a/src/gatt-client.c
> +++ b/src/gatt-client.c
> @@ -728,20 +728,20 @@ struct chrc_prop_data {
>
>  static struct chrc_prop_data chrc_props[] = {
>         /* Default Properties */
> -       { BT_GATT_CHRC_PROP_BROADCAST,          "broadcast" },
> -       { BT_GATT_CHRC_PROP_READ,               "read" },
> -       { BT_GATT_CHRC_PROP_WRITE_WITHOUT_RESP, "write-without-response" },
> -       { BT_GATT_CHRC_PROP_WRITE,              "write" },
> -       { BT_GATT_CHRC_PROP_NOTIFY,             "notify" },
> -       { BT_GATT_CHRC_PROP_INDICATE,           "indicate" },
> -       { BT_GATT_CHRC_PROP_AUTH,               "authenticated-signed-writes" },
> -       { BT_GATT_CHRC_PROP_EXT_PROP,           "extended-properties" }
> +       { BT_GATT_PROP_BROADCAST,               "broadcast" },
> +       { BT_GATT_PROP_READ,                    "read" },
> +       { BT_GATT_PROP_WRITE_WITHOUT_RESP,      "write-without-response" },
> +       { BT_GATT_PROP_WRITE,                   "write" },
> +       { BT_GATT_PROP_NOTIFY,                  "notify" },
> +       { BT_GATT_PROP_INDICATE,                "indicate" },
> +       { BT_GATT_PROP_AUTH,                    "authenticated-signed-writes" },
> +       { BT_GATT_PROP_EXT_PROP,                "extended-properties" }
>  };
>
>  static struct chrc_prop_data chrc_ext_props[] = {
>         /* Extended Properties */
> -       { BT_GATT_CHRC_EXT_PROP_RELIABLE_WRITE, "reliable-write" },
> -       { BT_GATT_CHRC_EXT_PROP_WRITABLE_AUX,   "writable-auxiliaries" }
> +       { BT_GATT_EXT_PROP_RELIABLE_WRITE,      "reliable-write" },
> +       { BT_GATT_EXT_PROP_WRITABLE_AUX,        "writable-auxiliaries" }
>  };
>
>  static gboolean characteristic_get_flags(const GDBusPropertyTable *property,
> @@ -910,7 +910,7 @@ static DBusMessage *characteristic_write_value(DBusConnection *conn,
>          *     - If value is larger than MTU - 3: long-write
>          *   * "write-without-response" property set -> write command.
>          */
> -       if ((chrc->ext_props & BT_GATT_CHRC_EXT_PROP_RELIABLE_WRITE)) {
> +       if ((chrc->ext_props & BT_GATT_EXT_PROP_RELIABLE_WRITE)) {
>                 supported = true;
>                 chrc->write_id = start_long_write(msg, chrc->value_handle, gatt,
>                                                 true, value, value_len,
> @@ -919,7 +919,7 @@ static DBusMessage *characteristic_write_value(DBusConnection *conn,
>                         return NULL;
>         }
>
> -       if (chrc->props & BT_GATT_CHRC_PROP_WRITE) {
> +       if (chrc->props & BT_GATT_PROP_WRITE) {
>                 uint16_t mtu;
>
>                 supported = true;
> @@ -942,13 +942,13 @@ static DBusMessage *characteristic_write_value(DBusConnection *conn,
>                         return NULL;
>         }
>
> -       if (!(chrc->props & BT_GATT_CHRC_PROP_WRITE_WITHOUT_RESP))
> +       if (!(chrc->props & BT_GATT_PROP_WRITE_WITHOUT_RESP))
>                 goto fail;
>
>         supported = true;
>         chrc->write_id = bt_gatt_client_write_without_response(gatt,
>                                         chrc->value_handle,
> -                                       chrc->props & BT_GATT_CHRC_PROP_AUTH,
> +                                       chrc->props & BT_GATT_PROP_AUTH,
>                                         value, value_len);
>         if (chrc->write_id)
>                 return dbus_message_new_method_return(msg);
> @@ -1152,8 +1152,8 @@ static DBusMessage *characteristic_start_notify(DBusConnection *conn,
>         struct async_dbus_op *op;
>         struct notify_client *client;
>
> -       if (!(chrc->props & BT_GATT_CHRC_PROP_NOTIFY ||
> -                               chrc->props & BT_GATT_CHRC_PROP_INDICATE))
> +       if (!(chrc->props & BT_GATT_PROP_NOTIFY ||
> +                               chrc->props & BT_GATT_PROP_INDICATE))
>                 return btd_error_not_supported(msg);
>
>         /* Each client can only have one active notify session. */
> diff --git a/src/gatt-database.c b/src/gatt-database.c
> index cf75b41..9397bff 100644
> --- a/src/gatt-database.c
> +++ b/src/gatt-database.c
> @@ -656,7 +656,7 @@ static void populate_gap_service(struct btd_gatt_database *database)
>          */
>         bt_uuid16_create(&uuid, GATT_CHARAC_DEVICE_NAME);
>         gatt_db_service_add_characteristic(service, &uuid, BT_ATT_PERM_READ,
> -                                                       BT_GATT_CHRC_PROP_READ,
> +                                                       BT_GATT_PROP_READ,
>                                                         gap_device_name_read_cb,
>                                                         NULL, database);
>
> @@ -665,7 +665,7 @@ static void populate_gap_service(struct btd_gatt_database *database)
>          */
>         bt_uuid16_create(&uuid, GATT_CHARAC_APPEARANCE);
>         gatt_db_service_add_characteristic(service, &uuid, BT_ATT_PERM_READ,
> -                                                       BT_GATT_CHRC_PROP_READ,
> +                                                       BT_GATT_PROP_READ,
>                                                         gap_appearance_read_cb,
>                                                         NULL, database);
>
> @@ -871,7 +871,7 @@ static void populate_gatt_service(struct btd_gatt_database *database)
>
>         bt_uuid16_create(&uuid, GATT_CHARAC_SERVICE_CHANGED);
>         database->svc_chngd = gatt_db_service_add_characteristic(service, &uuid,
> -                               BT_ATT_PERM_READ, BT_GATT_CHRC_PROP_INDICATE,
> +                               BT_ATT_PERM_READ, BT_GATT_PROP_INDICATE,
>                                 NULL, NULL, database);
>
>         database->svc_chngd_ccc = service_add_ccc(service, database, NULL, NULL,
> @@ -1224,35 +1224,35 @@ static bool parse_flags(GDBusProxy *proxy, uint8_t *props, uint8_t *ext_props)
>                 dbus_message_iter_get_basic(&array, &flag);
>
>                 if (!strcmp("broadcast", flag))
> -                       *props |= BT_GATT_CHRC_PROP_BROADCAST;
> +                       *props |= BT_GATT_PROP_BROADCAST;
>                 else if (!strcmp("read", flag))
> -                       *props |= BT_GATT_CHRC_PROP_READ;
> +                       *props |= BT_GATT_PROP_READ;
>                 else if (!strcmp("write-without-response", flag))
> -                       *props |= BT_GATT_CHRC_PROP_WRITE_WITHOUT_RESP;
> +                       *props |= BT_GATT_PROP_WRITE_WITHOUT_RESP;
>                 else if (!strcmp("write", flag))
> -                       *props |= BT_GATT_CHRC_PROP_WRITE;
> +                       *props |= BT_GATT_PROP_WRITE;
>                 else if (!strcmp("notify", flag))
> -                       *props |= BT_GATT_CHRC_PROP_NOTIFY;
> +                       *props |= BT_GATT_PROP_NOTIFY;
>                 else if (!strcmp("indicate", flag))
> -                       *props |= BT_GATT_CHRC_PROP_INDICATE;
> +                       *props |= BT_GATT_PROP_INDICATE;
>                 else if (!strcmp("authenticated-signed-writes", flag))
> -                       *props |= BT_GATT_CHRC_PROP_AUTH;
> +                       *props |= BT_GATT_PROP_AUTH;
>                 else if (!strcmp("reliable-write", flag))
> -                       *ext_props |= BT_GATT_CHRC_EXT_PROP_RELIABLE_WRITE;
> +                       *ext_props |= BT_GATT_EXT_PROP_RELIABLE_WRITE;
>                 else if (!strcmp("writable-auxiliaries", flag))
> -                       *ext_props |= BT_GATT_CHRC_EXT_PROP_WRITABLE_AUX;
> +                       *ext_props |= BT_GATT_EXT_PROP_WRITABLE_AUX;
>                 else if (!strcmp("encrypt-read", flag)) {
> -                       *props |= BT_GATT_CHRC_PROP_READ;
> -                       *ext_props |= BT_GATT_CHRC_EXT_PROP_ENC_READ;
> +                       *props |= BT_GATT_PROP_READ;
> +                       *ext_props |= BT_GATT_EXT_PROP_ENC_READ;
>                 } else if (!strcmp("encrypt-write", flag)) {
> -                       *props |= BT_GATT_CHRC_PROP_WRITE;
> -                       *ext_props |= BT_GATT_CHRC_EXT_PROP_ENC_WRITE;
> +                       *props |= BT_GATT_PROP_WRITE;
> +                       *ext_props |= BT_GATT_EXT_PROP_ENC_WRITE;
>                 } else if (!strcmp("encrypt-authenticated-read", flag)) {
> -                       *props |= BT_GATT_CHRC_PROP_READ;
> -                       *ext_props |= BT_GATT_CHRC_EXT_PROP_AUTH_READ;
> +                       *props |= BT_GATT_PROP_READ;
> +                       *ext_props |= BT_GATT_EXT_PROP_AUTH_READ;
>                 } else if (!strcmp("encrypt-authenticated-write", flag)) {
> -                       *props |= BT_GATT_CHRC_PROP_WRITE;
> -                       *ext_props |= BT_GATT_CHRC_EXT_PROP_AUTH_WRITE;
> +                       *props |= BT_GATT_PROP_WRITE;
> +                       *ext_props |= BT_GATT_EXT_PROP_AUTH_WRITE;
>                 } else {
>                         error("Invalid characteristic flag: %s", flag);
>                         return false;
> @@ -1260,7 +1260,7 @@ static bool parse_flags(GDBusProxy *proxy, uint8_t *props, uint8_t *ext_props)
>         } while (dbus_message_iter_next(&array));
>
>         if (*ext_props)
> -               *props |= BT_GATT_CHRC_PROP_EXT_PROP;
> +               *props |= BT_GATT_PROP_EXT_PROP;
>
>         return true;
>  }
> @@ -1337,8 +1337,8 @@ static void proxy_added_cb(GDBusProxy *proxy, void *user_data)
>                         return;
>                 }
>
> -               if ((chrc->props & BT_GATT_CHRC_PROP_NOTIFY ||
> -                               chrc->props & BT_GATT_CHRC_PROP_INDICATE) &&
> +               if ((chrc->props & BT_GATT_PROP_NOTIFY ||
> +                               chrc->props & BT_GATT_PROP_INDICATE) &&
>                                 !incr_attr_count(service, 1)) {
>                         error("Failed to increment attribute count for CCC");
>                         service->failed = true;
> @@ -1678,28 +1678,28 @@ static uint32_t permissions_from_props(uint8_t props, uint8_t ext_props)
>  {
>         uint32_t perm = 0;
>
> -       if (props & BT_GATT_CHRC_PROP_WRITE ||
> -                       props & BT_GATT_CHRC_PROP_WRITE_WITHOUT_RESP ||
> -                       ext_props & BT_GATT_CHRC_EXT_PROP_RELIABLE_WRITE ||
> -                       ext_props & BT_GATT_CHRC_EXT_PROP_ENC_WRITE ||
> -                       ext_props & BT_GATT_CHRC_EXT_PROP_AUTH_WRITE)
> +       if (props & BT_GATT_PROP_WRITE ||
> +                       props & BT_GATT_PROP_WRITE_WITHOUT_RESP ||
> +                       ext_props & BT_GATT_EXT_PROP_RELIABLE_WRITE ||
> +                       ext_props & BT_GATT_EXT_PROP_ENC_WRITE ||
> +                       ext_props & BT_GATT_EXT_PROP_AUTH_WRITE)
>                 perm |= BT_ATT_PERM_WRITE;
>
> -       if (props & BT_GATT_CHRC_PROP_READ ||
> -                       ext_props & BT_GATT_CHRC_EXT_PROP_ENC_READ ||
> -                       ext_props & BT_GATT_CHRC_EXT_PROP_AUTH_READ)
> +       if (props & BT_GATT_PROP_READ ||
> +                       ext_props & BT_GATT_EXT_PROP_ENC_READ ||
> +                       ext_props & BT_GATT_EXT_PROP_AUTH_READ)
>                 perm |= BT_ATT_PERM_READ;
>
> -       if (ext_props & BT_GATT_CHRC_EXT_PROP_ENC_READ)
> +       if (ext_props & BT_GATT_EXT_PROP_ENC_READ)
>                 perm |= BT_ATT_PERM_READ_ENCRYPT;
>
> -       if (ext_props & BT_GATT_CHRC_EXT_PROP_ENC_WRITE)
> +       if (ext_props & BT_GATT_EXT_PROP_ENC_WRITE)
>                 perm |= BT_ATT_PERM_WRITE_ENCRYPT;
>
> -       if (ext_props & BT_GATT_CHRC_EXT_PROP_AUTH_READ)
> +       if (ext_props & BT_GATT_EXT_PROP_AUTH_READ)
>                 perm |= BT_ATT_PERM_READ_AUTHEN;
>
> -       if (ext_props & BT_GATT_CHRC_EXT_PROP_AUTH_WRITE)
> +       if (ext_props & BT_GATT_EXT_PROP_AUTH_WRITE)
>                 perm |= BT_ATT_PERM_WRITE_AUTHEN;
>
>         return perm;
> @@ -1741,8 +1741,8 @@ static uint8_t ccc_write_cb(uint16_t value, void *user_data)
>
>         /* Don't support undefined CCC values yet */
>         if (value > 2 ||
> -               (value == 1 && !(chrc->props & BT_GATT_CHRC_PROP_NOTIFY)) ||
> -               (value == 2 && !(chrc->props & BT_GATT_CHRC_PROP_INDICATE)))
> +               (value == 1 && !(chrc->props & BT_GATT_PROP_NOTIFY)) ||
> +               (value == 2 && !(chrc->props & BT_GATT_PROP_INDICATE)))
>                 return BT_ATT_ERROR_REQUEST_NOT_SUPPORTED;
>
>         /*
> @@ -1791,14 +1791,14 @@ static void property_changed_cb(GDBusProxy *proxy, const char *name,
>                                 gatt_db_attribute_get_handle(chrc->attrib),
>                                 value, len,
>                                 gatt_db_attribute_get_handle(chrc->ccc),
> -                               chrc->props & BT_GATT_CHRC_PROP_INDICATE);
> +                               chrc->props & BT_GATT_PROP_INDICATE);
>  }
>
>  static bool database_add_ccc(struct external_service *service,
>                                                 struct external_chrc *chrc)
>  {
> -       if (!(chrc->props & BT_GATT_CHRC_PROP_NOTIFY) &&
> -                               !(chrc->props & BT_GATT_CHRC_PROP_INDICATE))
> +       if (!(chrc->props & BT_GATT_PROP_NOTIFY) &&
> +                               !(chrc->props & BT_GATT_PROP_INDICATE))
>                 return true;
>
>         chrc->ccc = service_add_ccc(service->attrib, service->database,
> diff --git a/src/shared/att-types.h b/src/shared/att-types.h
> index ee20992..85f6e2e 100644
> --- a/src/shared/att-types.h
> +++ b/src/shared/att-types.h
> @@ -125,23 +125,23 @@ struct bt_att_pdu_error_rsp {
>  #define BT_ATT_PERM_NONE               0x80
>
>  /* GATT Characteristic Properties Bitfield values */
> -#define BT_GATT_CHRC_PROP_BROADCAST                    0x01
> -#define BT_GATT_CHRC_PROP_READ                         0x02
> -#define BT_GATT_CHRC_PROP_WRITE_WITHOUT_RESP           0x04
> -#define BT_GATT_CHRC_PROP_WRITE                                0x08
> -#define BT_GATT_CHRC_PROP_NOTIFY                       0x10
> -#define BT_GATT_CHRC_PROP_INDICATE                     0x20
> -#define BT_GATT_CHRC_PROP_AUTH                         0x40
> -#define BT_GATT_CHRC_PROP_EXT_PROP                     0x80
> +#define BT_GATT_PROP_BROADCAST                 0x01
> +#define BT_GATT_PROP_READ                      0x02
> +#define BT_GATT_PROP_WRITE_WITHOUT_RESP                0x04
> +#define BT_GATT_PROP_WRITE                     0x08
> +#define BT_GATT_PROP_NOTIFY                    0x10
> +#define BT_GATT_PROP_INDICATE                  0x20
> +#define BT_GATT_PROP_AUTH                      0x40
> +#define BT_GATT_PROP_EXT_PROP                  0x80
>
>  /* GATT Characteristic Extended Properties Bitfield values */
> -#define BT_GATT_CHRC_EXT_PROP_RELIABLE_WRITE           0x01
> -#define BT_GATT_CHRC_EXT_PROP_WRITABLE_AUX             0x02
> -#define BT_GATT_CHRC_EXT_PROP_ENC_READ                 0x04
> -#define BT_GATT_CHRC_EXT_PROP_ENC_WRITE                        0x08
> -#define BT_GATT_CHRC_EXT_PROP_ENC      (BT_GATT_CHRC_EXT_PROP_ENC_READ | \
> -                                       BT_GATT_CHRC_EXT_PROP_ENC_WRITE)
> -#define BT_GATT_CHRC_EXT_PROP_AUTH_READ                        0x10
> -#define BT_GATT_CHRC_EXT_PROP_AUTH_WRITE               0x20
> -#define BT_GATT_CHRC_EXT_PROP_AUTH     (BT_GATT_CHRC_EXT_PROP_AUTH_READ | \
> -                                       BT_GATT_CHRC_EXT_PROP_AUTH_WRITE)
> +#define BT_GATT_EXT_PROP_RELIABLE_WRITE                0x01
> +#define BT_GATT_EXT_PROP_WRITABLE_AUX          0x02
> +#define BT_GATT_EXT_PROP_ENC_READ              0x04
> +#define BT_GATT_EXT_PROP_ENC_WRITE             0x08
> +#define BT_GATT_EXT_PROP_ENC                   (BT_GATT_EXT_PROP_ENC_READ | \
> +                                               BT_GATT_EXT_PROP_ENC_WRITE)
> +#define BT_GATT_EXT_PROP_AUTH_READ             0x10
> +#define BT_GATT_EXT_PROP_AUTH_WRITE            0x20
> +#define BT_GATT_EXT_PROP_AUTH                  (BT_GATT_EXT_PROP_AUTH_READ | \
> +                                               BT_GATT_EXT_PROP_AUTH_WRITE)
> diff --git a/src/shared/gatt-client.c b/src/shared/gatt-client.c
> index 7b628fe..af34ae9 100644
> --- a/src/shared/gatt-client.c
> +++ b/src/shared/gatt-client.c
> @@ -1392,10 +1392,10 @@ static bool notify_data_write_ccc(struct notify_data *notify_data, bool enable,
>                 /* Try to enable notifications and/or indications based on
>                  * whatever the characteristic supports.
>                  */
> -               if (notify_data->chrc->properties & BT_GATT_CHRC_PROP_NOTIFY)
> +               if (notify_data->chrc->properties & BT_GATT_PROP_NOTIFY)
>                         pdu[2] = 0x01;
>
> -               if (notify_data->chrc->properties & BT_GATT_CHRC_PROP_INDICATE)
> +               if (notify_data->chrc->properties & BT_GATT_PROP_INDICATE)
>                         pdu[2] |= 0x02;
>
>                 if (!pdu[2])
> diff --git a/tools/btgatt-server.c b/tools/btgatt-server.c
> index b30a958..b5f433e 100644
> --- a/tools/btgatt-server.c
> +++ b/tools/btgatt-server.c
> @@ -204,7 +204,7 @@ static void gap_device_name_ext_prop_read_cb(struct gatt_db_attribute *attrib,
>
>         PRLOG("Device Name Extended Properties Read called\n");
>
> -       value[0] = BT_GATT_CHRC_EXT_PROP_RELIABLE_WRITE;
> +       value[0] = BT_GATT_EXT_PROP_RELIABLE_WRITE;
>         value[1] = 0;
>
>         gatt_db_attribute_read_result(attrib, id, 0, value, sizeof(value));
> @@ -419,7 +419,7 @@ static void populate_gap_service(struct server *server)
>         bt_uuid16_create(&uuid, GATT_CHARAC_DEVICE_NAME);
>         gatt_db_service_add_characteristic(service, &uuid,
>                                         BT_ATT_PERM_READ | BT_ATT_PERM_WRITE,
> -                                       BT_GATT_CHRC_PROP_READ,
> +                                       BT_GATT_PROP_READ,
>                                         gap_device_name_read_cb,
>                                         gap_device_name_write_cb,
>                                         server);
> @@ -436,7 +436,7 @@ static void populate_gap_service(struct server *server)
>         bt_uuid16_create(&uuid, GATT_CHARAC_APPEARANCE);
>         tmp = gatt_db_service_add_characteristic(service, &uuid,
>                                                         BT_ATT_PERM_READ,
> -                                                       BT_GATT_CHRC_PROP_READ,
> +                                                       BT_GATT_PROP_READ,
>                                                         NULL, NULL, server);
>
>         /*
> @@ -465,7 +465,7 @@ static void populate_gatt_service(struct server *server)
>         bt_uuid16_create(&uuid, GATT_CHARAC_SERVICE_CHANGED);
>         svc_chngd = gatt_db_service_add_characteristic(service, &uuid,
>                         BT_ATT_PERM_READ,
> -                       BT_GATT_CHRC_PROP_READ | BT_GATT_CHRC_PROP_INDICATE,
> +                       BT_GATT_PROP_READ | BT_GATT_PROP_INDICATE,
>                         gatt_service_changed_cb,
>                         NULL, server);
>         server->gatt_svc_chngd_handle = gatt_db_attribute_get_handle(svc_chngd);
> @@ -494,7 +494,7 @@ static void populate_hr_service(struct server *server)
>         bt_uuid16_create(&uuid, UUID_HEART_RATE_MSRMT);
>         hr_msrmt = gatt_db_service_add_characteristic(service, &uuid,
>                                                 BT_ATT_PERM_NONE,
> -                                               BT_GATT_CHRC_PROP_NOTIFY,
> +                                               BT_GATT_PROP_NOTIFY,
>                                                 NULL, NULL, NULL);
>         server->hr_msrmt_handle = gatt_db_attribute_get_handle(hr_msrmt);
>
> @@ -511,7 +511,7 @@ static void populate_hr_service(struct server *server)
>         bt_uuid16_create(&uuid, UUID_HEART_RATE_BODY);
>         body = gatt_db_service_add_characteristic(service, &uuid,
>                                                 BT_ATT_PERM_READ,
> -                                               BT_GATT_CHRC_PROP_READ,
> +                                               BT_GATT_PROP_READ,
>                                                 NULL, NULL, server);
>         gatt_db_attribute_write(body, 0, (void *) &body_loc, sizeof(body_loc),
>                                                         BT_ATT_OP_WRITE_REQ,
> @@ -522,7 +522,7 @@ static void populate_hr_service(struct server *server)
>         bt_uuid16_create(&uuid, UUID_HEART_RATE_CTRL);
>         gatt_db_service_add_characteristic(service, &uuid,
>                                                 BT_ATT_PERM_WRITE,
> -                                               BT_GATT_CHRC_PROP_WRITE,
> +                                               BT_GATT_PROP_WRITE,
>                                                 NULL, hr_control_point_write_cb,
>                                                 server);
>
> diff --git a/unit/test-gatt.c b/unit/test-gatt.c
> index caaacbd..21ae6fc 100644
> --- a/unit/test-gatt.c
> +++ b/unit/test-gatt.c
> @@ -1414,14 +1414,14 @@ static struct gatt_db *make_service_data_1_db(void)
>         const struct att_handle_spec specs[] = {
>                 PRIMARY_SERVICE(0x0001, GATT_UUID, 4),
>                 CHARACTERISTIC_STR(GATT_CHARAC_DEVICE_NAME, BT_ATT_PERM_READ,
> -                                       BT_GATT_CHRC_PROP_READ, "BlueZ"),
> +                                       BT_GATT_PROP_READ, "BlueZ"),
>                 DESCRIPTOR_STR(GATT_CHARAC_USER_DESC_UUID, BT_ATT_PERM_READ,
>                                                                 "Device Name"),
>                 PRIMARY_SERVICE(0x0005, HEART_RATE_UUID, 4),
>                 CHARACTERISTIC_STR(GATT_CHARAC_MANUFACTURER_NAME_STRING,
>                                                 BT_ATT_PERM_READ,
> -                                               BT_GATT_CHRC_PROP_READ |
> -                                               BT_GATT_CHRC_PROP_WRITE, ""),
> +                                               BT_GATT_PROP_READ |
> +                                               BT_GATT_PROP_WRITE, ""),
>                 DESCRIPTOR_STR(GATT_CHARAC_USER_DESC_UUID, BT_ATT_PERM_READ,
>                                                         "Manufacturer Name"),
>                 { }
> @@ -1459,15 +1459,15 @@ static struct gatt_db *make_service_data_2_db(void)
>         const struct att_handle_spec specs[] = {
>                 PRIMARY_SERVICE(0x0001, GATT_UUID, 4),
>                 CHARACTERISTIC_STR(GATT_CHARAC_DEVICE_NAME, BT_ATT_PERM_READ,
> -                                       BT_GATT_CHRC_PROP_READ, "BlueZ"),
> +                                       BT_GATT_PROP_READ, "BlueZ"),
>                 DESCRIPTOR_STR(GATT_CHARAC_USER_DESC_UUID, BT_ATT_PERM_READ,
>                                                                 "Device Name"),
>                 PRIMARY_SERVICE(0x0005, HEART_RATE_UUID, 6),
>                 CHARACTERISTIC_STR_AT(0x0008,
>                                         GATT_CHARAC_MANUFACTURER_NAME_STRING,
>                                         BT_ATT_PERM_READ,
> -                                       BT_GATT_CHRC_PROP_READ |
> -                                       BT_GATT_CHRC_PROP_WRITE, ""),
> +                                       BT_GATT_PROP_READ |
> +                                       BT_GATT_PROP_WRITE, ""),
>                 DESCRIPTOR_STR_AT(0x000a, GATT_CHARAC_USER_DESC_UUID,
>                                         BT_ATT_PERM_READ, "Manufacturer Name"),
>                 { }
> @@ -1506,17 +1506,17 @@ static struct gatt_db *make_service_data_3_db(void)
>                 PRIMARY_SERVICE(0x0100, GAP_UUID, 0x0121 - 0x0100 + 1),
>                 CHARACTERISTIC_STR_AT(0x0111, GATT_CHARAC_DEVICE_NAME,
>                                         BT_ATT_PERM_READ,
> -                                       BT_GATT_CHRC_PROP_READ, "BlueZ"),
> +                                       BT_GATT_PROP_READ, "BlueZ"),
>                 CHARACTERISTIC_AT(0x0121, GATT_CHARAC_APPEARANCE,
>                                         BT_ATT_PERM_READ,
> -                                       BT_GATT_CHRC_PROP_READ, 0x00, 0x00),
> +                                       BT_GATT_PROP_READ, 0x00, 0x00),
>                 PRIMARY_SERVICE(0x0200, GATT_UUID, 0x0200 - 0x0200 + 1),
>                 PRIMARY_SERVICE(0x0300, HEART_RATE_UUID, 0x0320 - 0x0300 + 1),
>                 CHARACTERISTIC_STR_AT(0x0311,
>                                         GATT_CHARAC_MANUFACTURER_NAME_STRING,
>                                         BT_ATT_PERM_READ,
> -                                       BT_GATT_CHRC_PROP_READ |
> -                                       BT_GATT_CHRC_PROP_WRITE, ""),
> +                                       BT_GATT_PROP_READ |
> +                                       BT_GATT_PROP_WRITE, ""),
>                 DESCRIPTOR_AT(0x0320, GATT_CLIENT_CHARAC_CFG_UUID,
>                                         BT_ATT_PERM_READ | BT_ATT_PERM_WRITE,
>                                         0x00, 0x00),
> @@ -1548,9 +1548,9 @@ static struct gatt_db *make_test_spec_small_db(void)
>                 CHARACTERISTIC_STR(GATT_CHARAC_MANUFACTURER_NAME_STRING,
>                                                 BT_ATT_PERM_READ |
>                                                 BT_ATT_PERM_WRITE,
> -                                               BT_GATT_CHRC_PROP_READ |
> -                                               BT_GATT_CHRC_PROP_NOTIFY |
> -                                               BT_GATT_CHRC_PROP_INDICATE,
> +                                               BT_GATT_PROP_READ |
> +                                               BT_GATT_PROP_NOTIFY |
> +                                               BT_GATT_PROP_INDICATE,
>                                                 "BlueZ"),
>                 DESCRIPTOR(GATT_CLIENT_CHARAC_CFG_UUID, BT_ATT_PERM_READ |
>                                                 BT_ATT_PERM_WRITE, 0x00, 0x00),
> @@ -1559,13 +1559,13 @@ static struct gatt_db *make_test_spec_small_db(void)
>                 PRIMARY_SERVICE(0xF010, GAP_UUID, 8),
>                 INCLUDE(0x0001),
>                 CHARACTERISTIC_STR(GATT_CHARAC_DEVICE_NAME, BT_ATT_PERM_READ,
> -                                                       BT_GATT_CHRC_PROP_READ,
> +                                                       BT_GATT_PROP_READ,
>                                                         "BlueZ Unit Tester"),
>                 CHARACTERISTIC(0000B009-0000-0000-0123-456789abcdef,
>                                         BT_ATT_PERM_READ | BT_ATT_PERM_WRITE,
> -                                       BT_GATT_CHRC_PROP_READ, 0x09),
> +                                       BT_GATT_PROP_READ, 0x09),
>                 CHARACTERISTIC(GATT_CHARAC_APPEARANCE, BT_ATT_PERM_READ,
> -                                       BT_GATT_CHRC_PROP_READ, 0x00, 0x00),
> +                                       BT_GATT_PROP_READ, 0x00, 0x00),
>                 PRIMARY_SERVICE(0xFFFF, DEVICE_INFORMATION_UUID, 1),
>                 { }
>         };
> @@ -1605,8 +1605,8 @@ static struct gatt_db *make_test_spec_large_db_1(void)
>         const struct att_handle_spec specs[] = {
>                 PRIMARY_SERVICE(0x0080, "a00b", 6),
>                 CHARACTERISTIC(0xb008, BT_ATT_PERM_READ | BT_ATT_PERM_WRITE,
> -                                       BT_GATT_CHRC_PROP_READ |
> -                                       BT_GATT_CHRC_PROP_WRITE,
> +                                       BT_GATT_PROP_READ |
> +                                       BT_GATT_PROP_WRITE,
>                                         0x08),
>                 DESCRIPTOR(0xb015, BT_ATT_PERM_READ | BT_ATT_PERM_WRITE, 0x01),
>                 DESCRIPTOR(0xb016, BT_ATT_PERM_READ | BT_ATT_PERM_WRITE, 0x02),
> @@ -1615,14 +1615,14 @@ static struct gatt_db *make_test_spec_large_db_1(void)
>
>                 SECONDARY_SERVICE(0x0001, "a00d", 6),
>                 INCLUDE(0x0080),
> -               CHARACTERISTIC(0xb00c, BT_ATT_PERM_READ, BT_GATT_CHRC_PROP_READ,
> +               CHARACTERISTIC(0xb00c, BT_ATT_PERM_READ, BT_GATT_PROP_READ,
>                                                                         0x0C),
>                 CHARACTERISTIC(0000b00b-0000-0000-0123-456789abcdef,
> -                               BT_ATT_PERM_READ, BT_GATT_CHRC_PROP_READ, 0x0B),
> +                               BT_ATT_PERM_READ, BT_GATT_PROP_READ, 0x0B),
>
>                 PRIMARY_SERVICE(0x0010, GATT_UUID, 4),
>                 CHARACTERISTIC(GATT_CHARAC_SERVICE_CHANGED, BT_ATT_PERM_READ,
> -                                               BT_GATT_CHRC_PROP_INDICATE,
> +                                               BT_GATT_PROP_INDICATE,
>                                                 0x01, 0x00, 0xFF, 0xFF),
>                 DESCRIPTOR(GATT_CLIENT_CHARAC_CFG_UUID,
>                                         BT_ATT_PERM_READ | BT_ATT_PERM_WRITE,
> @@ -1630,46 +1630,46 @@ static struct gatt_db *make_test_spec_large_db_1(void)
>
>                 PRIMARY_SERVICE(0x0020, "a00a", 10),
>                 INCLUDE(0x0001),
> -               CHARACTERISTIC(0xb001, BT_ATT_PERM_READ, BT_GATT_CHRC_PROP_READ,
> +               CHARACTERISTIC(0xb001, BT_ATT_PERM_READ, BT_GATT_PROP_READ,
>                                                                         0x01),
>                 CHARACTERISTIC_STR(0xb002, BT_ATT_PERM_READ | BT_ATT_PERM_WRITE,
> -                                               BT_GATT_CHRC_PROP_READ |
> -                                               BT_GATT_CHRC_PROP_WRITE,
> +                                               BT_GATT_PROP_READ |
> +                                               BT_GATT_PROP_WRITE,
>                                                 STRING_512BYTES),
>                 CHARACTERISTIC_STR(0xb002, BT_ATT_PERM_WRITE,
> -                                               BT_GATT_CHRC_PROP_WRITE,
> +                                               BT_GATT_PROP_WRITE,
>                                                 "1111122222333334444455555"
>                                                 "6666677777888889999900000"),
>                 CHARACTERISTIC(0xb003, BT_ATT_PERM_WRITE,
> -                                               BT_GATT_CHRC_PROP_WRITE, 0x03),
> +                                               BT_GATT_PROP_WRITE, 0x03),
>
>                 PRIMARY_SERVICE(0x0030, "a00b", 3),
>                 CHARACTERISTIC(0xb007, BT_ATT_PERM_WRITE,
> -                                               BT_GATT_CHRC_PROP_WRITE, 0x07),
> +                                               BT_GATT_PROP_WRITE, 0x07),
>
>                 PRIMARY_SERVICE(0x0040, GAP_UUID, 7),
>                 CHARACTERISTIC_STR(GATT_CHARAC_DEVICE_NAME, BT_ATT_PERM_READ,
> -                                       BT_GATT_CHRC_PROP_READ,
> +                                       BT_GATT_PROP_READ,
>                                         "Test Database"),
>                 CHARACTERISTIC(GATT_CHARAC_APPEARANCE, BT_ATT_PERM_READ,
> -                                               BT_GATT_CHRC_PROP_READ, 17),
> +                                               BT_GATT_PROP_READ, 17),
>                 CHARACTERISTIC(GATT_CHARAC_PERIPHERAL_PREF_CONN,
> -                               BT_ATT_PERM_READ, BT_GATT_CHRC_PROP_READ,
> +                               BT_ATT_PERM_READ, BT_GATT_PROP_READ,
>                                 0x64, 0x00, 0xC8, 0x00, 0x00, 0x00, 0x07, 0xD0),
>
>                 PRIMARY_SERVICE(0x0050, "a00b", 3),
>                 CHARACTERISTIC(0xb006, BT_ATT_PERM_READ | BT_ATT_PERM_WRITE,
> -                                       BT_GATT_CHRC_PROP_READ |
> -                                       BT_GATT_CHRC_PROP_WRITE |
> -                                       BT_GATT_CHRC_PROP_WRITE_WITHOUT_RESP |
> -                                       BT_GATT_CHRC_PROP_NOTIFY |
> -                                       BT_GATT_CHRC_PROP_INDICATE, 0x06),
> +                                       BT_GATT_PROP_READ |
> +                                       BT_GATT_PROP_WRITE |
> +                                       BT_GATT_PROP_WRITE_WITHOUT_RESP |
> +                                       BT_GATT_PROP_NOTIFY |
> +                                       BT_GATT_PROP_INDICATE, 0x06),
>
>                 PRIMARY_SERVICE(0x0060, "a00b", 12),
>                 CHARACTERISTIC(0xb004, BT_ATT_PERM_READ | BT_ATT_PERM_WRITE,
> -                       BT_GATT_CHRC_PROP_READ | BT_GATT_CHRC_PROP_WRITE, 0x04),
> +                       BT_GATT_PROP_READ | BT_GATT_PROP_WRITE, 0x04),
>                 CHARACTERISTIC(0xb004, BT_ATT_PERM_READ | BT_ATT_PERM_WRITE,
> -                       BT_GATT_CHRC_PROP_READ | BT_GATT_CHRC_PROP_WRITE, 0x04),
> +                       BT_GATT_PROP_READ | BT_GATT_PROP_WRITE, 0x04),
>                 DESCRIPTOR(GATT_SERVER_CHARAC_CFG_UUID,
>                                         BT_ATT_PERM_READ | BT_ATT_PERM_WRITE,
>                                         0x00, 0x00),
> @@ -1680,7 +1680,7 @@ static struct gatt_db *make_test_spec_large_db_1(void)
>                                 0x44, 0x55, 0x66, 0x77, 0x88, 0x99, 0x00, 0x11,
>                                 0x22, 0x33, 0x44, 0x55, 0x66, 0x77, 0x88, 0x99,
>                                 0x00, 0x11, 0x22, 0x33),
> -               CHARACTERISTIC(0xb004, BT_ATT_PERM_READ, BT_GATT_CHRC_PROP_READ,
> +               CHARACTERISTIC(0xb004, BT_ATT_PERM_READ, BT_GATT_PROP_READ,
>                                                                         0x04),
>                 DESCRIPTOR(0xb012, BT_ATT_PERM_READ, 0x11, 0x22, 0x33, 0x44,
>                                 0x55, 0x66, 0x77, 0x88, 0x99, 0x00, 0x11, 0x22,
> @@ -1691,9 +1691,9 @@ static struct gatt_db *make_test_spec_large_db_1(void)
>
>                 PRIMARY_SERVICE(0x0070, "a00b", 7),
>                 CHARACTERISTIC(0xb005, BT_ATT_PERM_READ | BT_ATT_PERM_WRITE,
> -                                               BT_GATT_CHRC_PROP_READ |
> -                                               BT_GATT_CHRC_PROP_WRITE |
> -                                               BT_GATT_CHRC_PROP_EXT_PROP,
> +                                               BT_GATT_PROP_READ |
> +                                               BT_GATT_PROP_WRITE |
> +                                               BT_GATT_PROP_EXT_PROP,
>                                                 0x05),
>                 DESCRIPTOR(GATT_CHARAC_EXT_PROPER_UUID, BT_ATT_PERM_READ, 0x03,
>                                                                         0x00),
> @@ -1712,9 +1712,9 @@ static struct gatt_db *make_test_spec_large_db_1(void)
>                 INCLUDE(0x0001),
>                 CHARACTERISTIC(0000b009-0000-0000-0123-456789abcdef,
>                                         BT_ATT_PERM_READ | BT_ATT_PERM_WRITE,
> -                                       BT_GATT_CHRC_PROP_READ |
> -                                       BT_GATT_CHRC_PROP_WRITE |
> -                                       BT_GATT_CHRC_PROP_EXT_PROP, 0x09),
> +                                       BT_GATT_PROP_READ |
> +                                       BT_GATT_PROP_WRITE |
> +                                       BT_GATT_PROP_EXT_PROP, 0x09),
>                 DESCRIPTOR(GATT_CHARAC_EXT_PROPER_UUID, BT_ATT_PERM_READ, 0x01,
>                                                                         0x00),
>                 DESCRIPTOR(0000d9d2-0000-0000-0123-456789abcdef,
> @@ -1724,65 +1724,65 @@ static struct gatt_db *make_test_spec_large_db_1(void)
>
>                 PRIMARY_SERVICE(0x00a0, "a00f", 18),
>                 CHARACTERISTIC_STR(0xb00e, BT_ATT_PERM_READ,
> -                                       BT_GATT_CHRC_PROP_READ, "Length is "),
> +                                       BT_GATT_PROP_READ, "Length is "),
>                 DESCRIPTOR(GATT_CHARAC_FMT_UUID, BT_ATT_PERM_READ, 0x19, 0x00,
>                                                 0x00, 0x30, 0x01, 0x00, 0x00),
>                 CHARACTERISTIC(0xb00f, BT_ATT_PERM_READ | BT_ATT_PERM_WRITE,
> -                                               BT_GATT_CHRC_PROP_READ |
> -                                               BT_GATT_CHRC_PROP_WRITE, 0x65),
> +                                               BT_GATT_PROP_READ |
> +                                               BT_GATT_PROP_WRITE, 0x65),
>                 DESCRIPTOR(GATT_CHARAC_FMT_UUID, BT_ATT_PERM_READ, 0x04, 0x00,
>                                                 0x01, 0x27, 0x01, 0x01, 0x00),
>                 CHARACTERISTIC(0xb006, BT_ATT_PERM_READ | BT_ATT_PERM_WRITE,
> -                                               BT_GATT_CHRC_PROP_READ |
> -                                               BT_GATT_CHRC_PROP_WRITE,
> +                                               BT_GATT_PROP_READ |
> +                                               BT_GATT_PROP_WRITE,
>                                                 0x34, 0x12),
>                 DESCRIPTOR(GATT_CHARAC_FMT_UUID, BT_ATT_PERM_READ, 0x06, 0x00,
>                                                 0x10, 0x27, 0x01, 0x02, 0x00),
>                 CHARACTERISTIC(0xb007, BT_ATT_PERM_READ | BT_ATT_PERM_WRITE,
> -                                               BT_GATT_CHRC_PROP_READ |
> -                                               BT_GATT_CHRC_PROP_WRITE,
> +                                               BT_GATT_PROP_READ |
> +                                               BT_GATT_PROP_WRITE,
>                                                 0x04, 0x03, 0x02, 0x01),
>                 DESCRIPTOR(GATT_CHARAC_FMT_UUID, BT_ATT_PERM_READ, 0x08, 0x00,
>                                                 0x17, 0x27, 0x01, 0x03, 0x00),
> -               CHARACTERISTIC(0xb010, BT_ATT_PERM_READ, BT_GATT_CHRC_PROP_READ,
> +               CHARACTERISTIC(0xb010, BT_ATT_PERM_READ, BT_GATT_PROP_READ,
>                                         0x65, 0x34, 0x12, 0x04, 0x03, 0x02,
>                                         0x01),
>                 DESCRIPTOR(GATT_CHARAC_AGREG_FMT_UUID, BT_ATT_PERM_READ, 0xA6,
>                                                 0x00, 0xa9, 0x00, 0xac, 0x00),
>                 CHARACTERISTIC(0xb011, BT_ATT_PERM_READ | BT_ATT_PERM_WRITE,
> -                                               BT_GATT_CHRC_PROP_READ |
> -                                               BT_GATT_CHRC_PROP_AUTH, 0x012),
> +                                               BT_GATT_PROP_READ |
> +                                               BT_GATT_PROP_AUTH, 0x012),
>
>                 PRIMARY_SERVICE(0x00C0, "0000a00c-0000-0000-0123-456789abcdef",
>                                                                         30),
> -               CHARACTERISTIC(0xb00a, BT_ATT_PERM_READ, BT_GATT_CHRC_PROP_READ,
> +               CHARACTERISTIC(0xb00a, BT_ATT_PERM_READ, BT_GATT_PROP_READ,
>                                                                         0x0A),
>                 CHARACTERISTIC_STR(0xb002, BT_ATT_PERM_READ | BT_ATT_PERM_WRITE,
> -                                               BT_GATT_CHRC_PROP_READ |
> -                                               BT_GATT_CHRC_PROP_WRITE,
> +                                               BT_GATT_PROP_READ |
> +                                               BT_GATT_PROP_WRITE,
>                                                 "111112222233333444445"),
>                 DESCRIPTOR(0xb012, BT_ATT_PERM_READ | BT_ATT_PERM_WRITE,
>                                 0x11, 0x22, 0x33, 0x44, 0x55, 0x66, 0x77, 0x88,
>                                 0x99, 0x00, 0x12, 0x34, 0x56, 0x78, 0x90, 0x11),
>                 CHARACTERISTIC_STR(0xb002, BT_ATT_PERM_READ | BT_ATT_PERM_WRITE,
> -                                               BT_GATT_CHRC_PROP_READ |
> -                                               BT_GATT_CHRC_PROP_WRITE,
> +                                               BT_GATT_PROP_READ |
> +                                               BT_GATT_PROP_WRITE,
>                                                 "2222233333444445555566"),
>                 DESCRIPTOR(0xb013, BT_ATT_PERM_READ | BT_ATT_PERM_WRITE,
>                                 0x11, 0x22, 0x33, 0x44, 0x55, 0x66, 0x77, 0x88,
>                                 0x99, 0x00, 0x12, 0x34, 0x56, 0x78, 0x90, 0x11,
>                                 0x22),
>                 CHARACTERISTIC_STR(0xb002, BT_ATT_PERM_READ | BT_ATT_PERM_WRITE,
> -                                               BT_GATT_CHRC_PROP_READ |
> -                                               BT_GATT_CHRC_PROP_WRITE,
> +                                               BT_GATT_PROP_READ |
> +                                               BT_GATT_PROP_WRITE,
>                                                 "33333444445555566666777"),
>                 DESCRIPTOR(0xb014, BT_ATT_PERM_READ | BT_ATT_PERM_WRITE,
>                                 0x11, 0x22, 0x33, 0x44, 0x55, 0x66, 0x77, 0x88,
>                                 0x99, 0x00, 0x12, 0x34, 0x56, 0x78, 0x90, 0x11,
>                                 0x22, 0x33),
>                 CHARACTERISTIC(0xb002, BT_ATT_PERM_READ | BT_ATT_PERM_WRITE,
> -                                               BT_GATT_CHRC_PROP_READ |
> -                                               BT_GATT_CHRC_PROP_WRITE,
> +                                               BT_GATT_PROP_READ |
> +                                               BT_GATT_PROP_WRITE,
>                                                 0x11, 0x22, 0x33, 0x44, 0x55,
>                                                 0x66, 0x77, 0x88, 0x99, 0x00,
>                                                 0x11, 0x22, 0x33, 0x44, 0x55,
> @@ -1800,8 +1800,8 @@ static struct gatt_db *make_test_spec_large_db_1(void)
>                                 0x33, 0x44, 0x55, 0x66, 0x77, 0x88, 0x99, 0x00,
>                                 0x11, 0x22, 0x33),
>                 CHARACTERISTIC(0xb002, BT_ATT_PERM_READ | BT_ATT_PERM_WRITE,
> -                                               BT_GATT_CHRC_PROP_READ |
> -                                               BT_GATT_CHRC_PROP_WRITE,
> +                                               BT_GATT_PROP_READ |
> +                                               BT_GATT_PROP_WRITE,
>                                                 0x11, 0x22, 0x33, 0x44, 0x55,
>                                                 0x66, 0x77, 0x88, 0x99, 0x00,
>                                                 0x11, 0x22, 0x33, 0x44, 0x55,
> @@ -1819,8 +1819,8 @@ static struct gatt_db *make_test_spec_large_db_1(void)
>                                 0x33, 0x44, 0x55, 0x66, 0x77, 0x88, 0x99, 0x00,
>                                 0x11, 0x22, 0x33, 0x44),
>                 CHARACTERISTIC(0xb002, BT_ATT_PERM_READ | BT_ATT_PERM_WRITE,
> -                                               BT_GATT_CHRC_PROP_READ |
> -                                               BT_GATT_CHRC_PROP_WRITE,
> +                                               BT_GATT_PROP_READ |
> +                                               BT_GATT_PROP_WRITE,
>                                                 0x11, 0x22, 0x33, 0x44, 0x55,
>                                                 0x66, 0x77, 0x88, 0x99, 0x00,
>                                                 0x11, 0x22, 0x33, 0x44, 0x55,
> @@ -1838,8 +1838,8 @@ static struct gatt_db *make_test_spec_large_db_1(void)
>                                 0x33, 0x44, 0x55, 0x66, 0x77, 0x88, 0x99, 0x00,
>                                 0x11, 0x22, 0x33, 0x44, 0x55),
>                 CHARACTERISTIC_STR(0xb002, BT_ATT_PERM_READ | BT_ATT_PERM_WRITE,
> -                                               BT_GATT_CHRC_PROP_READ |
> -                                               BT_GATT_CHRC_PROP_WRITE,
> +                                               BT_GATT_PROP_READ |
> +                                               BT_GATT_PROP_WRITE,
>                                                 "1111122222333334444455555"
>                                                 "666667777788888999"),
>                 DESCRIPTOR(0xb012, BT_ATT_PERM_READ | BT_ATT_PERM_WRITE,
> @@ -1850,8 +1850,8 @@ static struct gatt_db *make_test_spec_large_db_1(void)
>                                 0x33, 0x44, 0x55, 0x66, 0x77, 0x88, 0x99, 0x00,
>                                 0x11, 0x22, 0x33),
>                 CHARACTERISTIC_STR(0xb002, BT_ATT_PERM_READ | BT_ATT_PERM_WRITE,
> -                                               BT_GATT_CHRC_PROP_READ |
> -                                               BT_GATT_CHRC_PROP_WRITE,
> +                                               BT_GATT_PROP_READ |
> +                                               BT_GATT_PROP_WRITE,
>                                                 "2222233333444445555566666"
>                                                 "7777788888999990000"),
>                 DESCRIPTOR(0xb013, BT_ATT_PERM_READ | BT_ATT_PERM_WRITE,
> @@ -1862,8 +1862,8 @@ static struct gatt_db *make_test_spec_large_db_1(void)
>                                 0x33, 0x44, 0x55, 0x66, 0x77, 0x88, 0x99, 0x00,
>                                 0x11, 0x22, 0x33, 0x44),
>                 CHARACTERISTIC_STR(0xb002, BT_ATT_PERM_READ | BT_ATT_PERM_WRITE,
> -                                               BT_GATT_CHRC_PROP_READ |
> -                                               BT_GATT_CHRC_PROP_WRITE,
> +                                               BT_GATT_PROP_READ |
> +                                               BT_GATT_PROP_WRITE,
>                                                 "3333344444555556666677777"
>                                                 "88888999990000011111"),
>                 DESCRIPTOR(0xb014, BT_ATT_PERM_READ | BT_ATT_PERM_WRITE,
> --
> 2.1.0
>
> --
> To unsubscribe from this list: send the line "unsubscribe linux-bluetooth" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html

Thanks,
Arman
