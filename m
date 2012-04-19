Return-Path: <cyrus@holtmann.org>
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH obexd 3/6] client: transfer api merges put and get
Date: Thu, 19 Apr 2012 17:06:25 +0300
Message-Id: <1334844388-7121-3-git-send-email-luiz.dentz@gmail.com>
In-Reply-To: <1334844388-7121-1-git-send-email-luiz.dentz@gmail.com>
References: <1334844388-7121-1-git-send-email-luiz.dentz@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

From: Mikel Astiz <mikel.astiz@bmw-carit.de>

A new enum type is used to distinguish put and get transfers.

This is more convenient since it is done when registering the transfer,
and not when it is actually started. The main benefits would be:
    - Some actions can be taken during creation, such as opening files.
    - session.c gets simplified.
    - The size of a put transfer can be exposed in D-Bus, while queued.
    - The transfer operation (put or get) can be exposed in D-Bus.

None of these D-Bus changes are included in this patch.
---
 client/session.c  |   67 ++++++++++++++++------------------------------------
 client/transfer.c |   53 ++++++++++++++++++++++++++++++-----------
 client/transfer.h |    5 ++-
 3 files changed, 63 insertions(+), 62 deletions(-)

diff --git a/client/session.c b/client/session.c
index 1638a18..0b15299 100644
--- a/client/session.c
+++ b/client/session.c
@@ -100,7 +100,7 @@ struct obc_session {
 
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
+		if (obc_transfer_get_operation(transfer) == G_OBEX_OP_GET)
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
@@ -917,19 +917,15 @@ fail:
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
 
@@ -961,8 +957,9 @@ int obc_session_get(struct obc_session *session, const char *type,
 		agent = NULL;
 
 	transfer = obc_transfer_register(session->conn, session->obex,
-							agent, targetfile,
-							name, type, params);
+						agent, G_OBEX_OP_GET,
+						targetfile, name,
+						type, params);
 	if (transfer == NULL) {
 		if (params != NULL) {
 			g_free(params->data);
@@ -971,8 +968,7 @@ int obc_session_get(struct obc_session *session, const char *type,
 		return -EIO;
 	}
 
-	return session_request(session, transfer, session_prepare_get,
-							func, user_data);
+	return session_request(session, transfer, func, user_data);
 }
 
 int obc_session_send(struct obc_session *session, const char *filename,
@@ -988,8 +984,9 @@ int obc_session_send(struct obc_session *session, const char *filename,
 	agent = obc_agent_get_name(session->agent);
 
 	transfer = obc_transfer_register(session->conn, session->obex,
-							agent, filename,
-							name, NULL, NULL);
+						agent, G_OBEX_OP_PUT,
+						filename, name,
+						NULL, NULL);
 	if (transfer == NULL)
 		return -EINVAL;
 
@@ -999,8 +996,7 @@ int obc_session_send(struct obc_session *session, const char *filename,
 		return err;
 	}
 
-	return session_request(session, transfer, session_prepare_put,
-								NULL, NULL);
+	return session_request(session, transfer, NULL, NULL);
 }
 
 int obc_session_pull(struct obc_session *session,
@@ -1041,26 +1037,6 @@ fail:
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
 int obc_session_put(struct obc_session *session, const char *contents,
 					size_t size, const char *name)
 {
@@ -1074,9 +1050,9 @@ int obc_session_put(struct obc_session *session, const char *contents,
 	agent = obc_agent_get_name(session->agent);
 
 	transfer = obc_transfer_register(session->conn, session->obex,
-							agent, NULL,
-							name, NULL,
-							NULL);
+							agent, G_OBEX_OP_PUT,
+							NULL, name,
+							NULL, NULL);
 	if (transfer == NULL)
 		return -EIO;
 
@@ -1086,8 +1062,7 @@ int obc_session_put(struct obc_session *session, const char *contents,
 		return err;
 	}
 
-	return session_request(session, transfer, session_prepare_put, NULL,
-									NULL);
+	return session_request(session, transfer, NULL, NULL);
 }
 
 static void agent_destroy(gpointer data, gpointer user_data)
diff --git a/client/transfer.c b/client/transfer.c
index a40f849..adc4289 100644
--- a/client/transfer.c
+++ b/client/transfer.c
@@ -55,6 +55,7 @@ struct transfer_callback {
 
 struct obc_transfer {
 	GObex *obex;
+	guint8 op;
 	struct obc_transfer_params *params;
 	struct transfer_callback *callback;
 	DBusConnection *conn;
@@ -221,6 +222,7 @@ static void obc_transfer_free(struct obc_transfer *transfer)
 struct obc_transfer *obc_transfer_register(DBusConnection *conn,
 						GObex *obex,
 						const char *agent,
+						guint8 op,
 						const char *filename,
 						const char *name,
 						const char *type,
@@ -230,6 +232,7 @@ struct obc_transfer *obc_transfer_register(DBusConnection *conn,
 
 	transfer = g_new0(struct obc_transfer, 1);
 	transfer->obex = g_obex_ref(obex);
+	transfer->op = op;
 	transfer->agent = g_strdup(agent);
 	transfer->filename = g_strdup(filename);
 	transfer->name = g_strdup(name);
@@ -442,14 +445,16 @@ done:
 	return fd;
 }
 
-int obc_transfer_get(struct obc_transfer *transfer)
+static gboolean transfer_start_get(struct obc_transfer *transfer, GError **err)
 {
-	GError *err = NULL;
 	GObexPacket *req;
 	int perr;
 
-	if (transfer->xfer != 0)
-		return -EALREADY;
+	if (transfer->xfer > 0) {
+		g_set_error(err, OBC_TRANSFER_ERROR, -EALREADY,
+						"Transfer already started");
+		return FALSE;
+	}
 
 	perr = transfer_open(transfer, O_WRONLY | O_CREAT, 0600);
 	if (perr < 0)
@@ -472,20 +477,22 @@ int obc_transfer_get(struct obc_transfer *transfer)
 
 	transfer->xfer = g_obex_send_req(transfer->obex, req, -1,
 						get_xfer_progress_first,
-						transfer, &err);
+						transfer, err);
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
 
-	if (transfer->xfer != 0)
-		return -EALREADY;
+	if (transfer->xfer > 0) {
+		g_set_error(err, OBC_TRANSFER_ERROR, -EALREADY,
+						"Transfer already started");
+		return FALSE;
+	}
 
 	req = g_obex_packet_new(G_OBEX_OP_PUT, FALSE, G_OBEX_HDR_INVALID);
 
@@ -507,11 +514,29 @@ int obc_transfer_put(struct obc_transfer *transfer)
 
 	transfer->xfer = g_obex_put_req_pkt(transfer->obex, req,
 					put_xfer_progress, xfer_complete,
-					transfer, &err);
+					transfer, err);
 	if (transfer->xfer == 0)
-		return -ENOTCONN;
+		return FALSE;
 
-	return 0;
+	return TRUE;
+}
+
+gboolean obc_transfer_start(struct obc_transfer *transfer, GError **err)
+{
+	switch (transfer->op) {
+	case G_OBEX_OP_GET:
+		return transfer_start_get(transfer, err);
+	case G_OBEX_OP_PUT:
+		return transfer_start_put(transfer, err);
+	}
+
+	g_set_error(err, OBC_TRANSFER_ERROR, -ENOTSUP, "Not supported");
+	return FALSE;
+}
+
+guint8 obc_transfer_get_operation(struct obc_transfer *transfer)
+{
+	return transfer->op;
 }
 
 int obc_transfer_get_params(struct obc_transfer *transfer,
diff --git a/client/transfer.h b/client/transfer.h
index a65981c..7858423 100644
--- a/client/transfer.h
+++ b/client/transfer.h
@@ -35,6 +35,7 @@ typedef void (*transfer_callback_t) (struct obc_transfer *transfer,
 struct obc_transfer *obc_transfer_register(DBusConnection *conn,
 					GObex *obex,
 					const char *agent,
+					guint8 op,
 					const char *filename,
 					const char *name,
 					const char *type,
@@ -46,8 +47,8 @@ gboolean obc_transfer_set_callback(struct obc_transfer *transfer,
 					transfer_callback_t func,
 					void *user_data);
 
-int obc_transfer_get(struct obc_transfer *transfer);
-int obc_transfer_put(struct obc_transfer *transfer);
+gboolean obc_transfer_start(struct obc_transfer *transfer, GError **err);
+guint8 obc_transfer_get_operation(struct obc_transfer *transfer);
 
 int obc_transfer_get_params(struct obc_transfer *transfer,
 					struct obc_transfer_params *params);
-- 
1.7.7.6

