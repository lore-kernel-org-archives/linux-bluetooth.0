Return-Path: <cyrus@holtmann.org>
From: Szymon Janc <szymon.janc@tieto.com>
To: linux-bluetooth@vger.kernel.org
Cc: Szymon Janc <szymon.janc@tieto.com>
Subject: [PATCH v2 07/12] android/handsfree: Pass device to SCO handling functions
Date: Wed,  8 Oct 2014 12:15:09 +0200
Message-Id: <1412763314-12871-7-git-send-email-szymon.janc@tieto.com>
In-Reply-To: <1412763314-12871-1-git-send-email-szymon.janc@tieto.com>
References: <1412763314-12871-1-git-send-email-szymon.janc@tieto.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

---
 android/handsfree.c | 93 +++++++++++++++++++++++++++--------------------------
 1 file changed, 48 insertions(+), 45 deletions(-)

diff --git a/android/handsfree.c b/android/handsfree.c
index 49ecab4..069a6f3 100644
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
@@ -914,32 +917,32 @@ static void connect_sco_cb(GIOChannel *chan, GError *err, gpointer user_data)
 
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
 
-static bool connect_sco(void)
+static bool connect_sco(struct hf_device *dev)
 {
 	GIOChannel *io;
 	GError *gerr = NULL;
 	uint16_t voice_settings;
 
-	if (device.sco)
+	if (dev->sco)
 		return false;
 
-	if (!(device.features & HFP_HF_FEAT_CODEC))
+	if (!(dev->features & HFP_HF_FEAT_CODEC))
 		voice_settings = 0;
-	else if (device.negotiated_codec != CODEC_ID_CVSD)
+	else if (dev->negotiated_codec != CODEC_ID_CVSD)
 		voice_settings = BT_VOICE_TRANSPARENT;
 	else
 		voice_settings = BT_VOICE_CVSD_16BIT;
 
-	io = bt_io_connect(connect_sco_cb, NULL, NULL, &gerr,
+	io = bt_io_connect(connect_sco_cb, dev, NULL, &gerr,
 				BT_IO_OPT_SOURCE_BDADDR, &adapter_addr,
-				BT_IO_OPT_DEST_BDADDR, &device.bdaddr,
+				BT_IO_OPT_DEST_BDADDR, &dev->bdaddr,
 				BT_IO_OPT_VOICE, voice_settings,
 				BT_IO_OPT_INVALID);
 
@@ -951,7 +954,7 @@ static bool connect_sco(void)
 
 	g_io_channel_unref(io);
 
-	set_audio_state(&device, HAL_EV_HANDSFREE_AUDIO_STATE_CONNECTING);
+	set_audio_state(dev, HAL_EV_HANDSFREE_AUDIO_STATE_CONNECTING);
 
 	return true;
 }
@@ -982,7 +985,7 @@ static void at_cmd_bcc(struct hfp_gw_result *result, enum hfp_gw_cmd_type type,
 		 * we try connect to negotiated codec. If it fails, and it isn't
 		 * CVSD codec, try connect CVSD
 		 */
-		if (!connect_sco() && dev->negotiated_codec != CODEC_ID_CVSD)
+		if (!connect_sco(dev) && dev->negotiated_codec != CODEC_ID_CVSD)
 			select_codec(dev, CODEC_ID_CVSD);
 
 		return;
@@ -1023,7 +1026,7 @@ static void at_cmd_bcs(struct hfp_gw_result *result, enum hfp_gw_cmd_type type,
 		hfp_gw_send_result(dev->gw, HFP_RESULT_OK);
 
 		/* Connect sco with negotiated parameters */
-		connect_sco();
+		connect_sco(dev);
 		return;
 	case HFP_GW_CMD_TYPE_READ:
 	case HFP_GW_CMD_TYPE_TEST:
@@ -1671,38 +1674,38 @@ failed:
 					HAL_OP_HANDSFREE_DISCONNECT, status);
 }
 
-static bool disconnect_sco(void)
+static bool disconnect_sco(struct hf_device *dev)
 {
-	if (!device.sco)
+	if (!dev->sco)
 		return false;
 
-	set_audio_state(&device, HAL_EV_HANDSFREE_AUDIO_STATE_DISCONNECTING);
+	set_audio_state(dev, HAL_EV_HANDSFREE_AUDIO_STATE_DISCONNECTING);
 
-	if (device.sco_watch) {
-		g_source_remove(device.sco_watch);
-		device.sco_watch = 0;
+	if (dev->sco_watch) {
+		g_source_remove(dev->sco_watch);
+		dev->sco_watch = 0;
 	}
 
-	g_io_channel_shutdown(device.sco, TRUE, NULL);
-	g_io_channel_unref(device.sco);
-	device.sco = NULL;
+	g_io_channel_shutdown(dev->sco, TRUE, NULL);
+	g_io_channel_unref(dev->sco);
+	dev->sco = NULL;
 
-	set_audio_state(&device, HAL_EV_HANDSFREE_AUDIO_STATE_DISCONNECTED);
+	set_audio_state(dev, HAL_EV_HANDSFREE_AUDIO_STATE_DISCONNECTED);
 	return true;
 }
 
-static bool connect_audio(void)
+static bool connect_audio(struct hf_device *dev)
 {
-	if (device.audio_state != HAL_EV_HANDSFREE_AUDIO_STATE_DISCONNECTED)
+	if (dev->audio_state != HAL_EV_HANDSFREE_AUDIO_STATE_DISCONNECTED)
 		return false;
 
 	/* we haven't negotiated codec, start selection */
-	if ((device.features & HFP_HF_FEAT_CODEC) && !device.negotiated_codec) {
-		select_codec(&device, 0);
+	if ((dev->features & HFP_HF_FEAT_CODEC) && !dev->negotiated_codec) {
+		select_codec(dev, 0);
 		return true;
 	}
 
-	return connect_sco();
+	return connect_sco(dev);
 }
 
 static void handle_connect_audio(const void *buf, uint16_t len)
@@ -1721,7 +1724,7 @@ static void handle_connect_audio(const void *buf, uint16_t len)
 		goto done;
 	}
 
-	status = connect_audio() ? HAL_STATUS_SUCCESS : HAL_STATUS_FAILED;
+	status = connect_audio(&device) ? HAL_STATUS_SUCCESS : HAL_STATUS_FAILED;
 
 done:
 	ipc_send_rsp(hal_ipc, HAL_SERVICE_ID_HANDSFREE,
@@ -1744,7 +1747,7 @@ static void handle_disconnect_audio(const void *buf, uint16_t len)
 		goto done;
 	}
 
-	status = disconnect_sco() ? HAL_STATUS_SUCCESS : HAL_STATUS_FAILED;
+	status = disconnect_sco(&device) ? HAL_STATUS_SUCCESS : HAL_STATUS_FAILED;
 
 done:
 	ipc_send_rsp(hal_ipc, HAL_SERVICE_ID_HANDSFREE,
@@ -2032,7 +2035,7 @@ static void phone_state_dialing(int num_active, int num_held)
 		update_indicator(IND_CALLHELD, 2);
 
 	if (device.num_active == 0 && device.num_held == 0)
-		connect_audio();
+		connect_audio(&device);
 }
 
 static void phone_state_alerting(int num_active, int num_held)
@@ -2120,7 +2123,7 @@ static void phone_state_idle(int num_active, int num_held)
 			update_indicator(IND_CALL, 1);
 
 			if (device.num_active == 0 && device.num_held == 0)
-				connect_audio();
+				connect_audio(&device);
 		}
 
 		if (num_held > device.num_held)
@@ -2164,9 +2167,9 @@ static void phone_state_idle(int num_active, int num_held)
 			 * was no call setup change this means that there were
 			 * calls present when headset was connected.
 			 */
-			connect_audio();
+			connect_audio(&device);
 		} else if (num_active == 0 && num_held == 0) {
-			disconnect_sco();
+			disconnect_sco(&device);
 		}
 
 		update_indicator(IND_CALLHELD,
@@ -2372,7 +2375,7 @@ static void confirm_sco_cb(GIOChannel *chan, gpointer user_data)
 		goto drop;
 	}
 
-	if (!bt_io_accept(chan, connect_sco_cb, NULL, NULL, NULL)) {
+	if (!bt_io_accept(chan, connect_sco_cb, &device, NULL, NULL)) {
 		error("handsfree: failed to accept audio connection");
 		goto drop;
 	}
-- 
1.9.1

