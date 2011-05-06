Return-Path: <cyrus@holtmann.org>
Subject: [obexd] GCC 4.6 warning fixes
From: Bastien Nocera <hadess@hadess.net>
To: BlueZ development <linux-bluetooth@vger.kernel.org>
Date: Fri, 06 May 2011 15:57:07 +0100
Content-Type: multipart/mixed; boundary="=-uC/bGaMeWw1rDJO8grfs"
Message-ID: <1304693827.16101.36.camel@novo.hadess.net>
Mime-Version: 1.0
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>


--=-uC/bGaMeWw1rDJO8grfs
Content-Type: text/plain
Content-Transfer-Encoding: 7bit

As for bluez.

--=-uC/bGaMeWw1rDJO8grfs
Content-Disposition: attachment;
	filename="0001-Fix-GCC-4.6-warnings-about-unused-variables.patch"
Content-Type: text/x-patch;
	name="0001-Fix-GCC-4.6-warnings-about-unused-variables.patch";
	charset="ISO-8859-1"
Content-Transfer-Encoding: 7bit

>From cc010c73caa98195f62340dc28e4f705dfd191d0 Mon Sep 17 00:00:00 2001
From: Bastien Nocera <hadess@hadess.net>
Date: Fri, 6 May 2011 15:50:31 +0100
Subject: [PATCH] Fix GCC 4.6 warnings about unused variables

---
 btio/btio.c      |    4 ++++
 client/session.c |    3 ---
 gdbus/object.c   |    3 +--
 3 files changed, 5 insertions(+), 5 deletions(-)

diff --git a/btio/btio.c b/btio/btio.c
index 8b273ca..1d8101a 100644
--- a/btio/btio.c
+++ b/btio/btio.c
@@ -1067,6 +1067,10 @@ gboolean bt_io_accept(GIOChannel *io, BtIOConnect connect, gpointer user_data,
 	if (!(pfd.revents & POLLOUT)) {
 		int ret;
 		ret = read(sock, &c, 1);
+		if (ret < 0) {
+			ERROR_FAILED(err, "read", errno);
+			return FALSE;
+		}
 	}
 
 	accept_add(io, connect, user_data, destroy);
diff --git a/client/session.c b/client/session.c
index 88eae8d..ceda3f4 100644
--- a/client/session.c
+++ b/client/session.c
@@ -516,10 +516,7 @@ struct session_data *session_create(const char *source,
 
 void session_shutdown(struct session_data *session)
 {
-	struct transfer_data *transfer;
-
 	DBG("%p", session);
-	transfer = session->pending ? session->pending->data : NULL;
 
 	session_ref(session);
 
diff --git a/gdbus/object.c b/gdbus/object.c
index eaa2e1a..d17a101 100644
--- a/gdbus/object.c
+++ b/gdbus/object.c
@@ -255,14 +255,13 @@ void g_dbus_pending_success(DBusConnection *connection,
 
         for (list = pending_security; list; list = list->next) {
 		struct security_data *secdata = list->data;
-		DBusHandlerResult result;
 
 		if (secdata->pending != pending)
 			continue;
 
 		pending_security = g_slist_remove(pending_security, secdata);
 
-		result = process_message(connection, secdata->message,
+		process_message(connection, secdata->message,
 				secdata->method, secdata->iface_user_data);
 
 		dbus_message_unref(secdata->message);
-- 
1.7.5


--=-uC/bGaMeWw1rDJO8grfs--

