Return-Path: <cyrus@holtmann.org>
Subject: [PATCH] Always use "nice abort" in osso-gwobex
From: Bastien Nocera <hadess@hadess.net>
To: BlueZ development <linux-bluetooth@vger.kernel.org>
Content-Type: multipart/mixed; boundary="=-hcrqmTw5uqSW5K/RpfGs"
Date: Thu, 18 Feb 2010 01:09:50 +0000
Message-ID: <1266455391.678.1742.camel@localhost.localdomain>
Mime-Version: 1.0
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>


--=-hcrqmTw5uqSW5K/RpfGs
Content-Type: text/plain; charset="ISO-8859-1"
Content-Transfer-Encoding: 7bit

Heya,

As discussed on IRC, we should always use the "nice abort" of openobex,
rather than disconnecting from device when cancelling transfers.

The other patch fixes a little typo.

Cheers

--=-hcrqmTw5uqSW5K/RpfGs
Content-Disposition: attachment; filename="0001-Fix-typo-in-incomming.patch"
Content-Type: text/x-patch; name="0001-Fix-typo-in-incomming.patch"; charset="ISO-8859-1"
Content-Transfer-Encoding: 7bit

>From c1b889e33fc4a40f3164ce4616d59adca149b81e Mon Sep 17 00:00:00 2001
From: Bastien Nocera <hadess@hadess.net>
Date: Thu, 18 Feb 2010 01:05:25 +0000
Subject: [PATCH 1/2] Fix typo in "incomming"

---
 src/obex-priv.c |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/src/obex-priv.c b/src/obex-priv.c
index a8b12ea..f99740a 100644
--- a/src/obex-priv.c
+++ b/src/obex-priv.c
@@ -371,7 +371,7 @@ static void obex_readstream(GwObex *ctx, obex_object_t *object) {
     int actual;
 
     if (!xfer) {
-        debug("Incomming data even though no xfer active!\n");
+        debug("Incoming data even though no xfer active!\n");
         /* Flush incomming stream */
         actual = OBEX_ObjectReadStream(ctx->handle, object, &buf);
         if (actual > 0)
-- 
1.6.6.1


--=-hcrqmTw5uqSW5K/RpfGs
Content-Disposition: attachment; filename="0002-Always-use-nice-abort.patch"
Content-Type: text/x-patch; name="0002-Always-use-nice-abort.patch"; charset="ISO-8859-1"
Content-Transfer-Encoding: 7bit

>From 62e697f0cf06dcf22899188e08ef7ebfcf349fc7 Mon Sep 17 00:00:00 2001
From: Bastien Nocera <hadess@hadess.net>
Date: Thu, 18 Feb 2010 01:05:37 +0000
Subject: [PATCH 2/2] Always use "nice abort"

So we don't disconnect when cancelling a request.
---
 configure.ac    |    1 -
 src/obex-xfer.c |    8 --------
 2 files changed, 0 insertions(+), 9 deletions(-)

diff --git a/configure.ac b/configure.ac
index 7688054..f0dcd53 100644
--- a/configure.ac
+++ b/configure.ac
@@ -38,7 +38,6 @@ AC_SUBST(LDFLAGS)
 
 AC_ARG_ENABLE(docs,      [  --enable-docs        build DOXYGEN documentation (requires Doxygen)],enable_docs=$enableval,enable_docs=auto)
 AC_ARG_ENABLE(tracing,   [  --enable-tracing     Enable debuging information],enable_tracing=$enableval,enable_tracing=no)
-AC_ARG_ENABLE(niceabort, [  --enable-niceabort   Enable proper abort],enable_niceabort=$enableval,enable_niceabort=no)
 AC_ARG_ENABLE(localtime, [  --enable-localtime   Send time as local instead of UTC],enable_localtime=$enableval,enable_localtime=no)
 AC_ARG_ENABLE(coverage,  [  --enable-coverage    Enable coverage], enable_coverage=$enableval, enable_coverage=no)
 
diff --git a/src/obex-xfer.c b/src/obex-xfer.c
index 38a2f4f..81ac5dc 100644
--- a/src/obex-xfer.c
+++ b/src/obex-xfer.c
@@ -98,18 +98,10 @@ gboolean gw_obex_xfer_do_abort(struct gw_obex_xfer *xfer) {
 
     xfer->abort = TRUE;
 
-#ifdef USE_NICE_ABORT
     debug("Performing nice abort\n");
     if (OBEX_CancelRequest(xfer->ctx->handle, TRUE) != 0)
         return FALSE;
     return TRUE;
-#else
-    debug("Performing abort through disconnection (without ABORT command)\n");
-    xfer->ctx->done = TRUE;
-    OBEX_CancelRequest(xfer->ctx->handle, FALSE);
-    obex_link_error(xfer->ctx);
-    return FALSE;
-#endif
 }
 
 GwObexXfer *gw_obex_put_async(GwObex *ctx, const char *name, const char *type,
-- 
1.6.6.1


--=-hcrqmTw5uqSW5K/RpfGs--

