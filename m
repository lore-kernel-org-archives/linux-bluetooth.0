Return-Path: <cyrus@holtmann.org>
From: Arman Uguray <armansito@chromium.org>
To: linux-bluetooth@vger.kernel.org
Cc: Arman Uguray <armansito@chromium.org>
Subject: [PATCH BlueZ v1 03/17] gdbus/client: Allow specifying ObjectManager path
Date: Wed, 25 Feb 2015 21:13:16 -0800
Message-Id: <1424927610-26226-4-git-send-email-armansito@chromium.org>
In-Reply-To: <1424927610-26226-1-git-send-email-armansito@chromium.org>
References: <1424927610-26226-1-git-send-email-armansito@chromium.org>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

GDBusClient currently hard-codes "/" as the remote ObjectManager path.
This is generally incorrect, as an application can choose to expose an
ObjectManager at any well-known path. This patch fixes this by allowing
the user to pass in the ObjectManager path to g_dbus_client_new.
---
 client/main.c            |  2 +-
 gdbus/client.c           | 23 ++++++++++++++++-------
 gdbus/gdbus.h            |  5 +++--
 plugins/hostname.c       |  2 +-
 profiles/iap/main.c      |  2 +-
 tools/bluetooth-player.c |  2 +-
 tools/gap-tester.c       |  3 ++-
 tools/gatt-service.c     |  2 +-
 tools/mpris-proxy.c      |  2 +-
 tools/obexctl.c          |  2 +-
 unit/test-gdbus-client.c | 39 ++++++++++++++++++++++++++-------------
 11 files changed, 54 insertions(+), 30 deletions(-)

diff --git a/client/main.c b/client/main.c
index 809c372..9fd3d54 100644
--- a/client/main.c
+++ b/client/main.c
@@ -1769,7 +1769,7 @@ int main(int argc, char *argv[])
 	rl_redisplay();
 
 	signal = setup_signalfd();
-	client = g_dbus_client_new(dbus_conn, "org.bluez", "/org/bluez");
+	client = g_dbus_client_new(dbus_conn, "org.bluez", "/org/bluez", NULL);
 
 	g_dbus_client_set_connect_watch(client, connect_handler, NULL);
 	g_dbus_client_set_disconnect_watch(client, disconnect_handler, NULL);
diff --git a/gdbus/client.c b/gdbus/client.c
index cd5c767..1381e37 100644
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
 
@@ -1196,8 +1198,9 @@ static DBusHandlerResult message_filter(DBusConnection *connection,
 	return DBUS_HANDLER_RESULT_NOT_YET_HANDLED;
 }
 
-GDBusClient *g_dbus_client_new(DBusConnection *connection,
-					const char *service, const char *path)
+GDBusClient *g_dbus_client_new(DBusConnection *connection, const char *service,
+							const char *path,
+							const char *om_path)
 {
 	GDBusClient *client;
 	unsigned int i;
@@ -1215,9 +1218,14 @@ GDBusClient *g_dbus_client_new(DBusConnection *connection,
 		return NULL;
 	}
 
+	/* If no ObjectManager path is given, then default to "/" */
+	if (!om_path)
+		om_path = "/";
+
 	client->dbus_conn = dbus_connection_ref(connection);
 	client->service_name = g_strdup(service);
 	client->base_path = g_strdup(path);
+	client->om_path = g_strdup(om_path);
 	client->connected = FALSE;
 
 	client->match_rules = g_ptr_array_sized_new(1);
@@ -1228,13 +1236,13 @@ GDBusClient *g_dbus_client_new(DBusConnection *connection,
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
@@ -1308,6 +1316,7 @@ void g_dbus_client_unref(GDBusClient *client)
 
 	g_free(client->service_name);
 	g_free(client->base_path);
+	g_free(client->om_path);
 
 	g_free(client);
 }
diff --git a/gdbus/gdbus.h b/gdbus/gdbus.h
index 551c306..1d6d55b 100644
--- a/gdbus/gdbus.h
+++ b/gdbus/gdbus.h
@@ -353,8 +353,9 @@ gboolean g_dbus_proxy_set_property_watch(GDBusProxy *proxy,
 gboolean g_dbus_proxy_set_removed_watch(GDBusProxy *proxy,
 			GDBusProxyFunction destroy, void *user_data);
 
-GDBusClient *g_dbus_client_new(DBusConnection *connection,
-					const char *service, const char *path);
+GDBusClient *g_dbus_client_new(DBusConnection *connection, const char *service,
+							const char *path,
+							const char *om_path);
 
 GDBusClient *g_dbus_client_ref(GDBusClient *client);
 void g_dbus_client_unref(GDBusClient *client);
diff --git a/plugins/hostname.c b/plugins/hostname.c
index d4d72d3..e1f6cf5 100644
--- a/plugins/hostname.c
+++ b/plugins/hostname.c
@@ -275,7 +275,7 @@ static int hostname_init(void)
 	read_dmi_fallback();
 
 	hostname_client = g_dbus_client_new(conn, "org.freedesktop.hostname1",
-						"/org/freedesktop/hostname1");
+					"/org/freedesktop/hostname1", NULL);
 	if (!hostname_client)
 		return -EIO;
 
diff --git a/profiles/iap/main.c b/profiles/iap/main.c
index 0e8f43f..2b7a9e7 100644
--- a/profiles/iap/main.c
+++ b/profiles/iap/main.c
@@ -447,7 +447,7 @@ int main(int argc, char *argv[])
 
 	signal = setup_signalfd();
 
-	client = g_dbus_client_new(dbus_conn, "org.bluez", "/org/bluez");
+	client = g_dbus_client_new(dbus_conn, "org.bluez", "/org/bluez", NULL);
 
 	g_dbus_client_set_connect_watch(client, connect_handler, client);
 	g_dbus_client_set_disconnect_watch(client, disconnect_handler, NULL);
diff --git a/tools/bluetooth-player.c b/tools/bluetooth-player.c
index f10d9be..875fa7c 100644
--- a/tools/bluetooth-player.c
+++ b/tools/bluetooth-player.c
@@ -1430,7 +1430,7 @@ int main(int argc, char *argv[])
 
 	input = setup_standard_input();
 	signal = setup_signalfd();
-	client = g_dbus_client_new(dbus_conn, "org.bluez", "/org/bluez");
+	client = g_dbus_client_new(dbus_conn, "org.bluez", "/org/bluez", NULL);
 
 	g_dbus_client_set_connect_watch(client, connect_handler, NULL);
 	g_dbus_client_set_disconnect_watch(client, disconnect_handler, NULL);
diff --git a/tools/gap-tester.c b/tools/gap-tester.c
index 2a0be91..31260d1 100644
--- a/tools/gap-tester.c
+++ b/tools/gap-tester.c
@@ -108,7 +108,8 @@ static void test_setup(const void *test_data)
 {
 	dbus_conn = g_dbus_setup_private(DBUS_BUS_SYSTEM, NULL, NULL);
 
-	dbus_client = g_dbus_client_new(dbus_conn, "org.bluez", "/org/bluez");
+	dbus_client = g_dbus_client_new(dbus_conn, "org.bluez", "/org/bluez",
+									NULL);
 
 	g_dbus_client_set_connect_watch(dbus_client, connect_handler, NULL);
 	g_dbus_client_set_disconnect_watch(dbus_client,
diff --git a/tools/gatt-service.c b/tools/gatt-service.c
index 6bca404..8aaa520 100644
--- a/tools/gatt-service.c
+++ b/tools/gatt-service.c
@@ -521,7 +521,7 @@ int main(int argc, char *argv[])
 
 	create_services();
 
-	client = g_dbus_client_new(connection, "org.bluez", "/org/bluez");
+	client = g_dbus_client_new(connection, "org.bluez", "/org/bluez", NULL);
 
 	g_dbus_client_set_connect_watch(client, connect_handler, NULL);
 
diff --git a/tools/mpris-proxy.c b/tools/mpris-proxy.c
index 397f064..a4eafb8 100644
--- a/tools/mpris-proxy.c
+++ b/tools/mpris-proxy.c
@@ -2568,7 +2568,7 @@ int main(int argc, char *argv[])
 	sigaction(SIGTERM, &sa, NULL);
 	sigaction(SIGINT,  &sa, NULL);
 
-	client = g_dbus_client_new(sys, BLUEZ_BUS_NAME, BLUEZ_PATH);
+	client = g_dbus_client_new(sys, BLUEZ_BUS_NAME, BLUEZ_PATH, NULL);
 
 	g_dbus_client_set_connect_watch(client, connect_handler, NULL);
 	g_dbus_client_set_disconnect_watch(client, disconnect_handler, NULL);
diff --git a/tools/obexctl.c b/tools/obexctl.c
index b4fdc1c..26c061b 100644
--- a/tools/obexctl.c
+++ b/tools/obexctl.c
@@ -2498,7 +2498,7 @@ int main(int argc, char *argv[])
 	input = setup_standard_input();
 	signal = setup_signalfd();
 	client = g_dbus_client_new(dbus_conn, "org.bluez.obex",
-							"/org/bluez/obex");
+						"/org/bluez/obex", NULL);
 
 	g_dbus_client_set_connect_watch(client, connect_handler, NULL);
 	g_dbus_client_set_disconnect_watch(client, disconnect_handler, NULL);
diff --git a/unit/test-gdbus-client.c b/unit/test-gdbus-client.c
index d0b6ce7..d352fda 100644
--- a/unit/test-gdbus-client.c
+++ b/unit/test-gdbus-client.c
@@ -153,7 +153,8 @@ static void simple_client(void)
 		return;
 
 	context->dbus_client = g_dbus_client_new(context->dbus_conn,
-						SERVICE_NAME, SERVICE_PATH);
+						SERVICE_NAME, SERVICE_PATH,
+						NULL);
 
 	g_dbus_client_set_connect_watch(context->dbus_client,
 						connect_handler, context);
@@ -177,7 +178,8 @@ static void client_connect_disconnect(void)
 				methods, signals, properties, NULL, NULL);
 
 	context->dbus_client = g_dbus_client_new(context->dbus_conn,
-						SERVICE_NAME, SERVICE_PATH);
+						SERVICE_NAME, SERVICE_PATH,
+						NULL);
 
 	g_dbus_client_set_connect_watch(context->dbus_client,
 						connect_handler, context);
@@ -323,7 +325,8 @@ static void client_get_dict_property(void)
 				NULL, NULL);
 
 	context->dbus_client = g_dbus_client_new(context->dbus_conn,
-						SERVICE_NAME, SERVICE_PATH);
+						SERVICE_NAME, SERVICE_PATH,
+						NULL);
 
 	g_dbus_client_set_disconnect_watch(context->dbus_client,
 						disconnect_handler, context);
@@ -385,7 +388,8 @@ static void client_get_string_property(void)
 				context, NULL);
 
 	context->dbus_client = g_dbus_client_new(context->dbus_conn,
-						SERVICE_NAME, SERVICE_PATH);
+						SERVICE_NAME, SERVICE_PATH,
+						NULL);
 
 	g_dbus_client_set_disconnect_watch(context->dbus_client,
 						disconnect_handler, context);
@@ -446,7 +450,8 @@ static void client_get_boolean_property(void)
 				NULL, NULL);
 
 	context->dbus_client = g_dbus_client_new(context->dbus_conn,
-						SERVICE_NAME, SERVICE_PATH);
+						SERVICE_NAME, SERVICE_PATH,
+						NULL);
 
 	g_dbus_client_set_proxy_handlers(context->dbus_client,
 						proxy_get_boolean,
@@ -523,7 +528,8 @@ static void client_get_array_property(void)
 				NULL, NULL);
 
 	context->dbus_client = g_dbus_client_new(context->dbus_conn,
-						SERVICE_NAME, SERVICE_PATH);
+						SERVICE_NAME, SERVICE_PATH,
+						NULL);
 
 	g_dbus_client_set_proxy_handlers(context->dbus_client, proxy_get_array,
 						NULL, NULL, context);
@@ -584,7 +590,8 @@ static void client_get_uint64_property(void)
 				NULL, NULL);
 
 	context->dbus_client = g_dbus_client_new(context->dbus_conn,
-						SERVICE_NAME, SERVICE_PATH);
+						SERVICE_NAME, SERVICE_PATH,
+						NULL);
 
 	g_dbus_client_set_proxy_handlers(context->dbus_client,
 						proxy_get_uint64,
@@ -684,7 +691,8 @@ static void client_set_string_property(void)
 				context, NULL);
 
 	context->dbus_client = g_dbus_client_new(context->dbus_conn,
-						SERVICE_NAME, SERVICE_PATH);
+						SERVICE_NAME, SERVICE_PATH,
+						NULL);
 
 	g_dbus_client_set_disconnect_watch(context->dbus_client,
 						disconnect_handler, context);
@@ -767,7 +775,8 @@ static void client_string_changed(void)
 				context, NULL);
 
 	context->dbus_client = g_dbus_client_new(context->dbus_conn,
-						SERVICE_NAME, SERVICE_PATH);
+						SERVICE_NAME, SERVICE_PATH,
+						NULL);
 
 	g_dbus_client_set_disconnect_watch(context->dbus_client,
 						disconnect_handler, context);
@@ -836,7 +845,8 @@ static void client_check_order(void)
 				context, NULL);
 
 	context->dbus_client = g_dbus_client_new(context->dbus_conn,
-						SERVICE_NAME, SERVICE_PATH);
+						SERVICE_NAME, SERVICE_PATH,
+						NULL);
 
 	g_dbus_client_set_disconnect_watch(context->dbus_client,
 						disconnect_handler, context);
@@ -896,7 +906,8 @@ static void client_proxy_removed(void)
 				context, NULL);
 
 	context->dbus_client = g_dbus_client_new(context->dbus_conn,
-						SERVICE_NAME, SERVICE_PATH);
+						SERVICE_NAME, SERVICE_PATH,
+						NULL);
 
 	g_dbus_client_set_proxy_handlers(context->dbus_client,
 						proxy_set_removed, NULL, NULL,
@@ -951,7 +962,8 @@ static void client_force_disconnect(void)
 					context, NULL);
 
 	context->dbus_client = g_dbus_client_new(context->dbus_conn,
-						SERVICE_NAME1, SERVICE_PATH);
+						SERVICE_NAME1, SERVICE_PATH,
+						NULL);
 
 	g_dbus_client_set_proxy_handlers(context->dbus_client,
 					proxy_force_disconnect, NULL, NULL,
@@ -1004,7 +1016,8 @@ static void client_ready(void)
 				context, NULL);
 
 	context->dbus_client = g_dbus_client_new(context->dbus_conn,
-						SERVICE_NAME, SERVICE_PATH);
+						SERVICE_NAME, SERVICE_PATH,
+						NULL);
 
 	g_dbus_client_set_ready_watch(context->dbus_client, client_ready_watch,
 								context);
-- 
2.2.0.rc0.207.ga3a616c

