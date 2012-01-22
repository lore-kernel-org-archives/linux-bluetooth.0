Return-Path: <cyrus@holtmann.org>
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH obexd 1/2] gobex: fix not disabling SRM when dealing with GET responses
Date: Sun, 22 Jan 2012 23:07:03 +0200
Message-Id: <1327266423-1033-1-git-send-email-luiz.dentz@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

From: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>

While sending the final bit can be changed during encoding.
---
 gobex/gobex.c |  218 ++++++++++++++++++++++++++++++---------------------------
 1 files changed, 115 insertions(+), 103 deletions(-)

diff --git a/gobex/gobex.c b/gobex/gobex.c
index 33b77fd..03da84f 100644
--- a/gobex/gobex.c
+++ b/gobex/gobex.c
@@ -299,6 +299,110 @@ static gboolean write_packet(GObex *obex, GError **err)
 	return TRUE;
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
+static void set_srm(GObex *obex, guint8 op, guint8 srm)
+{
+	struct srm_config *config = obex->srm;
+	gboolean enable;
+
+	if (config == NULL) {
+		if (srm == G_OBEX_SRM_DISABLE)
+			return;
+
+		config = g_new0(struct srm_config, 1);
+		config->op = op;
+		config->srm = srm;
+		obex->srm = config;
+		return;
+	}
+
+	/* Indicate response, treat it as request */
+	if (config->srm == G_OBEX_SRM_INDICATE) {
+		if (srm != G_OBEX_SRM_ENABLE)
+			goto done;
+		config->srm = srm;
+		return;
+	}
+
+	enable = (srm == G_OBEX_SRM_ENABLE);
+	if (config->enabled == enable)
+		goto done;
+
+	config->enabled = enable;
+
+	g_obex_debug(G_OBEX_DEBUG_COMMAND, "SRM %s", config->enabled ?
+						"Enabled" : "Disabled");
+
+done:
+	if (config->enabled)
+		return;
+
+	g_free(obex->srm);
+	obex->srm = NULL;
+}
+
+static void check_srm_final(GObex *obex, guint8 op)
+{
+	if (obex->srm == NULL || !obex->srm->enabled)
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
+static void setup_srm(GObex *obex, GObexPacket *pkt, gboolean outgoing)
+{
+	GObexHeader *hdr;
+	guint8 op;
+	gboolean final;
+
+	if (!obex->use_srm)
+		return;
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
+	hdr = g_obex_packet_get_header(pkt, G_OBEX_HDR_SRMP);
+	if (hdr != NULL) {
+		guint8 srmp;
+		g_obex_header_get_uint8(hdr, &srmp);
+		g_obex_debug(G_OBEX_DEBUG_COMMAND, "srmp 0x%02x", srmp);
+		set_srmp(obex, srmp, outgoing);
+	} else
+		set_srmp(obex, -1, outgoing);
+
+	if (final)
+		check_srm_final(obex, op);
+}
+
 static gboolean write_data(GIOChannel *io, GIOCondition cond,
 							gpointer user_data)
 {
@@ -317,6 +421,8 @@ static gboolean write_data(GIOChannel *io, GIOCondition cond,
 		if (p == NULL)
 			goto stop_tx;
 
+		setup_srm(obex, p->pkt, TRUE);
+
 		if (g_obex_srm_active(obex))
 			goto encode;
 
@@ -345,8 +451,13 @@ encode:
 			obex->pending_req = p;
 			p->timeout_id = g_timeout_add_seconds(p->timeout,
 							req_timeout, obex);
-		} else
+		} else {
+			/* During packet encode final bit can be set */
+			if (obex->tx_buf[0] & FINAL_BIT)
+				check_srm_final(obex,
+						obex->tx_buf[0] & ~FINAL_BIT);
 			pending_pkt_free(p);
+		}
 
 		obex->tx_data = len;
 		obex->tx_sent = 0;
@@ -442,104 +553,6 @@ static void prepare_connect_rsp(GObex *obex, GObexPacket *rsp)
 	g_obex_packet_prepend_header(rsp, connid);
 }
 
-static void set_srmp(GObex *obex, guint8 srmp, gboolean outgoing)
-{
-	struct srm_config *config = obex->srm;
-
-	if (config == NULL)
-		return;
-
-	/* Dont't reset if direction doesn't match */
-	if (srmp > G_OBEX_SRMP_NEXT_WAIT && config->outgoing != outgoing)
-		return;
-
-	config->srmp = srmp;
-	config->outgoing = outgoing;
-}
-
-static void set_srm(GObex *obex, guint8 op, guint8 srm)
-{
-	struct srm_config *config = obex->srm;
-	gboolean enable;
-
-	if (config == NULL) {
-		if (srm == G_OBEX_SRM_DISABLE)
-			return;
-
-		config = g_new0(struct srm_config, 1);
-		config->op = op;
-		config->srm = srm;
-		obex->srm = config;
-		return;
-	}
-
-	/* Indicate response, treat it as request */
-	if (config->srm == G_OBEX_SRM_INDICATE) {
-		if (srm != G_OBEX_SRM_ENABLE)
-			goto done;
-		config->srm = srm;
-		return;
-	}
-
-	enable = (srm == G_OBEX_SRM_ENABLE);
-	if (config->enabled == enable)
-		goto done;
-
-	config->enabled = enable;
-
-	g_obex_debug(G_OBEX_DEBUG_COMMAND, "SRM %s", config->enabled ?
-						"Enabled" : "Disabled");
-
-done:
-	if (config->enabled)
-		return;
-
-	g_free(obex->srm);
-	obex->srm = NULL;
-}
-
-static void setup_srm(GObex *obex, GObexPacket *pkt, gboolean outgoing)
-{
-	GObexHeader *hdr;
-	guint8 op;
-	gboolean final;
-
-	if (!obex->use_srm)
-		return;
-
-	op = g_obex_packet_get_operation(pkt, &final);
-
-	hdr = g_obex_packet_get_header(pkt, G_OBEX_HDR_SRM);
-	if (hdr != NULL) {
-		guint8 srm;
-		g_obex_header_get_uint8(hdr, &srm);
-		g_obex_debug(G_OBEX_DEBUG_COMMAND, "srm 0x%02x", srm);
-		set_srm(obex, op, srm);
-	}
-
-	hdr = g_obex_packet_get_header(pkt, G_OBEX_HDR_SRMP);
-	if (hdr != NULL) {
-		guint8 srmp;
-		g_obex_header_get_uint8(hdr, &srmp);
-		g_obex_debug(G_OBEX_DEBUG_COMMAND, "srmp 0x%02x", srmp);
-		set_srmp(obex, srmp, outgoing);
-	} else
-		set_srmp(obex, -1, outgoing);
-
-	if (obex->srm == NULL || !obex->srm->enabled || !final)
-		return;
-
-	switch (obex->srm->op) {
-	case G_OBEX_OP_CONNECT:
-		return;
-	default:
-		if (op <= G_OBEX_RSP_CONTINUE)
-			return;
-	}
-
-	set_srm(obex, op, G_OBEX_SRM_DISABLE);
-}
-
 static void prepare_srm_rsp(GObex *obex, GObexPacket *pkt)
 {
 	GObexHeader *hdr;
@@ -581,8 +594,6 @@ gboolean g_obex_send(GObex *obex, GObexPacket *pkt, GError **err)
 		break;
 	}
 
-	setup_srm(obex, pkt, TRUE);
-
 	p = g_new0(struct pending_pkt, 1);
 	p->pkt = pkt;
 
@@ -628,8 +639,6 @@ guint g_obex_send_req(GObex *obex, GObexPacket *req, gint timeout,
 		prepare_srm_req(obex, req);
 	}
 
-	setup_srm(obex, req, TRUE);
-
 	if (obex->conn_id == CONNID_INVALID)
 		goto create_pending;
 
@@ -847,6 +856,9 @@ gboolean g_obex_srm_active(GObex *obex)
 {
 	gboolean ret = FALSE;
 
+	if (!obex->use_srm)
+		return FALSE;
+
 	if (obex->srm == NULL || !obex->srm->enabled)
 		goto done;
 
-- 
1.7.7.5

