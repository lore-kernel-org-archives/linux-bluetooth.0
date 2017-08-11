Return-Path: <linux-bluetooth-owner@vger.kernel.org>
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH BlueZ] gdbus: Fix calling GetAll while GetManagedObject is pending
Date: Fri, 11 Aug 2017 15:58:15 +0300
Message-Id: <20170811125815.964-1-luiz.dentz@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

From: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>

If proxies are created while the client is not ready put them into a
pending list so only if they are not found in GetManagedObject reply
call GetAll.
---
 gdbus/client.c | 100 +++++++++++++++++++++++++++++++++++++--------------------
 1 file changed, 65 insertions(+), 35 deletions(-)

diff --git a/gdbus/client.c b/gdbus/client.c
index a011e19c3..7f3daa246 100644
--- a/gdbus/client.c
+++ b/gdbus/client.c
@@ -63,6 +63,7 @@ struct GDBusClient {
 	GDBusPropertyFunction property_changed;
 	void *user_data;
 	GList *proxy_list;
+	GList *pending_list;
 };
 
 struct GDBusProxy {
@@ -76,6 +77,7 @@ struct GDBusProxy {
 	void *prop_data;
 	GDBusProxyFunction removed_func;
 	void *removed_data;
+	DBusPendingCall *get_all_call;
 };
 
 struct prop_entry {
@@ -278,6 +280,18 @@ static void update_properties(GDBusProxy *proxy, DBusMessageIter *iter,
 	}
 }
 
+static void proxy_added(GDBusClient *client, GDBusProxy *proxy)
+{
+	if (g_list_find(client->proxy_list, proxy) == NULL) {
+		if (client->proxy_added)
+			client->proxy_added(proxy, client->user_data);
+
+		client->proxy_list = g_list_append(client->proxy_list, proxy);
+		client->pending_list = g_list_remove(client->pending_list,
+								proxy);
+	}
+}
+
 static void get_all_properties_reply(DBusPendingCall *call, void *user_data)
 {
 	GDBusProxy *proxy = user_data;
@@ -286,6 +300,8 @@ static void get_all_properties_reply(DBusPendingCall *call, void *user_data)
 	DBusMessageIter iter;
 	DBusError error;
 
+	g_dbus_client_ref(client);
+
 	dbus_error_init(&error);
 
 	if (dbus_set_error_from_message(&error, reply) == TRUE) {
@@ -298,15 +314,13 @@ static void get_all_properties_reply(DBusPendingCall *call, void *user_data)
 	update_properties(proxy, &iter, FALSE);
 
 done:
-	if (g_list_find(client->proxy_list, proxy) == NULL) {
-		if (client->proxy_added)
-			client->proxy_added(proxy, client->user_data);
-
-		client->proxy_list = g_list_append(client->proxy_list, proxy);
-	}
+	proxy_added(client, proxy);
 
 	dbus_message_unref(reply);
 
+	dbus_pending_call_unref(proxy->get_all_call);
+	proxy->get_all_call = NULL;
+
 	g_dbus_client_unref(client);
 }
 
@@ -315,7 +329,9 @@ static void get_all_properties(GDBusProxy *proxy)
 	GDBusClient *client = proxy->client;
 	const char *service_name = client->service_name;
 	DBusMessage *msg;
-	DBusPendingCall *call;
+
+	if (proxy->get_all_call)
+		return;
 
 	msg = dbus_message_new_method_call(service_name, proxy->obj_path,
 					DBUS_INTERFACE_PROPERTIES, "GetAll");
@@ -326,28 +342,24 @@ static void get_all_properties(GDBusProxy *proxy)
 							DBUS_TYPE_INVALID);
 
 	if (g_dbus_send_message_with_reply(client->dbus_conn, msg,
-							&call, -1) == FALSE) {
+					&proxy->get_all_call, -1) == FALSE) {
 		dbus_message_unref(msg);
 		return;
 	}
 
-	g_dbus_client_ref(client);
-
-	dbus_pending_call_set_notify(call, get_all_properties_reply,
-							proxy, NULL);
-	dbus_pending_call_unref(call);
+	dbus_pending_call_set_notify(proxy->get_all_call,
+					get_all_properties_reply, proxy, NULL);
 
 	dbus_message_unref(msg);
 }
 
-static GDBusProxy *proxy_lookup(GDBusClient *client, const char *path,
+static GDBusProxy *proxy_lookup(GList *list, const char *path,
 						const char *interface)
 {
-	GList *list;
+	GList *l;
 
-	for (list = g_list_first(client->proxy_list); list;
-						list = g_list_next(list)) {
-		GDBusProxy *proxy = list->data;
+	for (l = g_list_first(list); l; l = g_list_next(l)) {
+		GDBusProxy *proxy = l->data;
 
 		if (g_str_equal(proxy->interface, interface) == TRUE &&
 				g_str_equal(proxy->obj_path, path) == TRUE)
@@ -478,7 +490,11 @@ GDBusProxy *g_dbus_proxy_new(GDBusClient *client, const char *path,
 	if (client == NULL)
 		return NULL;
 
-	proxy = proxy_lookup(client, path, interface);
+	proxy = proxy_lookup(client->proxy_list, path, interface);
+	if (proxy)
+		return g_dbus_proxy_ref(proxy);
+
+	proxy = proxy_lookup(client->pending_list, path, interface);
 	if (proxy)
 		return g_dbus_proxy_ref(proxy);
 
@@ -486,7 +502,10 @@ GDBusProxy *g_dbus_proxy_new(GDBusClient *client, const char *path,
 	if (proxy == NULL)
 		return NULL;
 
-	get_all_properties(proxy);
+	client->pending_list = g_list_append(client->pending_list, proxy);
+
+	if (client->connected && !client->get_objects_call)
+		get_all_properties(proxy);
 
 	return g_dbus_proxy_ref(proxy);
 }
@@ -509,6 +528,11 @@ void g_dbus_proxy_unref(GDBusProxy *proxy)
 	if (__sync_sub_and_fetch(&proxy->ref_count, 1) > 0)
 		return;
 
+	if (proxy->get_all_call != NULL) {
+		dbus_pending_call_cancel(proxy->get_all_call);
+		dbus_pending_call_unref(proxy->get_all_call);
+	}
+
 	g_hash_table_destroy(proxy->prop_list);
 
 	g_free(proxy->obj_path);
@@ -916,12 +940,11 @@ gboolean g_dbus_proxy_set_removed_watch(GDBusProxy *proxy,
 	return TRUE;
 }
 
-static void refresh_properties(GDBusClient *client)
+static void refresh_properties(GList *list)
 {
-	GList *list;
+	GList *l;
 
-	for (list = g_list_first(client->proxy_list); list;
-						list = g_list_next(list)) {
+	for (l = g_list_first(list); l; l = g_list_next(l)) {
 		GDBusProxy *proxy = list->data;
 
 		get_all_properties(proxy);
@@ -939,22 +962,22 @@ static void parse_properties(GDBusClient *client, const char *path,
 	if (g_str_equal(interface, DBUS_INTERFACE_PROPERTIES) == TRUE)
 		return;
 
-	proxy = proxy_lookup(client, path, interface);
+	proxy = proxy_lookup(client->proxy_list, path, interface);
 	if (proxy) {
 		update_properties(proxy, iter, FALSE);
 		return;
 	}
 
-	proxy = proxy_new(client, path, interface);
-	if (proxy == NULL)
-		return;
+	proxy = proxy_lookup(client->pending_list, path, interface);
+	if (!proxy) {
+		proxy = proxy_new(client, path, interface);
+		if (proxy == NULL)
+			return;
+	}
 
 	update_properties(proxy, iter, FALSE);
 
-	if (client->proxy_added)
-		client->proxy_added(proxy, client->user_data);
-
-	client->proxy_list = g_list_append(client->proxy_list, proxy);
+	proxy_added(client, proxy);
 }
 
 static void parse_interfaces(GDBusClient *client, const char *path,
@@ -1103,6 +1126,8 @@ done:
 	dbus_pending_call_unref(client->get_objects_call);
 	client->get_objects_call = NULL;
 
+	refresh_properties(client->pending_list);
+
 	g_dbus_client_unref(client);
 }
 
@@ -1115,7 +1140,8 @@ static void get_managed_objects(GDBusClient *client)
 
 	if ((!client->proxy_added && !client->proxy_removed) ||
 							!client->root_path) {
-		refresh_properties(client);
+		refresh_properties(client->proxy_list);
+		refresh_properties(client->pending_list);
 		return;
 	}
 
@@ -1152,11 +1178,11 @@ static void service_connect(DBusConnection *conn, void *user_data)
 
 	client->connected = TRUE;
 
+	get_managed_objects(client);
+
 	if (client->connect_func)
 		client->connect_func(conn, client->connect_data);
 
-	get_managed_objects(client);
-
 	g_dbus_client_unref(client);
 }
 
@@ -1169,6 +1195,9 @@ static void service_disconnect(DBusConnection *conn, void *user_data)
 	g_list_free_full(client->proxy_list, proxy_free);
 	client->proxy_list = NULL;
 
+	g_list_free_full(client->pending_list, proxy_free);
+	client->pending_list = NULL;
+
 	if (client->disconn_func)
 		client->disconn_func(conn, client->disconn_data);
 }
@@ -1310,6 +1339,7 @@ void g_dbus_client_unref(GDBusClient *client)
 						message_filter, client);
 
 	g_list_free_full(client->proxy_list, proxy_free);
+	g_list_free_full(client->pending_list, proxy_free);
 
 	/*
 	 * Don't call disconn_func twice if disconnection
-- 
2.13.4

