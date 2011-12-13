Return-Path: <cyrus@holtmann.org>
From: Mikel Astiz <mikel.astiz@bmw-carit.de>
To: <linux-bluetooth@vger.kernel.org>
CC: Mikel Astiz <mikel.astiz@bmw-carit.de>
Subject: [PATCH obexd] gobex: fix transfer search in transfer_complete
Date: Tue, 13 Dec 2011 17:21:22 +0100
Message-ID: <1323793282-24497-1-git-send-email-mikel.astiz@bmw-carit.de>
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

The previous approach searched the transfer pointer itself, assuming
that the transfers has not been modified if the pointer is in the list.
However the callback could have removed the transfer and registered
another one, which can eventually point to the same memory location.

This is solved by looking for the transfer id instead of the pointer.
---
 gobex/gobex-transfer.c |   30 +++++++++++++++++++-----------
 1 files changed, 19 insertions(+), 11 deletions(-)

diff --git a/gobex/gobex-transfer.c b/gobex/gobex-transfer.c
index f5222cd..692d713 100644
--- a/gobex/gobex-transfer.c
+++ b/gobex/gobex-transfer.c
@@ -77,14 +77,30 @@ static void transfer_free(struct transfer *transfer)
 	g_free(transfer);
 }
 
+static struct transfer *find_transfer(guint id)
+{
+	GSList *l;
+
+	for (l = transfers; l != NULL; l = g_slist_next(l)) {
+		struct transfer *t = l->data;
+		if (t->id == id)
+			return t;
+	}
+
+	return NULL;
+}
+
 static void transfer_complete(struct transfer *transfer, GError *err)
 {
-	g_obex_debug(G_OBEX_DEBUG_TRANSFER, "transfer %u", transfer->id);
+	guint id = transfer->id;
+
+	g_obex_debug(G_OBEX_DEBUG_TRANSFER, "transfer %u", id);
 
 	transfer->complete_func(transfer->obex, err, transfer->user_data);
 	/* Check if the complete_func removed the transfer */
-	if (g_slist_find(transfers, transfer) == NULL)
+	if (find_transfer(id) == NULL)
 		return;
+
 	transfer_free(transfer);
 }
 
@@ -425,7 +441,6 @@ guint g_obex_get_req_pkt(GObex *obex, GObexPacket *req,
 
 	transfer = transfer_new(obex, G_OBEX_OP_GET, complete_func, user_data);
 	transfer->data_consumer = data_func;
-
 	transfer->req_id = g_obex_send_req(obex, req, FIRST_PACKET_TIMEOUT,
 					transfer_response, transfer, err);
 	if (transfer->req_id == 0) {
@@ -573,17 +588,10 @@ guint g_obex_get_rsp(GObex *obex, GObexDataProducer data_func,
 gboolean g_obex_cancel_transfer(guint id)
 {
 	struct transfer *transfer = NULL;
-	GSList *l;
 
 	g_obex_debug(G_OBEX_DEBUG_TRANSFER, "transfer %u", id);
 
-	for (l = transfers; l != NULL; l = g_slist_next(l)) {
-		struct transfer *t = l->data;
-		if (t->id == id) {
-			transfer = t;
-			break;
-		}
-	}
+	transfer = find_transfer(id);
 
 	if (transfer == NULL)
 		return FALSE;
-- 
1.7.6.4

