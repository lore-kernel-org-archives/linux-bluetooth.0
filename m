Return-Path: <cyrus@holtmann.org>
From: Jakub Adamek <adamek.kuba@gmail.com>
To: linux-bluetooth@vger.kernel.org
Cc: Jakub Adamek <adamek.kuba@gmail.com>
Subject: [PATCH obexd v3 06/11] Parse headers in a PUT response packet
Date: Fri, 24 Jun 2011 02:39:12 +0200
Message-Id: <1308875957-13397-7-git-send-email-adamek.kuba@gmail.com>
In-Reply-To: <1308875957-13397-1-git-send-email-adamek.kuba@gmail.com>
References: <1308875957-13397-1-git-send-email-adamek.kuba@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

---
 gwobex/obex-priv.c |   69 +++++++++++++++++++++++++++-------------------------
 1 files changed, 36 insertions(+), 33 deletions(-)

diff --git a/gwobex/obex-priv.c b/gwobex/obex-priv.c
index 2073c2c..7e3068b 100644
--- a/gwobex/obex-priv.c
+++ b/gwobex/obex-priv.c
@@ -298,39 +298,6 @@ static void obex_abort_done(GwObex *ctx, obex_object_t *object,
                 optostr((uint8_t)obex_cmd), (uint8_t)obex_cmd);
 }
 
-static void obex_request_done(GwObex *ctx, obex_object_t *object,
-                              int obex_cmd, int obex_rsp) {
-    ctx->done = TRUE;
-    if (ctx->xfer)
-        ctx->xfer->do_cb = TRUE;
-
-    ctx->obex_rsp = obex_rsp;
-
-    if (obex_rsp != OBEX_RSP_SUCCESS) {
-        debug("%s command (0x%02x) failed: %s (0x%02x)\n",
-                optostr((uint8_t)obex_cmd), (uint8_t)obex_cmd,
-                OBEX_ResponseToString(obex_rsp), (uint8_t)obex_rsp);
-#ifdef DEBUG
-        if (obex_rsp == OBEX_RSP_UNAUTHORIZED) {
-            debug("Showing headers..\n");
-            show_headers(ctx->handle, object);
-        }
-#endif
-        return;
-    }
-
-    debug("%s command (0x%02x) succeeded.\n", optostr((uint8_t)obex_cmd),
-            (uint8_t)obex_cmd);
-
-    switch (obex_cmd) {
-        case OBEX_CMD_CONNECT:
-            obex_connect_done(ctx, object, obex_rsp);
-            break;
-        default:
-            break;
-    }
-}
-
 static void get_non_body_headers(obex_t *handle, obex_object_t *object,
                                      struct gw_obex_xfer *xfer) {
     obex_headerdata_t hv;
@@ -371,6 +338,42 @@ static void get_non_body_headers(obex_t *handle, obex_object_t *object,
     OBEX_ObjectReParseHeaders(handle, object);
 }
 
+static void obex_request_done(GwObex *ctx, obex_object_t *object,
+                              int obex_cmd, int obex_rsp) {
+    ctx->done = TRUE;
+    if (ctx->xfer)
+        ctx->xfer->do_cb = TRUE;
+
+    ctx->obex_rsp = obex_rsp;
+
+    if (obex_rsp != OBEX_RSP_SUCCESS) {
+        debug("%s command (0x%02x) failed: %s (0x%02x)\n",
+                optostr((uint8_t)obex_cmd), (uint8_t)obex_cmd,
+                OBEX_ResponseToString(obex_rsp), (uint8_t)obex_rsp);
+#ifdef DEBUG
+        if (obex_rsp == OBEX_RSP_UNAUTHORIZED) {
+            debug("Showing headers..\n");
+            show_headers(ctx->handle, object);
+        }
+#endif
+        return;
+    }
+
+    if (ctx->xfer)
+        get_non_body_headers(ctx->handle, object, ctx->xfer);
+
+    debug("%s command (0x%02x) succeeded.\n", optostr((uint8_t)obex_cmd),
+            (uint8_t)obex_cmd);
+
+    switch (obex_cmd) {
+        case OBEX_CMD_CONNECT:
+            obex_connect_done(ctx, object, obex_rsp);
+            break;
+        default:
+            break;
+    }
+}
+
 static void obex_readstream(GwObex *ctx, obex_object_t *object) {
     struct gw_obex_xfer *xfer = ctx->xfer;
     const uint8_t *buf;
-- 
1.7.0.4

