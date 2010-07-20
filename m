Return-Path: <cyrus@holtmann.org>
Message-ID: <4C46324D.5070800@aircable.net>
Date: Tue, 20 Jul 2010 20:33:33 -0300
From: Manuel Naranjo <manuel@aircable.net>
MIME-Version: 1.0
To: BlueZ <linux-bluetooth@vger.kernel.org>
Subject: [PATCH][RFC] Fix SDP resolving segfault
Content-Type: multipart/mixed;
 boundary="------------010205030004030907050108"
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

This is a multi-part message in MIME format.
--------------010205030004030907050108
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit

Guys,

I think this patch fixes the weird segfault I had been experiencing for 
the last few months.

Manuel

Signed-off-by: Manuel Naranjo<manuel@aircable.net>


--------------010205030004030907050108
Content-Type: text/plain;
 name="0001-Possible-fix-for-BlueZ-SDP-segfaults.patch"
Content-Transfer-Encoding: 7bit
Content-Disposition: attachment;
 filename="0001-Possible-fix-for-BlueZ-SDP-segfaults.patch"

>From a292f1df55ace6d4c7e4e91edf833b7e4f07e5a7 Mon Sep 17 00:00:00 2001
From: Manuel Francisco Naranjo <manuel@aircable.net>
Date: Tue, 20 Jul 2010 20:12:56 -0300
Subject: [PATCH] Possible fix for BlueZ SDP segfaults

modified:   src/glib-helper.c

Sometimes when you do a DiscoverServices through DBUS and the device goes out of
range then BlueZ will end with a SegFault. I've traced it, and it seems like
connect_watch is been triggered, it gets into the failed tag and when it does the
callback as the btd_device has been released before, the callback triggers the
segfault.

This patch seems to fix the problem, not sure if this is the best way, or the right
one at all. Maybe the problem is that btd_device has no direct reference to the
search_context and then when btd_device is released there's no direct search_context
release (this happens through the function bt_cancel_discovery, but I have a feeling
this approach is actually failing in some cases).
---
 src/glib-helper.c |   18 ++++++++++++------
 1 files changed, 12 insertions(+), 6 deletions(-)

diff --git a/src/glib-helper.c b/src/glib-helper.c
index 41f5e3c..fef0d41 100644
--- a/src/glib-helper.c
+++ b/src/glib-helper.c
@@ -156,8 +156,10 @@ static void search_context_cleanup(struct search_context *ctxt)
 {
 	context_list = g_slist_remove(context_list, ctxt);
 
-	if (ctxt->destroy)
+	if (ctxt->destroy){
 		ctxt->destroy(ctxt->user_data);
+		ctxt->user_data = NULL;
+	}
 
 	g_free(ctxt);
 }
@@ -206,7 +208,7 @@ static void search_completed_cb(uint8_t type, uint16_t status,
 done:
 	cache_sdp_session(&ctxt->src, &ctxt->dst, ctxt->session);
 
-	if (ctxt->cb)
+	if (ctxt->cb && ctxt->user_data)
 		ctxt->cb(recs, err, ctxt->user_data);
 
 	if (recs)
@@ -236,7 +238,7 @@ failed:
 		sdp_close(ctxt->session);
 		ctxt->session = NULL;
 
-		if (ctxt->cb)
+		if (ctxt->cb && ctxt->user_data)
 			ctxt->cb(NULL, err, ctxt->user_data);
 
 		search_context_cleanup(ctxt);
@@ -254,6 +256,8 @@ static gboolean connect_watch(GIOChannel *chan, GIOCondition cond, gpointer user
 	int sk, err = 0;
 
 	sk = g_io_channel_unix_get_fd(chan);
+	if (ctxt->io_id)
+	    g_source_remove(ctxt->io_id);
 	ctxt->io_id = 0;
 
 	len = sizeof(err);
@@ -293,7 +297,7 @@ failed:
 	sdp_close(ctxt->session);
 	ctxt->session = NULL;
 
-	if (ctxt->cb)
+	if (ctxt->cb && ctxt->user_data)
 		ctxt->cb(NULL, -err, ctxt->user_data);
 
 	search_context_cleanup(ctxt);
@@ -391,11 +395,13 @@ int bt_cancel_discovery(const bdaddr_t *src, const bdaddr_t *dst)
 		return -ENODATA;
 
 	ctxt = match->data;
-	if (!ctxt->session)
-		return -ENOTCONN;
 
 	if (ctxt->io_id)
 		g_source_remove(ctxt->io_id);
+	ctxt->io_id = 0;
+
+	if (!ctxt->session)
+		return -ENOTCONN;
 
 	if (ctxt->session)
 		sdp_close(ctxt->session);
-- 
1.6.4.4


--------------010205030004030907050108--
