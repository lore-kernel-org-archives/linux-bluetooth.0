Return-Path: <cyrus@holtmann.org>
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH obexd 16/16] gobex: handle Single Response Mode Parameters (SRMP) headers
Date: Tue, 27 Dec 2011 11:07:17 +0200
Message-Id: <1324976837-11914-16-git-send-email-luiz.dentz@gmail.com>
In-Reply-To: <1324976837-11914-1-git-send-email-luiz.dentz@gmail.com>
References: <1324976837-11914-1-git-send-email-luiz.dentz@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

From: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>

---
 gobex/gobex.c |   78 +++++++++++++++++++++++++++++++++++++++++++++++++++++---
 1 files changed, 73 insertions(+), 5 deletions(-)

diff --git a/gobex/gobex.c b/gobex/gobex.c
index 54d19ed..9337516 100644
--- a/gobex/gobex.c
+++ b/gobex/gobex.c
@@ -52,7 +52,12 @@ struct srm_setup {
 		SRM_DISABLED		= 0,
 		SRM_INDICATING		= 1,
 		SRM_ENABLED		= 2,
+		SRM_NEXT		= 3,
+		SRM_WAITING		= 4,
+		SRM_NEXT_WAIT		= 5,
 	} state;
+	guint8 srmp;
+	gboolean outgoing;
 };
 
 struct _GObex {
@@ -453,11 +458,60 @@ static const char *state2str(guint mode)
 		return "SRM Indicating";
 	case SRM_ENABLED:
 		return "SRM Enabled";
+	case SRM_NEXT:
+		return "SRM Next";
+	case SRM_WAITING:
+		return "SRM Waiting";
+	case SRM_NEXT_WAIT:
+		return "SRM Next and Wait";
 	default:
 		return "Unkown";
 	}
 }
 
+static void set_srmp(GObex *obex, guint8 srmp, gboolean outgoing)
+{
+	struct srm_setup *setup = obex->srm;
+	guint state = -1;
+
+	if (setup == NULL)
+		return;
+
+	if (setup->state == SRM_DISABLED) {
+		setup->srmp = srmp;
+		setup->outgoing = outgoing;
+		return;
+	}
+
+	/* SRMP header not set */
+	if (srmp > G_OBEX_SRMP_NEXT_WAIT) {
+		if (setup->outgoing == outgoing)
+			state = SRM_ENABLED;
+		goto done;
+	}
+
+	switch (srmp) {
+	case G_OBEX_SRMP_NEXT:
+		state = SRM_NEXT;
+		break;
+	case G_OBEX_SRMP_WAIT:
+		state = SRM_WAITING;
+		break;
+	case G_OBEX_SRMP_NEXT_WAIT:
+		state = SRM_NEXT_WAIT;
+		break;
+	}
+
+done:
+	if (setup->state == state || state > SRM_NEXT_WAIT)
+		return;
+
+	setup->state = state;
+	setup->outgoing = outgoing;
+
+	g_obex_debug(G_OBEX_DEBUG_COMMAND, "%s", state2str(setup->state));
+}
+
 static void set_srm(GObex *obex, guint8 op, guint8 srm)
 {
 	struct srm_setup *setup = obex->srm;
@@ -486,13 +540,18 @@ static void set_srm(GObex *obex, guint8 op, guint8 srm)
 
 	g_obex_debug(G_OBEX_DEBUG_COMMAND, "%s", state2str(setup->state));
 
+	if (setup->srmp <= G_OBEX_SRMP_NEXT_WAIT) {
+		set_srmp(obex, setup->srmp, setup->outgoing);
+		setup->srmp = -1;
+	}
+
 	if (setup->state == SRM_DISABLED) {
 		g_free(obex->srm);
 		obex->srm = NULL;
 	}
 }
 
-static void setup_srm(GObex *obex, GObexPacket *pkt)
+static void setup_srm(GObex *obex, GObexPacket *pkt, gboolean outgoing)
 {
 	GObexHeader *hdr;
 	guint8 op;
@@ -508,6 +567,15 @@ static void setup_srm(GObex *obex, GObexPacket *pkt)
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
 	if (obex->srm == NULL || obex->srm->state == SRM_DISABLED || !final)
 		return;
 
@@ -539,7 +607,7 @@ gboolean g_obex_send(GObex *obex, GObexPacket *pkt, GError **err)
 	if (obex->rx_last_op == G_OBEX_OP_CONNECT)
 		prepare_connect_rsp(obex, pkt);
 
-	setup_srm(obex, pkt);
+	setup_srm(obex, pkt, TRUE);
 
 	p = g_new0(struct pending_pkt, 1);
 	p->pkt = pkt;
@@ -561,7 +629,7 @@ guint g_obex_send_req(GObex *obex, GObexPacket *req, gint timeout,
 
 	g_obex_debug(G_OBEX_DEBUG_COMMAND, "conn %u", obex->conn_id);
 
-	setup_srm(obex, req);
+	setup_srm(obex, req, TRUE);
 
 	if (obex->conn_id == CONNID_INVALID)
 		goto create_pending;
@@ -821,7 +889,7 @@ static gboolean parse_response(GObex *obex, GObexPacket *rsp)
 	if (opcode == G_OBEX_OP_CONNECT)
 		parse_connect_data(obex, rsp);
 
-	setup_srm(obex, rsp);
+	setup_srm(obex, rsp, FALSE);
 
 	if (g_obex_get_srm(obex) != G_OBEX_SRM_ENABLE)
 		return final;
@@ -912,7 +980,7 @@ static guint8 parse_request(GObex *obex, GObexPacket *req)
 		return G_OBEX_RSP_SERVICE_UNAVAILABLE;
 	}
 
-	setup_srm(obex, req);
+	setup_srm(obex, req, FALSE);
 
 	return op;
 }
-- 
1.7.7.4

