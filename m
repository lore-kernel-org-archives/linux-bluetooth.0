Return-Path: <cyrus@holtmann.org>
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH BlueZ 2/2] gobex: Fix being able to cancel completed requests
Date: Mon,  7 Apr 2014 14:03:08 +0300
Message-Id: <1396868588-20875-2-git-send-email-luiz.dentz@gmail.com>
In-Reply-To: <1396868588-20875-1-git-send-email-luiz.dentz@gmail.com>
References: <1396868588-20875-1-git-send-email-luiz.dentz@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

From: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>

This fixes bogus responses when rsp_func calls g_obex_cancel_req for
responses with final bit set.
---
 gobex/gobex.c | 8 +++++---
 1 file changed, 5 insertions(+), 3 deletions(-)

diff --git a/gobex/gobex.c b/gobex/gobex.c
index 7f85938..850e288 100644
--- a/gobex/gobex.c
+++ b/gobex/gobex.c
@@ -1098,6 +1098,10 @@ static void handle_response(GObex *obex, GError *err, GObexPacket *rsp)
 
 	p = obex->pending_req;
 
+	/* Reset if final so it can no longer be cancelled */
+	if (final_rsp)
+		obex->pending_req = NULL;
+
 	if (p->cancelled)
 		err = g_error_new(G_OBEX_ERROR, G_OBEX_ERROR_CANCELLED,
 					"The operation was cancelled");
@@ -1116,10 +1120,8 @@ static void handle_response(GObex *obex, GError *err, GObexPacket *rsp)
 	if (p->cancelled)
 		g_error_free(err);
 
-	if (final_rsp) {
+	if (final_rsp)
 		pending_pkt_free(p);
-		obex->pending_req = NULL;
-	}
 
 	if (!disconn && g_queue_get_length(obex->tx_queue) > 0)
 		enable_tx(obex);
-- 
1.9.0

