Return-Path: <cyrus@holtmann.org>
From: Mikel Astiz <mikel.astiz.oss@gmail.com>
To: linux-bluetooth@vger.kernel.org
Cc: Mikel Astiz <mikel.astiz@bmw-carit.de>
Subject: [PATCH obexd v0 05/11] client: transfer api merges put and get
Date: Mon, 12 Mar 2012 14:32:39 +0100
Message-Id: <1331559165-28367-6-git-send-email-mikel.astiz.oss@gmail.com>
In-Reply-To: <1331559165-28367-1-git-send-email-mikel.astiz.oss@gmail.com>
References: <1331559165-28367-1-git-send-email-mikel.astiz.oss@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

From: Mikel Astiz <mikel.astiz@bmw-carit.de>

A new enum type is used to distinguish put and get transfers.

This is more convenient since it is done when registering the transfer,
and not when it is actually started. The main benefits would be:
    - Some actions can be taken during creation, such as opening files.
    - session.c gets simplified.
    - The size of a put transfer can be exposed in D-Bus, while queued.
    - The type of transfer (put or get) can be exposed in D-Bus.

None of these D-Bus changes are included in this patch.
---
 client/session.c  |   69 +++++++++++++++++------------------------------------
 client/transfer.c |   59 +++++++++++++++++++++++++++++++++------------
 client/transfer.h |   10 ++++++-
 3 files changed, 73 insertions(+), 65 deletions(-)

diff --git a/client/session.c b/client/session.c
index c597bac..79717cb 100644
--- a/client/session.c
+++ b/client/session.c
@@ -103,7 +103,7 @@ struct obc_session {
 
 static GSList *sessions = NULL;
 
-static void session_prepare_put(gpointer data, gpointer user_data);
+static void session_start_transfer(gpointer data, gpointer user_data);
 static void session_terminate_transfer(struct obc_session *session,
 					struct obc_transfer *transfer,
 					GError *gerr);
@@ -686,7 +686,7 @@ static void session_request_reply(DBusPendingCall *call, gpointer user_data)
 	DBG("Agent.Request() reply: %s", name);
 
 	if (strlen(name)) {
-		if (p->auth_complete == session_prepare_put)
+		if (obc_transfer_get_dir(transfer) == OBC_TRANSFER_PUT)
 			obc_transfer_set_name(transfer, name);
 		else
 			obc_transfer_set_filename(transfer, name);
@@ -731,7 +731,6 @@ static int pending_request_auth(struct pending_request *p)
 
 static int session_request(struct obc_session *session,
 					struct obc_transfer *transfer,
-					GFunc auth_complete,
 					session_callback_t func,
 					void *data)
 {
@@ -740,7 +739,8 @@ static int session_request(struct obc_session *session,
 
 	obc_transfer_set_callback(transfer, transfer_progress, session);
 
-	p = pending_request_new(session, transfer, auth_complete, func, data);
+	p = pending_request_new(session, transfer, session_start_transfer,
+								func, data);
 
 	if (session->p) {
 		g_queue_push_tail(session->queue, p);
@@ -915,19 +915,15 @@ fail:
 	session_notify_error(session, transfer, err);
 }
 
-static void session_prepare_get(gpointer data, gpointer user_data)
+static void session_start_transfer(gpointer data, gpointer user_data)
 {
 	struct obc_session *session = data;
 	struct obc_transfer *transfer = user_data;
-	int ret;
+	GError *err = NULL;
 
-	ret = obc_transfer_get(transfer);
-	if (ret < 0) {
-		GError *gerr = NULL;
-
-		g_set_error(&gerr, OBEX_IO_ERROR, ret, "%s", strerror(-ret));
-		session_notify_error(session, transfer, gerr);
-		g_clear_error(&gerr);
+	if (!obc_transfer_start(transfer, &err)) {
+		session_notify_error(session, transfer, err);
+		g_clear_error(&err);
 		return;
 	}
 
@@ -959,8 +955,10 @@ int obc_session_get(struct obc_session *session, const char *type,
 		agent = NULL;
 
 	transfer = obc_transfer_register(session->conn, session->obex,
-							agent, targetfile,
-							name, type, params);
+							agent,
+							OBC_TRANSFER_GET,
+							targetfile, name, type,
+							params);
 	if (transfer == NULL) {
 		if (params != NULL) {
 			g_free(params->data);
@@ -969,8 +967,7 @@ int obc_session_get(struct obc_session *session, const char *type,
 		return -EIO;
 	}
 
-	return session_request(session, transfer, session_prepare_get,
-							func, user_data);
+	return session_request(session, transfer, func, user_data);
 }
 
 int obc_session_send(struct obc_session *session, const char *filename,
@@ -985,8 +982,9 @@ int obc_session_send(struct obc_session *session, const char *filename,
 
 	agent = obc_agent_get_name(session->agent);
 
-	transfer = obc_transfer_register(session->conn, session->obex,
-							agent, filename,
+	transfer = obc_transfer_register(session->conn, session->obex, agent,
+							OBC_TRANSFER_PUT,
+							filename,
 							name, NULL, NULL);
 	if (transfer == NULL)
 		return -EINVAL;
@@ -997,8 +995,7 @@ int obc_session_send(struct obc_session *session, const char *filename,
 		return err;
 	}
 
-	return session_request(session, transfer, session_prepare_put,
-								NULL, NULL);
+	return session_request(session, transfer, NULL, NULL);
 }
 
 int obc_session_pull(struct obc_session *session,
@@ -1039,26 +1036,6 @@ fail:
 	return NULL;
 }
 
-static void session_prepare_put(gpointer data, gpointer user_data)
-{
-	struct obc_session *session = data;
-	struct obc_transfer *transfer = user_data;
-	int ret;
-
-	ret = obc_transfer_put(transfer);
-	if (ret < 0) {
-		GError *gerr = NULL;
-
-		g_set_error(&gerr, OBEX_IO_ERROR, ret, "%s (%d)",
-							strerror(-ret), -ret);
-		session_notify_error(session, transfer, gerr);
-		g_clear_error(&gerr);
-		return;
-	}
-
-	DBG("Transfer(%p) started", transfer);
-}
-
 int obc_session_put(struct obc_session *session, char *buf, const char *name)
 {
 	struct obc_transfer *transfer;
@@ -1071,10 +1048,9 @@ int obc_session_put(struct obc_session *session, char *buf, const char *name)
 
 	agent = obc_agent_get_name(session->agent);
 
-	transfer = obc_transfer_register(session->conn, session->obex,
-							agent, NULL,
-							name, NULL,
-							NULL);
+	transfer = obc_transfer_register(session->conn, session->obex, agent,
+							OBC_TRANSFER_PUT,
+							name, NULL, NULL, NULL);
 	if (transfer == NULL) {
 		g_free(buf);
 		return -EIO;
@@ -1082,8 +1058,7 @@ int obc_session_put(struct obc_session *session, char *buf, const char *name)
 
 	obc_transfer_set_buffer(transfer, buf);
 
-	return session_request(session, transfer, session_prepare_put,
-								NULL, NULL);
+	return session_request(session, transfer, NULL, NULL);
 }
 
 static void agent_destroy(gpointer data, gpointer user_data)
diff --git a/client/transfer.c b/client/transfer.c
index bc896f8..e491f03 100644
--- a/client/transfer.c
+++ b/client/transfer.c
@@ -55,6 +55,7 @@ struct transfer_callback {
 
 struct obc_transfer {
 	GObex *obex;
+	ObcTransferDirection direction; /* Put or Get */
 	struct obc_transfer_params *params;
 	struct transfer_callback *callback;
 	DBusConnection *conn;
@@ -257,6 +258,7 @@ static void obc_transfer_free(struct obc_transfer *transfer)
 struct obc_transfer *obc_transfer_register(DBusConnection *conn,
 						GObex *obex,
 						const char *agent,
+						ObcTransferDirection dir,
 						const char *filename,
 						const char *name,
 						const char *type,
@@ -266,6 +268,7 @@ struct obc_transfer *obc_transfer_register(DBusConnection *conn,
 
 	transfer = g_new0(struct obc_transfer, 1);
 	transfer->obex = g_obex_ref(obex);
+	transfer->direction = dir;
 	transfer->agent = g_strdup(agent);
 	transfer->filename = g_strdup(filename);
 	transfer->name = g_strdup(name);
@@ -518,16 +521,18 @@ gboolean obc_transfer_set_callback(struct obc_transfer *transfer,
 	return TRUE;
 }
 
-int obc_transfer_get(struct obc_transfer *transfer)
+static gboolean transfer_start_get(struct obc_transfer *transfer, GError **err)
 {
-	GError *err = NULL;
 	GObexPacket *req;
 	GObexDataConsumer data_cb;
 	GObexFunc complete_cb;
 	GObexResponseFunc rsp_cb = NULL;
 
-	if (transfer->xfer != 0)
-		return -EALREADY;
+	if (transfer->xfer > 0) {
+		g_set_error(err, OBC_TRANSFER_ERROR, -EALREADY,
+						"Transfer already started");
+		return FALSE;
+	}
 
 	if (transfer->type != NULL &&
 			(strncmp(transfer->type, "x-obex/", 7) == 0 ||
@@ -538,7 +543,9 @@ int obc_transfer_get(struct obc_transfer *transfer)
 				O_WRONLY | O_CREAT, 0600);
 		if (fd < 0) {
 			error("open(): %s(%d)", strerror(errno), errno);
-			return -errno;
+			g_set_error(err, OBC_TRANSFER_ERROR, -EIO,
+							"Cannot open file");
+			return FALSE;
 		}
 		transfer->fd = fd;
 		data_cb = get_xfer_progress;
@@ -562,26 +569,28 @@ int obc_transfer_get(struct obc_transfer *transfer)
 
 	if (rsp_cb)
 		transfer->xfer = g_obex_send_req(transfer->obex, req, -1,
-						rsp_cb, transfer, &err);
+						rsp_cb, transfer, err);
 	else
 		transfer->xfer = g_obex_get_req_pkt(transfer->obex, req,
 						data_cb, complete_cb, transfer,
-						&err);
+						err);
 
 	if (transfer->xfer == 0)
-		return -ENOTCONN;
+		return FALSE;
 
-	return 0;
+	return TRUE;
 }
 
-int obc_transfer_put(struct obc_transfer *transfer)
+static gboolean transfer_start_put(struct obc_transfer *transfer, GError **err)
 {
-	GError *err = NULL;
 	GObexPacket *req;
 	GObexDataProducer data_cb;
 
-	if (transfer->xfer != 0)
-		return -EALREADY;
+	if (transfer->xfer > 0) {
+		g_set_error(err, OBC_TRANSFER_ERROR, -EALREADY,
+						"Transfer already started");
+		return FALSE;
+	}
 
 	if (transfer->buffer) {
 		data_cb = put_buf_xfer_progress;
@@ -611,11 +620,29 @@ done:
 
 	transfer->xfer = g_obex_put_req_pkt(transfer->obex, req, data_cb,
 						xfer_complete, transfer,
-						&err);
+						err);
 	if (transfer->xfer == 0)
-		return -ENOTCONN;
+		return FALSE;
 
-	return 0;
+	return TRUE;
+}
+
+gboolean obc_transfer_start(struct obc_transfer *transfer, GError **err)
+{
+	switch (transfer->direction) {
+	case OBC_TRANSFER_GET:
+		return transfer_start_get(transfer, err);
+	case OBC_TRANSFER_PUT:
+		return transfer_start_put(transfer, err);
+	}
+
+	g_set_error(err, OBC_TRANSFER_ERROR, -ENOTSUP, "Not supported");
+	return FALSE;
+}
+
+ObcTransferDirection obc_transfer_get_dir(struct obc_transfer *transfer)
+{
+	return transfer->direction;
 }
 
 const void *obc_transfer_get_params(struct obc_transfer *transfer, size_t *size)
diff --git a/client/transfer.h b/client/transfer.h
index c399129..3594ce4 100644
--- a/client/transfer.h
+++ b/client/transfer.h
@@ -21,6 +21,11 @@
  *
  */
 
+typedef enum {
+	OBC_TRANSFER_GET,
+	OBC_TRANSFER_PUT
+} ObcTransferDirection;
+
 struct obc_transfer_params {
 	void *data;
 	size_t size;
@@ -35,6 +40,7 @@ typedef void (*transfer_callback_t) (struct obc_transfer *transfer,
 struct obc_transfer *obc_transfer_register(DBusConnection *conn,
 					GObex *obex,
 					const char *agent,
+					ObcTransferDirection dir,
 					const char *filename,
 					const char *name,
 					const char *type,
@@ -46,9 +52,9 @@ gboolean obc_transfer_set_callback(struct obc_transfer *transfer,
 					transfer_callback_t func,
 					void *user_data);
 
-int obc_transfer_get(struct obc_transfer *transfer);
-int obc_transfer_put(struct obc_transfer *transfer);
+gboolean obc_transfer_start(struct obc_transfer *transfer, GError **err);
 
+ObcTransferDirection obc_transfer_get_dir(struct obc_transfer *transfer);
 const void *obc_transfer_get_params(struct obc_transfer *transfer,
 								size_t *size);
 const void *obc_transfer_get_buffer(struct obc_transfer *transfer,
-- 
1.7.7.6

