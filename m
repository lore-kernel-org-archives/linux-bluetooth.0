Return-Path: <cyrus@holtmann.org>
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH BlueZ] core/profile: Fix failing to accept connections without a service
Date: Thu, 27 Mar 2014 10:34:19 +0200
Message-Id: <1395909259-2154-1-git-send-email-luiz.dentz@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

From: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>

For incoming connections it is not mandatory to have a service since the
profile may be a server only (enable_client is false) therefore it does
not need to track connection status.
---
 src/profile.c | 40 +++++++++++++++++++++++++++++++---------
 1 file changed, 31 insertions(+), 9 deletions(-)

diff --git a/src/profile.c b/src/profile.c
index f6aa970..7c2fe18 100644
--- a/src/profile.c
+++ b/src/profile.c
@@ -752,7 +752,9 @@ static gboolean ext_io_disconnected(GIOChannel *io, GIOCondition cond,
 
 	DBG("%s disconnected from %s", ext->name, addr);
 drop:
-	btd_service_disconnecting_complete(conn->service, 0);
+	if (conn->service)
+		btd_service_disconnecting_complete(conn->service, 0);
+
 	ext->conns = g_slist_remove(ext->conns, conn);
 	ext_io_destroy(conn);
 	return FALSE;
@@ -774,7 +776,9 @@ static void new_conn_reply(DBusPendingCall *call, void *user_data)
 	conn->pending = NULL;
 
 	if (!dbus_error_is_set(&err)) {
-		btd_service_connecting_complete(conn->service, 0);
+		if (conn->service)
+			btd_service_connecting_complete(conn->service, 0);
+
 		conn->connected = true;
 		return;
 	}
@@ -782,7 +786,8 @@ static void new_conn_reply(DBusPendingCall *call, void *user_data)
 	error("%s replied with an error: %s, %s", ext->name,
 						err.name, err.message);
 
-	btd_service_connecting_complete(conn->service, -ECONNREFUSED);
+	if (conn->service)
+		btd_service_connecting_complete(conn->service, -ECONNREFUSED);
 
 	dbus_error_free(&err);
 
@@ -806,14 +811,18 @@ static void disconn_reply(DBusPendingCall *call, void *user_data)
 	conn->pending = NULL;
 
 	if (!dbus_error_is_set(&err)) {
-		btd_service_disconnecting_complete(conn->service, 0);
+		if (conn->service)
+			btd_service_disconnecting_complete(conn->service, 0);
+
 		goto disconnect;
 	}
 
 	error("%s replied with an error: %s, %s", ext->name,
 						err.name, err.message);
 
-	btd_service_disconnecting_complete(conn->service, -ECONNREFUSED);
+	if (conn->service)
+		btd_service_disconnecting_complete(conn->service,
+								-ECONNREFUSED);
 
 	dbus_error_free(&err);
 
@@ -986,9 +995,13 @@ static void ext_connect(GIOChannel *io, GError *err, gpointer user_data)
 		return;
 
 drop:
-	btd_service_connecting_complete(conn->service, err ? -err->code : -EIO);
+	if (conn->service)
+		btd_service_connecting_complete(conn->service,
+						err ? -err->code : -EIO);
+
 	if (io_err)
 		g_error_free(io_err);
+
 	ext->conns = g_slist_remove(ext->conns, conn);
 	ext_io_destroy(conn);
 }
@@ -1034,7 +1047,7 @@ static struct ext_io *create_conn(struct ext_io *server, GIOChannel *io,
 						bdaddr_t *src, bdaddr_t *dst)
 {
 	struct btd_device *device;
-	struct btd_service *service;
+	struct btd_service *service = NULL;
 	struct ext_io *conn;
 	GIOCondition cond;
 	char addr[18];
@@ -1046,6 +1059,10 @@ static struct ext_io *create_conn(struct ext_io *server, GIOChannel *io,
 		return NULL;
 	}
 
+	/* Do not add UUID if client role is not enabled */
+	if (!server->ext->enable_client)
+		goto done;
+
 	btd_device_add_uuid(device, server->ext->remote_uuid);
 	service = btd_device_get_service(device, server->ext->remote_uuid);
 	if (service == NULL) {
@@ -1055,13 +1072,16 @@ static struct ext_io *create_conn(struct ext_io *server, GIOChannel *io,
 		return NULL;
 	}
 
+done:
 	conn = g_new0(struct ext_io, 1);
 	conn->io = g_io_channel_ref(io);
 	conn->proto = server->proto;
 	conn->ext = server->ext;
 	conn->adapter = btd_adapter_ref(server->adapter);
 	conn->device = btd_device_ref(device);
-	conn->service = btd_service_ref(service);
+
+	if (service)
+		conn->service = btd_service_ref(service);
 
 	cond = G_IO_HUP | G_IO_ERR | G_IO_NVAL;
 	conn->io_id = g_io_add_watch(io, cond, ext_io_disconnected, conn);
@@ -1537,7 +1557,9 @@ static void record_cb(sdp_list_t *recs, int err, gpointer user_data)
 	return;
 
 failed:
-	btd_service_connecting_complete(conn->service, err);
+	if (conn->service)
+		btd_service_connecting_complete(conn->service, err);
+
 	ext->conns = g_slist_remove(ext->conns, conn);
 	ext_io_destroy(conn);
 }
-- 
1.8.5.3

