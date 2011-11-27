Return-Path: <cyrus@holtmann.org>
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH obexd 3/6 v2] Fix calling getpeername directly on manager.c
Date: Sun, 27 Nov 2011 23:12:08 +0200
Message-Id: <1322428331-28204-3-git-send-email-luiz.dentz@gmail.com>
In-Reply-To: <1322428331-28204-1-git-send-email-luiz.dentz@gmail.com>
References: <1322428331-28204-1-git-send-email-luiz.dentz@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

From: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>

Manager should be transport agnostic and not pretend the transport is
always RFCOMM since in future this might not be true even for Bluetooth.
---
 src/manager.c |   34 +++++++++++-----------------------
 src/obex.c    |   10 ++++++++++
 src/obex.h    |    1 +
 3 files changed, 22 insertions(+), 23 deletions(-)

diff --git a/src/manager.c b/src/manager.c
index 3953e9d..b151a21 100644
--- a/src/manager.c
+++ b/src/manager.c
@@ -31,9 +31,7 @@
 #include <errno.h>
 #include <gdbus.h>
 #include <sys/socket.h>
-
-#include <bluetooth/bluetooth.h>
-#include <bluetooth/rfcomm.h>
+#include <inttypes.h>
 
 #include <openobex/obex.h>
 
@@ -521,16 +519,12 @@ int manager_request_authorization(struct obex_session *os, int32_t time,
 {
 	DBusMessage *msg;
 	DBusPendingCall *call;
-	GIOChannel *io;
-	struct sockaddr_rc addr;
-	socklen_t addrlen;
-	char address[18];
-	const char *bda = address;
 	const char *filename = os->name ? os->name : "";
 	const char *type = os->type ? os->type : "";
-	char *path;
-	unsigned int watch, fd;
+	char *path, *address;
+	unsigned int watch;
 	gboolean got_reply;
+	int err;
 
 	if (!agent)
 		return -1;
@@ -541,23 +535,18 @@ int manager_request_authorization(struct obex_session *os, int32_t time,
 	if (!new_folder || !new_name)
 		return -EINVAL;
 
-	memset(&addr, 0, sizeof(addr));
-	addrlen = sizeof(addr);
-
-	fd = OBEX_GetFD(os->obex);
-	if (getpeername(fd, (struct sockaddr *) &addr, &addrlen) < 0)
-		return -errno;
-
-	ba2str(&addr.rc_bdaddr, address);
+	err = obex_getpeername(os, &address);
+	if (err < 0)
+		return err;
 
-	path = g_strdup_printf("/transfer%d", os->cid);
+	path = g_strdup_printf("/transfer%u", GPOINTER_TO_UINT(os));
 
 	msg = dbus_message_new_method_call(agent->bus_name, agent->path,
 					"org.openobex.Agent", "Authorize");
 
 	dbus_message_append_args(msg,
 			DBUS_TYPE_OBJECT_PATH, &path,
-			DBUS_TYPE_STRING, &bda,
+			DBUS_TYPE_STRING, &address,
 			DBUS_TYPE_STRING, &filename,
 			DBUS_TYPE_STRING, &type,
 			DBUS_TYPE_INT32, &os->size,
@@ -565,6 +554,7 @@ int manager_request_authorization(struct obex_session *os, int32_t time,
 			DBUS_TYPE_INVALID);
 
 	g_free(path);
+	g_free(address);
 
 	if (!dbus_connection_send_with_reply(connection,
 					msg, &call, TIMEOUT)) {
@@ -578,11 +568,9 @@ int manager_request_authorization(struct obex_session *os, int32_t time,
 	got_reply = FALSE;
 
 	/* Catches errors before authorization response comes */
-	io = g_io_channel_unix_new(fd);
-	watch = g_io_add_watch_full(io, G_PRIORITY_DEFAULT,
+	watch = g_io_add_watch_full(os->io, G_PRIORITY_DEFAULT,
 			G_IO_HUP | G_IO_ERR | G_IO_NVAL,
 			auth_error, NULL, NULL);
-	g_io_channel_unref(io);
 
 	dbus_pending_call_set_notify(call, agent_reply, &got_reply, NULL);
 
diff --git a/src/obex.c b/src/obex.c
index 7d8d0e8..7f31c5d 100644
--- a/src/obex.c
+++ b/src/obex.c
@@ -1556,6 +1556,16 @@ ssize_t obex_get_non_header_data(struct obex_session *os,
 	return os->nonhdr_len;
 }
 
+int obex_getpeername(struct obex_session *os, char **name)
+{
+	struct obex_transport_driver *transport = os->server->transport;
+
+	if (transport == NULL || transport->getpeername == NULL)
+		return -ENOTSUP;
+
+	return transport->getpeername(os->io, name);
+}
+
 int memncmp0(const void *a, size_t na, const void *b, size_t nb)
 {
 	if (na != nb)
diff --git a/src/obex.h b/src/obex.h
index 3e8ce00..3ec49a9 100644
--- a/src/obex.h
+++ b/src/obex.h
@@ -50,6 +50,7 @@ char *obex_get_id(struct obex_session *os);
 ssize_t obex_get_apparam(struct obex_session *os, const uint8_t **buffer);
 ssize_t obex_get_non_header_data(struct obex_session *os,
 							const uint8_t **data);
+int obex_getpeername(struct obex_session *os, char **name);
 
 /* Just a thin wrapper around memcmp to deal with NULL values */
 int memncmp0(const void *a, size_t na, const void *b, size_t nb);
-- 
1.7.7.3

