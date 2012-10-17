Return-Path: <cyrus@holtmann.org>
From: Lucas De Marchi <lucas.demarchi@profusion.mobi>
To: linux-bluetooth@vger.kernel.org
Cc: Lucas De Marchi <lucas.demarchi@profusion.mobi>
Subject: [PATCH BlueZ 1/2] gdbus: Remove connection from pending_property functions
Date: Wed, 17 Oct 2012 12:14:28 -0300
Message-Id: <1350486869-5020-1-git-send-email-lucas.demarchi@profusion.mobi>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

The reply to a DBus.Properties.Set() method call should go through the
same D-Bus connection. Thus remove the DBusConnection parameter from the
following functions:

    - g_dbus_pending_property_success()
    - g_dbus_pending_property_error_valist()
    - g_dbus_pending_property_error()
---
 gdbus/gdbus.h  | 13 +++++--------
 gdbus/object.c | 24 ++++++++++++------------
 2 files changed, 17 insertions(+), 20 deletions(-)

diff --git a/gdbus/gdbus.h b/gdbus/gdbus.h
index 8251947..ba49621 100644
--- a/gdbus/gdbus.h
+++ b/gdbus/gdbus.h
@@ -246,14 +246,11 @@ guint g_dbus_add_signal_watch(DBusConnection *connection,
 gboolean g_dbus_remove_watch(DBusConnection *connection, guint tag);
 void g_dbus_remove_all_watches(DBusConnection *connection);
 
-void g_dbus_pending_property_success(DBusConnection *connection,
-						GDBusPendingPropertySet id);
-void g_dbus_pending_property_error_valist(DBusConnection *connection,
-					GDBusPendingReply id, const char *name,
-					const char *format, va_list args);
-void g_dbus_pending_property_error(DBusConnection *connection,
-					GDBusPendingReply id, const char *name,
-					const char *format, ...);
+void g_dbus_pending_property_success(GDBusPendingPropertySet id);
+void g_dbus_pending_property_error_valist(GDBusPendingReply id,
+			const char *name, const char *format, va_list args);
+void g_dbus_pending_property_error(GDBusPendingReply id, const char *name,
+						const char *format, ...);
 void g_dbus_emit_property_changed(DBusConnection *connection,
 				const char *path, const char *interface,
 				const char *name);
diff --git a/gdbus/object.c b/gdbus/object.c
index 4147361..ec98c2c 100644
--- a/gdbus/object.c
+++ b/gdbus/object.c
@@ -71,6 +71,7 @@ struct security_data {
 };
 
 struct property_data {
+	DBusConnection *conn;
 	GDBusPendingPropertySet id;
 	DBusMessage *message;
 };
@@ -445,8 +446,7 @@ static struct property_data *remove_pending_property_data(
 	return propdata;
 }
 
-void g_dbus_pending_property_success(DBusConnection *connection,
-						GDBusPendingPropertySet id)
+void g_dbus_pending_property_success(GDBusPendingPropertySet id)
 {
 	struct property_data *propdata;
 
@@ -454,14 +454,15 @@ void g_dbus_pending_property_success(DBusConnection *connection,
 	if (propdata == NULL)
 		return;
 
-	g_dbus_send_reply(connection, propdata->message, DBUS_TYPE_INVALID);
+	g_dbus_send_reply(propdata->conn, propdata->message,
+							DBUS_TYPE_INVALID);
 	dbus_message_unref(propdata->message);
 	g_free(propdata);
 }
 
-void g_dbus_pending_property_error_valist(DBusConnection *connection,
-					GDBusPendingReply id, const char *name,
-					const char *format, va_list args)
+void g_dbus_pending_property_error_valist(GDBusPendingReply id,
+					const char *name, const char *format,
+					va_list args)
 {
 	struct property_data *propdata;
 	DBusMessage *reply;
@@ -473,7 +474,7 @@ void g_dbus_pending_property_error_valist(DBusConnection *connection,
 	reply = g_dbus_create_error_valist(propdata->message, name, format,
 									args);
 	if (reply != NULL) {
-		dbus_connection_send(connection, reply, NULL);
+		dbus_connection_send(propdata->conn, reply, NULL);
 		dbus_message_unref(reply);
 	}
 
@@ -481,16 +482,14 @@ void g_dbus_pending_property_error_valist(DBusConnection *connection,
 	g_free(propdata);
 }
 
-void g_dbus_pending_property_error(DBusConnection *connection,
-					GDBusPendingReply id, const char *name,
-					const char *format, ...)
+void g_dbus_pending_property_error(GDBusPendingReply id, const char *name,
+						const char *format, ...)
 {
 	va_list args;
 
 	va_start(args, format);
 
-	g_dbus_pending_property_error_valist(connection, id, name, format,
-									args);
+	g_dbus_pending_property_error_valist(id, name, format, args);
 
 	va_end(args);
 }
@@ -891,6 +890,7 @@ static DBusMessage *properties_set(DBusConnection *connection,
 	propdata = g_new(struct property_data, 1);
 	propdata->id = next_pending_property++;
 	propdata->message = dbus_message_ref(message);
+	propdata->conn = connection;
 	pending_property_set = g_slist_prepend(pending_property_set, propdata);
 
 	property->set(property, &sub, propdata->id, iface->user_data);
-- 
1.7.12.3

