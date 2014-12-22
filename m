Return-Path: <cyrus@holtmann.org>
MIME-Version: 1.0
In-Reply-To: <1419024965-10375-6-git-send-email-armansito@chromium.org>
References: <1419024965-10375-1-git-send-email-armansito@chromium.org>
	<1419024965-10375-6-git-send-email-armansito@chromium.org>
Date: Mon, 22 Dec 2014 12:54:14 -0200
Message-ID: <CABBYNZ+_aESk2SjqCNpebsPeEQaxuCM_Gn=Gd7v0xvNYBO_UaQ@mail.gmail.com>
Subject: Re: [PATCH BlueZ 05/17] core: gatt: Implement GattCharacteristic1.ReadValue
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
To: Arman Uguray <armansito@chromium.org>
Cc: "linux-bluetooth@vger.kernel.org" <linux-bluetooth@vger.kernel.org>
Content-Type: text/plain; charset=UTF-8
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Arman,

On Fri, Dec 19, 2014 at 7:35 PM, Arman Uguray <armansito@chromium.org> wrote:
> This patch implements the ReadValue method of
> org.bluez.GattCharacteristic1 and exposes the "Value" property based on
> what was cached during the most recent read. The property is hidden if
> the value is unknown.
> ---
>  src/gatt-client.c | 217 +++++++++++++++++++++++++++++++++++++++++++++++++++++-
>  1 file changed, 213 insertions(+), 4 deletions(-)
>
> diff --git a/src/gatt-client.c b/src/gatt-client.c
> index bd3711a..1c4ea51 100644
> --- a/src/gatt-client.c
> +++ b/src/gatt-client.c
> @@ -73,6 +73,12 @@ struct characteristic {
>         uint8_t props;
>         bt_uuid_t uuid;
>         char *path;
> +
> +       bool in_read;
> +       bool value_known;
> +       uint8_t *value;
> +       size_t value_len;
> +
>         struct queue *descs;
>  };
>
> @@ -83,6 +89,66 @@ struct descriptor {
>         char *path;
>  };
>
> +static DBusMessage *gatt_error_read_not_permitted(DBusMessage *msg)
> +{
> +       return g_dbus_create_error(msg, ERROR_INTERFACE ".ReadNotPermitted",
> +                               "Reading of this value is not allowed");
> +}
> +
> +static DBusMessage *gatt_error_write_not_permitted(DBusMessage *msg)
> +{
> +       return g_dbus_create_error(msg, ERROR_INTERFACE ".WriteNotPermitted",
> +                               "Writing of this value is not allowed");
> +}
> +
> +static DBusMessage *gatt_error_invalid_value_len(DBusMessage *msg)
> +{
> +       return g_dbus_create_error(msg, ERROR_INTERFACE ".InvalidValueLength",
> +                                                       "Invalid value length");
> +}
> +
> +static DBusMessage *gatt_error_invalid_offset(DBusMessage *msg)
> +{
> +       return g_dbus_create_error(msg, ERROR_INTERFACE ".InvalidOffset",
> +                                                       "Invalid value offset");
> +}
> +
> +static DBusMessage *gatt_error_not_paired(DBusMessage *msg)
> +{
> +       return g_dbus_create_error(msg, ERROR_INTERFACE ".NotPaired",
> +                                                               "Not Paired");
> +}
> +
> +static DBusMessage *create_gatt_dbus_error(DBusMessage *msg, uint8_t att_ecode)
> +{
> +       switch (att_ecode) {
> +       case BT_ATT_ERROR_READ_NOT_PERMITTED:
> +               return gatt_error_read_not_permitted(msg);
> +       case BT_ATT_ERROR_WRITE_NOT_PERMITTED:
> +               return gatt_error_write_not_permitted(msg);
> +       case BT_ATT_ERROR_AUTHENTICATION:
> +       case BT_ATT_ERROR_INSUFFICIENT_ENCRYPTION:
> +       case BT_ATT_ERROR_INSUFFICIENT_ENCRYPTION_KEY_SIZE:
> +               return gatt_error_not_paired(msg);
> +       case BT_ATT_ERROR_INVALID_OFFSET:
> +               return gatt_error_invalid_offset(msg);
> +       case BT_ATT_ERROR_INVALID_ATTRIBUTE_VALUE_LEN:
> +               return gatt_error_invalid_value_len(msg);
> +       case BT_ATT_ERROR_AUTHORIZATION:
> +               return btd_error_not_authorized(msg);
> +       case BT_ATT_ERROR_REQUEST_NOT_SUPPORTED:
> +               return btd_error_not_supported(msg);
> +       case 0:
> +               return btd_error_failed(msg, "Operation failed");
> +       default:
> +               return g_dbus_create_error(msg, ERROR_INTERFACE,
> +                               "Operation failed with ATT error: 0x%02x",
> +                               att_ecode);
> +       }
> +
> +       return NULL;
> +}
> +
>  static gboolean descriptor_property_get_uuid(const GDBusPropertyTable *property,
>                                         DBusMessageIter *iter, void *data)
>  {
> @@ -232,17 +298,32 @@ static gboolean characteristic_property_get_value(
>                                         const GDBusPropertyTable *property,
>                                         DBusMessageIter *iter, void *data)
>  {
> +       struct characteristic *chrc = data;
>         DBusMessageIter array;
> +       size_t i;
>
>         dbus_message_iter_open_container(iter, DBUS_TYPE_ARRAY, "y", &array);
>
> -       /* TODO: Implement this once the value is cached */
> +       if (chrc->value_known) {
> +               for (i = 0; i < chrc->value_len; i++)
> +                       dbus_message_iter_append_basic(&array, DBUS_TYPE_BYTE,
> +                                                       chrc->value + i);
> +       }
>
>         dbus_message_iter_close_container(iter, &array);
>
>         return TRUE;
>  }
>
> +static gboolean characteristic_property_value_exists(
> +                                       const GDBusPropertyTable *property,
> +                                       void *data)
> +{
> +       struct characteristic *chrc = data;
> +
> +       return chrc->value_known ? TRUE : FALSE;
> +}
> +
>  static gboolean characteristic_property_get_notifying(
>                                         const GDBusPropertyTable *property,
>                                         DBusMessageIter *iter, void *data)
> @@ -305,11 +386,137 @@ static gboolean characteristic_property_get_flags(
>         return TRUE;
>  }
>
> +struct chrc_dbus_op {
> +       struct characteristic *chrc;
> +       DBusMessage *msg;
> +};
> +
> +static void chrc_dbus_op_free(void *data)
> +{
> +       struct chrc_dbus_op *op = data;
> +
> +       dbus_message_unref(op->msg);
> +       free(op);
> +}
> +
> +static bool chrc_resize_value(struct characteristic *chrc, size_t new_size)
> +{
> +       uint8_t *ptr;
> +
> +       if (chrc->value_len == new_size)
> +               return true;
> +
> +       if (!new_size) {
> +               free(chrc->value);
> +               chrc->value = NULL;
> +               chrc->value_len = 0;
> +
> +               return true;
> +       }
> +
> +       ptr = realloc(chrc->value, sizeof(uint8_t) * new_size);
> +       if (!ptr)
> +               return false;
> +
> +       chrc->value = ptr;
> +       chrc->value_len = new_size;
> +
> +       return true;
> +}
> +
> +static void chrc_read_long_cb(bool success, uint8_t att_ecode,
> +                                       const uint8_t *value, uint16_t length,
> +                                       void *user_data)
> +{
> +       struct chrc_dbus_op *op = user_data;
> +       struct characteristic *chrc = op->chrc;
> +       DBusMessageIter iter, array;
> +       DBusMessage *reply;
> +
> +       op->chrc->in_read = false;
> +
> +       if (!success) {
> +               reply = create_gatt_dbus_error(op->msg, att_ecode);
> +               goto done;
> +       }
> +
> +       /*
> +        * If the value is the same, then only update it if it wasn't previously
> +        * known.
> +        */
> +       if (chrc->value_known && chrc->value_len == length &&
> +                       !memcmp(chrc->value, value, sizeof(uint8_t) * length))
> +               goto reply;
> +
> +       if (!chrc_resize_value(chrc, length)) {
> +               /*
> +                * Failed to resize the buffer. Since we don't want to show a
> +                * stale value, if the value was previously known, then free and
> +                * hide it.
> +                */
> +               free(chrc->value);
> +               chrc->value = NULL;
> +               chrc->value_len = 0;
> +               chrc->value_known = false;
> +
> +               goto changed_signal;
> +       }
> +
> +       chrc->value_known = true;
> +       memcpy(chrc->value, value, sizeof(uint8_t) * length);

We could store this in the db itself and remember across connections
since this is supposed to be used only when notifications are enabled.

> +changed_signal:
> +       g_dbus_emit_property_changed(btd_get_dbus_connection(), chrc->path,
> +                                               GATT_CHARACTERISTIC_IFACE,
> +                                               "Value");
> +
> +reply:
> +       reply = g_dbus_create_reply(op->msg, DBUS_TYPE_INVALID);
> +       if (!reply) {
> +               error("Failed to allocate D-Bus message reply");
> +               return;
> +       }
> +
> +       dbus_message_iter_init_append(reply, &iter);
> +       dbus_message_iter_open_container(&iter, DBUS_TYPE_ARRAY, "y", &array);
> +
> +       for (i = 0; i < length; i++)
> +               dbus_message_iter_append_basic(&array, DBUS_TYPE_BYTE,
> +                                                               value + i);
> +
> +       dbus_message_iter_close_container(&iter, &array);
> +
> +done:
> +       g_dbus_send_message(btd_get_dbus_connection(), reply);
> +}
> +
>  static DBusMessage *characteristic_read_value(DBusConnection *conn,
>                                         DBusMessage *msg, void *user_data)
>  {
> -       /* TODO: Implement */
> -       return btd_error_failed(msg, "Not implemented");
> +       struct characteristic *chrc = user_data;
> +       struct bt_gatt_client *gatt = chrc->service->client->gatt;
> +       struct chrc_dbus_op *op;
> +
> +       if (chrc->in_read)
> +               return btd_error_in_progress(msg);
> +
> +       op = new0(struct chrc_dbus_op, 1);
> +       if (!op)
> +               return btd_error_failed(msg, "Failed to initialize request");
> +
> +       op->chrc = chrc;
> +       op->msg = dbus_message_ref(msg);
> +
> +       if (bt_gatt_client_read_long_value(gatt, chrc->value_handle, 0,
> +                                                       chrc_read_long_cb, op,
> +                                                       chrc_dbus_op_free)) {
> +               chrc->in_read = true;
> +               return NULL;
> +       }
> +
> +       chrc_dbus_op_free(op);
> +
> +       return btd_error_failed(msg, "Failed to send read request");
>  }
>
>  static DBusMessage *characteristic_write_value(DBusConnection *conn,
> @@ -361,7 +568,8 @@ static gboolean characteristic_property_get_descriptors(
>  static const GDBusPropertyTable characteristic_properties[] = {
>         { "UUID", "s", characteristic_property_get_uuid },
>         { "Service", "o", characteristic_property_get_service },
> -       { "Value", "ay", characteristic_property_get_value },
> +       { "Value", "ay", characteristic_property_get_value, NULL,
> +                                       characteristic_property_value_exists },
>         { "Notifying", "b", characteristic_property_get_notifying },
>         { "Flags", "as", characteristic_property_get_flags },
>         { "Descriptors", "ao", characteristic_property_get_descriptors },
> @@ -384,6 +592,7 @@ static void characteristic_free(void *data)
>         struct characteristic *chrc = data;
>
>         queue_destroy(chrc->descs, NULL);  /* List should be empty here */
> +       free(chrc->value);
>         g_free(chrc->path);
>         free(chrc);
>  }
> --
> 2.2.0.rc0.207.ga3a616c
>
> --
> To unsubscribe from this list: send the line "unsubscribe linux-bluetooth" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html



-- 
Luiz Augusto von Dentz
