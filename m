Return-Path: <cyrus@holtmann.org>
From: Jaganath Kanakkassery <jaganath.k@samsung.com>
To: linux-bluetooth@vger.kernel.org
Cc: Jaganath Kanakkassery <jaganath.k@samsung.com>
Subject: [PATCH obexd v2 1/3] gobex: Add callback and userdata parameter to
 g_obex_cancel_transfer()
Date: Fri, 04 May 2012 15:27:04 +0530
Message-id: <1336125426-30445-1-git-send-email-jaganath.k@samsung.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

If callback is provided in g_obex_cancel_transfer() current complete
callback will be replaced by the new one and user will be informed
when abort completes.
---
 gobex/gobex-transfer.c |   17 +++++++++++++++--
 gobex/gobex.c          |    4 ++--
 gobex/gobex.h          |    5 ++++-
 3 files changed, 21 insertions(+), 5 deletions(-)

diff --git a/gobex/gobex-transfer.c b/gobex/gobex-transfer.c
index c62a91e..724c788 100644
--- a/gobex/gobex-transfer.c
+++ b/gobex/gobex-transfer.c
@@ -624,9 +624,11 @@ guint g_obex_get_rsp(GObex *obex, GObexDataProducer data_func,
 							user_data, err);
 }
 
-gboolean g_obex_cancel_transfer(guint id)
+gboolean g_obex_cancel_transfer(guint id, GObexFunc complete_func,
+			gpointer user_data)
 {
 	struct transfer *transfer = NULL;
+	gboolean ret = TRUE;
 
 	g_obex_debug(G_OBEX_DEBUG_TRANSFER, "transfer %u", id);
 
@@ -635,6 +637,17 @@ gboolean g_obex_cancel_transfer(guint id)
 	if (transfer == NULL)
 		return FALSE;
 
+	if (complete_func == NULL)
+		goto done;
+
+	transfer->complete_func = complete_func;
+	transfer->user_data = user_data;
+
+	ret = g_obex_pending_req_abort(transfer->obex, NULL);
+	if (ret)
+		return TRUE;
+
+done:
 	transfer_free(transfer);
-	return TRUE;
+	return ret;
 }
diff --git a/gobex/gobex.c b/gobex/gobex.c
index f31b733..b20542d 100644
--- a/gobex/gobex.c
+++ b/gobex/gobex.c
@@ -684,7 +684,7 @@ static gint pending_pkt_cmp(gconstpointer a, gconstpointer b)
 	return (p->id - id);
 }
 
-static gboolean pending_req_abort(GObex *obex, GError **err)
+gboolean g_obex_pending_req_abort(GObex *obex, GError **err)
 {
 	struct pending_pkt *p = obex->pending_req;
 	GObexPacket *req;
@@ -728,7 +728,7 @@ gboolean g_obex_cancel_req(GObex *obex, guint req_id, gboolean remove_callback)
 	struct pending_pkt *p;
 
 	if (obex->pending_req && obex->pending_req->id == req_id) {
-		if (!pending_req_abort(obex, NULL)) {
+		if (!g_obex_pending_req_abort(obex, NULL)) {
 			p = obex->pending_req;
 			obex->pending_req = NULL;
 			goto immediate_completion;
diff --git a/gobex/gobex.h b/gobex/gobex.h
index aacdb53..3120da2 100644
--- a/gobex/gobex.h
+++ b/gobex/gobex.h
@@ -49,6 +49,8 @@ guint g_obex_send_req(GObex *obex, GObexPacket *req, gint timeout,
 gboolean g_obex_cancel_req(GObex *obex, guint req_id,
 						gboolean remove_callback);
 
+gboolean g_obex_pending_req_abort(GObex *obex, GError **err);
+
 gboolean g_obex_send_rsp(GObex *obex, guint8 rspcode, GError **err,
 						guint8 first_hdr_type, ...);
 
@@ -122,7 +124,8 @@ guint g_obex_get_rsp_pkt(GObex *obex, GObexPacket *rsp,
 			GObexDataProducer data_func, GObexFunc complete_func,
 			gpointer user_data, GError **err);
 
-gboolean g_obex_cancel_transfer(guint id);
+gboolean g_obex_cancel_transfer(guint id, GObexFunc complete_func,
+							gpointer user_data);
 
 const char *g_obex_strerror(guint8 err_code);
 guint8 g_obex_errno_to_rsp(int err);
-- 
1.7.1

