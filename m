Return-Path: <cyrus@holtmann.org>
From: Szymon Janc <szymon.janc@tieto.com>
To: linux-bluetooth@vger.kernel.org
Cc: Szymon Janc <szymon.janc@tieto.com>
Subject: [PATCH v2 1/8] android/bluetooth: Refactor handle_start_discovery_cmd
Date: Sun, 27 Apr 2014 16:54:51 +0200
Message-Id: <1398610498-1112-1-git-send-email-szymon.janc@tieto.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

This makes function flow easier to follow. Also fix usage of
adapter.exp_discovery_type which should be used only when stopping
currently running discovery session to restart it with new type.
---
 android/bluetooth.c | 43 +++++++++++++++++++++----------------------
 1 file changed, 21 insertions(+), 22 deletions(-)

diff --git a/android/bluetooth.c b/android/bluetooth.c
index 7d82aba..3931618 100644
--- a/android/bluetooth.c
+++ b/android/bluetooth.c
@@ -3704,39 +3704,38 @@ static void handle_start_discovery_cmd(const void *buf, uint16_t len)
 {
 	uint8_t status;
 
-	/* Check if there is discovery with BREDR type */
-	if (adapter.cur_discovery_type & SCAN_TYPE_BREDR) {
-		status = HAL_STATUS_SUCCESS;
-		goto reply;
-	}
-
 	if (!(adapter.current_settings & MGMT_SETTING_POWERED)) {
 		status = HAL_STATUS_NOT_READY;
-		goto reply;
+		goto failed;
 	}
 
-	adapter.exp_discovery_type |= SCAN_TYPE_DUAL;
-
-	/* If there is no discovery ongoing, try to start discovery */
-	if (!adapter.cur_discovery_type) {
-		if (!start_discovery(adapter.exp_discovery_type))
+	switch (adapter.cur_discovery_type) {
+	case SCAN_TYPE_DUAL:
+	case SCAN_TYPE_BREDR:
+		break;
+	case SCAN_TYPE_NONE:
+		if (!start_discovery(SCAN_TYPE_DUAL)) {
 			status = HAL_STATUS_FAILED;
-		else
-			status = HAL_STATUS_SUCCESS;
+			goto failed;
+		}
 
-		goto reply;
-	}
+		break;
+	case SCAN_TYPE_LE:
+		if (get_adapter_discovering_type() == SCAN_TYPE_LE)
+			break;
 
-	/* Stop discovery here. Once it is stop we will restart it
-	 * with exp_discovery_settings */
-	if (!stop_discovery(adapter.cur_discovery_type)) {
-		status = HAL_STATUS_FAILED;
-		goto reply;
+		if (!stop_discovery(SCAN_TYPE_LE)) {
+			status = HAL_STATUS_FAILED;
+			goto failed;
+		}
+
+		adapter.exp_discovery_type = SCAN_TYPE_DUAL;
+		break;
 	}
 
 	status = HAL_STATUS_SUCCESS;
 
-reply:
+failed:
 	ipc_send_rsp(hal_ipc, HAL_SERVICE_ID_BLUETOOTH, HAL_OP_START_DISCOVERY,
 									status);
 }
-- 
1.9.1

