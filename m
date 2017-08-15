Return-Path: <linux-bluetooth-owner@vger.kernel.org>
From: Yunhan Wang <yunhanw@google.com>
To: linux-bluetooth@vger.kernel.org
Cc: Yunhan Wang <yunhanw@google.com>
Subject: [PATCH BlueZ] gdbus: add method to receive reply when property is updated
Date: Mon, 14 Aug 2017 18:22:42 -0700
Message-Id: <20170815012242.70454-1-yunhanw@google.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

This add g_dbus_emit_property_changed_with_reply to receive reply when
property change is emitted.
If no reply is received in the given timeout_milliseconds or reply is
recieved, the notification function is called. If destroy function is
set, this function would be called after notification function completes.
---
 gdbus/gdbus.h     | 20 +++++++++++--
 gdbus/object.c    | 87 +++++++++++++++++++++++++++++++++++++++++++++++++++----
 src/gatt-client.c |  2 +-
 3 files changed, 100 insertions(+), 9 deletions(-)

diff --git a/gdbus/gdbus.h b/gdbus/gdbus.h
index e37385fa1..8099a9930 100644
--- a/gdbus/gdbus.h
+++ b/gdbus/gdbus.h
@@ -59,6 +59,8 @@ gboolean g_dbus_set_disconnect_function(DBusConnection *connection,
 				GDBusWatchFunction function,
 				void *user_data, DBusFreeFunction destroy);
 
+typedef void (* GDBusResultFunction) (const DBusError *error, void *user_data);
+
 typedef void (* GDBusDestroyFunction) (void *user_data);
 
 typedef DBusMessage * (* GDBusMethodFunction) (DBusConnection *connection,
@@ -314,10 +316,24 @@ void g_dbus_pending_property_error(GDBusPendingReply id, const char *name,
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
+				GDBusDestroyFunction destroy,
+				int timeout);
+
+void g_dbus_emit_property_changed_with_reply(DBusConnection *connection,
+				const char *path, const char *interface,
+				const char *name,
+				GDBusResultFunction function,
+				void *user_data,
+				GDBusDestroyFunction destroy,
+				int timeout);
+
 gboolean g_dbus_get_properties(DBusConnection *connection, const char *path,
 				const char *interface, DBusMessageIter *iter);
 
@@ -341,8 +357,6 @@ gboolean g_dbus_proxy_get_property(GDBusProxy *proxy, const char *name,
 
 gboolean g_dbus_proxy_refresh_property(GDBusProxy *proxy, const char *name);
 
-typedef void (* GDBusResultFunction) (const DBusError *error, void *user_data);
-
 gboolean g_dbus_proxy_set_property_basic(GDBusProxy *proxy,
 				const char *name, int type, const void *value,
 				GDBusResultFunction function, void *user_data,
diff --git a/gdbus/object.c b/gdbus/object.c
index afb458764..16d769c9b 100644
--- a/gdbus/object.c
+++ b/gdbus/object.c
@@ -59,6 +59,10 @@ struct generic_data {
 	gboolean pending_prop;
 	char *introspect;
 	struct generic_data *parent;
+	GDBusResultFunction function;
+	void *user_data;
+	GDBusDestroyFunction destroy;
+	int timeout;
 };
 
 struct interface_data {
@@ -84,6 +88,12 @@ struct property_data {
 	DBusMessage *message;
 };
 
+struct process_property_data {
+	GDBusResultFunction function;
+	void *user_data;
+	GDBusDestroyFunction destroy;
+};
+
 static int global_flags = 0;
 static struct generic_data *root;
 static GSList *pending = NULL;
@@ -1651,6 +1661,26 @@ fail:
 	return ret;
 }
 
+static void process_property_reply(DBusPendingCall *call, void *user_data)
+{
+	struct process_property_data *data = user_data;
+	DBusMessage *reply = dbus_pending_call_steal_reply(call);
+	DBusError error;
+
+	dbus_error_init(&error);
+
+	dbus_set_error_from_message(&error, reply);
+
+	if (data->function)
+		data->function(&error, data->user_data);
+
+	if (data->destroy)
+		data->destroy(data->user_data);
+
+	dbus_error_free(&error);
+	dbus_message_unref(reply);
+}
+
 static void process_properties_from_interface(struct generic_data *data,
 						struct interface_data *iface)
 {
@@ -1658,7 +1688,7 @@ static void process_properties_from_interface(struct generic_data *data,
 	DBusMessage *signal;
 	DBusMessageIter iter, dict, array;
 	GSList *invalidated;
-
+	DBusPendingCall *call;
 	data->pending_prop = FALSE;
 
 	if (iface->pending_prop == NULL)
@@ -1713,8 +1743,35 @@ static void process_properties_from_interface(struct generic_data *data,
 	g_slist_free(iface->pending_prop);
 	iface->pending_prop = NULL;
 
-	/* Use dbus_connection_send to avoid recursive calls to g_dbus_flush */
-	dbus_connection_send(data->conn, signal, NULL);
+	if (data->function != NULL)
+	{
+		struct process_property_data *process_property_data;
+
+		process_property_data = g_try_new0(struct process_property_data, 1);
+		if (process_property_data == NULL)
+			return;
+
+		process_property_data->function = data->function;
+		process_property_data->user_data = data->user_data;
+		process_property_data->destroy = data->destroy;
+
+		/* Use dbus_connection_send to avoid recursive calls to g_dbus_flush */
+		if (g_dbus_send_message_with_reply(data->conn, signal,
+								&call, data->timeout) == FALSE) {
+			dbus_message_unref(signal);
+			g_free(process_property_data);
+			return;
+		}
+
+		dbus_pending_call_set_notify(call, process_property_reply, process_property_data, g_free);
+		dbus_pending_call_unref(call);
+	}
+	else
+	{
+		/* Use dbus_connection_send to avoid recursive calls to g_dbus_flush */
+		dbus_connection_send(data->conn, signal, NULL);
+	}
+
 	dbus_message_unref(signal);
 }
 
@@ -1732,7 +1789,11 @@ static void process_property_changes(struct generic_data *data)
 void g_dbus_emit_property_changed_full(DBusConnection *connection,
 				const char *path, const char *interface,
 				const char *name,
-				GDbusPropertyChangedFlags flags)
+				GDbusPropertyChangedFlags flags,
+				GDBusResultFunction function,
+				void *user_data,
+				GDBusDestroyFunction destroy,
+				int timeout)
 {
 	const GDBusPropertyTable *property;
 	struct generic_data *data;
@@ -1770,6 +1831,14 @@ void g_dbus_emit_property_changed_full(DBusConnection *connection,
 	iface->pending_prop = g_slist_prepend(iface->pending_prop,
 						(void *) property);
 
+	if (function != NULL)
+	{
+		data->function = function;
+		data->user_data = user_data;
+		data->destroy = destroy;
+		data->timeout = timeout;
+	}
+
 	if (flags & G_DBUS_PROPERTY_CHANGED_FLAG_FLUSH)
 		process_property_changes(data);
 	else
@@ -1779,7 +1848,15 @@ void g_dbus_emit_property_changed_full(DBusConnection *connection,
 void g_dbus_emit_property_changed(DBusConnection *connection, const char *path,
 				const char *interface, const char *name)
 {
-	g_dbus_emit_property_changed_full(connection, path, interface, name, 0);
+	g_dbus_emit_property_changed_full(connection, path, interface, name, 0, NULL, NULL, NULL, 0);
+}
+
+void g_dbus_emit_property_changed_with_reply(DBusConnection *connection, const char *path,
+				const char *interface, const char *name,
+				GDBusResultFunction function, void *user_data,
+				GDBusDestroyFunction destroy, int timeout)
+{
+	g_dbus_emit_property_changed_full(connection, path, interface, name, 0, function, user_data, destroy, timeout);
 }
 
 gboolean g_dbus_get_properties(DBusConnection *connection, const char *path,
diff --git a/src/gatt-client.c b/src/gatt-client.c
index 1cd7fbcf5..5fd94657c 100644
--- a/src/gatt-client.c
+++ b/src/gatt-client.c
@@ -878,7 +878,7 @@ static void write_characteristic_cb(struct gatt_db_attribute *attr, int err,
 
 	g_dbus_emit_property_changed_full(btd_get_dbus_connection(),
 				chrc->path, GATT_CHARACTERISTIC_IFACE,
-				"Value", G_DBUS_PROPERTY_CHANGED_FLAG_FLUSH);
+				"Value", G_DBUS_PROPERTY_CHANGED_FLAG_FLUSH, NULL, NULL, NULL, 0);
 
 }
 
-- 
2.14.0.434.g98096fd7a8-goog

