Return-Path: <cyrus@holtmann.org>
From: Jaganath Kanakkassery <jaganath.k@samsung.com>
To: linux-bluetooth@vger.kernel.org
Cc: Jaganath Kanakkassery <jaganath.k@samsung.com>
Subject: [PATCH obexd 1/2] gobex: flush tx_queue before disconnection
Date: Thu, 08 Mar 2012 12:18:23 +0530
Message-id: <1331189303-6734-1-git-send-email-jaganath.k@samsung.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

This patch send the packets in tx_queue before the actual disconnection
If the operation is aborted it just sends ABORT and ignore the
rest of the packets in the queue.
---
 gobex/gobex.c |    8 +++++++-
 1 files changed, 7 insertions(+), 1 deletions(-)

diff --git a/gobex/gobex.c b/gobex/gobex.c
index bc76e57..496de46 100644
--- a/gobex/gobex.c
+++ b/gobex/gobex.c
@@ -1324,7 +1324,7 @@ GObex *g_obex_ref(GObex *obex)
 
 void g_obex_unref(GObex *obex)
 {
-	gboolean last_ref;
+	gboolean last_ref, ret;
 
 	last_ref = g_atomic_int_dec_and_test(&obex->ref_count);
 
@@ -1335,6 +1335,12 @@ void g_obex_unref(GObex *obex)
 
 	g_slist_free_full(obex->req_handlers, g_free);
 
+	do {
+		ret = write_data(obex->io, G_IO_OUT, obex);
+		if (obex->pending_req && obex->pending_req->cancelled)
+			break;
+	} while(ret);
+
 	g_queue_foreach(obex->tx_queue, (GFunc) pending_pkt_free, NULL);
 	g_queue_free(obex->tx_queue);
 
-- 
1.7.1

