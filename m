Return-Path: <cyrus@holtmann.org>
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
To: linux-bluetooth@vger.kernel.org
Cc: patrick.ohly@intel.com
Subject: [PATCH BlueZ 7/8] gobex: Handle suspending/resuming for GET when SRM is active
Date: Fri, 14 Feb 2014 17:53:03 +0200
Message-Id: <1392393184-15266-7-git-send-email-luiz.dentz@gmail.com>
In-Reply-To: <1392393184-15266-1-git-send-email-luiz.dentz@gmail.com>
References: <1392393184-15266-1-git-send-email-luiz.dentz@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

From: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>

This adds support for suspending/resuming GET requests GET when SRM is
active, in this case suspending the TX queue wont stop the remote
to continue sending packets, to do that SRMP header should be set to wait
so the remote should wait.
---
 gobex/gobex-transfer.c |  2 +-
 gobex/gobex.c          | 56 ++++++++++++++++++++++++++++++++++++++++++++++++--
 2 files changed, 55 insertions(+), 3 deletions(-)

diff --git a/gobex/gobex-transfer.c b/gobex/gobex-transfer.c
index b815d60..09f56ba 100644
--- a/gobex/gobex-transfer.c
+++ b/gobex/gobex-transfer.c
@@ -390,7 +390,7 @@ static void transfer_put_req(GObex *obex, GObexPacket *req, gpointer user_data)
 
 	rspcode = put_get_bytes(transfer, req);
 
-	/* Don't send continue while in SRM */
+	/* Don't send continue while SRM is active */
 	if (g_obex_srm_active(transfer->obex) &&
 				rspcode == G_OBEX_RSP_CONTINUE)
 		goto done;
diff --git a/gobex/gobex.c b/gobex/gobex.c
index 291ed72..0d9b449 100644
--- a/gobex/gobex.c
+++ b/gobex/gobex.c
@@ -105,6 +105,7 @@ struct pending_pkt {
 	GObexResponseFunc rsp_func;
 	gpointer rsp_data;
 	gboolean cancelled;
+	gboolean suspended;
 };
 
 struct req_handler {
@@ -407,7 +408,9 @@ static void setup_srm(GObex *obex, GObexPacket *pkt, gboolean outgoing)
 		g_obex_header_get_uint8(hdr, &srmp);
 		g_obex_debug(G_OBEX_DEBUG_COMMAND, "srmp 0x%02x", srmp);
 		set_srmp(obex, srmp, outgoing);
-	} else
+	} else if (obex->pending_req && obex->pending_req->suspended)
+		g_obex_packet_add_uint8(pkt, G_OBEX_HDR_SRMP, G_OBEX_SRMP_WAIT);
+	else
 		set_srmp(obex, -1, outgoing);
 
 	if (final)
@@ -845,24 +848,73 @@ gboolean g_obex_remove_request_function(GObex *obex, guint id)
 	return TRUE;
 }
 
+static void g_obex_srm_suspend(GObex *obex)
+{
+	struct pending_pkt *p = obex->pending_req;
+	GObexPacket *req;
+
+	g_source_remove(p->timeout_id);
+	p->suspended = TRUE;
+
+	req = g_obex_packet_new(G_OBEX_OP_GET, TRUE,
+					G_OBEX_HDR_SRMP, G_OBEX_SRMP_WAIT,
+					G_OBEX_HDR_INVALID);
+
+	g_obex_send(obex, req, NULL);
+}
+
 void g_obex_suspend(GObex *obex)
 {
+	struct pending_pkt *req = obex->pending_req;
+
 	g_obex_debug(G_OBEX_DEBUG_COMMAND, "conn %u", obex->conn_id);
 
+	if (!g_obex_srm_active(obex) || !req)
+		goto done;
+
+	/* Send SRMP wait in case of GET */
+	if (g_obex_packet_get_operation(req->pkt, NULL) == G_OBEX_OP_GET) {
+		g_obex_srm_suspend(obex);
+		return;
+	}
+
+done:
+	obex->suspended = TRUE;
+
 	if (obex->write_source > 0) {
 		g_source_remove(obex->write_source);
 		obex->write_source = 0;
 	}
+}
 
-	obex->suspended = TRUE;
+static void g_obex_srm_resume(GObex *obex)
+{
+	struct pending_pkt *p = obex->pending_req;
+	GObexPacket *req;
+
+	p->timeout_id = g_timeout_add_seconds(p->timeout, req_timeout, obex);
+	p->suspended = FALSE;
+
+	req = g_obex_packet_new(G_OBEX_OP_GET, TRUE, G_OBEX_HDR_INVALID);
+
+	g_obex_send(obex, req, NULL);
 }
 
 void g_obex_resume(GObex *obex)
 {
+	struct pending_pkt *req = obex->pending_req;
+
 	g_obex_debug(G_OBEX_DEBUG_COMMAND, "conn %u", obex->conn_id);
 
 	obex->suspended = FALSE;
 
+	if (g_obex_srm_active(obex) || !req)
+		goto done;
+
+	if (g_obex_packet_get_operation(req->pkt, NULL) == G_OBEX_OP_GET)
+		g_obex_srm_resume(obex);
+
+done:
 	if (g_queue_get_length(obex->tx_queue) > 0 || obex->tx_data > 0)
 		enable_tx(obex);
 }
-- 
1.8.5.3

