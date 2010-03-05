Return-Path: <cyrus@holtmann.org>
Subject: Re: [PATCHes] osso-gwobex patches for review
From: Bastien Nocera <hadess@hadess.net>
To: Johan Hedberg <johan.hedberg@gmail.com>
Cc: BlueZ development <linux-bluetooth@vger.kernel.org>
In-Reply-To: <20100223134810.GA6157@jh-x301>
References: <1266762470.25029.2195.camel@localhost.localdomain>
	 <20100223134810.GA6157@jh-x301>
Content-Type: multipart/mixed; boundary="=-DPZ0M4THVl2DQQb1rCci"
Date: Fri, 05 Mar 2010 17:15:41 +0000
Message-ID: <1267809341.22567.10.camel@localhost.localdomain>
Mime-Version: 1.0
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>


--=-DPZ0M4THVl2DQQb1rCci
Content-Type: text/plain; charset="ISO-8859-1"
Content-Transfer-Encoding: 7bit

On Tue, 2010-02-23 at 10:48 -0300, Johan Hedberg wrote:
> Hi Bastien,
> 
> On Sun, Feb 21, 2010, Bastien Nocera wrote:
> > The first patch fixes a few typos.
> 
> Yep, looks good and I've pushed it upstream.
> 
> > The second one requires the openobex patches I posted to the list, but
> > should fail gracefully if the support does not exist.
> 
> This patch has some issues:
<snip>
> Besides those issues the patch seems ok'ish.

Updated patch below for the USB support. Not tested, as I'm having some
problems with recent changes in OpenObex (as I mailed recently).

Cheers

--=-DPZ0M4THVl2DQQb1rCci
Content-Disposition: attachment; filename="0001-Add-USB-support-to-osso-gwobex.patch"
Content-Type: text/x-patch; name="0001-Add-USB-support-to-osso-gwobex.patch"; charset="ISO-8859-1"
Content-Transfer-Encoding: 7bit

>From addf804a4865729b9185727d1f38b02ad1329cd2 Mon Sep 17 00:00:00 2001
From: Bastien Nocera <hadess@hadess.net>
Date: Sun, 21 Feb 2010 14:18:37 +0000
Subject: [PATCH] Add USB support to osso-gwobex

Pass a "usb:busid,deviceid,interface" string to
gw_obex_setup_dev() to setup a USB Obex device.

Then you can access the FTP service as normal.
---
 src/gw-obex.c   |  120 +++++++++++++++++++++++++++++++++++++++++++++++++++++++
 src/obex-priv.c |   20 +++++++++
 src/obex-priv.h |    4 ++
 src/obex-xfer.c |    2 +-
 4 files changed, 145 insertions(+), 1 deletions(-)

diff --git a/src/gw-obex.c b/src/gw-obex.c
index 8352782..fea270d 100644
--- a/src/gw-obex.c
+++ b/src/gw-obex.c
@@ -370,11 +370,131 @@ GwObex *gw_obex_setup_fd(int fd, const gchar *uuid, gint uuid_len,
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
+        if (error)
+            *error = GW_OBEX_ERROR_NO_SERVICE;
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
+        OBEX_Cleanup(handle);
+        if (error)
+            *error = GW_OBEX_ERROR_NO_SERVICE;
+        return NULL;
+    }
+
+    /* Prepare the context */
+    ctx = make_context(handle);
+
+    if (!g_thread_supported() && !g_thread_get_initialized())
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
+        goto fail;
+    }
+
+    debug("Transport connection opened.\n");
+
+    /* Set the file descriptor for listening in */
+    update_context(ctx);
+    if (ctx->conn_fd < 0) {
+        debug("Unable to get a file descriptor for the USB connection\n");
+        if (error)
+            *error = GW_OBEX_ERROR_NO_SERVICE;
+        goto fail;
+    }
+
+    debug("New FD is %d\n", ctx->conn_fd);
+
+    /* Do the service connection */
+    debug("Connecting to OBEX service\n");
+    if (!gw_obex_connect(ctx, uuid, uuid_len)) {
+        debug("Unable to connect to OBEX service\n");
+        if (error)
+            *error = GW_OBEX_ERROR_NO_SERVICE;
+        goto fail;
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
+
+fail:
+    if (ctx != NULL) {
+        if (ctx->mutex != NULL)
+            g_mutex_free(ctx->mutex);
+        g_free(ctx);
+    }
+    OBEX_Cleanup(handle);
+
+    return NULL;
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
index 37b20de..f8d98f7 100644
--- a/src/obex-priv.h
+++ b/src/obex-priv.h
@@ -164,6 +164,8 @@ struct gw_obex {
 
 GwObex *make_context(obex_t *handle);
 
+void update_context(GwObex *ctx);
+
 gboolean gw_obex_set_error(GwObex *ctx);
 
 void gw_obex_get_error(GwObex *ctx, gint *error);
@@ -178,6 +180,8 @@ gboolean gw_obex_disconnect(GwObex *ctx);
 
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


--=-DPZ0M4THVl2DQQb1rCci--

