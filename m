Return-Path: <cyrus@holtmann.org>
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH obexd 4/7 v3] gobex: log transfers using G_OBEX_DEBUG_TRANSFER
Date: Fri, 21 Oct 2011 13:34:02 +0300
Message-Id: <1319193245-23058-4-git-send-email-luiz.dentz@gmail.com>
In-Reply-To: <1319193245-23058-1-git-send-email-luiz.dentz@gmail.com>
References: <1319193245-23058-1-git-send-email-luiz.dentz@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

From: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>

---
 gobex/gobex-transfer.c |   50 ++++++++++++++++++++++++++++++++++++++++++++++++
 1 files changed, 50 insertions(+), 0 deletions(-)

diff --git a/gobex/gobex-transfer.c b/gobex/gobex-transfer.c
index 7220cfd..6d2f7af 100644
--- a/gobex/gobex-transfer.c
+++ b/gobex/gobex-transfer.c
@@ -54,6 +54,8 @@ struct transfer {
 
 static void transfer_free(struct transfer *transfer)
 {
+	g_obex_debug(G_OBEX_DEBUG_TRANSFER, "transfer %u", transfer->id);
+
 	transfers = g_slist_remove(transfers, transfer);
 
 	if (transfer->req_id > 0)
@@ -77,6 +79,8 @@ static void transfer_free(struct transfer *transfer)
 
 static void transfer_complete(struct transfer *transfer, GError *err)
 {
+	g_obex_debug(G_OBEX_DEBUG_TRANSFER, "transfer %u", transfer->id);
+
 	transfer->complete_func(transfer->obex, err, transfer->user_data);
 	/* Check if the complete_func removed the transfer */
 	if (g_slist_find(transfers, transfer) == NULL)
@@ -89,6 +93,8 @@ static void transfer_abort_response(GObex *obex, GError *err, GObexPacket *rsp,
 {
 	struct transfer *transfer = user_data;
 
+	g_obex_debug(G_OBEX_DEBUG_TRANSFER, "transfer %u", transfer->id);
+
 	transfer->req_id = 0;
 
 	/* Intentionally override error */
@@ -156,6 +162,8 @@ static void transfer_response(GObex *obex, GError *err, GObexPacket *rsp,
 	GObexPacket *req;
 	gboolean rspcode, final;
 
+	g_obex_debug(G_OBEX_DEBUG_TRANSFER, "transfer %u", transfer->id);
+
 	transfer->req_id = 0;
 
 	if (err != NULL) {
@@ -206,6 +214,8 @@ static struct transfer *transfer_new(GObex *obex, guint8 opcode,
 	static guint next_id = 1;
 	struct transfer *transfer;
 
+	g_obex_debug(G_OBEX_DEBUG_TRANSFER, "obex %p opcode %u", obex, opcode);
+
 	transfer = g_new0(struct transfer, 1);
 
 	transfer->id = next_id++;
@@ -225,6 +235,8 @@ guint g_obex_put_req_pkt(GObex *obex, GObexPacket *req,
 {
 	struct transfer *transfer;
 
+	g_obex_debug(G_OBEX_DEBUG_TRANSFER, "obex %p", obex);
+
 	if (g_obex_packet_get_operation(req, NULL) != G_OBEX_OP_PUT)
 		return 0;
 
@@ -240,6 +252,8 @@ guint g_obex_put_req_pkt(GObex *obex, GObexPacket *req,
 		return 0;
 	}
 
+	g_obex_debug(G_OBEX_DEBUG_TRANSFER, "transfer %u", transfer->id);
+
 	return transfer->id;
 }
 
@@ -251,6 +265,8 @@ guint g_obex_put_req(GObex *obex, GObexDataProducer data_func,
 	GObexPacket *req;
 	va_list args;
 
+	g_obex_debug(G_OBEX_DEBUG_TRANSFER, "obex %p", obex);
+
 	transfer = transfer_new(obex, G_OBEX_OP_PUT, complete_func, user_data);
 	transfer->data_producer = data_func;
 
@@ -268,6 +284,8 @@ guint g_obex_put_req(GObex *obex, GObexDataProducer data_func,
 		return 0;
 	}
 
+	g_obex_debug(G_OBEX_DEBUG_TRANSFER, "transfer %u", transfer->id);
+
 	return transfer->id;
 }
 
@@ -277,6 +295,8 @@ static void transfer_abort_req(GObex *obex, GObexPacket *req, gpointer user_data
 	GObexPacket *rsp;
 	GError *err;
 
+	g_obex_debug(G_OBEX_DEBUG_TRANSFER, "transfer %u", transfer->id);
+
 	err = g_error_new(G_OBEX_ERROR, G_OBEX_ERROR_CANCELLED,
 						"Request was aborted");
 	rsp = g_obex_packet_new(G_OBEX_RSP_SUCCESS, TRUE, G_OBEX_HDR_INVALID);
@@ -294,6 +314,8 @@ static guint8 put_get_bytes(struct transfer *transfer, GObexPacket *req)
 	const guint8 *buf;
 	gsize len;
 
+	g_obex_debug(G_OBEX_DEBUG_TRANSFER, "transfer %u", transfer->id);
+
 	g_obex_packet_get_operation(req, &final);
 	if (final)
 		rsp = G_OBEX_RSP_SUCCESS;
@@ -321,6 +343,8 @@ static void transfer_put_req_first(struct transfer *transfer, GObexPacket *req,
 	GObexPacket *rsp;
 	guint8 rspcode;
 
+	g_obex_debug(G_OBEX_DEBUG_TRANSFER, "transfer %u", transfer->id);
+
 	rspcode = put_get_bytes(transfer, req);
 
 	rsp = g_obex_packet_new_valist(rspcode, TRUE, first_hdr_id, args);
@@ -340,6 +364,8 @@ static void transfer_put_req(GObex *obex, GObexPacket *req, gpointer user_data)
 	GObexPacket *rsp;
 	guint8 rspcode;
 
+	g_obex_debug(G_OBEX_DEBUG_TRANSFER, "transfer %u", transfer->id);
+
 	rspcode = put_get_bytes(transfer, req);
 
 	rsp = g_obex_packet_new(rspcode, TRUE, G_OBEX_HDR_INVALID);
@@ -361,6 +387,8 @@ guint g_obex_put_rsp(GObex *obex, GObexPacket *req,
 	va_list args;
 	guint id;
 
+	g_obex_debug(G_OBEX_DEBUG_TRANSFER, "obex %p", obex);
+
 	transfer = transfer_new(obex, G_OBEX_OP_PUT, complete_func, user_data);
 	transfer->data_consumer = data_func;
 
@@ -379,6 +407,8 @@ guint g_obex_put_rsp(GObex *obex, GObexPacket *req,
 						transfer_abort_req, transfer);
 	transfer->abort_id = id;
 
+	g_obex_debug(G_OBEX_DEBUG_TRANSFER, "transfer %u", transfer->id);
+
 	return transfer->id;
 }
 
@@ -388,6 +418,8 @@ guint g_obex_get_req_pkt(GObex *obex, GObexPacket *req,
 {
 	struct transfer *transfer;
 
+	g_obex_debug(G_OBEX_DEBUG_TRANSFER, "obex %p", obex);
+
 	if (g_obex_packet_get_operation(req, NULL) != G_OBEX_OP_GET)
 		return 0;
 
@@ -401,6 +433,8 @@ guint g_obex_get_req_pkt(GObex *obex, GObexPacket *req,
 		return 0;
 	}
 
+	g_obex_debug(G_OBEX_DEBUG_TRANSFER, "transfer %u", transfer->id);
+
 	return transfer->id;
 }
 
@@ -412,6 +446,8 @@ guint g_obex_get_req(GObex *obex, GObexDataConsumer data_func,
 	GObexPacket *req;
 	va_list args;
 
+	g_obex_debug(G_OBEX_DEBUG_TRANSFER, "obex %p", obex);
+
 	transfer = transfer_new(obex, G_OBEX_OP_GET, complete_func, user_data);
 	transfer->data_consumer = data_func;
 
@@ -427,6 +463,8 @@ guint g_obex_get_req(GObex *obex, GObexDataConsumer data_func,
 		return 0;
 	}
 
+	g_obex_debug(G_OBEX_DEBUG_TRANSFER, "transfer %u", transfer->id);
+
 	return transfer->id;
 }
 
@@ -437,6 +475,8 @@ static gssize get_get_data(void *buf, gsize len, gpointer user_data)
 	GError *err = NULL;
 	gssize ret;
 
+	g_obex_debug(G_OBEX_DEBUG_TRANSFER, "transfer %u", transfer->id);
+
 	ret = transfer->data_producer(buf, len, transfer->user_data);
 	if (ret > 0)
 		return ret;
@@ -468,6 +508,8 @@ static void transfer_get_req_first(struct transfer *transfer,
 	GError *err = NULL;
 	GObexPacket *rsp;
 
+	g_obex_debug(G_OBEX_DEBUG_TRANSFER, "transfer %u", transfer->id);
+
 	rsp = g_obex_packet_new_valist(G_OBEX_RSP_CONTINUE, TRUE,
 							first_hdr_id, args);
 	g_obex_packet_add_body(rsp, get_get_data, transfer);
@@ -484,6 +526,8 @@ static void transfer_get_req(GObex *obex, GObexPacket *req, gpointer user_data)
 	GError *err = NULL;
 	GObexPacket *rsp;
 
+	g_obex_debug(G_OBEX_DEBUG_TRANSFER, "transfer %u", transfer->id);
+
 	rsp = g_obex_packet_new(G_OBEX_RSP_CONTINUE, TRUE, G_OBEX_HDR_INVALID);
 	g_obex_packet_add_body(rsp, get_get_data, transfer);
 
@@ -501,6 +545,8 @@ guint g_obex_get_rsp(GObex *obex, GObexDataProducer data_func,
 	va_list args;
 	guint id;
 
+	g_obex_debug(G_OBEX_DEBUG_TRANSFER, "obex %p", obex);
+
 	transfer = transfer_new(obex, G_OBEX_OP_GET, complete_func, user_data);
 	transfer->data_producer = data_func;
 
@@ -519,6 +565,8 @@ guint g_obex_get_rsp(GObex *obex, GObexDataProducer data_func,
 						transfer_abort_req, transfer);
 	transfer->abort_id = id;
 
+	g_obex_debug(G_OBEX_DEBUG_TRANSFER, "transfer %u", transfer->id);
+
 	return transfer->id;
 }
 
@@ -527,6 +575,8 @@ gboolean g_obex_cancel_transfer(guint id)
 	struct transfer *transfer = NULL;
 	GSList *l;
 
+	g_obex_debug(G_OBEX_DEBUG_TRANSFER, "transfer %u", id);
+
 	for (l = transfers; l != NULL; l = g_slist_next(l)) {
 		struct transfer *t = l->data;
 		if (t->id == id) {
-- 
1.7.6.4

