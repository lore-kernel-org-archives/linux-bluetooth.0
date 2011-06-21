Return-Path: <cyrus@holtmann.org>
From: Jakub Adamek <adamek.kuba@gmail.com>
To: linux-bluetooth@vger.kernel.org
Cc: Jakub Adamek <adamek.kuba@gmail.com>
Subject: [PATCH obexd v2 03/11] Add function to create fresh a_header
Date: Wed, 22 Jun 2011 00:24:17 +0200
Message-Id: <1308695065-3784-4-git-send-email-adamek.kuba@gmail.com>
In-Reply-To: <1308695065-3784-1-git-send-email-adamek.kuba@gmail.com>
References: <1308695065-3784-1-git-send-email-adamek.kuba@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

---
 gwobex/obex-xfer.c |   25 +++++++++++++++++++++++++
 gwobex/obex-xfer.h |    3 +++
 2 files changed, 28 insertions(+), 0 deletions(-)

diff --git a/gwobex/obex-xfer.c b/gwobex/obex-xfer.c
index 1430f10..55ea842 100644
--- a/gwobex/obex-xfer.c
+++ b/gwobex/obex-xfer.c
@@ -422,6 +422,31 @@ out:
     return ret;
 }
 
+struct a_header *make_a_header(uint8_t hi, obex_headerdata_t hv,
+        unsigned int hlen) {
+    struct a_header *ah = g_new0(struct a_header, 1);
+    ah->hi = hi;
+    ah->hv_size = hlen;
+    switch (hi & OBEX_HDR_TYPE_MASK) {
+        case OBEX_HDR_TYPE_UINT8:
+        case OBEX_HDR_TYPE_UINT32:
+            ah->hv = hv;
+            break;
+        case OBEX_HDR_TYPE_BYTES:
+        case OBEX_HDR_TYPE_UNICODE:
+            ah->hv.bs = g_try_malloc(hlen);
+            if (ah->hv.bs != NULL)
+                memcpy((void *) ah->hv.bs, hv.bs, hlen);
+            else if (hlen > 0) {
+                g_free(ah);
+                return NULL;
+            }
+            ah->hv_size = hlen;
+        break;
+    }
+    return ah;
+}
+
 void a_header_free(struct a_header *ah) {
     switch (ah->hi & OBEX_HDR_TYPE_MASK) {
         case OBEX_HDR_TYPE_BYTES:
diff --git a/gwobex/obex-xfer.h b/gwobex/obex-xfer.h
index b1e2ff0..7c59827 100644
--- a/gwobex/obex-xfer.h
+++ b/gwobex/obex-xfer.h
@@ -93,6 +93,9 @@ struct a_header {
 
 void a_header_free(struct a_header *ah);
 
+struct a_header *make_a_header(uint8_t hi, obex_headerdata_t hv,
+                                             unsigned int hlen);
+
 struct gw_obex_xfer *gw_obex_xfer_new(struct gw_obex *ctx, gboolean async, int stream_fd);
 
 void _gw_obex_xfer_free(struct gw_obex_xfer *xfer);
-- 
1.7.0.4

