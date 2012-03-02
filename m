Return-Path: <cyrus@holtmann.org>
From: Mikel Astiz <mikel.astiz.oss@gmail.com>
To: linux-bluetooth@vger.kernel.org
Cc: Mikel Astiz <mikel.astiz@bmw-carit.de>
Subject: [PATCH obexd 1/3] client: fix naming convention in transfer api
Date: Fri,  2 Mar 2012 13:41:25 +0100
Message-Id: <1330692087-13021-2-git-send-email-mikel.astiz.oss@gmail.com>
In-Reply-To: <1330692087-13021-1-git-send-email-mikel.astiz.oss@gmail.com>
References: <1330692087-13021-1-git-send-email-mikel.astiz.oss@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

From: Mikel Astiz <mikel.astiz@bmw-carit.de>

The terms can be quite misleading, so this patch proposes to follow the
terminology in the D-Bus api:
       - Name: the remote name of the object being transferred
       - Filename: the name of the file in local the filesystem

Both values can be NULL independently.

This also fixes the problem of using the terms differently in get and
put operations. The result was that the properties "Name" and "Filename"
were swapped in D-Bus in the case of get.
---
 client/session.c  |   21 ++++++++++-----------
 client/transfer.c |   14 +++++++-------
 client/transfer.h |    3 ++-
 3 files changed, 19 insertions(+), 19 deletions(-)

diff --git a/client/session.c b/client/session.c
index 57a5b06..06022b5 100644
--- a/client/session.c
+++ b/client/session.c
@@ -659,7 +659,7 @@ static void session_request_reply(DBusPendingCall *call, gpointer user_data)
 	struct pending_request *p = session->p;
 	struct obc_transfer *transfer = p->transfer;
 	DBusMessage *reply = dbus_pending_call_steal_reply(call);
-	const char *name;
+	const char *filename;
 	DBusError derr;
 
 	dbus_error_init(&derr);
@@ -680,13 +680,13 @@ static void session_request_reply(DBusPendingCall *call, gpointer user_data)
 	}
 
 	dbus_message_get_args(reply, NULL,
-			DBUS_TYPE_STRING, &name,
+			DBUS_TYPE_STRING, &filename,
 			DBUS_TYPE_INVALID);
 
-	DBG("Agent.Request() reply: %s", name);
+	DBG("Agent.Request() reply: %s", filename);
 
-	if (strlen(name))
-		obc_transfer_set_name(transfer, name);
+	if (strlen(filename))
+		obc_transfer_set_filename(transfer, filename);
 
 	if (p->auth_complete)
 		p->auth_complete(session, transfer);
@@ -955,8 +955,8 @@ int obc_session_get(struct obc_session *session, const char *type,
 		agent = NULL;
 
 	transfer = obc_transfer_register(session->conn, session->obex,
-							agent, filename,
-							targetname, type,
+							agent, targetname,
+							filename, type,
 							params);
 	if (transfer == NULL) {
 		if (params != NULL) {
@@ -1015,8 +1015,8 @@ int obc_session_pull(struct obc_session *session,
 		agent = NULL;
 
 	transfer = obc_transfer_register(session->conn, session->obex,
-								agent, NULL,
-								filename, type,
+								agent, filename,
+								NULL, type,
 								NULL);
 	if (transfer == NULL) {
 		return -EIO;
@@ -1090,8 +1090,7 @@ int obc_session_put(struct obc_session *session, char *buf, const char *targetna
 
 	transfer = obc_transfer_register(session->conn, session->obex,
 							agent, NULL,
-							targetname, NULL,
-							NULL);
+							targetname, NULL, NULL);
 	if (transfer == NULL) {
 		g_free(buf);
 		return -EIO;
diff --git a/client/transfer.c b/client/transfer.c
index d1edef2..8049c25 100644
--- a/client/transfer.c
+++ b/client/transfer.c
@@ -526,9 +526,8 @@ int obc_transfer_get(struct obc_transfer *transfer)
 			strncmp(transfer->type, "x-bt/", 5) == 0)) {
 		rsp_cb = get_buf_xfer_progress;
 	} else {
-		int fd = open(transfer->name ? : transfer->filename,
+		int fd = open(transfer->filename ? : transfer->name,
 				O_WRONLY | O_CREAT, 0600);
-
 		if (fd < 0) {
 			error("open(): %s(%d)", strerror(errno), errno);
 			return -errno;
@@ -540,9 +539,9 @@ int obc_transfer_get(struct obc_transfer *transfer)
 
 	req = g_obex_packet_new(G_OBEX_OP_GET, TRUE, G_OBEX_HDR_INVALID);
 
-	if (transfer->filename != NULL)
+	if (transfer->name != NULL)
 		g_obex_packet_add_unicode(req, G_OBEX_HDR_NAME,
-							transfer->filename);
+							transfer->name);
 
 	if (transfer->type != NULL)
 		g_obex_packet_add_bytes(req, G_OBEX_HDR_TYPE, transfer->type,
@@ -639,10 +638,11 @@ void obc_transfer_set_buffer(struct obc_transfer *transfer, char *buffer)
 	transfer->buffer = buffer;
 }
 
-void obc_transfer_set_name(struct obc_transfer *transfer, const char *name)
+void obc_transfer_set_filename(struct obc_transfer *transfer,
+							const char *filename)
 {
-	g_free(transfer->name);
-	transfer->name = g_strdup(name);
+	g_free(transfer->filename);
+	transfer->filename = g_strdup(filename);
 }
 
 const char *obc_transfer_get_path(struct obc_transfer *transfer)
diff --git a/client/transfer.h b/client/transfer.h
index e7e1000..bb4acc4 100644
--- a/client/transfer.h
+++ b/client/transfer.h
@@ -55,7 +55,8 @@ const char *obc_transfer_get_buffer(struct obc_transfer *transfer, size_t *size)
 void obc_transfer_set_buffer(struct obc_transfer *transfer, char *buffer);
 void obc_transfer_clear_buffer(struct obc_transfer *transfer);
 
-void obc_transfer_set_name(struct obc_transfer *transfer, const char *name);
+void obc_transfer_set_filename(struct obc_transfer *transfer,
+							const char *filename);
 const char *obc_transfer_get_path(struct obc_transfer *transfer);
 gint64 obc_transfer_get_size(struct obc_transfer *transfer);
 int obc_transfer_set_file(struct obc_transfer *transfer);
-- 
1.7.6.5

