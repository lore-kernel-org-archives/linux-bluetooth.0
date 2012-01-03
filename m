Return-Path: <cyrus@holtmann.org>
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH obexd 2/4] gobex: handle Single Response Mode Parameters (SRMP) headers
Date: Tue,  3 Jan 2012 15:52:22 +0200
Message-Id: <1325598744-18855-2-git-send-email-luiz.dentz@gmail.com>
In-Reply-To: <1325598744-18855-1-git-send-email-luiz.dentz@gmail.com>
References: <1325598744-18855-1-git-send-email-luiz.dentz@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

From: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>

Single Response Mode Parameters is a 1-byte quantity containing the
value for the parameters used for SRM.
---
 gobex/gobex.c |   39 ++++++++++++++++++++++++++++++++++-----
 1 files changed, 34 insertions(+), 5 deletions(-)

diff --git a/gobex/gobex.c b/gobex/gobex.c
index e225a50..ed051ee 100644
--- a/gobex/gobex.c
+++ b/gobex/gobex.c
@@ -50,6 +50,8 @@ struct srm_config {
 	guint8 op;
 	gboolean enabled;
 	guint8 srm;
+	guint8 srmp;
+	gboolean outgoing;
 };
 
 struct _GObex {
@@ -441,6 +443,21 @@ static void prepare_connect_rsp(GObex *obex, GObexPacket *rsp)
 	g_obex_packet_prepend_header(rsp, connid);
 }
 
+static void set_srmp(GObex *obex, guint8 srmp, gboolean outgoing)
+{
+	struct srm_config *config = obex->srm;
+
+	if (config == NULL)
+		return;
+
+	/* Dont't reset if direction doesn't match */
+	if (srmp > G_OBEX_SRMP_NEXT_WAIT && config->outgoing != outgoing)
+		return;
+
+	config->srmp = srmp;
+	config->outgoing = outgoing;
+}
+
 static void set_srm(GObex *obex, guint8 op, guint8 srm)
 {
 	struct srm_config *config = obex->srm;
@@ -482,7 +499,7 @@ done:
 	obex->srm = NULL;
 }
 
-static void setup_srm(GObex *obex, GObexPacket *pkt)
+static void setup_srm(GObex *obex, GObexPacket *pkt, gboolean outgoing)
 {
 	GObexHeader *hdr;
 	guint8 op;
@@ -498,6 +515,15 @@ static void setup_srm(GObex *obex, GObexPacket *pkt)
 		set_srm(obex, op, srm);
 	}
 
+	hdr = g_obex_packet_get_header(pkt, G_OBEX_HDR_SRMP);
+	if (hdr != NULL) {
+		guint8 srmp;
+		g_obex_header_get_uint8(hdr, &srmp);
+		g_obex_debug(G_OBEX_DEBUG_COMMAND, "srmp 0x%02x", srmp);
+		set_srmp(obex, srmp, outgoing);
+	} else
+		set_srmp(obex, -1, outgoing);
+
 	if (obex->srm == NULL || !obex->srm->enabled || !final)
 		return;
 
@@ -529,7 +555,7 @@ gboolean g_obex_send(GObex *obex, GObexPacket *pkt, GError **err)
 	if (obex->rx_last_op == G_OBEX_OP_CONNECT)
 		prepare_connect_rsp(obex, pkt);
 
-	setup_srm(obex, pkt);
+	setup_srm(obex, pkt, TRUE);
 
 	p = g_new0(struct pending_pkt, 1);
 	p->pkt = pkt;
@@ -551,7 +577,7 @@ guint g_obex_send_req(GObex *obex, GObexPacket *req, gint timeout,
 
 	g_obex_debug(G_OBEX_DEBUG_COMMAND, "conn %u", obex->conn_id);
 
-	setup_srm(obex, req);
+	setup_srm(obex, req, TRUE);
 
 	if (obex->conn_id == CONNID_INVALID)
 		goto create_pending;
@@ -773,6 +799,9 @@ gboolean g_obex_srm_active(GObex *obex)
 	if (obex->srm == NULL || !obex->srm->enabled)
 		goto done;
 
+	if (obex->srm->srmp <= G_OBEX_SRMP_NEXT_WAIT)
+		goto done;
+
 	ret = TRUE;
 done:
 	g_obex_debug(G_OBEX_DEBUG_COMMAND, "%s", ret ? "yes" : "no");
@@ -814,7 +843,7 @@ static gboolean parse_response(GObex *obex, GObexPacket *rsp)
 	if (opcode == G_OBEX_OP_CONNECT)
 		parse_connect_data(obex, rsp);
 
-	setup_srm(obex, rsp);
+	setup_srm(obex, rsp, FALSE);
 
 	if (!g_obex_srm_active(obex))
 		return final;
@@ -905,7 +934,7 @@ static int parse_request(GObex *obex, GObexPacket *req)
 		return -G_OBEX_RSP_SERVICE_UNAVAILABLE;
 	}
 
-	setup_srm(obex, req);
+	setup_srm(obex, req, FALSE);
 
 	return op;
 }
-- 
1.7.7.4

