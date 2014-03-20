Return-Path: <cyrus@holtmann.org>
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH BlueZ 2/2] core/profile: Remove code for waiting services to be resolved
Date: Thu, 20 Mar 2014 15:50:51 +0200
Message-Id: <1395323451-31229-3-git-send-email-luiz.dentz@gmail.com>
In-Reply-To: <1395323451-31229-1-git-send-email-luiz.dentz@gmail.com>
References: <1395323451-31229-1-git-send-email-luiz.dentz@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

From: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>

This remove code related to waiting service to be resolved as it is now
part of btd_request_authorization.
---
 src/profile.c | 56 --------------------------------------------------------
 1 file changed, 56 deletions(-)

diff --git a/src/profile.c b/src/profile.c
index ecbb1c5..4fdf940 100644
--- a/src/profile.c
+++ b/src/profile.c
@@ -619,7 +619,6 @@ struct ext_io {
 	uint8_t chan;
 
 	guint auth_id;
-	unsigned int svc_id;
 	DBusPendingCall *pending;
 };
 
@@ -708,10 +707,6 @@ static void ext_io_destroy(gpointer p)
 	if (ext_io->auth_id != 0)
 		btd_cancel_authorization(ext_io->auth_id);
 
-	if (ext_io->svc_id != 0)
-		device_remove_svc_complete_callback(ext_io->device,
-							ext_io->svc_id);
-
 	if (ext_io->pending) {
 		dbus_pending_call_cancel(ext_io->pending);
 		dbus_pending_call_unref(ext_io->pending);
@@ -1017,12 +1012,6 @@ static void ext_auth(DBusError *err, void *user_data)
 		goto drop;
 	}
 
-	if (conn->svc_id > 0) {
-		DBG("Connection from %s authorized but still waiting for SDP",
-									addr);
-		return;
-	}
-
 	if (!bt_io_accept(conn->io, ext_connect, conn, NULL, &gerr)) {
 		error("bt_io_accept: %s", gerr->message);
 		g_error_free(gerr);
@@ -1077,47 +1066,6 @@ static struct ext_io *create_conn(struct ext_io *server, GIOChannel *io,
 	return conn;
 }
 
-static void ext_svc_complete(struct btd_device *dev, int err, void *user_data)
-{
-	struct ext_io *conn = user_data;
-	struct ext_profile *ext = conn->ext;
-	const bdaddr_t *bdaddr;
-	GError *gerr = NULL;
-	char addr[18];
-
-	conn->svc_id = 0;
-
-	bdaddr = device_get_address(dev);
-	ba2str(bdaddr, addr);
-
-	if (err < 0) {
-		error("Service resolving failed for %s: %s (%d)",
-						addr, strerror(-err), -err);
-		goto drop;
-	}
-
-	DBG("Services resolved for %s", addr);
-
-	if (conn->auth_id > 0) {
-		DBG("Services resolved but still waiting for authorization");
-		return;
-	}
-
-	if (!bt_io_accept(conn->io, ext_connect, conn, NULL, &gerr)) {
-		error("bt_io_accept: %s", gerr->message);
-		g_error_free(gerr);
-		goto drop;
-	}
-
-	DBG("%s authorized to connect to %s", addr, ext->name);
-
-	return;
-
-drop:
-	ext->conns = g_slist_remove(ext->conns, conn);
-	ext_io_destroy(conn);
-}
-
 static void ext_confirm(GIOChannel *io, gpointer user_data)
 {
 	struct ext_io *server = user_data;
@@ -1156,10 +1104,6 @@ static void ext_confirm(GIOChannel *io, gpointer user_data)
 
 	ext->conns = g_slist_append(ext->conns, conn);
 
-	conn->svc_id = device_wait_for_svc_complete(conn->device,
-							ext_svc_complete,
-							conn);
-
 	DBG("%s authorizing connection from %s", ext->name, addr);
 }
 
-- 
1.8.5.3

