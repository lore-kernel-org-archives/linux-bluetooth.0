Return-Path: <cyrus@holtmann.org>
From: Arman Uguray <armansito@chromium.org>
To: linux-bluetooth@vger.kernel.org
Cc: Arman Uguray <armansito@chromium.org>
Subject: [PATCH BlueZ v2 02/16] gdbus/client: Allow specifying ObjectManager path
Date: Fri, 27 Feb 2015 00:16:25 -0800
Message-Id: <1425024999-29789-3-git-send-email-armansito@chromium.org>
In-Reply-To: <1425024999-29789-1-git-send-email-armansito@chromium.org>
References: <1425024999-29789-1-git-send-email-armansito@chromium.org>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

GDBusClient currently hard-codes "/" as the remote ObjectManager path.
This is generally incorrect, as an application can choose to expose an
ObjectManager at any well-known path. This patch fixes this by allowing
the user to pass in the ObjectManager path by introducing a new
conctructor "g_dbus_client_new_full".
---
 gdbus/client.c | 24 ++++++++++++++++++------
 gdbus/gdbus.h  |  4 ++++
 2 files changed, 22 insertions(+), 6 deletions(-)

diff --git a/gdbus/client.c b/gdbus/client.c
index cd5c767..91946af 100644
--- a/gdbus/client.c
+++ b/gdbus/client.c
@@ -42,6 +42,7 @@ struct GDBusClient {
 	DBusConnection *dbus_conn;
 	char *service_name;
 	char *base_path;
+	char *om_path;
 	guint watch;
 	guint added_watch;
 	guint removed_watch;
@@ -1118,9 +1119,10 @@ static void get_managed_objects(GDBusClient *client)
 	if (client->get_objects_call != NULL)
 		return;
 
-	msg = dbus_message_new_method_call(client->service_name, "/",
-					DBUS_INTERFACE_DBUS ".ObjectManager",
-							"GetManagedObjects");
+	msg = dbus_message_new_method_call(client->service_name,
+						client->om_path,
+						DBUS_INTERFACE_OBJECT_MANAGER,
+						"GetManagedObjects");
 	if (msg == NULL)
 		return;
 
@@ -1199,10 +1201,18 @@ static DBusHandlerResult message_filter(DBusConnection *connection,
 GDBusClient *g_dbus_client_new(DBusConnection *connection,
 					const char *service, const char *path)
 {
+	return g_dbus_client_new_full(connection, service, path, "/");
+}
+
+GDBusClient *g_dbus_client_new_full(DBusConnection *connection,
+							const char *service,
+							const char *path,
+							const char *om_path)
+{
 	GDBusClient *client;
 	unsigned int i;
 
-	if (connection == NULL)
+	if (!connection || !service || !om_path)
 		return NULL;
 
 	client = g_try_new0(GDBusClient, 1);
@@ -1218,6 +1228,7 @@ GDBusClient *g_dbus_client_new(DBusConnection *connection,
 	client->dbus_conn = dbus_connection_ref(connection);
 	client->service_name = g_strdup(service);
 	client->base_path = g_strdup(path);
+	client->om_path = g_strdup(om_path);
 	client->connected = FALSE;
 
 	client->match_rules = g_ptr_array_sized_new(1);
@@ -1228,13 +1239,13 @@ GDBusClient *g_dbus_client_new(DBusConnection *connection,
 						service_disconnect,
 						client, NULL);
 	client->added_watch = g_dbus_add_signal_watch(connection, service,
-						"/",
+						client->om_path,
 						DBUS_INTERFACE_OBJECT_MANAGER,
 						"InterfacesAdded",
 						interfaces_added,
 						client, NULL);
 	client->removed_watch = g_dbus_add_signal_watch(connection, service,
-						"/",
+						client->om_path,
 						DBUS_INTERFACE_OBJECT_MANAGER,
 						"InterfacesRemoved",
 						interfaces_removed,
@@ -1308,6 +1319,7 @@ void g_dbus_client_unref(GDBusClient *client)
 
 	g_free(client->service_name);
 	g_free(client->base_path);
+	g_free(client->om_path);
 
 	g_free(client);
 }
diff --git a/gdbus/gdbus.h b/gdbus/gdbus.h
index 551c306..59499cb 100644
--- a/gdbus/gdbus.h
+++ b/gdbus/gdbus.h
@@ -355,6 +355,10 @@ gboolean g_dbus_proxy_set_removed_watch(GDBusProxy *proxy,
 
 GDBusClient *g_dbus_client_new(DBusConnection *connection,
 					const char *service, const char *path);
+GDBusClient *g_dbus_client_new_full(DBusConnection *connection,
+							const char *service,
+							const char *path,
+							const char *om_path);
 
 GDBusClient *g_dbus_client_ref(GDBusClient *client);
 void g_dbus_client_unref(GDBusClient *client);
-- 
2.2.0.rc0.207.ga3a616c

