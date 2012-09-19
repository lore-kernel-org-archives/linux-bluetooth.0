Return-Path: <cyrus@holtmann.org>
From: Andrzej Kaczmarek <andrzej.kaczmarek@tieto.com>
To: <linux-bluetooth@vger.kernel.org>
CC: Andrzej Kaczmarek <andrzej.kaczmarek@tieto.com>
Subject: [PATCH 13/17] network: Simplify DBusConnection object handling
Date: Wed, 19 Sep 2012 12:22:15 +0200
Message-ID: <1348050139-27883-14-git-send-email-andrzej.kaczmarek@tieto.com>
In-Reply-To: <1348050139-27883-1-git-send-email-andrzej.kaczmarek@tieto.com>
References: <1348050139-27883-1-git-send-email-andrzej.kaczmarek@tieto.com>
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

This patch removes redundant references and function parameters for
DBusConnection object and uses btd_get_dbus_connection() call wherever
such object is needed instead.

Pointer returned by this call is guaranteed to be valid for entire
bluetoothd lifetime and thus do not need to be refcounted.
---
 profiles/network/connection.c | 64 +++++++++++++++++--------------------------
 profiles/network/connection.h |  2 --
 profiles/network/main.c       | 15 +---------
 profiles/network/manager.c    | 16 ++---------
 profiles/network/manager.h    |  2 +-
 profiles/network/server.c     | 13 ++++-----
 profiles/network/server.h     |  2 +-
 7 files changed, 35 insertions(+), 79 deletions(-)

diff --git a/profiles/network/connection.c b/profiles/network/connection.c
index 178f51f..9773b7b 100644
--- a/profiles/network/connection.c
+++ b/profiles/network/connection.c
@@ -84,7 +84,6 @@ struct __service_16 {
 	uint16_t src;
 } __attribute__ ((packed));
 
-static DBusConnection *connection = NULL;
 static GSList *peers = NULL;
 
 static struct network_peer *find_peer(GSList *list, const char *path)
@@ -115,25 +114,23 @@ static gboolean bnep_watchdog_cb(GIOChannel *chan, GIOCondition cond,
 				gpointer data)
 {
 	struct network_conn *nc = data;
+	gboolean connected = FALSE;
+	const char *property = "";
 
-	if (connection != NULL) {
-		gboolean connected = FALSE;
-		const char *property = "";
-		emit_property_changed(nc->peer->path,
-					NETWORK_PEER_INTERFACE, "Connected",
-					DBUS_TYPE_BOOLEAN, &connected);
-		emit_property_changed(nc->peer->path,
-					NETWORK_PEER_INTERFACE, "Interface",
-					DBUS_TYPE_STRING, &property);
-		emit_property_changed(nc->peer->path,
-					NETWORK_PEER_INTERFACE, "UUID",
-					DBUS_TYPE_STRING, &property);
-		device_remove_disconnect_watch(nc->peer->device, nc->dc_id);
-		nc->dc_id = 0;
-		if (nc->watch) {
-			g_dbus_remove_watch(connection, nc->watch);
-			nc->watch = 0;
-		}
+	emit_property_changed(nc->peer->path,
+				NETWORK_PEER_INTERFACE, "Connected",
+				DBUS_TYPE_BOOLEAN, &connected);
+	emit_property_changed(nc->peer->path,
+				NETWORK_PEER_INTERFACE, "Interface",
+				DBUS_TYPE_STRING, &property);
+	emit_property_changed(nc->peer->path,
+				NETWORK_PEER_INTERFACE, "UUID",
+				DBUS_TYPE_STRING, &property);
+	device_remove_disconnect_watch(nc->peer->device, nc->dc_id);
+	nc->dc_id = 0;
+	if (nc->watch) {
+		g_dbus_remove_watch(btd_get_dbus_connection(), nc->watch);
+		nc->watch = 0;
 	}
 
 	info("%s disconnected", nc->dev);
@@ -148,6 +145,7 @@ static gboolean bnep_watchdog_cb(GIOChannel *chan, GIOCondition cond,
 
 static void cancel_connection(struct network_conn *nc, const char *err_msg)
 {
+	DBusConnection *conn = btd_get_dbus_connection();
 	DBusMessage *reply;
 
 	if (nc->timeout_source > 0) {
@@ -156,13 +154,13 @@ static void cancel_connection(struct network_conn *nc, const char *err_msg)
 	}
 
 	if (nc->watch) {
-		g_dbus_remove_watch(connection, nc->watch);
+		g_dbus_remove_watch(conn, nc->watch);
 		nc->watch = 0;
 	}
 
 	if (nc->msg && err_msg) {
 		reply = btd_error_failed(nc->msg, err_msg);
-		g_dbus_send_message(connection, reply);
+		g_dbus_send_message(conn, reply);
 	}
 
 	g_io_channel_shutdown(nc->io, TRUE, NULL);
@@ -269,7 +267,7 @@ static gboolean bnep_setup_cb(GIOChannel *chan, GIOCondition cond,
 	pdev = nc->dev;
 	uuid = bnep_uuid(nc->id);
 
-	g_dbus_send_reply(connection, nc->msg,
+	g_dbus_send_reply(btd_get_dbus_connection(), nc->msg,
 			DBUS_TYPE_STRING, &pdev,
 			DBUS_TYPE_INVALID);
 
@@ -450,7 +448,7 @@ static DBusMessage *connection_cancel(DBusConnection *conn,
 	if (!g_str_equal(owner, caller))
 		return btd_error_not_authorized(msg);
 
-	connection_destroy(conn, nc);
+	connection_destroy(NULL, nc);
 
 	return g_dbus_create_reply(msg, DBUS_TYPE_INVALID);
 }
@@ -530,7 +528,7 @@ static void connection_free(void *data)
 	if (nc->dc_id)
 		device_remove_disconnect_watch(nc->peer->device, nc->dc_id);
 
-	connection_destroy(connection, nc);
+	connection_destroy(NULL, nc);
 
 	g_free(nc);
 	nc = NULL;
@@ -585,7 +583,8 @@ void connection_unregister(const char *path)
 	g_slist_free_full(peer->connections, connection_free);
 	peer->connections = NULL;
 
-	g_dbus_unregister_interface(connection, path, NETWORK_PEER_INTERFACE);
+	g_dbus_unregister_interface(btd_get_dbus_connection(),
+						path, NETWORK_PEER_INTERFACE);
 }
 
 static struct network_peer *create_peer(struct btd_device *device,
@@ -600,7 +599,7 @@ static struct network_peer *create_peer(struct btd_device *device,
 	bacpy(&peer->src, src);
 	bacpy(&peer->dst, dst);
 
-	if (g_dbus_register_interface(connection, path,
+	if (g_dbus_register_interface(btd_get_dbus_connection(), path,
 					NETWORK_PEER_INTERFACE,
 					connection_methods,
 					connection_signals, NULL,
@@ -649,16 +648,3 @@ int connection_register(struct btd_device *device, const char *path,
 
 	return 0;
 }
-
-int connection_init(DBusConnection *conn)
-{
-	connection = dbus_connection_ref(conn);
-
-	return 0;
-}
-
-void connection_exit(void)
-{
-	dbus_connection_unref(connection);
-	connection = NULL;
-}
diff --git a/profiles/network/connection.h b/profiles/network/connection.h
index a5e0e61..2e33c55 100644
--- a/profiles/network/connection.h
+++ b/profiles/network/connection.h
@@ -21,8 +21,6 @@
  *
  */
 
-int connection_init(DBusConnection *conn);
-void connection_exit(void);
 int connection_register(struct btd_device *device, const char *path,
 			bdaddr_t *src, bdaddr_t *dst, uint16_t id);
 void connection_unregister(const char *path);
diff --git a/profiles/network/main.c b/profiles/network/main.c
index 88e77ee..8ec1f3f 100644
--- a/profiles/network/main.c
+++ b/profiles/network/main.c
@@ -32,27 +32,14 @@
 #include "plugin.h"
 #include "manager.h"
 
-static DBusConnection *connection;
-
 static int network_init(void)
 {
-	connection = dbus_bus_get(DBUS_BUS_SYSTEM, NULL);
-	if (connection == NULL)
-		return -EIO;
-
-	if (network_manager_init(connection) < 0) {
-		dbus_connection_unref(connection);
-		return -EIO;
-	}
-
-	return 0;
+	return network_manager_init();
 }
 
 static void network_exit(void)
 {
 	network_manager_exit();
-
-	dbus_connection_unref(connection);
 }
 
 BLUETOOTH_PLUGIN_DEFINE(network, VERSION,
diff --git a/profiles/network/manager.c b/profiles/network/manager.c
index 9ab3a8b..a0506d3 100644
--- a/profiles/network/manager.c
+++ b/profiles/network/manager.c
@@ -45,8 +45,6 @@
 #include "connection.h"
 #include "server.h"
 
-static DBusConnection *connection = NULL;
-
 static gboolean conf_security = TRUE;
 
 static void read_config(const char *file)
@@ -133,7 +131,7 @@ static struct btd_profile network_profile = {
 	.adapter_remove	= network_server_remove,
 };
 
-int network_manager_init(DBusConnection *conn)
+int network_manager_init(void)
 {
 	read_config(CONFIGDIR "/network.conf");
 
@@ -149,16 +147,11 @@ int network_manager_init(DBusConnection *conn)
 	 * field that defines which service the source is connecting to.
 	 */
 
-	if (server_init(conn, conf_security) < 0)
+	if (server_init(conf_security) < 0)
 		return -1;
 
 	btd_profile_register(&network_profile);
 
-	if (connection_init(conn) < 0)
-		return -1;
-
-	connection = dbus_connection_ref(conn);
-
 	return 0;
 }
 
@@ -166,12 +159,7 @@ void network_manager_exit(void)
 {
 	server_exit();
 
-	connection_exit();
-
 	btd_profile_unregister(&network_profile);
 
-	dbus_connection_unref(connection);
-	connection = NULL;
-
 	bnep_cleanup();
 }
diff --git a/profiles/network/manager.h b/profiles/network/manager.h
index 27bc13f..5ba1f0e 100644
--- a/profiles/network/manager.h
+++ b/profiles/network/manager.h
@@ -21,5 +21,5 @@
  *
  */
 
-int network_manager_init(DBusConnection *conn);
+int network_manager_init(void);
 void network_manager_exit(void);
diff --git a/profiles/network/server.c b/profiles/network/server.c
index 88e108f..43ce9d9 100644
--- a/profiles/network/server.c
+++ b/profiles/network/server.c
@@ -82,7 +82,6 @@ struct network_server {
 	guint		watch_id;	/* Client service watch */
 };
 
-static DBusConnection *connection = NULL;
 static GSList *adapters = NULL;
 static gboolean security = TRUE;
 
@@ -553,18 +552,15 @@ drop:
 	g_io_channel_shutdown(chan, TRUE, NULL);
 }
 
-int server_init(DBusConnection *conn, gboolean secure)
+int server_init(gboolean secure)
 {
 	security = secure;
-	connection = dbus_connection_ref(conn);
 
 	return 0;
 }
 
 void server_exit(void)
 {
-	dbus_connection_unref(connection);
-	connection = NULL;
 }
 
 static uint32_t register_server_record(struct network_server *ns)
@@ -798,7 +794,8 @@ int server_register(struct btd_adapter *adapter)
 
 	path = adapter_get_path(adapter);
 
-	if (!g_dbus_register_interface(connection, path, ns->iface,
+	if (!g_dbus_register_interface(btd_get_dbus_connection(),
+					path, ns->iface,
 					server_methods, NULL, NULL,
 					ns, path_unregister)) {
 		error("D-Bus failed to register %s interface",
@@ -832,8 +829,8 @@ int server_unregister(struct btd_adapter *adapter)
 	if (!ns)
 		return -EINVAL;
 
-	g_dbus_unregister_interface(connection, adapter_get_path(adapter),
-					ns->iface);
+	g_dbus_unregister_interface(btd_get_dbus_connection(),
+					adapter_get_path(adapter), ns->iface);
 
 	return 0;
 }
diff --git a/profiles/network/server.h b/profiles/network/server.h
index 6351f6d..4c3ab85 100644
--- a/profiles/network/server.h
+++ b/profiles/network/server.h
@@ -21,7 +21,7 @@
  *
  */
 
-int server_init(DBusConnection *conn, gboolean secure);
+int server_init(gboolean secure);
 void server_exit(void);
 int server_register(struct btd_adapter *adapter);
 int server_unregister(struct btd_adapter *adapter);
-- 
1.7.11.3

