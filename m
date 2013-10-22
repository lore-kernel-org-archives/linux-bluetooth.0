Return-Path: <cyrus@holtmann.org>
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH BlueZ] core: Fix crash while processing SDP records
Date: Tue, 22 Oct 2013 12:03:20 +0300
Message-Id: <1382432600-6101-1-git-send-email-luiz.dentz@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

From: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>

This was introduced by commit 073714c3ff70379131be3e19d9ccb8b85fe3f0d9
which attempted to treat the return of sdp_process but caused the crash
bellow because sdp_process actually calls search_completed_cb if it
fails:
Invalid read of size 8
   at 0x44FC93: search_process_cb (sdp-client.c:214)
   by 0x3D46047E05: g_main_context_dispatch (in /usr/lib64/libglib-2.0.so.0.3600.3)
   by 0x3D46048157: ??? (in /usr/lib64/libglib-2.0.so.0.3600.3)
   by 0x3D46048559: g_main_loop_run (in /usr/lib64/libglib-2.0.so.0.3600.3)
   by 0x40A2DF: main (main.c:587)
 Address 0x59febd0 is 16 bytes inside a block of size 72 free'd
   at 0x4A074C4: free (in /usr/lib64/valgrind/vgpreload_memcheck-amd64-linux.so)
   by 0x3D4604D9AE: g_free (in /usr/lib64/libglib-2.0.so.0.3600.3)
   by 0x44FE44: search_completed_cb (sdp-client.c:192)
   by 0x4732E7: sdp_process (sdp.c:4341)
   by 0x44FCD8: search_process_cb (sdp-client.c:206)
   by 0x3D46047E05: g_main_context_dispatch (in /usr/lib64/libglib-2.0.so.0.3600.3)
   by 0x3D46048157: ??? (in /usr/lib64/libglib-2.0.so.0.3600.3)
   by 0x3D46048559: g_main_loop_run (in /usr/lib64/libglib-2.0.so.0.3600.3)
   by 0x40A2DF: main (main.c:587)
---
 src/sdp-client.c | 22 +++++++---------------
 1 file changed, 7 insertions(+), 15 deletions(-)

diff --git a/src/sdp-client.c b/src/sdp-client.c
index 1221f5e..51f3048 100644
--- a/src/sdp-client.c
+++ b/src/sdp-client.c
@@ -196,31 +196,23 @@ static gboolean search_process_cb(GIOChannel *chan, GIOCondition cond,
 							gpointer user_data)
 {
 	struct search_context *ctxt = user_data;
-	int err;
 
 	if (cond & (G_IO_ERR | G_IO_HUP | G_IO_NVAL)) {
-		err = -EIO;
-		goto failed;
-	}
-
-	err = sdp_process(ctxt->session);
-	if (err < 0)
-		goto failed;
-
-	return TRUE;
-
-failed:
-	if (err) {
 		sdp_close(ctxt->session);
 		ctxt->session = NULL;
 
 		if (ctxt->cb)
-			ctxt->cb(NULL, err, ctxt->user_data);
+			ctxt->cb(NULL, -EIO, ctxt->user_data);
 
 		search_context_cleanup(ctxt);
+		return FALSE;
 	}
 
-	return FALSE;
+	/* If sdp_process fails it calls search_completed_cb */
+	if (sdp_process(ctxt->session) < 0)
+		return FALSE;
+
+	return TRUE;
 }
 
 static gboolean connect_watch(GIOChannel *chan, GIOCondition cond,
-- 
1.8.3.1

