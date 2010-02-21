Return-Path: <cyrus@holtmann.org>
Subject: [PATCHes] osso-gwobex patches for review
From: Bastien Nocera <hadess@hadess.net>
To: BlueZ development <linux-bluetooth@vger.kernel.org>
Content-Type: multipart/mixed; boundary="=-pcvOj/Zw9WDVI3RWxkNG"
Date: Sun, 21 Feb 2010 14:27:50 +0000
Message-ID: <1266762470.25029.2195.camel@localhost.localdomain>
Mime-Version: 1.0
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>


--=-pcvOj/Zw9WDVI3RWxkNG
Content-Type: text/plain; charset="ISO-8859-1"
Content-Transfer-Encoding: 7bit

Heya,

The first patch fixes a few typos.

The second one requires the openobex patches I posted to the list, but
should fail gracefully if the support does not exist.

The dependency on openobex itself should probably be upped as well.

Cheers

--=-pcvOj/Zw9WDVI3RWxkNG
Content-Disposition: attachment; filename="0001-Fix-a-few-typos.patch"
Content-Type: text/x-patch; name="0001-Fix-a-few-typos.patch"; charset="ISO-8859-1"
Content-Transfer-Encoding: 7bit

>From f15d528af880b639567e8c2924be50cc6a6d0cd3 Mon Sep 17 00:00:00 2001
From: Bastien Nocera <hadess@hadess.net>
Date: Fri, 19 Feb 2010 15:49:27 +0000
Subject: [PATCH 1/2] Fix a few typos

---
 src/obex-priv.c |    4 ++--
 1 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/src/obex-priv.c b/src/obex-priv.c
index f99740a..a43c56a 100644
--- a/src/obex-priv.c
+++ b/src/obex-priv.c
@@ -221,7 +221,7 @@ static void obex_connect_done(GwObex *ctx, obex_object_t *object, int obex_rsp)
 #endif
             case OBEX_HDR_CONNECTION:
                 ctx->conid = hv.bq4;
-                debug("got Conection ID: %#x\n", hv.bq4);
+                debug("got Connection ID: %#x\n", hv.bq4);
                 break;
             default:
                 debug("Skipped header %02x\n", hi);
@@ -372,7 +372,7 @@ static void obex_readstream(GwObex *ctx, obex_object_t *object) {
 
     if (!xfer) {
         debug("Incoming data even though no xfer active!\n");
-        /* Flush incomming stream */
+        /* Flush incoming stream */
         actual = OBEX_ObjectReadStream(ctx->handle, object, &buf);
         if (actual > 0)
             debug("Ignored %d bytes\n", actual);
-- 
1.6.6.1


--=-pcvOj/Zw9WDVI3RWxkNG
Content-Disposition: attachment; filename="0002-Add-USB-support-to-osso-gwobex.patch"
Content-Type: text/x-patch; name="0002-Add-USB-support-to-osso-gwobex.patch"; charset="ISO-8859-1"
Content-Transfer-Encoding: 7bit

>From 841d913a1b31ada32cfeb7a2f36fd0ccc820c088 Mon Sep 17 00:00:00 2001
From: Bastien Nocera <hadess@hadess.net>
Date: Sun, 21 Feb 2010 14:18:37 +0000
Subject: [PATCH 2/2] Add USB support to osso-gwobex

Pass a "usb:busid,deviceid,interface" string to
gw_obex_setup_dev() to setup a USB Obex device.

Then you can access the FTP service as normal.
---
 src/gw-obex.c   |  117 +++++++++++++++++++++++++++++++++++++++++++++++++++++++
 src/obex-priv.c |   20 +++++++++
 src/obex-priv.h |    4 ++
 src/obex-xfer.c |    2 +-
 4 files changed, 142 insertions(+), 1 deletions(-)

diff --git a/src/gw-obex.c b/src/gw-obex.c
index 8352782..a51222a 100644
--- a/src/gw-obex.c
+++ b/src/gw-obex.c
@@ -370,11 +370,128 @@ GwObex *gw_obex_setup_fd(int fd, const gchar *uuid, gint uuid_len,
     return ctx;
 }
 
+static GwObex *gw_obex_setup_usb(const char *dev, const gchar *uuid, gint uuid_len,
+                                 GMainContext *context, gint *error) {
+    GwObex *ctx;
+    obex_t *handle;
+    obex_interface_t *iface;
+    int i, num;
+
+    /* Setup low-level USB */
+    if (!gw_obex_transport_setup_usb(&handle)) {
+        debug("gw_obex_transport_setup_usb() failed, no USB support?\n");
+        return NULL;
+    }
+
+    /* Look for the requested interface */
+    num = OBEX_EnumerateInterfaces(handle);
+    if (num == 0) {
+        debug("usbobex_find_interfaces() found no USB devices\n");
+        if (error)
+            *error = GW_OBEX_ERROR_NO_SERVICE;
+        return NULL;
+    }
+
+    iface = NULL;
+    for (i = 0; i < num; i++) {
+        gchar *path;
+        obex_interface_t *tmp;
+        tmp = OBEX_GetInterfaceByIndex(handle, i);
+
+        path = g_strdup_printf("usb:%d,%d,%d", tmp->usb.bus_number,
+                               tmp->usb.device_address,
+                               tmp->usb.interface_number);
+        debug("Checking requested '%s' against found '%s'\n", dev, path);
+        /* Is that the interface we're looking for? */
+        if (g_str_equal(path, dev)) {
+            iface = tmp;
+            g_free(path);
+            break;
+        }
+        g_free(path);
+    }
+
+    if (iface == NULL) {
+        debug("Could not find matching USB interface for %s\n", dev);
+        if (error)
+            *error = GW_OBEX_ERROR_NO_SERVICE;
+        return NULL;
+    }
+
+    /* Prepare the context */
+    ctx = make_context(handle);
+
+    if (!g_thread_supported())
+        g_thread_init(NULL);
+    ctx->mutex = g_mutex_new();
+
+    OBEX_SetCustomData(handle, ctx);
+
+    /* Do the transport connection */
+    if (OBEX_InterfaceConnect(handle, iface) < 0) {
+        debug("Could not connect to USB device '%s'\n", dev);
+        if (error)
+            *error = GW_OBEX_ERROR_NO_SERVICE;
+        return NULL;
+    }
+
+    debug("Transport connection opened.\n");
+
+    /* Set the file descriptor for listening in */
+    update_context(ctx);
+    if (ctx->conn_fd < 0) {
+        debug("Unable to get a file descriptor for the USB connection\n");
+        g_mutex_free(ctx->mutex);
+        ctx->mutex = NULL;
+
+        g_free(ctx);
+        OBEX_Cleanup(handle);
+        if (error)
+            *error = GW_OBEX_ERROR_NO_SERVICE;
+        return NULL;
+    }
+
+    debug("New FD is %d\n", ctx->conn_fd);
+
+    /* Do the service connection */
+    debug("Connecting to OBEX service\n");
+    if (!gw_obex_connect(ctx, uuid, uuid_len)) {
+        debug("Unable to connect to OBEX service\n");
+        g_mutex_free(ctx->mutex);
+        ctx->mutex = NULL;
+
+        g_free(ctx);
+        OBEX_Cleanup(handle);
+        if (error)
+            *error = GW_OBEX_ERROR_NO_SERVICE;
+        return NULL;
+    }
+
+    debug("Connected (Connection ID: %#x)\n", ctx->conid);
+
+    /* Setup the file descriptor to get events from */
+    ctx->gio = g_io_channel_unix_new(ctx->conn_fd);
+    ctx->gio_source = g_io_create_watch (ctx->gio,
+                                         G_IO_IN | G_IO_HUP | G_IO_ERR | G_IO_NVAL);
+    g_source_set_callback(ctx->gio_source, (GSourceFunc)gw_obex_cb, ctx, NULL);
+    (void) g_source_attach(ctx->gio_source, context);
+    g_source_unref(ctx->gio_source);
+
+    ctx->main_ctx = context;
+
+    return ctx;
+}
+
 GwObex *gw_obex_setup_dev(const char *dev, const gchar *uuid, gint uuid_len,
                           GMainContext *context, gint *error) {
     GwObex *ctx;
     int fd;
 
+    if (strncmp(dev, "usb:", 4) == 0) {
+        debug("Trying to set up USB device '%s'\n", dev);
+        return gw_obex_setup_usb(dev, uuid, uuid_len, context, error);
+    }
+
     fd = open(dev, O_RDWR | O_NOCTTY | O_SYNC);
     if (fd < 0) {
         debug("open(\"%s\"): %s\n", dev, strerror(errno));
diff --git a/src/obex-priv.c b/src/obex-priv.c
index a43c56a..278a0a7 100644
--- a/src/obex-priv.c
+++ b/src/obex-priv.c
@@ -515,6 +515,7 @@ static void obex_writestream(GwObex *ctx, obex_object_t *object) {
 static void obex_event_handler(obex_t *handle, obex_object_t *object, int mode,
                                int event, int obex_cmd, int obex_rsp) {
     GwObex *ctx = OBEX_GetCustomData(handle);
+
     switch (event) {
         case OBEX_EV_ABORT:
             debug("OBEX_EV_ABORT\n");
@@ -630,6 +631,16 @@ gboolean gw_obex_transport_setup(int fd, obex_t **handle) {
     return TRUE;
 }
 
+gboolean gw_obex_transport_setup_usb(obex_t **handle) {
+    *handle = OBEX_Init(OBEX_TRANS_USB, obex_event_handler, 0);
+    if (*handle == NULL) {
+        debug("OBEX_Init() failed\n");
+        return FALSE;
+    }
+
+    return TRUE;
+}
+
 void gw_obex_get_error(GwObex *ctx, gint *error) {
     if (error)
         *error = ctx->error;
@@ -728,6 +739,15 @@ GwObex *make_context(obex_t *handle) {
     return context;
 }
 
+void update_context(GwObex *ctx)
+{
+    int fd;
+
+    fd = OBEX_GetFD(ctx->handle);
+    if (fd > 0)
+        ctx->conn_fd = fd;
+}
+
 gboolean gw_obex_action_op(GwObex *ctx, const gchar *src, const gchar *dst,
                            uint8_t action) {
     gboolean ret = FALSE;
diff --git a/src/obex-priv.h b/src/obex-priv.h
index ce7748c..4991d49 100644
--- a/src/obex-priv.h
+++ b/src/obex-priv.h
@@ -162,6 +162,8 @@ struct gw_obex {
 
 GwObex *make_context(obex_t *handle);
 
+void update_context(GwObex *ctx);
+
 gboolean gw_obex_set_error(GwObex *ctx);
 
 void gw_obex_get_error(GwObex *ctx, gint *error);
@@ -176,6 +178,8 @@ gboolean gw_obex_disconnect(GwObex *ctx);
 
 gboolean gw_obex_transport_setup(int fd, obex_t **handle);
 
+gboolean gw_obex_transport_setup_usb(obex_t **handle);
+
 gboolean gw_obex_action_op(GwObex *ctx, const gchar *src, const gchar *dst,
                            uint8_t action);
 
diff --git a/src/obex-xfer.c b/src/obex-xfer.c
index 81ac5dc..8c7b645 100644
--- a/src/obex-xfer.c
+++ b/src/obex-xfer.c
@@ -48,7 +48,7 @@ static gboolean handle_input(GwObex *ctx, gint *err) {
     r = OBEX_HandleInput(ctx->handle, 22);
 
     if (r < 0) {
-        debug("OBEX_HandleInput() failed\n");
+        debug("OBEX_HandleInput() failed (%d)\n", r);
         obex_link_error(ctx);
         if (err)
             *err = GW_OBEX_ERROR_INTERNAL;
-- 
1.6.6.1


--=-pcvOj/Zw9WDVI3RWxkNG--

