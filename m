Return-Path: <cyrus@holtmann.org>
From: Lukasz Rymanowski <lukasz.rymanowski@tieto.com>
To: linux-bluetooth@vger.kernel.org
Cc: Lukasz Rymanowski <lukasz.rymanowski@tieto.com>
Subject: [PATCH 3/4] android/handsfree: Use bt_sco lib in HFP AG code
Date: Tue,  2 Dec 2014 11:59:38 +0100
Message-Id: <1417517979-18136-4-git-send-email-lukasz.rymanowski@tieto.com>
In-Reply-To: <1417517979-18136-1-git-send-email-lukasz.rymanowski@tieto.com>
References: <1417517979-18136-1-git-send-email-lukasz.rymanowski@tieto.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

---
 android/handsfree.c | 181 +++++++++++++---------------------------------------
 1 file changed, 45 insertions(+), 136 deletions(-)

diff --git a/android/handsfree.c b/android/handsfree.c
index 45826d9..29cd498 100644
--- a/android/handsfree.c
+++ b/android/handsfree.c
@@ -48,6 +48,7 @@
 #include "src/log.h"
 #include "utils.h"
 #include "sco-msg.h"
+#include "sco.h"
 
 #define HSP_AG_CHANNEL 12
 #define HFP_AG_CHANNEL 13
@@ -137,9 +138,6 @@ struct hf_device {
 	bool hsp;
 
 	struct hfp_gw *gw;
-
-	GIOChannel *sco;
-	guint sco_watch;
 	guint delay_sco;
 };
 
@@ -173,7 +171,7 @@ static GIOChannel *hfp_server = NULL;
 static uint32_t hsp_record_id = 0;
 static GIOChannel *hsp_server = NULL;
 
-static GIOChannel *sco_server = NULL;
+static struct bt_sco *sco = NULL;
 
 static unsigned int max_hfp_clients = 0;
 
@@ -254,16 +252,11 @@ static void device_destroy(struct hf_device *dev)
 {
 	hfp_gw_unref(dev->gw);
 
-	if (dev->sco_watch)
-		g_source_remove(dev->sco_watch);
-
 	if (dev->delay_sco)
 		g_source_remove(dev->delay_sco);
 
-	if (dev->sco) {
-		g_io_channel_shutdown(dev->sco, TRUE, NULL);
-		g_io_channel_unref(dev->sco);
-	}
+	if (dev->audio_state == HAL_EV_HANDSFREE_AUDIO_STATE_CONNECTED)
+		bt_sco_disconnect(sco);
 
 	g_source_remove(dev->ring);
 	g_free(dev->clip);
@@ -936,22 +929,19 @@ static void at_cmd_btrh(struct hfp_context *context,
 	hfp_gw_send_result(dev->gw, HFP_RESULT_ERROR);
 }
 
-static gboolean sco_watch_cb(GIOChannel *chan, GIOCondition cond,
-							gpointer user_data)
+static void disconnect_sco_cb(const bdaddr_t *addr)
 {
-	struct hf_device *dev = user_data;
-
-	g_io_channel_shutdown(dev->sco, TRUE, NULL);
-	g_io_channel_unref(dev->sco);
-	dev->sco = NULL;
+	struct hf_device *dev;
 
 	DBG("");
 
-	dev->sco_watch = 0;
+	dev = find_device(addr);
+	if (!dev) {
+		error("handsfree: Could not find device");
+		return;
+	}
 
 	set_audio_state(dev, HAL_EV_HANDSFREE_AUDIO_STATE_DISCONNECTED);
-
-	return FALSE;
 }
 
 static void select_codec(struct hf_device *dev, uint8_t codec_type)
@@ -987,12 +977,18 @@ static bool codec_negotiation_supported(struct hf_device *dev)
 			(hfp_ag_features & HFP_AG_FEAT_CODEC);
 }
 
-static void connect_sco_cb(GIOChannel *chan, GError *err, gpointer user_data)
+static void connect_sco_cb(enum sco_status status, const bdaddr_t *addr)
 {
-	struct hf_device *dev = user_data;
+	struct hf_device *dev;
 
-	if (err) {
-		error("handsfree: audio connect failed (%s)", err->message);
+	dev = find_device(addr);
+	if (!dev) {
+		error("handsfree: Connect sco failed, no device?");
+		return;
+	}
+
+	if (status != SCO_STATUS_OK) {
+		error("handsfree: audio connect failed");
 
 		set_audio_state(dev, HAL_EV_HANDSFREE_AUDIO_STATE_DISCONNECTED);
 
@@ -1008,24 +1004,13 @@ static void connect_sco_cb(GIOChannel *chan, GError *err, gpointer user_data)
 		return;
 	}
 
-	g_io_channel_set_close_on_unref(chan, TRUE);
-
-	dev->sco = g_io_channel_ref(chan);
-	dev->sco_watch = g_io_add_watch(chan, G_IO_ERR | G_IO_HUP | G_IO_NVAL,
-							sco_watch_cb, dev);
-
 	set_audio_state(dev, HAL_EV_HANDSFREE_AUDIO_STATE_CONNECTED);
 }
 
 static bool connect_sco(struct hf_device *dev)
 {
-	GIOChannel *io;
-	GError *gerr = NULL;
 	uint16_t voice_settings;
 
-	if (dev->sco)
-		return false;
-
 	if (!codec_negotiation_supported(dev))
 		voice_settings = 0;
 	else if (dev->negotiated_codec != CODEC_ID_CVSD)
@@ -1033,19 +1018,8 @@ static bool connect_sco(struct hf_device *dev)
 	else
 		voice_settings = BT_VOICE_CVSD_16BIT;
 
-	io = bt_io_connect(connect_sco_cb, dev, NULL, &gerr,
-				BT_IO_OPT_SOURCE_BDADDR, &adapter_addr,
-				BT_IO_OPT_DEST_BDADDR, &dev->bdaddr,
-				BT_IO_OPT_VOICE, voice_settings,
-				BT_IO_OPT_INVALID);
-
-	if (!io) {
-		error("handsfree: unable to connect audio: %s", gerr->message);
-		g_error_free(gerr);
+	if (!bt_sco_connect(sco, &dev->bdaddr, voice_settings))
 		return false;
-	}
-
-	g_io_channel_unref(io);
 
 	set_audio_state(dev, HAL_EV_HANDSFREE_AUDIO_STATE_CONNECTING);
 
@@ -1841,30 +1815,11 @@ failed:
 					HAL_OP_HANDSFREE_DISCONNECT, status);
 }
 
-static bool disconnect_sco(struct hf_device *dev)
+static void disconnect_sco(struct hf_device *dev)
 {
-	if (!dev->sco) {
-		if (dev->delay_sco) {
-			g_source_remove(dev->delay_sco);
-			dev->delay_sco = 0;
-		}
-
-		return false;
-	}
-
+	bt_sco_disconnect(sco);
 	set_audio_state(dev, HAL_EV_HANDSFREE_AUDIO_STATE_DISCONNECTING);
-
-	if (dev->sco_watch) {
-		g_source_remove(dev->sco_watch);
-		dev->sco_watch = 0;
-	}
-
-	g_io_channel_shutdown(dev->sco, TRUE, NULL);
-	g_io_channel_unref(dev->sco);
-	dev->sco = NULL;
-
 	set_audio_state(dev, HAL_EV_HANDSFREE_AUDIO_STATE_DISCONNECTED);
-	return true;
 }
 
 static bool connect_audio(struct hf_device *dev)
@@ -1932,7 +1887,8 @@ static void handle_disconnect_audio(const void *buf, uint16_t len)
 		goto done;
 	}
 
-	status = disconnect_sco(dev) ? HAL_STATUS_SUCCESS : HAL_STATUS_FAILED;
+	disconnect_sco(dev);
+	status = HAL_STATUS_SUCCESS;
 
 done:
 	ipc_send_rsp(hal_ipc, HAL_SERVICE_ID_HANDSFREE,
@@ -2681,42 +2637,26 @@ static sdp_record_t *headset_ag_record(void)
 	return record;
 }
 
-static void confirm_sco_cb(GIOChannel *chan, gpointer user_data)
+static bool confirm_sco_cb(const bdaddr_t *addr, uint16_t *voice_settings)
 {
 	char address[18];
-	bdaddr_t bdaddr;
-	GError *err = NULL;
 	struct hf_device *dev;
 
-	bt_io_get(chan, &err,
-			BT_IO_OPT_DEST, address,
-			BT_IO_OPT_DEST_BDADDR, &bdaddr,
-			BT_IO_OPT_INVALID);
-	if (err) {
-		error("handsfree: audio confirm failed (%s)", err->message);
-		g_error_free(err);
-		goto drop;
-	}
+	ba2str(addr, address);
 
 	DBG("incoming SCO connection from %s", address);
 
-	dev = find_device(&bdaddr);
-	if (!dev || dev->state != HAL_EV_HANDSFREE_CONN_STATE_SLC_CONNECTED ||
-								dev->sco) {
+	dev = find_device(addr);
+	if (!dev || dev->state != HAL_EV_HANDSFREE_CONN_STATE_SLC_CONNECTED) {
 		error("handsfree: audio connection from %s rejected", address);
-		goto drop;
+		return false;
 	}
 
-	if (!bt_io_accept(chan, connect_sco_cb, dev, NULL, NULL)) {
-		error("handsfree: failed to accept audio connection");
-		goto drop;
-	}
+	/* If HF initiate SCO there must be no WBS used */
+	*voice_settings = 0;
 
 	set_audio_state(dev, HAL_EV_HANDSFREE_AUDIO_STATE_CONNECTING);
-	return;
-
-drop:
-	g_io_channel_shutdown(chan, TRUE, NULL);
+	return true;
 }
 
 static bool enable_hsp_ag(void)
@@ -2912,40 +2852,12 @@ static void cleanup_hfp_ag(void)
 	}
 }
 
-static bool enable_sco_server(void)
-{
-	GError *err = NULL;
-
-	sco_server = bt_io_listen(NULL, confirm_sco_cb, NULL, NULL, &err,
-				BT_IO_OPT_SOURCE_BDADDR, &adapter_addr,
-				BT_IO_OPT_INVALID);
-	if (!sco_server) {
-		error("handsfree: Failed to listen on SCO: %s", err->message);
-		g_error_free(err);
-		cleanup_hsp_ag();
-		cleanup_hfp_ag();
-		return false;
-	}
-
-	return true;
-}
-
-static void disable_sco_server(void)
-{
-	if (sco_server) {
-		g_io_channel_shutdown(sco_server, TRUE, NULL);
-		g_io_channel_unref(sco_server);
-		sco_server = NULL;
-	}
-}
-
 static void bt_sco_get_fd(const void *buf, uint16_t len)
 {
 	const struct sco_cmd_get_fd *cmd = buf;
 	struct sco_rsp_get_fd rsp;
 	struct hf_device *dev;
 	bdaddr_t bdaddr;
-	GError *err;
 	int fd;
 
 	DBG("");
@@ -2953,19 +2865,9 @@ static void bt_sco_get_fd(const void *buf, uint16_t len)
 	android2bdaddr(cmd->bdaddr, &bdaddr);
 
 	dev = find_device(&bdaddr);
-	if (!dev || !dev->sco)
+	if (!dev || !bt_sco_get_fd_and_mtu(sco, &fd, &rsp.mtu))
 		goto failed;
 
-	err = NULL;
-	if (!bt_io_get(dev->sco, &err, BT_IO_OPT_MTU, &rsp.mtu,
-							BT_IO_OPT_INVALID)) {
-		error("Unable to get MTU: %s\n", err->message);
-		g_clear_error(&err);
-		goto failed;
-	}
-
-	fd = g_io_channel_unix_get_fd(dev->sco);
-
 	DBG("fd %d mtu %u", fd, rsp.mtu);
 
 	ipc_send_rsp_full(sco_ipc, SCO_SERVICE_ID, SCO_OP_GET_FD,
@@ -3022,9 +2924,14 @@ bool bt_handsfree_register(struct ipc *ipc, const bdaddr_t *addr, uint8_t mode,
 	if (!enable_hsp_ag())
 		goto failed_queue;
 
-	if (!enable_sco_server())
+	sco = bt_sco_new(addr);
+	if (!sco)
 		goto failed_hsp;
 
+	bt_sco_set_confirm_cb(sco, confirm_sco_cb);
+	bt_sco_set_connect_cb(sco, connect_sco_cb);
+	bt_sco_set_disconnect_cb(sco, disconnect_sco_cb);
+
 	if (mode == HAL_MODE_HANDSFREE_HSP_ONLY)
 		goto done;
 
@@ -3036,7 +2943,8 @@ bool bt_handsfree_register(struct ipc *ipc, const bdaddr_t *addr, uint8_t mode,
 	if (enable_hfp_ag())
 		goto done;
 
-	disable_sco_server();
+	bt_sco_unref(sco);
+	sco = NULL;
 	hfp_ag_features = 0;
 failed_hsp:
 	cleanup_hsp_ag();
@@ -3068,7 +2976,8 @@ void bt_handsfree_unregister(void)
 
 	cleanup_hfp_ag();
 	cleanup_hsp_ag();
-	disable_sco_server();
+	bt_sco_unref(sco);
+	sco = NULL;
 
 	hfp_ag_features = 0;
 
-- 
1.8.4

