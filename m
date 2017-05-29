Return-Path: <linux-bluetooth-owner@vger.kernel.org>
MIME-Version: 1.0
In-Reply-To: <20170525103712.19143-1-luiz.dentz@gmail.com>
References: <20170525103712.19143-1-luiz.dentz@gmail.com>
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Date: Mon, 29 May 2017 16:15:37 +0300
Message-ID: <CABBYNZ+ZcFxdj1Bc7_m5rt_RQ8FP9+yUTXPs_iNC0KvEzKaFbQ@mail.gmail.com>
Subject: Re: [PATCH BlueZ] client: Fix using RegisterProfile
To: "linux-bluetooth@vger.kernel.org" <linux-bluetooth@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi,

On Thu, May 25, 2017 at 1:37 PM, Luiz Augusto von Dentz
<luiz.dentz@gmail.com> wrote:
> From: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>
>
> RegisterProfile no longer works for registering GattProfile instances
> as this functionality has been moved to RegisterApplication.
>
> In order to make this more clear this replaces the (un)register-profile
> with (un)register-application and enable ObjectManager, here is an
> example how to register for 12345678-1234-5678-1234-56789abcdef1:
>
> [bluetooth]# register-application 12345678-1234-5678-1234-56789abcdef1
> Application registered
>
> bluetoothd[8777]: src/gatt-database.c:manager_register_app() Registering application: :1.483:/
> bluetoothd[8777]: src/gatt-database.c:proxy_added_cb() Object received: /org/bluez/application, iface: org.bluez.GattProfile1
> bluetoothd[8777]: src/gatt-database.c:proxy_added_cb() Object received: /org/bluez/agent, iface: org.bluez.Agent1
> bluetoothd[8777]: src/gatt-database.c:profile_add() Added ":1.483/org/bluez/application/12345678-1234-5678-1234-56789abcdef1"
> bluetoothd[8777]: src/gatt-database.c:client_ready_cb() GATT application registered: :1.483:/
>
> [bluetooth]# unregister-application
> Application unregistered
>
> bluetoothd[8777]: src/gatt-database.c:profile_remove() Removed ":1.483/org/bluez/application/12345678-1234-5678-1234-56789abcdef1"
> bluetoothd[8777]: src/gatt-database.c:profile_release() Releasing ":1.483"
> ---
>  client/gatt.c | 94 +++++++++++++++++++++++++++++++++++++----------------------
>  client/gatt.h |  5 ++--
>  client/main.c | 13 +++++----
>  3 files changed, 68 insertions(+), 44 deletions(-)
>
> diff --git a/client/gatt.c b/client/gatt.c
> index 79bc7a3..40d3f6a 100644
> --- a/client/gatt.c
> +++ b/client/gatt.c
> @@ -37,12 +37,13 @@
>  #include <readline/history.h>
>  #include <glib.h>
>
> +#include "src/shared/queue.h"
>  #include "gdbus/gdbus.h"
>  #include "monitor/uuid.h"
>  #include "display.h"
>  #include "gatt.h"
>
> -#define PROFILE_PATH "/org/bluez/profile"
> +#define APP_PATH "/org/bluez/app"
>  #define PROFILE_INTERFACE "org.bluez.GattProfile1"
>
>  /* String display constants */
> @@ -54,6 +55,7 @@ static GList *services;
>  static GList *characteristics;
>  static GList *descriptors;
>  static GList *managers;
> +static GList *uuids;
>
>  static void print_service(GDBusProxy *proxy, const char *description)
>  {
> @@ -626,21 +628,13 @@ void gatt_notify_attribute(GDBusProxy *proxy, bool enable)
>                                                 g_dbus_proxy_get_path(proxy));
>  }
>
> -static void register_profile_setup(DBusMessageIter *iter, void *user_data)
> +static void register_app_setup(DBusMessageIter *iter, void *user_data)
>  {
> -       wordexp_t *w = user_data;
> -       DBusMessageIter uuids, opt;
> -       const char *path = PROFILE_PATH;
> -       size_t i;
> +       DBusMessageIter opt;
> +       const char *path = "/";
>
>         dbus_message_iter_append_basic(iter, DBUS_TYPE_OBJECT_PATH, &path);
>
> -       dbus_message_iter_open_container(iter, DBUS_TYPE_ARRAY, "s", &uuids);
> -       for (i = 0; i < w->we_wordc; i++)
> -               dbus_message_iter_append_basic(&uuids, DBUS_TYPE_STRING,
> -                                                       &w->we_wordv[i]);
> -       dbus_message_iter_close_container(iter, &uuids);
> -
>         dbus_message_iter_open_container(iter, DBUS_TYPE_ARRAY,
>                                         DBUS_DICT_ENTRY_BEGIN_CHAR_AS_STRING
>                                         DBUS_TYPE_STRING_AS_STRING
> @@ -651,19 +645,19 @@ static void register_profile_setup(DBusMessageIter *iter, void *user_data)
>
>  }
>
> -static void register_profile_reply(DBusMessage *message, void *user_data)
> +static void register_app_reply(DBusMessage *message, void *user_data)
>  {
>         DBusError error;
>
>         dbus_error_init(&error);
>
>         if (dbus_set_error_from_message(&error, message) == TRUE) {
> -               rl_printf("Failed to register profile: %s\n", error.name);
> +               rl_printf("Failed to register application: %s\n", error.name);
>                 dbus_error_free(&error);
>                 return;
>         }
>
> -       rl_printf("Profile registered\n");
> +       rl_printf("Application registered\n");
>  }
>
>  void gatt_add_manager(GDBusProxy *proxy)
> @@ -688,7 +682,7 @@ static int match_proxy(const void *a, const void *b)
>  static DBusMessage *release_profile(DBusConnection *conn,
>                                         DBusMessage *msg, void *user_data)
>  {
> -       g_dbus_unregister_interface(conn, PROFILE_PATH, PROFILE_INTERFACE);
> +       g_dbus_unregister_interface(conn, APP_PATH, PROFILE_INTERFACE);
>
>         return dbus_message_new_method_return(msg);
>  }
> @@ -698,10 +692,33 @@ static const GDBusMethodTable methods[] = {
>         { }
>  };
>
> -void gatt_register_profile(DBusConnection *conn, GDBusProxy *proxy,
> -                                                               wordexp_t *w)
> +static gboolean get_uuids(const GDBusPropertyTable *property,
> +                                       DBusMessageIter *iter, void *data)
> +{
> +       DBusMessageIter entry;
> +       GList *uuid;
> +
> +       dbus_message_iter_open_container(iter, DBUS_TYPE_ARRAY,
> +                               DBUS_TYPE_STRING_AS_STRING, &entry);
> +
> +       for (uuid = uuids; uuid; uuid = g_list_next(uuid->next))
> +               dbus_message_iter_append_basic(&entry, DBUS_TYPE_STRING,
> +                                                       &uuid->data);
> +
> +       dbus_message_iter_close_container(iter, &entry);
> +
> +       return TRUE;
> +}
> +
> +static const GDBusPropertyTable properties[] = {
> +       { "UUIDs", "as", get_uuids },
> +       { }
> +};
> +
> +void gatt_register_app(DBusConnection *conn, GDBusProxy *proxy, wordexp_t *w)
>  {
>         GList *l;
> +       unsigned int i;
>
>         l = g_list_find_custom(managers, proxy, match_proxy);
>         if (!l) {
> @@ -709,23 +726,27 @@ void gatt_register_profile(DBusConnection *conn, GDBusProxy *proxy,
>                 return;
>         }
>
> -       if (g_dbus_register_interface(conn, PROFILE_PATH,
> +       if (g_dbus_register_interface(conn, APP_PATH,
>                                         PROFILE_INTERFACE, methods,
> -                                       NULL, NULL, NULL, NULL) == FALSE) {
> -               rl_printf("Failed to register profile object\n");
> +                                       NULL, properties, NULL, NULL) == FALSE) {
> +               rl_printf("Failed to register application object\n");
>                 return;
>         }
>
> -       if (g_dbus_proxy_method_call(l->data, "RegisterProfile",
> -                                               register_profile_setup,
> -                                               register_profile_reply, w,
> +       for (i = 0; i < w->we_wordc; i++)
> +               uuids = g_list_append(uuids, g_strdup(w->we_wordv[i]));
> +
> +       if (g_dbus_proxy_method_call(l->data, "RegisterApplication",
> +                                               register_app_setup,
> +                                               register_app_reply, w,
>                                                 NULL) == FALSE) {
> -               rl_printf("Failed register profile\n");
> +               rl_printf("Failed register application\n");
> +               g_dbus_unregister_interface(conn, APP_PATH, PROFILE_INTERFACE);
>                 return;
>         }
>  }
>
> -static void unregister_profile_reply(DBusMessage *message, void *user_data)
> +static void unregister_app_reply(DBusMessage *message, void *user_data)
>  {
>         DBusConnection *conn = user_data;
>         DBusError error;
> @@ -733,24 +754,27 @@ static void unregister_profile_reply(DBusMessage *message, void *user_data)
>         dbus_error_init(&error);
>
>         if (dbus_set_error_from_message(&error, message) == TRUE) {
> -               rl_printf("Failed to unregister profile: %s\n", error.name);
> +               rl_printf("Failed to unregister application: %s\n", error.name);
>                 dbus_error_free(&error);
>                 return;
>         }
>
> -       rl_printf("Profile unregistered\n");
> +       g_list_free_full(uuids, g_free);
> +       uuids = NULL;
> +
> +       rl_printf("Application unregistered\n");
>
> -       g_dbus_unregister_interface(conn, PROFILE_PATH, PROFILE_INTERFACE);
> +       g_dbus_unregister_interface(conn, APP_PATH, PROFILE_INTERFACE);
>  }
>
> -static void unregister_profile_setup(DBusMessageIter *iter, void *user_data)
> +static void unregister_app_setup(DBusMessageIter *iter, void *user_data)
>  {
> -       const char *path = PROFILE_PATH;
> +       const char *path = "/";
>
>         dbus_message_iter_append_basic(iter, DBUS_TYPE_OBJECT_PATH, &path);
>  }
>
> -void gatt_unregister_profile(DBusConnection *conn, GDBusProxy *proxy)
> +void gatt_unregister_app(DBusConnection *conn, GDBusProxy *proxy)
>  {
>         GList *l;
>
> @@ -760,9 +784,9 @@ void gatt_unregister_profile(DBusConnection *conn, GDBusProxy *proxy)
>                 return;
>         }
>
> -       if (g_dbus_proxy_method_call(l->data, "UnregisterProfile",
> -                                               unregister_profile_setup,
> -                                               unregister_profile_reply, conn,
> +       if (g_dbus_proxy_method_call(l->data, "UnregisterApplication",
> +                                               unregister_app_setup,
> +                                               unregister_app_reply, conn,
>                                                 NULL) == FALSE) {
>                 rl_printf("Failed unregister profile\n");
>                 return;
> diff --git a/client/gatt.h b/client/gatt.h
> index 7a91975..4c9fd5b 100644
> --- a/client/gatt.h
> +++ b/client/gatt.h
> @@ -41,6 +41,5 @@ void gatt_notify_attribute(GDBusProxy *proxy, bool enable);
>  void gatt_add_manager(GDBusProxy *proxy);
>  void gatt_remove_manager(GDBusProxy *proxy);
>
> -void gatt_register_profile(DBusConnection *conn, GDBusProxy *proxy,
> -                                                               wordexp_t *w);
> -void gatt_unregister_profile(DBusConnection *conn, GDBusProxy *proxy);
> +void gatt_register_app(DBusConnection *conn, GDBusProxy *proxy, wordexp_t *w);
> +void gatt_unregister_app(DBusConnection *conn, GDBusProxy *proxy);
> diff --git a/client/main.c b/client/main.c
> index 255cbd5..2f269af 100644
> --- a/client/main.c
> +++ b/client/main.c
> @@ -1814,7 +1814,7 @@ static void cmd_notify(const char *arg)
>         gatt_notify_attribute(default_attr, enable ? true : false);
>  }
>
> -static void cmd_register_profile(const char *arg)
> +static void cmd_register_app(const char *arg)
>  {
>         wordexp_t w;
>
> @@ -1831,17 +1831,17 @@ static void cmd_register_profile(const char *arg)
>                 return;
>         }
>
> -       gatt_register_profile(dbus_conn, default_ctrl->proxy, &w);
> +       gatt_register_app(dbus_conn, default_ctrl->proxy, &w);
>
>         wordfree(&w);
>  }
>
> -static void cmd_unregister_profile(const char *arg)
> +static void cmd_unregister_app(const char *arg)
>  {
>         if (check_default_ctrl() == FALSE)
>                 return;
>
> -       gatt_unregister_profile(dbus_conn, default_ctrl->proxy);
> +       gatt_unregister_app(dbus_conn, default_ctrl->proxy);
>  }
>
>  static void cmd_version(const char *arg)
> @@ -2138,9 +2138,9 @@ static const struct {
>         { "write",        "<data=[xx xx ...]>", cmd_write,
>                                                 "Write attribute value" },
>         { "notify",       "<on/off>", cmd_notify, "Notify attribute value" },
> -       { "register-profile", "<UUID ...>", cmd_register_profile,
> +       { "register-application", "<UUID ...>", cmd_register_app,
>                                                 "Register profile to connect" },
> -       { "unregister-profile", NULL, cmd_unregister_profile,
> +       { "unregister-application", NULL, cmd_unregister_app,
>                                                 "Unregister profile" },
>         { "version",      NULL,       cmd_version, "Display version" },
>         { "quit",         NULL,       cmd_quit, "Quit program" },
> @@ -2407,6 +2407,7 @@ int main(int argc, char *argv[])
>
>         main_loop = g_main_loop_new(NULL, FALSE);
>         dbus_conn = g_dbus_setup_bus(DBUS_BUS_SYSTEM, NULL, NULL);
> +       g_dbus_attach_object_manager(dbus_conn);
>
>         setlinebuf(stdout);
>         rl_attempted_completion_function = cmd_completion;
> --
> 2.9.4
>

Applied.

-- 
Luiz Augusto von Dentz
