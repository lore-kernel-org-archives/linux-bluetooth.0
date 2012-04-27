Return-Path: <cyrus@holtmann.org>
From: Henrique Dante de Almeida <hdante@profusion.mobi>
To: linux-bluetooth@vger.kernel.org
Cc: Henrique Dante de Almeida <hdante@profusion.mobi>
Subject: [PATCH RFC 2/4] thermometer: implement support for DBus.Properties.Get and DBus.Properties.Set
Date: Fri, 27 Apr 2012 18:54:04 -0300
Message-Id: <1335563646-9944-3-git-send-email-hdante@profusion.mobi>
In-Reply-To: <1335563646-9944-1-git-send-email-hdante@profusion.mobi>
References: <1335563646-9944-1-git-send-email-hdante@profusion.mobi>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

---
 thermometer/thermometer.c |   86 +++++++++++++++++++++++++++++++++++++++++++--
 1 files changed, 83 insertions(+), 3 deletions(-)

diff --git a/thermometer/thermometer.c b/thermometer/thermometer.c
index 487c1fc..2c70721 100644
--- a/thermometer/thermometer.c
+++ b/thermometer/thermometer.c
@@ -556,6 +556,57 @@ static void configure_thermometer_cb(GSList *characteristics, guint8 status,
 	}
 }
 
+static gboolean get_property_intermediate(DBusConnection *connection,
+		DBusMessage *message, const GDBusPropertyTable *property,
+		DBusMessageIter *variant, void *data)
+{
+	struct thermometer *t = data;
+	dbus_message_iter_append_basic(variant, DBUS_TYPE_BOOLEAN,
+		&t->intermediate);
+	return TRUE;
+}
+
+gboolean property_interval_exists(const GDBusPropertyTable *property,
+								void *data)
+{
+	struct thermometer *t = data;
+
+	return (t->has_interval);
+}
+
+static gboolean get_property_interval(DBusConnection *connection,
+		DBusMessage *message, const GDBusPropertyTable *property,
+		DBusMessageIter *variant, void *data)
+{
+	struct thermometer *t = data;
+
+	dbus_message_iter_append_basic(variant, DBUS_TYPE_UINT16, &t->interval);
+
+	return TRUE;
+}
+
+static gboolean get_property_maximum(DBusConnection *connection,
+		DBusMessage *message, const GDBusPropertyTable *property,
+		DBusMessageIter *variant, void *data)
+{
+	struct thermometer *t = data;
+
+	dbus_message_iter_append_basic(variant, DBUS_TYPE_UINT16, &t->max);
+
+	return TRUE;
+}
+
+static gboolean get_property_minimum(DBusConnection *connection,
+		DBusMessage *message, const GDBusPropertyTable *property,
+		DBusMessageIter *variant, void *data)
+{
+	struct thermometer *t = data;
+
+	dbus_message_iter_append_basic(variant, DBUS_TYPE_UINT16, &t->min);
+
+	return TRUE;
+}
+
 static DBusMessage *get_properties(DBusConnection *conn, DBusMessage *msg,
 								void *data)
 {
@@ -640,6 +691,21 @@ static DBusMessage *write_attr_interval(struct thermometer *t, DBusMessage *msg,
 	return dbus_message_new_method_return(msg);
 }
 
+DBusMessage *set_property_interval(DBusConnection *connection,
+		DBusMessage *message, const GDBusPropertyTable *property,
+		DBusMessageIter *iter, void *data)
+{
+	struct thermometer *t = data;
+	uint16_t value;
+
+	if (dbus_message_iter_get_arg_type(iter) != DBUS_TYPE_UINT16)
+		return btd_error_invalid_args(message);
+
+	dbus_message_iter_get_basic(iter, &value);
+
+	return write_attr_interval(t, message, value);
+}
+
 static DBusMessage *set_property(DBusConnection *conn, DBusMessage *msg,
 								void *data)
 {
@@ -960,9 +1026,11 @@ static DBusMessage *disable_intermediate(DBusConnection *conn, DBusMessage *msg,
 }
 
 static const GDBusMethodTable thermometer_methods[] = {
-	{ "GetProperties", "", "a{sv}[properties]", get_properties },
+	{ "GetProperties", "", "a{sv}[properties]", get_properties,
+						G_DBUS_METHOD_FLAG_DEPRECATED},
 	{ "SetProperty", "s[name]v[value]", "", set_property,
-						G_DBUS_METHOD_FLAG_ASYNC },
+						G_DBUS_METHOD_FLAG_ASYNC |
+						G_DBUS_METHOD_FLAG_DEPRECATED},
 	{ "RegisterWatcher", "o[agent]", "", register_watcher },
 	{ "UnregisterWatcher", "o[agent]", "", unregister_watcher },
 	{ "EnableIntermediateMeasurement", "o[agent]", "", enable_intermediate },
@@ -975,6 +1043,17 @@ static const GDBusSignalTable thermometer_signals[] = {
 	{ }
 };
 
+static const GDBusPropertyTable thermometer_properties[] = {
+	{ "Intermediate", "b", 0, get_property_intermediate },
+	{ "Interval", "q", 0, get_property_interval, set_property_interval,
+						property_interval_exists },
+	{ "Maximum", "q", 0, get_property_maximum, NULL,
+						property_interval_exists },
+	{ "Minimum", "q", 0, get_property_minimum, NULL,
+						property_interval_exists },
+	{ }
+};
+
 static void update_watcher(gpointer data, gpointer user_data)
 {
 	struct watcher *w = data;
@@ -1228,7 +1307,8 @@ int thermometer_register(DBusConnection *connection, struct btd_device *device,
 
 	if (!g_dbus_register_interface(t->conn, path, THERMOMETER_INTERFACE,
 				thermometer_methods, thermometer_signals,
-				NULL, t, destroy_thermometer)) {
+				thermometer_properties, t,
+				destroy_thermometer)) {
 		error("D-Bus failed to register %s interface",
 							THERMOMETER_INTERFACE);
 		destroy_thermometer(t);
-- 
1.7.5.4

