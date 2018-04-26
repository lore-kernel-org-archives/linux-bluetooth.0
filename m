Return-Path: <linux-bluetooth-owner@vger.kernel.org>
From: Grzegorz Kolodziejczyk <grzegorz.kolodziejczyk@codecoup.pl>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH BlueZ v3 3/4] client: Add support for optional gatt read offset parameter
Date: Thu, 26 Apr 2018 14:31:59 +0200
Message-Id: <20180426123200.3916-3-grzegorz.kolodziejczyk@codecoup.pl>
In-Reply-To: <20180426123200.3916-1-grzegorz.kolodziejczyk@codecoup.pl>
References: <20180426123200.3916-1-grzegorz.kolodziejczyk@codecoup.pl>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

This patch extends missing optional gatt read offset parameter.
---
 client/gatt.c | 18 +++++++++++++-----
 client/gatt.h |  2 +-
 client/main.c |  4 ++--
 3 files changed, 16 insertions(+), 8 deletions(-)

diff --git a/client/gatt.c b/client/gatt.c
index b0ef7b9c0..a33a094e6 100644
--- a/client/gatt.c
+++ b/client/gatt.c
@@ -518,6 +518,7 @@ static void read_reply(DBusMessage *message, void *user_data)
 static void read_setup(DBusMessageIter *iter, void *user_data)
 {
 	DBusMessageIter dict;
+	uint16_t *offset = user_data;
 
 	dbus_message_iter_open_container(iter, DBUS_TYPE_ARRAY,
 					DBUS_DICT_ENTRY_BEGIN_CHAR_AS_STRING
@@ -525,14 +526,16 @@ static void read_setup(DBusMessageIter *iter, void *user_data)
 					DBUS_TYPE_VARIANT_AS_STRING
 					DBUS_DICT_ENTRY_END_CHAR_AS_STRING,
 					&dict);
-	/* TODO: Add offset support */
+
+	g_dbus_dict_append_entry(&dict, "offset", DBUS_TYPE_UINT16, offset);
+
 	dbus_message_iter_close_container(iter, &dict);
 }
 
-static void read_attribute(GDBusProxy *proxy)
+static void read_attribute(GDBusProxy *proxy, uint16_t offset)
 {
 	if (g_dbus_proxy_method_call(proxy, "ReadValue", read_setup, read_reply,
-							NULL, NULL) == FALSE) {
+						&offset, NULL) == FALSE) {
 		bt_shell_printf("Failed to read\n");
 		return bt_shell_noninteractive_quit(EXIT_FAILURE);
 	}
@@ -540,14 +543,19 @@ static void read_attribute(GDBusProxy *proxy)
 	bt_shell_printf("Attempting to read %s\n", g_dbus_proxy_get_path(proxy));
 }
 
-void gatt_read_attribute(GDBusProxy *proxy)
+void gatt_read_attribute(GDBusProxy *proxy, int argc, char *argv[])
 {
 	const char *iface;
+	uint16_t offset = 0;
 
 	iface = g_dbus_proxy_get_interface(proxy);
 	if (!strcmp(iface, "org.bluez.GattCharacteristic1") ||
 				!strcmp(iface, "org.bluez.GattDescriptor1")) {
-		read_attribute(proxy);
+
+		if (argc == 2)
+			offset = atoi(argv[1]);
+
+		read_attribute(proxy, offset);
 		return;
 	}
 
diff --git a/client/gatt.h b/client/gatt.h
index f4c36b870..274c76b1f 100644
--- a/client/gatt.h
+++ b/client/gatt.h
@@ -34,7 +34,7 @@ void gatt_list_attributes(const char *device);
 GDBusProxy *gatt_select_attribute(GDBusProxy *parent, const char *path);
 char *gatt_attribute_generator(const char *text, int state);
 
-void gatt_read_attribute(GDBusProxy *proxy);
+void gatt_read_attribute(GDBusProxy *proxy, int argc, char *argv[]);
 void gatt_write_attribute(GDBusProxy *proxy, const char *arg);
 void gatt_notify_attribute(GDBusProxy *proxy, bool enable);
 
diff --git a/client/main.c b/client/main.c
index b96278d45..57a85f1d5 100644
--- a/client/main.c
+++ b/client/main.c
@@ -1908,7 +1908,7 @@ static void cmd_read(int argc, char *argv[])
 		return bt_shell_noninteractive_quit(EXIT_FAILURE);
 	}
 
-	gatt_read_attribute(default_attr);
+	gatt_read_attribute(default_attr, argc, argv);
 }
 
 static void cmd_write(int argc, char *argv[])
@@ -2415,7 +2415,7 @@ static const struct bt_shell_menu gatt_menu = {
 				"Select attribute", attribute_generator },
 	{ "attribute-info", "[attribute/UUID]",  cmd_attribute_info,
 				"Select attribute", attribute_generator },
-	{ "read",         NULL,       cmd_read, "Read attribute value" },
+	{ "read", "[offset]", cmd_read, "Read attribute value" },
 	{ "write",        "<data=xx xx ...>", cmd_write,
 						"Write attribute value" },
 	{ "acquire-write", NULL, cmd_acquire_write,
-- 
2.13.6

