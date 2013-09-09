Return-Path: <cyrus@holtmann.org>
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH BlueZ 6/8] gdbus/client: Use g_dbus_add_service_watch to track services
Date: Mon,  9 Sep 2013 17:49:37 +0300
Message-Id: <1378738179-21047-6-git-send-email-luiz.dentz@gmail.com>
In-Reply-To: <1378738179-21047-1-git-send-email-luiz.dentz@gmail.com>
References: <1378738179-21047-1-git-send-email-luiz.dentz@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

From: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>

This make the handling much simpler and avoids duplicates of the same
match rule.
---
 gdbus/client.c | 173 +++++++++++++--------------------------------------------
 1 file changed, 38 insertions(+), 135 deletions(-)

diff --git a/gdbus/client.c b/gdbus/client.c
index 8ebfaad..7a14d7e 100644
--- a/gdbus/client.c
+++ b/gdbus/client.c
@@ -36,8 +36,8 @@ struct GDBusClient {
 	int ref_count;
 	DBusConnection *dbus_conn;
 	char *service_name;
-	char *unique_name;
 	char *base_path;
+	guint watch;
 	GPtrArray *match_rules;
 	DBusPendingCall *pending_call;
 	DBusPendingCall *get_objects_call;
@@ -1051,74 +1051,36 @@ static void get_managed_objects(GDBusClient *client)
 	dbus_message_unref(msg);
 }
 
-static void get_name_owner_reply(DBusPendingCall *call, void *user_data)
+static void service_connect(DBusConnection *conn, void *user_data)
 {
 	GDBusClient *client = user_data;
-	DBusMessage *reply = dbus_pending_call_steal_reply(call);
-	DBusError error;
-	const char *name;
 
 	g_dbus_client_ref(client);
 
-	dbus_error_init(&error);
-
-	if (dbus_set_error_from_message(&error, reply) == TRUE) {
-		dbus_error_free(&error);
-		goto done;
-	}
-
-	if (dbus_message_get_args(reply, NULL, DBUS_TYPE_STRING, &name,
-						DBUS_TYPE_INVALID) == FALSE)
-		goto done;
-
-	if (client->unique_name == NULL) {
-		client->unique_name = g_strdup(name);
-
-		if (client->connect_func)
-			client->connect_func(client->dbus_conn,
-							client->connect_data);
-
-		get_managed_objects(client);
-	}
-
-done:
-	dbus_message_unref(reply);
+	if (client->connect_func)
+		client->connect_func(conn, client->connect_data);
 
-	dbus_pending_call_unref(client->pending_call);
-	client->pending_call = NULL;
+	get_managed_objects(client);
 
 	g_dbus_client_unref(client);
 }
 
-static void get_name_owner(GDBusClient *client, const char *name)
+static void service_disconnect(DBusConnection *conn, void *user_data)
 {
-	DBusMessage *msg;
-
-	msg = dbus_message_new_method_call(DBUS_SERVICE_DBUS, DBUS_PATH_DBUS,
-					DBUS_INTERFACE_DBUS, "GetNameOwner");
-	if (msg == NULL)
-		return;
-
-	dbus_message_append_args(msg, DBUS_TYPE_STRING, &name,
-						DBUS_TYPE_INVALID);
-
-	if (g_dbus_send_message_with_reply(client->dbus_conn, msg,
-					&client->pending_call, -1) == FALSE) {
-		dbus_message_unref(msg);
-		return;
-	}
+	GDBusClient *client = user_data;
 
-	dbus_pending_call_set_notify(client->pending_call,
-					get_name_owner_reply, client, NULL);
+	g_list_free_full(client->proxy_list, proxy_free);
+	client->proxy_list = NULL;
 
-	dbus_message_unref(msg);
+	if (client->disconn_func)
+		client->disconn_func(conn, client->disconn_data);
 }
 
 static DBusHandlerResult message_filter(DBusConnection *connection,
 					DBusMessage *message, void *user_data)
 {
 	GDBusClient *client = user_data;
-	const char *sender;
+	const char *sender, *path, *interface, *member;
 
 	if (dbus_message_get_type(message) != DBUS_MESSAGE_TYPE_SIGNAL)
 		return DBUS_HANDLER_RESULT_NOT_YET_HANDLED;
@@ -1127,98 +1089,41 @@ static DBusHandlerResult message_filter(DBusConnection *connection,
 	if (sender == NULL)
 		return DBUS_HANDLER_RESULT_NOT_YET_HANDLED;
 
-	if (g_str_equal(sender, DBUS_SERVICE_DBUS) == TRUE) {
-		const char *interface, *member;
-		const char *name, *old, *new;
+	path = dbus_message_get_path(message);
+	interface = dbus_message_get_interface(message);
+	member = dbus_message_get_member(message);
 
-		interface = dbus_message_get_interface(message);
-
-		if (g_str_equal(interface, DBUS_INTERFACE_DBUS) == FALSE)
-			return DBUS_HANDLER_RESULT_NOT_YET_HANDLED;
-
-		member = dbus_message_get_member(message);
-
-		if (g_str_equal(member, "NameOwnerChanged") == FALSE)
+	if (g_str_equal(path, "/") == TRUE) {
+		if (g_str_equal(interface, DBUS_INTERFACE_DBUS
+						".ObjectManager") == FALSE)
 			return DBUS_HANDLER_RESULT_NOT_YET_HANDLED;
 
-		if (dbus_message_get_args(message, NULL,
-						DBUS_TYPE_STRING, &name,
-						DBUS_TYPE_STRING, &old,
-						DBUS_TYPE_STRING, &new,
-						DBUS_TYPE_INVALID) == FALSE)
+		if (g_str_equal(member, "InterfacesAdded") == TRUE) {
+			interfaces_added(client, message);
 			return DBUS_HANDLER_RESULT_NOT_YET_HANDLED;
+		}
 
-		if (g_str_equal(name, client->service_name) == FALSE)
+		if (g_str_equal(member, "InterfacesRemoved") == TRUE) {
+			interfaces_removed(client, message);
 			return DBUS_HANDLER_RESULT_NOT_YET_HANDLED;
-
-		if (*new == '\0' && client->unique_name != NULL &&
-				g_str_equal(old, client->unique_name) == TRUE) {
-
-			g_list_free_full(client->proxy_list, proxy_free);
-			client->proxy_list = NULL;
-
-			if (client->disconn_func)
-				client->disconn_func(client->dbus_conn,
-							client->disconn_data);
-
-			g_free(client->unique_name);
-			client->unique_name = NULL;
-		} else if (*old == '\0' && client->unique_name == NULL) {
-			client->unique_name = g_strdup(new);
-
-			if (client->connect_func)
-				client->connect_func(client->dbus_conn,
-							client->connect_data);
-
-			get_managed_objects(client);
 		}
 
 		return DBUS_HANDLER_RESULT_NOT_YET_HANDLED;
 	}
 
-	if (client->unique_name == NULL)
+	if (g_str_has_prefix(path, client->base_path) == FALSE)
 		return DBUS_HANDLER_RESULT_NOT_YET_HANDLED;
 
-	if (g_str_equal(sender, client->unique_name) == TRUE) {
-		const char *path, *interface, *member;
-
-		path = dbus_message_get_path(message);
-		interface = dbus_message_get_interface(message);
-		member = dbus_message_get_member(message);
-
-		if (g_str_equal(path, "/") == TRUE) {
-			if (g_str_equal(interface, DBUS_INTERFACE_DBUS
-						".ObjectManager") == FALSE)
-				return DBUS_HANDLER_RESULT_NOT_YET_HANDLED;
-
-			if (g_str_equal(member, "InterfacesAdded") == TRUE) {
-				interfaces_added(client, message);
-				return DBUS_HANDLER_RESULT_NOT_YET_HANDLED;
-			}
-
-			if (g_str_equal(member, "InterfacesRemoved") == TRUE) {
-				interfaces_removed(client, message);
-				return DBUS_HANDLER_RESULT_NOT_YET_HANDLED;
-			}
+	if (g_str_equal(interface, DBUS_INTERFACE_PROPERTIES) == TRUE) {
+		if (g_str_equal(member, "PropertiesChanged") == TRUE)
+			properties_changed(client, path, message);
 
-			return DBUS_HANDLER_RESULT_NOT_YET_HANDLED;
-		}
-
-		if (g_str_has_prefix(path, client->base_path) == FALSE)
-			return DBUS_HANDLER_RESULT_NOT_YET_HANDLED;
-
-		if (g_str_equal(interface, DBUS_INTERFACE_PROPERTIES) == TRUE) {
-			if (g_str_equal(member, "PropertiesChanged") == TRUE)
-				properties_changed(client, path, message);
-
-			return DBUS_HANDLER_RESULT_NOT_YET_HANDLED;
-		}
-
-		if (client->signal_func)
-			client->signal_func(client->dbus_conn,
-					message, client->signal_data);
+		return DBUS_HANDLER_RESULT_NOT_YET_HANDLED;
 	}
 
+	if (client->signal_func)
+		client->signal_func(connection, message, client->signal_data);
+
 	return DBUS_HANDLER_RESULT_NOT_YET_HANDLED;
 }
 
@@ -1245,16 +1150,13 @@ GDBusClient *g_dbus_client_new(DBusConnection *connection,
 	client->service_name = g_strdup(service);
 	client->base_path = g_strdup(path);
 
-	get_name_owner(client, client->service_name);
-
-	client->match_rules = g_ptr_array_sized_new(4);
+	client->match_rules = g_ptr_array_sized_new(3);
 	g_ptr_array_set_free_func(client->match_rules, g_free);
 
-	g_ptr_array_add(client->match_rules, g_strdup_printf("type='signal',"
-				"sender='%s',path='%s',interface='%s',"
-				"member='NameOwnerChanged',arg0='%s'",
-				DBUS_SERVICE_DBUS, DBUS_PATH_DBUS,
-				DBUS_INTERFACE_DBUS, client->service_name));
+	client->watch = g_dbus_add_service_watch(connection, service,
+						service_connect,
+						service_disconnect,
+						client, NULL);
 	g_ptr_array_add(client->match_rules, g_strdup_printf("type='signal',"
 				"sender='%s',"
 				"path='/',interface='%s.ObjectManager',"
@@ -1322,10 +1224,11 @@ void g_dbus_client_unref(GDBusClient *client)
 	if (client->disconn_func)
 		client->disconn_func(client->dbus_conn, client->disconn_data);
 
+	g_dbus_remove_watch(client->dbus_conn, client->watch);
+
 	dbus_connection_unref(client->dbus_conn);
 
 	g_free(client->service_name);
-	g_free(client->unique_name);
 	g_free(client->base_path);
 
 	g_free(client);
-- 
1.8.3.1

