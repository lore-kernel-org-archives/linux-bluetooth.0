Return-Path: <linux-bluetooth-owner@vger.kernel.org>
From: Grzegorz Kolodziejczyk <grzegorz.kolodziejczyk@codecoup.pl>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH BlueZ v3 4/4] client: Add support for optional gatt write offset parameter
Date: Thu, 26 Apr 2018 14:32:00 +0200
Message-Id: <20180426123200.3916-4-grzegorz.kolodziejczyk@codecoup.pl>
In-Reply-To: <20180426123200.3916-1-grzegorz.kolodziejczyk@codecoup.pl>
References: <20180426123200.3916-1-grzegorz.kolodziejczyk@codecoup.pl>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

This patch extends missing optional gatt write offset parameter.
---
 client/gatt.c | 34 ++++++++++++++++++++++++++--------
 client/gatt.h |  2 +-
 client/main.c |  4 ++--
 3 files changed, 29 insertions(+), 11 deletions(-)

diff --git a/client/gatt.c b/client/gatt.c
index a33a094e6..125d6034d 100644
--- a/client/gatt.c
+++ b/client/gatt.c
@@ -579,14 +579,20 @@ static void write_reply(DBusMessage *message, void *user_data)
 	return bt_shell_noninteractive_quit(EXIT_SUCCESS);
 }
 
+struct write_attribute_data {
+	struct iovec *iov;
+	uint16_t offset;
+};
+
 static void write_setup(DBusMessageIter *iter, void *user_data)
 {
-	struct iovec *iov = user_data;
+	struct write_attribute_data *wd = user_data;
 	DBusMessageIter array, dict;
 
 	dbus_message_iter_open_container(iter, DBUS_TYPE_ARRAY, "y", &array);
 	dbus_message_iter_append_fixed_array(&array, DBUS_TYPE_BYTE,
-						&iov->iov_base, iov->iov_len);
+						&wd->iov->iov_base,
+						wd->iov->iov_len);
 	dbus_message_iter_close_container(iter, &array);
 
 	dbus_message_iter_open_container(iter, DBUS_TYPE_ARRAY,
@@ -595,18 +601,22 @@ static void write_setup(DBusMessageIter *iter, void *user_data)
 					DBUS_TYPE_VARIANT_AS_STRING
 					DBUS_DICT_ENTRY_END_CHAR_AS_STRING,
 					&dict);
-	/* TODO: Add offset support */
+
+	g_dbus_dict_append_entry(&dict, "offset", DBUS_TYPE_UINT16,
+								&wd->offset);
+
 	dbus_message_iter_close_container(iter, &dict);
 }
 
-static void write_attribute(GDBusProxy *proxy, char *arg)
+static void write_attribute(GDBusProxy *proxy, char *val_str, uint16_t offset)
 {
 	struct iovec iov;
+	struct write_attribute_data wd;
 	uint8_t value[512];
 	char *entry;
 	unsigned int i;
 
-	for (i = 0; (entry = strsep(&arg, " \t")) != NULL; i++) {
+	for (i = 0; (entry = strsep(&val_str, " \t")) != NULL; i++) {
 		long int val;
 		char *endptr = NULL;
 
@@ -642,8 +652,11 @@ static void write_attribute(GDBusProxy *proxy, char *arg)
 		return;
 	}
 
+	wd.iov = &iov;
+	wd.offset = offset;
+
 	if (g_dbus_proxy_method_call(proxy, "WriteValue", write_setup,
-					write_reply, &iov, NULL) == FALSE) {
+					write_reply, &wd, NULL) == FALSE) {
 		bt_shell_printf("Failed to write\n");
 		return bt_shell_noninteractive_quit(EXIT_FAILURE);
 	}
@@ -652,14 +665,19 @@ static void write_attribute(GDBusProxy *proxy, char *arg)
 					g_dbus_proxy_get_path(proxy));
 }
 
-void gatt_write_attribute(GDBusProxy *proxy, const char *arg)
+void gatt_write_attribute(GDBusProxy *proxy, int argc, char *argv[])
 {
 	const char *iface;
+	uint16_t offset = 0;
 
 	iface = g_dbus_proxy_get_interface(proxy);
 	if (!strcmp(iface, "org.bluez.GattCharacteristic1") ||
 				!strcmp(iface, "org.bluez.GattDescriptor1")) {
-		write_attribute(proxy, (char *) arg);
+
+		if (argc > 2)
+			offset = atoi(argv[2]);
+
+		write_attribute(proxy, argv[1], offset);
 		return;
 	}
 
diff --git a/client/gatt.h b/client/gatt.h
index 274c76b1f..957ae8003 100644
--- a/client/gatt.h
+++ b/client/gatt.h
@@ -35,7 +35,7 @@ GDBusProxy *gatt_select_attribute(GDBusProxy *parent, const char *path);
 char *gatt_attribute_generator(const char *text, int state);
 
 void gatt_read_attribute(GDBusProxy *proxy, int argc, char *argv[]);
-void gatt_write_attribute(GDBusProxy *proxy, const char *arg);
+void gatt_write_attribute(GDBusProxy *proxy, int argc, char *argv[]);
 void gatt_notify_attribute(GDBusProxy *proxy, bool enable);
 
 void gatt_acquire_write(GDBusProxy *proxy, const char *arg);
diff --git a/client/main.c b/client/main.c
index 57a85f1d5..dd85a1c85 100644
--- a/client/main.c
+++ b/client/main.c
@@ -1918,7 +1918,7 @@ static void cmd_write(int argc, char *argv[])
 		return bt_shell_noninteractive_quit(EXIT_FAILURE);
 	}
 
-	gatt_write_attribute(default_attr, argv[1]);
+	gatt_write_attribute(default_attr, argc, argv);
 }
 
 static void cmd_acquire_write(int argc, char *argv[])
@@ -2416,7 +2416,7 @@ static const struct bt_shell_menu gatt_menu = {
 	{ "attribute-info", "[attribute/UUID]",  cmd_attribute_info,
 				"Select attribute", attribute_generator },
 	{ "read", "[offset]", cmd_read, "Read attribute value" },
-	{ "write",        "<data=xx xx ...>", cmd_write,
+	{ "write", "<data=xx xx ...> [offset]", cmd_write,
 						"Write attribute value" },
 	{ "acquire-write", NULL, cmd_acquire_write,
 					"Acquire Write file descriptor" },
-- 
2.13.6

