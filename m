Return-Path: <cyrus@holtmann.org>
From: Jaganath Kanakkassery <jaganath.k@samsung.com>
To: linux-bluetooth@vger.kernel.org
Cc: Jaganath Kanakkassery <jaganath.k@samsung.com>
Subject: [PATCH obexd 1/2] gobex: Introduce g_obex_abort_transfer()
Date: Tue, 27 Mar 2012 16:02:31 +0530
Message-id: <1332844351-13732-1-git-send-email-jaganath.k@samsung.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

This function sends the abort request and wait for response before
disconnection. This patch fixes the issue ABORT packet not sending
when user cancels the transfer.
---
 gobex/gobex-transfer.c |   22 +++++++++++++++++++++-
 gobex/gobex.c          |    4 ++--
 gobex/gobex.h          |    4 ++++
 3 files changed, 27 insertions(+), 3 deletions(-)

diff --git a/gobex/gobex-transfer.c b/gobex/gobex-transfer.c
index c62a91e..1033b08 100644
--- a/gobex/gobex-transfer.c
+++ b/gobex/gobex-transfer.c
@@ -99,7 +99,8 @@ static void transfer_complete(struct transfer *transfer, GError *err)
 
 	g_obex_debug(G_OBEX_DEBUG_TRANSFER, "transfer %u", id);
 
-	transfer->complete_func(transfer->obex, err, transfer->user_data);
+	if (transfer->complete_func)
+		transfer->complete_func(transfer->obex, err, transfer->user_data);
 	/* Check if the complete_func removed the transfer */
 	if (find_transfer(id) == NULL)
 		return;
@@ -638,3 +639,22 @@ gboolean g_obex_cancel_transfer(guint id)
 	transfer_free(transfer);
 	return TRUE;
 }
+
+gboolean g_obex_abort_transfer(guint id)
+{
+	struct transfer *transfer = NULL;
+
+	g_obex_debug(G_OBEX_DEBUG_TRANSFER, "transfer %u", id);
+
+	transfer = find_transfer(id);
+
+	if (transfer == NULL)
+		return FALSE;
+
+	if (!g_obex_pending_req_abort(transfer->obex, NULL))
+		transfer_free(transfer);
+	else
+		transfer->complete_func = NULL;
+
+	return TRUE;
+}
diff --git a/gobex/gobex.c b/gobex/gobex.c
index bc76e57..bbdac9f 100644
--- a/gobex/gobex.c
+++ b/gobex/gobex.c
@@ -685,7 +685,7 @@ static gint pending_pkt_cmp(gconstpointer a, gconstpointer b)
 	return (p->id - id);
 }
 
-static gboolean pending_req_abort(GObex *obex, GError **err)
+gboolean g_obex_pending_req_abort(GObex *obex, GError **err)
 {
 	struct pending_pkt *p = obex->pending_req;
 	GObexPacket *req;
@@ -729,7 +729,7 @@ gboolean g_obex_cancel_req(GObex *obex, guint req_id, gboolean remove_callback)
 	struct pending_pkt *p;
 
 	if (obex->pending_req && obex->pending_req->id == req_id) {
-		if (!pending_req_abort(obex, NULL)) {
+		if (!g_obex_pending_req_abort(obex, NULL)) {
 			p = obex->pending_req;
 			obex->pending_req = NULL;
 			goto immediate_completion;
diff --git a/gobex/gobex.h b/gobex/gobex.h
index aacdb53..72964e2 100644
--- a/gobex/gobex.h
+++ b/gobex/gobex.h
@@ -49,6 +49,8 @@ guint g_obex_send_req(GObex *obex, GObexPacket *req, gint timeout,
 gboolean g_obex_cancel_req(GObex *obex, guint req_id,
 						gboolean remove_callback);
 
+gboolean g_obex_pending_req_abort(GObex *obex, GError **err);
+
 gboolean g_obex_send_rsp(GObex *obex, guint8 rspcode, GError **err,
 						guint8 first_hdr_type, ...);
 
@@ -124,6 +126,8 @@ guint g_obex_get_rsp_pkt(GObex *obex, GObexPacket *rsp,
 
 gboolean g_obex_cancel_transfer(guint id);
 
+gboolean g_obex_abort_transfer(guint id);
+
 const char *g_obex_strerror(guint8 err_code);
 guint8 g_obex_errno_to_rsp(int err);
 
-- 
1.7.1

