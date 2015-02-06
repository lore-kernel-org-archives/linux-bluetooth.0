Return-Path: <cyrus@holtmann.org>
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH BlueZ 06/12] client: Add command select-attribute
Date: Fri,  6 Feb 2015 13:03:38 +0200
Message-Id: <1423220624-18861-7-git-send-email-luiz.dentz@gmail.com>
In-Reply-To: <1423220624-18861-1-git-send-email-luiz.dentz@gmail.com>
References: <1423220624-18861-1-git-send-email-luiz.dentz@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

From: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>

Command select-attribute can be used to select a service attribute.
---
 client/gatt.c | 77 +++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
 client/gatt.h |  2 ++
 client/main.c | 76 +++++++++++++++++++++++++++++++++++++++++++++++++++-------
 3 files changed, 146 insertions(+), 9 deletions(-)

diff --git a/client/gatt.c b/client/gatt.c
index 7c44a9f..8fb3f62 100644
--- a/client/gatt.c
+++ b/client/gatt.c
@@ -249,3 +249,80 @@ void gatt_list_attributes(const char *path)
 {
 	list_attributes(path, services);
 }
+
+static GDBusProxy *select_proxy(const char *path, GList *source)
+{
+	GList *l;
+
+	for (l = source; l; l = g_list_next(l)) {
+		GDBusProxy *proxy = l->data;
+
+		if (strcmp(path, g_dbus_proxy_get_path(proxy)) == 0)
+			return proxy;
+	}
+
+	return NULL;
+}
+
+GDBusProxy *gatt_select_attribute(const char *path)
+{
+	GDBusProxy *proxy;
+
+	proxy = select_proxy(path, services);
+	if (proxy)
+		return proxy;
+
+	proxy = select_proxy(path, characteristics);
+	if (proxy)
+		return proxy;
+
+	return select_proxy(path, descriptors);
+}
+
+static char *attribute_generator(const char *text, int state, GList *source)
+{
+	static int index, len;
+	GList *list;
+
+	if (!state) {
+		index = 0;
+		len = strlen(text);
+	}
+
+	for (list = g_list_nth(source, index); list;
+						list = g_list_next(list)) {
+		GDBusProxy *proxy = list->data;
+		const char *path;
+
+		index++;
+
+		path = g_dbus_proxy_get_path(proxy);
+
+		if (!strncmp(path, text, len))
+			return strdup(path);
+        }
+
+	return NULL;
+}
+
+char *gatt_attribute_generator(const char *text, int state)
+{
+	static GList *list = NULL;
+
+	if (!state) {
+		GList *list1;
+
+		if (list) {
+			g_list_free(list);
+			list = NULL;
+		}
+
+		list1 = g_list_copy(characteristics);
+		list1 = g_list_concat(list1, g_list_copy(descriptors));
+
+		list = g_list_copy(services);
+		list = g_list_concat(list, list1);
+	}
+
+	return attribute_generator(text, state, list);
+}
diff --git a/client/gatt.h b/client/gatt.h
index 5785073..bb7cb1c 100644
--- a/client/gatt.h
+++ b/client/gatt.h
@@ -31,3 +31,5 @@ void gatt_add_descriptor(GDBusProxy *proxy);
 void gatt_remove_descriptor(GDBusProxy *proxy);
 
 void gatt_list_attributes(const char *device);
+GDBusProxy *gatt_select_attribute(const char *path);
+char *gatt_attribute_generator(const char *text, int state);
diff --git a/client/main.c b/client/main.c
index 7cdb19a..1481694 100644
--- a/client/main.c
+++ b/client/main.c
@@ -59,6 +59,7 @@ static char *auto_register_agent = NULL;
 
 static GDBusProxy *default_ctrl;
 static GDBusProxy *default_dev;
+static GDBusProxy *default_attr;
 static GList *ctrl_list;
 static GList *dev_list;
 
@@ -346,20 +347,30 @@ static void proxy_added(GDBusProxy *proxy, void *user_data)
 	}
 }
 
-static void set_default_device(GDBusProxy *proxy)
+static void set_default_device(GDBusProxy *proxy, const char *attribute)
 {
 	char *desc = NULL;
 	DBusMessageIter iter;
+	const char *path;
 
 	default_dev = proxy;
 
+	if (proxy == NULL) {
+		default_attr = NULL;
+		goto done;
+	}
+
 	if (!g_dbus_proxy_get_property(proxy, "Alias", &iter)) {
 		if (!g_dbus_proxy_get_property(proxy, "Address", &iter))
 			goto done;
 	}
 
+	path = g_dbus_proxy_get_path(proxy);
+
 	dbus_message_iter_get_basic(&iter, &desc);
-	desc = g_strdup_printf(COLOR_BLUE "[%s]" COLOR_OFF "# ", desc);
+	desc = g_strdup_printf(COLOR_BLUE "[%s%s%s]" COLOR_OFF "# ", desc,
+				attribute ? ":" : "",
+				attribute ? attribute + strlen(path) : "");
 
 done:
 	rl_set_prompt(desc ? desc : PROMPT_ON);
@@ -367,6 +378,17 @@ done:
 	g_free(desc);
 }
 
+static void set_default_attribute(GDBusProxy *proxy)
+{
+	const char *path;
+
+	default_attr = proxy;
+
+	path = g_dbus_proxy_get_path(proxy);
+
+	set_default_device(default_dev, path);
+}
+
 static void proxy_removed(GDBusProxy *proxy, void *user_data)
 {
 	const char *interface;
@@ -380,7 +402,7 @@ static void proxy_removed(GDBusProxy *proxy, void *user_data)
 			print_device(proxy, COLORED_DEL);
 
 			if (default_dev == proxy)
-				set_default_device(NULL);
+				set_default_device(NULL, NULL);
 		}
 	} else if (!strcmp(interface, "org.bluez.Adapter1")) {
 		ctrl_list = g_list_remove(ctrl_list, proxy);
@@ -389,7 +411,7 @@ static void proxy_removed(GDBusProxy *proxy, void *user_data)
 
 		if (default_ctrl == proxy) {
 			default_ctrl = NULL;
-			set_default_device(NULL);
+			set_default_device(NULL, NULL);
 
 			g_list_free(dev_list);
 			dev_list = NULL;
@@ -401,12 +423,22 @@ static void proxy_removed(GDBusProxy *proxy, void *user_data)
 				agent_unregister(dbus_conn, NULL);
 		}
 	} else if (!strcmp(interface, "org.bluez.GattService1")) {
-		if (service_is_child(proxy))
+		if (service_is_child(proxy)) {
 			gatt_remove_service(proxy);
+
+			if (default_attr == proxy)
+				set_default_attribute(NULL);
+		}
 	} else if (!strcmp(interface, "org.bluez.GattCharacteristic1")) {
 		gatt_remove_characteristic(proxy);
+
+		if (default_attr == proxy)
+			set_default_attribute(NULL);
 	} else if (!strcmp(interface, "org.bluez.GattDescriptor1")) {
 		gatt_remove_descriptor(proxy);
+
+		if (default_attr == proxy)
+			set_default_attribute(NULL);
 	}
 }
 
@@ -439,9 +471,9 @@ static void property_changed(GDBusProxy *proxy, const char *name,
 				dbus_message_iter_get_basic(iter, &connected);
 
 				if (connected && default_dev == NULL)
-					set_default_device(proxy);
+					set_default_device(proxy, NULL);
 				else if (!connected && default_dev == proxy)
-					set_default_device(NULL);
+					set_default_device(NULL, NULL);
 			}
 
 			print_iter(str, name, iter);
@@ -1085,7 +1117,7 @@ static void connect_reply(DBusMessage *message, void *user_data)
 
 	rl_printf("Connection successful\n");
 
-	set_default_device(proxy);
+	set_default_device(proxy, NULL);
 }
 
 static void cmd_connect(const char *arg)
@@ -1130,7 +1162,7 @@ static void disconn_reply(DBusMessage *message, void *user_data)
 	if (proxy != default_dev)
 		return;
 
-	set_default_device(NULL);
+	set_default_device(NULL, NULL);
 }
 
 static void cmd_disconn(const char *arg)
@@ -1161,6 +1193,25 @@ static void cmd_list_attributes(const char *arg)
 	gatt_list_attributes(g_dbus_proxy_get_path(proxy));
 }
 
+static void cmd_select_attribute(const char *arg)
+{
+	GDBusProxy *proxy;
+
+	if (!arg || !strlen(arg)) {
+		rl_printf("Missing attribute argument\n");
+		return;
+	}
+
+	if (!default_dev) {
+		rl_printf("No device connected\n");
+		return;
+	}
+
+	proxy = gatt_select_attribute(arg);
+	if (proxy)
+		set_default_attribute(proxy);
+}
+
 static void cmd_version(const char *arg)
 {
 	rl_printf("Version %s\n", VERSION);
@@ -1212,6 +1263,11 @@ static char *dev_generator(const char *text, int state)
 	return generic_generator(text, state, dev_list, "Address");
 }
 
+static char *attribute_generator(const char *text, int state)
+{
+	return gatt_attribute_generator(text, state);
+}
+
 static char *capability_generator(const char *text, int state)
 {
 	static int index, len;
@@ -1281,6 +1337,8 @@ static const struct {
 							dev_generator },
 	{ "list-attributes", "[dev]", cmd_list_attributes, "List attributes",
 							dev_generator },
+	{ "select-attribute", "<attribute>",  cmd_select_attribute,
+				"Select attribute", attribute_generator },
 	{ "version",      NULL,       cmd_version, "Display version" },
 	{ "quit",         NULL,       cmd_quit, "Quit program" },
 	{ "exit",         NULL,       cmd_quit },
-- 
2.1.0

