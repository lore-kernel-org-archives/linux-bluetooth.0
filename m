Return-Path: <cyrus@holtmann.org>
From: Lukasz Rymanowski <lukasz.rymanowski@tieto.com>
To: linux-bluetooth@vger.kernel.org
Cc: Lukasz Rymanowski <lukasz.rymanowski@tieto.com>
Subject: [PATCH v2 3/5] android/handsfree-client: Implement audio connect/disconnect
Date: Fri, 28 Nov 2014 10:37:23 +0100
Message-Id: <1417167445-29099-4-git-send-email-lukasz.rymanowski@tieto.com>
In-Reply-To: <1417167445-29099-1-git-send-email-lukasz.rymanowski@tieto.com>
References: <1417167445-29099-1-git-send-email-lukasz.rymanowski@tieto.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

---
 android/handsfree-client.c | 60 ++++++++++++++++++++++++++++++++++++++++++----
 1 file changed, 55 insertions(+), 5 deletions(-)

diff --git a/android/handsfree-client.c b/android/handsfree-client.c
index be12d5e..fd68d78 100644
--- a/android/handsfree-client.c
+++ b/android/handsfree-client.c
@@ -312,19 +312,69 @@ static void set_audio_state(struct device *dev, uint8_t state)
 				HAL_EV_HF_CLIENT_AUDIO_STATE, sizeof(ev), &ev);
 }
 
+static bool connect_sco(struct device *dev)
+{
+	/* TODO: handle codec negotiation */
+
+	return bt_sco_connect(sco, &dev->bdaddr, BT_VOICE_CVSD_16BIT);
+}
+
 static void handle_connect_audio(const void *buf, uint16_t len)
 {
-	DBG("Not Implemented");
+	const struct hal_cmd_hf_client_connect_audio *cmd = (void *) buf;
+	struct device *dev;
+	uint8_t status;
+	bdaddr_t bdaddr;
+
+	DBG("");
+
+	android2bdaddr(&cmd->bdaddr, &bdaddr);
+
+	dev = find_device(&bdaddr);
+	if (!dev || dev->state != HAL_HF_CLIENT_CONN_STATE_SLC_CONNECTED ||
+		dev->audio_state != HAL_HF_CLIENT_AUDIO_STATE_DISCONNECTED) {
+		error("hf-client: Cannot create SCO, check SLC or audio state");
+		status = HAL_STATUS_FAILED;
+		goto done;
+	}
+
+	if (connect_sco(dev)) {
+		status = HAL_STATUS_SUCCESS;
+		set_audio_state(dev, HAL_HF_CLIENT_AUDIO_STATE_CONNECTING);
+	} else {
+		status = HAL_STATUS_FAILED;
+	}
+
+done:
 	ipc_send_rsp(hal_ipc, HAL_SERVICE_ID_HANDSFREE_CLIENT,
-			HAL_OP_HF_CLIENT_CONNECT_AUDIO, HAL_STATUS_UNSUPPORTED);
+					HAL_OP_HF_CLIENT_CONNECT_AUDIO, status);
 }
 
 static void handle_disconnect_audio(const void *buf, uint16_t len)
 {
-	DBG("Not Implemented");
+	const struct hal_cmd_hf_client_disconnect_audio *cmd = (void *) buf;
+	struct device *dev;
+	uint8_t status;
+	bdaddr_t bdaddr;
+
+	DBG("");
+
+	android2bdaddr(&cmd->bdaddr, &bdaddr);
+
+	dev = find_device(&bdaddr);
+	if (!dev ||
+		dev->audio_state == HAL_HF_CLIENT_AUDIO_STATE_DISCONNECTED) {
+		error("hf-client: Device not found or audio not connected");
+		status = HAL_STATUS_FAILED;
+		goto done;
+	}
+
+	bt_sco_disconnect(sco);
+	status = HAL_STATUS_SUCCESS;
+
+done:
 	ipc_send_rsp(hal_ipc, HAL_SERVICE_ID_HANDSFREE_CLIENT,
-					HAL_OP_HF_CLIENT_DISCONNECT_AUDIO,
-					HAL_STATUS_UNSUPPORTED);
+				HAL_OP_HF_CLIENT_DISCONNECT_AUDIO, status);
 }
 
 static void cmd_complete_cb(enum hfp_result result, enum hfp_error cme_err,
-- 
1.8.4

