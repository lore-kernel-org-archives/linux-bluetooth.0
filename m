Return-Path: <cyrus@holtmann.org>
From: Denis Kenzior <denkenz@gmail.com>
To: linux-bluetooth@vger.kernel.org
Cc: Denis Kenzior <denkenz@gmail.com>
Subject: [PATCH 3/3] profile: Remove support for Cancel method
Date: Tue, 10 Sep 2013 11:42:23 -0500
Message-Id: <1378831343-3534-3-git-send-email-denkenz@gmail.com>
In-Reply-To: <1378831343-3534-1-git-send-email-denkenz@gmail.com>
References: <1378831343-3534-1-git-send-email-denkenz@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

---
 src/profile.c | 18 ------------------
 1 file changed, 18 deletions(-)

diff --git a/src/profile.c b/src/profile.c
index 57aead7..523e119 100644
--- a/src/profile.c
+++ b/src/profile.c
@@ -678,20 +678,9 @@ static struct ext_profile *find_ext_profile(const char *owner,
 	return NULL;
 }
 
-static void ext_cancel(struct ext_profile *ext)
-{
-	DBusMessage *msg;
-
-	msg = dbus_message_new_method_call(ext->owner, ext->path,
-						"org.bluez.Profile1", "Cancel");
-	if (msg)
-		g_dbus_send_message(btd_get_dbus_connection(), msg);
-}
-
 static void ext_io_destroy(gpointer p)
 {
 	struct ext_io *ext_io = p;
-	struct ext_profile *ext = ext_io->ext;
 
 	if (ext_io->io_id > 0)
 		g_source_remove(ext_io->io_id);
@@ -711,7 +700,6 @@ static void ext_io_destroy(gpointer p)
 	if (ext_io->pending) {
 		dbus_pending_call_cancel(ext_io->pending);
 		dbus_pending_call_unref(ext_io->pending);
-		ext_cancel(ext);
 	}
 
 	if (ext_io->resolving)
@@ -783,9 +771,6 @@ static void new_conn_reply(DBusPendingCall *call, void *user_data)
 
 	btd_service_connecting_complete(conn->service, -ECONNREFUSED);
 
-	if (dbus_error_has_name(&err, DBUS_ERROR_NO_REPLY))
-		ext_cancel(ext);
-
 	dbus_error_free(&err);
 
 	ext->conns = g_slist_remove(ext->conns, conn);
@@ -817,9 +802,6 @@ static void disconn_reply(DBusPendingCall *call, void *user_data)
 
 	btd_service_disconnecting_complete(conn->service, -ECONNREFUSED);
 
-	if (dbus_error_has_name(&err, DBUS_ERROR_NO_REPLY))
-		ext_cancel(ext);
-
 	dbus_error_free(&err);
 
 disconnect:
-- 
1.8.1.5

