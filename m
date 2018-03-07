Return-Path: <linux-bluetooth-owner@vger.kernel.org>
From: Grzegorz Kolodziejczyk <grzegorz.kolodziejczyk@codecoup.pl>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH BlueZ] client: Fix reading long values
Date: Wed,  7 Mar 2018 17:09:18 +0100
Message-Id: <20180307160918.12156-1-grzegorz.kolodziejczyk@codecoup.pl>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

While value has more than single MTU can carry long read procedure will
be triggered. In such cases offset need to bo considered while getting
value from storage.
---
 client/gatt.c | 41 ++++++++++++++++++++++++++++++++++++++++-
 1 file changed, 40 insertions(+), 1 deletion(-)

diff --git a/client/gatt.c b/client/gatt.c
index 8c818d8c1..9d8c50d47 100644
--- a/client/gatt.c
+++ b/client/gatt.c
@@ -1412,6 +1412,39 @@ static const GDBusPropertyTable chrc_properties[] = {
 	{ }
 };
 
+static int parse_offset(DBusMessageIter *iter, uint16_t *offset)
+{
+	DBusMessageIter dict;
+
+	if (dbus_message_iter_get_arg_type(iter) != DBUS_TYPE_ARRAY)
+		return -EINVAL;
+
+	dbus_message_iter_recurse(iter, &dict);
+
+	while (dbus_message_iter_get_arg_type(&dict) == DBUS_TYPE_DICT_ENTRY) {
+		const char *key;
+		DBusMessageIter value, entry;
+		int var;
+
+		dbus_message_iter_recurse(&dict, &entry);
+		dbus_message_iter_get_basic(&entry, &key);
+
+		dbus_message_iter_next(&entry);
+		dbus_message_iter_recurse(&entry, &value);
+
+		var = dbus_message_iter_get_arg_type(&value);
+		if (strcasecmp(key, "offset") == 0) {
+			if (var != DBUS_TYPE_UINT16)
+				return -EINVAL;
+			dbus_message_iter_get_basic(&value, offset);
+		}
+
+		dbus_message_iter_next(&dict);
+	}
+
+	return 0;
+}
+
 static DBusMessage *read_value(DBusMessage *msg, uint8_t *value,
 						uint16_t value_len)
 {
@@ -1433,8 +1466,14 @@ static DBusMessage *chrc_read_value(DBusConnection *conn, DBusMessage *msg,
 							void *user_data)
 {
 	struct chrc *chrc = user_data;
+	DBusMessageIter iter;
+	uint16_t offset = 0;
+
+	dbus_message_iter_init(msg, &iter);
+
+	parse_offset(&iter, &offset);
 
-	return read_value(msg, chrc->value, chrc->value_len);
+	return read_value(msg, &chrc->value[offset], chrc->value_len - offset);
 }
 
 static int parse_value_arg(DBusMessageIter *iter, uint8_t **value, int *len)
-- 
2.13.6

