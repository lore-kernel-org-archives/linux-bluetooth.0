Return-Path: <cyrus@holtmann.org>
MIME-Version: 1.0
In-Reply-To: <CABBYNZ+mD5QRvGHCo+Ugr7P2_M0-thTr_DHpyndTyRRn-ZmNEw@mail.gmail.com>
References: <1424483824-27374-1-git-send-email-armansito@chromium.org>
	<1424483824-27374-7-git-send-email-armansito@chromium.org>
	<CABBYNZ+mD5QRvGHCo+Ugr7P2_M0-thTr_DHpyndTyRRn-ZmNEw@mail.gmail.com>
Date: Mon, 23 Feb 2015 17:45:34 +0200
Message-ID: <CABBYNZ+ERC-uiurkUKRVjxF_d5jrihpjRQKxFGop3E8BDMb3kw@mail.gmail.com>
Subject: Re: [PATCH BlueZ 06/18] core: gatt: Implement GattManager1.RegisterService
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
To: Arman Uguray <armansito@chromium.org>
Cc: "linux-bluetooth@vger.kernel.org" <linux-bluetooth@vger.kernel.org>
Content-Type: text/plain; charset=UTF-8
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Arman,

On Mon, Feb 23, 2015 at 5:31 PM, Luiz Augusto von Dentz
<luiz.dentz@gmail.com> wrote:
> Hi Arman,
>
> On Sat, Feb 21, 2015 at 3:56 AM, Arman Uguray <armansito@chromium.org> wrote:
>> This patch adds the initial implementation of the RegisterService
>> method. Currently only one attribute entry is created in the local
>> database for the GATT service declaration.
>> ---
>>  src/gatt-manager.c | 340 ++++++++++++++++++++++++++++++++++++++++++++++++++++-
>>  1 file changed, 339 insertions(+), 1 deletion(-)
>>
>> diff --git a/src/gatt-manager.c b/src/gatt-manager.c
>> index 296eabc..a69c7ea 100644
>> --- a/src/gatt-manager.c
>> +++ b/src/gatt-manager.c
>> @@ -26,27 +26,347 @@
>>
>>  #include <dbus/dbus.h>
>>  #include <gdbus/gdbus.h>
>> +#include <glib.h>
>>
>> +#include "lib/bluetooth.h"
>> +#include "lib/uuid.h"
>>  #include "adapter.h"
>>  #include "gatt-manager.h"
>> +#include "gatt-database.h"
>>  #include "dbus-common.h"
>>  #include "log.h"
>>  #include "error.h"
>>  #include "src/shared/queue.h"
>>  #include "src/shared/util.h"
>> +#include "src/shared/att.h"
>> +#include "src/shared/gatt-db.h"
>>
>>  #define GATT_MANAGER_IFACE     "org.bluez.GattManager1"
>> +#define GATT_SERVICE_IFACE     "org.bluez.GattService1"
>> +
>> +#define UUID_GAP       0x1800
>> +#define UUID_GATT      0x1801
>>
>>  struct btd_gatt_manager {
>>         struct btd_adapter *adapter;
>> +       struct gatt_db *db;
>> +       struct queue *services;
>> +};
>> +
>> +struct external_service {
>> +       struct btd_gatt_manager *manager;
>> +       char *owner;
>> +       char *om_path;  /* Path to ObjectManager */
>> +       char *path;     /* Path to GattService1 */
>> +       DBusMessage *reg;
>> +       GDBusClient *client;
>> +       GDBusProxy *proxy;
>> +       struct gatt_db_attribute *attrib;
>>  };
>>
>> +static bool match_service_path(const void *a, const void *b)
>> +{
>> +       const struct external_service *service = a;
>> +       const char *path = b;
>> +
>> +       return g_strcmp0(service->path, path) == 0;
>> +}
>> +
>> +static void service_free(void *data)
>> +{
>> +       struct external_service *service = data;
>> +
>> +       gatt_db_remove_service(service->manager->db, service->attrib);
>> +
>> +       if (service->client) {
>> +               g_dbus_client_set_disconnect_watch(service->client, NULL, NULL);
>> +               g_dbus_client_set_proxy_handlers(service->client, NULL, NULL,
>> +                                                               NULL, NULL);
>> +               g_dbus_client_set_ready_watch(service->client, NULL, NULL);
>> +               g_dbus_client_unref(service->client);
>> +       }
>> +
>> +       if (service->proxy)
>> +               g_dbus_proxy_unref(service->proxy);
>> +
>> +       if (service->reg)
>> +               dbus_message_unref(service->reg);
>> +
>> +       if (service->owner)
>> +               g_free(service->owner);
>> +
>> +       if (service->path)
>> +               g_free(service->path);
>> +
>> +       if (service->om_path)
>> +               g_free(service->om_path);
>> +
>> +       free(service);
>> +}
>> +
>> +static gboolean service_free_idle_cb(void *data)
>> +{
>> +       service_free(data);
>> +
>> +       return FALSE;
>> +}
>> +
>> +static void service_remove_helper(void *data)
>> +{
>> +       struct external_service *service = data;
>> +
>> +       queue_remove(service->manager->services, service);
>> +
>> +       /*
>> +        * Do not run in the same loop, this may be a disconnect
>> +        * watch call and GDBusClient should not be destroyed.
>> +        */
>> +       g_idle_add(service_free_idle_cb, service);
>> +}
>> +
>> +static void client_disconnect_cb(DBusConnection *conn, void *user_data)
>> +{
>> +       DBG("Client disconnected");
>> +
>> +       service_remove_helper(user_data);
>> +}
>> +
>> +static void service_remove(void *data)
>> +{
>> +       struct external_service *service = data;
>> +
>> +       /*
>> +        * Set callback to NULL to avoid potential race condition
>> +        * when calling remove_service and GDBusClient unref.
>> +        */
>> +       g_dbus_client_set_disconnect_watch(service->client, NULL, NULL);
>> +
>> +       service_remove_helper(service);
>> +}
>> +
>> +static void proxy_added_cb(GDBusProxy *proxy, void *user_data)
>> +{
>> +       struct external_service *service = user_data;
>> +       const char *iface, *path;
>> +
>> +       iface = g_dbus_proxy_get_interface(proxy);
>> +       path = g_dbus_proxy_get_path(proxy);
>> +
>> +       if (!g_str_has_prefix(path, service->path))
>> +               return;
>> +
>> +       /* TODO: Handle characteristic and descriptors here */
>> +
>> +       if (g_strcmp0(iface, GATT_SERVICE_IFACE))
>> +               return;
>> +
>> +       DBG("Object added to service - path: %s, iface: %s", path, iface);
>> +
>> +       service->proxy = g_dbus_proxy_ref(proxy);
>> +}
>> +
>> +static void proxy_removed_cb(GDBusProxy *proxy, void *user_data)
>> +{
>> +       struct external_service *service = user_data;
>> +       const char *path;
>> +
>> +       path = g_dbus_proxy_get_path(proxy);
>> +
>> +       if (!g_str_has_prefix(path, service->path))
>> +               return;
>> +
>> +       DBG("Proxy removed - removing service: %s", service->path);
>> +
>> +       service_remove(service);
>> +}
>> +
>> +static bool parse_uuid(GDBusProxy *proxy, bt_uuid_t *uuid)
>> +{
>> +       DBusMessageIter iter;
>> +       bt_uuid_t tmp;
>> +       const char *uuidstr;
>> +
>> +       if (!g_dbus_proxy_get_property(proxy, "UUID", &iter))
>> +               return false;
>> +
>> +       if (dbus_message_iter_get_arg_type(&iter) != DBUS_TYPE_STRING)
>> +               return false;
>> +
>> +       dbus_message_iter_get_basic(&iter, &uuidstr);
>> +
>> +       if (bt_string_to_uuid(uuid, uuidstr) < 0)
>> +               return false;
>> +
>> +       /* GAP & GATT services are created and managed by BlueZ */
>> +       bt_uuid16_create(&tmp, UUID_GAP);
>> +       if (!bt_uuid_cmp(&tmp, uuid)) {
>> +               error("GAP service must be handled by BlueZ");
>> +               return false;
>> +       }
>> +
>> +       bt_uuid16_create(&tmp, UUID_GATT);
>> +       if (!bt_uuid_cmp(&tmp, uuid)) {
>> +               error("GATT service must be handled by BlueZ");
>> +               return false;
>> +       }
>> +
>> +       return true;
>> +}
>> +
>> +static bool parse_primary(GDBusProxy *proxy, bool *primary)
>> +{
>> +       DBusMessageIter iter;
>> +
>> +       if (!g_dbus_proxy_get_property(proxy, "Primary", &iter))
>> +               return false;
>> +
>> +       if (dbus_message_iter_get_arg_type(&iter) != DBUS_TYPE_BOOLEAN)
>> +               return false;
>> +
>> +       dbus_message_iter_get_basic(&iter, primary);
>> +
>> +       return true;
>> +}
>> +
>> +static bool create_service_entry(struct external_service *service)
>> +{
>> +       bt_uuid_t uuid;
>> +       bool primary;
>> +
>> +       if (!parse_uuid(service->proxy, &uuid)) {
>> +               error("Failed to read \"UUID\" property of service");
>> +               return false;
>> +       }
>> +
>> +       if (!parse_primary(service->proxy, &primary)) {
>> +               error("Failed to read \"Primary\" property of service");
>> +               return false;
>> +       }
>> +
>> +       /* TODO: Determine the correct attribute count */
>> +       service->attrib = gatt_db_add_service(service->manager->db, &uuid,
>> +                                                               primary, 1);
>> +       if (!service->attrib)
>> +               return false;
>> +
>> +       gatt_db_service_set_active(service->attrib, true);
>> +
>> +       return true;
>> +}
>> +
>> +static void client_ready_cb(GDBusClient *client, void *user_data)
>> +{
>> +       struct external_service *service = user_data;
>> +       DBusMessage *reply;
>> +       bool fail = false;
>> +
>> +       if (!service->proxy) {
>> +               error("No external GATT objects found");
>> +               fail = true;
>> +               reply = btd_error_failed(service->reg,
>> +                                               "No service object found");
>> +               goto reply;
>> +       }
>> +
>> +       if (!create_service_entry(service)) {
>> +               error("Failed to create GATT service entry in local database");
>> +               fail = true;
>> +               reply = btd_error_failed(service->reg,
>> +                                       "Failed to create entry in database");
>> +               goto reply;
>> +       }
>> +
>> +       DBG("GATT service registered: %s", service->path);
>> +
>> +       reply = dbus_message_new_method_return(service->reg);
>> +
>> +reply:
>> +       g_dbus_send_message(btd_get_dbus_connection(), reply);
>> +       dbus_message_unref(service->reg);
>> +       service->reg = NULL;
>> +
>> +       if (fail)
>> +               service_remove(service);
>> +}
>> +
>> +static struct external_service *service_create(DBusConnection *conn,
>> +                                       DBusMessage *msg, const char *path,
>> +                                       const char *om_path)
>> +{
>> +       struct external_service *service;
>> +       const char *sender = dbus_message_get_sender(msg);
>> +
>> +       service = new0(struct external_service, 1);
>> +       if (!service)
>> +               return NULL;
>> +
>> +       service->client = g_dbus_client_new(conn, sender, om_path);
>> +       if (!service->client)
>> +               goto fail;
>> +
>> +       service->owner = g_strdup(sender);
>> +       if (!service->owner)
>> +               goto fail;
>> +
>> +       service->path = g_strdup(path);
>> +       if (!service->path)
>> +               goto fail;
>> +
>> +       service->om_path = g_strdup(om_path);
>> +       if (!service->om_path)
>> +               goto fail;
>> +
>> +       service->reg = dbus_message_ref(msg);
>> +
>> +       g_dbus_client_set_disconnect_watch(service->client,
>> +                                               client_disconnect_cb, service);
>> +       g_dbus_client_set_proxy_handlers(service->client, proxy_added_cb,
>> +                                                       proxy_removed_cb, NULL,
>> +                                                       service);
>> +       g_dbus_client_set_ready_watch(service->client, client_ready_cb,
>> +                                                               service);
>> +
>> +       return service;
>> +
>> +fail:
>> +       service_free(service);
>> +       return NULL;
>> +}
>> +
>>  static DBusMessage *manager_register_service(DBusConnection *conn,
>>                                         DBusMessage *msg, void *user_data)
>>  {
>> +       struct btd_gatt_manager *manager = user_data;
>> +       DBusMessageIter args;
>> +       const char *path;
>> +       struct external_service *service;
>> +
>>         DBG("RegisterService");
>>
>> -       /* TODO */
>> +       if (!dbus_message_iter_init(msg, &args))
>> +               return btd_error_invalid_args(msg);
>> +
>> +       if (dbus_message_iter_get_arg_type(&args) != DBUS_TYPE_OBJECT_PATH)
>> +               return btd_error_invalid_args(msg);
>> +
>> +       dbus_message_iter_get_basic(&args, &path);
>> +
>> +       if (queue_find(manager->services, match_service_path, path))
>> +               return btd_error_already_exists(msg);
>
> Here is the tricky part of ObjectManager, we should avoid creating
> different client instance for it since it caches the whole object
> hierarchy it becomes really expensive as the process adds more
> services. So we have to detect if we already a client instance for the
> sender, if we do then we proceed with g_dbus_client_ref,
> g_dbus_proxy_new, etc. Also this needs to match the sender not only
> path, so this needs fixing anyway.

Another thing we could perhaps do is to change this to be
RegisterServices, so the application just need to register itself and
bluetoothd will keep track of services, then perhaps we can have an
optional property to GattService to indicate if the service is active
or not in addition to InterfacesRemoved if we want to give the
application the ability to dynamically activate/deactivate its
services.

>
>> +
>> +       dbus_message_iter_next(&args);
>> +       if (dbus_message_iter_get_arg_type(&args) != DBUS_TYPE_ARRAY)
>> +               return btd_error_invalid_args(msg);
>> +
>> +       service = service_create(conn, msg, path, "/");
>
> If we are going to hardcode "/" there is no point in storing it.
>
>> +       if (!service)
>> +               return btd_error_failed(msg, "Failed to register service");
>> +
>> +       DBG("Registering service - path: %s", path);
>> +
>> +       service->manager = manager;
>> +       queue_push_tail(manager->services, service);
>> +
>>         return NULL;
>>  }
>>
>> @@ -72,11 +392,24 @@ static const GDBusMethodTable manager_methods[] = {
>>  static struct btd_gatt_manager *manager_create(struct btd_adapter *adapter)
>>  {
>>         struct btd_gatt_manager *manager;
>> +       struct gatt_db *db;
>> +       struct btd_gatt_database *database;
>> +
>> +       database = btd_adapter_get_database(adapter);
>> +       db = btd_gatt_database_get_db(database);
>> +       if (!db)
>> +               return NULL;
>>
>>         manager = new0(struct btd_gatt_manager, 1);
>>         if (!manager)
>>                 return NULL;
>>
>> +       manager->services = queue_new();
>> +       if (!manager->services) {
>> +               free(manager);
>> +               return NULL;
>> +       }
>> +
>>         manager->adapter = adapter;
>>
>>         if (!g_dbus_register_interface(btd_get_dbus_connection(),
>> @@ -85,10 +418,13 @@ static struct btd_gatt_manager *manager_create(struct btd_adapter *adapter)
>>                                                 manager_methods, NULL, NULL,
>>                                                 manager, NULL)) {
>>                 error("Failed to register " GATT_MANAGER_IFACE);
>> +               queue_destroy(manager->services, NULL);
>>                 free(manager);
>>                 return NULL;
>>         }
>>
>> +       manager->db = gatt_db_ref(db);
>> +
>>         return manager;
>>  }
>>
>> @@ -117,5 +453,7 @@ void btd_gatt_manager_destroy(struct btd_gatt_manager *manager)
>>         g_dbus_unregister_interface(btd_get_dbus_connection(),
>>                                         adapter_get_path(manager->adapter),
>>                                         GATT_MANAGER_IFACE);
>> +       queue_destroy(manager->services, service_free);
>> +       gatt_db_unref(manager->db);
>>         free(manager);
>>  }
>> --
>> 2.2.0.rc0.207.ga3a616c
>>
>
>
>
> --
> Luiz Augusto von Dentz



-- 
Luiz Augusto von Dentz
