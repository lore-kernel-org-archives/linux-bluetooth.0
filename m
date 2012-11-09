Return-Path: <cyrus@holtmann.org>
From: Andrzej Kaczmarek <andrzej.kaczmarek@tieto.com>
To: <linux-bluetooth@vger.kernel.org>
CC: Andrzej Kaczmarek <andrzej.kaczmarek@tieto.com>
Subject: [PATCH 12/15] thermometer: Add DBus.Properties support
Date: Fri, 9 Nov 2012 09:55:54 +0100
Message-ID: <1352451357-22097-13-git-send-email-andrzej.kaczmarek@tieto.com>
In-Reply-To: <1352451357-22097-1-git-send-email-andrzej.kaczmarek@tieto.com>
References: <1352451357-22097-1-git-send-email-andrzej.kaczmarek@tieto.com>
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

This patch adds handlers required to support generic DBus.Properties
interface.
---
 profiles/thermometer/thermometer.c | 116 ++++++++++++++++++++++++++++++++++++-
 1 file changed, 115 insertions(+), 1 deletion(-)

diff --git a/profiles/thermometer/thermometer.c b/profiles/thermometer/thermometer.c
index 446f011..b98fe88 100644
--- a/profiles/thermometer/thermometer.c
+++ b/profiles/thermometer/thermometer.c
@@ -276,7 +276,12 @@ static void change_property(struct thermometer *t, const char *name,
 					DBUS_TYPE_UINT16, &t->min);
 	} else {
 		DBG("%s is not a thermometer property", name);
+		return;
 	}
+
+	g_dbus_emit_property_changed(btd_get_dbus_connection(),
+						device_get_path(t->dev),
+						THERMOMETER_INTERFACE, name);
 }
 
 static void update_watcher(gpointer data, gpointer user_data)
@@ -1114,6 +1119,114 @@ static DBusMessage *disable_intermediate(DBusConnection *conn, DBusMessage *msg,
 	return dbus_message_new_method_return(msg);
 }
 
+static gboolean property_get_intermediate(const GDBusPropertyTable *property,
+					DBusMessageIter *iter, void *data)
+{
+	struct thermometer *t = data;
+	dbus_bool_t val;
+
+	val = !!t->intermediate;
+
+	dbus_message_iter_append_basic(iter, DBUS_TYPE_BOOLEAN, &val);
+
+	return TRUE;
+}
+
+static gboolean property_get_interval(const GDBusPropertyTable *property,
+					DBusMessageIter *iter, void *data)
+{
+	struct thermometer *t = data;
+
+	if (!t->has_interval)
+		return FALSE;
+
+	dbus_message_iter_append_basic(iter, DBUS_TYPE_UINT16, &t->interval);
+
+	return TRUE;
+}
+
+static void property_set_interval(const GDBusPropertyTable *property,
+					DBusMessageIter *iter,
+					GDBusPendingPropertySet id, void *data)
+{
+	struct thermometer *t = data;
+	struct tmp_interval_data *interval_data;
+	uint16_t val;
+	uint8_t atval[2];
+
+	if (t->interval_val_handle == 0)
+		return g_dbus_pending_property_error(id,
+					ERROR_INTERFACE ".NotSupported",
+					"Operation is not supported");
+
+	if (dbus_message_iter_get_arg_type(iter) != DBUS_TYPE_UINT16)
+		return g_dbus_pending_property_error(id,
+					ERROR_INTERFACE ".InvalidArguments",
+					"Invalid arguments in method call");
+
+	dbus_message_iter_get_basic(iter, &val);
+
+	if (val < t->min || val > t->max)
+		return g_dbus_pending_property_error(id,
+					ERROR_INTERFACE ".InvalidArguments",
+					"Invalid arguments in method call");
+
+	att_put_u16(val, &atval[0]);
+
+	interval_data = g_new0(struct tmp_interval_data, 1);
+	interval_data->thermometer = t;
+	interval_data->interval = val;
+	gatt_write_char(t->attrib, t->interval_val_handle, atval, sizeof(atval),
+					write_interval_cb, interval_data);
+
+	g_dbus_pending_property_success(id);
+}
+
+static gboolean property_exists_interval(const GDBusPropertyTable *property,
+								void *data)
+{
+	struct thermometer *t = data;
+
+	return t->has_interval;
+}
+
+static gboolean property_get_maximum(const GDBusPropertyTable *property,
+					DBusMessageIter *iter, void *data)
+{
+	struct thermometer *t = data;
+
+	if (!t->has_interval)
+		return FALSE;
+
+	dbus_message_iter_append_basic(iter, DBUS_TYPE_UINT16, &t->max);
+
+	return TRUE;
+}
+
+static gboolean property_get_minimum(const GDBusPropertyTable *property,
+					DBusMessageIter *iter, void *data)
+{
+	struct thermometer *t = data;
+
+	if (!t->has_interval)
+		return FALSE;
+
+	dbus_message_iter_append_basic(iter, DBUS_TYPE_UINT16, &t->min);
+
+	return TRUE;
+}
+
+static const GDBusPropertyTable thermometer_properties[] = {
+	{ "Intermediate", "b", property_get_intermediate },
+	{ "Interval", "q", property_get_interval, property_set_interval,
+						property_exists_interval },
+	{ "Maximum", "q", property_get_maximum, NULL,
+						property_exists_interval },
+	{ "Minimum", "q", property_get_minimum, NULL,
+						property_exists_interval },
+	{ }
+};
+
 static const GDBusMethodTable thermometer_methods[] = {
 	{ GDBUS_METHOD("GetProperties",
 			NULL, GDBUS_ARGS({ "properties", "a{sv}" }),
@@ -1191,7 +1304,8 @@ int thermometer_register(struct btd_device *device, struct gatt_primary *tattr)
 	if (!g_dbus_register_interface(btd_get_dbus_connection(),
 				path, THERMOMETER_INTERFACE,
 				thermometer_methods, thermometer_signals,
-				NULL, t, destroy_thermometer)) {
+				thermometer_properties, t,
+				destroy_thermometer)) {
 		error("D-Bus failed to register %s interface",
 							THERMOMETER_INTERFACE);
 		destroy_thermometer(t);
-- 
1.8.0

