Return-Path: <cyrus@holtmann.org>
From: Jakub Adamek <adamek.kuba@gmail.com>
To: linux-bluetooth@vger.kernel.org
Cc: Jakub Adamek <adamek.kuba@gmail.com>
Subject: [PATCH obexd v2 05/11] Add functions to get, put w. a_header list
Date: Wed, 22 Jun 2011 00:24:19 +0200
Message-Id: <1308695065-3784-6-git-send-email-adamek.kuba@gmail.com>
In-Reply-To: <1308695065-3784-1-git-send-email-adamek.kuba@gmail.com>
References: <1308695065-3784-1-git-send-email-adamek.kuba@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

These are for internal use by gwobex.
---
 gwobex/obex-priv.c |   40 ++++++++++++++++++++++++++++++++++++++++
 gwobex/obex-priv.h |   29 +++++++++++++++++++++++++++++
 2 files changed, 69 insertions(+), 0 deletions(-)

diff --git a/gwobex/obex-priv.c b/gwobex/obex-priv.c
index 7d85045..005e656 100644
--- a/gwobex/obex-priv.c
+++ b/gwobex/obex-priv.c
@@ -847,6 +847,15 @@ gboolean gw_obex_get(GwObex *ctx,
                      const guint8 *apparam, gint apparam_size,
                      gchar **buf, gint *buf_size, int stream_fd,
                      gboolean async) {
+    return gw_obex_get_with_aheaders(ctx, local, remote, type, apparam, apparam_size,
+            NULL, buf, buf_size, stream_fd, async);
+}
+
+gboolean gw_obex_get_with_aheaders(GwObex *ctx,
+        const gchar *local, const gchar *remote, const gchar *type,
+        const guint8 *apparam, gint apparam_size,
+        const GSList *aheaders, gchar **buf, gint *buf_size, int stream_fd,
+        gboolean async) {
     gboolean ret = FALSE;
     obex_headerdata_t hv;
     obex_object_t *object;
@@ -911,6 +920,17 @@ gboolean gw_obex_get(GwObex *ctx,
         }
     }
 
+    if (aheaders) {
+        const GSList *hlist = aheaders;
+        struct a_header *ah;
+        while (hlist) {
+            ah = hlist->data;
+            hv = ah->hv;
+            OBEX_ObjectAddHeader(ctx->handle, object, ah->hi, hv, ah->hv_size, 0);
+            hlist = g_slist_next(hlist);
+        }
+    }
+
     OBEX_ObjectReadStream(ctx->handle, object, NULL);
 
     if (async) {
@@ -964,6 +984,15 @@ gboolean gw_obex_put(GwObex *ctx,
                      const guint8 *apparam, gint apparam_size,
                      const gchar *buf, gint object_size, time_t object_time,
                      int stream_fd, gboolean async) {
+    return gw_obex_put_with_aheaders(ctx, local, remote, type, apparam, apparam_size,
+            NULL, buf, object_size, object_time, stream_fd, async);
+}
+
+gboolean gw_obex_put_with_aheaders(GwObex *ctx,
+        const gchar *local, const gchar *remote, const gchar *type,
+        const guint8 *apparam, gint apparam_size,
+        const GSList *aheaders, const gchar *buf, gint object_size, time_t object_time,
+        int stream_fd, gboolean async) {
     gboolean ret = FALSE;
     obex_headerdata_t hv;
     obex_object_t *object;
@@ -1042,6 +1071,17 @@ gboolean gw_obex_put(GwObex *ctx,
         OBEX_ObjectAddHeader(ctx->handle, object, OBEX_HDR_APPARAM, hv, apparam_size, 0);
     }
 
+    if (aheaders) {
+        const GSList *hlist = aheaders;
+        struct a_header *ah;
+        while (hlist) {
+            ah = hlist->data;
+            hv = ah->hv;
+            OBEX_ObjectAddHeader(ctx->handle, object, ah->hi, hv, ah->hv_size, 0);
+            hlist = g_slist_next(hlist);
+        }
+    }
+
     /* Try to figure out modification time if none was given */
     if (ctx->xfer->stream_fd >= 0) {
         struct stat stats;
diff --git a/gwobex/obex-priv.h b/gwobex/obex-priv.h
index f4e3e5b..c0548b0 100644
--- a/gwobex/obex-priv.h
+++ b/gwobex/obex-priv.h
@@ -214,4 +214,33 @@ gboolean gw_obex_put(GwObex *ctx,
                      const gchar *buf, gint buf_size, time_t object_time,
                      int stream_fd, gboolean async);
 
+
+/** Get an object from the server, specifying additional headers
+ * @param ctx Pointer returned by gw_obex_setup()
+ * @param local Local filename which contains the object
+ * @param remote Remote filename to store the object in
+ * @param type MIME-type of the object (NULL if not known)
+ * @param aheaders list of additional headers (NULL if empty)
+ * @returns TRUE on success, FALSE on failure
+ */
+gboolean gw_obex_get_with_aheaders(GwObex *ctx,
+                     const gchar *local, const gchar *remote, const gchar *type,
+                     const guint8 *apparam, gint apparam_size,
+                     const GSList *aheaders, gchar **buf, gint *buf_size, int stream_fd,
+                     gboolean async);
+
+/** Send an object to the server
+ * @param ctx Pointer returned by gw_obex_setup()
+ * @param local Local filename to store the objec in
+ * @param remote Remote filename which contains the object
+ * @param type MIME-type of the object (NULL if not known)
+ * @param aheaders list of additional headers (NULL if empty)
+ * @returns TRUE on success, FALSE on failure
+ */
+gboolean gw_obex_put_with_aheaders(GwObex *ctx,
+                     const gchar *local, const gchar *remote, const gchar *type,
+                     const guint8 *apparam, gint apparam_size,
+                     const GSList *aheaders, const gchar *buf, gint buf_size, time_t object_time,
+                     int stream_fd, gboolean async);
+
 #endif /* _OBEX_PRIV_H_ */
-- 
1.7.0.4

