Return-Path: <cyrus@holtmann.org>
From: Szymon Janc <szymon.janc@tieto.com>
To: <linux-bluetooth@vger.kernel.org>
CC: Szymon Janc <szymon.janc@tieto.com>
Subject: [PATCH 4/8] network: Remove redundant struct network_peer members
Date: Tue, 16 Oct 2012 12:12:55 +0200
Message-ID: <1350382379-30489-4-git-send-email-szymon.janc@tieto.com>
In-Reply-To: <1350382379-30489-1-git-send-email-szymon.janc@tieto.com>
References: <1350382379-30489-1-git-send-email-szymon.janc@tieto.com>
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

struct network_peer holds reference to btd_device so path, src and dst
can be accessed from it.

---
 profiles/network/common.c     |    2 +-
 profiles/network/common.h     |    2 +-
 profiles/network/connection.c |   66 ++++++++++++++++++++---------------------
 profiles/network/connection.h |    5 ++--
 profiles/network/manager.c    |   22 ++++----------
 5 files changed, 43 insertions(+), 54 deletions(-)

diff --git a/profiles/network/common.c b/profiles/network/common.c
index da493c1..34ab788 100644
--- a/profiles/network/common.c
+++ b/profiles/network/common.c
@@ -124,7 +124,7 @@ int bnep_cleanup(void)
 	return 0;
 }
 
-int bnep_kill_connection(bdaddr_t *dst)
+int bnep_kill_connection(const bdaddr_t *dst)
 {
 	struct bnep_conndel_req req;
 
diff --git a/profiles/network/common.h b/profiles/network/common.h
index 62f2f59..0a8c4fe 100644
--- a/profiles/network/common.h
+++ b/profiles/network/common.h
@@ -28,7 +28,7 @@ uint16_t bnep_service_id(const char *svc);
 const char *bnep_uuid(uint16_t id);
 const char *bnep_name(uint16_t id);
 
-int bnep_kill_connection(bdaddr_t *dst);
+int bnep_kill_connection(const bdaddr_t *dst);
 int bnep_kill_all_connections(void);
 
 int bnep_connadd(int sk, uint16_t role, char *dev);
diff --git a/profiles/network/connection.c b/profiles/network/connection.c
index 9646e5a..8564bca 100644
--- a/profiles/network/connection.c
+++ b/profiles/network/connection.c
@@ -59,9 +59,6 @@ typedef enum {
 } conn_state;
 
 struct network_peer {
-	bdaddr_t	src;
-	bdaddr_t	dst;
-	char		*path;		/* D-Bus path */
 	struct btd_device *device;
 	GSList		*connections;
 };
@@ -86,12 +83,12 @@ struct __service_16 {
 
 static GSList *peers = NULL;
 
-static struct network_peer *find_peer(GSList *list, const char *path)
+static struct network_peer *find_peer(GSList *list, struct btd_device *device)
 {
 	for (; list; list = list->next) {
 		struct network_peer *peer = list->data;
 
-		if (!strcmp(peer->path, path))
+		if (peer->device == device)
 			return peer;
 	}
 
@@ -116,14 +113,15 @@ static gboolean bnep_watchdog_cb(GIOChannel *chan, GIOCondition cond,
 	struct network_conn *nc = data;
 	gboolean connected = FALSE;
 	const char *property = "";
+	const char *path = device_get_path(nc->peer->device);
 
-	emit_property_changed(nc->peer->path,
+	emit_property_changed(path,
 				NETWORK_PEER_INTERFACE, "Connected",
 				DBUS_TYPE_BOOLEAN, &connected);
-	emit_property_changed(nc->peer->path,
+	emit_property_changed(path,
 				NETWORK_PEER_INTERFACE, "Interface",
 				DBUS_TYPE_STRING, &property);
-	emit_property_changed(nc->peer->path,
+	emit_property_changed(path,
 				NETWORK_PEER_INTERFACE, "UUID",
 				DBUS_TYPE_STRING, &property);
 	device_remove_disconnect_watch(nc->peer->device, nc->dc_id);
@@ -180,7 +178,7 @@ static void connection_destroy(DBusConnection *conn, void *user_data)
 
 	if (nc->state == CONNECTED) {
 		bnep_if_down(nc->dev);
-		bnep_kill_connection(&nc->peer->dst);
+		bnep_kill_connection(device_get_address(nc->peer->device));
 	} else if (nc->io)
 		cancel_connection(nc, NULL);
 }
@@ -190,7 +188,7 @@ static void disconnect_cb(struct btd_device *device, gboolean removal,
 {
 	struct network_conn *nc = user_data;
 
-	info("Network: disconnect %s", nc->peer->path);
+	info("Network: disconnect %s", device_get_path(nc->peer->device));
 
 	connection_destroy(NULL, user_data);
 }
@@ -206,6 +204,7 @@ static gboolean bnep_setup_cb(GIOChannel *chan, GIOCondition cond,
 	int sk;
 	const char *pdev, *uuid;
 	gboolean connected;
+	const char *path;
 
 	if (cond & G_IO_NVAL)
 		return FALSE;
@@ -277,14 +276,16 @@ static gboolean bnep_setup_cb(GIOChannel *chan, GIOCondition cond,
 	dbus_message_unref(nc->msg);
 	nc->msg = NULL;
 
+	path = device_get_path(nc->peer->device);
+
 	connected = TRUE;
-	emit_property_changed(nc->peer->path,
+	emit_property_changed(path,
 				NETWORK_PEER_INTERFACE, "Connected",
 				DBUS_TYPE_BOOLEAN, &connected);
-	emit_property_changed(nc->peer->path,
+	emit_property_changed(path,
 				NETWORK_PEER_INTERFACE, "Interface",
 				DBUS_TYPE_STRING, &pdev);
-	emit_property_changed(nc->peer->path,
+	emit_property_changed(path,
 				NETWORK_PEER_INTERFACE, "UUID",
 				DBUS_TYPE_STRING, &uuid);
 
@@ -404,6 +405,8 @@ static DBusMessage *connection_connect(DBusConnection *conn,
 	const char *svc;
 	uint16_t id;
 	GError *err = NULL;
+	const bdaddr_t *src;
+	const bdaddr_t *dst;
 
 	if (dbus_message_get_args(msg, NULL, DBUS_TYPE_STRING, &svc,
 						DBUS_TYPE_INVALID) == FALSE)
@@ -417,10 +420,13 @@ static DBusMessage *connection_connect(DBusConnection *conn,
 	if (nc->state != DISCONNECTED)
 		return btd_error_already_connected(msg);
 
+	src = adapter_get_address(device_get_adapter(peer->device));
+	dst = device_get_address(peer->device);
+
 	nc->io = bt_io_connect(connect_cb, nc,
 				NULL, &err,
-				BT_IO_OPT_SOURCE_BDADDR, &peer->src,
-				BT_IO_OPT_DEST_BDADDR, &peer->dst,
+				BT_IO_OPT_SOURCE_BDADDR, src,
+				BT_IO_OPT_DEST_BDADDR, dst,
 				BT_IO_OPT_PSM, BNEP_PSM,
 				BT_IO_OPT_SEC_LEVEL, BT_IO_SEC_MEDIUM,
 				BT_IO_OPT_OMTU, BNEP_MTU,
@@ -544,7 +550,6 @@ static void peer_free(struct network_peer *peer)
 {
 	g_slist_free_full(peer->connections, connection_free);
 	btd_device_unref(peer->device);
-	g_free(peer->path);
 	g_free(peer);
 }
 
@@ -553,7 +558,7 @@ static void path_unregister(void *data)
 	struct network_peer *peer = data;
 
 	DBG("Unregistered interface %s on path %s",
-		NETWORK_PEER_INTERFACE, peer->path);
+		NETWORK_PEER_INTERFACE, device_get_path(peer->device));
 
 	peers = g_slist_remove(peers, peer);
 	peer_free(peer);
@@ -578,11 +583,11 @@ static const GDBusSignalTable connection_signals[] = {
 	{ }
 };
 
-void connection_unregister(const char *path)
+void connection_unregister(struct btd_device *device)
 {
 	struct network_peer *peer;
 
-	peer = find_peer(peers, path);
+	peer = find_peer(peers, device);
 	if (!peer)
 		return;
 
@@ -590,20 +595,19 @@ void connection_unregister(const char *path)
 	peer->connections = NULL;
 
 	g_dbus_unregister_interface(btd_get_dbus_connection(),
-						path, NETWORK_PEER_INTERFACE);
+						device_get_path(device),
+						NETWORK_PEER_INTERFACE);
 }
 
-static struct network_peer *create_peer(struct btd_device *device,
-					const char *path, const bdaddr_t *src,
-					const bdaddr_t *dst)
+static struct network_peer *create_peer(struct btd_device *device)
 {
 	struct network_peer *peer;
+	const char *path;
 
 	peer = g_new0(struct network_peer, 1);
 	peer->device = btd_device_ref(device);
-	peer->path = g_strdup(path);
-	bacpy(&peer->src, src);
-	bacpy(&peer->dst, dst);
+
+	path = device_get_path(device);
 
 	if (g_dbus_register_interface(btd_get_dbus_connection(), path,
 					NETWORK_PEER_INTERFACE,
@@ -622,18 +626,14 @@ static struct network_peer *create_peer(struct btd_device *device,
 	return peer;
 }
 
-int connection_register(struct btd_device *device, const char *path,
-			const bdaddr_t *src, const bdaddr_t *dst, uint16_t id)
+int connection_register(struct btd_device *device, uint16_t id)
 {
 	struct network_peer *peer;
 	struct network_conn *nc;
 
-	if (!path)
-		return -EINVAL;
-
-	peer = find_peer(peers, path);
+	peer = find_peer(peers, device);
 	if (!peer) {
-		peer = create_peer(device, path, src, dst);
+		peer = create_peer(device);
 		if (!peer)
 			return -1;
 		peers = g_slist_append(peers, peer);
diff --git a/profiles/network/connection.h b/profiles/network/connection.h
index efc4ccb..50c0774 100644
--- a/profiles/network/connection.h
+++ b/profiles/network/connection.h
@@ -21,6 +21,5 @@
  *
  */
 
-int connection_register(struct btd_device *device, const char *path,
-			const bdaddr_t *src, const bdaddr_t *dst, uint16_t id);
-void connection_unregister(const char *path);
+int connection_register(struct btd_device *device, uint16_t id);
+void connection_unregister(struct btd_device *device);
diff --git a/profiles/network/manager.c b/profiles/network/manager.c
index 049fbc7..aa564bd 100644
--- a/profiles/network/manager.c
+++ b/profiles/network/manager.c
@@ -76,33 +76,23 @@ done:
 static int network_probe(struct btd_profile *p, struct btd_device *device,
 								GSList *uuids)
 {
-	struct btd_adapter *adapter = device_get_adapter(device);
-	const gchar *path = device_get_path(device);
-	const bdaddr_t *src;
-	const bdaddr_t *dst;
-
-	DBG("path %s", path);
-
-	src = adapter_get_address(adapter);
-	dst = device_get_address(device);
+	DBG("path %s", device_get_path(device));
 
 	if (g_slist_find_custom(uuids, PANU_UUID, bt_uuid_strcmp))
-		connection_register(device, path, src, dst, BNEP_SVC_PANU);
+		connection_register(device, BNEP_SVC_PANU);
 	if (g_slist_find_custom(uuids, GN_UUID, bt_uuid_strcmp))
-		connection_register(device, path, src, dst, BNEP_SVC_GN);
+		connection_register(device, BNEP_SVC_GN);
 	if (g_slist_find_custom(uuids, NAP_UUID, bt_uuid_strcmp))
-		connection_register(device, path, src, dst, BNEP_SVC_NAP);
+		connection_register(device, BNEP_SVC_NAP);
 
 	return 0;
 }
 
 static void network_remove(struct btd_profile *p, struct btd_device *device)
 {
-	const gchar *path = device_get_path(device);
-
-	DBG("path %s", path);
+	DBG("path %s", device_get_path(device));
 
-	connection_unregister(path);
+	connection_unregister(device);
 }
 
 static int network_server_probe(struct btd_profile *p,
-- 
1.7.9.5

