Return-Path: <cyrus@holtmann.org>
Subject: Re: [PATCH] Always use "nice abort" in osso-gwobex
From: Bastien Nocera <hadess@hadess.net>
To: Bastien Nocera <hadess@hadess.net>
Cc: BlueZ development <linux-bluetooth@vger.kernel.org>
In-Reply-To: <1266455391.678.1742.camel@localhost.localdomain>
References: <1266455391.678.1742.camel@localhost.localdomain>
Content-Type: multipart/mixed; boundary="=-r4Lk+wrjYaMAlrwjH8et"
Date: Thu, 18 Feb 2010 10:56:16 +0000
Message-ID: <1266490576.678.2975.camel@localhost.localdomain>
Mime-Version: 1.0
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>


--=-r4Lk+wrjYaMAlrwjH8et
Content-Type: text/plain; charset="ISO-8859-1"
Content-Transfer-Encoding: 7bit

On Thu, 2010-02-18 at 01:09 +0000, Bastien Nocera wrote:
> Heya,
> 
> As discussed on IRC, we should always use the "nice abort" of openobex,
> rather than disconnecting from device when cancelling transfers.

Updated patch for that, forgot to remove some bits in configure.ac

Cheers

--=-r4Lk+wrjYaMAlrwjH8et
Content-Disposition: attachment; filename="0002-Always-use-nice-abort.patch"
Content-Type: text/x-patch; name="0002-Always-use-nice-abort.patch"; charset="ISO-8859-1"
Content-Transfer-Encoding: 7bit

>From 4812cec279691aa057540abad443d2ccf9aff6ea Mon Sep 17 00:00:00 2001
From: Bastien Nocera <hadess@hadess.net>
Date: Thu, 18 Feb 2010 01:05:37 +0000
Subject: [PATCH 2/2] Always use "nice abort"

So we don't disconnect when cancelling a request.
---
 configure.ac    |    5 -----
 src/obex-xfer.c |    8 --------
 2 files changed, 0 insertions(+), 13 deletions(-)

diff --git a/configure.ac b/configure.ac
index 9d2c19f..a915ec7 100644
--- a/configure.ac
+++ b/configure.ac
@@ -38,7 +38,6 @@ AC_SUBST(LDFLAGS)
 
 AC_ARG_ENABLE(docs,      [  --enable-docs        build DOXYGEN documentation (requires Doxygen)],enable_docs=$enableval,enable_docs=auto)
 AC_ARG_ENABLE(tracing,   [  --enable-tracing     Enable debuging information],enable_tracing=$enableval,enable_tracing=no)
-AC_ARG_ENABLE(niceabort, [  --enable-niceabort   Enable proper abort],enable_niceabort=$enableval,enable_niceabort=no)
 AC_ARG_ENABLE(localtime, [  --enable-localtime   Send time as local instead of UTC],enable_localtime=$enableval,enable_localtime=no)
 AC_ARG_ENABLE(coverage,  [  --enable-coverage    Enable coverage], enable_coverage=$enableval, enable_coverage=no)
 
@@ -98,10 +97,6 @@ else
     AC_MSG_RESULT(no)
 fi
 
-if (test x$enable_niceabort = xyes); then
-        AC_DEFINE(USE_NICE_ABORT, 1, [Enable nice abort support.])
-fi
-
 if (test x$enable_localtime = xyes); then
         AC_DEFINE(USE_LOCALTIME, 1, [Send time as local instead of UTC.])
 fi
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


--=-r4Lk+wrjYaMAlrwjH8et--

