Return-Path: <cyrus@holtmann.org>
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH BlueZ 3/8] gdbus: Avoid calling dbus_connection_send*
Date: Mon, 19 Aug 2013 17:32:54 +0300
Message-Id: <1376922779-11802-5-git-send-email-luiz.dentz@gmail.com>
In-Reply-To: <1376922779-11802-1-git-send-email-luiz.dentz@gmail.com>
References: <1376922779-11802-1-git-send-email-luiz.dentz@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

From: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>

dbus_connection_send* should not be called directly except by
g_dbus_send_message.
---
 gdbus/client.c | 14 ++++-----
 gdbus/object.c | 92 ++++++++++++++++++++++------------------------------------
 2 files changed, 42 insertions(+), 64 deletions(-)

diff --git a/gdbus/client.c b/gdbus/client.c
index d80e252..8ebfaad 100644
--- a/gdbus/client.c
+++ b/gdbus/client.c
@@ -100,7 +100,7 @@ static gboolean modify_match(DBusConnection *conn, const char *member,
 	dbus_message_append_args(msg, DBUS_TYPE_STRING, &rule,
 						DBUS_TYPE_INVALID);
 
-	if (dbus_connection_send_with_reply(conn, msg, &call, -1) == FALSE) {
+	if (g_dbus_send_message_with_reply(conn, msg, &call, -1) == FALSE) {
 		dbus_message_unref(msg);
 		return FALSE;
 	}
@@ -319,7 +319,7 @@ static void get_all_properties(GDBusProxy *proxy)
 	dbus_message_append_args(msg, DBUS_TYPE_STRING, &proxy->interface,
 							DBUS_TYPE_INVALID);
 
-	if (dbus_connection_send_with_reply(client->dbus_conn, msg,
+	if (g_dbus_send_message_with_reply(client->dbus_conn, msg,
 							&call, -1) == FALSE) {
 		dbus_message_unref(msg);
 		return;
@@ -575,7 +575,7 @@ gboolean g_dbus_proxy_refresh_property(GDBusProxy *proxy, const char *name)
 							&proxy->interface);
 	dbus_message_iter_append_basic(&iter, DBUS_TYPE_STRING, &name);
 
-	if (dbus_connection_send_with_reply(client->dbus_conn, msg,
+	if (g_dbus_send_message_with_reply(client->dbus_conn, msg,
 							&call, -1) == FALSE) {
 		dbus_message_unref(msg);
 		refresh_property_free(data);
@@ -668,7 +668,7 @@ gboolean g_dbus_proxy_set_property_basic(GDBusProxy *proxy,
 	dbus_message_iter_append_basic(&variant, type, value);
 	dbus_message_iter_close_container(&iter, &variant);
 
-	if (dbus_connection_send_with_reply(client->dbus_conn, msg,
+	if (g_dbus_send_message_with_reply(client->dbus_conn, msg,
 							&call, -1) == FALSE) {
 		dbus_message_unref(msg);
 		g_free(data);
@@ -742,7 +742,7 @@ gboolean g_dbus_proxy_method_call(GDBusProxy *proxy, const char *method,
 		setup(&iter, data->user_data);
 	}
 
-	if (dbus_connection_send_with_reply(client->dbus_conn, msg,
+	if (g_dbus_send_message_with_reply(client->dbus_conn, msg,
 					&call, METHOD_CALL_TIMEOUT) == FALSE) {
 		dbus_message_unref(msg);
 		g_free(data);
@@ -1038,7 +1038,7 @@ static void get_managed_objects(GDBusClient *client)
 
 	dbus_message_append_args(msg, DBUS_TYPE_INVALID);
 
-	if (dbus_connection_send_with_reply(client->dbus_conn, msg,
+	if (g_dbus_send_message_with_reply(client->dbus_conn, msg,
 				&client->get_objects_call, -1) == FALSE) {
 		dbus_message_unref(msg);
 		return;
@@ -1102,7 +1102,7 @@ static void get_name_owner(GDBusClient *client, const char *name)
 	dbus_message_append_args(msg, DBUS_TYPE_STRING, &name,
 						DBUS_TYPE_INVALID);
 
-	if (dbus_connection_send_with_reply(client->dbus_conn, msg,
+	if (g_dbus_send_message_with_reply(client->dbus_conn, msg,
 					&client->pending_call, -1) == FALSE) {
 		dbus_message_unref(msg);
 		return;
diff --git a/gdbus/object.c b/gdbus/object.c
index 5d43036..92f57a0 100644
--- a/gdbus/object.c
+++ b/gdbus/object.c
@@ -271,8 +271,7 @@ static DBusHandlerResult process_message(DBusConnection *connection,
 	if (reply == NULL)
 		return DBUS_HANDLER_RESULT_NEED_MEMORY;
 
-	dbus_connection_send(connection, reply, NULL);
-	dbus_message_unref(reply);
+	g_dbus_send_message(connection, reply);
 
 	return DBUS_HANDLER_RESULT_HANDLED;
 }
@@ -312,19 +311,14 @@ void g_dbus_pending_error_valist(DBusConnection *connection,
 
 	for (list = pending_security; list; list = list->next) {
 		struct security_data *secdata = list->data;
-		DBusMessage *reply;
 
 		if (secdata->pending != pending)
 			continue;
 
 		pending_security = g_slist_remove(pending_security, secdata);
 
-		reply = g_dbus_create_error_valist(secdata->message,
+		g_dbus_send_error_valist(connection, secdata->message,
 							name, format, args);
-		if (reply != NULL) {
-			dbus_connection_send(connection, reply, NULL);
-			dbus_message_unref(reply);
-		}
 
 		dbus_message_unref(secdata->message);
 		g_free(secdata);
@@ -469,18 +463,13 @@ void g_dbus_pending_property_error_valist(GDBusPendingReply id,
 					va_list args)
 {
 	struct property_data *propdata;
-	DBusMessage *reply;
 
 	propdata = remove_pending_property_data(id);
 	if (propdata == NULL)
 		return;
 
-	reply = g_dbus_create_error_valist(propdata->message, name, format,
-									args);
-	if (reply != NULL) {
-		dbus_connection_send(propdata->conn, reply, NULL);
-		dbus_message_unref(reply);
-	}
+	g_dbus_send_error_valist(propdata->conn, propdata->message, name,
+								format, args);
 
 	dbus_message_unref(propdata->message);
 	g_free(propdata);
@@ -1319,45 +1308,6 @@ static gboolean check_signal(DBusConnection *conn, const char *path,
 	return FALSE;
 }
 
-static dbus_bool_t emit_signal_valist(DBusConnection *conn,
-						const char *path,
-						const char *interface,
-						const char *name,
-						int first,
-						va_list var_args)
-{
-	DBusMessage *signal;
-	dbus_bool_t ret;
-	const GDBusArgInfo *args;
-
-	if (!check_signal(conn, path, interface, name, &args))
-		return FALSE;
-
-	signal = dbus_message_new_signal(path, interface, name);
-	if (signal == NULL) {
-		error("Unable to allocate new %s.%s signal", interface,  name);
-		return FALSE;
-	}
-
-	ret = dbus_message_append_args_valist(signal, first, var_args);
-	if (!ret)
-		goto fail;
-
-	if (g_dbus_args_have_signature(args, signal) == FALSE) {
-		error("%s.%s: got unexpected signature '%s'", interface, name,
-					dbus_message_get_signature(signal));
-		ret = FALSE;
-		goto fail;
-	}
-
-	ret = dbus_connection_send(conn, signal, NULL);
-
-fail:
-	dbus_message_unref(signal);
-
-	return ret;
-}
-
 gboolean g_dbus_register_interface(DBusConnection *connection,
 					const char *path, const char *name,
 					const GDBusMethodTable *methods,
@@ -1634,7 +1584,7 @@ gboolean g_dbus_emit_signal(DBusConnection *connection,
 
 	va_start(args, type);
 
-	result = emit_signal_valist(connection, path, interface,
+	result = g_dbus_emit_signal_valist(connection, path, interface,
 							name, type, args);
 
 	va_end(args);
@@ -1646,8 +1596,36 @@ gboolean g_dbus_emit_signal_valist(DBusConnection *connection,
 				const char *path, const char *interface,
 				const char *name, int type, va_list args)
 {
-	return emit_signal_valist(connection, path, interface,
-							name, type, args);
+	DBusMessage *signal;
+	dbus_bool_t ret;
+	const GDBusArgInfo *args_info;
+
+	if (!check_signal(connection, path, interface, name, &args_info))
+		return FALSE;
+
+	signal = dbus_message_new_signal(path, interface, name);
+	if (signal == NULL) {
+		error("Unable to allocate new %s.%s signal", interface,  name);
+		return FALSE;
+	}
+
+	ret = dbus_message_append_args_valist(signal, type, args);
+	if (!ret)
+		goto fail;
+
+	if (g_dbus_args_have_signature(args_info, signal) == FALSE) {
+		error("%s.%s: got unexpected signature '%s'", interface, name,
+					dbus_message_get_signature(signal));
+		ret = FALSE;
+		goto fail;
+	}
+
+	return g_dbus_send_message(connection, signal);
+
+fail:
+	dbus_message_unref(signal);
+
+	return ret;
 }
 
 static void process_properties_from_interface(struct generic_data *data,
-- 
1.8.3.1

