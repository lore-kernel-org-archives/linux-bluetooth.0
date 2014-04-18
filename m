Return-Path: <cyrus@holtmann.org>
From: Szymon Janc <szymon.janc@tieto.com>
To: linux-bluetooth@vger.kernel.org
Cc: Szymon Janc <szymon.janc@tieto.com>
Subject: [PATCH 2/7] android/bluetooth: Refactor handle_cancel_discovery_cmd
Date: Fri, 18 Apr 2014 15:04:39 +0200
Message-Id: <1397826284-11118-2-git-send-email-szymon.janc@tieto.com>
In-Reply-To: <1397826284-11118-1-git-send-email-szymon.janc@tieto.com>
References: <1397826284-11118-1-git-send-email-szymon.janc@tieto.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

This makes function flow easier to follow. Also fix usage of
adapter.exp_discovery_type which should be used only when stopping
currently running discovery session to restart it with new type.
---
 android/bluetooth.c | 27 +++++++++++++++------------
 1 file changed, 15 insertions(+), 12 deletions(-)

diff --git a/android/bluetooth.c b/android/bluetooth.c
index 0e16f74..c38cec3 100644
--- a/android/bluetooth.c
+++ b/android/bluetooth.c
@@ -3741,27 +3741,30 @@ static void handle_cancel_discovery_cmd(const void *buf, uint16_t len)
 {
 	uint8_t status;
 
-	if (!adapter.cur_discovery_type) {
-		status = HAL_STATUS_SUCCESS;
-		goto reply;
-	}
-
 	if (!(adapter.current_settings & MGMT_SETTING_POWERED)) {
 		status = HAL_STATUS_NOT_READY;
-		goto reply;
+		goto failed;
 	}
 
-	/* Take into account that gatt might want to keep discover */
-	adapter.exp_discovery_type = gatt_device_found_cb ? SCAN_TYPE_LE : 0;
+	switch (adapter.cur_discovery_type) {
+	case SCAN_TYPE_NONE:
+	case SCAN_TYPE_LE:
+		break;
+	case SCAN_TYPE_DUAL:
+	case SCAN_TYPE_BREDR:
+		if (!stop_discovery(SCAN_TYPE_DUAL)) {
+			status = HAL_STATUS_FAILED;
+			goto failed;
+		}
 
-	if (!stop_discovery(adapter.cur_discovery_type)) {
-		status = HAL_STATUS_FAILED;
-		goto reply;
+		adapter.exp_discovery_type = gatt_device_found_cb ?
+						SCAN_TYPE_LE : SCAN_TYPE_NONE;
+		break;
 	}
 
 	status = HAL_STATUS_SUCCESS;
 
-reply:
+failed:
 	ipc_send_rsp(hal_ipc, HAL_SERVICE_ID_BLUETOOTH, HAL_OP_CANCEL_DISCOVERY,
 									status);
 }
-- 
1.9.1

