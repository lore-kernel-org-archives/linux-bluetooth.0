Return-Path: <cyrus@holtmann.org>
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH BlueZ 09/12] client: Add read command
Date: Fri,  6 Feb 2015 13:03:41 +0200
Message-Id: <1423220624-18861-10-git-send-email-luiz.dentz@gmail.com>
In-Reply-To: <1423220624-18861-1-git-send-email-luiz.dentz@gmail.com>
References: <1423220624-18861-1-git-send-email-luiz.dentz@gmail.com>
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
index 8fb3f62..ce709c8 100644
--- a/client/gatt.c
+++ b/client/gatt.c
@@ -326,3 +326,62 @@ char *gatt_attribute_generator(const char *text, int state)
 
 	return attribute_generator(text, state, list);
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
index 614efca..04cb51b 100644
--- a/client/main.c
+++ b/client/main.c
@@ -1276,6 +1276,16 @@ static void cmd_attribute_info(const char *arg)
 	}
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
@@ -1405,6 +1415,7 @@ static const struct {
 				"Select attribute", attribute_generator },
 	{ "attribute-info", "[attribute]",  cmd_attribute_info,
 				"Select attribute", attribute_generator },
+	{ "read",         NULL,       cmd_read, "Read attribute value" },
 	{ "version",      NULL,       cmd_version, "Display version" },
 	{ "quit",         NULL,       cmd_quit, "Quit program" },
 	{ "exit",         NULL,       cmd_quit },
-- 
2.1.0

