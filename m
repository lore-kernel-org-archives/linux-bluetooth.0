Return-Path: <cyrus@holtmann.org>
From: Marcel Holtmann <marcel@holtmann.org>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH] Use simpler error callbacks for GDBus security hooks
Date: Sun, 29 Aug 2010 06:32:26 -0400
Message-Id: <1283077946-27472-1-git-send-email-marcel@holtmann.org>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

---
 gdbus/gdbus.h  |    9 +++++++--
 gdbus/object.c |   29 +++++++++++++++++++++++------
 2 files changed, 30 insertions(+), 8 deletions(-)

diff --git a/gdbus/gdbus.h b/gdbus/gdbus.h
index 42d4f73..553918c 100644
--- a/gdbus/gdbus.h
+++ b/gdbus/gdbus.h
@@ -58,7 +58,7 @@ typedef DBusMessage * (* GDBusMethodFunction) (DBusConnection *connection,
 typedef guint32 GDBusPendingReply;
 
 typedef void (* GDBusSecurityFunction) (DBusConnection *connection,
-			DBusMessage *message, GDBusPendingReply pending);
+						GDBusPendingReply pending);
 
 typedef enum {
 	G_DBUS_METHOD_FLAG_DEPRECATED = (1 << 0),
@@ -116,7 +116,12 @@ gboolean g_dbus_unregister_security(const GDBusSecurityTable *security);
 void g_dbus_pending_success(DBusConnection *connection,
 					GDBusPendingReply pending);
 void g_dbus_pending_error(DBusConnection *connection,
-				GDBusPendingReply pending, DBusMessage *error);
+				GDBusPendingReply pending,
+				const char *name, const char *format, ...)
+					__attribute__((format(printf, 4, 5)));
+void g_dbus_pending_error_valist(DBusConnection *connection,
+				GDBusPendingReply pending, const char *name,
+					const char *format, va_list args);
 
 DBusMessage *g_dbus_create_error(DBusMessage *message, const char *name,
 						const char *format, ...)
diff --git a/gdbus/object.c b/gdbus/object.c
index a367f93..48530f2 100644
--- a/gdbus/object.c
+++ b/gdbus/object.c
@@ -271,22 +271,26 @@ void g_dbus_pending_success(DBusConnection *connection,
         }
 }
 
-void g_dbus_pending_error(DBusConnection *connection,
-				GDBusPendingReply pending, DBusMessage *error)
+void g_dbus_pending_error_valist(DBusConnection *connection,
+				GDBusPendingReply pending, const char *name,
+					const char *format, va_list args)
 {
 	GSList *list;
 
         for (list = pending_security; list; list = list->next) {
 		struct security_data *secdata = list->data;
+		DBusMessage *reply;
 
 		if (secdata->pending != pending)
 			continue;
 
 		pending_security = g_slist_remove(pending_security, secdata);
 
-		if (error != NULL) {
-			dbus_connection_send(connection, error, NULL);
-			dbus_message_unref(error);
+		reply = g_dbus_create_error_valist(secdata->message,
+							name, format, args);
+		if (reply != NULL) {
+			dbus_connection_send(connection, reply, NULL);
+			dbus_message_unref(reply);
 		}
 
 		dbus_message_unref(secdata->message);
@@ -295,6 +299,19 @@ void g_dbus_pending_error(DBusConnection *connection,
         }
 }
 
+void g_dbus_pending_error(DBusConnection *connection,
+				GDBusPendingReply pending,
+				const char *name, const char *format, ...)
+{
+	va_list args;
+
+	va_start(args, format);
+
+	g_dbus_pending_error_valist(connection, pending, name, format, args);
+
+	va_end(args);
+}
+
 static gboolean check_privilege(DBusConnection *conn, DBusMessage *msg,
 			const GDBusMethodTable *method, void *iface_user_data)
 {
@@ -315,7 +332,7 @@ static gboolean check_privilege(DBusConnection *conn, DBusMessage *msg,
 
 		pending_security = g_slist_prepend(pending_security, secdata);
 
-		security->function(conn, secdata->message, secdata->pending);
+		security->function(conn, secdata->pending);
 
 		return TRUE;
 	}
-- 
1.7.2.2

