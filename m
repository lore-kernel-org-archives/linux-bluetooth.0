Return-Path: <cyrus@holtmann.org>
From: Ravi kumar Veeramally <ravikumar.veeramally@linux.intel.com>
To: linux-bluetooth@vger.kernel.org
Cc: Ravi kumar Veeramally <ravikumar.veeramally@linux.intel.com>
Subject: [PATCH 4/4] android/avrcp: Add support for controller send passthrough command
Date: Mon, 17 Nov 2014 14:59:17 +0200
Message-Id: <1416229157-10128-4-git-send-email-ravikumar.veeramally@linux.intel.com>
In-Reply-To: <1416229157-10128-1-git-send-email-ravikumar.veeramally@linux.intel.com>
References: <1416229157-10128-1-git-send-email-ravikumar.veeramally@linux.intel.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

---
 android/avrcp.c | 26 +++++++++++++++++++++++---
 1 file changed, 23 insertions(+), 3 deletions(-)

diff --git a/android/avrcp.c b/android/avrcp.c
index 335b957..b5676c0 100644
--- a/android/avrcp.c
+++ b/android/avrcp.c
@@ -1193,11 +1193,31 @@ void bt_avrcp_disconnect(const bdaddr_t *dst)
 
 static void handle_send_passthrough(const void *buf, uint16_t len)
 {
-	DBG("Not Implemented");
+	const struct hal_cmd_avrcp_ctrl_send_passthrough *cmd = buf;
+	struct avrcp_device *dev;
+	bdaddr_t dst;
+	uint8_t status;
+
+	DBG("");
+
+	android2bdaddr(&cmd->bdaddr, &dst);
+	dev = avrcp_device_find(&dst);
+	if (!dev || !dev->session) {
+		status = HAL_STATUS_INVALID;
+		goto reply;
+	}
+
+	if (avrcp_send_passthrough(dev->session, cmd->key_code,
+							cmd->key_state)) {
+		status = HAL_STATUS_FAILED;
+		goto reply;
+	}
+
+	status = HAL_STATUS_SUCCESS;
 
+reply:
 	ipc_send_rsp(hal_ipc_ctrl, HAL_SERVICE_ID_AVRCP_CTRL,
-					HAL_OP_AVRCP_CTRL_SEND_PASSTHROUGH,
-							HAL_STATUS_UNSUPPORTED);
+				HAL_OP_AVRCP_CTRL_SEND_PASSTHROUGH, status);
 }
 
 static const struct ipc_handler ctrl_cmd_handlers[] = {
-- 
2.1.0

