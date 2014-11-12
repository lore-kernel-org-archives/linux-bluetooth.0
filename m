Return-Path: <cyrus@holtmann.org>
From: Lukasz Rymanowski <lukasz.rymanowski@tieto.com>
To: linux-bluetooth@vger.kernel.org
Cc: Lukasz Rymanowski <lukasz.rymanowski@tieto.com>
Subject: [PATCH 02/14] android/handsfree-client: Add volume control handling
Date: Wed, 12 Nov 2014 11:49:25 +0100
Message-Id: <1415789377-20458-3-git-send-email-lukasz.rymanowski@tieto.com>
In-Reply-To: <1415789377-20458-1-git-send-email-lukasz.rymanowski@tieto.com>
References: <1415789377-20458-1-git-send-email-lukasz.rymanowski@tieto.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

---
 android/handsfree-client.c | 65 ++++++++++++++++++++++++++++++++++++++++++++--
 1 file changed, 63 insertions(+), 2 deletions(-)

diff --git a/android/handsfree-client.c b/android/handsfree-client.c
index d8b0bb1..e498f89 100644
--- a/android/handsfree-client.c
+++ b/android/handsfree-client.c
@@ -391,10 +391,39 @@ done:
 
 static void handle_volume_control(const void *buf, uint16_t len)
 {
-	DBG("Not Implemented");
+	const struct hal_cmd_hf_client_volume_control *cmd = buf;
+	struct device *dev;
+	uint8_t status;
+	bool ret;
+
+	DBG("");
+
+	dev = find_default_device();
+	if (!dev) {
+		status = HAL_STATUS_FAILED;
+		goto done;
+	}
+
+	switch (cmd->type) {
+	case HF_CLIENT_VOLUME_TYPE_SPEAKER:
+		ret = hfp_hf_send_command(dev->hf, cmd_complete_cb, NULL,
+						"AT+VGS=%d", cmd->volume);
+		break;
+	case HF_CLIENT_VOLUME_TYPE_MIC:
+		ret = hfp_hf_send_command(dev->hf, cmd_complete_cb, NULL,
+						"AT+VGM=%d", cmd->volume);
+		break;
+	default:
+		ret = false;
+		break;
+	}
+
+	status = ret ? HAL_STATUS_SUCCESS : HAL_STATUS_FAILED;
+
+done:
 	ipc_send_rsp(hal_ipc, HAL_SERVICE_ID_HANDSFREE_CLIENT,
 					HAL_OP_HF_CLIENT_VOLUME_CONTROL,
-					HAL_STATUS_UNSUPPORTED);
+					status);
 }
 
 static void handle_dial(const void *buf, uint16_t len)
@@ -543,6 +572,36 @@ static void bvra_cb(struct hfp_context *context, void *user_data)
 				HAL_EV_HF_CLIENT_VR_STATE, sizeof(ev), &ev);
 }
 
+static void vgm_cb(struct hfp_context *context, void *user_data)
+{
+	struct hal_ev_hf_client_volume_changed ev;
+	uint32_t val;
+
+	if (!hfp_context_get_number(context, &val))
+		return;
+
+	ev.type = HF_CLIENT_VOLUME_TYPE_MIC;
+	ev.volume = val;
+
+	ipc_send_notif(hal_ipc, HAL_SERVICE_ID_HANDSFREE_CLIENT,
+				HAL_EV_HF_CLIENT_VR_STATE, sizeof(ev), &ev);
+}
+
+static void vgs_cb(struct hfp_context *context, void *user_data)
+{
+	struct hal_ev_hf_client_volume_changed ev;
+	uint32_t val;
+
+	if (!hfp_context_get_number(context, &val))
+		return;
+
+	ev.type = HF_CLIENT_VOLUME_TYPE_SPEAKER;
+	ev.volume = val;
+
+	ipc_send_notif(hal_ipc, HAL_SERVICE_ID_HANDSFREE_CLIENT,
+			HAL_EV_CLIENT_VOLUME_CHANGED, sizeof(ev), &ev);
+}
+
 static void slc_completed(struct device *dev)
 {
 	DBG("");
@@ -555,6 +614,8 @@ static void slc_completed(struct device *dev)
 	 */
 
 	hfp_hf_register(dev->hf, bvra_cb, "+BRVA", dev, NULL);
+	hfp_hf_register(dev->hf, vgm_cb, "+VGM", dev, NULL);
+	hfp_hf_register(dev->hf, vgs_cb, "+VGS", dev, NULL);
 }
 
 static void slc_chld_cb(struct hfp_context *context, void *user_data)
-- 
1.8.4

