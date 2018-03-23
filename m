Return-Path: <linux-bluetooth-owner@vger.kernel.org>
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH v2 3/3] client: Parse all options passed for GATT attribute
Date: Fri, 23 Mar 2018 15:37:03 +0200
Message-Id: <20180323133703.12499-3-luiz.dentz@gmail.com>
In-Reply-To: <20180323133703.12499-1-luiz.dentz@gmail.com>
References: <20180323133703.12499-1-luiz.dentz@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

From: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>

This parses the options given to Acquire*, WriteValue and ReadValue.
---
 client/gatt.c | 97 +++++++++++++++++++++++++++++++++--------------------------
 1 file changed, 55 insertions(+), 42 deletions(-)

diff --git a/client/gatt.c b/client/gatt.c
index 930a64699..066a00580 100644
--- a/client/gatt.c
+++ b/client/gatt.c
@@ -1415,7 +1415,8 @@ static const GDBusPropertyTable chrc_properties[] = {
 	{ }
 };
 
-static int parse_offset(DBusMessageIter *iter, uint16_t *offset)
+static int parse_options(DBusMessageIter *iter, uint16_t *offset, uint16_t *mtu,
+						char **device, char **link)
 {
 	DBusMessageIter dict;
 
@@ -1439,7 +1440,23 @@ static int parse_offset(DBusMessageIter *iter, uint16_t *offset)
 		if (strcasecmp(key, "offset") == 0) {
 			if (var != DBUS_TYPE_UINT16)
 				return -EINVAL;
-			dbus_message_iter_get_basic(&value, offset);
+			if (offset)
+				dbus_message_iter_get_basic(&value, offset);
+		} else if (strcasecmp(key, "MTU") == 0) {
+			if (var != DBUS_TYPE_UINT16)
+				return -EINVAL;
+			if (mtu)
+				dbus_message_iter_get_basic(&value, mtu);
+		} else if (strcasecmp(key, "device") == 0) {
+			if (var != DBUS_TYPE_OBJECT_PATH)
+				return -EINVAL;
+			if (device)
+				dbus_message_iter_get_basic(&value, device);
+		} else if (strcasecmp(key, "link") == 0) {
+			if (var != DBUS_TYPE_STRING)
+				return -EINVAL;
+			if (link)
+				dbus_message_iter_get_basic(&value, link);
 		}
 
 		dbus_message_iter_next(&dict);
@@ -1512,11 +1529,18 @@ static DBusMessage *chrc_read_value(DBusConnection *conn, DBusMessage *msg,
 	struct chrc *chrc = user_data;
 	DBusMessageIter iter;
 	uint16_t offset = 0;
+	char *device, *link;
 	char *str;
 
 	dbus_message_iter_init(msg, &iter);
 
-	parse_offset(&iter, &offset);
+	if (parse_options(&iter, &offset, NULL, &device, &link))
+		return g_dbus_create_error(msg,
+					"org.bluez.Error.InvalidArguments",
+					NULL);
+
+	bt_shell_printf("ReadValue: offset %u device %s link %s\n", offset,
+							device, link);
 
 	if (chrc->authorization_req && offset == 0)
 		chrc->authorized = false;
@@ -1640,42 +1664,6 @@ static DBusMessage *chrc_write_value(DBusConnection *conn, DBusMessage *msg,
 	return g_dbus_create_reply(msg, DBUS_TYPE_INVALID);
 }
 
-static int parse_options(DBusMessageIter *iter, struct chrc *chrc)
-{
-	DBusMessageIter dict;
-
-	if (dbus_message_iter_get_arg_type(iter) != DBUS_TYPE_ARRAY)
-		return -EINVAL;
-
-	dbus_message_iter_recurse(iter, &dict);
-
-	while (dbus_message_iter_get_arg_type(&dict) == DBUS_TYPE_DICT_ENTRY) {
-		const char *key;
-		DBusMessageIter value, entry;
-		int var;
-
-		dbus_message_iter_recurse(&dict, &entry);
-		dbus_message_iter_get_basic(&entry, &key);
-
-		dbus_message_iter_next(&entry);
-		dbus_message_iter_recurse(&entry, &value);
-
-		var = dbus_message_iter_get_arg_type(&value);
-		if (strcasecmp(key, "Device") == 0) {
-			if (var != DBUS_TYPE_OBJECT_PATH)
-				return -EINVAL;
-		} else if (strcasecmp(key, "MTU") == 0) {
-			if (var != DBUS_TYPE_UINT16)
-				return -EINVAL;
-			dbus_message_iter_get_basic(&value, &chrc->mtu);
-		}
-
-		dbus_message_iter_next(&dict);
-	}
-
-	return 0;
-}
-
 static DBusMessage *chrc_create_pipe(struct chrc *chrc, DBusMessage *msg)
 {
 	int pipefd[2];
@@ -1720,6 +1708,7 @@ static DBusMessage *chrc_acquire_write(DBusConnection *conn, DBusMessage *msg,
 	struct chrc *chrc = user_data;
 	DBusMessageIter iter;
 	DBusMessage *reply;
+	char *device = NULL, *link= NULL;
 
 	dbus_message_iter_init(msg, &iter);
 
@@ -1728,11 +1717,13 @@ static DBusMessage *chrc_acquire_write(DBusConnection *conn, DBusMessage *msg,
 					"org.bluez.Error.NotPermitted",
 					NULL);
 
-	if (parse_options(&iter, chrc))
+	if (parse_options(&iter, NULL, &chrc->mtu, &device, &link))
 		return g_dbus_create_error(msg,
 					"org.bluez.Error.InvalidArguments",
 					NULL);
 
+	bt_shell_printf("AcquireWrite: device %s link %s\n", device, link);
+
 	reply = chrc_create_pipe(chrc, msg);
 
 	if (chrc->write_io)
@@ -1748,6 +1739,7 @@ static DBusMessage *chrc_acquire_notify(DBusConnection *conn, DBusMessage *msg,
 	struct chrc *chrc = user_data;
 	DBusMessageIter iter;
 	DBusMessage *reply;
+	char *device = NULL, *link = NULL;
 
 	dbus_message_iter_init(msg, &iter);
 
@@ -1756,11 +1748,13 @@ static DBusMessage *chrc_acquire_notify(DBusConnection *conn, DBusMessage *msg,
 					"org.bluez.Error.NotPermitted",
 					NULL);
 
-	if (parse_options(&iter, chrc))
+	if (parse_options(&iter, NULL, &chrc->mtu, &device, &link))
 		return g_dbus_create_error(msg,
 					"org.bluez.Error.InvalidArguments",
 					NULL);
 
+	bt_shell_printf("AcquireNotify: device %s link %s\n", device, link);
+
 	reply = chrc_create_pipe(chrc, msg);
 
 	if (chrc->notify_io)
@@ -1958,10 +1952,17 @@ static DBusMessage *desc_read_value(DBusConnection *conn, DBusMessage *msg,
 	struct desc *desc = user_data;
 	DBusMessageIter iter;
 	uint16_t offset = 0;
+	char *device = NULL, *link = NULL;
 
 	dbus_message_iter_init(msg, &iter);
 
-	parse_offset(&iter, &offset);
+	if (parse_options(&iter, &offset, NULL, &device, &link))
+		return g_dbus_create_error(msg,
+					"org.bluez.Error.InvalidArguments",
+					NULL);
+
+	bt_shell_printf("ReadValue: offset %u device %s link %s\n", offset,
+							device, link);
 
 	if (offset > desc->value_len)
 		return g_dbus_create_error(msg, "org.bluez.Error.InvalidOffset",
@@ -1975,6 +1976,8 @@ static DBusMessage *desc_write_value(DBusConnection *conn, DBusMessage *msg,
 {
 	struct desc *desc = user_data;
 	DBusMessageIter iter;
+	uint16_t offset = 0;
+	char *device = NULL, *link = NULL;
 
 	dbus_message_iter_init(msg, &iter);
 
@@ -1983,6 +1986,16 @@ static DBusMessage *desc_write_value(DBusConnection *conn, DBusMessage *msg,
 					"org.bluez.Error.InvalidArguments",
 					NULL);
 
+	dbus_message_iter_next(&iter);
+
+	if (parse_options(&iter, &offset, NULL, &device, &link))
+		return g_dbus_create_error(msg,
+					"org.bluez.Error.InvalidArguments",
+					NULL);
+
+	bt_shell_printf("WriteValue: offset %u device %s link %s\n",
+					offset, device, link);
+
 	bt_shell_printf("[" COLORED_CHG "] Attribute %s written" , desc->path);
 
 	g_dbus_emit_property_changed(conn, desc->path, CHRC_INTERFACE, "Value");
-- 
2.14.3

