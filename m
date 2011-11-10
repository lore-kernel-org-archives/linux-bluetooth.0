Return-Path: <cyrus@holtmann.org>
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH obexd 8/9] gobex: fix sending Connection ID header in all requests
Date: Thu, 10 Nov 2011 16:43:57 +0200
Message-Id: <1320936238-28360-8-git-send-email-luiz.dentz@gmail.com>
In-Reply-To: <1320936238-28360-1-git-send-email-luiz.dentz@gmail.com>
References: <1320936238-28360-1-git-send-email-luiz.dentz@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

From: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>

According to both OBEX and GOEP specs Connection ID should only be
included in the first packet of a request.
---
 client/transfer.c      |    7 +++----
 gobex/gobex-transfer.c |   17 ++++++++++-------
 gobex/gobex.c          |   31 +++++++++++++++++++++----------
 gobex/gobex.h          |    6 +++---
 unit/test-gobex.c      |    6 +++---
 5 files changed, 40 insertions(+), 27 deletions(-)

diff --git a/client/transfer.c b/client/transfer.c
index b6994d1..d6d3e0d 100644
--- a/client/transfer.c
+++ b/client/transfer.c
@@ -375,9 +375,8 @@ static void get_buf_xfer_progress(GObex *obex, GError *err, GObexPacket *rsp,
 
 	req = g_obex_packet_new(G_OBEX_OP_GET, TRUE, G_OBEX_HDR_INVALID);
 
-	transfer->xfer = g_obex_send_req(obex, req, -1, get_buf_xfer_progress,
-							transfer, &err);
-
+	transfer->xfer = g_obex_send_req(obex, req, transfer->xfer, -1,
+				get_buf_xfer_progress, transfer, &err);
 	if (callback)
 		callback->func(transfer, transfer->transferred, err,
 							callback->data);
@@ -539,7 +538,7 @@ int obc_transfer_get(struct obc_transfer *transfer, transfer_callback_t func,
 						transfer->params->size);
 
 	if (rsp_cb)
-		transfer->xfer = g_obex_send_req(obex, req, -1, rsp_cb,
+		transfer->xfer = g_obex_send_req(obex, req, 0, -1, rsp_cb,
 							transfer, &err);
 	else
 		transfer->xfer = g_obex_get_req_pkt(obex, req, data_cb,
diff --git a/gobex/gobex-transfer.c b/gobex/gobex-transfer.c
index 6d2f7af..80e4781 100644
--- a/gobex/gobex-transfer.c
+++ b/gobex/gobex-transfer.c
@@ -121,7 +121,7 @@ static gssize put_get_data(void *buf, gsize len, gpointer user_data)
 		return ret;
 
 	req = g_obex_packet_new(G_OBEX_OP_ABORT, TRUE, G_OBEX_HDR_INVALID);
-	transfer->req_id = g_obex_send_req(transfer->obex, req, -1,
+	transfer->req_id = g_obex_send_req(transfer->obex, req, 0, -1,
 						transfer_abort_response,
 						transfer, &err);
 	if (err != NULL) {
@@ -161,9 +161,11 @@ static void transfer_response(GObex *obex, GError *err, GObexPacket *rsp,
 	struct transfer *transfer = user_data;
 	GObexPacket *req;
 	gboolean rspcode, final;
+	guint id;
 
 	g_obex_debug(G_OBEX_DEBUG_TRANSFER, "transfer %u", transfer->id);
 
+	id = transfer->req_id;
 	transfer->req_id = 0;
 
 	if (err != NULL) {
@@ -198,8 +200,9 @@ static void transfer_response(GObex *obex, GError *err, GObexPacket *rsp,
 							G_OBEX_HDR_INVALID);
 	}
 
-	transfer->req_id = g_obex_send_req(obex, req, -1, transfer_response,
-							transfer, &err);
+	transfer->req_id = g_obex_send_req(obex, req, id, -1,
+						transfer_response, transfer,
+						&err);
 failed:
 	if (err != NULL) {
 		g_obex_debug(G_OBEX_DEBUG_ERROR, "%s", err->message);
@@ -245,7 +248,7 @@ guint g_obex_put_req_pkt(GObex *obex, GObexPacket *req,
 
 	g_obex_packet_add_body(req, put_get_data, transfer);
 
-	transfer->req_id = g_obex_send_req(obex, req, FIRST_PACKET_TIMEOUT,
+	transfer->req_id = g_obex_send_req(obex, req, 0, FIRST_PACKET_TIMEOUT,
 					transfer_response, transfer, err);
 	if (transfer->req_id == 0) {
 		transfer_free(transfer);
@@ -277,7 +280,7 @@ guint g_obex_put_req(GObex *obex, GObexDataProducer data_func,
 
 	g_obex_packet_add_body(req, put_get_data, transfer);
 
-	transfer->req_id = g_obex_send_req(obex, req, FIRST_PACKET_TIMEOUT,
+	transfer->req_id = g_obex_send_req(obex, req, 0, FIRST_PACKET_TIMEOUT,
 					transfer_response, transfer, err);
 	if (transfer->req_id == 0) {
 		transfer_free(transfer);
@@ -426,7 +429,7 @@ guint g_obex_get_req_pkt(GObex *obex, GObexPacket *req,
 	transfer = transfer_new(obex, G_OBEX_OP_GET, complete_func, user_data);
 	transfer->data_consumer = data_func;
 
-	transfer->req_id = g_obex_send_req(obex, req, FIRST_PACKET_TIMEOUT,
+	transfer->req_id = g_obex_send_req(obex, req, 0, FIRST_PACKET_TIMEOUT,
 					transfer_response, transfer, err);
 	if (transfer->req_id == 0) {
 		transfer_free(transfer);
@@ -456,7 +459,7 @@ guint g_obex_get_req(GObex *obex, GObexDataConsumer data_func,
 							first_hdr_id, args);
 	va_end(args);
 
-	transfer->req_id = g_obex_send_req(obex, req, FIRST_PACKET_TIMEOUT,
+	transfer->req_id = g_obex_send_req(obex, req, 0, FIRST_PACKET_TIMEOUT,
 					transfer_response, transfer, err);
 	if (transfer->req_id == 0) {
 		transfer_free(transfer);
diff --git a/gobex/gobex.c b/gobex/gobex.c
index b0f3716..62d36da 100644
--- a/gobex/gobex.c
+++ b/gobex/gobex.c
@@ -397,19 +397,30 @@ gboolean g_obex_send(GObex *obex, GObexPacket *pkt, GError **err)
 	return ret;
 }
 
-guint g_obex_send_req(GObex *obex, GObexPacket *req, gint timeout,
-			GObexResponseFunc func, gpointer user_data,
-			GError **err)
+guint g_obex_send_req(GObex *obex, GObexPacket *req, guint req_id,
+			gint timeout, GObexResponseFunc func,
+			gpointer user_data, GError **err)
 {
 	GObexHeader *connid;
 	struct pending_pkt *p;
 	static guint id = 1;
 
-	g_obex_debug(G_OBEX_DEBUG_COMMAND, "conn %u", obex->conn_id);
+	g_obex_debug(G_OBEX_DEBUG_COMMAND, "conn %u req_id %u", obex->conn_id,
+								req_id);
 
 	if (obex->conn_id == CONNID_INVALID)
 		goto create_pending;
 
+	if (obex->pending_req && obex->pending_req->id == req_id)
+		goto create_pending;
+
+	if (req_id != 0) {
+		g_set_error(err, G_OBEX_ERROR, G_OBEX_ERROR_INVALID_ARGS,
+				"Invalid arguments");
+		g_obex_debug(G_OBEX_DEBUG_ERROR, "%s", (*err)->message);
+		return 0;
+	}
+
 	connid = g_obex_packet_get_header(req, G_OBEX_HDR_CONNECTION);
 	if (connid != NULL)
 		goto create_pending;
@@ -1076,7 +1087,7 @@ guint g_obex_connect(GObex *obex, GObexResponseFunc func, gpointer user_data,
 	init_connect_data(obex, &data);
 	g_obex_packet_set_data(req, &data, sizeof(data), G_OBEX_DATA_COPY);
 
-	return g_obex_send_req(obex, req, -1, func, user_data, err);
+	return g_obex_send_req(obex, req, 0, -1, func, user_data, err);
 }
 
 guint g_obex_setpath(GObex *obex, const char *path, GObexResponseFunc func,
@@ -1102,7 +1113,7 @@ guint g_obex_setpath(GObex *obex, const char *path, GObexResponseFunc func,
 
 	g_obex_packet_set_data(req, &data, sizeof(data), G_OBEX_DATA_COPY);
 
-	return g_obex_send_req(obex, req, -1, func, user_data, err);
+	return g_obex_send_req(obex, req, 0, -1, func, user_data, err);
 }
 
 guint g_obex_mkdir(GObex *obex, const char *path, GObexResponseFunc func,
@@ -1119,7 +1130,7 @@ guint g_obex_mkdir(GObex *obex, const char *path, GObexResponseFunc func,
 	memset(&data, 0, sizeof(data));
 	g_obex_packet_set_data(req, &data, sizeof(data), G_OBEX_DATA_COPY);
 
-	return g_obex_send_req(obex, req, -1, func, user_data, err);
+	return g_obex_send_req(obex, req, 0, -1, func, user_data, err);
 }
 
 guint g_obex_delete(GObex *obex, const char *name, GObexResponseFunc func,
@@ -1132,7 +1143,7 @@ guint g_obex_delete(GObex *obex, const char *name, GObexResponseFunc func,
 	req = g_obex_packet_new(G_OBEX_OP_PUT, TRUE, G_OBEX_HDR_NAME, name,
 							G_OBEX_HDR_INVALID);
 
-	return g_obex_send_req(obex, req, -1, func, user_data, err);
+	return g_obex_send_req(obex, req, 0, -1, func, user_data, err);
 }
 
 guint g_obex_copy(GObex *obex, const char *name, const char *dest,
@@ -1149,7 +1160,7 @@ guint g_obex_copy(GObex *obex, const char *name, const char *dest,
 					G_OBEX_HDR_DESTNAME, dest,
 					G_OBEX_HDR_INVALID);
 
-	return g_obex_send_req(obex, req, -1, func, user_data, err);
+	return g_obex_send_req(obex, req, 0, -1, func, user_data, err);
 }
 
 guint g_obex_move(GObex *obex, const char *name, const char *dest,
@@ -1166,5 +1177,5 @@ guint g_obex_move(GObex *obex, const char *name, const char *dest,
 					G_OBEX_HDR_DESTNAME, dest,
 					G_OBEX_HDR_INVALID);
 
-	return g_obex_send_req(obex, req, -1, func, user_data, err);
+	return g_obex_send_req(obex, req, 0, -1, func, user_data, err);
 }
diff --git a/gobex/gobex.h b/gobex/gobex.h
index 1b20333..9c45817 100644
--- a/gobex/gobex.h
+++ b/gobex/gobex.h
@@ -43,9 +43,9 @@ typedef void (*GObexResponseFunc) (GObex *obex, GError *err, GObexPacket *rsp,
 
 gboolean g_obex_send(GObex *obex, GObexPacket *pkt, GError **err);
 
-guint g_obex_send_req(GObex *obex, GObexPacket *req, gint timeout,
-			GObexResponseFunc func, gpointer user_data,
-			GError **err);
+guint g_obex_send_req(GObex *obex, GObexPacket *req, guint req_id,
+			gint timeout, GObexResponseFunc func,
+			gpointer user_data, GError **err);
 gboolean g_obex_cancel_req(GObex *obex, guint req_id,
 						gboolean remove_callback);
 
diff --git a/unit/test-gobex.c b/unit/test-gobex.c
index 62443db..1e31fe8 100644
--- a/unit/test-gobex.c
+++ b/unit/test-gobex.c
@@ -231,7 +231,7 @@ static void send_req(GObexPacket *req, GObexResponseFunc rsp_func,
 
 	create_endpoints(&obex, &io, transport_type);
 
-	g_obex_send_req(obex, req, req_timeout, rsp_func, &gerr, &gerr);
+	g_obex_send_req(obex, req, 0, req_timeout, rsp_func, &gerr, &gerr);
 	g_assert_no_error(gerr);
 
 	cond = G_IO_IN | G_IO_HUP | G_IO_ERR | G_IO_NVAL;
@@ -340,7 +340,7 @@ static void test_cancel_req_immediate(void)
 	r.err = NULL;
 
 	req = g_obex_packet_new(G_OBEX_OP_PUT, TRUE, G_OBEX_HDR_INVALID);
-	r.id = g_obex_send_req(r.obex, req, -1, req_done, &r, &r.err);
+	r.id = g_obex_send_req(r.obex, req, 0, -1, req_done, &r, &r.err);
 	g_assert_no_error(r.err);
 	g_assert(r.id != 0);
 
@@ -421,7 +421,7 @@ static void test_cancel_req_delay(int transport_type)
 	r.err = NULL;
 
 	req = g_obex_packet_new(G_OBEX_OP_PUT, TRUE, G_OBEX_HDR_INVALID);
-	r.id = g_obex_send_req(r.obex, req, -1, req_done, &r, &r.err);
+	r.id = g_obex_send_req(r.obex, req, 0, -1, req_done, &r, &r.err);
 	g_assert_no_error(r.err);
 	g_assert(r.id != 0);
 
-- 
1.7.6.4

