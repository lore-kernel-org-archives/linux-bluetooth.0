Return-Path: <cyrus@holtmann.org>
From: Szymon Janc <szymon.janc@tieto.com>
To: linux-bluetooth@vger.kernel.org
Cc: Szymon Janc <szymon.janc@tieto.com>
Subject: [PATCH 2/2] gobex: Fix removing invalid source
Date: Thu, 17 Apr 2014 15:59:46 +0200
Message-Id: <1397743186-29897-2-git-send-email-szymon.janc@tieto.com>
In-Reply-To: <1397743186-29897-1-git-send-email-szymon.janc@tieto.com>
References: <1397743186-29897-1-git-send-email-szymon.janc@tieto.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Since GLib 2.39 calling g_source_remove on already removed source
is causing critical warning.

This was affecting unit/test-gobex-transfer when running with
GLib 2.40.

/gobex/test_packet_get_req_suspend_resume:
(./unit/test-gobex-transfer:28879): GLib-CRITICAL **: Source ID 263 was
    not found when attempting to remove it
Trace/breakpoint trap
---
 gobex/gobex.c | 22 +++++++++++++++++-----
 1 file changed, 17 insertions(+), 5 deletions(-)

diff --git a/gobex/gobex.c b/gobex/gobex.c
index 887e2a2..ee7d494 100644
--- a/gobex/gobex.c
+++ b/gobex/gobex.c
@@ -263,6 +263,8 @@ static gboolean req_timeout(gpointer user_data)
 	g_error_free(err);
 	pending_pkt_free(p);
 
+	p->timeout_id = 0;
+
 	return FALSE;
 }
 
@@ -778,7 +780,9 @@ static gboolean pending_req_abort(GObex *obex, GError **err)
 
 	p->cancelled = TRUE;
 
-	g_source_remove(p->timeout_id);
+	if (p->timeout_id > 0)
+		g_source_remove(p->timeout_id);
+
 	p->timeout = G_OBEX_ABORT_TIMEOUT;
 	p->timeout_id = g_timeout_add_seconds(p->timeout, req_timeout, obex);
 
@@ -922,7 +926,11 @@ static void g_obex_srm_suspend(GObex *obex)
 	struct pending_pkt *p = obex->pending_req;
 	GObexPacket *req;
 
-	g_source_remove(p->timeout_id);
+	if (p->timeout_id) {
+		g_source_remove(p->timeout_id);
+		p->timeout_id = 0;
+	}
+
 	p->suspended = TRUE;
 
 	req = g_obex_packet_new(G_OBEX_OP_GET, TRUE,
@@ -1017,8 +1025,10 @@ static void auth_challenge(GObex *obex)
 
 	/* Remove it as pending and add it back to the queue so it gets sent
 	 * again */
-	g_source_remove(p->timeout_id);
-	p->timeout_id = 0;
+	if (p->timeout_id) {
+		g_source_remove(p->timeout_id);
+		p->timeout_id = 0;
+	}
 	obex->pending_req = NULL;
 	g_obex_send_internal(obex, p, NULL);
 }
@@ -1076,7 +1086,9 @@ static gboolean parse_response(GObex *obex, GObexPacket *rsp)
 	 * continue sending responses until the transfer is finished
 	 */
 	if (opcode == G_OBEX_OP_GET && rspcode == G_OBEX_RSP_CONTINUE) {
-		g_source_remove(p->timeout_id);
+		if (p->timeout_id)
+			g_source_remove(p->timeout_id);
+
 		p->timeout_id = g_timeout_add_seconds(p->timeout, req_timeout,
 									obex);
 		return FALSE;
-- 
1.9.1

