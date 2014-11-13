Return-Path: <cyrus@holtmann.org>
From: Hannu Mallat <hannu.mallat@jollamobile.com>
To: linux-bluetooth@vger.kernel.org
Cc: Hannu Mallat <hannu.mallat@jollamobile.com>
Subject: [PATCH] gdbus: use caller's bus name in polkit authorization check
Date: Thu, 13 Nov 2014 13:51:39 +0200
Message-Id: <1415879499-920-1-git-send-email-hannu.mallat@jollamobile.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Use the message sender's bus name instead of bluetooth daemon's own
bus name in polkit authorization query.

Added the message as a parameter to GDBusSecurityFunction so that the
sender name (and possibly other message characteristics) can be used
for authorization.
---
 gdbus/gdbus.h  |  1 +
 gdbus/object.c |  8 +++++---
 gdbus/polkit.c | 16 +++++++++++-----
 3 files changed, 17 insertions(+), 8 deletions(-)

diff --git a/gdbus/gdbus.h b/gdbus/gdbus.h
index 551c306..33689cd 100644
--- a/gdbus/gdbus.h
+++ b/gdbus/gdbus.h
@@ -84,6 +84,7 @@ typedef gboolean (*GDBusPropertyExists)(const GDBusPropertyTable *property,
 typedef guint32 GDBusPendingReply;
 
 typedef void (* GDBusSecurityFunction) (DBusConnection *connection,
+						DBusMessage *message,
 						const char *action,
 						gboolean interaction,
 						GDBusPendingReply pending);
diff --git a/gdbus/object.c b/gdbus/object.c
index 4d5a64c..991fec7 100644
--- a/gdbus/object.c
+++ b/gdbus/object.c
@@ -341,6 +341,7 @@ void g_dbus_pending_error(DBusConnection *connection,
 }
 
 int polkit_check_authorization(DBusConnection *conn,
+				DBusMessage *message,
 				const char *action, gboolean interaction,
 				void (*function) (dbus_bool_t authorized,
 							void *user_data),
@@ -365,6 +366,7 @@ static void builtin_security_result(dbus_bool_t authorized, void *user_data)
 }
 
 static void builtin_security_function(DBusConnection *conn,
+						DBusMessage *message,
 						const char *action,
 						gboolean interaction,
 						GDBusPendingReply pending)
@@ -375,7 +377,7 @@ static void builtin_security_function(DBusConnection *conn,
 	data->conn = conn;
 	data->pending = pending;
 
-	if (polkit_check_authorization(conn, action, interaction,
+	if (polkit_check_authorization(conn, message, action, interaction,
 				builtin_security_result, data, 30000) < 0)
 		g_dbus_pending_error(conn, pending, NULL, NULL);
 }
@@ -408,10 +410,10 @@ static gboolean check_privilege(DBusConnection *conn, DBusMessage *msg,
 
 		if (!(security->flags & G_DBUS_SECURITY_FLAG_BUILTIN) &&
 							security->function)
-			security->function(conn, security->action,
+			security->function(conn, msg, security->action,
 						interaction, secdata->pending);
 		else
-			builtin_security_function(conn, security->action,
+			builtin_security_function(conn, msg, security->action,
 						interaction, secdata->pending);
 
 		return TRUE;
diff --git a/gdbus/polkit.c b/gdbus/polkit.c
index 9e95fa3..ea224bd 100644
--- a/gdbus/polkit.c
+++ b/gdbus/polkit.c
@@ -32,6 +32,7 @@
 #include <glib.h>
 
 int polkit_check_authorization(DBusConnection *conn,
+				DBusMessage *message,
 				const char *action, gboolean interaction,
 				void (*function) (dbus_bool_t authorized,
 							void *user_data),
@@ -72,10 +73,9 @@ static void add_empty_string_dict(DBusMessageIter *iter)
 	dbus_message_iter_close_container(iter, &dict);
 }
 
-static void add_arguments(DBusConnection *conn, DBusMessageIter *iter,
+static void add_arguments(const char *caller, DBusMessageIter *iter,
 				const char *action, dbus_uint32_t flags)
 {
-	const char *busname = dbus_bus_get_unique_name(conn);
 	const char *kind = "system-bus-name";
 	const char *cancel = "";
 	DBusMessageIter subject;
@@ -83,7 +83,7 @@ static void add_arguments(DBusConnection *conn, DBusMessageIter *iter,
 	dbus_message_iter_open_container(iter, DBUS_TYPE_STRUCT,
 							NULL, &subject);
 	dbus_message_iter_append_basic(&subject, DBUS_TYPE_STRING, &kind);
-	add_dict_with_string_value(&subject, "name", busname);
+	add_dict_with_string_value(&subject, "name", caller);
 	dbus_message_iter_close_container(iter, &subject);
 
 	dbus_message_iter_append_basic(iter, DBUS_TYPE_STRING, &action);
@@ -143,6 +143,7 @@ done:
 #define AUTHORITY_PATH	"/org/freedesktop/PolicyKit1/Authority"
 
 int polkit_check_authorization(DBusConnection *conn,
+				DBusMessage *message,
 				const char *action, gboolean interaction,
 				void (*function) (dbus_bool_t authorized,
 							void *user_data),
@@ -153,8 +154,13 @@ int polkit_check_authorization(DBusConnection *conn,
 	DBusMessageIter iter;
 	DBusPendingCall *call;
 	dbus_uint32_t flags = 0x00000000;
+	const char *caller;
 
-	if (conn == NULL)
+	if (conn == NULL || message == NULL)
+		return -EINVAL;
+
+	caller = dbus_message_get_sender(message);
+	if (caller == NULL)
 		return -EINVAL;
 
 	data = dbus_malloc0(sizeof(*data));
@@ -175,7 +181,7 @@ int polkit_check_authorization(DBusConnection *conn,
 		action = "org.freedesktop.policykit.exec";
 
 	dbus_message_iter_init_append(msg, &iter);
-	add_arguments(conn, &iter, action, flags);
+	add_arguments(caller, &iter, action, flags);
 
 	if (dbus_connection_send_with_reply(conn, msg,
 						&call, timeout) == FALSE) {
-- 
1.9.1

