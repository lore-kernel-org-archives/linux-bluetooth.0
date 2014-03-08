Return-Path: <cyrus@holtmann.org>
From: Szymon Janc <szymon.janc@tieto.com>
To: linux-bluetooth@vger.kernel.org
Cc: Szymon Janc <szymon.janc@tieto.com>
Subject: [PATCH 06/20] android/handsfree: Add support for AT+CLCC command
Date: Sat,  8 Mar 2014 01:19:50 +0100
Message-Id: <1394238004-15691-7-git-send-email-szymon.janc@tieto.com>
In-Reply-To: <1394238004-15691-1-git-send-email-szymon.janc@tieto.com>
References: <1394238004-15691-1-git-send-email-szymon.janc@tieto.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

---
 android/handsfree.c | 72 +++++++++++++++++++++++++++++++++++++++++++++++++++--
 1 file changed, 70 insertions(+), 2 deletions(-)

diff --git a/android/handsfree.c b/android/handsfree.c
index 31eaabe..a2991b6 100644
--- a/android/handsfree.c
+++ b/android/handsfree.c
@@ -348,7 +348,20 @@ static void at_cmd_clcc(struct hfp_gw_result *result, enum hfp_gw_cmd_type type,
 {
 	DBG("");
 
-	/* TODO */
+	switch (type) {
+	case HFP_GW_CMD_TYPE_COMMAND:
+		if (hfp_gw_result_has_next(result))
+			break;
+
+		ipc_send_notif(hal_ipc, HAL_SERVICE_ID_HANDSFREE,
+					HAL_EV_HANDSFREE_CLCC, 0, NULL);
+
+		return;
+	case HFP_GW_CMD_TYPE_READ:
+	case HFP_GW_CMD_TYPE_TEST:
+	case HFP_GW_CMD_TYPE_SET:
+		break;
+	}
 
 	hfp_gw_send_result(device.gw, HFP_RESULT_ERROR);
 }
@@ -1278,10 +1291,65 @@ static void handle_at_resp(const void *buf, uint16_t len)
 
 static void handle_clcc_resp(const void *buf, uint16_t len)
 {
+	const struct hal_cmd_handsfree_clcc_response *cmd = buf;
+	uint8_t status;
+
+	if (len != sizeof(*cmd) + cmd->number_len) {
+		error("Invalid CLCC response command, terminating");
+		raise(SIGTERM);
+		return;
+	}
+
 	DBG("");
 
+	if (!cmd->index) {
+		hfp_gw_send_result(device.gw, HFP_RESULT_OK);
+
+		status = HAL_STATUS_SUCCESS;
+		goto done;
+	}
+
+	switch (cmd->state) {
+	/* according to comment in HAL only those can have number and type */
+	case HAL_HANDSFREE_CALL_STATE_INCOMING:
+	case HAL_HANDSFREE_CALL_STATE_WAITING:
+		if (cmd->number_len) {
+			char *number = g_malloc0(cmd->number_len + 1);
+
+			memcpy(number, cmd->number, cmd->number_len);
+
+			hfp_gw_send_info(device.gw,
+						"+CLCC: %u,%u,%u,%u,%u,%s,%u",
+						cmd->index, cmd->dir,
+						cmd->state, cmd->mode,
+						cmd->mpty, number, cmd->type);
+
+			g_free(number);
+
+			status = HAL_STATUS_SUCCESS;
+			break;
+		}
+
+		/* fall through */
+	case HAL_HANDSFREE_CALL_STATE_ACTIVE:
+	case HAL_HANDSFREE_CALL_STATE_HELD:
+	case HAL_HANDSFREE_CALL_STATE_DIALING:
+	case HAL_HANDSFREE_CALL_STATE_ALERTING:
+		hfp_gw_send_info(device.gw, "+CLCC: %u,%u,%u,%u,%u",
+					cmd->index, cmd->dir, cmd->state,
+					cmd->mode, cmd->mpty);
+
+		status = HAL_STATUS_SUCCESS;
+		break;
+	case HAL_HANDSFREE_CALL_STATE_IDLE:
+	default:
+		status = HAL_STATUS_FAILED;
+		break;
+	}
+
+done:
 	ipc_send_rsp(hal_ipc, HAL_SERVICE_ID_HANDSFREE,
-			HAL_OP_HANDSFREE_CLCC_RESPONSE, HAL_STATUS_FAILED);
+				HAL_OP_HANDSFREE_CLCC_RESPONSE, status);
 }
 
 static void handle_phone_state_change(const void *buf, uint16_t len)
-- 
1.8.5.3

