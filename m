Return-Path: <cyrus@holtmann.org>
From: Szymon Janc <szymon.janc@tieto.com>
To: linux-bluetooth@vger.kernel.org
Cc: Szymon Janc <szymon.janc@tieto.com>
Subject: [PATCH 04/20] android/handsfree: Add support for voice recognition function
Date: Sat,  8 Mar 2014 01:19:48 +0100
Message-Id: <1394238004-15691-5-git-send-email-szymon.janc@tieto.com>
In-Reply-To: <1394238004-15691-1-git-send-email-szymon.janc@tieto.com>
References: <1394238004-15691-1-git-send-email-szymon.janc@tieto.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

---
 android/hal-msg.h   |  3 +++
 android/handsfree.c | 48 +++++++++++++++++++++++++++++++++++++++++++++---
 2 files changed, 48 insertions(+), 3 deletions(-)

diff --git a/android/hal-msg.h b/android/hal-msg.h
index 1b2b31a..8859454 100644
--- a/android/hal-msg.h
+++ b/android/hal-msg.h
@@ -999,6 +999,9 @@ struct hal_ev_handsfree_audio_state {
 	uint8_t bdaddr[6];
 } __attribute__((packed));
 
+#define HAL_HANDSFREE_VR_STOPPED	0x00
+#define HAL_HANDSFREE_VR_STARTED	0x01
+
 #define HAL_EV_HANDSFREE_VR		0x83
 struct hal_ev_handsfree_vr_state {
 	uint8_t state;
diff --git a/android/handsfree.c b/android/handsfree.c
index e104c4a..b0226e8 100644
--- a/android/handsfree.c
+++ b/android/handsfree.c
@@ -416,9 +416,33 @@ static void at_cmd_bldn(struct hfp_gw_result *result, enum hfp_gw_cmd_type type,
 static void at_cmd_bvra(struct hfp_gw_result *result, enum hfp_gw_cmd_type type,
 							void *user_data)
 {
+	struct hal_ev_handsfree_vr_state ev;
+	unsigned int val;
+
 	DBG("");
 
-	/* TODO */
+	switch (type) {
+	case HFP_GW_CMD_TYPE_SET:
+		if (!hfp_gw_result_get_number(result, &val) || val > 1)
+			break;
+
+		if (hfp_gw_result_has_next(result))
+			break;
+
+		if (val)
+			ev.state = HAL_HANDSFREE_VR_STARTED;
+		else
+			ev.state = HAL_HANDSFREE_VR_STOPPED;
+
+		ipc_send_notif(hal_ipc, HAL_SERVICE_ID_HANDSFREE,
+					HAL_EV_HANDSFREE_VR, sizeof(ev), &ev);
+
+		return;
+	case HFP_GW_CMD_TYPE_READ:
+	case HFP_GW_CMD_TYPE_TEST:
+	case HFP_GW_CMD_TYPE_COMMAND:
+		break;
+	}
 
 	hfp_gw_send_result(device.gw, HFP_RESULT_ERROR);
 }
@@ -1013,18 +1037,36 @@ static void handle_disconnect_audio(const void *buf, uint16_t len)
 
 static void handle_start_vr(const void *buf, uint16_t len)
 {
+	uint8_t status;
+
 	DBG("");
 
+	if (device.features & HFP_HF_FEAT_VR) {
+		hfp_gw_send_info(device.gw, "+BVRA: 1");
+		status = HAL_STATUS_SUCCESS;
+	} else {
+		status = HAL_STATUS_FAILED;
+	}
+
 	ipc_send_rsp(hal_ipc, HAL_SERVICE_ID_HANDSFREE,
-				HAL_OP_HANDSFREE_START_VR, HAL_STATUS_FAILED);
+					HAL_OP_HANDSFREE_START_VR, status);
 }
 
 static void handle_stop_vr(const void *buf, uint16_t len)
 {
+	uint8_t status;
+
 	DBG("");
 
+	if (device.features & HFP_HF_FEAT_VR) {
+		hfp_gw_send_info(device.gw, "+BVRA: 0");
+		status = HAL_STATUS_SUCCESS;
+	} else {
+		status = HAL_STATUS_FAILED;
+	}
+
 	ipc_send_rsp(hal_ipc, HAL_SERVICE_ID_HANDSFREE,
-				HAL_OP_HANDSFREE_STOP_VR, HAL_STATUS_FAILED);
+				HAL_OP_HANDSFREE_STOP_VR, status);
 }
 
 static void handle_volume_control(const void *buf, uint16_t len)
-- 
1.8.5.3

