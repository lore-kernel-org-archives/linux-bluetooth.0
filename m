Return-Path: <cyrus@holtmann.org>
From: Szymon Janc <szymon.janc@tieto.com>
To: linux-bluetooth@vger.kernel.org
Cc: Szymon Janc <szymon.janc@tieto.com>
Subject: [PATCH 07/13] android/handsfree: Pass device to SCO handling functions
Date: Wed,  8 Oct 2014 09:12:17 +0200
Message-Id: <1412752343-7001-7-git-send-email-szymon.janc@tieto.com>
In-Reply-To: <1412752343-7001-1-git-send-email-szymon.janc@tieto.com>
References: <1412752343-7001-1-git-send-email-szymon.janc@tieto.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

---
 android/handsfree.c | 35 +++++++++++++++++++----------------
 1 file changed, 19 insertions(+), 16 deletions(-)

diff --git a/android/handsfree.c b/android/handsfree.c
index 7c8020c..d83f0a2 100644
--- a/android/handsfree.c
+++ b/android/handsfree.c
@@ -852,15 +852,17 @@ static void at_cmd_btrh(struct hfp_gw_result *result, enum hfp_gw_cmd_type type,
 static gboolean sco_watch_cb(GIOChannel *chan, GIOCondition cond,
 							gpointer user_data)
 {
-	g_io_channel_shutdown(device.sco, TRUE, NULL);
-	g_io_channel_unref(device.sco);
-	device.sco = NULL;
+	struct hf_device *dev = user_data;
+
+	g_io_channel_shutdown(dev->sco, TRUE, NULL);
+	g_io_channel_unref(dev->sco);
+	dev->sco = NULL;
 
 	DBG("");
 
-	device.sco_watch = 0;
+	dev->sco_watch = 0;
 
-	set_audio_state(&device, HAL_EV_HANDSFREE_AUDIO_STATE_DISCONNECTED);
+	set_audio_state(dev, HAL_EV_HANDSFREE_AUDIO_STATE_DISCONNECTED);
 
 	return FALSE;
 }
@@ -894,19 +896,20 @@ done:
 
 static void connect_sco_cb(GIOChannel *chan, GError *err, gpointer user_data)
 {
+	struct hf_device *dev = user_data;
+
 	if (err) {
 		error("handsfree: audio connect failed (%s)", err->message);
 
-		set_audio_state(&device,
-				HAL_EV_HANDSFREE_AUDIO_STATE_DISCONNECTED);
+		set_audio_state(dev, HAL_EV_HANDSFREE_AUDIO_STATE_DISCONNECTED);
 
-		if (!(device.features & HFP_HF_FEAT_CODEC))
+		if (!(dev->features & HFP_HF_FEAT_CODEC))
 			return;
 
 		/* If other failed, try connecting with CVSD */
-		if (device.negotiated_codec != CODEC_ID_CVSD) {
+		if (dev->negotiated_codec != CODEC_ID_CVSD) {
 			info("handsfree: trying fallback with CVSD");
-			select_codec(&device, CODEC_ID_CVSD);
+			select_codec(dev, CODEC_ID_CVSD);
 		}
 
 		return;
@@ -914,11 +917,11 @@ static void connect_sco_cb(GIOChannel *chan, GError *err, gpointer user_data)
 
 	g_io_channel_set_close_on_unref(chan, TRUE);
 
-	device.sco = g_io_channel_ref(chan);
-	device.sco_watch = g_io_add_watch(chan, G_IO_ERR | G_IO_HUP | G_IO_NVAL,
-							sco_watch_cb, NULL);
+	dev->sco = g_io_channel_ref(chan);
+	dev->sco_watch = g_io_add_watch(chan, G_IO_ERR | G_IO_HUP | G_IO_NVAL,
+							sco_watch_cb, dev);
 
-	set_audio_state(&device, HAL_EV_HANDSFREE_AUDIO_STATE_CONNECTED);
+	set_audio_state(dev, HAL_EV_HANDSFREE_AUDIO_STATE_CONNECTED);
 }
 
 static bool connect_sco(void)
@@ -937,7 +940,7 @@ static bool connect_sco(void)
 	else
 		voice_settings = BT_VOICE_CVSD_16BIT;
 
-	io = bt_io_connect(connect_sco_cb, NULL, NULL, &gerr,
+	io = bt_io_connect(connect_sco_cb, &device, NULL, &gerr,
 				BT_IO_OPT_SOURCE_BDADDR, &adapter_addr,
 				BT_IO_OPT_DEST_BDADDR, &device.bdaddr,
 				BT_IO_OPT_VOICE, voice_settings,
@@ -2373,7 +2376,7 @@ static void confirm_sco_cb(GIOChannel *chan, gpointer user_data)
 		goto drop;
 	}
 
-	if (!bt_io_accept(chan, connect_sco_cb, NULL, NULL, NULL)) {
+	if (!bt_io_accept(chan, connect_sco_cb, &device, NULL, NULL)) {
 		error("handsfree: failed to accept audio connection");
 		goto drop;
 	}
-- 
1.9.1

