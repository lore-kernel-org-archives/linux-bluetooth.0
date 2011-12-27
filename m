Return-Path: <cyrus@holtmann.org>
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH obexd 15/16] gobex: handle Single Response Mode (SRM) headers
Date: Tue, 27 Dec 2011 11:07:16 +0200
Message-Id: <1324976837-11914-15-git-send-email-luiz.dentz@gmail.com>
In-Reply-To: <1324976837-11914-1-git-send-email-luiz.dentz@gmail.com>
References: <1324976837-11914-1-git-send-email-luiz.dentz@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

From: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>

---
 gobex/gobex-transfer.c |   54 +++++++++++--
 gobex/gobex.c          |  199 ++++++++++++++++++++++++++++++++++++++++++------
 gobex/gobex.h          |    1 +
 3 files changed, 222 insertions(+), 32 deletions(-)

diff --git a/gobex/gobex-transfer.c b/gobex/gobex-transfer.c
index 0a7a29f..ca7834b 100644
--- a/gobex/gobex-transfer.c
+++ b/gobex/gobex-transfer.c
@@ -33,6 +33,9 @@
 
 static GSList *transfers = NULL;
 
+static void transfer_response(GObex *obex, GError *err, GObexPacket *rsp,
+							gpointer user_data);
+
 struct transfer {
 	guint id;
 	guint8 opcode;
@@ -130,16 +133,30 @@ static gssize put_get_data(void *buf, gsize len, gpointer user_data)
 	gssize ret;
 
 	ret = transfer->data_producer(buf, len, transfer->user_data);
-	if (ret >= 0)
+	if (ret == 0 || ret == -EAGAIN)
 		return ret;
 
-	if (ret == -EAGAIN)
-		return ret;
+	if (ret > 0) {
+		/* Check if SRM is enable */
+		if (g_obex_get_srm(transfer->obex) != G_OBEX_SRM_ENABLE)
+			return ret;
+
+		/* Generate next packet */
+		req = g_obex_packet_new(transfer->opcode, FALSE,
+							G_OBEX_HDR_INVALID);
+		g_obex_packet_add_body(req, put_get_data, transfer);
+		transfer->req_id = g_obex_send_req(transfer->obex, req, -1,
+						transfer_response, transfer,
+						&err);
+		goto done;
+	}
 
 	req = g_obex_packet_new(G_OBEX_OP_ABORT, TRUE, G_OBEX_HDR_INVALID);
+
 	transfer->req_id = g_obex_send_req(transfer->obex, req, -1,
 						transfer_abort_response,
 						transfer, &err);
+done:
 	if (err != NULL) {
 		transfer_complete(transfer, err);
 		g_error_free(err);
@@ -209,10 +226,11 @@ static void transfer_response(GObex *obex, GError *err, GObexPacket *rsp,
 		req = g_obex_packet_new(transfer->opcode, FALSE,
 							G_OBEX_HDR_INVALID);
 		g_obex_packet_add_body(req, put_get_data, transfer);
-	} else {
+	} else if (g_obex_get_srm(transfer->obex) != G_OBEX_SRM_ENABLE) {
 		req = g_obex_packet_new(transfer->opcode, TRUE,
 							G_OBEX_HDR_INVALID);
-	}
+	} else
+		return;
 
 	transfer->req_id = g_obex_send_req(obex, req, -1, transfer_response,
 							transfer, &err);
@@ -350,6 +368,7 @@ static void transfer_put_req_first(struct transfer *transfer, GObexPacket *req,
 	rspcode = put_get_bytes(transfer, req);
 
 	rsp = g_obex_packet_new_valist(rspcode, TRUE, first_hdr_id, args);
+
 	if (!g_obex_send(transfer->obex, rsp, &err)) {
 		transfer_complete(transfer, err);
 		g_error_free(err);
@@ -370,12 +389,19 @@ static void transfer_put_req(GObex *obex, GObexPacket *req, gpointer user_data)
 
 	rspcode = put_get_bytes(transfer, req);
 
+	/* Don't send continue while in SRM */
+	if (g_obex_get_srm(transfer->obex) == G_OBEX_SRM_ENABLE &&
+				rspcode == G_OBEX_RSP_CONTINUE)
+		goto done;
+
 	rsp = g_obex_packet_new(rspcode, TRUE, G_OBEX_HDR_INVALID);
+
 	if (!g_obex_send(obex, rsp, &err)) {
 		transfer_complete(transfer, err);
 		g_error_free(err);
 	}
 
+done:
 	if (rspcode != G_OBEX_RSP_CONTINUE)
 		transfer_complete(transfer, NULL);
 }
@@ -472,15 +498,29 @@ guint g_obex_get_req(GObex *obex, GObexDataConsumer data_func,
 static gssize get_get_data(void *buf, gsize len, gpointer user_data)
 {
 	struct transfer *transfer = user_data;
-	GObexPacket *req;
+	GObexPacket *req, *rsp;
 	GError *err = NULL;
 	gssize ret;
 
 	g_obex_debug(G_OBEX_DEBUG_TRANSFER, "transfer %u", transfer->id);
 
 	ret = transfer->data_producer(buf, len, transfer->user_data);
-	if (ret > 0)
+	if (ret > 0) {
+		if (g_obex_get_srm(transfer->obex) != G_OBEX_SRM_ENABLE)
+			return ret;
+
+		/* Generate next response */
+		rsp = g_obex_packet_new(G_OBEX_RSP_CONTINUE, TRUE,
+							G_OBEX_HDR_INVALID);
+		g_obex_packet_add_body(rsp, get_get_data, transfer);
+
+		if (!g_obex_send(transfer->obex, rsp, &err)) {
+			transfer_complete(transfer, err);
+			g_error_free(err);
+		}
+
 		return ret;
+	}
 
 	if (ret == -EAGAIN)
 		return ret;
diff --git a/gobex/gobex.c b/gobex/gobex.c
index 036a44a..54d19ed 100644
--- a/gobex/gobex.c
+++ b/gobex/gobex.c
@@ -46,6 +46,15 @@
 
 guint gobex_debug = 0;
 
+struct srm_setup {
+	guint8 op;
+	enum {
+		SRM_DISABLED		= 0,
+		SRM_INDICATING		= 1,
+		SRM_ENABLED		= 2,
+	} state;
+};
+
 struct _GObex {
 	gint ref_count;
 	GIOChannel *io;
@@ -65,6 +74,8 @@ struct _GObex {
 
 	gboolean suspended;
 
+	struct srm_setup *srm;
+
 	guint write_source;
 
 	gssize io_rx_mtu;
@@ -308,12 +319,16 @@ static gboolean write_data(GIOChannel *io, GIOCondition cond,
 		if (p == NULL)
 			goto stop_tx;
 
+		if (g_obex_get_srm(obex) == G_OBEX_SRM_ENABLE)
+			goto encode;
+
 		/* Can't send a request while there's a pending one */
 		if (obex->pending_req && p->id > 0) {
 			g_queue_push_head(obex->tx_queue, p);
 			goto stop_tx;
 		}
 
+encode:
 		len = g_obex_packet_encode(p->pkt, obex->tx_buf, obex->tx_mtu);
 		if (len == -EAGAIN) {
 			g_queue_push_head(obex->tx_queue, p);
@@ -327,6 +342,8 @@ static gboolean write_data(GIOChannel *io, GIOCondition cond,
 		}
 
 		if (p->id > 0) {
+			if (obex->pending_req != NULL)
+				pending_pkt_free(obex->pending_req);
 			obex->pending_req = p;
 			p->timeout_id = g_timeout_add_seconds(p->timeout,
 							req_timeout, obex);
@@ -427,6 +444,84 @@ static void prepare_connect_rsp(GObex *obex, GObexPacket *rsp)
 	g_obex_packet_prepend_header(rsp, connid);
 }
 
+static const char *state2str(guint mode)
+{
+	switch (mode) {
+	case SRM_DISABLED:
+		return "SRM Disabled";
+	case SRM_INDICATING:
+		return "SRM Indicating";
+	case SRM_ENABLED:
+		return "SRM Enabled";
+	default:
+		return "Unkown";
+	}
+}
+
+static void set_srm(GObex *obex, guint8 op, guint8 srm)
+{
+	struct srm_setup *setup = obex->srm;
+
+	if (setup == NULL) {
+		if (srm == G_OBEX_SRM_DISABLE)
+			return;
+
+		setup = g_new0(struct srm_setup, 1);
+		setup->op = op;
+		obex->srm = setup;
+		return;
+	}
+
+	switch (srm) {
+	case G_OBEX_SRM_DISABLE:
+		setup->state = SRM_DISABLED;
+		break;
+	case G_OBEX_SRM_ENABLE:
+		setup->state = SRM_ENABLED;
+		break;
+	case G_OBEX_SRM_INDICATE:
+		setup->state = SRM_INDICATING;
+		break;
+	}
+
+	g_obex_debug(G_OBEX_DEBUG_COMMAND, "%s", state2str(setup->state));
+
+	if (setup->state == SRM_DISABLED) {
+		g_free(obex->srm);
+		obex->srm = NULL;
+	}
+}
+
+static void setup_srm(GObex *obex, GObexPacket *pkt)
+{
+	GObexHeader *hdr;
+	guint8 op;
+	gboolean final;
+
+	op = g_obex_packet_get_operation(pkt, &final);
+
+	hdr = g_obex_packet_get_header(pkt, G_OBEX_HDR_SRM);
+	if (hdr != NULL) {
+		guint8 srm;
+		g_obex_header_get_uint8(hdr, &srm);
+		g_obex_debug(G_OBEX_DEBUG_COMMAND, "srm 0x%02x", srm);
+		set_srm(obex, op, srm);
+	}
+
+	if (obex->srm == NULL || obex->srm->state == SRM_DISABLED || !final)
+		return;
+
+	switch (obex->srm->op) {
+	case G_OBEX_OP_CONNECT:
+		return;
+	default:
+		if (op <= G_OBEX_RSP_CONTINUE)
+			return;
+	}
+
+	set_srm(obex, op, G_OBEX_SRM_DISABLE);
+}
+
 gboolean g_obex_send(GObex *obex, GObexPacket *pkt, GError **err)
 {
 	struct pending_pkt *p;
@@ -444,6 +539,8 @@ gboolean g_obex_send(GObex *obex, GObexPacket *pkt, GError **err)
 	if (obex->rx_last_op == G_OBEX_OP_CONNECT)
 		prepare_connect_rsp(obex, pkt);
 
+	setup_srm(obex, pkt);
+
 	p = g_new0(struct pending_pkt, 1);
 	p->pkt = pkt;
 
@@ -458,25 +555,30 @@ guint g_obex_send_req(GObex *obex, GObexPacket *req, gint timeout,
 			GObexResponseFunc func, gpointer user_data,
 			GError **err)
 {
-	GObexHeader *connid;
+	GObexHeader *hdr;
 	struct pending_pkt *p;
 	static guint id = 1;
 
 	g_obex_debug(G_OBEX_DEBUG_COMMAND, "conn %u", obex->conn_id);
 
+	setup_srm(obex, req);
+
 	if (obex->conn_id == CONNID_INVALID)
 		goto create_pending;
 
 	if (obex->rx_last_op == G_OBEX_RSP_CONTINUE)
 		goto create_pending;
 
-	connid = g_obex_packet_get_header(req, G_OBEX_HDR_CONNECTION);
-	if (connid != NULL)
+	if (g_obex_get_srm(obex) == G_OBEX_SRM_ENABLE &&
+						obex->pending_req != NULL)
 		goto create_pending;
 
-	connid = g_obex_header_new_uint32(G_OBEX_HDR_CONNECTION,
-							obex->conn_id);
-	g_obex_packet_prepend_header(req, connid);
+	hdr = g_obex_packet_get_header(req, G_OBEX_HDR_CONNECTION);
+	if (hdr != NULL)
+		goto create_pending;
+
+	hdr = g_obex_header_new_uint32(G_OBEX_HDR_CONNECTION, obex->conn_id);
+	g_obex_packet_prepend_header(req, hdr);
 
 create_pending:
 	p = g_new0(struct pending_pkt, 1);
@@ -675,6 +777,15 @@ void g_obex_resume(GObex *obex)
 		enable_tx(obex);
 }
 
+guint8 g_obex_get_srm(GObex *obex)
+{
+	if (obex->srm == NULL)
+		return G_OBEX_SRM_DISABLE;
+
+	return obex->srm->state == SRM_ENABLED ? G_OBEX_SRM_ENABLE :
+							G_OBEX_SRM_DISABLE;
+}
+
 static void parse_connect_data(GObex *obex, GObexPacket *pkt)
 {
 	const struct connect_data *data;
@@ -698,21 +809,46 @@ static void parse_connect_data(GObex *obex, GObexPacket *pkt)
 		g_obex_header_get_uint32(connid, &obex->conn_id);
 }
 
-static void handle_response(GObex *obex, GError *err, GObexPacket *rsp)
+static gboolean parse_response(GObex *obex, GObexPacket *rsp)
 {
 	struct pending_pkt *p = obex->pending_req;
-	gboolean disconn = err ? TRUE : FALSE, final_rsp = TRUE;
+	guint8 opcode, rspcode;
+	gboolean final;
 
-	if (rsp != NULL) {
-		guint8 opcode;
+	rspcode = g_obex_packet_get_operation(rsp, &final);
 
-		g_obex_packet_get_operation(rsp, &final_rsp);
+	opcode = g_obex_packet_get_operation(p->pkt, NULL);
+	if (opcode == G_OBEX_OP_CONNECT)
+		parse_connect_data(obex, rsp);
 
-		opcode = g_obex_packet_get_operation(p->pkt, NULL);
-		if (opcode == G_OBEX_OP_CONNECT)
-			parse_connect_data(obex, rsp);
+	setup_srm(obex, rsp);
+
+	if (g_obex_get_srm(obex) != G_OBEX_SRM_ENABLE)
+		return final;
+
+	/*
+	 * Resposes have final bit set but in case of GET with SRM
+	 * we should not remove the request since the remote side will
+	 * continue sending responses until the transfer is finished
+	 */
+	if (opcode == G_OBEX_OP_GET && rspcode == G_OBEX_RSP_CONTINUE) {
+		g_source_remove(p->timeout_id);
+		p->timeout_id = g_timeout_add_seconds(p->timeout, req_timeout,
+									obex);
+		return FALSE;
 	}
 
+	return final;
+}
+
+static void handle_response(GObex *obex, GError *err, GObexPacket *rsp)
+{
+	struct pending_pkt *p = obex->pending_req;
+	gboolean disconn = err ? TRUE : FALSE, final_rsp = TRUE;
+
+	if (rsp != NULL)
+		final_rsp = parse_response(obex, rsp);
+
 	if (p->cancelled)
 		err = g_error_new(G_OBEX_ERROR, G_OBEX_ERROR_CANCELLED,
 					"The operation was cancelled");
@@ -720,7 +856,6 @@ static void handle_response(GObex *obex, GError *err, GObexPacket *rsp)
 	if (err)
 		g_obex_debug(G_OBEX_DEBUG_ERROR, "%s", err->message);
 
-
 	if (p->rsp_func) {
 		p->rsp_func(obex, err, rsp, p->rsp_data);
 
@@ -758,13 +893,12 @@ static gboolean check_connid(GObex *obex, GObexPacket *pkt)
 	return obex->conn_id == id;
 }
 
-static void handle_request(GObex *obex, GObexPacket *req)
+static guint8 parse_request(GObex *obex, GObexPacket *req)
 {
-	GSList *match;
 	guint op;
+	gboolean final;
 
-	op = g_obex_packet_get_operation(req, NULL);
-
+	op = g_obex_packet_get_operation(req, &final);
 	switch (op) {
 	case G_OBEX_OP_CONNECT:
 		parse_connect_data(obex, req);
@@ -775,12 +909,23 @@ static void handle_request(GObex *obex, GObexPacket *req)
 		if (check_connid(obex, req))
 			break;
 
-		g_obex_debug(G_OBEX_DEBUG_ERROR, "Invalid Connection ID");
-		g_obex_send_rsp(obex, G_OBEX_RSP_SERVICE_UNAVAILABLE, NULL,
-							G_OBEX_HDR_INVALID);
-		return;
+		return G_OBEX_RSP_SERVICE_UNAVAILABLE;
 	}
 
+	setup_srm(obex, req);
+
+	return op;
+}
+
+static void handle_request(GObex *obex, GObexPacket *req)
+{
+	GSList *match;
+	guint op;
+
+	op = parse_request(obex, req);
+	if (op >= G_OBEX_RSP_CONTINUE && op != G_OBEX_OP_ABORT)
+		goto done;
+
 	match = g_slist_find_custom(obex->req_handlers, GUINT_TO_POINTER(op),
 							req_handler_cmpop);
 	if (match) {
@@ -789,8 +934,11 @@ static void handle_request(GObex *obex, GObexPacket *req)
 		return;
 	}
 
-	g_obex_send_rsp(obex, G_OBEX_RSP_NOT_IMPLEMENTED, NULL,
-							G_OBEX_HDR_INVALID);
+	op = G_OBEX_RSP_NOT_IMPLEMENTED;
+
+done:
+	g_obex_debug(G_OBEX_DEBUG_ERROR, "Invalid Connection ID");
+	g_obex_send_rsp(obex, op, NULL, G_OBEX_HDR_INVALID);
 }
 
 static gboolean read_stream(GObex *obex, GError **err)
@@ -1111,6 +1259,7 @@ void g_obex_unref(GObex *obex)
 
 	g_free(obex->rx_buf);
 	g_free(obex->tx_buf);
+	g_free(obex->srm);
 
 	if (obex->pending_req)
 		pending_pkt_free(obex->pending_req);
diff --git a/gobex/gobex.h b/gobex/gobex.h
index 81981ea..cbc4482 100644
--- a/gobex/gobex.h
+++ b/gobex/gobex.h
@@ -61,6 +61,7 @@ gboolean g_obex_remove_request_function(GObex *obex, guint id);
 
 void g_obex_suspend(GObex *obex);
 void g_obex_resume(GObex *obex);
+guint8 g_obex_get_srm(GObex *obex);
 
 GObex *g_obex_new(GIOChannel *io, GObexTransportType transport_type,
 						gssize rx_mtu, gssize tx_mtu);
-- 
1.7.7.4

