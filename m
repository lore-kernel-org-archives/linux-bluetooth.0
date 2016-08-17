Return-Path: <linux-bluetooth-owner@vger.kernel.org>
From: =?UTF-8?q?Micha=C5=82=20Narajowski?=
	<michal.narajowski@codecoup.pl>
To: linux-bluetooth@vger.kernel.org
Cc: =?UTF-8?q?Micha=C5=82=20Narajowski?=
	<michal.narajowski@codecoup.pl>
Subject: [PATCH BlueZ v4] client: Add better support for managing devices of multiple controllers
Date: Wed, 17 Aug 2016 10:22:06 +0200
Message-Id: <1471422126-12624-1-git-send-email-michal.narajowski@codecoup.pl>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Previously devices list was cleared when selecting new default
controller. Now devices list is preserverd allowing to list and suggest
devices for default controller even after changing the default
controller.
---
 Makefile.tools |   3 +-
 client/main.c  | 262 +++++++++++++++++++++++++++++++++++++++++----------------
 2 files changed, 190 insertions(+), 75 deletions(-)

diff --git a/Makefile.tools b/Makefile.tools
index 7706dc7..78ccb1c 100644
--- a/Makefile.tools
+++ b/Makefile.tools
@@ -10,7 +10,8 @@ client_bluetoothctl_SOURCES = client/main.c \
 					client/gatt.h client/gatt.c \
 					monitor/uuid.h monitor/uuid.c
 client_bluetoothctl_LDADD = gdbus/libgdbus-internal.la @GLIB_LIBS@ @DBUS_LIBS@ \
-				-lreadline
+				-lreadline src/libshared-glib.la
+
 endif
 
 if MONITOR
diff --git a/client/main.c b/client/main.c
index 1ceddb0..af98354 100644
--- a/client/main.c
+++ b/client/main.c
@@ -38,6 +38,7 @@
 #include <readline/history.h>
 #include <glib.h>
 
+#include "src/shared/util.h"
 #include "gdbus/gdbus.h"
 #include "monitor/uuid.h"
 #include "agent.h"
@@ -59,13 +60,16 @@ static DBusConnection *dbus_conn;
 static GDBusProxy *agent_manager;
 static char *auto_register_agent = NULL;
 
-static GDBusProxy *ad_manager;
+struct adapter {
+	GDBusProxy *proxy;
+	GList *devices;
+};
 
-static GDBusProxy *default_ctrl;
+static struct adapter *default_ctrl;
 static GDBusProxy *default_dev;
 static GDBusProxy *default_attr;
+static GDBusProxy *ad_manager;
 static GList *ctrl_list;
-static GList *dev_list;
 
 static guint input = 0;
 
@@ -145,13 +149,10 @@ static void disconnect_handler(DBusConnection *connection, void *user_data)
 	rl_on_new_line();
 	rl_redisplay();
 
-	g_list_free(ctrl_list);
+	g_list_free_full(ctrl_list, proxy_leak);
 	ctrl_list = NULL;
 
 	default_ctrl = NULL;
-
-	g_list_free(dev_list);
-	dev_list = NULL;
 }
 
 static void print_adapter(GDBusProxy *proxy, const char *description)
@@ -174,7 +175,7 @@ static void print_adapter(GDBusProxy *proxy, const char *description)
 				description ? : "",
 				description ? "] " : "",
 				address, name,
-				default_ctrl == proxy ? "[default]" : "");
+				default_ctrl && default_ctrl->proxy == proxy ? "[default]" : "");
 
 }
 
@@ -357,10 +358,13 @@ static gboolean service_is_child(GDBusProxy *service)
 
 	dbus_message_iter_get_basic(&iter, &device);
 
-	for (l = dev_list; l; l = g_list_next(l)) {
-		GDBusProxy *proxy = l->data;
+	if (!default_ctrl)
+		return FALSE;
+
+	for (l = default_ctrl->devices; l; l = g_list_next(l)) {
+		struct adapter *adapter = l->data;
 
-		path = g_dbus_proxy_get_path(proxy);
+		path = g_dbus_proxy_get_path(adapter->proxy);
 
 		if (!strcmp(path, device))
 			return TRUE;
@@ -369,6 +373,19 @@ static gboolean service_is_child(GDBusProxy *service)
 	return FALSE;
 }
 
+static struct adapter *find_parent(GDBusProxy *device)
+{
+	GList *list;
+
+	for (list = g_list_first(ctrl_list); list; list = g_list_next(list)) {
+		struct adapter *adapter = list->data;
+
+		if (device_is_child(device, adapter->proxy) == TRUE) 
+			return adapter;
+	}
+	return NULL;
+}
+
 static void set_default_device(GDBusProxy *proxy, const char *attribute)
 {
 	char *desc = NULL;
@@ -405,8 +422,13 @@ static void device_added(GDBusProxy *proxy)
 {
 	DBusMessageIter iter;
 
-	dev_list = g_list_append(dev_list, proxy);
+	struct adapter *adapter = find_parent(proxy);
+	if (!adapter) {
+		/* TODO: Error */
+		return;
+	}
 
+	adapter->devices = g_list_append(adapter->devices, proxy);
 	print_device(proxy, COLORED_NEW);
 
 	if (default_dev)
@@ -422,6 +444,19 @@ static void device_added(GDBusProxy *proxy)
 	}
 }
 
+static void adapter_added(GDBusProxy *proxy)
+{
+	struct adapter *adapter = new0(struct adapter, 1);
+
+	adapter->proxy = proxy;
+	ctrl_list = g_list_append(ctrl_list, adapter);
+
+	if (!default_ctrl)
+		default_ctrl = adapter;
+
+	print_adapter(proxy, COLORED_NEW);
+}
+
 static void proxy_added(GDBusProxy *proxy, void *user_data)
 {
 	const char *interface;
@@ -429,16 +464,9 @@ static void proxy_added(GDBusProxy *proxy, void *user_data)
 	interface = g_dbus_proxy_get_interface(proxy);
 
 	if (!strcmp(interface, "org.bluez.Device1")) {
-		if (device_is_child(proxy, default_ctrl) == TRUE)
-			device_added(proxy);
-
+		device_added(proxy);
 	} else if (!strcmp(interface, "org.bluez.Adapter1")) {
-		ctrl_list = g_list_append(ctrl_list, proxy);
-
-		if (!default_ctrl)
-			default_ctrl = proxy;
-
-		print_adapter(proxy, COLORED_NEW);
+		adapter_added(proxy);
 	} else if (!strcmp(interface, "org.bluez.AgentManager1")) {
 		if (!agent_manager) {
 			agent_manager = proxy;
@@ -472,33 +500,56 @@ static void set_default_attribute(GDBusProxy *proxy)
 	set_default_device(default_dev, path);
 }
 
-static void proxy_removed(GDBusProxy *proxy, void *user_data)
+static void device_removed(GDBusProxy *proxy)
 {
-	const char *interface;
+	struct adapter *adapter = find_parent(proxy);
+	if (!adapter) {
+		/* TODO: Error */
+		return;
+	}
 
-	interface = g_dbus_proxy_get_interface(proxy);
+	adapter->devices = g_list_remove(adapter->devices, proxy);
 
-	if (!strcmp(interface, "org.bluez.Device1")) {
-		if (device_is_child(proxy, default_ctrl) == TRUE) {
-			dev_list = g_list_remove(dev_list, proxy);
+	print_device(proxy, COLORED_DEL);
+
+	if (default_dev == proxy)
+		set_default_device(NULL, NULL);
+}
+
+static void adapter_removed(GDBusProxy *proxy)
+{
+	GList *llink;
+
+	for (llink = g_list_first(ctrl_list); llink; llink = g_list_next(llink)) {
+		struct adapter *adapter = llink->data;
 
-			print_device(proxy, COLORED_DEL);
+		if (adapter->proxy == proxy) {
+			print_adapter(proxy, COLORED_DEL);
 
-			if (default_dev == proxy)
+			if (default_ctrl && default_ctrl->proxy == proxy) {
+				default_ctrl = NULL;
 				set_default_device(NULL, NULL);
+			}
+
+			ctrl_list = g_list_remove_link(ctrl_list, llink);
+			g_list_free(adapter->devices);
+			free(adapter);
+			g_list_free(llink);
+			return;
 		}
-	} else if (!strcmp(interface, "org.bluez.Adapter1")) {
-		ctrl_list = g_list_remove(ctrl_list, proxy);
+	}
+}
 
-		print_adapter(proxy, COLORED_DEL);
+static void proxy_removed(GDBusProxy *proxy, void *user_data)
+{
+	const char *interface;
 
-		if (default_ctrl == proxy) {
-			default_ctrl = NULL;
-			set_default_device(NULL, NULL);
+	interface = g_dbus_proxy_get_interface(proxy);
 
-			g_list_free(dev_list);
-			dev_list = NULL;
-		}
+	if (!strcmp(interface, "org.bluez.Device1")) {
+		device_removed(proxy);
+	} else if (!strcmp(interface, "org.bluez.Adapter1")) {
+		adapter_removed(proxy);
 	} else if (!strcmp(interface, "org.bluez.AgentManager1")) {
 		if (agent_manager == proxy) {
 			agent_manager = NULL;
@@ -538,7 +589,7 @@ static void property_changed(GDBusProxy *proxy, const char *name,
 	interface = g_dbus_proxy_get_interface(proxy);
 
 	if (!strcmp(interface, "org.bluez.Device1")) {
-		if (device_is_child(proxy, default_ctrl) == TRUE) {
+		if (default_ctrl && device_is_child(proxy, default_ctrl->proxy) == TRUE) {
 			DBusMessageIter addr_iter;
 			char *str;
 
@@ -601,6 +652,27 @@ static void message_handler(DBusConnection *connection,
 					dbus_message_get_member(message));
 }
 
+static struct adapter *find_ctrl_by_address(GList *source, const char *address)
+{
+	GList *list;
+
+	for (list = g_list_first(source); list; list = g_list_next(list)) {
+		struct adapter *adapter = list->data;
+		DBusMessageIter iter;
+		const char *str;
+
+		if (g_dbus_proxy_get_property(adapter->proxy, "Address", &iter) == FALSE)
+			continue;
+
+		dbus_message_iter_get_basic(&iter, &str);
+
+		if (!strcmp(str, address))
+			return adapter;
+	}
+
+	return NULL;
+}
+
 static GDBusProxy *find_proxy_by_address(GList *source, const char *address)
 {
 	GList *list;
@@ -691,13 +763,14 @@ static void cmd_list(const char *arg)
 	GList *list;
 
 	for (list = g_list_first(ctrl_list); list; list = g_list_next(list)) {
-		GDBusProxy *proxy = list->data;
-		print_adapter(proxy, NULL);
+		struct adapter *adapter = list->data;
+		print_adapter(adapter->proxy, NULL);
 	}
 }
 
 static void cmd_show(const char *arg)
 {
+	struct adapter *adapter;
 	GDBusProxy *proxy;
 	DBusMessageIter iter;
 	const char *address;
@@ -706,13 +779,14 @@ static void cmd_show(const char *arg)
 		if (check_default_ctrl() == FALSE)
 			return;
 
-		proxy = default_ctrl;
+		proxy = default_ctrl->proxy;
 	} else {
-		proxy = find_proxy_by_address(ctrl_list, arg);
-		if (!proxy) {
+		adapter = find_ctrl_by_address(ctrl_list, arg);
+		if (!adapter) {
 			rl_printf("Controller %s not available\n", arg);
 			return;
 		}
+		proxy = adapter->proxy;
 	}
 
 	if (g_dbus_proxy_get_property(proxy, "Address", &iter) == FALSE)
@@ -734,34 +808,34 @@ static void cmd_show(const char *arg)
 
 static void cmd_select(const char *arg)
 {
-	GDBusProxy *proxy;
+	struct adapter *adapter;
 
 	if (!arg || !strlen(arg)) {
 		rl_printf("Missing controller address argument\n");
 		return;
 	}
 
-	proxy = find_proxy_by_address(ctrl_list, arg);
-	if (!proxy) {
+	adapter = find_ctrl_by_address(ctrl_list, arg);
+	if (!adapter) {
 		rl_printf("Controller %s not available\n", arg);
 		return;
 	}
 
-	if (default_ctrl == proxy)
+	if (default_ctrl && default_ctrl->proxy == adapter->proxy)
 		return;
 
-	default_ctrl = proxy;
-	print_adapter(proxy, NULL);
-
-	g_list_free(dev_list);
-	dev_list = NULL;
+	default_ctrl = adapter;
+	print_adapter(adapter->proxy, NULL);
 }
 
 static void cmd_devices(const char *arg)
 {
 	GList *list;
 
-	for (list = g_list_first(dev_list); list; list = g_list_next(list)) {
+	if (check_default_ctrl() == FALSE)
+		return;
+
+	for (list = g_list_first(default_ctrl->devices); list; list = g_list_next(list)) {
 		GDBusProxy *proxy = list->data;
 		print_device(proxy, NULL);
 	}
@@ -771,7 +845,10 @@ static void cmd_paired_devices(const char *arg)
 {
 	GList *list;
 
-	for (list = g_list_first(dev_list); list; list = g_list_next(list)) {
+	if (check_default_ctrl() == FALSE)
+		return;
+
+	for (list = g_list_first(default_ctrl->devices); list; list = g_list_next(list)) {
 		GDBusProxy *proxy = list->data;
 		DBusMessageIter iter;
 		dbus_bool_t paired;
@@ -811,7 +888,7 @@ static void cmd_system_alias(const char *arg)
 
 	name = g_strdup(arg);
 
-	if (g_dbus_proxy_set_property_basic(default_ctrl, "Alias",
+	if (g_dbus_proxy_set_property_basic(default_ctrl->proxy, "Alias",
 					DBUS_TYPE_STRING, &name,
 					generic_callback, name, g_free) == TRUE)
 		return;
@@ -828,7 +905,7 @@ static void cmd_reset_alias(const char *arg)
 
 	name = g_strdup("");
 
-	if (g_dbus_proxy_set_property_basic(default_ctrl, "Alias",
+	if (g_dbus_proxy_set_property_basic(default_ctrl->proxy, "Alias",
 					DBUS_TYPE_STRING, &name,
 					generic_callback, name, g_free) == TRUE)
 		return;
@@ -849,7 +926,7 @@ static void cmd_power(const char *arg)
 
 	str = g_strdup_printf("power %s", powered == TRUE ? "on" : "off");
 
-	if (g_dbus_proxy_set_property_basic(default_ctrl, "Powered",
+	if (g_dbus_proxy_set_property_basic(default_ctrl->proxy, "Powered",
 					DBUS_TYPE_BOOLEAN, &powered,
 					generic_callback, str, g_free) == TRUE)
 		return;
@@ -870,7 +947,7 @@ static void cmd_pairable(const char *arg)
 
 	str = g_strdup_printf("pairable %s", pairable == TRUE ? "on" : "off");
 
-	if (g_dbus_proxy_set_property_basic(default_ctrl, "Pairable",
+	if (g_dbus_proxy_set_property_basic(default_ctrl->proxy, "Pairable",
 					DBUS_TYPE_BOOLEAN, &pairable,
 					generic_callback, str, g_free) == TRUE)
 		return;
@@ -892,7 +969,7 @@ static void cmd_discoverable(const char *arg)
 	str = g_strdup_printf("discoverable %s",
 				discoverable == TRUE ? "on" : "off");
 
-	if (g_dbus_proxy_set_property_basic(default_ctrl, "Discoverable",
+	if (g_dbus_proxy_set_property_basic(default_ctrl->proxy, "Discoverable",
 					DBUS_TYPE_BOOLEAN, &discoverable,
 					generic_callback, str, g_free) == TRUE)
 		return;
@@ -966,7 +1043,7 @@ static void cmd_scan(const char *arg)
 	else
 		method = "StopDiscovery";
 
-	if (g_dbus_proxy_method_call(default_ctrl, method,
+	if (g_dbus_proxy_method_call(default_ctrl->proxy, method,
 				NULL, start_discovery_reply,
 				GUINT_TO_POINTER(enable), NULL) == FALSE) {
 		rl_printf("Failed to %s discovery\n",
@@ -1135,7 +1212,7 @@ static void cmd_set_scan_filter_commit(void)
 	if (check_default_ctrl() == FALSE)
 		return;
 
-	if (g_dbus_proxy_method_call(default_ctrl, "SetDiscoveryFilter",
+	if (g_dbus_proxy_method_call(default_ctrl->proxy, "SetDiscoveryFilter",
 		set_discovery_filter_setup, set_discovery_filter_reply,
 		&args, NULL) == FALSE) {
 		rl_printf("Failed to set discovery filter\n");
@@ -1224,7 +1301,10 @@ static void cmd_set_scan_filter_clear(const char *arg)
 	g_free(filtered_scan_transport);
 	filtered_scan_transport = NULL;
 
-	if (g_dbus_proxy_method_call(default_ctrl, "SetDiscoveryFilter",
+	if (check_default_ctrl() == FALSE)
+		return;
+
+	if (g_dbus_proxy_method_call(default_ctrl->proxy, "SetDiscoveryFilter",
 		clear_discovery_filter_setup, set_discovery_filter_reply,
 		NULL, NULL) == FALSE) {
 		rl_printf("Failed to clear discovery filter\n");
@@ -1242,7 +1322,10 @@ static struct GDBusProxy *find_device(const char *arg)
 		return NULL;
 	}
 
-	proxy = find_proxy_by_address(dev_list, arg);
+	if (check_default_ctrl() == FALSE)
+		return NULL;
+
+	proxy = find_proxy_by_address(default_ctrl->devices, arg);
 	if (!proxy) {
 		rl_printf("Device %s not available\n", arg);
 		return NULL;
@@ -1432,8 +1515,11 @@ static void remove_device(GDBusProxy *proxy)
 	char *path;
 
 	path = g_strdup(g_dbus_proxy_get_path(proxy));
+	
+	if (!default_ctrl)
+		return;
 
-	if (g_dbus_proxy_method_call(default_ctrl, "RemoveDevice",
+	if (g_dbus_proxy_method_call(default_ctrl->proxy, "RemoveDevice",
 						remove_device_setup,
 						remove_device_reply,
 						path, g_free) == FALSE) {
@@ -1457,16 +1543,15 @@ static void cmd_remove(const char *arg)
 	if (strcmp(arg, "*") == 0) {
 		GList *list;
 
-		for (list = g_list_first(dev_list); list; list = g_list_next(list)) {
+		for (list = g_list_first(default_ctrl->devices); list; list = g_list_next(list)) {
 			GDBusProxy *proxy = list->data;
 
 			remove_device(proxy);
 		}
-
 		return;
 	}
 
-	proxy = find_proxy_by_address(dev_list, arg);
+	proxy = find_proxy_by_address(default_ctrl->devices, arg);
 	if (!proxy) {
 		rl_printf("Device %s not available\n", arg);
 		return;
@@ -1502,7 +1587,10 @@ static void cmd_connect(const char *arg)
 		return;
 	}
 
-	proxy = find_proxy_by_address(dev_list, arg);
+	if (check_default_ctrl() == FALSE)
+		return;
+
+	proxy = find_proxy_by_address(default_ctrl->devices, arg);
 	if (!proxy) {
 		rl_printf("Device %s not available\n", arg);
 		return;
@@ -1712,7 +1800,7 @@ static void cmd_register_profile(const char *arg)
 		return;
 	}
 
-	gatt_register_profile(dbus_conn, default_ctrl, &w);
+	gatt_register_profile(dbus_conn, default_ctrl->proxy, &w);
 
 	wordfree(&w);
 }
@@ -1722,7 +1810,7 @@ static void cmd_unregister_profile(const char *arg)
 	if (check_default_ctrl() == FALSE)
 		return;
 
-	gatt_unregister_profile(dbus_conn, default_ctrl);
+	gatt_unregister_profile(dbus_conn, default_ctrl->proxy);
 }
 
 static void cmd_version(const char *arg)
@@ -1768,12 +1856,39 @@ static char *generic_generator(const char *text, int state,
 
 static char *ctrl_generator(const char *text, int state)
 {
-	return generic_generator(text, state, ctrl_list, "Address");
+	static int index = 0;
+	static int len = 0;
+	GList *list;
+
+	if (!state) {
+		index = 0;
+		len = strlen(text);
+	}
+
+	for (list = g_list_nth(ctrl_list, index); list;
+						list = g_list_next(list)) {
+		struct adapter *adapter = list->data;
+		DBusMessageIter iter;
+		const char *str;
+
+		index++;
+
+		if (g_dbus_proxy_get_property(adapter->proxy, "Address", &iter) == FALSE)
+			continue;
+
+		dbus_message_iter_get_basic(&iter, &str);
+
+		if (!strncmp(str, text, len))
+			return strdup(str);
+        }
+
+	return NULL;
 }
 
 static char *dev_generator(const char *text, int state)
 {
-	return generic_generator(text, state, dev_list, "Address");
+	return generic_generator(text, state, 
+			default_ctrl ? default_ctrl->devices : NULL, "Address");
 }
 
 static char *attribute_generator(const char *text, int state)
@@ -2294,7 +2409,6 @@ int main(int argc, char *argv[])
 	g_main_loop_unref(main_loop);
 
 	g_list_free_full(ctrl_list, proxy_leak);
-	g_list_free_full(dev_list, proxy_leak);
 
 	g_free(auto_register_agent);
 
-- 
2.7.4

