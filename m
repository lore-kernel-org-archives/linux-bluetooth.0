Return-Path: <cyrus@holtmann.org>
From: Jakub Adamek <adamek.kuba@gmail.com>
To: linux-bluetooth@vger.kernel.org
Cc: Jakub Adamek <adamek.kuba@gmail.com>
Subject: [PATCH obexd 10/10] Add func for fetching header by id from list
Date: Sun, 19 Jun 2011 02:59:46 +0200
Message-Id: <1308445186-27135-11-git-send-email-adamek.kuba@gmail.com>
In-Reply-To: <1308445186-27135-1-git-send-email-adamek.kuba@gmail.com>
References: <1308445186-27135-1-git-send-email-adamek.kuba@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

---
 gwobex/obex-xfer.c |   10 ++++++++++
 gwobex/obex-xfer.h |    2 ++
 2 files changed, 12 insertions(+), 0 deletions(-)

diff --git a/gwobex/obex-xfer.c b/gwobex/obex-xfer.c
index 20a3221..413fed9 100644
--- a/gwobex/obex-xfer.c
+++ b/gwobex/obex-xfer.c
@@ -472,6 +472,16 @@ void a_header_free(struct a_header *ah) {
     g_free(ah);
 }
 
+struct a_header *a_header_find(GSList *aheaders, uint8_t hi) {
+    while (aheaders) {
+        if (((struct a_header *)aheaders->data)->hi == hi) {
+            return aheaders->data;
+        }
+        aheaders = g_slist_next(aheaders);
+    }
+    return NULL;
+}
+
 void _gw_obex_xfer_free(struct gw_obex_xfer *xfer) {
     GSList *aheaders = xfer->aheaders;
     while (aheaders) {
diff --git a/gwobex/obex-xfer.h b/gwobex/obex-xfer.h
index 61aa048..50dadad 100644
--- a/gwobex/obex-xfer.h
+++ b/gwobex/obex-xfer.h
@@ -95,6 +95,8 @@ void a_header_free(struct a_header *ah);
 
 struct a_header *a_header_copy(struct a_header *ah);
 
+struct a_header *a_header_find(GSList *aheaders, uint8_t hi);
+
 struct gw_obex_xfer *gw_obex_xfer_new(struct gw_obex *ctx, gboolean async, int stream_fd);
 
 void _gw_obex_xfer_free(struct gw_obex_xfer *xfer);
-- 
1.7.0.4

