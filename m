Return-Path: <cyrus@holtmann.org>
From: Vinicius Costa Gomes <vinicius.gomes@openbossa.org>
To: linux-bluetooth@vger.kernel.org
Cc: Vinicius Costa Gomes <vinicius.gomes@openbossa.org>
Subject: [RFC BlueZ 2/4] Add a way to enable notifications using the CCC descriptor
Date: Fri, 11 Nov 2011 21:20:07 -0300
Message-Id: <1321057209-24931-3-git-send-email-vinicius.gomes@openbossa.org>
In-Reply-To: <1321057209-24931-1-git-send-email-vinicius.gomes@openbossa.org>
References: <1321057209-24931-1-git-send-email-vinicius.gomes@openbossa.org>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

This implements the property "Config" of a Characterisitc, that if
present indicates that the Characteristics supports this descriptor.
Setting this property sends a write command with the correct value.
---
 attrib/client.c |  131 ++++++++++++++++++++++++++++++++++++++++++++++++++++++-
 1 files changed, 130 insertions(+), 1 deletions(-)

diff --git a/attrib/client.c b/attrib/client.c
index bfe5877..a0e8b12 100644
--- a/attrib/client.c
+++ b/attrib/client.c
@@ -78,6 +78,7 @@ struct gatt_service {
 	char *path;
 	GSList *chars;
 	GSList *offline_chars;
+	GSList *offline_configs;
 	GSList *watchers;
 	struct query *query;
 };
@@ -91,6 +92,8 @@ struct characteristic {
 	char type[MAX_LEN_UUID_STR + 1];
 	char *name;
 	char *desc;
+	uint16_t ccc;
+	uint16_t ccc_hnd;
 	struct format *format;
 	uint8_t *value;
 	size_t vlen;
@@ -137,6 +140,7 @@ static void gatt_service_free(struct gatt_service *gatt)
 	g_slist_free_full(gatt->watchers, watcher_free);
 	g_slist_free_full(gatt->chars, characteristic_free);
 	g_slist_free(gatt->offline_chars);
+	g_slist_free(gatt->offline_configs);
 	g_free(gatt->path);
 	btd_device_unref(gatt->dev);
 	dbus_connection_unref(gatt->conn);
@@ -175,6 +179,18 @@ static int watcher_cmp(gconstpointer a, gconstpointer b)
 	return g_strcmp0(watcher->path, match->path);
 }
 
+static const char *config2str(uint16_t ccc)
+{
+	switch (ccc) {
+	case 0x01:
+		return "notify";
+	case 0x02:
+		return "indicate";
+	default:
+		return "none";
+	}
+}
+
 static void append_char_dict(DBusMessageIter *iter, struct characteristic *chr)
 {
 	DBusMessageIter dict;
@@ -201,6 +217,11 @@ static void append_char_dict(DBusMessageIter *iter, struct characteristic *chr)
 		dict_append_array(&dict, "Value", DBUS_TYPE_BYTE, &chr->value,
 								chr->vlen);
 
+	if (chr->ccc_hnd) {
+		const char *config = config2str(chr->ccc);
+		dict_append_entry(&dict, "Config", DBUS_TYPE_STRING, &config);
+	}
+
 	/* FIXME: Missing Format, Value and Representation */
 
 	dbus_message_iter_close_container(iter, &dict);
@@ -300,7 +321,26 @@ static void offline_char_written(gpointer user_data)
 
 	gatt->offline_chars = g_slist_remove(gatt->offline_chars, chr);
 
-	if (gatt->offline_chars || gatt->watchers)
+	if (gatt->offline_chars || gatt->watchers || gatt->offline_configs)
+		return;
+
+	btd_device_remove_attio_callback(gatt->dev, gatt->attioid);
+	gatt->attioid = 0;
+}
+
+static void config_written(guint8 status, const guint8 *pdu,
+					guint16 len, gpointer user_data)
+{
+	struct characteristic *chr = user_data;
+	struct gatt_service *gatt = chr->gatt;
+	const char *str = config2str(chr->ccc);
+
+	gatt->offline_configs = g_slist_remove(gatt->offline_configs, chr);
+
+	emit_property_changed(gatt->conn, chr->path, CHAR_INTERFACE,
+					"Config", DBUS_TYPE_STRING, &str);
+
+	if (gatt->offline_chars || gatt->watchers || gatt->offline_configs)
 		return;
 
 	btd_device_remove_attio_callback(gatt->dev, gatt->attioid);
@@ -316,6 +356,18 @@ static void offline_char_write(gpointer data, gpointer user_data)
 						offline_char_written, chr);
 }
 
+static void offline_config_write(gpointer data, gpointer user_data)
+{
+	struct characteristic *chr = data;
+	GAttrib *attrib = user_data;
+	uint8_t buf[2];
+
+	att_put_u16(chr->ccc, buf);
+
+	gatt_write_char(attrib, chr->ccc_hnd, buf, sizeof(buf),
+						config_written, chr);
+}
+
 static void attio_connected(GAttrib *attrib, gpointer user_data)
 {
 	struct gatt_service *gatt = user_data;
@@ -328,6 +380,7 @@ static void attio_connected(GAttrib *attrib, gpointer user_data)
 					events_handler, gatt, NULL);
 
 	g_slist_foreach(gatt->offline_chars, offline_char_write, attrib);
+	g_slist_foreach(gatt->offline_configs, offline_config_write, attrib);
 }
 
 static void attio_disconnected(gpointer user_data)
@@ -401,6 +454,47 @@ static DBusMessage *unregister_watcher(DBusConnection *conn,
 	return dbus_message_new_method_return(msg);
 }
 
+static DBusMessage *set_config_char(DBusConnection *conn, DBusMessage *msg,
+			DBusMessageIter *iter, struct characteristic *chr)
+{
+	struct gatt_service *gatt = chr->gatt;
+	const char *str;
+	uint8_t buf[2];
+
+	if (dbus_message_iter_get_arg_type(iter) != DBUS_TYPE_STRING)
+		return btd_error_invalid_args(msg);
+
+	dbus_message_iter_get_basic(iter, &str);
+
+	if (chr->ccc_hnd == 0)
+		return btd_error_not_supported(msg);
+
+	if (g_str_equal(str, "notify"))
+		chr->ccc = 0x01;
+	else if (g_str_equal(str, "indicate"))
+		chr->ccc = 0x02;
+	else if (g_str_equal(str, "none"))
+		chr->ccc = 0;
+	else
+		return btd_error_invalid_args(msg);
+
+	if (gatt->attioid == 0) {
+		gatt->attioid = btd_device_add_attio_callback(gatt->dev,
+							attio_connected,
+							attio_disconnected,
+							gatt);
+		gatt->offline_configs = g_slist_append(gatt->offline_configs, chr);
+
+		return dbus_message_new_method_return(msg);
+	}
+
+	att_put_u16(chr->ccc, buf);
+	gatt_write_char(gatt->attrib, chr->ccc_hnd, buf, sizeof(buf),
+						config_written, chr);
+
+	return NULL;
+}
+
 static DBusMessage *set_value(DBusConnection *conn, DBusMessage *msg,
 			DBusMessageIter *iter, struct characteristic *chr)
 {
@@ -475,6 +569,9 @@ static DBusMessage *set_property(DBusConnection *conn,
 	if (g_str_equal("Value", property))
 		return set_value(conn, msg, &sub, chr);
 
+	if (g_str_equal("Config", property))
+		return set_config_char(conn, msg, &sub, chr);
+
 	return btd_error_invalid_args(msg);
 }
 
@@ -720,6 +817,33 @@ static void update_char_value(guint8 status, const guint8 *pdu,
 	g_free(current);
 }
 
+
+static void update_char_config(guint8 status, const guint8 *pdu, guint16 len,
+								gpointer user_data)
+{
+	struct query_data *current = user_data;
+	struct gatt_service *gatt = current->gatt;
+	struct characteristic *chr = current->chr;
+	uint8_t value[2];
+
+	if (status != 0)
+		goto done;
+
+	if (len < 3)
+		goto done;
+
+	chr->ccc = att_get_u16(&pdu[1]);
+	chr->ccc_hnd = current->handle;
+	memcpy(value, &chr->ccc, sizeof(chr->ccc));
+
+	store_attribute(gatt, current->handle, GATT_CLIENT_CHARAC_CFG_UUID,
+							value, sizeof(value));
+
+done:
+	query_list_remove(gatt, current);
+	g_free(current);
+}
+
 static int uuid_desc16_cmp(bt_uuid_t *uuid, guint16 desc)
 {
 	bt_uuid_t u16;
@@ -777,6 +901,11 @@ static void descriptor_cb(guint8 status, const guint8 *pdu, guint16 plen,
 			query_list_append(gatt, qfmt);
 			gatt_read_char(gatt->attrib, handle, 0,
 						update_char_format, qfmt);
+		} else if (uuid_desc16_cmp(&uuid,
+					GATT_CLIENT_CHARAC_CFG_UUID) == 0) {
+			query_list_append(gatt, qfmt);
+			gatt_read_char(gatt->attrib, handle, 0,
+						update_char_config, qfmt);
 		} else
 			g_free(qfmt);
 	}
-- 
1.7.7

