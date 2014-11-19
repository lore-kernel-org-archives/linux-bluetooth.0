Return-Path: <cyrus@holtmann.org>
From: Lukasz Rymanowski <lukasz.rymanowski@tieto.com>
To: linux-bluetooth@vger.kernel.org
Cc: Lukasz Rymanowski <lukasz.rymanowski@tieto.com>
Subject: [PATCH v2 05/15] android/handsfree-client: Add call action implementation
Date: Wed, 19 Nov 2014 10:43:38 +0100
Message-Id: <1416390228-28330-6-git-send-email-lukasz.rymanowski@tieto.com>
In-Reply-To: <1416390228-28330-1-git-send-email-lukasz.rymanowski@tieto.com>
References: <1416390228-28330-1-git-send-email-lukasz.rymanowski@tieto.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

---
 android/handsfree-client.c | 103 ++++++++++++++++++++++++++++++++++++++++++++-
 1 file changed, 101 insertions(+), 2 deletions(-)

diff --git a/android/handsfree-client.c b/android/handsfree-client.c
index 2b9a3ac..c6812ec 100644
--- a/android/handsfree-client.c
+++ b/android/handsfree-client.c
@@ -511,9 +511,87 @@ done:
 
 static void handle_call_action(const void *buf, uint16_t len)
 {
-	DBG("Not Implemented");
+	const struct hal_cmd_hf_client_call_action *cmd = buf;
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
+	switch (cmd->action) {
+	case HAL_HF_CLIENT_ACTION_CHLD_0:
+		ret = hfp_hf_send_command(dev->hf, cmd_complete_cb, NULL,
+								"AT+CHLD=0");
+		break;
+	case HAL_HF_CLIENT_ACTION_CHLD_1:
+		ret = hfp_hf_send_command(dev->hf, cmd_complete_cb, NULL,
+								"AT+CHLD=1");
+		break;
+	case HAL_HF_CLIENT_ACTION_CHLD_2:
+		ret = hfp_hf_send_command(dev->hf, cmd_complete_cb,
+							NULL, "AT+CHLD=2");
+		break;
+	case HAL_HF_CLIENT_ACTION_CHLD_3:
+		ret = hfp_hf_send_command(dev->hf, cmd_complete_cb, NULL,
+								"AT+CHLD=3");
+		break;
+	case HAL_HF_CLIENT_ACTION_CHLD_4:
+		ret = hfp_hf_send_command(dev->hf, cmd_complete_cb, NULL,
+								"AT+CHLD=4");
+		break;
+	case HAL_HF_CLIENT_ACTION_CHLD_1x:
+		/* Index is int in BT HAL. Let's be paranoid here */
+		if (cmd->index < 0)
+			ret = false;
+		else
+			ret = hfp_hf_send_command(dev->hf, cmd_complete_cb,
+					NULL, "AT+CHLD=1%d", cmd->index);
+		break;
+	case HAL_HF_CLIENT_ACTION_CHLD_2x:
+		/* Index is int in BT HAL. Let's be paranoid here */
+		if (cmd->index < 0)
+			ret = false;
+		else
+			ret = hfp_hf_send_command(dev->hf, cmd_complete_cb,
+					NULL, "AT+CHLD=2%d", cmd->index);
+		break;
+	case HAL_HF_CLIENT_ACTION_ATA:
+		ret = hfp_hf_send_command(dev->hf, cmd_complete_cb, NULL,
+									"ATA");
+		break;
+	case HAL_HF_CLIENT_ACTION_CHUP:
+		ret = hfp_hf_send_command(dev->hf, cmd_complete_cb, NULL,
+								"AT+CHUP");
+		break;
+	case HAL_HF_CLIENT_ACTION_BRTH_0:
+		ret = hfp_hf_send_command(dev->hf, cmd_complete_cb, NULL,
+								"AT+BTRH=0");
+		break;
+	case HAL_HF_CLIENT_ACTION_BRTH_1:
+		ret = hfp_hf_send_command(dev->hf, cmd_complete_cb, NULL,
+								"AT+BTRH=1");
+		break;
+	case HAL_HF_CLIENT_ACTION_BRTH_2:
+		ret = hfp_hf_send_command(dev->hf, cmd_complete_cb, NULL,
+								"AT+BTRH=2");
+		break;
+	default:
+		error("hf-client: Unknown action %d", cmd->action);
+		ret = false;
+		break;
+	}
+
+	status = ret ? HAL_STATUS_SUCCESS : HAL_STATUS_FAILED;
+
+done:
 	ipc_send_rsp(hal_ipc, HAL_SERVICE_ID_HANDSFREE_CLIENT,
-			HAL_OP_HF_CLIENT_CALL_ACTION, HAL_STATUS_UNSUPPORTED);
+					HAL_OP_HF_CLIENT_CALL_ACTION, status);
 }
 
 static void handle_query_current_calls(const void *buf, uint16_t len)
@@ -662,6 +740,26 @@ static void vgs_cb(struct hfp_context *context, void *user_data)
 			HAL_EV_CLIENT_VOLUME_CHANGED, sizeof(ev), &ev);
 }
 
+static void brth_cb(struct hfp_context *context, void *user_data)
+{
+	struct hal_ev_hf_client_response_and_hold_status ev;
+	unsigned int val;
+
+	DBG("");
+
+	if (!hfp_context_get_number(context, &val) ||
+			val > HAL_HF_CLIENT_RESP_AND_HOLD_STATUS_REJECT) {
+		error("hf-client: incorrect BTRH response ");
+		return;
+	}
+
+	ev.status = val;
+
+	ipc_send_notif(hal_ipc, HAL_SERVICE_ID_HANDSFREE_CLIENT,
+				HAL_EV_HF_CLIENT_RESPONSE_AND_HOLD_STATUS,
+				sizeof(ev), &ev);
+}
+
 static void slc_completed(struct device *dev)
 {
 	DBG("");
@@ -676,6 +774,7 @@ static void slc_completed(struct device *dev)
 	hfp_hf_register(dev->hf, bvra_cb, "+BRVA", dev, NULL);
 	hfp_hf_register(dev->hf, vgm_cb, "+VGM", dev, NULL);
 	hfp_hf_register(dev->hf, vgs_cb, "+VGS", dev, NULL);
+	hfp_hf_register(dev->hf, brth_cb, "+BTRH", dev, NULL);
 }
 
 static void slc_chld_cb(struct hfp_context *context, void *user_data)
-- 
1.8.4

