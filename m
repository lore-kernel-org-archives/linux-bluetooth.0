Return-Path: <cyrus@holtmann.org>
From: Szymon Janc <szymon.janc@tieto.com>
To: linux-bluetooth@vger.kernel.org
Cc: Szymon Janc <szymon.janc@tieto.com>
Subject: [PATCH v2 02/12] android/handsfree: Make init, cleanup and state functions static less
Date: Wed,  8 Oct 2014 12:15:04 +0200
Message-Id: <1412763314-12871-2-git-send-email-szymon.janc@tieto.com>
In-Reply-To: <1412763314-12871-1-git-send-email-szymon.janc@tieto.com>
References: <1412763314-12871-1-git-send-email-szymon.janc@tieto.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

---
 android/handsfree.c | 122 ++++++++++++++++++++++++++--------------------------
 1 file changed, 60 insertions(+), 62 deletions(-)

diff --git a/android/handsfree.c b/android/handsfree.c
index 0b82223..f11e0a1 100644
--- a/android/handsfree.c
+++ b/android/handsfree.c
@@ -171,102 +171,102 @@ static GIOChannel *hsp_server = NULL;
 
 static GIOChannel *sco_server = NULL;
 
-static void device_set_state(uint8_t state)
+static void set_state(struct hf_device *dev, uint8_t state)
 {
 	struct hal_ev_handsfree_conn_state ev;
 	char address[18];
 
-	if (device.state == state)
+	if (dev->state == state)
 		return;
 
-	device.state = state;
+	dev->state = state;
 
-	ba2str(&device.bdaddr, address);
+	ba2str(&dev->bdaddr, address);
 	DBG("device %s state %u", address, state);
 
-	bdaddr2android(&device.bdaddr, ev.bdaddr);
+	bdaddr2android(&dev->bdaddr, ev.bdaddr);
 	ev.state = state;
 
 	ipc_send_notif(hal_ipc, HAL_SERVICE_ID_HANDSFREE,
 				HAL_EV_HANDSFREE_CONN_STATE, sizeof(ev), &ev);
 }
 
-static void device_set_audio_state(uint8_t state)
+static void set_audio_state(struct hf_device *dev, uint8_t state)
 {
 	struct hal_ev_handsfree_audio_state ev;
 	char address[18];
 
-	if (device.audio_state == state)
+	if (dev->audio_state == state)
 		return;
 
-	device.audio_state = state;
+	dev->audio_state = state;
 
-	ba2str(&device.bdaddr, address);
+	ba2str(&dev->bdaddr, address);
 	DBG("device %s audio state %u", address, state);
 
-	bdaddr2android(&device.bdaddr, ev.bdaddr);
+	bdaddr2android(&dev->bdaddr, ev.bdaddr);
 	ev.state = state;
 
 	ipc_send_notif(hal_ipc, HAL_SERVICE_ID_HANDSFREE,
 				HAL_EV_HANDSFREE_AUDIO_STATE, sizeof(ev), &ev);
 }
 
-static void init_codecs(void)
+static void init_codecs(struct hf_device *dev)
 {
-	memcpy(device.codecs, codecs_defaults, sizeof(device.codecs));
+	memcpy(dev->codecs, codecs_defaults, sizeof(dev->codecs));
 
 	if (hfp_ag_features & HFP_AG_FEAT_CODEC)
-		device.codecs[MSBC_OFFSET].local_supported = true;
+		dev->codecs[MSBC_OFFSET].local_supported = true;
 }
 
-static void device_init(const bdaddr_t *bdaddr)
+static void device_init(struct hf_device *dev, const bdaddr_t *bdaddr)
 {
-	bacpy(&device.bdaddr, bdaddr);
+	bacpy(&dev->bdaddr, bdaddr);
 
-	device.setup_state = HAL_HANDSFREE_CALL_STATE_IDLE;
+	dev->setup_state = HAL_HANDSFREE_CALL_STATE_IDLE;
 
-	memcpy(device.inds, inds_defaults, sizeof(device.inds));
+	memcpy(dev->inds, inds_defaults, sizeof(dev->inds));
 
-	init_codecs();
+	init_codecs(dev);
 
-	device_set_state(HAL_EV_HANDSFREE_CONN_STATE_CONNECTING);
+	set_state(dev, HAL_EV_HANDSFREE_CONN_STATE_CONNECTING);
 }
 
-static void device_cleanup(void)
+static void device_cleanup(struct hf_device *dev)
 {
-	if (device.gw) {
-		hfp_gw_unref(device.gw);
-		device.gw = NULL;
+	if (dev->gw) {
+		hfp_gw_unref(dev->gw);
+		dev->gw = NULL;
 	}
 
-	device_set_state(HAL_EV_HANDSFREE_CONN_STATE_DISCONNECTED);
+	set_state(dev, HAL_EV_HANDSFREE_CONN_STATE_DISCONNECTED);
 
-	if (device.sco_watch) {
-		g_source_remove(device.sco_watch);
-		device.sco_watch = 0;
+	if (dev->sco_watch) {
+		g_source_remove(dev->sco_watch);
+		dev->sco_watch = 0;
 	}
 
-	if (device.sco) {
-		g_io_channel_shutdown(device.sco, TRUE, NULL);
-		g_io_channel_unref(device.sco);
-		device.sco = NULL;
+	if (dev->sco) {
+		g_io_channel_shutdown(dev->sco, TRUE, NULL);
+		g_io_channel_unref(dev->sco);
+		dev->sco = NULL;
 	}
 
-	if (device.ring) {
-		g_source_remove(device.ring);
-		device.ring = 0;
+	if (dev->ring) {
+		g_source_remove(dev->ring);
+		dev->ring = 0;
 	}
 
-	device_set_audio_state(HAL_EV_HANDSFREE_AUDIO_STATE_DISCONNECTED);
+	set_audio_state(dev, HAL_EV_HANDSFREE_AUDIO_STATE_DISCONNECTED);
 
-	memset(&device, 0, sizeof(device));
+	memset(dev, 0, sizeof(*dev));
 }
 
 static void disconnect_watch(void *user_data)
 {
 	DBG("");
 
-	device_cleanup();
+	device_cleanup(&device);
 }
 
 static void at_cmd_unknown(const char *command, void *user_data)
@@ -833,7 +833,7 @@ static gboolean sco_watch_cb(GIOChannel *chan, GIOCondition cond,
 
 	device.sco_watch = 0;
 
-	device_set_audio_state(HAL_EV_HANDSFREE_AUDIO_STATE_DISCONNECTED);
+	set_audio_state(&device, HAL_EV_HANDSFREE_AUDIO_STATE_DISCONNECTED);
 
 	return FALSE;
 }
@@ -868,12 +868,10 @@ done:
 static void connect_sco_cb(GIOChannel *chan, GError *err, gpointer user_data)
 {
 	if (err) {
-		uint8_t status;
-
 		error("handsfree: audio connect failed (%s)", err->message);
 
-		status = HAL_EV_HANDSFREE_AUDIO_STATE_DISCONNECTED;
-		device_set_audio_state(status);
+		set_audio_state(&device,
+				HAL_EV_HANDSFREE_AUDIO_STATE_DISCONNECTED);
 
 		if (!(device.features & HFP_HF_FEAT_CODEC))
 			return;
@@ -893,7 +891,7 @@ static void connect_sco_cb(GIOChannel *chan, GError *err, gpointer user_data)
 	device.sco_watch = g_io_add_watch(chan, G_IO_ERR | G_IO_HUP | G_IO_NVAL,
 							sco_watch_cb, NULL);
 
-	device_set_audio_state(HAL_EV_HANDSFREE_AUDIO_STATE_CONNECTED);
+	set_audio_state(&device, HAL_EV_HANDSFREE_AUDIO_STATE_CONNECTED);
 }
 
 static bool connect_sco(void)
@@ -926,7 +924,7 @@ static bool connect_sco(void)
 
 	g_io_channel_unref(io);
 
-	device_set_audio_state(HAL_EV_HANDSFREE_AUDIO_STATE_CONNECTING);
+	set_audio_state(&device, HAL_EV_HANDSFREE_AUDIO_STATE_CONNECTING);
 
 	return true;
 }
@@ -1101,7 +1099,7 @@ static void at_cmd_cmer(struct hfp_gw_result *result, enum hfp_gw_cmd_type type,
 			return;
 
 		register_post_slc_at();
-		device_set_state(HAL_EV_HANDSFREE_CONN_STATE_SLC_CONNECTED);
+		set_state(&device, HAL_EV_HANDSFREE_CONN_STATE_SLC_CONNECTED);
 		return;
 	case HFP_GW_CMD_TYPE_TEST:
 	case HFP_GW_CMD_TYPE_READ:
@@ -1225,7 +1223,7 @@ static void at_cmd_chld(struct hfp_gw_result *result, enum hfp_gw_cmd_type type,
 		hfp_gw_send_result(device.gw, HFP_RESULT_OK);
 
 		register_post_slc_at();
-		device_set_state(HAL_EV_HANDSFREE_CONN_STATE_SLC_CONNECTED);
+		set_state(&device, HAL_EV_HANDSFREE_CONN_STATE_SLC_CONNECTED);
 		return;
 	case HFP_GW_CMD_TYPE_READ:
 	case HFP_GW_CMD_TYPE_COMMAND:
@@ -1259,7 +1257,7 @@ static void at_cmd_bac(struct hfp_gw_result *result, enum hfp_gw_cmd_type type,
 			goto failed;
 
 		/* set codecs to defaults */
-		init_codecs();
+		init_codecs(&device);
 		device.negotiated_codec = 0;
 
 		/*
@@ -1337,18 +1335,18 @@ static void connect_cb(GIOChannel *chan, GError *err, gpointer user_data)
 
 	if (device.hsp) {
 		register_post_slc_at();
-		device_set_state(HAL_EV_HANDSFREE_CONN_STATE_CONNECTED);
-		device_set_state(HAL_EV_HANDSFREE_CONN_STATE_SLC_CONNECTED);
+		set_state(&device, HAL_EV_HANDSFREE_CONN_STATE_CONNECTED);
+		set_state(&device, HAL_EV_HANDSFREE_CONN_STATE_SLC_CONNECTED);
 		return;
 	}
 
 	register_slc_at();
-	device_set_state(HAL_EV_HANDSFREE_CONN_STATE_CONNECTED);
+	set_state(&device, HAL_EV_HANDSFREE_CONN_STATE_CONNECTED);
 	return;
 
 failed:
 	g_io_channel_shutdown(chan, TRUE, NULL);
-	device_cleanup();
+	device_cleanup(&device);
 }
 
 static void confirm_cb(GIOChannel *chan, gpointer data)
@@ -1374,11 +1372,11 @@ static void confirm_cb(GIOChannel *chan, gpointer data)
 		goto drop;
 	}
 
-	device_init(&bdaddr);
+	device_init(&device, &bdaddr);
 
 	if (!bt_io_accept(chan, connect_cb, NULL, NULL, NULL)) {
 		error("handsfree: failed to accept connection");
-		device_cleanup();
+		device_cleanup(&device);
 		goto drop;
 	}
 
@@ -1460,7 +1458,7 @@ static void sdp_hsp_search_cb(sdp_list_t *recs, int err, gpointer data)
 	return;
 
 fail:
-	device_cleanup();
+	device_cleanup(&device);
 }
 
 static int sdp_search_hsp(void)
@@ -1547,7 +1545,7 @@ static void sdp_hfp_search_cb(sdp_list_t *recs, int err, gpointer data)
 	return;
 
 fail:
-	device_cleanup();
+	device_cleanup(&device);
 }
 
 static int sdp_search_hfp(void)
@@ -1580,13 +1578,13 @@ static void handle_connect(const void *buf, uint16_t len)
 	ba2str(&bdaddr, addr);
 	DBG("connecting to %s", addr);
 
-	device_init(&bdaddr);
+	device_init(&device, &bdaddr);
 
 	/* prefer HFP over HSP */
 	ret = hfp_server ? sdp_search_hfp() : sdp_search_hsp();
 	if (ret < 0) {
 		error("handsfree: SDP search failed");
-		device_cleanup();
+		device_cleanup(&device);
 		status = HAL_STATUS_FAILED;
 		goto failed;
 	}
@@ -1620,9 +1618,9 @@ static void handle_disconnect(const void *buf, uint16_t len)
 	}
 
 	if (device.state == HAL_EV_HANDSFREE_CONN_STATE_CONNECTING) {
-		device_cleanup();
+		device_cleanup(&device);
 	} else {
-		device_set_state(HAL_EV_HANDSFREE_CONN_STATE_DISCONNECTING);
+		set_state(&device, HAL_EV_HANDSFREE_CONN_STATE_DISCONNECTING);
 		hfp_gw_disconnect(device.gw);
 	}
 
@@ -1638,7 +1636,7 @@ static bool disconnect_sco(void)
 	if (!device.sco)
 		return false;
 
-	device_set_audio_state(HAL_EV_HANDSFREE_AUDIO_STATE_DISCONNECTING);
+	set_audio_state(&device, HAL_EV_HANDSFREE_AUDIO_STATE_DISCONNECTING);
 
 	if (device.sco_watch) {
 		g_source_remove(device.sco_watch);
@@ -1649,7 +1647,7 @@ static bool disconnect_sco(void)
 	g_io_channel_unref(device.sco);
 	device.sco = NULL;
 
-	device_set_audio_state(HAL_EV_HANDSFREE_AUDIO_STATE_DISCONNECTED);
+	set_audio_state(&device, HAL_EV_HANDSFREE_AUDIO_STATE_DISCONNECTED);
 	return true;
 }
 
@@ -2339,7 +2337,7 @@ static void confirm_sco_cb(GIOChannel *chan, gpointer user_data)
 		goto drop;
 	}
 
-	device_set_audio_state(HAL_EV_HANDSFREE_AUDIO_STATE_CONNECTING);
+	set_audio_state(&device, HAL_EV_HANDSFREE_AUDIO_STATE_CONNECTING);
 	return;
 
 drop:
-- 
1.9.1

