Return-Path: <cyrus@holtmann.org>
From: Radoslaw Jablonski <radoslawjablonski@gmail.com>
To: linux-bluetooth@vger.kernel.org
Cc: Radoslaw Jablonski <radoslawjablonski@gmail.com>
Subject: [PATCHv2 obexd] Use 'nice abort' when canceling outgoing OPP transer
Date: Tue,  9 Aug 2011 11:41:06 +0200
Message-Id: <1312882866-14011-1-git-send-email-radoslawjablonski@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Previously client was suddenly disconnecting to cancel
outgoing OPP transfer. Now ABORT command will be sent
before disconnecting with server in that scenario.

This change is required to pass TC_CLIENT_OPH_BV_27_I PTS
test case (not mandatory for qualification).
---
 gwobex/obex-xfer.c |    8 --------
 1 files changed, 0 insertions(+), 8 deletions(-)

diff --git a/gwobex/obex-xfer.c b/gwobex/obex-xfer.c
index 4013687..3a2ada8 100644
--- a/gwobex/obex-xfer.c
+++ b/gwobex/obex-xfer.c
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
1.7.0.4

