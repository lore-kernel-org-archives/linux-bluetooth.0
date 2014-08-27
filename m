Return-Path: <cyrus@holtmann.org>
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH BlueZ 6/7] gobex: Add g_obex_abort
Date: Wed, 27 Aug 2014 19:04:49 +0300
Message-Id: <1409155490-25653-6-git-send-email-luiz.dentz@gmail.com>
In-Reply-To: <1409155490-25653-1-git-send-email-luiz.dentz@gmail.com>
References: <1409155490-25653-1-git-send-email-luiz.dentz@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

From: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>

---
 gobex/gobex-transfer.c |  7 ++-----
 gobex/gobex.c          | 10 ++++++++++
 gobex/gobex.h          |  3 +++
 3 files changed, 15 insertions(+), 5 deletions(-)

diff --git a/gobex/gobex-transfer.c b/gobex/gobex-transfer.c
index d7707f9..4e1a6c0 100644
--- a/gobex/gobex-transfer.c
+++ b/gobex/gobex-transfer.c
@@ -152,11 +152,8 @@ static gssize put_get_data(void *buf, gsize len, gpointer user_data)
 		goto done;
 	}
 
-	req = g_obex_packet_new(G_OBEX_OP_ABORT, TRUE, G_OBEX_HDR_INVALID);
-
-	transfer->req_id = g_obex_send_req(transfer->obex, req, -1,
-						transfer_abort_response,
-						transfer, &err);
+	transfer->req_id = g_obex_abort(transfer->obex, transfer_abort_response,
+								transfer, &err);
 done:
 	if (err != NULL) {
 		transfer_complete(transfer, err);
diff --git a/gobex/gobex.c b/gobex/gobex.c
index e9a08fa..42175fc 100644
--- a/gobex/gobex.c
+++ b/gobex/gobex.c
@@ -1676,6 +1676,16 @@ guint g_obex_move(GObex *obex, const char *name, const char *dest,
 	return g_obex_send_req(obex, req, -1, func, user_data, err);
 }
 
+guint g_obex_abort(GObex *obex, GObexResponseFunc func, gpointer user_data,
+								GError **err)
+{
+	GObexPacket *req;
+
+	req = g_obex_packet_new(G_OBEX_OP_ABORT, TRUE, G_OBEX_HDR_INVALID);
+
+	return g_obex_send_req(obex, req, -1, func, user_data, err);
+}
+
 guint8 g_obex_errno_to_rsp(int err)
 {
 	switch (err) {
diff --git a/gobex/gobex.h b/gobex/gobex.h
index 7c47590..fd2b274 100644
--- a/gobex/gobex.h
+++ b/gobex/gobex.h
@@ -95,6 +95,9 @@ guint g_obex_move(GObex *obex, const char *name, const char *dest,
 			GObexResponseFunc func, gpointer user_data,
 			GError **err);
 
+guint g_obex_abort(GObex *obex, GObexResponseFunc func, gpointer user_data,
+								GError **err);
+
 /* Transfer related high-level functions */
 
 guint g_obex_put_req(GObex *obex, GObexDataProducer data_func,
-- 
1.9.3

