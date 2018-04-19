Return-Path: <linux-bluetooth-owner@vger.kernel.org>
From: Grzegorz Kolodziejczyk <grzegorz.kolodziejczyk@codecoup.pl>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH BlueZ v2 3/4] client: Fix writing attribute values
Date: Thu, 19 Apr 2018 16:03:11 +0200
Message-Id: <20180419140312.22707-3-grzegorz.kolodziejczyk@codecoup.pl>
In-Reply-To: <20180419140312.22707-1-grzegorz.kolodziejczyk@codecoup.pl>
References: <20180419140312.22707-1-grzegorz.kolodziejczyk@codecoup.pl>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Attribute values is not copied with dbus_message_iter_get_fixed_array,
so gatt write callback needs to replace old value with reallocation and
copy.
---
 client/gatt.c | 8 +++++++-
 1 file changed, 7 insertions(+), 1 deletion(-)

diff --git a/client/gatt.c b/client/gatt.c
index 52a999dc9..102c11437 100644
--- a/client/gatt.c
+++ b/client/gatt.c
@@ -1589,12 +1589,18 @@ static DBusMessage *chrc_read_value(DBusConnection *conn, DBusMessage *msg,
 static int parse_value_arg(DBusMessageIter *iter, uint8_t **value, int *len)
 {
 	DBusMessageIter array;
+	uint8_t *read_value;
+	int read_len;
 
 	if (dbus_message_iter_get_arg_type(iter) != DBUS_TYPE_ARRAY)
 		return -EINVAL;
 
 	dbus_message_iter_recurse(iter, &array);
-	dbus_message_iter_get_fixed_array(&array, value, len);
+	dbus_message_iter_get_fixed_array(&array, &read_value, &read_len);
+
+	g_free(*value);
+	*value = g_memdup(read_value, read_len);
+	*len = read_len;
 
 	return 0;
 }
-- 
2.13.6

