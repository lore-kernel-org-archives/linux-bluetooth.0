Return-Path: <linux-bluetooth-owner@vger.kernel.org>
From: Grzegorz Kolodziejczyk <grzegorz.kolodziejczyk@codecoup.pl>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH BlueZ v3 2/4] client: Fix writing attribute values
Date: Thu, 26 Apr 2018 14:31:58 +0200
Message-Id: <20180426123200.3916-2-grzegorz.kolodziejczyk@codecoup.pl>
In-Reply-To: <20180426123200.3916-1-grzegorz.kolodziejczyk@codecoup.pl>
References: <20180426123200.3916-1-grzegorz.kolodziejczyk@codecoup.pl>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Attribute values is not copied with dbus_message_iter_get_fixed_array,
so gatt write callback needs to replace old value with reallocation and
copy.
---
 client/gatt.c | 16 +++++++++++++++-
 1 file changed, 15 insertions(+), 1 deletion(-)

diff --git a/client/gatt.c b/client/gatt.c
index 52a999dc9..b0ef7b9c0 100644
--- a/client/gatt.c
+++ b/client/gatt.c
@@ -1589,12 +1589,26 @@ static DBusMessage *chrc_read_value(DBusConnection *conn, DBusMessage *msg,
 static int parse_value_arg(DBusMessageIter *iter, uint8_t **value, int *len)
 {
 	DBusMessageIter array;
+	uint16_t offset = 0;
+	uint8_t *read_value;
+	int read_len;
 
 	if (dbus_message_iter_get_arg_type(iter) != DBUS_TYPE_ARRAY)
 		return -EINVAL;
 
 	dbus_message_iter_recurse(iter, &array);
-	dbus_message_iter_get_fixed_array(&array, value, len);
+	dbus_message_iter_get_fixed_array(&array, &read_value, &read_len);
+
+	dbus_message_iter_next(iter);
+	if (parse_options(iter, &offset, NULL, NULL, NULL))
+		return -EINVAL;
+
+	if ((offset + read_len) > *len) {
+		*len = offset + read_len;
+		*value = g_realloc(*value, *len);
+	}
+
+	memcpy(*value + offset, read_value, read_len);
 
 	return 0;
 }
-- 
2.13.6

