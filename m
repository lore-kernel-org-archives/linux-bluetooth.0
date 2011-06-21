Return-Path: <cyrus@holtmann.org>
From: Jakub Adamek <adamek.kuba@gmail.com>
To: linux-bluetooth@vger.kernel.org
Cc: Jakub Adamek <adamek.kuba@gmail.com>
Subject: [PATCH obexd v2 07/11] Add functions for async requests w a_header list
Date: Wed, 22 Jun 2011 00:24:21 +0200
Message-Id: <1308695065-3784-8-git-send-email-adamek.kuba@gmail.com>
In-Reply-To: <1308695065-3784-1-git-send-email-adamek.kuba@gmail.com>
References: <1308695065-3784-1-git-send-email-adamek.kuba@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

These are to be used by client for performing async get or put
operations with sending additional headers.
---
 gwobex/gw-obex.h   |   32 ++++++++++++++++++++++++++++++++
 gwobex/obex-xfer.c |   28 ++++++++++++++++++++++++++++
 2 files changed, 60 insertions(+), 0 deletions(-)

diff --git a/gwobex/gw-obex.h b/gwobex/gw-obex.h
index 0638f45..238d695 100644
--- a/gwobex/gw-obex.h
+++ b/gwobex/gw-obex.h
@@ -510,6 +510,24 @@ gboolean gw_obex_copy(GwObex *ctx, const gchar *src, const gchar *dst,
 GwObexXfer *gw_obex_put_async(GwObex *ctx, const char *name, const char *type,
                               gint size, time_t time, gint *error);
 
+/** Start a PUT operation asynchronously with additional headers
+ *
+ * @param ctx   Pointer returned by gw_obex_setup()
+ * @param name  Name of the object (null terminated UTF-8)
+ * @param type  Type of the object (null terminated UTF-8), or NULL
+ * @param apparam      Application parameters of the object
+ * @param apparam_size Application paramters' size
+ * @param aheaders      List of additional headers
+ * @param size  Size of the object (GW_OBEX_UNKNOWN_LENGTH if not known)
+ * @param time  Last modification time of the object (-1 if not known)
+ * @param error Place to store error code on failure (NULL if not interested)
+ *
+ * @returns a new GwObexXfer object on success, NULL on failure
+ */
+GwObexXfer *gw_obex_put_async_with_aheaders(GwObex *ctx, const char *name, const char *type,
+                              const guint8 *apparam, gint apparam_size,
+                              const GSList *aheaders,
+                              gint size, time_t time, gint *error);
 
 /** Start a GET operation asynchronously
  *
@@ -537,6 +555,20 @@ GwObexXfer *gw_obex_get_async(GwObex *ctx, const char *name, const char *type, g
 GwObexXfer *gw_obex_get_async_with_apparam(GwObex *ctx, const char *name, const char *type,
 		const guint8  *apparam, gint apparam_size, gint *error);
 
+/** Start a GET operation asynchronously with additional headers
+ *
+ * @param ctx   Pointer returned by gw_obex_setup()
+ * @param name  Name of the object (null terminated UTF-8)
+ * @param type  Type of the object (null terminated UTF-8), or NULL
+ * @param aheaders      List of additional headers
+ * @param error Place to store error code on failure (NULL if not interested)
+ *
+ * @returns a new GwObexXfer object on success, NULL on failure
+ */
+
+GwObexXfer *gw_obex_get_async_with_aheaders(GwObex *ctx, const char *name, const char *type,
+        const guint8 *apparam, gint apparam_size,
+        const GSList *aheaders, gint *error);
 
 /** Set a callback function for a GwObexXfer object
  * The callback function will be called in the following situations:
diff --git a/gwobex/obex-xfer.c b/gwobex/obex-xfer.c
index 55ea842..fc85fbf 100644
--- a/gwobex/obex-xfer.c
+++ b/gwobex/obex-xfer.c
@@ -124,6 +124,20 @@ GwObexXfer *gw_obex_put_async(GwObex *ctx, const char *name, const char *type,
     return ret ? ctx->xfer : NULL;
 }
 
+GwObexXfer *gw_obex_put_async_with_aheaders(GwObex *ctx, const char *name,
+        const char *type, const guint8 *apparam, gint apparam_size,
+        const GSList *aheaders, gint size, time_t time, gint *error) {
+    gboolean ret;
+    GW_OBEX_LOCK(ctx);
+    CHECK_DISCONNECT(NULL, error, ctx);
+    ret = gw_obex_put_with_aheaders(ctx, NULL, name, type, apparam, apparam_size,
+                                    aheaders, NULL, size, time, -1, TRUE);
+    if (ret == FALSE)
+        gw_obex_get_error(ctx, error);
+    GW_OBEX_UNLOCK(ctx);
+    return ret ? ctx->xfer : NULL;
+}
+
 GwObexXfer *gw_obex_get_async(GwObex *ctx, const char *name, const char *type, gint *error) {
     gboolean ret;
     GW_OBEX_LOCK(ctx);
@@ -147,6 +161,20 @@ GwObexXfer *gw_obex_get_async_with_apparam(GwObex *ctx, const char *name, const
     return ret ? ctx->xfer : NULL;
 }
 
+GwObexXfer *gw_obex_get_async_with_aheaders(GwObex *ctx, const char *name,
+        const char *type, const guint8 *apparam, gint apparam_size,
+        const GSList *aheaders, gint *error) {
+    gboolean ret;
+    GW_OBEX_LOCK(ctx);
+    CHECK_DISCONNECT(NULL, error, ctx);
+    ret = gw_obex_get_with_aheaders(ctx, NULL, name, type, apparam, apparam_size,
+                                    aheaders, NULL, NULL, -1, TRUE);
+    if (ret == FALSE)
+        gw_obex_get_error(ctx, error);
+    GW_OBEX_UNLOCK(ctx);
+    return ret ? ctx->xfer : NULL;
+}
+
 static gboolean gw_obex_put_idle(GwObexXfer *xfer) {
     struct gw_obex *ctx = xfer->ctx;
 
-- 
1.7.0.4

