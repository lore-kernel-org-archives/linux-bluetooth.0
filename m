Return-Path: <cyrus@holtmann.org>
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH BlueZ 5/5] gdbus/client: Use g_dbus_add_properties_watch to track properties
Date: Wed,  4 Sep 2013 22:04:31 +0300
Message-Id: <1378321471-9043-5-git-send-email-luiz.dentz@gmail.com>
In-Reply-To: <1378321471-9043-1-git-send-email-luiz.dentz@gmail.com>
References: <1378321471-9043-1-git-send-email-luiz.dentz@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

From: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>

This make the handling much simpler and avoids duplicates of the same
match rule.
---
 gdbus/client.c | 135 ++++++++++++++++++++++++---------------------------------
 1 file changed, 56 insertions(+), 79 deletions(-)

diff --git a/gdbus/client.c b/gdbus/client.c
index f1e6946..bd0eadc 100644
--- a/gdbus/client.c
+++ b/gdbus/client.c
@@ -67,7 +67,7 @@ struct GDBusProxy {
 	char *obj_path;
 	char *interface;
 	GHashTable *prop_list;
-	char *match_rule;
+	guint watch;
 	GDBusPropertyFunction prop_func;
 	void *prop_data;
 	GDBusProxyFunction removed_func;
@@ -358,6 +358,52 @@ static GDBusProxy *proxy_lookup(GDBusClient *client, const char *path,
 	return NULL;
 }
 
+static gboolean properties_changed(DBusConnection *conn, DBusMessage *msg,
+							void *user_data)
+{
+	GDBusProxy *proxy = user_data;
+	GDBusClient *client = proxy->client;
+	DBusMessageIter iter, entry;
+	const char *interface;
+
+	if (dbus_message_iter_init(msg, &iter) == FALSE)
+		return TRUE;
+
+	if (dbus_message_iter_get_arg_type(&iter) != DBUS_TYPE_STRING)
+		return TRUE;
+
+	dbus_message_iter_get_basic(&iter, &interface);
+	dbus_message_iter_next(&iter);
+
+	update_properties(proxy, &iter, TRUE);
+
+	dbus_message_iter_next(&iter);
+
+	if (dbus_message_iter_get_arg_type(&iter) != DBUS_TYPE_ARRAY)
+		return TRUE;
+
+	dbus_message_iter_recurse(&iter, &entry);
+
+	while (dbus_message_iter_get_arg_type(&entry) == DBUS_TYPE_STRING) {
+		const char *name;
+
+		dbus_message_iter_get_basic(&entry, &name);
+
+		g_hash_table_remove(proxy->prop_list, name);
+
+		if (proxy->prop_func)
+			proxy->prop_func(proxy, name, NULL, proxy->prop_data);
+
+		if (client->property_changed)
+			client->property_changed(proxy, name, NULL,
+							client->user_data);
+
+		dbus_message_iter_next(&entry);
+	}
+
+	return TRUE;
+}
+
 static GDBusProxy *proxy_new(GDBusClient *client, const char *path,
 						const char *interface)
 {
@@ -373,14 +419,12 @@ static GDBusProxy *proxy_new(GDBusClient *client, const char *path,
 
 	proxy->prop_list = g_hash_table_new_full(g_str_hash, g_str_equal,
 							NULL, prop_entry_free);
-
-	proxy->match_rule = g_strdup_printf("type='signal',"
-				"sender='%s',path='%s',interface='%s',"
-				"member='PropertiesChanged',arg0='%s'",
-				client->service_name, proxy->obj_path,
-				DBUS_INTERFACE_PROPERTIES, proxy->interface);
-
-	modify_match(client->dbus_conn, "AddMatch", proxy->match_rule);
+	proxy->watch = g_dbus_add_properties_watch(client->dbus_conn,
+							client->service_name,
+							proxy->obj_path,
+							proxy->interface,
+							properties_changed,
+							proxy, NULL);
 
 	return g_dbus_proxy_ref(proxy);
 }
@@ -395,11 +439,7 @@ static void proxy_free(gpointer data)
 		if (client->proxy_removed)
 			client->proxy_removed(proxy, client->user_data);
 
-		modify_match(client->dbus_conn, "RemoveMatch",
-							proxy->match_rule);
-
-		g_free(proxy->match_rule);
-		proxy->match_rule = NULL;
+		g_dbus_remove_watch(client->dbus_conn, proxy->watch);
 
 		g_hash_table_remove_all(proxy->prop_list);
 
@@ -800,64 +840,6 @@ static void refresh_properties(GDBusClient *client)
         }
 }
 
-static void properties_changed(GDBusClient *client, const char *path,
-							DBusMessage *msg)
-{
-	GDBusProxy *proxy = NULL;
-	DBusMessageIter iter, entry;
-	const char *interface;
-	GList *list;
-
-	if (dbus_message_iter_init(msg, &iter) == FALSE)
-		return;
-
-	if (dbus_message_iter_get_arg_type(&iter) != DBUS_TYPE_STRING)
-		return;
-
-	dbus_message_iter_get_basic(&iter, &interface);
-	dbus_message_iter_next(&iter);
-
-	for (list = g_list_first(client->proxy_list); list;
-						list = g_list_next(list)) {
-		GDBusProxy *data = list->data;
-
-		if (g_str_equal(data->interface, interface) == TRUE &&
-				g_str_equal(data->obj_path, path) == TRUE) {
-			proxy = data;
-			break;
-		}
-	}
-
-	if (proxy == NULL)
-		return;
-
-	update_properties(proxy, &iter, TRUE);
-
-	dbus_message_iter_next(&iter);
-
-	if (dbus_message_iter_get_arg_type(&iter) != DBUS_TYPE_ARRAY)
-		return;
-
-	dbus_message_iter_recurse(&iter, &entry);
-
-	while (dbus_message_iter_get_arg_type(&entry) == DBUS_TYPE_STRING) {
-		const char *name;
-
-		dbus_message_iter_get_basic(&entry, &name);
-
-		g_hash_table_remove(proxy->prop_list, name);
-
-		if (proxy->prop_func)
-			proxy->prop_func(proxy, name, NULL, proxy->prop_data);
-
-		if (client->property_changed)
-			client->property_changed(proxy, name, NULL,
-							client->user_data);
-
-		dbus_message_iter_next(&entry);
-	}
-}
-
 static void parse_properties(GDBusClient *client, const char *path,
 				const char *interface, DBusMessageIter *iter)
 {
@@ -1095,7 +1077,7 @@ static DBusHandlerResult message_filter(DBusConnection *connection,
 					DBusMessage *message, void *user_data)
 {
 	GDBusClient *client = user_data;
-	const char *sender, *path, *interface, *member;
+	const char *sender, *path, *interface;
 
 	if (dbus_message_get_type(message) != DBUS_MESSAGE_TYPE_SIGNAL)
 		return DBUS_HANDLER_RESULT_NOT_YET_HANDLED;
@@ -1106,17 +1088,12 @@ static DBusHandlerResult message_filter(DBusConnection *connection,
 
 	path = dbus_message_get_path(message);
 	interface = dbus_message_get_interface(message);
-	member = dbus_message_get_member(message);
 
 	if (g_str_has_prefix(path, client->base_path) == FALSE)
 		return DBUS_HANDLER_RESULT_NOT_YET_HANDLED;
 
-	if (g_str_equal(interface, DBUS_INTERFACE_PROPERTIES) == TRUE) {
-		if (g_str_equal(member, "PropertiesChanged") == TRUE)
-			properties_changed(client, path, message);
-
+	if (g_str_equal(interface, DBUS_INTERFACE_PROPERTIES) == TRUE)
 		return DBUS_HANDLER_RESULT_NOT_YET_HANDLED;
-	}
 
 	if (client->signal_func)
 		client->signal_func(connection, message, client->signal_data);
-- 
1.8.3.1

