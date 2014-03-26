Return-Path: <cyrus@holtmann.org>
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
To: linux-bluetooth@vger.kernel.org
Subject: [RFC BlueZ v0] core/profile: Fix failing to accept connections without a service
Date: Wed, 26 Mar 2014 18:18:56 +0200
Message-Id: <1395850736-10667-1-git-send-email-luiz.dentz@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

From: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>

For incoming connections it is not mandatory to have a service since the
profile may be a server only (enable_client is false) therefore it does
not need to track connection status.

This also pushes the logic to assign the service object to the connection
after the authorization took place so the service discovery should be
completed and all UUIDs should have been discover already.
---
v0: Sent as RFC because it was not properly tested but want a confirmation
that server only profiles do not need connection tracking that service infra
offers.

 src/profile.c | 47 +++++++++++++++++++++++++++++------------------
 1 file changed, 29 insertions(+), 18 deletions(-)

diff --git a/src/profile.c b/src/profile.c
index f6aa970..3eb23dd 100644
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
@@ -997,6 +1010,7 @@ static void ext_auth(DBusError *err, void *user_data)
 {
 	struct ext_io *conn = user_data;
 	struct ext_profile *ext = conn->ext;
+	struct btd_service *service;
 	GError *gerr = NULL;
 	char addr[18];
 
@@ -1023,6 +1037,12 @@ static void ext_auth(DBusError *err, void *user_data)
 
 	DBG("%s authorized to connect to %s", addr, ext->name);
 
+	/* Try getting the service object to provide connection status */
+	btd_device_add_uuid(conn->device, ext->remote_uuid);
+	service = btd_device_get_service(conn->device, ext->remote_uuid);
+	if (service)
+		conn->service = btd_service_ref(conn->service);
+
 	return;
 
 drop:
@@ -1034,7 +1054,6 @@ static struct ext_io *create_conn(struct ext_io *server, GIOChannel *io,
 						bdaddr_t *src, bdaddr_t *dst)
 {
 	struct btd_device *device;
-	struct btd_service *service;
 	struct ext_io *conn;
 	GIOCondition cond;
 	char addr[18];
@@ -1046,22 +1065,12 @@ static struct ext_io *create_conn(struct ext_io *server, GIOChannel *io,
 		return NULL;
 	}
 
-	btd_device_add_uuid(device, server->ext->remote_uuid);
-	service = btd_device_get_service(device, server->ext->remote_uuid);
-	if (service == NULL) {
-		ba2str(dst, addr);
-		error("%s service not found for device %s", server->ext->name,
-									addr);
-		return NULL;
-	}
-
 	conn = g_new0(struct ext_io, 1);
 	conn->io = g_io_channel_ref(io);
 	conn->proto = server->proto;
 	conn->ext = server->ext;
 	conn->adapter = btd_adapter_ref(server->adapter);
 	conn->device = btd_device_ref(device);
-	conn->service = btd_service_ref(service);
 
 	cond = G_IO_HUP | G_IO_ERR | G_IO_NVAL;
 	conn->io_id = g_io_add_watch(io, cond, ext_io_disconnected, conn);
@@ -1537,7 +1546,9 @@ static void record_cb(sdp_list_t *recs, int err, gpointer user_data)
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

