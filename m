Return-Path: <cyrus@holtmann.org>
From: Marcel Holtmann <marcel@holtmann.org>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH] Add support for GDBus security handlers
Date: Sat, 28 Aug 2010 21:29:54 -0400
Message-Id: <1283045394-23129-1-git-send-email-marcel@holtmann.org>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

---
 gdbus/gdbus.h  |   19 +++++++
 gdbus/object.c |  159 ++++++++++++++++++++++++++++++++++++++++++++++++--------
 2 files changed, 156 insertions(+), 22 deletions(-)

diff --git a/gdbus/gdbus.h b/gdbus/gdbus.h
index c3e7252..42d4f73 100644
--- a/gdbus/gdbus.h
+++ b/gdbus/gdbus.h
@@ -55,6 +55,11 @@ typedef void (* GDBusDestroyFunction) (void *user_data);
 typedef DBusMessage * (* GDBusMethodFunction) (DBusConnection *connection,
 					DBusMessage *message, void *user_data);
 
+typedef guint32 GDBusPendingReply;
+
+typedef void (* GDBusSecurityFunction) (DBusConnection *connection,
+			DBusMessage *message, GDBusPendingReply pending);
+
 typedef enum {
 	G_DBUS_METHOD_FLAG_DEPRECATED = (1 << 0),
 	G_DBUS_METHOD_FLAG_NOREPLY    = (1 << 1),
@@ -75,6 +80,7 @@ typedef struct {
 	const char *reply;
 	GDBusMethodFunction function;
 	GDBusMethodFlags flags;
+	unsigned int privilege;
 } GDBusMethodTable;
 
 typedef struct {
@@ -89,6 +95,11 @@ typedef struct {
 	GDBusPropertyFlags flags;
 } GDBusPropertyTable;
 
+typedef struct {
+	unsigned int privilege;
+	GDBusSecurityFunction function;
+} GDBusSecurityTable;
+
 gboolean g_dbus_register_interface(DBusConnection *connection,
 					const char *path, const char *name,
 					const GDBusMethodTable *methods,
@@ -99,6 +110,14 @@ gboolean g_dbus_register_interface(DBusConnection *connection,
 gboolean g_dbus_unregister_interface(DBusConnection *connection,
 					const char *path, const char *name);
 
+gboolean g_dbus_register_security(const GDBusSecurityTable *security);
+gboolean g_dbus_unregister_security(const GDBusSecurityTable *security);
+
+void g_dbus_pending_success(DBusConnection *connection,
+					GDBusPendingReply pending);
+void g_dbus_pending_error(DBusConnection *connection,
+				GDBusPendingReply pending, DBusMessage *error);
+
 DBusMessage *g_dbus_create_error(DBusMessage *message, const char *name,
 						const char *format, ...)
 					__attribute__((format(printf, 3, 4)));
diff --git a/gdbus/object.c b/gdbus/object.c
index ff69641..a367f93 100644
--- a/gdbus/object.c
+++ b/gdbus/object.c
@@ -52,6 +52,13 @@ struct interface_data {
 	GDBusDestroyFunction destroy;
 };
 
+struct security_data {
+	GDBusPendingReply pending;
+	DBusMessage *message;
+	const GDBusMethodTable *method;
+	void *iface_user_data;
+};
+
 static void print_arguments(GString *gstr, const char *sig,
 						const char *direction)
 {
@@ -208,6 +215,114 @@ static DBusMessage *introspect(DBusConnection *connection,
 	return reply;
 }
 
+static DBusHandlerResult process_message(DBusConnection *connection,
+			DBusMessage *message, const GDBusMethodTable *method,
+							void *iface_user_data)
+{
+	DBusMessage *reply;
+
+	reply = method->function(connection, message, iface_user_data);
+
+	if (method->flags & G_DBUS_METHOD_FLAG_NOREPLY) {
+		if (reply != NULL)
+			dbus_message_unref(reply);
+		return DBUS_HANDLER_RESULT_HANDLED;
+	}
+
+	if (method->flags & G_DBUS_METHOD_FLAG_ASYNC) {
+		if (reply == NULL)
+			return DBUS_HANDLER_RESULT_HANDLED;
+	}
+
+	if (reply == NULL)
+		return DBUS_HANDLER_RESULT_NEED_MEMORY;
+
+	dbus_connection_send(connection, reply, NULL);
+	dbus_message_unref(reply);
+
+	return DBUS_HANDLER_RESULT_HANDLED;
+}
+
+static GDBusPendingReply next_pending = 1;
+static GSList *pending_security = NULL;
+
+static const GDBusSecurityTable *security_table = NULL;
+
+void g_dbus_pending_success(DBusConnection *connection,
+					GDBusPendingReply pending)
+{
+	GSList *list;
+
+        for (list = pending_security; list; list = list->next) {
+		struct security_data *secdata = list->data;
+		DBusHandlerResult result;
+
+		if (secdata->pending != pending)
+			continue;
+
+		pending_security = g_slist_remove(pending_security, secdata);
+
+		result = process_message(connection, secdata->message,
+				secdata->method, secdata->iface_user_data);
+
+		dbus_message_unref(secdata->message);
+		g_free(secdata);
+		return;
+        }
+}
+
+void g_dbus_pending_error(DBusConnection *connection,
+				GDBusPendingReply pending, DBusMessage *error)
+{
+	GSList *list;
+
+        for (list = pending_security; list; list = list->next) {
+		struct security_data *secdata = list->data;
+
+		if (secdata->pending != pending)
+			continue;
+
+		pending_security = g_slist_remove(pending_security, secdata);
+
+		if (error != NULL) {
+			dbus_connection_send(connection, error, NULL);
+			dbus_message_unref(error);
+		}
+
+		dbus_message_unref(secdata->message);
+		g_free(secdata);
+		return;
+        }
+}
+
+static gboolean check_privilege(DBusConnection *conn, DBusMessage *msg,
+			const GDBusMethodTable *method, void *iface_user_data)
+{
+	const GDBusSecurityTable *security;
+
+	for (security = security_table; security && security->function &&
+					security->privilege; security++) {
+		struct security_data *secdata;
+
+		if (security->privilege != method->privilege)
+			continue;
+
+		secdata = g_new(struct security_data, 1);
+		secdata->pending = next_pending++;
+		secdata->message = dbus_message_ref(msg);
+		secdata->method = method;
+		secdata->iface_user_data = iface_user_data;
+
+		pending_security = g_slist_prepend(pending_security, secdata);
+
+		security->function(conn, secdata->message, secdata->pending);
+
+		return TRUE;
+	}
+
+	return FALSE;
+}
+
 static void generic_unregister(DBusConnection *connection, void *user_data)
 {
 	struct generic_data *data = user_data;
@@ -249,8 +364,6 @@ static DBusHandlerResult generic_message(DBusConnection *connection,
 
 	for (method = iface->methods; method &&
 			method->name && method->function; method++) {
-		DBusMessage *reply;
-
 		if (dbus_message_is_method_call(message, iface->name,
 							method->name) == FALSE)
 			continue;
@@ -259,26 +372,12 @@ static DBusHandlerResult generic_message(DBusConnection *connection,
 						method->signature) == FALSE)
 			continue;
 
-		reply = method->function(connection, message, iface->user_data);
-
-		if (method->flags & G_DBUS_METHOD_FLAG_NOREPLY) {
-			if (reply != NULL)
-				dbus_message_unref(reply);
+		if (check_privilege(connection, message, method,
+						iface->user_data) == TRUE)
 			return DBUS_HANDLER_RESULT_HANDLED;
-		}
-
-		if (method->flags & G_DBUS_METHOD_FLAG_ASYNC) {
-			if (reply == NULL)
-				return DBUS_HANDLER_RESULT_HANDLED;
-		}
 
-		if (reply == NULL)
-			return DBUS_HANDLER_RESULT_NEED_MEMORY;
-
-		dbus_connection_send(connection, reply, NULL);
-		dbus_message_unref(reply);
-
-		return DBUS_HANDLER_RESULT_HANDLED;
+		return process_message(connection, message, method,
+							iface->user_data);
 	}
 
 	return DBUS_HANDLER_RESULT_NOT_YET_HANDLED;
@@ -362,11 +461,10 @@ static struct generic_data *object_path_ref(DBusConnection *connection,
 	}
 
 	data = g_new0(struct generic_data, 1);
+	data->refcount = 1;
 
 	data->introspect = g_strdup(DBUS_INTROSPECT_1_0_XML_DOCTYPE_DECL_NODE "<node></node>");
 
-	data->refcount = 1;
-
 	if (!dbus_connection_register_object_path(connection, path,
 						&generic_table, data)) {
 		g_free(data->introspect);
@@ -556,6 +654,23 @@ gboolean g_dbus_unregister_interface(DBusConnection *connection,
 	return TRUE;
 }
 
+gboolean g_dbus_register_security(const GDBusSecurityTable *security)
+{
+	if (security_table != NULL)
+		return FALSE;
+
+	security_table = security;
+
+	return TRUE;
+}
+
+gboolean g_dbus_unregister_security(const GDBusSecurityTable *security)
+{
+	security_table = NULL;
+
+	return TRUE;
+}
+
 DBusMessage *g_dbus_create_error_valist(DBusMessage *message, const char *name,
 					const char *format, va_list args)
 {
-- 
1.7.2.2

