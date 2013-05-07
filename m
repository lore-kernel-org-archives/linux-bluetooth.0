Return-Path: <cyrus@holtmann.org>
From: Mikel Astiz <mikel.astiz.oss@gmail.com>
To: linux-bluetooth@vger.kernel.org
Cc: Mikel Astiz <mikel.astiz@bmw-carit.de>
Subject: [PATCH BlueZ v2 3/3] profile: Error-cases for incoming connections
Date: Tue,  7 May 2013 18:58:15 +0200
Message-Id: <1367945895-18926-4-git-send-email-mikel.astiz.oss@gmail.com>
In-Reply-To: <1367945895-18926-1-git-send-email-mikel.astiz.oss@gmail.com>
References: <1367945895-18926-1-git-send-email-mikel.astiz.oss@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

From: Mikel Astiz <mikel.astiz@bmw-carit.de>

When an incoming connection attempt is received, if the corresponding
device or service is not found, handle the error-case.
---
 src/profile.c | 34 +++++++++++++++++++++++-----------
 1 file changed, 23 insertions(+), 11 deletions(-)

diff --git a/src/profile.c b/src/profile.c
index 6a71627..8fd0424 100644
--- a/src/profile.c
+++ b/src/profile.c
@@ -1047,23 +1047,30 @@ static struct ext_io *create_conn(struct ext_io *server, GIOChannel *io,
 	struct btd_service *service;
 	struct ext_io *conn;
 	GIOCondition cond;
+	char addr[18];
+
+	device = adapter_find_device(server->adapter, dst);
+	if (device == NULL) {
+		ba2str(dst, addr);
+		error("%s device %s not found", server->ext->name, addr);
+		return NULL;
+	}
+
+	service = btd_device_get_service(device, server->ext->remote_uuid);
+	if (service == NULL) {
+		ba2str(dst, addr);
+		error("%s service not found for device %s", server->ext->name,
+									addr);
+		return NULL;
+	}
 
 	conn = g_new0(struct ext_io, 1);
 	conn->io = g_io_channel_ref(io);
 	conn->proto = server->proto;
 	conn->ext = server->ext;
 	conn->adapter = btd_adapter_ref(server->adapter);
-
-	device = adapter_find_device(server->adapter, dst);
-
-	if (device) {
-		conn->device = btd_device_ref(device);
-
-		service = btd_device_get_service(device,
-						server->ext->remote_uuid);
-		if (service)
-			conn->service = btd_service_ref(service);
-	}
+	conn->device = btd_device_ref(device);
+	conn->service = btd_service_ref(service);
 
 	cond = G_IO_HUP | G_IO_ERR | G_IO_NVAL;
 	conn->io_id = g_io_add_watch(io, cond, ext_io_disconnected, conn);
@@ -1137,6 +1144,8 @@ static void ext_confirm(GIOChannel *io, gpointer user_data)
 	DBG("incoming connect from %s", addr);
 
 	conn = create_conn(server, io, &src, &dst);
+	if (conn == NULL)
+		return;
 
 	conn->auth_id = btd_request_authorization(&src, &dst, uuid, ext_auth,
 									conn);
@@ -1175,6 +1184,9 @@ static void ext_direct_connect(GIOChannel *io, GError *err, gpointer user_data)
 	}
 
 	conn = create_conn(server, io, &src, &dst);
+	if (conn == NULL)
+		return;
+
 	ext->conns = g_slist_append(ext->conns, conn);
 
 	ext_connect(io, err, conn);
-- 
1.8.1.4

