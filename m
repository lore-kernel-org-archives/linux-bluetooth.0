Return-Path: <linux-bluetooth-owner@vger.kernel.org>
From: Yunhan Wang <yunhanw@google.com>
To: linux-bluetooth@vger.kernel.org
Cc: Yunhan Wang <yunhanw@google.com>
Subject: [PATCH BlueZ] Add method to process cb after emitting property
Date: Mon, 21 Aug 2017 00:03:32 -0700
Message-Id: <20170821070332.17952-1-yunhanw@google.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

This add g_dbus_emit_property_changed_with_callback to process callback functions after
property change is emitted.
---
 gdbus/gdbus.h     | 18 +++++++++++++++---
 gdbus/object.c    | 39 ++++++++++++++++++++++++++++++++++-----
 src/gatt-client.c |  2 +-
 3 files changed, 50 insertions(+), 9 deletions(-)

diff --git a/gdbus/gdbus.h b/gdbus/gdbus.h
index e37385fa1..3974b6e8c 100644
--- a/gdbus/gdbus.h
+++ b/gdbus/gdbus.h
@@ -59,6 +59,8 @@ gboolean g_dbus_set_disconnect_function(DBusConnection *connection,
 				GDBusWatchFunction function,
 				void *user_data, DBusFreeFunction destroy);
 
+typedef void (* GDBusResultFunction) (const DBusError *error, void *user_data);
+
 typedef void (* GDBusDestroyFunction) (void *user_data);
 
 typedef DBusMessage * (* GDBusMethodFunction) (DBusConnection *connection,
@@ -314,10 +316,22 @@ void g_dbus_pending_property_error(GDBusPendingReply id, const char *name,
 void g_dbus_emit_property_changed(DBusConnection *connection,
 				const char *path, const char *interface,
 				const char *name);
+
 void g_dbus_emit_property_changed_full(DBusConnection *connection,
 				const char *path, const char *interface,
 				const char *name,
-				GDbusPropertyChangedFlags flags);
+				GDbusPropertyChangedFlags flags,
+				GDBusResultFunction function,
+				void *user_data,
+				GDBusDestroyFunction destroy);
+
+void g_dbus_emit_property_changed_with_callback(DBusConnection *connection,
+				const char *path, const char *interface,
+				const char *name,
+				GDBusResultFunction function,
+				void *user_data,
+				GDBusDestroyFunction destroy);
+
 gboolean g_dbus_get_properties(DBusConnection *connection, const char *path,
 				const char *interface, DBusMessageIter *iter);
 
@@ -341,8 +355,6 @@ gboolean g_dbus_proxy_get_property(GDBusProxy *proxy, const char *name,
 
 gboolean g_dbus_proxy_refresh_property(GDBusProxy *proxy, const char *name);
 
-typedef void (* GDBusResultFunction) (const DBusError *error, void *user_data);
-
 gboolean g_dbus_proxy_set_property_basic(GDBusProxy *proxy,
 				const char *name, int type, const void *value,
 				GDBusResultFunction function, void *user_data,
diff --git a/gdbus/object.c b/gdbus/object.c
index afb458764..04c3b4fb4 100644
--- a/gdbus/object.c
+++ b/gdbus/object.c
@@ -59,6 +59,9 @@ struct generic_data {
 	gboolean pending_prop;
 	char *introspect;
 	struct generic_data *parent;
+	GDBusResultFunction function;
+	void *user_data;
+	GDBusDestroyFunction destroy;
 };
 
 struct interface_data {
@@ -1002,21 +1005,29 @@ static void remove_pending(struct generic_data *data)
 static gboolean process_changes(gpointer user_data)
 {
 	struct generic_data *data = user_data;
-
+	DBusError error;
+	dbus_error_init(&error);
 	remove_pending(data);
 
 	if (data->added != NULL)
 		emit_interfaces_added(data);
 
 	/* Flush pending properties */
-	if (data->pending_prop == TRUE)
+	if (data->pending_prop == TRUE) {
 		process_property_changes(data);
+		if (data->function != NULL) {
+			data->function(&error, data->user_data);
+		}
 
+		if (data->destroy != NULL) {
+			data->destroy(data->user_data);
+		}
+	}
 	if (data->removed != NULL)
 		emit_interfaces_removed(data);
 
 	data->process_id = 0;
-
+	dbus_error_free(&error);
 	return FALSE;
 }
 
@@ -1732,7 +1743,10 @@ static void process_property_changes(struct generic_data *data)
 void g_dbus_emit_property_changed_full(DBusConnection *connection,
 				const char *path, const char *interface,
 				const char *name,
-				GDbusPropertyChangedFlags flags)
+				GDbusPropertyChangedFlags flags,
+				GDBusResultFunction function,
+				void *user_data,
+				GDBusDestroyFunction destroy)
 {
 	const GDBusPropertyTable *property;
 	struct generic_data *data;
@@ -1770,6 +1784,13 @@ void g_dbus_emit_property_changed_full(DBusConnection *connection,
 	iface->pending_prop = g_slist_prepend(iface->pending_prop,
 						(void *) property);
 
+	if (function != NULL)
+	{
+		data->function = function;
+		data->user_data = user_data;
+		data->destroy = destroy;
+	}
+
 	if (flags & G_DBUS_PROPERTY_CHANGED_FLAG_FLUSH)
 		process_property_changes(data);
 	else
@@ -1779,7 +1800,15 @@ void g_dbus_emit_property_changed_full(DBusConnection *connection,
 void g_dbus_emit_property_changed(DBusConnection *connection, const char *path,
 				const char *interface, const char *name)
 {
-	g_dbus_emit_property_changed_full(connection, path, interface, name, 0);
+	g_dbus_emit_property_changed_full(connection, path, interface, name, 0, NULL, NULL, NULL);
+}
+
+void g_dbus_emit_property_changed_with_callback(DBusConnection *connection, const char *path,
+				const char *interface, const char *name,
+				GDBusResultFunction function, void *user_data,
+				GDBusDestroyFunction destroy)
+{
+	g_dbus_emit_property_changed_full(connection, path, interface, name, 0, function, user_data, destroy);
 }
 
 gboolean g_dbus_get_properties(DBusConnection *connection, const char *path,
diff --git a/src/gatt-client.c b/src/gatt-client.c
index 1cd7fbcf5..e70245c19 100644
--- a/src/gatt-client.c
+++ b/src/gatt-client.c
@@ -878,7 +878,7 @@ static void write_characteristic_cb(struct gatt_db_attribute *attr, int err,
 
 	g_dbus_emit_property_changed_full(btd_get_dbus_connection(),
 				chrc->path, GATT_CHARACTERISTIC_IFACE,
-				"Value", G_DBUS_PROPERTY_CHANGED_FLAG_FLUSH);
+				"Value", G_DBUS_PROPERTY_CHANGED_FLAG_FLUSH, NULL, NULL, NULL);
 
 }
 
-- 
2.14.1.480.gb18f417b89-goog

