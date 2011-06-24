Return-Path: <cyrus@holtmann.org>
From: Jakub Adamek <adamek.kuba@gmail.com>
To: linux-bluetooth@vger.kernel.org
Cc: Jakub Adamek <adamek.kuba@gmail.com>
Subject: [PATCH obexd v3 02/11] Add list to store received headers
Date: Fri, 24 Jun 2011 02:39:08 +0200
Message-Id: <1308875957-13397-3-git-send-email-adamek.kuba@gmail.com>
In-Reply-To: <1308875957-13397-1-git-send-email-adamek.kuba@gmail.com>
References: <1308875957-13397-1-git-send-email-adamek.kuba@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

The list is a GSList of a_header structs added to gw_obex_xfer for
storing received a_header objects.
---
 gwobex/gw-obex.h   |    7 +++++++
 gwobex/obex-xfer.c |   20 ++++++++++++++++++++
 gwobex/obex-xfer.h |    5 +++++
 3 files changed, 32 insertions(+), 0 deletions(-)

diff --git a/gwobex/gw-obex.h b/gwobex/gw-obex.h
index c858341..0638f45 100644
--- a/gwobex/gw-obex.h
+++ b/gwobex/gw-obex.h
@@ -583,6 +583,13 @@ gint gw_obex_xfer_object_size(GwObexXfer *xfer);
  */
 unsigned char *gw_obex_xfer_object_apparam(GwObexXfer *xfer, size_t *apparam_size);
 
+/** Get the additional header list
+ *
+ * @param xfer Pointer returned by gw_obex_put_async or gw_obex_get_async
+ *
+ * @returns The pointer to the GSList that contains the headers
+ */
+GSList *gw_obex_xfer_object_aheaders(GwObexXfer *xfer);
 
 /** Returns if a transfer is already done
  *
diff --git a/gwobex/obex-xfer.c b/gwobex/obex-xfer.c
index 4013687..1430f10 100644
--- a/gwobex/obex-xfer.c
+++ b/gwobex/obex-xfer.c
@@ -202,6 +202,10 @@ unsigned char *gw_obex_xfer_object_apparam(GwObexXfer *xfer, size_t *apparam_siz
     return xfer->apparam_buf;
 }
 
+GSList *gw_obex_xfer_object_aheaders(GwObexXfer *xfer) {
+    return xfer->aheaders;
+}
+
 gboolean gw_obex_xfer_object_done(GwObexXfer *xfer) {
     return xfer->ctx->done;
 }
@@ -418,7 +422,23 @@ out:
     return ret;
 }
 
+void a_header_free(struct a_header *ah) {
+    switch (ah->hi & OBEX_HDR_TYPE_MASK) {
+        case OBEX_HDR_TYPE_BYTES:
+        case OBEX_HDR_TYPE_UNICODE:
+            g_free((gpointer) ah->hv.bs);
+            break;
+    }
+    g_free(ah);
+}
+
 void _gw_obex_xfer_free(struct gw_obex_xfer *xfer) {
+    GSList *aheaders = xfer->aheaders;
+    while (aheaders) {
+        a_header_free(aheaders->data);
+        aheaders = g_slist_next(aheaders);
+    }
+    g_slist_free(xfer->aheaders);
     g_free(xfer->buf);
     g_free(xfer->apparam_buf);
     g_free(xfer);
diff --git a/gwobex/obex-xfer.h b/gwobex/obex-xfer.h
index 9bc832d..b1e2ff0 100644
--- a/gwobex/obex-xfer.h
+++ b/gwobex/obex-xfer.h
@@ -62,6 +62,9 @@ struct gw_obex_xfer {
     unsigned char           *apparam_buf;
     size_t                   apparam_size;
 
+    /* Additional headers, in the order they were received */
+    GSList                  *aheaders;
+
     /* These two elements are only used for async transfers */
     size_t                   data_start;
     size_t                   data_length;
@@ -88,6 +91,8 @@ struct a_header {
     uint32_t hv_size;
 };
 
+void a_header_free(struct a_header *ah);
+
 struct gw_obex_xfer *gw_obex_xfer_new(struct gw_obex *ctx, gboolean async, int stream_fd);
 
 void _gw_obex_xfer_free(struct gw_obex_xfer *xfer);
-- 
1.7.0.4

