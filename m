Return-Path: <cyrus@holtmann.org>
From: Andrzej Kaczmarek <andrzej.kaczmarek@tieto.com>
To: <linux-bluetooth@vger.kernel.org>
CC: Andrzej Kaczmarek <andrzej.kaczmarek@tieto.com>
Subject: [PATCH 13/15] thermometer: Remove legacy properties code
Date: Fri, 9 Nov 2012 09:55:55 +0100
Message-ID: <1352451357-22097-14-git-send-email-andrzej.kaczmarek@tieto.com>
In-Reply-To: <1352451357-22097-1-git-send-email-andrzej.kaczmarek@tieto.com>
References: <1352451357-22097-1-git-send-email-andrzej.kaczmarek@tieto.com>
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

This patch removes Get-/SetProperties methods along with PropertyChanged
signal which are now redundant after moving to generic DBus.Properties
interface.
---
 profiles/thermometer/thermometer.c | 129 +------------------------------------
 1 file changed, 2 insertions(+), 127 deletions(-)

diff --git a/profiles/thermometer/thermometer.c b/profiles/thermometer/thermometer.c
index b98fe88..cb81da6 100644
--- a/profiles/thermometer/thermometer.c
+++ b/profiles/thermometer/thermometer.c
@@ -243,9 +243,6 @@ static void change_property(struct thermometer *t, const char *name,
 			return;
 
 		t->intermediate = *intermediate;
-		emit_property_changed(device_get_path(t->dev),
-					THERMOMETER_INTERFACE, name,
-					DBUS_TYPE_BOOLEAN, &t->intermediate);
 	} else if (g_strcmp0(name, "Interval") == 0) {
 		uint16_t *interval = value;
 		if (t->has_interval && t->interval == *interval)
@@ -253,27 +250,18 @@ static void change_property(struct thermometer *t, const char *name,
 
 		t->has_interval = TRUE;
 		t->interval = *interval;
-		emit_property_changed(device_get_path(t->dev),
-					THERMOMETER_INTERFACE, name,
-					DBUS_TYPE_UINT16, &t->interval);
 	} else if (g_strcmp0(name, "Maximum") == 0) {
 		uint16_t *max = value;
 		if (t->max == *max)
 			return;
 
 		t->max = *max;
-		emit_property_changed(device_get_path(t->dev),
-					THERMOMETER_INTERFACE, name,
-					DBUS_TYPE_UINT16, &t->max);
 	} else if (g_strcmp0(name, "Minimum") == 0) {
 		uint16_t *min = value;
 		if (t->min == *min)
 			return;
 
 		t->min = *min;
-		emit_property_changed(device_get_path(t->dev),
-					THERMOMETER_INTERFACE, name,
-					DBUS_TYPE_UINT16, &t->min);
 	} else {
 		DBG("%s is not a thermometer property", name);
 		return;
@@ -768,40 +756,6 @@ static void configure_thermometer_cb(GSList *characteristics, guint8 status,
 	}
 }
 
-static DBusMessage *get_properties(DBusConnection *conn, DBusMessage *msg,
-								void *data)
-{
-	struct thermometer *t = data;
-	DBusMessageIter iter;
-	DBusMessageIter dict;
-	DBusMessage *reply;
-
-	reply = dbus_message_new_method_return(msg);
-	if (reply == NULL)
-		return NULL;
-
-	dbus_message_iter_init_append(reply, &iter);
-
-	dbus_message_iter_open_container(&iter, DBUS_TYPE_ARRAY,
-			DBUS_DICT_ENTRY_BEGIN_CHAR_AS_STRING
-			DBUS_TYPE_STRING_AS_STRING DBUS_TYPE_VARIANT_AS_STRING
-			DBUS_DICT_ENTRY_END_CHAR_AS_STRING, &dict);
-
-	dict_append_entry(&dict, "Intermediate", DBUS_TYPE_BOOLEAN,
-							&t->intermediate);
-
-	if (t->has_interval) {
-		dict_append_entry(&dict, "Interval", DBUS_TYPE_UINT16,
-								&t->interval);
-		dict_append_entry(&dict, "Maximum", DBUS_TYPE_UINT16, &t->max);
-		dict_append_entry(&dict, "Minimum", DBUS_TYPE_UINT16, &t->min);
-	}
-
-	dbus_message_iter_close_container(&iter, &dict);
-
-	return reply;
-}
-
 static void write_interval_cb(guint8 status, const guint8 *pdu, guint16 len,
 							gpointer user_data)
 {
@@ -824,68 +778,6 @@ done:
 	g_free(user_data);
 }
 
-static DBusMessage *write_attr_interval(struct thermometer *t, DBusMessage *msg,
-								uint16_t value)
-{
-	struct tmp_interval_data *data;
-	uint8_t atval[2];
-
-	if (t->attrib == NULL)
-		return btd_error_not_connected(msg);
-
-	if (t->interval_val_handle == 0)
-		return btd_error_not_available(msg);
-
-	if (value < t->min || value > t->max)
-		return btd_error_invalid_args(msg);
-
-	att_put_u16(value, &atval[0]);
-
-	data = g_new0(struct tmp_interval_data, 1);
-	data->thermometer = t;
-	data->interval = value;
-	gatt_write_char(t->attrib, t->interval_val_handle, atval, 2,
-						write_interval_cb, data);
-
-	return dbus_message_new_method_return(msg);
-}
-
-static DBusMessage *set_property(DBusConnection *conn, DBusMessage *msg,
-								void *data)
-{
-	struct thermometer *t = data;
-	const char *property;
-	DBusMessageIter iter;
-	DBusMessageIter sub;
-	uint16_t value;
-
-	if (!dbus_message_iter_init(msg, &iter))
-		return btd_error_invalid_args(msg);
-
-	if (dbus_message_iter_get_arg_type(&iter) != DBUS_TYPE_STRING)
-		return btd_error_invalid_args(msg);
-
-	dbus_message_iter_get_basic(&iter, &property);
-	if (g_strcmp0("Interval", property) != 0)
-		return btd_error_invalid_args(msg);
-
-	if (!t->has_interval)
-		return btd_error_not_available(msg);
-
-	dbus_message_iter_next(&iter);
-	if (dbus_message_iter_get_arg_type(&iter) != DBUS_TYPE_VARIANT)
-		return btd_error_invalid_args(msg);
-
-	dbus_message_iter_recurse(&iter, &sub);
-
-	if (dbus_message_iter_get_arg_type(&sub) != DBUS_TYPE_UINT16)
-		return btd_error_invalid_args(msg);
-
-	dbus_message_iter_get_basic(&sub, &value);
-
-	return write_attr_interval(t, msg, value);
-}
-
 static void enable_final_measurement(gpointer data, gpointer user_data)
 {
 	struct thermometer *t = data;
@@ -1227,22 +1119,6 @@ static const GDBusPropertyTable thermometer_properties[] = {
 	{ }
 };
 
-static const GDBusMethodTable thermometer_methods[] = {
-	{ GDBUS_METHOD("GetProperties",
-			NULL, GDBUS_ARGS({ "properties", "a{sv}" }),
-			get_properties) },
-	{ GDBUS_ASYNC_METHOD("SetProperty",
-			GDBUS_ARGS({ "name", "s" }, { "value", "v" }), NULL,
-			set_property) },
-	{ }
-};
-
-static const GDBusSignalTable thermometer_signals[] = {
-	{ GDBUS_SIGNAL("PropertyChanged",
-			GDBUS_ARGS({ "name", "s" }, { "value", "v" })) },
-	{ }
-};
-
 static void attio_connected_cb(GAttrib *attrib, gpointer user_data)
 {
 	struct thermometer *t = user_data;
@@ -1303,9 +1179,8 @@ int thermometer_register(struct btd_device *device, struct gatt_primary *tattr)
 
 	if (!g_dbus_register_interface(btd_get_dbus_connection(),
 				path, THERMOMETER_INTERFACE,
-				thermometer_methods, thermometer_signals,
-				thermometer_properties, t,
-				destroy_thermometer)) {
+				NULL, NULL, thermometer_properties,
+				t, destroy_thermometer)) {
 		error("D-Bus failed to register %s interface",
 							THERMOMETER_INTERFACE);
 		destroy_thermometer(t);
-- 
1.8.0

