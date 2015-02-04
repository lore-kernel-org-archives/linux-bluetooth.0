Return-Path: <cyrus@holtmann.org>
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
To: linux-bluetooth@vger.kernel.org
Subject: [RFC 8/9] client: Add read command
Date: Wed,  4 Feb 2015 17:33:18 +0200
Message-Id: <1423063999-15734-9-git-send-email-luiz.dentz@gmail.com>
In-Reply-To: <1423063999-15734-1-git-send-email-luiz.dentz@gmail.com>
References: <1423063999-15734-1-git-send-email-luiz.dentz@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

From: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>

This command can be used to read attributes, it only works if an
attribute has been selected with select-attribute.
---
 client/gatt.c | 59 +++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
 client/gatt.h |  2 ++
 client/main.c | 11 +++++++++++
 3 files changed, 72 insertions(+)

diff --git a/client/gatt.c b/client/gatt.c
index f2830a3..56a9241 100644
--- a/client/gatt.c
+++ b/client/gatt.c
@@ -319,3 +319,62 @@ char *gatt_attribute_generator(const char *text, int state)
 
 	return attribute_generator(text, state, descriptors);
 }
+
+static void read_reply(DBusMessage *message, void *user_data)
+{
+	DBusError error;
+	DBusMessageIter iter, array;
+	uint8_t *value;
+	int len;
+
+	dbus_error_init(&error);
+
+	if (dbus_set_error_from_message(&error, message) == TRUE) {
+		rl_printf("Failed to read: %s\n", error.name);
+		dbus_error_free(&error);
+		return;
+	}
+
+	dbus_message_iter_init(message, &iter);
+
+	if (dbus_message_iter_get_arg_type(&iter) != DBUS_TYPE_ARRAY) {
+		rl_printf("Invalid response to read\n");
+		return;
+	}
+
+	dbus_message_iter_recurse(&iter, &array);
+	dbus_message_iter_get_fixed_array(&array, &value, &len);
+
+	if (len < 0) {
+		rl_printf("Unable to parse value\n");
+		return;
+	}
+
+	rl_hexdump(value, len);
+}
+
+static void read_attribute(GDBusProxy *proxy)
+{
+	if (g_dbus_proxy_method_call(proxy, "ReadValue", NULL, read_reply,
+							NULL, NULL) == FALSE) {
+		rl_printf("Failed to read\n");
+		return;
+	}
+
+	rl_printf("Attempting to read %s\n", g_dbus_proxy_get_path(proxy));
+}
+
+void gatt_read_attribute(GDBusProxy *proxy)
+{
+	const char *iface;
+
+	iface = g_dbus_proxy_get_interface(proxy);
+	if (!strcmp(iface, "org.bluez.GattCharacteristic1") ||
+				!strcmp(iface, "org.bluez.GattDescriptor1")) {
+		read_attribute(proxy);
+		return;
+	}
+
+	rl_printf("Unable to read attribute %s\n",
+						g_dbus_proxy_get_path(proxy));
+}
diff --git a/client/gatt.h b/client/gatt.h
index bb7cb1c..ac18a2a 100644
--- a/client/gatt.h
+++ b/client/gatt.h
@@ -33,3 +33,5 @@ void gatt_remove_descriptor(GDBusProxy *proxy);
 void gatt_list_attributes(const char *device);
 GDBusProxy *gatt_select_attribute(const char *path);
 char *gatt_attribute_generator(const char *text, int state);
+
+void gatt_read_attribute(GDBusProxy *proxy);
diff --git a/client/main.c b/client/main.c
index 1481694..e0f35e2 100644
--- a/client/main.c
+++ b/client/main.c
@@ -1212,6 +1212,16 @@ static void cmd_select_attribute(const char *arg)
 		set_default_attribute(proxy);
 }
 
+static void cmd_read(const char *arg)
+{
+	if (!default_attr) {
+		rl_printf("No attribute selected\n");
+		return;
+	}
+
+	gatt_read_attribute(default_attr);
+}
+
 static void cmd_version(const char *arg)
 {
 	rl_printf("Version %s\n", VERSION);
@@ -1339,6 +1349,7 @@ static const struct {
 							dev_generator },
 	{ "select-attribute", "<attribute>",  cmd_select_attribute,
 				"Select attribute", attribute_generator },
+	{ "read",         NULL,       cmd_read, "Read attribute value" },
 	{ "version",      NULL,       cmd_version, "Display version" },
 	{ "quit",         NULL,       cmd_quit, "Quit program" },
 	{ "exit",         NULL,       cmd_quit },
-- 
2.1.0

