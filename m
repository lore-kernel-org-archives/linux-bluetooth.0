Return-Path: <cyrus@holtmann.org>
MIME-Version: 1.0
In-Reply-To: <1419024965-10375-4-git-send-email-armansito@chromium.org>
References: <1419024965-10375-1-git-send-email-armansito@chromium.org>
	<1419024965-10375-4-git-send-email-armansito@chromium.org>
Date: Mon, 22 Dec 2014 12:49:08 -0200
Message-ID: <CABBYNZ+23==WALXgm5OdY+09CBKi1vQ1eSs8cJeqbEBhF64kfQ@mail.gmail.com>
Subject: Re: [PATCH BlueZ 03/17] core: gatt: Export GATT characteristics on D-Bus
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
To: Arman Uguray <armansito@chromium.org>
Cc: "linux-bluetooth@vger.kernel.org" <linux-bluetooth@vger.kernel.org>
Content-Type: text/plain; charset=UTF-8
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Arman,

On Fri, Dec 19, 2014 at 7:35 PM, Arman Uguray <armansito@chromium.org> wrote:
> This patch adds code that exports an object on D-Bus with the
> org.bluez.GattCharacteristic1 interface for each GATT characteristic
> that is present in bt_gatt_client.
> ---
>  src/gatt-client.c | 332 +++++++++++++++++++++++++++++++++++++++++++++++++++++-
>  1 file changed, 330 insertions(+), 2 deletions(-)
>
> diff --git a/src/gatt-client.c b/src/gatt-client.c
> index 05782ab..1a0e1cf 100644
> --- a/src/gatt-client.c
> +++ b/src/gatt-client.c
> @@ -30,6 +30,7 @@
>  #include <bluetooth/bluetooth.h>
>
>  #include "log.h"
> +#include "error.h"
>  #include "adapter.h"
>  #include "device.h"
>  #include "lib/uuid.h"
> @@ -41,7 +42,8 @@
>  #include "gatt-client.h"
>  #include "dbus-common.h"
>
> -#define GATT_SERVICE_IFACE "org.bluez.GattService1"
> +#define GATT_SERVICE_IFACE             "org.bluez.GattService1"
> +#define GATT_CHARACTERISTIC_IFACE      "org.bluez.GattCharacteristic1"
>
>  struct btd_gatt_client {
>         struct btd_device *device;
> @@ -59,8 +61,242 @@ struct service {
>         uint16_t end_handle;
>         bt_uuid_t uuid;
>         char *path;
> +       struct queue *chrcs;
> +       bool chrcs_ready;
>  };
>
> +struct characteristic {
> +       struct service *service;
> +       uint16_t handle;
> +       uint16_t value_handle;
> +       uint8_t props;
> +       bt_uuid_t uuid;
> +       char *path;
> +};
> +
> +static gboolean characteristic_property_get_uuid(
> +                                       const GDBusPropertyTable *property,
> +                                       DBusMessageIter *iter, void *data)
> +{
> +       char uuid[MAX_LEN_UUID_STR + 1];
> +       const char *ptr = uuid;
> +       struct characteristic *chrc = data;
> +
> +       bt_uuid_to_string(&chrc->uuid, uuid, sizeof(uuid));
> +       dbus_message_iter_append_basic(iter, DBUS_TYPE_STRING, &ptr);
> +
> +       return TRUE;
> +}
> +
> +static gboolean characteristic_property_get_service(
> +                                       const GDBusPropertyTable *property,
> +                                       DBusMessageIter *iter, void *data)
> +{
> +       struct characteristic *chrc = data;
> +       const char *str = chrc->service->path;
> +
> +       dbus_message_iter_append_basic(iter, DBUS_TYPE_OBJECT_PATH, &str);
> +
> +       return TRUE;
> +}
> +
> +static gboolean characteristic_property_get_value(
> +                                       const GDBusPropertyTable *property,
> +                                       DBusMessageIter *iter, void *data)
> +{
> +       DBusMessageIter array;
> +
> +       dbus_message_iter_open_container(iter, DBUS_TYPE_ARRAY, "y", &array);
> +
> +       /* TODO: Implement this once the value is cached */
> +
> +       dbus_message_iter_close_container(iter, &array);
> +
> +       return TRUE;
> +}
> +
> +static gboolean characteristic_property_get_notifying(
> +                                       const GDBusPropertyTable *property,
> +                                       DBusMessageIter *iter, void *data)
> +{
> +       dbus_bool_t notifying = FALSE;
> +
> +       /*
> +        * TODO: Return the correct value here once StartNotify and StopNotify
> +        * methods are implemented.
> +        */
> +
> +       dbus_message_iter_append_basic(iter, DBUS_TYPE_BOOLEAN, &notifying);
> +
> +       return TRUE;
> +}
> +
> +static struct {
> +       uint8_t prop;
> +       char *str;
> +} properties[] = {
> +       /* Default Properties */
> +       { BT_GATT_CHRC_PROP_BROADCAST,          "broadcast" },
> +       { BT_GATT_CHRC_PROP_READ,               "read" },
> +       { BT_GATT_CHRC_PROP_WRITE_WITHOUT_RESP, "write-without-response" },
> +       { BT_GATT_CHRC_PROP_WRITE,              "write" },
> +       { BT_GATT_CHRC_PROP_NOTIFY,             "notify" },
> +       { BT_GATT_CHRC_PROP_INDICATE,           "indicate" },
> +       { BT_GATT_CHRC_PROP_AUTH,               "authenticated-signed-writes" },
> +       { BT_GATT_CHRC_PROP_EXT_PROP,           "extended-properties" },
> +       { },
> +       /* Extended Properties */
> +       { BT_GATT_CHRC_EXT_PROP_RELIABLE_WRITE, "reliable-write" },
> +       { BT_GATT_CHRC_EXT_PROP_WRITABLE_AUX,   "writable-auxiliaries" },
> +       { }
> +};
> +
> +static gboolean characteristic_property_get_flags(
> +                                       const GDBusPropertyTable *property,
> +                                       DBusMessageIter *iter, void *data)
> +{
> +       struct characteristic *chrc = data;
> +       DBusMessageIter array;
> +       int i;
> +
> +       dbus_message_iter_open_container(iter, DBUS_TYPE_ARRAY, "s", &array);
> +
> +       for (i = 0; properties[i].str; i++) {
> +               if (chrc->props & properties[i].prop)
> +                       dbus_message_iter_append_basic(&array, DBUS_TYPE_STRING,
> +                                                       &properties[i].str);
> +       }
> +
> +       /*
> +        * TODO: Handle extended properties if the descriptor is
> +        * present.
> +        */
> +
> +       dbus_message_iter_close_container(iter, &array);
> +
> +       return TRUE;
> +}
> +
> +static DBusMessage *characteristic_read_value(DBusConnection *conn,
> +                                       DBusMessage *msg, void *user_data)
> +{
> +       /* TODO: Implement */
> +       return btd_error_failed(msg, "Not implemented");
> +}
> +
> +static DBusMessage *characteristic_write_value(DBusConnection *conn,
> +                                       DBusMessage *msg, void *user_data)
> +{
> +       /* TODO: Implement */
> +       return btd_error_failed(msg, "Not implemented");
> +}
> +
> +static DBusMessage *characteristic_start_notify(DBusConnection *conn,
> +                                       DBusMessage *msg, void *user_data)
> +{
> +       /* TODO: Implement */
> +       return btd_error_failed(msg, "Not implemented");
> +}
> +
> +static DBusMessage *characteristic_stop_notify(DBusConnection *conn,
> +                                       DBusMessage *msg, void *user_data)
> +{
> +       /* TODO: Implement */
> +       return btd_error_failed(msg, "Not implemented");
> +}
> +
> +static gboolean characteristic_property_get_descriptors(
> +                                       const GDBusPropertyTable *property,
> +                                       DBusMessageIter *iter, void *data)
> +{
> +       DBusMessageIter array;
> +
> +       dbus_message_iter_open_container(iter, DBUS_TYPE_ARRAY, "o", &array);
> +
> +       /* TODO: Implement this once descriptors are exported */
> +
> +       dbus_message_iter_close_container(iter, &array);
> +
> +       return TRUE;
> +}
> +
> +static const GDBusPropertyTable characteristic_properties[] = {
> +       { "UUID", "s", characteristic_property_get_uuid },
> +       { "Service", "o", characteristic_property_get_service },
> +       { "Value", "ay", characteristic_property_get_value },
> +       { "Notifying", "b", characteristic_property_get_notifying },
> +       { "Flags", "as", characteristic_property_get_flags },
> +       { "Descriptors", "ao", characteristic_property_get_descriptors },
> +       { }
> +};
> +
> +static const GDBusMethodTable characteristic_methods[] = {
> +       { GDBUS_ASYNC_METHOD("ReadValue", NULL, GDBUS_ARGS({ "value", "ay" }),
> +                                               characteristic_read_value) },
> +       { GDBUS_ASYNC_METHOD("WriteValue", GDBUS_ARGS({ "value", "ay" }),
> +                                       NULL, characteristic_write_value) },
> +       { GDBUS_ASYNC_METHOD("StartNotify", NULL, NULL,
> +                                               characteristic_start_notify) },
> +       { GDBUS_METHOD("StopNotify", NULL, NULL, characteristic_stop_notify) },

I don't think if StartNotify and StopNotify are a reliable API in case
of paired device, CCC is persistent thus on disconnect it would
remember if any client has enabled notification but upon reconnection
that client may no longer be available, IMO the best policy here is to
always enable notifications if possible so it is up to the application
to register for PropertiesChanged if it cares about them.

> +       { }
> +};
> +
> +static void characteristic_free(void *data)
> +{
> +       struct characteristic *chrc = data;
> +
> +       g_free(chrc->path);
> +       free(chrc);
> +}
> +
> +static struct characteristic *characteristic_create(
> +                                               struct gatt_db_attribute *attr,
> +                                               struct service *service)
> +{
> +       struct characteristic *chrc;
> +       bt_uuid_t uuid;
> +
> +       chrc = new0(struct characteristic, 1);
> +       if (!chrc)
> +               return NULL;
> +
> +       chrc->service = service;
> +
> +       gatt_db_attribute_get_char_data(attr, &chrc->handle,
> +                                                       &chrc->value_handle,
> +                                                       &chrc->props, &uuid);
> +       bt_uuid_to_uuid128(&uuid, &chrc->uuid);
> +
> +       chrc->path = g_strdup_printf("%s/char%04x", service->path,
> +                                                               chrc->handle);
> +
> +       if (!g_dbus_register_interface(btd_get_dbus_connection(), chrc->path,
> +                                               GATT_CHARACTERISTIC_IFACE,
> +                                               characteristic_methods, NULL,
> +                                               characteristic_properties,
> +                                               chrc, characteristic_free)) {
> +               error("Unable to register GATT characteristic with handle "
> +                                                       "0x%04x", chrc->handle);
> +               characteristic_free(chrc);
> +
> +               return NULL;
> +       }
> +
> +       DBG("Exported GATT characteristic: %s", chrc->path);
> +
> +       return chrc;
> +}
> +
> +static void unregister_characteristic(void *data)
> +{
> +       struct characteristic *chrc = data;
> +
> +       DBG("Removing GATT characteristic: %s", chrc->path);
> +
> +       g_dbus_unregister_interface(btd_get_dbus_connection(), chrc->path,
> +                                               GATT_CHARACTERISTIC_IFACE);
> +}
> +
>  static gboolean service_property_get_uuid(const GDBusPropertyTable *property,
>                                         DBusMessageIter *iter, void *data)
>  {
> @@ -98,15 +334,26 @@ static gboolean service_property_get_primary(const GDBusPropertyTable *property,
>         return TRUE;
>  }
>
> +static void append_chrc_path(void *data, void *user_data)
> +{
> +       struct characteristic *chrc = data;
> +       DBusMessageIter *array = user_data;
> +
> +       dbus_message_iter_append_basic(array, DBUS_TYPE_OBJECT_PATH,
> +                                                               &chrc->path);
> +}
> +
>  static gboolean service_property_get_characteristics(
>                                         const GDBusPropertyTable *property,
>                                         DBusMessageIter *iter, void *data)
>  {
> +       struct service *service = data;
>         DBusMessageIter array;
>
>         dbus_message_iter_open_container(iter, DBUS_TYPE_ARRAY, "o", &array);
>
> -       /* TODO: Implement this once characteristics are exported */
> +       if (service->chrcs_ready)
> +               queue_foreach(service->chrcs, append_chrc_path, &array);
>
>         dbus_message_iter_close_container(iter, &array);
>
> @@ -125,6 +372,7 @@ static void service_free(void *data)
>  {
>         struct service *service = data;
>
> +       queue_destroy(service->chrcs, NULL);  /* List should be empty here */
>         g_free(service->path);
>         free(service);
>  }
> @@ -140,6 +388,12 @@ static struct service *service_create(struct gatt_db_attribute *attr,
>         if (!service)
>                 return NULL;
>
> +       service->chrcs = queue_new();
> +       if (!service->chrcs) {
> +               free(service);
> +               return NULL;
> +       }
> +
>         service->client = client;
>
>         gatt_db_attribute_get_service_data(attr, &service->start_handle,
> @@ -176,10 +430,71 @@ static void unregister_service(void *data)
>
>         DBG("Removing GATT service: %s", service->path);
>
> +       queue_remove_all(service->chrcs, NULL, NULL, unregister_characteristic);
> +
>         g_dbus_unregister_interface(btd_get_dbus_connection(), service->path,
>                                                         GATT_SERVICE_IFACE);
>  }
>
> +struct export_data {
> +       void *root;
> +       bool failed;
> +};
> +
> +static void export_char(struct gatt_db_attribute *attr, void *user_data)
> +{
> +       struct characteristic *charac;
> +       struct export_data *data = user_data;
> +       struct service *service = data->root;
> +
> +       if (data->failed)
> +               return;
> +
> +       charac = characteristic_create(attr, service);
> +       if (!charac) {
> +               data->failed = true;
> +               return;
> +       }
> +
> +       queue_push_tail(service->chrcs, charac);
> +}
> +
> +static bool create_characteristics(struct gatt_db_attribute *attr,
> +                                               struct service *service)
> +{
> +       struct export_data data;
> +
> +       data.root = service;
> +       data.failed = false;
> +
> +       gatt_db_service_foreach_char(attr, export_char, &data);
> +
> +       return !data.failed;
> +}
> +
> +static void notify_chrcs(void *data, void *user_data)
> +{
> +       struct service *service = data;
> +
> +       service->chrcs_ready = true;
> +
> +       g_dbus_emit_property_changed(btd_get_dbus_connection(), service->path,
> +                                                       GATT_SERVICE_IFACE,
> +                                                       "Characteristics");
> +}
> +
> +static gboolean set_chrcs_ready(gpointer user_data)
> +{
> +       struct btd_gatt_client *client = user_data;
> +
> +       if (!client->gatt)
> +               return FALSE;
> +
> +       queue_foreach(client->services, notify_chrcs, NULL);
> +
> +       return FALSE;
> +}
> +
>  static void export_service(struct gatt_db_attribute *attr, void *user_data)
>  {
>         struct btd_gatt_client *client = user_data;
> @@ -189,6 +504,12 @@ static void export_service(struct gatt_db_attribute *attr, void *user_data)
>         if (!service)
>                 return;
>
> +       if (!create_characteristics(attr, service)) {
> +               error("Exporting characteristics failed");
> +               unregister_service(service);
> +               return;
> +       }
> +
>         queue_push_tail(client->services, service);
>  }
>
> @@ -197,6 +518,13 @@ static void create_services(struct btd_gatt_client *client)
>         DBG("Exporting objects for GATT services: %s", client->devaddr);
>
>         gatt_db_foreach_service(client->db, NULL, export_service, client);
> +
> +       /*
> +        * Asynchronously update the "Characteristics" property of each service.
> +        * We do this so that users have a way to know that all characteristics
> +        * of a service have been exported.
> +        */
> +       g_idle_add(set_chrcs_ready, client);
>  }
>
>  struct btd_gatt_client *btd_gatt_client_new(struct btd_device *device)
> --
> 2.2.0.rc0.207.ga3a616c
>
> --
> To unsubscribe from this list: send the line "unsubscribe linux-bluetooth" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html



-- 
Luiz Augusto von Dentz
