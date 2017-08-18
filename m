Return-Path: <linux-bluetooth-owner@vger.kernel.org>
MIME-Version: 1.0
In-Reply-To: <20170818020204.68649-1-yunhanw@google.com>
References: <20170818020204.68649-1-yunhanw@google.com>
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Date: Fri, 18 Aug 2017 21:40:05 +0300
Message-ID: <CABBYNZJqKfG_RT1EQOMAheVo7_gEBOkbiC-GGv50cLa=JP5XZA@mail.gmail.com>
Subject: Re: [PATCH v2] client: Fix the selection bug of ad manager
To: Yunhan Wang <yunhanw@google.com>
Cc: "linux-bluetooth@vger.kernel.org" <linux-bluetooth@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Yunhan

On Fri, Aug 18, 2017 at 5:02 AM, Yunhan Wang <yunhanw@google.com> wrote:
> If there are multiple adapters, bluetoothctl may choose the wrong
> advertising manager. In addition, select command cannot update
> current advertising manager when choosing another adapter. Therefore, we
> need to put advertising manager under adapter structure to resolve this
> issue.
> ---
>  client/main.c | 93 +++++++++++++++++++++++++++++------------------------------
>  1 file changed, 46 insertions(+), 47 deletions(-)
>
> diff --git a/client/main.c b/client/main.c
> index 276e7f184..a2b66fa9a 100644
> --- a/client/main.c
> +++ b/client/main.c
> @@ -61,14 +61,14 @@ static GDBusProxy *agent_manager;
>  static char *auto_register_agent = NULL;
>
>  struct adapter {
> -       GDBusProxy *proxy;
> +       GDBusProxy *adapterProxy;

No need to change the proxy field here.

> +       GDBusProxy *advertisingProxy;

We don't use camelCase for variable or fields, please rename this to
something like ad_proxy.

>         GList *devices;
>  };
>
>  static struct adapter *default_ctrl;
>  static GDBusProxy *default_dev;
>  static GDBusProxy *default_attr;
> -static GDBusProxy *ad_manager;
>  static GList *ctrl_list;
>
>  static guint input = 0;
> @@ -176,7 +176,7 @@ static void print_adapter(GDBusProxy *proxy, const char *description)
>                                 description ? "] " : "",
>                                 address, name,
>                                 default_ctrl &&
> -                               default_ctrl->proxy == proxy ?
> +                               default_ctrl->adapterProxy == proxy ?
>                                 "[default]" : "");
>
>  }
> @@ -455,7 +455,7 @@ static struct adapter *find_parent(GDBusProxy *device)
>         for (list = g_list_first(ctrl_list); list; list = g_list_next(list)) {
>                 struct adapter *adapter = list->data;
>
> -               if (device_is_child(device, adapter->proxy) == TRUE)
> +               if (device_is_child(device, adapter->adapterProxy) == TRUE)
>                         return adapter;
>         }
>         return NULL;
> @@ -521,17 +521,17 @@ static void device_added(GDBusProxy *proxy)
>
>  static void adapter_added(GDBusProxy *proxy)
>  {
> -       struct adapter *adapter = g_malloc0(sizeof(struct adapter));
> -
> -       adapter->proxy = proxy;
> -       ctrl_list = g_list_append(ctrl_list, adapter);
> -
> -       if (!default_ctrl)
> -               default_ctrl = adapter;
> -
> +       default_ctrl = g_malloc0(sizeof(struct adapter));
> +       default_ctrl->adapterProxy = proxy;
> +       ctrl_list = g_list_append(ctrl_list, default_ctrl);
>         print_adapter(proxy, COLORED_NEW);
>  }
>
> +static void ad_manager_added(GDBusProxy *proxy)
> +{
> +       default_ctrl->advertisingProxy = proxy;
> +}
> +
>  static void proxy_added(GDBusProxy *proxy, void *user_data)
>  {
>         const char *interface;
> @@ -560,7 +560,7 @@ static void proxy_added(GDBusProxy *proxy, void *user_data)
>         } else if (!strcmp(interface, "org.bluez.GattManager1")) {
>                 gatt_add_manager(proxy);
>         } else if (!strcmp(interface, "org.bluez.LEAdvertisingManager1")) {
> -               ad_manager = proxy;
> +               ad_manager_added(proxy);
>         }
>  }
>
> @@ -598,10 +598,10 @@ static void adapter_removed(GDBusProxy *proxy)
>         for (ll = g_list_first(ctrl_list); ll; ll = g_list_next(ll)) {
>                 struct adapter *adapter = ll->data;
>
> -               if (adapter->proxy == proxy) {
> +               if (adapter->adapterProxy == proxy) {
>                         print_adapter(proxy, COLORED_DEL);
>
> -                       if (default_ctrl && default_ctrl->proxy == proxy) {
> +                       if (default_ctrl && default_ctrl->adapterProxy == proxy) {
>                                 default_ctrl = NULL;
>                                 set_default_device(NULL, NULL);
>                         }
> @@ -649,8 +649,7 @@ static void proxy_removed(GDBusProxy *proxy, void *user_data)
>         } else if (!strcmp(interface, "org.bluez.GattManager1")) {
>                 gatt_remove_manager(proxy);
>         } else if (!strcmp(interface, "org.bluez.LEAdvertisingManager1")) {
> -               if (ad_manager == proxy) {
> -                       agent_manager = NULL;
> +               if(!dbus_conn){
>                         ad_unregister(dbus_conn, NULL);
>                 }
>         }
> @@ -663,7 +662,7 @@ static struct adapter *find_ctrl(GList *source, const char *path)
>         for (list = g_list_first(source); list; list = g_list_next(list)) {
>                 struct adapter *adapter = list->data;
>
> -               if (!strcasecmp(g_dbus_proxy_get_path(adapter->proxy), path))
> +               if (!strcasecmp(g_dbus_proxy_get_path(adapter->adapterProxy), path))
>                         return adapter;
>         }
>
> @@ -680,7 +679,7 @@ static void property_changed(GDBusProxy *proxy, const char *name,
>
>         if (!strcmp(interface, "org.bluez.Device1")) {
>                 if (default_ctrl && device_is_child(proxy,
> -                                       default_ctrl->proxy) == TRUE) {
> +                                       default_ctrl->adapterProxy) == TRUE) {
>                         DBusMessageIter addr_iter;
>                         char *str;
>
> @@ -733,7 +732,7 @@ static void property_changed(GDBusProxy *proxy, const char *name,
>                 if (!ctrl)
>                         return;
>
> -               if (g_dbus_proxy_get_property(ctrl->proxy, "Address",
> +               if (g_dbus_proxy_get_property(ctrl->adapterProxy, "Address",
>                                                 &addr_iter) == TRUE) {
>                         const char *address;
>
> @@ -773,7 +772,7 @@ static struct adapter *find_ctrl_by_address(GList *source, const char *address)
>                 DBusMessageIter iter;
>                 const char *str;
>
> -               if (g_dbus_proxy_get_property(adapter->proxy,
> +               if (g_dbus_proxy_get_property(adapter->adapterProxy,
>                                         "Address", &iter) == FALSE)
>                         continue;
>
> @@ -877,7 +876,7 @@ static void cmd_list(const char *arg)
>
>         for (list = g_list_first(ctrl_list); list; list = g_list_next(list)) {
>                 struct adapter *adapter = list->data;
> -               print_adapter(adapter->proxy, NULL);
> +               print_adapter(adapter->adapterProxy, NULL);
>         }
>  }
>
> @@ -892,14 +891,14 @@ static void cmd_show(const char *arg)
>                 if (check_default_ctrl() == FALSE)
>                         return;
>
> -               proxy = default_ctrl->proxy;
> +               proxy = default_ctrl->adapterProxy;
>         } else {
>                 adapter = find_ctrl_by_address(ctrl_list, arg);
>                 if (!adapter) {
>                         rl_printf("Controller %s not available\n", arg);
>                         return;
>                 }
> -               proxy = adapter->proxy;
> +               proxy = adapter->adapterProxy;
>         }
>
>         if (g_dbus_proxy_get_property(proxy, "Address", &iter) == FALSE)
> @@ -934,11 +933,11 @@ static void cmd_select(const char *arg)
>                 return;
>         }
>
> -       if (default_ctrl && default_ctrl->proxy == adapter->proxy)
> +       if (default_ctrl && default_ctrl->adapterProxy == adapter->adapterProxy)
>                 return;
>
>         default_ctrl = adapter;
> -       print_adapter(adapter->proxy, NULL);
> +       print_adapter(adapter->adapterProxy, NULL);
>  }
>
>  static void cmd_devices(const char *arg)
> @@ -1003,7 +1002,7 @@ static void cmd_system_alias(const char *arg)
>
>         name = g_strdup(arg);
>
> -       if (g_dbus_proxy_set_property_basic(default_ctrl->proxy, "Alias",
> +       if (g_dbus_proxy_set_property_basic(default_ctrl->adapterProxy, "Alias",
>                                         DBUS_TYPE_STRING, &name,
>                                         generic_callback, name, g_free) == TRUE)
>                 return;
> @@ -1020,7 +1019,7 @@ static void cmd_reset_alias(const char *arg)
>
>         name = g_strdup("");
>
> -       if (g_dbus_proxy_set_property_basic(default_ctrl->proxy, "Alias",
> +       if (g_dbus_proxy_set_property_basic(default_ctrl->adapterProxy, "Alias",
>                                         DBUS_TYPE_STRING, &name,
>                                         generic_callback, name, g_free) == TRUE)
>                 return;
> @@ -1041,7 +1040,7 @@ static void cmd_power(const char *arg)
>
>         str = g_strdup_printf("power %s", powered == TRUE ? "on" : "off");
>
> -       if (g_dbus_proxy_set_property_basic(default_ctrl->proxy, "Powered",
> +       if (g_dbus_proxy_set_property_basic(default_ctrl->adapterProxy, "Powered",
>                                         DBUS_TYPE_BOOLEAN, &powered,
>                                         generic_callback, str, g_free) == TRUE)
>                 return;
> @@ -1062,7 +1061,7 @@ static void cmd_pairable(const char *arg)
>
>         str = g_strdup_printf("pairable %s", pairable == TRUE ? "on" : "off");
>
> -       if (g_dbus_proxy_set_property_basic(default_ctrl->proxy, "Pairable",
> +       if (g_dbus_proxy_set_property_basic(default_ctrl->adapterProxy, "Pairable",
>                                         DBUS_TYPE_BOOLEAN, &pairable,
>                                         generic_callback, str, g_free) == TRUE)
>                 return;
> @@ -1084,7 +1083,7 @@ static void cmd_discoverable(const char *arg)
>         str = g_strdup_printf("discoverable %s",
>                                 discoverable == TRUE ? "on" : "off");
>
> -       if (g_dbus_proxy_set_property_basic(default_ctrl->proxy, "Discoverable",
> +       if (g_dbus_proxy_set_property_basic(default_ctrl->adapterProxy, "Discoverable",
>                                         DBUS_TYPE_BOOLEAN, &discoverable,
>                                         generic_callback, str, g_free) == TRUE)
>                 return;
> @@ -1158,7 +1157,7 @@ static void cmd_scan(const char *arg)
>         else
>                 method = "StopDiscovery";
>
> -       if (g_dbus_proxy_method_call(default_ctrl->proxy, method,
> +       if (g_dbus_proxy_method_call(default_ctrl->adapterProxy, method,
>                                 NULL, start_discovery_reply,
>                                 GUINT_TO_POINTER(enable), NULL) == FALSE) {
>                 rl_printf("Failed to %s discovery\n",
> @@ -1334,7 +1333,7 @@ static void cmd_set_scan_filter_commit(void)
>         if (check_default_ctrl() == FALSE)
>                 return;
>
> -       if (g_dbus_proxy_method_call(default_ctrl->proxy, "SetDiscoveryFilter",
> +       if (g_dbus_proxy_method_call(default_ctrl->adapterProxy, "SetDiscoveryFilter",
>                 set_discovery_filter_setup, set_discovery_filter_reply,
>                 &args, NULL) == FALSE) {
>                 rl_printf("Failed to set discovery filter\n");
> @@ -1442,7 +1441,7 @@ static void cmd_set_scan_filter_clear(const char *arg)
>         if (check_default_ctrl() == FALSE)
>                 return;
>
> -       if (g_dbus_proxy_method_call(default_ctrl->proxy, "SetDiscoveryFilter",
> +       if (g_dbus_proxy_method_call(default_ctrl->adapterProxy, "SetDiscoveryFilter",
>                 clear_discovery_filter_setup, set_discovery_filter_reply,
>                 NULL, NULL) == FALSE) {
>                 rl_printf("Failed to clear discovery filter\n");
> @@ -1657,7 +1656,7 @@ static void remove_device(GDBusProxy *proxy)
>         if (!default_ctrl)
>                 return;
>
> -       if (g_dbus_proxy_method_call(default_ctrl->proxy, "RemoveDevice",
> +       if (g_dbus_proxy_method_call(default_ctrl->adapterProxy, "RemoveDevice",
>                                                 remove_device_setup,
>                                                 remove_device_reply,
>                                                 path, g_free) == FALSE) {
> @@ -1998,7 +1997,7 @@ static void cmd_register_app(const char *arg)
>                 return;
>         }
>
> -       gatt_register_app(dbus_conn, default_ctrl->proxy, &w);
> +       gatt_register_app(dbus_conn, default_ctrl->adapterProxy, &w);
>
>         wordfree(&w);
>  }
> @@ -2008,7 +2007,7 @@ static void cmd_unregister_app(const char *arg)
>         if (check_default_ctrl() == FALSE)
>                 return;
>
> -       gatt_unregister_app(dbus_conn, default_ctrl->proxy);
> +       gatt_unregister_app(dbus_conn, default_ctrl->adapterProxy);
>  }
>
>  static void cmd_register_service(const char *arg)
> @@ -2028,7 +2027,7 @@ static void cmd_register_service(const char *arg)
>                 goto done;
>         }
>
> -       gatt_register_service(dbus_conn, default_ctrl->proxy, &w);
> +       gatt_register_service(dbus_conn, default_ctrl->adapterProxy, &w);
>
>  done:
>         wordfree(&w);
> @@ -2051,7 +2050,7 @@ static void cmd_unregister_service(const char *arg)
>                 goto done;
>         }
>
> -       gatt_unregister_service(dbus_conn, default_ctrl->proxy, &w);
> +       gatt_unregister_service(dbus_conn, default_ctrl->adapterProxy, &w);
>
>  done:
>         wordfree(&w);
> @@ -2074,7 +2073,7 @@ static void cmd_register_characteristic(const char *arg)
>                 goto done;
>         }
>
> -       gatt_register_chrc(dbus_conn, default_ctrl->proxy, &w);
> +       gatt_register_chrc(dbus_conn, default_ctrl->adapterProxy, &w);
>
>  done:
>         wordfree(&w);
> @@ -2097,7 +2096,7 @@ static void cmd_unregister_characteristic(const char *arg)
>                 goto done;
>         }
>
> -       gatt_unregister_chrc(dbus_conn, default_ctrl->proxy, &w);
> +       gatt_unregister_chrc(dbus_conn, default_ctrl->adapterProxy, &w);
>
>  done:
>         wordfree(&w);
> @@ -2120,7 +2119,7 @@ static void cmd_register_descriptor(const char *arg)
>                 goto done;
>         }
>
> -       gatt_register_desc(dbus_conn, default_ctrl->proxy, &w);
> +       gatt_register_desc(dbus_conn, default_ctrl->adapterProxy, &w);
>
>  done:
>         wordfree(&w);
> @@ -2143,7 +2142,7 @@ static void cmd_unregister_descriptor(const char *arg)
>                 goto done;
>         }
>
> -       gatt_unregister_desc(dbus_conn, default_ctrl->proxy, &w);
> +       gatt_unregister_desc(dbus_conn, default_ctrl->adapterProxy, &w);
>
>  done:
>         wordfree(&w);
> @@ -2211,7 +2210,7 @@ static char *ctrl_generator(const char *text, int state)
>
>                 index++;
>
> -               if (g_dbus_proxy_get_property(adapter->proxy,
> +               if (g_dbus_proxy_get_property(adapter->adapterProxy,
>                                         "Address", &iter) == FALSE)
>                         continue;
>
> @@ -2296,15 +2295,15 @@ static void cmd_advertise(const char *arg)
>         if (parse_argument_advertise(arg, &enable, &type) == FALSE)
>                 return;
>
> -       if (!ad_manager) {
> +       if (!default_ctrl || !default_ctrl->advertisingProxy) {
>                 rl_printf("LEAdvertisingManager not found\n");
>                 return;
>         }
>
>         if (enable == TRUE)
> -               ad_register(dbus_conn, ad_manager, type);
> +               ad_register(dbus_conn, default_ctrl->advertisingProxy, type);
>         else
> -               ad_unregister(dbus_conn, ad_manager);
> +               ad_unregister(dbus_conn, default_ctrl->advertisingProxy);
>  }
>
>  static char *ad_generator(const char *text, int state)
> --
> 2.14.1.480.gb18f417b89-goog
>
> --
> To unsubscribe from this list: send the line "unsubscribe linux-bluetooth" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html



-- 
Luiz Augusto von Dentz
