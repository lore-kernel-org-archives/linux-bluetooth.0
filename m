Return-Path: <cyrus@holtmann.org>
From: Chethan T N <chethan.tn@samsung.com>
To: linux-bluetooth@vger.kernel.org
Cc: Chethan T N <chethan.tn@samsung.com>
Subject: [PATCH] audio: Fix headset crash
Date: Wed, 28 Dec 2011 12:16:25 +0530
Message-id: <1325054785-15073-1-git-send-email-chethan.tn@samsung.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Original patch by Chan-yeol Park <chanyeol.park@samsung.com>

Once the headset struct is freed, rfcomm_io_cb would be called and
it might lead to a crash. So when g_io_shutdown rfcomm channel,
additionally we remove g_io_add_watch() source id handle to avoid
unwanted call. And even though rfcomm_io_cb is called and in case
that struct headset is NULL, rfcomm_io_cb would return with FALSE.
---
 audio/headset.c |   19 +++++++++++++++++--
 1 files changed, 17 insertions(+), 2 deletions(-)

diff --git a/audio/headset.c b/audio/headset.c
index 6aef6a8..77883d2 100644
--- a/audio/headset.c
+++ b/audio/headset.c
@@ -165,6 +165,7 @@ struct headset {
 	gboolean auto_dc;
 
 	guint dc_timer;
+	guint rfcomm_io_id;
 
 	gboolean hfp_active;
 	gboolean search_hfp;
@@ -1280,6 +1281,9 @@ static gboolean rfcomm_io_cb(GIOChannel *chan, GIOCondition cond,
 		return FALSE;
 
 	hs = device->headset;
+	if (!hs)
+		return FALSE;
+
 	slc = hs->slc;
 
 	if (cond & (G_IO_ERR | G_IO_HUP)) {
@@ -1397,8 +1401,9 @@ void headset_connect_cb(GIOChannel *chan, GError *err, gpointer user_data)
 	else
 		hs->auto_dc = FALSE;
 
-	g_io_add_watch(chan, G_IO_IN | G_IO_ERR | G_IO_HUP| G_IO_NVAL,
-			(GIOFunc) rfcomm_io_cb, dev);
+	hs->rfcomm_io_id = g_io_add_watch(chan,
+				G_IO_IN | G_IO_ERR | G_IO_HUP| G_IO_NVAL,
+				(GIOFunc) rfcomm_io_cb, dev);
 
 	DBG("%s: Connected to %s", dev->path, hs_address);
 
@@ -1619,6 +1624,11 @@ static int rfcomm_connect(struct audio_device *dev, headset_stream_cb_t cb,
 	DBG("%s: Connecting to %s channel %d", dev->path, address,
 		hs->rfcomm_ch);
 
+	if (hs->rfcomm_io_id) {
+		g_source_remove(hs->rfcomm_io_id);
+		hs->rfcomm_io_id = 0;
+	}
+
 	hs->tmp_rfcomm = bt_io_connect(BT_IO_RFCOMM, headset_connect_cb, dev,
 					NULL, &err,
 					BT_IO_OPT_SOURCE_BDADDR, &dev->src,
@@ -2147,6 +2157,11 @@ static int headset_close_rfcomm(struct audio_device *dev)
 		hs->rfcomm = NULL;
 	}
 
+	if (hs->rfcomm_io_id) {
+		g_source_remove(hs->rfcomm_io_id);
+		hs->rfcomm_io_id = 0;
+	}
+
 	g_free(hs->slc);
 	hs->slc = NULL;
 
-- 
1.7.5.4

