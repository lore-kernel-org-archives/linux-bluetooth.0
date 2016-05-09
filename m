Return-Path: <linux-bluetooth-owner@vger.kernel.org>
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCHv2 BlueZ 5/6] client: Update to use new GATT API
Date: Mon,  9 May 2016 16:51:22 +0300
Message-Id: <1462801883-6361-5-git-send-email-luiz.dentz@gmail.com>
In-Reply-To: <1462801883-6361-1-git-send-email-luiz.dentz@gmail.com>
References: <1462801883-6361-1-git-send-email-luiz.dentz@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

From: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>

This update use of ReadValue and WriteValue to include the options
introduced in the API.
---
 client/gatt.c | 27 +++++++++++++++++++++++++--
 1 file changed, 25 insertions(+), 2 deletions(-)

diff --git a/client/gatt.c b/client/gatt.c
index 7dd3c94..fee1cf9 100644
--- a/client/gatt.c
+++ b/client/gatt.c
@@ -379,9 +379,23 @@ static void read_reply(DBusMessage *message, void *user_data)
 	rl_hexdump(value, len);
 }
 
+static void read_setup(DBusMessageIter *iter, void *user_data)
+{
+	DBusMessageIter dict;
+
+	dbus_message_iter_open_container(iter, DBUS_TYPE_ARRAY,
+					DBUS_DICT_ENTRY_BEGIN_CHAR_AS_STRING
+					DBUS_TYPE_STRING_AS_STRING
+					DBUS_TYPE_VARIANT_AS_STRING
+					DBUS_DICT_ENTRY_END_CHAR_AS_STRING,
+					&dict);
+	/* TODO: Add offset support */
+	dbus_message_iter_close_container(iter, &dict);
+}
+
 static void read_attribute(GDBusProxy *proxy)
 {
-	if (g_dbus_proxy_method_call(proxy, "ReadValue", NULL, read_reply,
+	if (g_dbus_proxy_method_call(proxy, "ReadValue", read_setup, read_reply,
 							NULL, NULL) == FALSE) {
 		rl_printf("Failed to read\n");
 		return;
@@ -421,12 +435,21 @@ static void write_reply(DBusMessage *message, void *user_data)
 static void write_setup(DBusMessageIter *iter, void *user_data)
 {
 	struct iovec *iov = user_data;
-	DBusMessageIter array;
+	DBusMessageIter array, dict;
 
 	dbus_message_iter_open_container(iter, DBUS_TYPE_ARRAY, "y", &array);
 	dbus_message_iter_append_fixed_array(&array, DBUS_TYPE_BYTE,
 						&iov->iov_base, iov->iov_len);
 	dbus_message_iter_close_container(iter, &array);
+
+	dbus_message_iter_open_container(iter, DBUS_TYPE_ARRAY,
+					DBUS_DICT_ENTRY_BEGIN_CHAR_AS_STRING
+					DBUS_TYPE_STRING_AS_STRING
+					DBUS_TYPE_VARIANT_AS_STRING
+					DBUS_DICT_ENTRY_END_CHAR_AS_STRING,
+					&dict);
+	/* TODO: Add offset support */
+	dbus_message_iter_close_container(iter, &dict);
 }
 
 static void write_attribute(GDBusProxy *proxy, char *arg)
-- 
2.5.5

