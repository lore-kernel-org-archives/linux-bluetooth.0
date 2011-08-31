Return-Path: <cyrus@holtmann.org>
From: Slawomir Bochenski <lkslawek@gmail.com>
To: linux-bluetooth@vger.kernel.org
Cc: Slawomir Bochenski <lkslawek@gmail.com>
Subject: [PATCH obexd 1/2] Add gw_obex_put_async_with_apparam()
Date: Wed, 31 Aug 2011 15:35:13 +0200
Message-Id: <1314797714-25193-2-git-send-email-lkslawek@gmail.com>
In-Reply-To: <1314797714-25193-1-git-send-email-lkslawek@gmail.com>
References: <1314797714-25193-1-git-send-email-lkslawek@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

---
 gwobex/gw-obex.h   |   17 +++++++++++++++++
 gwobex/obex-xfer.c |   13 +++++++++++++
 2 files changed, 30 insertions(+), 0 deletions(-)

diff --git a/gwobex/gw-obex.h b/gwobex/gw-obex.h
index c858341..d21e299 100644
--- a/gwobex/gw-obex.h
+++ b/gwobex/gw-obex.h
@@ -510,6 +510,23 @@ gboolean gw_obex_copy(GwObex *ctx, const gchar *src, const gchar *dst,
 GwObexXfer *gw_obex_put_async(GwObex *ctx, const char *name, const char *type,
                               gint size, time_t time, gint *error);
 
+/** Start an asynchrounous PUT operation supporting application parameters
+ *
+ * @param ctx   Pointer returned by gw_obex_setup()
+ * @param name  Name of the object (null terminated UTF-8)
+ * @param type  Type of the object (null terminated UTF-8), or NULL
+ * @param size  Size of the object (GW_OBEX_UNKNOWN_LENGTH if not known)
+ * @param time  Last modification time of the object (-1 if not known)
+ * @param apparam      Application parameters of the object
+ * @param apparam_size Application paramters' size
+ * @param error Place to store error code on failure (NULL if not interested)
+ *
+ * @returns a new GwObexXfer object on success, NULL on failure
+ */
+GwObexXfer *gw_obex_put_async_with_apparam(GwObex *ctx, const char *name,
+				const char *type, const guint8 *apparam,
+				gint apparam_size, gint size,
+				time_t time, gint *error);
 
 /** Start a GET operation asynchronously
  *
diff --git a/gwobex/obex-xfer.c b/gwobex/obex-xfer.c
index 3a2ada8..20edb99 100644
--- a/gwobex/obex-xfer.c
+++ b/gwobex/obex-xfer.c
@@ -116,6 +116,19 @@ GwObexXfer *gw_obex_put_async(GwObex *ctx, const char *name, const char *type,
     return ret ? ctx->xfer : NULL;
 }
 
+GwObexXfer *gw_obex_put_async_with_apparam(GwObex *ctx, const char *name,
+		const char *type, const guint8 *apparam, gint apparam_size,
+		gint size, time_t time, gint *error) {
+    gboolean ret;
+    GW_OBEX_LOCK(ctx);
+    CHECK_DISCONNECT(NULL, error, ctx);
+    ret = gw_obex_put(ctx, NULL, name, type, apparam, apparam_size, NULL, size, time, -1, TRUE);
+    if (ret == FALSE)
+        gw_obex_get_error(ctx, error);
+    GW_OBEX_UNLOCK(ctx);
+    return ret ? ctx->xfer : NULL;
+}
+
 GwObexXfer *gw_obex_get_async(GwObex *ctx, const char *name, const char *type, gint *error) {
     gboolean ret;
     GW_OBEX_LOCK(ctx);
-- 
1.7.4.1

