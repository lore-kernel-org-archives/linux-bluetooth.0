Return-Path: <cyrus@holtmann.org>
From: Claudio Takahasi <claudio.takahasi@openbossa.org>
To: linux-bluetooth@vger.kernel.org
Cc: Claudio Takahasi <claudio.takahasi@openbossa.org>
Subject: [PATCH BlueZ 11/11] Add on demand characteristic write
Date: Tue, 12 Jul 2011 17:28:41 -0300
Message-Id: <1310502521-462-12-git-send-email-claudio.takahasi@openbossa.org>
In-Reply-To: <1310502521-462-1-git-send-email-claudio.takahasi@openbossa.org>
References: <1310502521-462-1-git-send-email-claudio.takahasi@openbossa.org>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Changes the Generic Attribute registering a callback to request ATT
connection(if necessary) and write the characteristic value.
---
 attrib/client.c |   42 +++++++++++++++++++++++++++++++++++++-----
 1 files changed, 37 insertions(+), 5 deletions(-)

diff --git a/attrib/client.c b/attrib/client.c
index 03d161e..70cbf15 100644
--- a/attrib/client.c
+++ b/attrib/client.c
@@ -77,6 +77,7 @@ struct gatt_service {
 	int psm;
 	char *path;
 	GSList *chars;
+	GSList *offline_chars;
 	GSList *watchers;
 	struct query *query;
 };
@@ -135,6 +136,7 @@ static void gatt_service_free(struct gatt_service *gatt)
 {
 	g_slist_free_full(gatt->watchers, watcher_free);
 	g_slist_free_full(gatt->chars, characteristic_free);
+	g_slist_free(gatt->offline_chars);
 	g_free(gatt->path);
 	btd_device_unref(gatt->dev);
 	dbus_connection_unref(gatt->conn);
@@ -291,6 +293,29 @@ static void events_handler(const uint8_t *pdu, uint16_t len,
 	}
 }
 
+static void offline_char_written(gpointer user_data)
+{
+	struct characteristic *chr = user_data;
+	struct gatt_service *gatt = chr->gatt;
+
+	gatt->offline_chars = g_slist_remove(gatt->offline_chars, chr);
+
+	if (gatt->offline_chars || gatt->watchers)
+		return;
+
+	btd_device_remove_attio_callback(gatt->dev, gatt->attioid);
+	gatt->attioid = 0;
+}
+
+static void offline_char_write(gpointer data, gpointer user_data)
+{
+	struct characteristic *chr = data;
+	GAttrib *attrib = user_data;
+
+	gatt_write_cmd(attrib, chr->handle, chr->value, chr->vlen,
+						offline_char_written, chr);
+}
+
 static void attio_connected(GAttrib *attrib, gpointer user_data)
 {
 	struct gatt_service *gatt = user_data;
@@ -301,6 +326,8 @@ static void attio_connected(GAttrib *attrib, gpointer user_data)
 					events_handler, gatt, NULL);
 	g_attrib_register(gatt->attrib, ATT_OP_HANDLE_IND,
 					events_handler, gatt, NULL);
+
+	g_slist_foreach(gatt->offline_chars, offline_char_write, attrib);
 }
 
 static void attio_disconnected(gpointer user_data)
@@ -382,9 +409,6 @@ static DBusMessage *set_value(DBusConnection *conn, DBusMessage *msg,
 	uint8_t *value;
 	int len;
 
-	if (gatt->attrib == NULL)
-		return btd_error_not_connected(msg);
-
 	if (dbus_message_iter_get_arg_type(iter) != DBUS_TYPE_ARRAY ||
 			dbus_message_iter_get_element_type(iter) != DBUS_TYPE_BYTE)
 		return btd_error_invalid_args(msg);
@@ -393,10 +417,18 @@ static DBusMessage *set_value(DBusConnection *conn, DBusMessage *msg,
 
 	dbus_message_iter_get_fixed_array(&sub, &value, &len);
 
-	gatt_write_cmd(gatt->attrib, chr->handle, value, len, NULL, NULL);
-
 	characteristic_set_value(chr, value, len);
 
+	if (gatt->attioid == 0) {
+		gatt->attioid = btd_device_add_attio_callback(gatt->dev,
+							attio_connected,
+							attio_disconnected,
+							gatt);
+		gatt->offline_chars = g_slist_append(gatt->offline_chars, chr);
+	} else
+		gatt_write_cmd(gatt->attrib, chr->handle, value, len,
+								NULL, NULL);
+
 	return dbus_message_new_method_return(msg);
 }
 
-- 
1.7.6

