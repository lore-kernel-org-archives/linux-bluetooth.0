Return-Path: <cyrus@holtmann.org>
From: Lukasz Rymanowski <lukasz.rymanowski@tieto.com>
To: linux-bluetooth@vger.kernel.org
Cc: Lukasz Rymanowski <lukasz.rymanowski@tieto.com>
Subject: [PATCH v2 2/5] android/handsfree-client: Add handle incoming SCO connection
Date: Fri, 28 Nov 2014 10:37:22 +0100
Message-Id: <1417167445-29099-3-git-send-email-lukasz.rymanowski@tieto.com>
In-Reply-To: <1417167445-29099-1-git-send-email-lukasz.rymanowski@tieto.com>
References: <1417167445-29099-1-git-send-email-lukasz.rymanowski@tieto.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

---
 android/handsfree-client.c | 92 ++++++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 92 insertions(+)

diff --git a/android/handsfree-client.c b/android/handsfree-client.c
index 9e67c7f..be12d5e 100644
--- a/android/handsfree-client.c
+++ b/android/handsfree-client.c
@@ -116,6 +116,7 @@ struct device {
 	bdaddr_t bdaddr;
 	struct hfp_hf *hf;
 	uint8_t state;
+	uint8_t audio_state;
 
 	uint8_t negotiated_codec;
 	uint32_t features;
@@ -184,6 +185,7 @@ static struct device *device_create(const bdaddr_t *bdaddr)
 
 	bacpy(&dev->bdaddr, bdaddr);
 	dev->state = HAL_HF_CLIENT_CONN_STATE_DISCONNECTED;
+	dev->audio_state = HAL_HF_CLIENT_AUDIO_STATE_DISCONNECTED;
 
 	init_codecs(dev);
 
@@ -290,6 +292,26 @@ done:
 			HAL_OP_HF_CLIENT_DISCONNECT, status);
 }
 
+static void set_audio_state(struct device *dev, uint8_t state)
+{
+	struct hal_ev_hf_client_audio_state ev;
+	char address[18];
+
+	if (dev->audio_state == state)
+		return;
+
+	dev->audio_state = state;
+
+	ba2str(&dev->bdaddr, address);
+	DBG("device %s audio state %u", address, state);
+
+	bdaddr2android(&dev->bdaddr, ev.bdaddr);
+	ev.state = state;
+
+	ipc_send_notif(hal_ipc, HAL_SERVICE_ID_HANDSFREE_CLIENT,
+				HAL_EV_HF_CLIENT_AUDIO_STATE, sizeof(ev), &ev);
+}
+
 static void handle_connect_audio(const void *buf, uint16_t len)
 {
 	DBG("Not Implemented");
@@ -2009,6 +2031,72 @@ static void cleanup_hfp_hf(void)
 	}
 }
 
+static bool confirm_sco_cb(const bdaddr_t *addr, uint16_t *voice_settings)
+{
+	struct device *dev;
+
+	DBG("");
+
+	dev = find_device(addr);
+	if (!dev || dev->state != HAL_HF_CLIENT_CONN_STATE_SLC_CONNECTED) {
+		error("hf-client: No device or SLC not ready");
+		return false;
+	}
+
+	set_audio_state(dev, HAL_HF_CLIENT_AUDIO_STATE_CONNECTING);
+
+	if (codec_negotiation_supported(dev) &&
+			dev->negotiated_codec != CODEC_ID_CVSD)
+		*voice_settings = BT_VOICE_TRANSPARENT;
+	else
+		*voice_settings = BT_VOICE_CVSD_16BIT;
+
+	return true;
+}
+
+static void connect_sco_cb(enum sco_status status, const bdaddr_t *addr)
+{
+	struct device *dev;
+	uint8_t audio_state;
+
+	DBG("SCO Status %u", status);
+
+	/* Device shall be there, just sanity check */
+	dev = find_device(addr);
+	if (!dev) {
+		error("hf-client: There is no device?");
+		return;
+	}
+
+	if (status != SCO_STATUS_OK) {
+		audio_state = HAL_HF_CLIENT_AUDIO_STATE_DISCONNECTED;
+		goto done;
+	}
+
+	if (dev->negotiated_codec == CODEC_ID_MSBC)
+		audio_state = HAL_HF_CLIENT_AUDIO_STATE_CONNECTED_MSBC;
+	else
+		audio_state = HAL_HF_CLIENT_AUDIO_STATE_CONNECTED;
+
+done:
+	set_audio_state(dev, audio_state);
+}
+
+static void disconnect_sco_cb(const bdaddr_t *addr)
+{
+	struct device *dev;
+
+	DBG("");
+
+	dev = find_device(addr);
+	if (!dev) {
+		error("hf-client: No device");
+		return;
+	}
+
+	set_audio_state(dev, HAL_HF_CLIENT_AUDIO_STATE_DISCONNECTED);
+}
+
 bool bt_hf_client_register(struct ipc *ipc, const bdaddr_t *addr)
 {
 	DBG("");
@@ -2030,6 +2118,10 @@ bool bt_hf_client_register(struct ipc *ipc, const bdaddr_t *addr)
 		goto failed;
 	}
 
+	bt_sco_set_confirm_cb(sco, confirm_sco_cb);
+	bt_sco_set_connect_cb(sco, connect_sco_cb);
+	bt_sco_set_disconnect_cb(sco, disconnect_sco_cb);
+
 	hal_ipc = ipc;
 	ipc_register(hal_ipc, HAL_SERVICE_ID_HANDSFREE_CLIENT, cmd_handlers,
 						G_N_ELEMENTS(cmd_handlers));
-- 
1.8.4

