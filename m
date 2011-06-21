Return-Path: <cyrus@holtmann.org>
From: Jakub Adamek <adamek.kuba@gmail.com>
To: linux-bluetooth@vger.kernel.org
Cc: Jakub Adamek <adamek.kuba@gmail.com>
Subject: [PATCH obexd v2 08/11] Reorder headers to conform to BIP's requirements
Date: Wed, 22 Jun 2011 00:24:22 +0200
Message-Id: <1308695065-3784-9-git-send-email-adamek.kuba@gmail.com>
In-Reply-To: <1308695065-3784-1-git-send-email-adamek.kuba@gmail.com>
References: <1308695065-3784-1-git-send-email-adamek.kuba@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

---
 gwobex/obex-priv.c |   20 ++++++++++----------
 1 files changed, 10 insertions(+), 10 deletions(-)

diff --git a/gwobex/obex-priv.c b/gwobex/obex-priv.c
index 420d9bc..c92160d 100644
--- a/gwobex/obex-priv.c
+++ b/gwobex/obex-priv.c
@@ -882,11 +882,6 @@ gboolean gw_obex_get_with_aheaders(GwObex *ctx,
         OBEX_ObjectAddHeader(ctx->handle, object, OBEX_HDR_CONNECTION, hv, 4, 0);
     }
 
-    if (apparam && apparam_size > 0) {
-        hv.bs = (unsigned char *)apparam;
-        OBEX_ObjectAddHeader(ctx->handle, object, OBEX_HDR_APPARAM, hv, apparam_size, 0);
-    }
-
     if (type) {
         hv.bs = (unsigned char *)type;
         OBEX_ObjectAddHeader(ctx->handle, object, OBEX_HDR_TYPE, hv, strlen(type) + 1, 0);
@@ -923,6 +918,11 @@ gboolean gw_obex_get_with_aheaders(GwObex *ctx,
         }
     }
 
+    if (apparam && apparam_size > 0) {
+        hv.bs = (unsigned char *)apparam;
+        OBEX_ObjectAddHeader(ctx->handle, object, OBEX_HDR_APPARAM, hv, apparam_size, 0);
+    }
+
     if (aheaders) {
         const GSList *hlist = aheaders;
         struct a_header *ah;
@@ -1057,6 +1057,11 @@ gboolean gw_obex_put_with_aheaders(GwObex *ctx,
         OBEX_ObjectAddHeader(ctx->handle, object, OBEX_HDR_CONNECTION, hv, 4, 0);
     }
 
+    if (type) {
+        hv.bs = (unsigned char *)type;
+        OBEX_ObjectAddHeader(ctx->handle, object, OBEX_HDR_TYPE, hv, strlen(type) + 1, 0);
+    }
+
     if (uname) {
         hv.bs = (unsigned char *)uname;
         OBEX_ObjectAddHeader(ctx->handle, object, OBEX_HDR_NAME, hv, uname_len, 0);
@@ -1064,11 +1069,6 @@ gboolean gw_obex_put_with_aheaders(GwObex *ctx,
         uname = NULL;
     }
 
-    if (type) {
-        hv.bs = (unsigned char *)type;
-        OBEX_ObjectAddHeader(ctx->handle, object, OBEX_HDR_TYPE, hv, strlen(type) + 1, 0);
-    }
-
     if (apparam && apparam_size > 0) {
         hv.bs = (unsigned char *)apparam;
         OBEX_ObjectAddHeader(ctx->handle, object, OBEX_HDR_APPARAM, hv, apparam_size, 0);
-- 
1.7.0.4

