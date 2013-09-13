Return-Path: <cyrus@holtmann.org>
From: Szymon Janc <szymon.janc@tieto.com>
To: <linux-bluetooth@vger.kernel.org>
CC: Szymon Janc <szymon.janc@tieto.com>
Subject: [PATCH 3/8] sap: Keep reference to btd_adapter in struct sap_server
Date: Fri, 13 Sep 2013 13:30:47 +0200
Message-ID: <1379071852-10094-3-git-send-email-szymon.janc@tieto.com>
In-Reply-To: <1379071852-10094-1-git-send-email-szymon.janc@tieto.com>
References: <1379071852-10094-1-git-send-email-szymon.janc@tieto.com>
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Path and adapter address can be obtained easily from btd_adapter
and there is no need to keep local copy.
---
 profiles/sap/manager.c |  6 ++----
 profiles/sap/server.c  | 23 +++++++++++++----------
 profiles/sap/server.h  |  2 +-
 3 files changed, 16 insertions(+), 15 deletions(-)

diff --git a/profiles/sap/manager.c b/profiles/sap/manager.c
index 24b73e7..bfb81a5 100644
--- a/profiles/sap/manager.c
+++ b/profiles/sap/manager.c
@@ -35,11 +35,9 @@
 
 static int sap_server_probe(struct btd_profile *p, struct btd_adapter *adapter)
 {
-	const char *path = adapter_get_path(adapter);
-
-	DBG("path %s", path);
+	DBG("path %s", adapter_get_path(adapter));
 
-	return sap_server_register(path, adapter_get_address(adapter));
+	return sap_server_register(adapter);
 }
 
 static void sap_server_remove(struct btd_profile *p,
diff --git a/profiles/sap/server.c b/profiles/sap/server.c
index dfcf0f1..1aacfe9 100644
--- a/profiles/sap/server.c
+++ b/profiles/sap/server.c
@@ -73,7 +73,7 @@ struct sap_connection {
 };
 
 struct sap_server {
-	char *path;
+	struct btd_adapter *adapter;
 	uint32_t record_id;
 	GIOChannel *listen_io;
 	struct sap_connection *conn;
@@ -620,7 +620,8 @@ static void sap_set_connected(struct sap_server *server)
 {
 	server->conn->state = SAP_STATE_CONNECTED;
 
-	g_dbus_emit_property_changed(btd_get_dbus_connection(), server->path,
+	g_dbus_emit_property_changed(btd_get_dbus_connection(),
+					adapter_get_path(server->adapter),
 					SAP_SERVER_INTERFACE, "Connected");
 }
 
@@ -1144,7 +1145,8 @@ static void sap_io_destroy(void *data)
 	if (conn->state != SAP_STATE_CONNECT_IN_PROGRESS &&
 				conn->state != SAP_STATE_CONNECT_MODEM_BUSY)
 		g_dbus_emit_property_changed(btd_get_dbus_connection(),
-					server->path, SAP_SERVER_INTERFACE,
+					adapter_get_path(server->adapter),
+					SAP_SERVER_INTERFACE,
 					"Connected");
 
 	if (conn->state == SAP_STATE_CONNECT_IN_PROGRESS ||
@@ -1326,7 +1328,7 @@ static void server_remove(struct sap_server *server)
 		server->listen_io = NULL;
 	}
 
-	g_free(server->path);
+	btd_adapter_unref(server->adapter);
 	g_free(server);
 }
 
@@ -1335,12 +1337,12 @@ static void destroy_sap_interface(void *data)
 	struct sap_server *server = data;
 
 	DBG("Unregistered interface %s on path %s", SAP_SERVER_INTERFACE,
-								server->path);
+					adapter_get_path(server->adapter));
 
 	server_remove(server);
 }
 
-int sap_server_register(const char *path, const bdaddr_t *src)
+int sap_server_register(struct btd_adapter *adapter)
 {
 	sdp_record_t *record = NULL;
 	GError *gerr = NULL;
@@ -1358,19 +1360,19 @@ int sap_server_register(const char *path, const bdaddr_t *src)
 		goto sdp_err;
 	}
 
-	if (add_record_to_server(src, record) < 0) {
+	if (add_record_to_server(adapter_get_address(adapter), record) < 0) {
 		error("Adding SAP SDP record to the SDP server failed.");
 		sdp_record_free(record);
 		goto sdp_err;
 	}
 
 	server = g_new0(struct sap_server, 1);
-	server->path = g_strdup(path);
+	server->adapter = btd_adapter_ref(adapter);
 	server->record_id = record->handle;
 
 	io = bt_io_listen(NULL, connect_confirm_cb, server,
 			NULL, &gerr,
-			BT_IO_OPT_SOURCE_BDADDR, src,
+			BT_IO_OPT_SOURCE_BDADDR, adapter_get_address(adapter),
 			BT_IO_OPT_CHANNEL, SAP_SERVER_CHANNEL,
 			BT_IO_OPT_SEC_LEVEL, BT_IO_SEC_HIGH,
 			BT_IO_OPT_MASTER, TRUE,
@@ -1383,7 +1385,8 @@ int sap_server_register(const char *path, const bdaddr_t *src)
 	server->listen_io = io;
 
 	if (!g_dbus_register_interface(btd_get_dbus_connection(),
-					server->path, SAP_SERVER_INTERFACE,
+					adapter_get_path(server->adapter),
+					SAP_SERVER_INTERFACE,
 					server_methods, NULL,
 					server_properties, server,
 					destroy_sap_interface)) {
diff --git a/profiles/sap/server.h b/profiles/sap/server.h
index 73b38ab..d7e674a 100644
--- a/profiles/sap/server.h
+++ b/profiles/sap/server.h
@@ -20,5 +20,5 @@
 
 #include <gdbus/gdbus.h>
 
-int sap_server_register(const char *path, const bdaddr_t *src);
+int sap_server_register(struct btd_adapter *adapter);
 void sap_server_unregister(const char *path);
-- 
1.8.4

