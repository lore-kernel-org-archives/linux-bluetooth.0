Return-Path: <cyrus@holtmann.org>
Subject: Add application header support to gwobex
From: Marcel Holtmann <marcel@holtmann.org>
To: BlueZ development <linux-bluetooth@vger.kernel.org>
Content-Type: multipart/mixed; boundary="=-Ddf33f+Nr/DtGkO2+5cA"
Date: Sun, 19 Oct 2008 10:28:29 +0200
Message-Id: <1224404909.9386.29.camel@californication>
Mime-Version: 1.0
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>


--=-Ddf33f+Nr/DtGkO2+5cA
Content-Type: text/plain
Content-Transfer-Encoding: 7bit

Hi Johan,

for the PBAP support, we need to handle the application header and for
our client/test applications, I extended gwobex to allow us to specify
this header. What do you think?

Regards

Marcel


--=-Ddf33f+Nr/DtGkO2+5cA
Content-Disposition: attachment; filename=patch-gwobex-apparam-support
Content-Type: text/x-patch; name=patch-gwobex-apparam-support; charset=UTF-8
Content-Transfer-Encoding: 7bit

diff --git a/gwobex/gw-obex.c b/gwobex/gw-obex.c
index 061e9e9..e656692 100644
--- a/gwobex/gw-obex.c
+++ b/gwobex/gw-obex.c
@@ -44,7 +44,7 @@ gboolean gw_obex_get_file(GwObex *ctx,
     gboolean ret;
     GW_OBEX_LOCK(ctx);
     CHECK_DISCONNECT(FALSE, error, ctx);
-    ret = gw_obex_get(ctx, local, remote, type, NULL, NULL, -1, FALSE);
+    ret = gw_obex_get(ctx, local, remote, type, NULL, 0, NULL, NULL, -1, FALSE);
     if (ret == FALSE)
         gw_obex_get_error(ctx, error);
     GW_OBEX_UNLOCK(ctx);
@@ -59,7 +59,7 @@ gboolean gw_obex_get_fd(GwObex      *ctx,
     gboolean ret;
     GW_OBEX_LOCK(ctx);
     CHECK_DISCONNECT(FALSE, error, ctx);
-    ret = gw_obex_get(ctx, NULL, remote, type, NULL, NULL, fd, FALSE);
+    ret = gw_obex_get(ctx, NULL, remote, type, NULL, 0, NULL, NULL, fd, FALSE);
     if (ret == FALSE)
         gw_obex_get_error(ctx, error);
     GW_OBEX_UNLOCK(ctx);
@@ -74,7 +74,7 @@ gboolean gw_obex_put_fd(GwObex      *ctx,
     gboolean ret;
     GW_OBEX_LOCK(ctx);
     CHECK_DISCONNECT(FALSE, error, ctx);
-    ret = gw_obex_put(ctx, NULL, remote, type, NULL, 0, -1, fd, FALSE);
+    ret = gw_obex_put(ctx, NULL, remote, type, NULL, 0, NULL, 0, -1, fd, FALSE);
     if (ret == FALSE)
         gw_obex_get_error(ctx, error);
     GW_OBEX_UNLOCK(ctx);
@@ -89,7 +89,7 @@ gboolean gw_obex_put_file(GwObex      *ctx,
     gboolean ret;
     GW_OBEX_LOCK(ctx);
     CHECK_DISCONNECT(FALSE, error, ctx);
-    ret = gw_obex_put(ctx, local, remote, type, NULL, 0, -1, -1, FALSE);
+    ret = gw_obex_put(ctx, local, remote, type, NULL, 0, NULL, 0, -1, -1, FALSE);
     if (ret == FALSE)
         gw_obex_get_error(ctx, error);
     GW_OBEX_UNLOCK(ctx);
@@ -105,7 +105,7 @@ gboolean gw_obex_get_buf(GwObex       *ctx,
     gboolean ret;
     GW_OBEX_LOCK(ctx);
     CHECK_DISCONNECT(FALSE, error, ctx);
-    ret = gw_obex_get(ctx, NULL, remote, type, buf, buf_size, -1, FALSE);
+    ret = gw_obex_get(ctx, NULL, remote, type, NULL, 0, buf, buf_size, -1, FALSE);
     if (ret == FALSE)
         gw_obex_get_error(ctx, error);
     GW_OBEX_UNLOCK(ctx);
@@ -122,7 +122,44 @@ gboolean gw_obex_put_buf(GwObex      *ctx,
     gboolean ret;
     GW_OBEX_LOCK(ctx);
     CHECK_DISCONNECT(FALSE, error, ctx);
-    ret = gw_obex_put(ctx, NULL, remote, type, buf, buf_size, time, -1, FALSE);
+    ret = gw_obex_put(ctx, NULL, remote, type, NULL, 0, buf, buf_size, time, -1, FALSE);
+    if (ret == FALSE)
+        gw_obex_get_error(ctx, error);
+    GW_OBEX_UNLOCK(ctx);
+    return ret;
+}
+
+gboolean gw_obex_get_buf_with_apparam(GwObex        *ctx,
+                                      const gchar   *remote,
+                                      const gchar   *type,
+                                      const guint8  *apparam,
+                                      gint           apparam_size,
+                                      gchar        **buf,
+                                      gint          *buf_size,
+                                      gint          *error) {
+    gboolean ret;
+    GW_OBEX_LOCK(ctx);
+    CHECK_DISCONNECT(FALSE, error, ctx);
+    ret = gw_obex_get(ctx, NULL, remote, type, apparam, apparam_size, buf, buf_size, -1, FALSE);
+    if (ret == FALSE)
+        gw_obex_get_error(ctx, error);
+    GW_OBEX_UNLOCK(ctx);
+    return ret;
+}
+
+gboolean gw_obex_put_buf_with_apparam(GwObex       *ctx,
+                                      const gchar  *remote,
+                                      const gchar  *type,
+                                      const guint8 *apparam,
+                                      gint          apparam_size,
+                                      const gchar  *buf,
+                                      gint          buf_size,
+                                      gint          time,
+                                      gint         *error) {
+    gboolean ret;
+    GW_OBEX_LOCK(ctx);
+    CHECK_DISCONNECT(FALSE, error, ctx);
+    ret = gw_obex_put(ctx, NULL, remote, type, apparam, apparam_size, buf, buf_size, time, -1, FALSE);
     if (ret == FALSE)
         gw_obex_get_error(ctx, error);
     GW_OBEX_UNLOCK(ctx);
@@ -158,7 +195,7 @@ gboolean gw_obex_read_dir(GwObex *ctx, const gchar *dir,
     gboolean ret;
     GW_OBEX_LOCK(ctx);
     CHECK_DISCONNECT(FALSE, error, ctx);
-    ret = gw_obex_get(ctx, NULL, dir ? dir : "", LST_TYPE, buf, buf_size, -1, FALSE);
+    ret = gw_obex_get(ctx, NULL, dir ? dir : "", LST_TYPE, NULL, 0, buf, buf_size, -1, FALSE);
     if (ret == FALSE)
         gw_obex_get_error(ctx, error);
     else if (*buf_size > 0) {
@@ -181,7 +218,7 @@ gboolean gw_obex_delete(GwObex *ctx, const gchar *name, gint *error) {
     gboolean ret;
     GW_OBEX_LOCK(ctx);
     CHECK_DISCONNECT(FALSE, error, ctx);
-    ret = gw_obex_put(ctx, NULL, name, NULL, NULL, 0, -1, -1, FALSE);
+    ret = gw_obex_put(ctx, NULL, name, NULL, NULL, 0, NULL, 0, -1, -1, FALSE);
     if (ret == FALSE)
         gw_obex_get_error(ctx, error);
     GW_OBEX_UNLOCK(ctx);
@@ -214,7 +251,7 @@ gboolean gw_obex_get_capability(GwObex *ctx, gchar **cap, gint *cap_len, gint *e
     gboolean ret;
     GW_OBEX_LOCK(ctx);
     CHECK_DISCONNECT(FALSE, error, ctx);
-    ret = gw_obex_get(ctx, NULL, NULL, CAP_TYPE, cap, cap_len, -1, FALSE);
+    ret = gw_obex_get(ctx, NULL, NULL, CAP_TYPE, NULL, 0, cap, cap_len, -1, FALSE);
     if (ret == FALSE) {
         *cap = NULL;
         *cap_len = 0;
diff --git a/gwobex/gw-obex.h b/gwobex/gw-obex.h
index c1be103..d810d1c 100644
--- a/gwobex/gw-obex.h
+++ b/gwobex/gw-obex.h
@@ -365,6 +365,48 @@ gboolean gw_obex_put_buf(GwObex *ctx, const gchar *remote, const gchar *type,
                          const gchar *buf, gint buf_size, gint time, gint *error);
 
 
+/** Get an object from the remote device and store it in a memory buffer.
+ * Either remote filename or type must be supplied (or both).
+ *
+ * @param ctx          Pointer returned by gw_obex_setup()
+ * @param remote       Remote filename (null terminated UTF-8)
+ * @param type         MIME-type of the object
+ * @param apparam      Application Parameter of the object
+ * @param apparam_size Application Paramter size
+ * @param buf          Buffer to store the object in.
+ *                      g_free() when not needed anymore.
+ * @param buf_size     Place to store length of fetched object
+ * @param error        Place to store error code on failure
+ *                     (NULL if not interested)
+ *
+ * @returns TRUE on success, FALSE on failure
+ */
+gboolean gw_obex_get_buf_with_apparam(GwObex *ctx, const gchar *remote, const gchar *type,
+                                      const guint8 *apparam, gint apparam_size,
+                                      gchar **buf, gint *buf_size, gint *error);
+
+
+/** Send a object located in a memory buffer to the remote device.
+ * Either remote filename or type must be supplied (or both)
+ *
+ * @param ctx          Pointer returned by gw_obex_setup()
+ * @param remote       Remote filename (null terminated UTF-8)
+ * @param type         MIME-type of the object
+ * @param apparam      Application Parameter of the object
+ * @param apparam_size Application Paramter size
+ * @param buf          Buffer containing the object
+ * @param buf_size     Buffer (object) size
+ * @param time         Last modification time of object (or -1 if not known)
+ * @param error        Place to store error code on failure
+ *                     (NULL if not interested)
+ *
+ * @returns TRUE on success, FALSE on failure
+ */
+gboolean gw_obex_put_buf_wit_apparam(GwObex *ctx, const gchar *remote, const gchar *type,
+                                     const guint8 *apparam, gint apparam_size,
+                                     const gchar *buf, gint buf_size, gint time, gint *error);
+
+
 /** Change directory (relative to the current one).
  *
  * @param ctx   Pointer returned by gw_obex_setup()
diff --git a/gwobex/obex-priv.c b/gwobex/obex-priv.c
index 792cb4f..013e55a 100644
--- a/gwobex/obex-priv.c
+++ b/gwobex/obex-priv.c
@@ -828,6 +828,7 @@ out:
 
 gboolean gw_obex_get(GwObex *ctx,
                      const gchar *local, const gchar *remote, const gchar *type,
+                     const guint8 *apparam, gint apparam_size,
                      gchar **buf, gint *buf_size, int stream_fd,
                      gboolean async) {
     gboolean ret = FALSE;
@@ -853,6 +854,11 @@ gboolean gw_obex_get(GwObex *ctx,
         OBEX_ObjectAddHeader(ctx->handle, object, OBEX_HDR_CONNECTION, hv, 4, 0);
     }
 
+    if (apparam && apparam_size > 0) {
+        hv.bs = (unsigned char *)apparam;
+        OBEX_ObjectAddHeader(ctx->handle, object, OBEX_HDR_APPARAM, hv, apparam_size, 0);
+    }
+
     if (type) {
         hv.bs = (unsigned char *)type;
         OBEX_ObjectAddHeader(ctx->handle, object, OBEX_HDR_TYPE, hv, strlen(type) + 1, 0);
@@ -939,6 +945,7 @@ out:
 
 gboolean gw_obex_put(GwObex *ctx,
                      const gchar *local, const gchar *remote, const gchar *type,
+                     const guint8 *apparam, gint apparam_size,
                      const gchar *buf, gint object_size, time_t object_time,
                      int stream_fd, gboolean async) {
     gboolean ret = FALSE;
@@ -1015,6 +1022,11 @@ gboolean gw_obex_put(GwObex *ctx,
         OBEX_ObjectAddHeader(ctx->handle, object, OBEX_HDR_TYPE, hv, strlen(type) + 1, 0);
     }
 
+    if (apparam && apparam_size > 0) {
+        hv.bs = (unsigned char *)apparam;
+        OBEX_ObjectAddHeader(ctx->handle, object, OBEX_HDR_APPARAM, hv, apparam_size, 0);
+    }
+
     /* Try to figure out modification time if none was given */
     if (ctx->xfer->stream_fd >= 0) {
         struct stat stats;
diff --git a/gwobex/obex-priv.h b/gwobex/obex-priv.h
index b6cbbf6..01d7b8b 100644
--- a/gwobex/obex-priv.h
+++ b/gwobex/obex-priv.h
@@ -197,6 +197,7 @@ gboolean gw_obex_setpath(GwObex *ctx, const gchar *path, int flags);
  */
 gboolean gw_obex_get(GwObex *ctx,
                      const gchar *local, const gchar *remote, const gchar *type,
+                     const guint8 *apparam, gint apparam_size,
                      gchar **buf, gint *buf_size, int stream_fd,
                      gboolean async);
 
@@ -209,6 +210,7 @@ gboolean gw_obex_get(GwObex *ctx,
  */
 gboolean gw_obex_put(GwObex *ctx,
                      const gchar *local, const gchar *remote, const gchar *type,
+                     const guint8 *apparam, gint apparam_size,
                      const gchar *buf, gint buf_size, time_t object_time,
                      int stream_fd, gboolean async);
 
diff --git a/gwobex/obex-xfer.c b/gwobex/obex-xfer.c
index 1cce005..4edaa41 100644
--- a/gwobex/obex-xfer.c
+++ b/gwobex/obex-xfer.c
@@ -117,7 +117,7 @@ GwObexXfer *gw_obex_put_async(GwObex *ctx, const char *name, const char *type,
     gboolean ret;
     GW_OBEX_LOCK(ctx);
     CHECK_DISCONNECT(NULL, error, ctx);
-    ret = gw_obex_put(ctx, NULL, name, type, NULL, size, time, -1, TRUE);
+    ret = gw_obex_put(ctx, NULL, name, type, NULL, 0, NULL, size, time, -1, TRUE);
     if (ret == FALSE)
         gw_obex_get_error(ctx, error);
     GW_OBEX_UNLOCK(ctx);
@@ -128,7 +128,7 @@ GwObexXfer *gw_obex_get_async(GwObex *ctx, const char *name, const char *type, g
     gboolean ret;
     GW_OBEX_LOCK(ctx);
     CHECK_DISCONNECT(NULL, error, ctx);
-    ret = gw_obex_get(ctx, NULL, name, type, NULL, NULL, -1, TRUE);
+    ret = gw_obex_get(ctx, NULL, name, type, NULL, 0, NULL, NULL, -1, TRUE);
     if (ret == FALSE)
         gw_obex_get_error(ctx, error);
     GW_OBEX_UNLOCK(ctx);

--=-Ddf33f+Nr/DtGkO2+5cA--

