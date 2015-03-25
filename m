Return-Path: <cyrus@holtmann.org>
MIME-Version: 1.0
In-Reply-To: <1427189873-29770-1-git-send-email-luiz.dentz@gmail.com>
References: <1427189873-29770-1-git-send-email-luiz.dentz@gmail.com>
Date: Wed, 25 Mar 2015 12:39:50 +0200
Message-ID: <CABBYNZJ0ztcAok=5V2E172585WQUy+ZGVJirUHS9vc+20FCahA@mail.gmail.com>
Subject: Re: [PATCH BlueZ 1/4] core/gatt: Add implementation of RegisterProfile
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
To: "linux-bluetooth@vger.kernel.org" <linux-bluetooth@vger.kernel.org>
Content-Type: text/plain; charset=UTF-8
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi,

On Tue, Mar 24, 2015 at 11:37 AM, Luiz Augusto von Dentz
<luiz.dentz@gmail.com> wrote:
> From: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>
>
> This adds initial implementation of RegisterProfile.
> ---
>  src/gatt-database.c | 197 ++++++++++++++++++++++++++++++++++++++++++++++++++++
>  1 file changed, 197 insertions(+)
>
> diff --git a/src/gatt-database.c b/src/gatt-database.c
> index e07c70f..e701439 100644
> --- a/src/gatt-database.c
> +++ b/src/gatt-database.c
> @@ -23,6 +23,7 @@
>
>  #include <stdint.h>
>  #include <stdlib.h>
> +#include <errno.h>
>
>  #include "lib/bluetooth.h"
>  #include "lib/sdp.h"
> @@ -41,6 +42,7 @@
>  #include "device.h"
>  #include "gatt-database.h"
>  #include "dbus-common.h"
> +#include "profile.h"
>
>  #ifndef ATT_CID
>  #define ATT_CID 4
> @@ -75,6 +77,7 @@ struct btd_gatt_database {
>         struct gatt_db_attribute *svc_chngd;
>         struct gatt_db_attribute *svc_chngd_ccc;
>         struct queue *services;
> +       struct queue *profiles;
>  };
>
>  struct external_service {
> @@ -91,6 +94,14 @@ struct external_service {
>         struct queue *descs;
>  };
>
> +struct external_profile {
> +       struct btd_gatt_database *database;
> +       char *owner;
> +       char *path;     /* Path to GattProfile1 */
> +       unsigned int id;
> +       struct queue *profiles; /* btd_profile list */
> +};
> +
>  struct external_chrc {
>         struct external_service *service;
>         char *path;
> @@ -364,6 +375,35 @@ static void service_free(void *data)
>         free(service);
>  }
>
> +static void profile_remove(void *data)
> +{
> +       struct btd_profile *p = data;
> +
> +       DBG("Removed \"%s\"", p->name);
> +
> +       adapter_foreach(adapter_remove_profile, p);
> +
> +       g_free((void *) p->name);
> +       g_free((void *) p->remote_uuid);
> +
> +       free(p);
> +}
> +
> +static void profile_free(void *data)
> +{
> +       struct external_profile *profile = data;
> +
> +       queue_destroy(profile->profiles, profile_remove);
> +
> +       if (profile->id)
> +               g_dbus_remove_watch(btd_get_dbus_connection(), profile->id);
> +
> +       g_free(profile->owner);
> +       g_free(profile->path);
> +
> +       free(profile);
> +}
> +
>  static void gatt_database_free(void *data)
>  {
>         struct btd_gatt_database *database = data;
> @@ -390,6 +430,7 @@ static void gatt_database_free(void *data)
>
>         queue_destroy(database->device_states, device_state_free);
>         queue_destroy(database->services, service_free);
> +       queue_destroy(database->profiles, profile_free);
>         queue_destroy(database->ccc_callbacks, ccc_cb_free);
>         database->device_states = NULL;
>         database->ccc_callbacks = NULL;
> @@ -2133,6 +2174,154 @@ static DBusMessage *manager_unregister_service(DBusConnection *conn,
>         return dbus_message_new_method_return(msg);
>  }
>
> +static void profile_exited(DBusConnection *conn, void *user_data)
> +{
> +       struct external_profile *profile = user_data;
> +
> +       DBG("\"%s\" exited", profile->owner);
> +
> +       profile->id = 0;
> +
> +       queue_remove(profile->database->profiles, profile);
> +
> +       profile_free(profile);
> +}
> +
> +static int profile_add(struct external_profile *profile, const char *uuid)
> +{
> +       struct btd_profile *p;
> +
> +       p = new0(struct btd_profile, 1);
> +       if (!p)
> +               return -ENOMEM;
> +
> +       /* Assign directly to avoid having extra fields */
> +       p->name = (const void *) g_strdup_printf("%s%s/%s", profile->owner,
> +                                                       profile->path, uuid);
> +       if (!p->name)
> +               return -ENOMEM;
> +
> +       p->remote_uuid = (const void *) g_strdup(uuid);
> +       if (!p->remote_uuid)
> +               return -ENOMEM;
> +
> +       p->auto_connect = true;
> +
> +       queue_push_tail(profile->profiles, p);
> +
> +       DBG("Added \"%s\"", p->name);
> +
> +       return 0;
> +}
> +
> +static void add_profile(void *data, void *user_data)
> +{
> +       struct btd_adapter *adapter = user_data;
> +
> +       adapter_add_profile(adapter, data);
> +}
> +
> +static int profile_create(DBusConnection *conn,
> +                               struct btd_gatt_database *database,
> +                               const char *sender, const char *path,
> +                               DBusMessageIter *iter)
> +{
> +       struct external_profile *profile;
> +       DBusMessageIter uuids;
> +
> +       if (!path || !g_str_has_prefix(path, "/"))
> +               return -EINVAL;
> +
> +       profile = new0(struct external_profile, 1);
> +       if (!profile)
> +               return -ENOMEM;
> +
> +       profile->owner = g_strdup(sender);
> +       if (!profile->owner)
> +               goto fail;
> +
> +       profile->path = g_strdup(path);
> +       if (!profile->path)
> +               goto fail;
> +
> +       profile->profiles = queue_new();
> +       if (!profile->profiles)
> +               goto fail;
> +
> +       profile->database = database;
> +       profile->id = g_dbus_add_disconnect_watch(conn, sender, profile_exited,
> +                                                               profile, NULL);
> +
> +       dbus_message_iter_recurse(iter, &uuids);
> +
> +       while (dbus_message_iter_get_arg_type(&uuids) == DBUS_TYPE_STRING) {
> +               const char *uuid;
> +
> +               dbus_message_iter_get_basic(&uuids, &uuid);
> +
> +               if (profile_add(profile, uuid) < 0)
> +                       goto fail;
> +
> +               dbus_message_iter_next(&uuids);
> +       }
> +
> +       if (queue_isempty(profile->profiles))
> +               goto fail;
> +
> +       queue_foreach(profile->profiles, add_profile, database->adapter);
> +       queue_push_tail(database->profiles, profile);
> +
> +       return 0;
> +
> +fail:
> +       profile_free(profile);
> +       return -EINVAL;
> +}
> +
> +static bool match_profile(const void *a, const void *b)
> +{
> +       const struct external_profile *profile = a;
> +       const struct svc_match_data *data = b;
> +
> +       return g_strcmp0(profile->path, data->path) == 0 &&
> +                               g_strcmp0(profile->owner, data->sender) == 0;
> +}
> +
> +static DBusMessage *manager_register_profile(DBusConnection *conn,
> +                                       DBusMessage *msg, void *user_data)
> +{
> +       struct btd_gatt_database *database = user_data;
> +       const char *sender = dbus_message_get_sender(msg);
> +       DBusMessageIter args;
> +       const char *path;
> +       struct svc_match_data match_data;
> +
> +       DBG("sender %s", sender);
> +
> +       if (!dbus_message_iter_init(msg, &args))
> +               return btd_error_invalid_args(msg);
> +
> +       if (dbus_message_iter_get_arg_type(&args) != DBUS_TYPE_OBJECT_PATH)
> +               return btd_error_invalid_args(msg);
> +
> +       dbus_message_iter_get_basic(&args, &path);
> +
> +       match_data.path = path;
> +       match_data.sender = sender;
> +
> +       if (queue_find(database->profiles, match_profile, &match_data))
> +               return btd_error_already_exists(msg);
> +
> +       dbus_message_iter_next(&args);
> +       if (dbus_message_iter_get_arg_type(&args) != DBUS_TYPE_ARRAY)
> +               return btd_error_invalid_args(msg);
> +
> +       if (profile_create(conn, database, sender, path, &args) < 0)
> +               return btd_error_failed(msg, "Failed to register profile");
> +
> +       return dbus_message_new_method_return(msg);
> +}
> +
>  static const GDBusMethodTable manager_methods[] = {
>         { GDBUS_EXPERIMENTAL_ASYNC_METHOD("RegisterService",
>                         GDBUS_ARGS({ "service", "o" }, { "options", "a{sv}" }),
> @@ -2140,6 +2329,10 @@ static const GDBusMethodTable manager_methods[] = {
>         { GDBUS_EXPERIMENTAL_ASYNC_METHOD("UnregisterService",
>                                         GDBUS_ARGS({ "service", "o" }),
>                                         NULL, manager_unregister_service) },
> +       { GDBUS_EXPERIMENTAL_ASYNC_METHOD("RegisterProfile",
> +                       GDBUS_ARGS({ "profile", "o" }, { "UUIDs", "as" },
> +                       { "options", "a{sv}" }), NULL,
> +                       manager_register_profile) },
>         { }
>  };
>
> @@ -2169,6 +2362,10 @@ struct btd_gatt_database *btd_gatt_database_new(struct btd_adapter *adapter)
>         if (!database->services)
>                 goto fail;
>
> +       database->profiles = queue_new();
> +       if (!database->profiles)
> +               goto fail;
> +
>         database->ccc_callbacks = queue_new();
>         if (!database->ccc_callbacks)
>                 goto fail;
> --
> 2.1.0

Applied.


-- 
Luiz Augusto von Dentz
