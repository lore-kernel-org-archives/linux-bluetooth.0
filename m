Return-Path: <cyrus@holtmann.org>
From: Jakub Adamek <adamek.kuba@gmail.com>
To: linux-bluetooth@vger.kernel.org
Cc: Jakub Adamek <adamek.kuba@gmail.com>
Subject: [PATCH obexd v3 10/11] Convenience method to make deep copy of a_header
Date: Fri, 24 Jun 2011 02:39:16 +0200
Message-Id: <1308875957-13397-11-git-send-email-adamek.kuba@gmail.com>
In-Reply-To: <1308875957-13397-1-git-send-email-adamek.kuba@gmail.com>
References: <1308875957-13397-1-git-send-email-adamek.kuba@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

---
 gwobex/obex-xfer.c |   14 ++++++++++++++
 gwobex/obex-xfer.h |    2 ++
 2 files changed, 16 insertions(+), 0 deletions(-)

diff --git a/gwobex/obex-xfer.c b/gwobex/obex-xfer.c
index 4c9b5ee..a48d8e8 100644
--- a/gwobex/obex-xfer.c
+++ b/gwobex/obex-xfer.c
@@ -484,6 +484,20 @@ struct a_header *make_a_header(uint8_t hi, obex_headerdata_t hv,
     return ah;
 }
 
+struct a_header *a_header_copy(struct a_header *ah) {
+    struct a_header *res;
+    if (ah == NULL)
+        return NULL;
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
index 6c92ef6..25b82b7 100644
--- a/gwobex/obex-xfer.h
+++ b/gwobex/obex-xfer.h
@@ -96,6 +96,8 @@ void a_header_free(struct a_header *ah);
 struct a_header *make_a_header(uint8_t hi, obex_headerdata_t hv,
                                unsigned int hlen);
 
+struct a_header *a_header_copy(struct a_header *ah);
+
 struct gw_obex_xfer *gw_obex_xfer_new(struct gw_obex *ctx, gboolean async, int stream_fd);
 
 void _gw_obex_xfer_free(struct gw_obex_xfer *xfer);
-- 
1.7.0.4

