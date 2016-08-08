Return-Path: <linux-bluetooth-owner@vger.kernel.org>
From: =?UTF-8?q?Micha=C5=82=20Narajowski?=
	<michal.narajowski@codecoup.pl>
To: linux-bluetooth@vger.kernel.org
Cc: =?UTF-8?q?Micha=C5=82=20Narajowski?=
	<michal.narajowski@codecoup.pl>
Subject: [PATCH BlueZ] client: Add better support for managing devices of multiple controllers
Date: Mon,  8 Aug 2016 11:15:41 +0200
Message-Id: <1470647741-12865-1-git-send-email-michal.narajowski@codecoup.pl>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Previously devices list was cleared when selecting new default
controller. Now devices list is preserverd allowing to list and suggest
devices for default controller even after changing the default
controller.
---
 client/main.c | 56 ++++++++++++++++++++++++++++++++++++--------------------
 1 file changed, 36 insertions(+), 20 deletions(-)

diff --git a/client/main.c b/client/main.c
index 056331f..e1d8eeb 100644
--- a/client/main.c
+++ b/client/main.c
@@ -63,6 +63,7 @@ static GDBusProxy *default_dev;
 static GDBusProxy *default_attr;
 static GList *ctrl_list;
 static GList *dev_list;
+static GList *default_ctrl_dev_list;
 
 static guint input = 0;
 
@@ -358,6 +359,24 @@ static gboolean service_is_child(GDBusProxy *service)
 	return FALSE;
 }
 
+static void update_default_ctrl_dev_list(void)
+{
+	GList *list;
+
+	if (default_ctrl_dev_list) {
+		g_list_free(default_ctrl_dev_list);
+		default_ctrl_dev_list = NULL;
+	}
+
+	for (list = g_list_first(dev_list); list; list = g_list_next(list)) {
+		GDBusProxy *proxy = list->data;
+
+		if (device_is_child(proxy, default_ctrl) == TRUE) 
+			default_ctrl_dev_list = g_list_append(default_ctrl_dev_list, 
+					proxy);
+	}
+}
+
 static void set_default_device(GDBusProxy *proxy, const char *attribute)
 {
 	char *desc = NULL;
@@ -418,9 +437,8 @@ static void proxy_added(GDBusProxy *proxy, void *user_data)
 	interface = g_dbus_proxy_get_interface(proxy);
 
 	if (!strcmp(interface, "org.bluez.Device1")) {
-		if (device_is_child(proxy, default_ctrl) == TRUE)
-			device_added(proxy);
-
+		device_added(proxy);
+		update_default_ctrl_dev_list();
 	} else if (!strcmp(interface, "org.bluez.Adapter1")) {
 		ctrl_list = g_list_append(ctrl_list, proxy);
 
@@ -466,14 +484,13 @@ static void proxy_removed(GDBusProxy *proxy, void *user_data)
 	interface = g_dbus_proxy_get_interface(proxy);
 
 	if (!strcmp(interface, "org.bluez.Device1")) {
-		if (device_is_child(proxy, default_ctrl) == TRUE) {
-			dev_list = g_list_remove(dev_list, proxy);
+		dev_list = g_list_remove(dev_list, proxy);
 
-			print_device(proxy, COLORED_DEL);
+		print_device(proxy, COLORED_DEL);
+		update_default_ctrl_dev_list();
 
-			if (default_dev == proxy)
-				set_default_device(NULL, NULL);
-		}
+		if (default_dev == proxy)
+			set_default_device(NULL, NULL);
 	} else if (!strcmp(interface, "org.bluez.Adapter1")) {
 		ctrl_list = g_list_remove(ctrl_list, proxy);
 
@@ -482,9 +499,7 @@ static void proxy_removed(GDBusProxy *proxy, void *user_data)
 		if (default_ctrl == proxy) {
 			default_ctrl = NULL;
 			set_default_device(NULL, NULL);
-
-			g_list_free(dev_list);
-			dev_list = NULL;
+			update_default_ctrl_dev_list();
 		}
 	} else if (!strcmp(interface, "org.bluez.AgentManager1")) {
 		if (agent_manager == proxy) {
@@ -734,16 +749,14 @@ static void cmd_select(const char *arg)
 
 	default_ctrl = proxy;
 	print_adapter(proxy, NULL);
-
-	g_list_free(dev_list);
-	dev_list = NULL;
+	update_default_ctrl_dev_list();
 }
 
 static void cmd_devices(const char *arg)
 {
 	GList *list;
 
-	for (list = g_list_first(dev_list); list; list = g_list_next(list)) {
+	for (list = g_list_first(default_ctrl_dev_list); list; list = g_list_next(list)) {
 		GDBusProxy *proxy = list->data;
 		print_device(proxy, NULL);
 	}
@@ -753,7 +766,7 @@ static void cmd_paired_devices(const char *arg)
 {
 	GList *list;
 
-	for (list = g_list_first(dev_list); list; list = g_list_next(list)) {
+	for (list = g_list_first(default_ctrl_dev_list); list; list = g_list_next(list)) {
 		GDBusProxy *proxy = list->data;
 		DBusMessageIter iter;
 		dbus_bool_t paired;
@@ -1439,22 +1452,24 @@ static void cmd_remove(const char *arg)
 	if (strcmp(arg, "*") == 0) {
 		GList *list;
 
-		for (list = g_list_first(dev_list); list; list = g_list_next(list)) {
+		for (list = g_list_first(default_ctrl_dev_list); list; list = g_list_next(list)) {
 			GDBusProxy *proxy = list->data;
 
 			remove_device(proxy);
 		}
+		update_default_ctrl_dev_list();
 
 		return;
 	}
 
-	proxy = find_proxy_by_address(dev_list, arg);
+	proxy = find_proxy_by_address(default_ctrl_dev_list, arg);
 	if (!proxy) {
 		rl_printf("Device %s not available\n", arg);
 		return;
 	}
 
 	remove_device(proxy);
+	update_default_ctrl_dev_list();
 }
 
 static void connect_reply(DBusMessage *message, void *user_data)
@@ -1755,7 +1770,7 @@ static char *ctrl_generator(const char *text, int state)
 
 static char *dev_generator(const char *text, int state)
 {
-	return generic_generator(text, state, dev_list, "Address");
+	return generic_generator(text, state, default_ctrl_dev_list, "Address");
 }
 
 static char *attribute_generator(const char *text, int state)
@@ -2156,6 +2171,7 @@ int main(int argc, char *argv[])
 
 	g_list_free_full(ctrl_list, proxy_leak);
 	g_list_free_full(dev_list, proxy_leak);
+	g_list_free(default_ctrl_dev_list);
 
 	g_free(auto_register_agent);
 
-- 
2.7.4

