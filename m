Return-Path: <cyrus@holtmann.org>
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
To: linux-bluetooth@vger.kernel.org
Cc: patrick.ohly@intel.com
Subject: [PATCH BlueZ 6/8] gobex: Fix not handling SRM properly
Date: Fri, 14 Feb 2014 17:53:02 +0200
Message-Id: <1392393184-15266-6-git-send-email-luiz.dentz@gmail.com>
In-Reply-To: <1392393184-15266-1-git-send-email-luiz.dentz@gmail.com>
References: <1392393184-15266-1-git-send-email-luiz.dentz@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

From: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>

SRM can be enabled but while not active with use of SRMP header so the
handling of this states needs to be separated.
---
 gobex/gobex.c | 24 ++++++++++++++++--------
 1 file changed, 16 insertions(+), 8 deletions(-)

diff --git a/gobex/gobex.c b/gobex/gobex.c
index 8c08b1e..291ed72 100644
--- a/gobex/gobex.c
+++ b/gobex/gobex.c
@@ -355,9 +355,20 @@ done:
 	obex->srm = NULL;
 }
 
+static gboolean g_obex_srm_enabled(GObex *obex)
+{
+	if (!obex->use_srm)
+		return FALSE;
+
+	if (obex->srm == NULL)
+		return FALSE;
+
+	return obex->srm->enabled;
+}
+
 static void check_srm_final(GObex *obex, guint8 op)
 {
-	if (obex->srm == NULL || !obex->srm->enabled)
+	if (!g_obex_srm_enabled(obex))
 		return;
 
 	switch (obex->srm->op) {
@@ -423,7 +434,7 @@ static gboolean write_data(GIOChannel *io, GIOCondition cond,
 
 		setup_srm(obex, p->pkt, TRUE);
 
-		if (g_obex_srm_active(obex))
+		if (g_obex_srm_enabled(obex))
 			goto encode;
 
 		/* Can't send a request while there's a pending one */
@@ -646,7 +657,7 @@ guint g_obex_send_req(GObex *obex, GObexPacket *req, int timeout,
 	if (obex->rx_last_op == G_OBEX_RSP_CONTINUE)
 		goto create_pending;
 
-	if (g_obex_srm_active(obex) && obex->pending_req != NULL)
+	if (g_obex_srm_enabled(obex) && obex->pending_req != NULL)
 		goto create_pending;
 
 	hdr = g_obex_packet_get_header(req, G_OBEX_HDR_CONNECTION);
@@ -860,10 +871,7 @@ gboolean g_obex_srm_active(GObex *obex)
 {
 	gboolean ret = FALSE;
 
-	if (!obex->use_srm)
-		return FALSE;
-
-	if (obex->srm == NULL || !obex->srm->enabled)
+	if (!g_obex_srm_enabled(obex))
 		goto done;
 
 	if (obex->srm->srmp <= G_OBEX_SRMP_NEXT_WAIT)
@@ -912,7 +920,7 @@ static gboolean parse_response(GObex *obex, GObexPacket *rsp)
 
 	setup_srm(obex, rsp, FALSE);
 
-	if (!g_obex_srm_active(obex))
+	if (!g_obex_srm_enabled(obex))
 		return final;
 
 	/*
-- 
1.8.5.3

