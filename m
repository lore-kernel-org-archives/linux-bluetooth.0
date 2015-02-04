Return-Path: <cyrus@holtmann.org>
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
To: linux-bluetooth@vger.kernel.org
Subject: [RFC 9/9] client: Add write command
Date: Wed,  4 Feb 2015 17:33:19 +0200
Message-Id: <1423063999-15734-10-git-send-email-luiz.dentz@gmail.com>
In-Reply-To: <1423063999-15734-1-git-send-email-luiz.dentz@gmail.com>
References: <1423063999-15734-1-git-send-email-luiz.dentz@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

From: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>

This command can be used to write attributes, it only works if an
attribute has been selected with select-attribute.

The data argument should be passed hexdump format, %02x separated by
spaces, which is the same format used by read command.
---
 client/gatt.c | 80 +++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
 client/gatt.h |  1 +
 client/main.c | 17 +++++++++++++
 3 files changed, 98 insertions(+)

diff --git a/client/gatt.c b/client/gatt.c
index 56a9241..35150df 100644
--- a/client/gatt.c
+++ b/client/gatt.c
@@ -30,6 +30,7 @@
 #include <unistd.h>
 #include <stdlib.h>
 #include <stdbool.h>
+#include <sys/uio.h>
 
 #include <readline/readline.h>
 #include <readline/history.h>
@@ -378,3 +379,82 @@ void gatt_read_attribute(GDBusProxy *proxy)
 	rl_printf("Unable to read attribute %s\n",
 						g_dbus_proxy_get_path(proxy));
 }
+
+static void write_reply(DBusMessage *message, void *user_data)
+{
+	DBusError error;
+
+	dbus_error_init(&error);
+
+	if (dbus_set_error_from_message(&error, message) == TRUE) {
+		rl_printf("Failed to write: %s\n", error.name);
+		dbus_error_free(&error);
+		return;
+	}
+}
+
+static void write_setup(DBusMessageIter *iter, void *user_data)
+{
+	struct iovec *iov = user_data;
+	DBusMessageIter array;
+
+	dbus_message_iter_open_container(iter, DBUS_TYPE_ARRAY, "y", &array);
+	dbus_message_iter_append_fixed_array(&array, DBUS_TYPE_BYTE,
+						&iov->iov_base, iov->iov_len);
+	dbus_message_iter_close_container(iter, &array);
+}
+
+static void write_attribute(GDBusProxy *proxy, char *arg)
+{
+	struct iovec iov;
+	uint8_t value[512];
+	char *entry;
+	int i;
+
+	for (i = 0; (entry = strsep(&arg, " \t")) != NULL; i++) {
+		long int val;
+		char *endptr = NULL;
+
+		if (*entry == '\0')
+			continue;
+
+		if (i > 512) {
+			rl_printf("Too much data\n");
+			return;
+		}
+
+		val = strtol(entry, &endptr, 0);
+		if (!endptr || *endptr != '\0' || val > UINT8_MAX) {
+			rl_printf("Invalid value at index %d\n", i);
+			return;
+		}
+
+		value[i] = val;
+	}
+
+	iov.iov_base = value;
+	iov.iov_len = i;
+
+	if (g_dbus_proxy_method_call(proxy, "WriteValue", write_setup,
+					write_reply, &iov, NULL) == FALSE) {
+		rl_printf("Failed to write\n");
+		return;
+	}
+
+	rl_printf("Attempting to write %s\n", g_dbus_proxy_get_path(proxy));
+}
+
+void gatt_write_attribute(GDBusProxy *proxy, const char *arg)
+{
+	const char *iface;
+
+	iface = g_dbus_proxy_get_interface(proxy);
+	if (!strcmp(iface, "org.bluez.GattCharacteristic1") ||
+				!strcmp(iface, "org.bluez.GattDescriptor1")) {
+		write_attribute(proxy, (char *) arg);
+		return;
+	}
+
+	rl_printf("Unable to write attribute %s\n",
+						g_dbus_proxy_get_path(proxy));
+}
diff --git a/client/gatt.h b/client/gatt.h
index ac18a2a..b99f0f0 100644
--- a/client/gatt.h
+++ b/client/gatt.h
@@ -35,3 +35,4 @@ GDBusProxy *gatt_select_attribute(const char *path);
 char *gatt_attribute_generator(const char *text, int state);
 
 void gatt_read_attribute(GDBusProxy *proxy);
+void gatt_write_attribute(GDBusProxy *proxy, const char *arg);
diff --git a/client/main.c b/client/main.c
index e0f35e2..7184bde 100644
--- a/client/main.c
+++ b/client/main.c
@@ -1222,6 +1222,21 @@ static void cmd_read(const char *arg)
 	gatt_read_attribute(default_attr);
 }
 
+static void cmd_write(const char *arg)
+{
+	if (!arg || !strlen(arg)) {
+		rl_printf("Missing data argument\n");
+		return;
+	}
+
+	if (!default_attr) {
+		rl_printf("No attribute selected\n");
+		return;
+	}
+
+	gatt_write_attribute(default_attr, arg);
+}
+
 static void cmd_version(const char *arg)
 {
 	rl_printf("Version %s\n", VERSION);
@@ -1350,6 +1365,8 @@ static const struct {
 	{ "select-attribute", "<attribute>",  cmd_select_attribute,
 				"Select attribute", attribute_generator },
 	{ "read",         NULL,       cmd_read, "Read attribute value" },
+	{ "write",        "<data=[xx xx ...]>", cmd_write,
+						"Write attribute value" },
 	{ "version",      NULL,       cmd_version, "Display version" },
 	{ "quit",         NULL,       cmd_quit, "Quit program" },
 	{ "exit",         NULL,       cmd_quit },
-- 
2.1.0

