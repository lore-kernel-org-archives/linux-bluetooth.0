Return-Path: <cyrus@holtmann.org>
From: Jakub Adamek <adamek.kuba@gmail.com>
To: linux-bluetooth@vger.kernel.org
Cc: Jakub Adamek <adamek.kuba@gmail.com>
Subject: [PATCH obexd 09/10] Convenience method to make deep copy of a_header
Date: Sun, 19 Jun 2011 02:59:45 +0200
Message-Id: <1308445186-27135-10-git-send-email-adamek.kuba@gmail.com>
In-Reply-To: <1308445186-27135-1-git-send-email-adamek.kuba@gmail.com>
References: <1308445186-27135-1-git-send-email-adamek.kuba@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

---
 gwobex/obex-xfer.c |   13 +++++++++++++
 gwobex/obex-xfer.h |    2 ++
 2 files changed, 15 insertions(+), 0 deletions(-)

diff --git a/gwobex/obex-xfer.c b/gwobex/obex-xfer.c
index 6d65197..20a3221 100644
--- a/gwobex/obex-xfer.c
+++ b/gwobex/obex-xfer.c
@@ -449,6 +449,19 @@ out:
     return ret;
 }
 
+struct a_header *a_header_copy(struct a_header *ah) {
+    struct a_header *res;
+    if(!ah) return NULL;
+    res = g_memdup(ah, sizeof(struct a_header));
+    switch (res->hi & OBEX_HDR_TYPE_MASK) {
+        case OBEX_HDR_TYPE_BYTES:
+        case OBEX_HDR_TYPE_UNICODE:
+            res->hv.bs = g_memdup(ah->hv.bs, ah->hv_size);
+            break;
+    }
+    return res;
+}
+
 void a_header_free(struct a_header *ah) {
     switch (ah->hi & OBEX_HDR_TYPE_MASK) {
         case OBEX_HDR_TYPE_BYTES:
diff --git a/gwobex/obex-xfer.h b/gwobex/obex-xfer.h
index b1e2ff0..61aa048 100644
--- a/gwobex/obex-xfer.h
+++ b/gwobex/obex-xfer.h
@@ -93,6 +93,8 @@ struct a_header {
 
 void a_header_free(struct a_header *ah);
 
+struct a_header *a_header_copy(struct a_header *ah);
+
 struct gw_obex_xfer *gw_obex_xfer_new(struct gw_obex *ctx, gboolean async, int stream_fd);
 
 void _gw_obex_xfer_free(struct gw_obex_xfer *xfer);
-- 
1.7.0.4

