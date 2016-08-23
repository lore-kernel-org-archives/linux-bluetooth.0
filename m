Return-Path: <linux-bluetooth-owner@vger.kernel.org>
MIME-Version: 1.0
In-Reply-To: <1471951674-29115-1-git-send-email-michal.narajowski@codecoup.pl>
References: <1471951674-29115-1-git-send-email-michal.narajowski@codecoup.pl>
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Date: Tue, 23 Aug 2016 17:28:05 +0300
Message-ID: <CABBYNZLujxXmcOr8ATvrzBncHZLF-Z4HfgTAs20iJ_kVk-RpCw@mail.gmail.com>
Subject: Re: [PATCH BlueZ v7] client: Add better support for managing devices
 of multiple controllers
To: =?UTF-8?Q?Micha=C5=82_Narajowski?= <michal.narajowski@codecoup.pl>
Cc: "linux-bluetooth@vger.kernel.org" <linux-bluetooth@vger.kernel.org>
Content-Type: text/plain; charset=UTF-8
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Micha=C5=82,

On Tue, Aug 23, 2016 at 2:27 PM, Micha=C5=82 Narajowski
<michal.narajowski@codecoup.pl> wrote:
> Previously devices list was cleared when selecting new default
> controller. Now devices list is preserverd allowing to list and suggest
> devices for default controller even after changing the default
> controller.
> ---
>  client/main.c | 278 ++++++++++++++++++++++++++++++++++++++++++----------=
------
>  1 file changed, 200 insertions(+), 78 deletions(-)
>
> diff --git a/client/main.c b/client/main.c
> index 1ceddb0..a95f79c 100644
> --- a/client/main.c
> +++ b/client/main.c
> @@ -38,6 +38,7 @@
>  #include <readline/history.h>
>  #include <glib.h>
>
> +#include "src/shared/util.h"
>  #include "gdbus/gdbus.h"
>  #include "monitor/uuid.h"
>  #include "agent.h"
> @@ -59,13 +60,16 @@ static DBusConnection *dbus_conn;
>  static GDBusProxy *agent_manager;
>  static char *auto_register_agent =3D NULL;
>
> -static GDBusProxy *ad_manager;
> +struct adapter {
> +       GDBusProxy *proxy;
> +       GList *devices;
> +};
>
> -static GDBusProxy *default_ctrl;
> +static struct adapter *default_ctrl;
>  static GDBusProxy *default_dev;
>  static GDBusProxy *default_attr;
> +static GDBusProxy *ad_manager;
>  static GList *ctrl_list;
> -static GList *dev_list;
>
>  static guint input =3D 0;
>
> @@ -145,13 +149,10 @@ static void disconnect_handler(DBusConnection *conn=
ection, void *user_data)
>         rl_on_new_line();
>         rl_redisplay();
>
> -       g_list_free(ctrl_list);
> +       g_list_free_full(ctrl_list, proxy_leak);
>         ctrl_list =3D NULL;
>
>         default_ctrl =3D NULL;
> -
> -       g_list_free(dev_list);
> -       dev_list =3D NULL;
>  }
>
>  static void print_adapter(GDBusProxy *proxy, const char *description)
> @@ -174,7 +175,9 @@ static void print_adapter(GDBusProxy *proxy, const ch=
ar *description)
>                                 description ? : "",
>                                 description ? "] " : "",
>                                 address, name,
> -                               default_ctrl =3D=3D proxy ? "[default]" :=
 "");
> +                               default_ctrl &&
> +                               default_ctrl->proxy =3D=3D proxy ?
> +                               "[default]" : "");
>
>  }
>
> @@ -357,10 +360,13 @@ static gboolean service_is_child(GDBusProxy *servic=
e)
>
>         dbus_message_iter_get_basic(&iter, &device);
>
> -       for (l =3D dev_list; l; l =3D g_list_next(l)) {
> -               GDBusProxy *proxy =3D l->data;
> +       if (!default_ctrl)
> +               return FALSE;
> +
> +       for (l =3D default_ctrl->devices; l; l =3D g_list_next(l)) {
> +               struct adapter *adapter =3D l->data;
>
> -               path =3D g_dbus_proxy_get_path(proxy);
> +               path =3D g_dbus_proxy_get_path(adapter->proxy);
>
>                 if (!strcmp(path, device))
>                         return TRUE;
> @@ -369,6 +375,19 @@ static gboolean service_is_child(GDBusProxy *service=
)
>         return FALSE;
>  }
>
> +static struct adapter *find_parent(GDBusProxy *device)
> +{
> +       GList *list;
> +
> +       for (list =3D g_list_first(ctrl_list); list; list =3D g_list_next=
(list)) {
> +               struct adapter *adapter =3D list->data;
> +
> +               if (device_is_child(device, adapter->proxy) =3D=3D TRUE)
> +                       return adapter;
> +       }
> +       return NULL;
> +}
> +
>  static void set_default_device(GDBusProxy *proxy, const char *attribute)
>  {
>         char *desc =3D NULL;
> @@ -405,8 +424,13 @@ static void device_added(GDBusProxy *proxy)
>  {
>         DBusMessageIter iter;
>
> -       dev_list =3D g_list_append(dev_list, proxy);
> +       struct adapter *adapter =3D find_parent(proxy);
> +       if (!adapter) {
> +               /* TODO: Error */
> +               return;
> +       }
>
> +       adapter->devices =3D g_list_append(adapter->devices, proxy);
>         print_device(proxy, COLORED_NEW);
>
>         if (default_dev)
> @@ -422,6 +446,19 @@ static void device_added(GDBusProxy *proxy)
>         }
>  }
>
> +static void adapter_added(GDBusProxy *proxy)
> +{
> +       struct adapter *adapter =3D g_malloc0(sizeof(struct adapter));
> +
> +       adapter->proxy =3D proxy;
> +       ctrl_list =3D g_list_append(ctrl_list, adapter);
> +
> +       if (!default_ctrl)
> +               default_ctrl =3D adapter;
> +
> +       print_adapter(proxy, COLORED_NEW);
> +}
> +
>  static void proxy_added(GDBusProxy *proxy, void *user_data)
>  {
>         const char *interface;
> @@ -429,16 +466,9 @@ static void proxy_added(GDBusProxy *proxy, void *use=
r_data)
>         interface =3D g_dbus_proxy_get_interface(proxy);
>
>         if (!strcmp(interface, "org.bluez.Device1")) {
> -               if (device_is_child(proxy, default_ctrl) =3D=3D TRUE)
> -                       device_added(proxy);
> -
> +               device_added(proxy);
>         } else if (!strcmp(interface, "org.bluez.Adapter1")) {
> -               ctrl_list =3D g_list_append(ctrl_list, proxy);
> -
> -               if (!default_ctrl)
> -                       default_ctrl =3D proxy;
> -
> -               print_adapter(proxy, COLORED_NEW);
> +               adapter_added(proxy);
>         } else if (!strcmp(interface, "org.bluez.AgentManager1")) {
>                 if (!agent_manager) {
>                         agent_manager =3D proxy;
> @@ -472,33 +502,56 @@ static void set_default_attribute(GDBusProxy *proxy=
)
>         set_default_device(default_dev, path);
>  }
>
> -static void proxy_removed(GDBusProxy *proxy, void *user_data)
> +static void device_removed(GDBusProxy *proxy)
>  {
> -       const char *interface;
> +       struct adapter *adapter =3D find_parent(proxy);
> +       if (!adapter) {
> +               /* TODO: Error */
> +               return;
> +       }
>
> -       interface =3D g_dbus_proxy_get_interface(proxy);
> +       adapter->devices =3D g_list_remove(adapter->devices, proxy);
>
> -       if (!strcmp(interface, "org.bluez.Device1")) {
> -               if (device_is_child(proxy, default_ctrl) =3D=3D TRUE) {
> -                       dev_list =3D g_list_remove(dev_list, proxy);
> +       print_device(proxy, COLORED_DEL);
> +
> +       if (default_dev =3D=3D proxy)
> +               set_default_device(NULL, NULL);
> +}
> +
> +static void adapter_removed(GDBusProxy *proxy)
> +{
> +       GList *ll;
>
> -                       print_device(proxy, COLORED_DEL);
> +       for (ll =3D g_list_first(ctrl_list); ll; ll =3D g_list_next(ll)) =
{
> +               struct adapter *adapter =3D ll->data;
>
> -                       if (default_dev =3D=3D proxy)
> +               if (adapter->proxy =3D=3D proxy) {
> +                       print_adapter(proxy, COLORED_DEL);
> +
> +                       if (default_ctrl && default_ctrl->proxy =3D=3D pr=
oxy) {
> +                               default_ctrl =3D NULL;
>                                 set_default_device(NULL, NULL);
> +                       }
> +
> +                       ctrl_list =3D g_list_remove_link(ctrl_list, ll);
> +                       g_list_free(adapter->devices);
> +                       g_free(adapter);
> +                       g_list_free(ll);
> +                       return;
>                 }
> -       } else if (!strcmp(interface, "org.bluez.Adapter1")) {
> -               ctrl_list =3D g_list_remove(ctrl_list, proxy);
> +       }
> +}
>
> -               print_adapter(proxy, COLORED_DEL);
> +static void proxy_removed(GDBusProxy *proxy, void *user_data)
> +{
> +       const char *interface;
>
> -               if (default_ctrl =3D=3D proxy) {
> -                       default_ctrl =3D NULL;
> -                       set_default_device(NULL, NULL);
> +       interface =3D g_dbus_proxy_get_interface(proxy);
>
> -                       g_list_free(dev_list);
> -                       dev_list =3D NULL;
> -               }
> +       if (!strcmp(interface, "org.bluez.Device1")) {
> +               device_removed(proxy);
> +       } else if (!strcmp(interface, "org.bluez.Adapter1")) {
> +               adapter_removed(proxy);
>         } else if (!strcmp(interface, "org.bluez.AgentManager1")) {
>                 if (agent_manager =3D=3D proxy) {
>                         agent_manager =3D NULL;
> @@ -538,7 +591,8 @@ static void property_changed(GDBusProxy *proxy, const=
 char *name,
>         interface =3D g_dbus_proxy_get_interface(proxy);
>
>         if (!strcmp(interface, "org.bluez.Device1")) {
> -               if (device_is_child(proxy, default_ctrl) =3D=3D TRUE) {
> +               if (default_ctrl && device_is_child(proxy,
> +                                       default_ctrl->proxy) =3D=3D TRUE)=
 {
>                         DBusMessageIter addr_iter;
>                         char *str;
>
> @@ -601,6 +655,28 @@ static void message_handler(DBusConnection *connecti=
on,
>                                         dbus_message_get_member(message))=
;
>  }
>
> +static struct adapter *find_ctrl_by_address(GList *source, const char *a=
ddress)
> +{
> +       GList *list;
> +
> +       for (list =3D g_list_first(source); list; list =3D g_list_next(li=
st)) {
> +               struct adapter *adapter =3D list->data;
> +               DBusMessageIter iter;
> +               const char *str;
> +
> +               if (g_dbus_proxy_get_property(adapter->proxy,
> +                                       "Address", &iter) =3D=3D FALSE)
> +                       continue;
> +
> +               dbus_message_iter_get_basic(&iter, &str);
> +
> +               if (!strcmp(str, address))
> +                       return adapter;
> +       }
> +
> +       return NULL;
> +}
> +
>  static GDBusProxy *find_proxy_by_address(GList *source, const char *addr=
ess)
>  {
>         GList *list;
> @@ -691,13 +767,14 @@ static void cmd_list(const char *arg)
>         GList *list;
>
>         for (list =3D g_list_first(ctrl_list); list; list =3D g_list_next=
(list)) {
> -               GDBusProxy *proxy =3D list->data;
> -               print_adapter(proxy, NULL);
> +               struct adapter *adapter =3D list->data;
> +               print_adapter(adapter->proxy, NULL);
>         }
>  }
>
>  static void cmd_show(const char *arg)
>  {
> +       struct adapter *adapter;
>         GDBusProxy *proxy;
>         DBusMessageIter iter;
>         const char *address;
> @@ -706,13 +783,14 @@ static void cmd_show(const char *arg)
>                 if (check_default_ctrl() =3D=3D FALSE)
>                         return;
>
> -               proxy =3D default_ctrl;
> +               proxy =3D default_ctrl->proxy;
>         } else {
> -               proxy =3D find_proxy_by_address(ctrl_list, arg);
> -               if (!proxy) {
> +               adapter =3D find_ctrl_by_address(ctrl_list, arg);
> +               if (!adapter) {
>                         rl_printf("Controller %s not available\n", arg);
>                         return;
>                 }
> +               proxy =3D adapter->proxy;
>         }
>
>         if (g_dbus_proxy_get_property(proxy, "Address", &iter) =3D=3D FAL=
SE)
> @@ -734,45 +812,50 @@ static void cmd_show(const char *arg)
>
>  static void cmd_select(const char *arg)
>  {
> -       GDBusProxy *proxy;
> +       struct adapter *adapter;
>
>         if (!arg || !strlen(arg)) {
>                 rl_printf("Missing controller address argument\n");
>                 return;
>         }
>
> -       proxy =3D find_proxy_by_address(ctrl_list, arg);
> -       if (!proxy) {
> +       adapter =3D find_ctrl_by_address(ctrl_list, arg);
> +       if (!adapter) {
>                 rl_printf("Controller %s not available\n", arg);
>                 return;
>         }
>
> -       if (default_ctrl =3D=3D proxy)
> +       if (default_ctrl && default_ctrl->proxy =3D=3D adapter->proxy)
>                 return;
>
> -       default_ctrl =3D proxy;
> -       print_adapter(proxy, NULL);
> -
> -       g_list_free(dev_list);
> -       dev_list =3D NULL;
> +       default_ctrl =3D adapter;
> +       print_adapter(adapter->proxy, NULL);
>  }
>
>  static void cmd_devices(const char *arg)
>  {
> -       GList *list;
> +       GList *ll;
>
> -       for (list =3D g_list_first(dev_list); list; list =3D g_list_next(=
list)) {
> -               GDBusProxy *proxy =3D list->data;
> +       if (check_default_ctrl() =3D=3D FALSE)
> +               return;
> +
> +       for (ll =3D g_list_first(default_ctrl->devices);
> +                       ll; ll =3D g_list_next(ll)) {
> +               GDBusProxy *proxy =3D ll->data;
>                 print_device(proxy, NULL);
>         }
>  }
>
>  static void cmd_paired_devices(const char *arg)
>  {
> -       GList *list;
> +       GList *ll;
>
> -       for (list =3D g_list_first(dev_list); list; list =3D g_list_next(=
list)) {
> -               GDBusProxy *proxy =3D list->data;
> +       if (check_default_ctrl() =3D=3D FALSE)
> +               return;
> +
> +       for (ll =3D g_list_first(default_ctrl->devices);
> +                       ll; ll =3D g_list_next(ll)) {
> +               GDBusProxy *proxy =3D ll->data;
>                 DBusMessageIter iter;
>                 dbus_bool_t paired;
>
> @@ -811,7 +894,7 @@ static void cmd_system_alias(const char *arg)
>
>         name =3D g_strdup(arg);
>
> -       if (g_dbus_proxy_set_property_basic(default_ctrl, "Alias",
> +       if (g_dbus_proxy_set_property_basic(default_ctrl->proxy, "Alias",
>                                         DBUS_TYPE_STRING, &name,
>                                         generic_callback, name, g_free) =
=3D=3D TRUE)
>                 return;
> @@ -828,7 +911,7 @@ static void cmd_reset_alias(const char *arg)
>
>         name =3D g_strdup("");
>
> -       if (g_dbus_proxy_set_property_basic(default_ctrl, "Alias",
> +       if (g_dbus_proxy_set_property_basic(default_ctrl->proxy, "Alias",
>                                         DBUS_TYPE_STRING, &name,
>                                         generic_callback, name, g_free) =
=3D=3D TRUE)
>                 return;
> @@ -849,7 +932,7 @@ static void cmd_power(const char *arg)
>
>         str =3D g_strdup_printf("power %s", powered =3D=3D TRUE ? "on" : =
"off");
>
> -       if (g_dbus_proxy_set_property_basic(default_ctrl, "Powered",
> +       if (g_dbus_proxy_set_property_basic(default_ctrl->proxy, "Powered=
",
>                                         DBUS_TYPE_BOOLEAN, &powered,
>                                         generic_callback, str, g_free) =
=3D=3D TRUE)
>                 return;
> @@ -870,7 +953,7 @@ static void cmd_pairable(const char *arg)
>
>         str =3D g_strdup_printf("pairable %s", pairable =3D=3D TRUE ? "on=
" : "off");
>
> -       if (g_dbus_proxy_set_property_basic(default_ctrl, "Pairable",
> +       if (g_dbus_proxy_set_property_basic(default_ctrl->proxy, "Pairabl=
e",
>                                         DBUS_TYPE_BOOLEAN, &pairable,
>                                         generic_callback, str, g_free) =
=3D=3D TRUE)
>                 return;
> @@ -892,7 +975,7 @@ static void cmd_discoverable(const char *arg)
>         str =3D g_strdup_printf("discoverable %s",
>                                 discoverable =3D=3D TRUE ? "on" : "off");
>
> -       if (g_dbus_proxy_set_property_basic(default_ctrl, "Discoverable",
> +       if (g_dbus_proxy_set_property_basic(default_ctrl->proxy, "Discove=
rable",
>                                         DBUS_TYPE_BOOLEAN, &discoverable,
>                                         generic_callback, str, g_free) =
=3D=3D TRUE)
>                 return;
> @@ -966,7 +1049,7 @@ static void cmd_scan(const char *arg)
>         else
>                 method =3D "StopDiscovery";
>
> -       if (g_dbus_proxy_method_call(default_ctrl, method,
> +       if (g_dbus_proxy_method_call(default_ctrl->proxy, method,
>                                 NULL, start_discovery_reply,
>                                 GUINT_TO_POINTER(enable), NULL) =3D=3D FA=
LSE) {
>                 rl_printf("Failed to %s discovery\n",
> @@ -1135,7 +1218,7 @@ static void cmd_set_scan_filter_commit(void)
>         if (check_default_ctrl() =3D=3D FALSE)
>                 return;
>
> -       if (g_dbus_proxy_method_call(default_ctrl, "SetDiscoveryFilter",
> +       if (g_dbus_proxy_method_call(default_ctrl->proxy, "SetDiscoveryFi=
lter",
>                 set_discovery_filter_setup, set_discovery_filter_reply,
>                 &args, NULL) =3D=3D FALSE) {
>                 rl_printf("Failed to set discovery filter\n");
> @@ -1224,7 +1307,10 @@ static void cmd_set_scan_filter_clear(const char *=
arg)
>         g_free(filtered_scan_transport);
>         filtered_scan_transport =3D NULL;
>
> -       if (g_dbus_proxy_method_call(default_ctrl, "SetDiscoveryFilter",
> +       if (check_default_ctrl() =3D=3D FALSE)
> +               return;
> +
> +       if (g_dbus_proxy_method_call(default_ctrl->proxy, "SetDiscoveryFi=
lter",
>                 clear_discovery_filter_setup, set_discovery_filter_reply,
>                 NULL, NULL) =3D=3D FALSE) {
>                 rl_printf("Failed to clear discovery filter\n");
> @@ -1242,7 +1328,10 @@ static struct GDBusProxy *find_device(const char *=
arg)
>                 return NULL;
>         }
>
> -       proxy =3D find_proxy_by_address(dev_list, arg);
> +       if (check_default_ctrl() =3D=3D FALSE)
> +               return NULL;
> +
> +       proxy =3D find_proxy_by_address(default_ctrl->devices, arg);
>         if (!proxy) {
>                 rl_printf("Device %s not available\n", arg);
>                 return NULL;
> @@ -1433,7 +1522,10 @@ static void remove_device(GDBusProxy *proxy)
>
>         path =3D g_strdup(g_dbus_proxy_get_path(proxy));
>
> -       if (g_dbus_proxy_method_call(default_ctrl, "RemoveDevice",
> +       if (!default_ctrl)
> +               return;
> +
> +       if (g_dbus_proxy_method_call(default_ctrl->proxy, "RemoveDevice",
>                                                 remove_device_setup,
>                                                 remove_device_reply,
>                                                 path, g_free) =3D=3D FALS=
E) {
> @@ -1457,16 +1549,16 @@ static void cmd_remove(const char *arg)
>         if (strcmp(arg, "*") =3D=3D 0) {
>                 GList *list;
>
> -               for (list =3D g_list_first(dev_list); list; list =3D g_li=
st_next(list)) {
> +               for (list =3D g_list_first(default_ctrl->devices);
> +                               list; list =3D g_list_next(list)) {
>                         GDBusProxy *proxy =3D list->data;
>
>                         remove_device(proxy);
>                 }
> -
>                 return;
>         }
>
> -       proxy =3D find_proxy_by_address(dev_list, arg);
> +       proxy =3D find_proxy_by_address(default_ctrl->devices, arg);
>         if (!proxy) {
>                 rl_printf("Device %s not available\n", arg);
>                 return;
> @@ -1502,7 +1594,10 @@ static void cmd_connect(const char *arg)
>                 return;
>         }
>
> -       proxy =3D find_proxy_by_address(dev_list, arg);
> +       if (check_default_ctrl() =3D=3D FALSE)
> +               return;
> +
> +       proxy =3D find_proxy_by_address(default_ctrl->devices, arg);
>         if (!proxy) {
>                 rl_printf("Device %s not available\n", arg);
>                 return;
> @@ -1712,7 +1807,7 @@ static void cmd_register_profile(const char *arg)
>                 return;
>         }
>
> -       gatt_register_profile(dbus_conn, default_ctrl, &w);
> +       gatt_register_profile(dbus_conn, default_ctrl->proxy, &w);
>
>         wordfree(&w);
>  }
> @@ -1722,7 +1817,7 @@ static void cmd_unregister_profile(const char *arg)
>         if (check_default_ctrl() =3D=3D FALSE)
>                 return;
>
> -       gatt_unregister_profile(dbus_conn, default_ctrl);
> +       gatt_unregister_profile(dbus_conn, default_ctrl->proxy);
>  }
>
>  static void cmd_version(const char *arg)
> @@ -1768,12 +1863,40 @@ static char *generic_generator(const char *text, =
int state,
>
>  static char *ctrl_generator(const char *text, int state)
>  {
> -       return generic_generator(text, state, ctrl_list, "Address");
> +       static int index =3D 0;
> +       static int len =3D 0;
> +       GList *list;
> +
> +       if (!state) {
> +               index =3D 0;
> +               len =3D strlen(text);
> +       }
> +
> +       for (list =3D g_list_nth(ctrl_list, index); list;
> +                                               list =3D g_list_next(list=
)) {
> +               struct adapter *adapter =3D list->data;
> +               DBusMessageIter iter;
> +               const char *str;
> +
> +               index++;
> +
> +               if (g_dbus_proxy_get_property(adapter->proxy,
> +                                       "Address", &iter) =3D=3D FALSE)
> +                       continue;
> +
> +               dbus_message_iter_get_basic(&iter, &str);
> +
> +               if (!strncmp(str, text, len))
> +                       return strdup(str);
> +       }
> +
> +       return NULL;
>  }
>
>  static char *dev_generator(const char *text, int state)
>  {
> -       return generic_generator(text, state, dev_list, "Address");
> +       return generic_generator(text, state,
> +                       default_ctrl ? default_ctrl->devices : NULL, "Add=
ress");
>  }
>
>  static char *attribute_generator(const char *text, int state)
> @@ -2294,7 +2417,6 @@ int main(int argc, char *argv[])
>         g_main_loop_unref(main_loop);
>
>         g_list_free_full(ctrl_list, proxy_leak);
> -       g_list_free_full(dev_list, proxy_leak);
>
>         g_free(auto_register_agent);
>
> --
> 2.7.4

Applied, note that I did have to fix a crash in service_is_child you
were assuming it devices had struct adapter entries when in fact the
list carries GDBusProxy.

--=20
Luiz Augusto von Dentz
