Return-Path: <cyrus@holtmann.org>
From: Jakub Adamek <adamek.kuba@gmail.com>
To: linux-bluetooth@vger.kernel.org
Cc: Jakub Adamek <adamek.kuba@gmail.com>
Subject: [PATCH obexd v3 11/11] Add func for fetching header by id from list
Date: Fri, 24 Jun 2011 02:39:17 +0200
Message-Id: <1308875957-13397-12-git-send-email-adamek.kuba@gmail.com>
In-Reply-To: <1308875957-13397-1-git-send-email-adamek.kuba@gmail.com>
References: <1308875957-13397-1-git-send-email-adamek.kuba@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

---
 gwobex/obex-xfer.c |   10 ++++++++++
 gwobex/obex-xfer.h |    2 ++
 2 files changed, 12 insertions(+), 0 deletions(-)

diff --git a/gwobex/obex-xfer.c b/gwobex/obex-xfer.c
index a48d8e8..915f756 100644
--- a/gwobex/obex-xfer.c
+++ b/gwobex/obex-xfer.c
@@ -508,6 +508,16 @@ void a_header_free(struct a_header *ah) {
     g_free(ah);
 }
 
+struct a_header *a_header_find(GSList *aheaders, uint8_t hi) {
+    while (aheaders) {
+        struct a_header *ah = aheaders->data;
+        if (ah->hi == hi)
+            return aheaders->data;
+        aheaders = g_slist_next(aheaders);
+    }
+    return NULL;
+}
+
 void _gw_obex_xfer_free(struct gw_obex_xfer *xfer) {
     GSList *aheaders = xfer->aheaders;
     while (aheaders) {
diff --git a/gwobex/obex-xfer.h b/gwobex/obex-xfer.h
index 25b82b7..33b3361 100644
--- a/gwobex/obex-xfer.h
+++ b/gwobex/obex-xfer.h
@@ -98,6 +98,8 @@ struct a_header *make_a_header(uint8_t hi, obex_headerdata_t hv,
 
 struct a_header *a_header_copy(struct a_header *ah);
 
+struct a_header *a_header_find(GSList *aheaders, uint8_t hi);
+
 struct gw_obex_xfer *gw_obex_xfer_new(struct gw_obex *ctx, gboolean async, int stream_fd);
 
 void _gw_obex_xfer_free(struct gw_obex_xfer *xfer);
-- 
1.7.0.4

