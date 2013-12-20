Return-Path: <cyrus@holtmann.org>
From: Szymon Janc <szymon.janc@tieto.com>
To: linux-bluetooth@vger.kernel.org
Cc: Szymon Janc <szymon.janc@tieto.com>
Subject: [PATCH 3/4] android/bluetooth: Print error on unimplemented functions
Date: Fri, 20 Dec 2013 19:30:09 +0100
Message-Id: <1387564210-6102-3-git-send-email-szymon.janc@tieto.com>
In-Reply-To: <1387564210-6102-1-git-send-email-szymon.janc@tieto.com>
References: <1387564210-6102-1-git-send-email-szymon.janc@tieto.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Functions or callbacks that are not implemented due to being bogus or
not feasible now prints error messages instead of debugs.
---
 android/bluetooth.c | 22 +++++++---------------
 1 file changed, 7 insertions(+), 15 deletions(-)

diff --git a/android/bluetooth.c b/android/bluetooth.c
index 59f0810..5598ad8 100644
--- a/android/bluetooth.c
+++ b/android/bluetooth.c
@@ -2059,9 +2059,7 @@ static uint8_t get_adapter_type(void)
 
 static uint8_t get_adapter_service_rec(void)
 {
-	DBG("Not implemented");
-
-	/* TODO: Add implementation */
+	error("get adapter BT_PROPERTY_SERVICE_RECORD not supported");
 
 	return HAL_STATUS_FAILED;
 }
@@ -2619,9 +2617,7 @@ static uint8_t get_device_type(struct device *dev)
 
 static uint8_t get_device_service_rec(struct device *dev)
 {
-	DBG("Not implemented");
-
-	/* TODO */
+	error("get device BT_PROPERTY_SERVICE_RECORD not supported");
 
 	return HAL_STATUS_FAILED;
 }
@@ -2650,9 +2646,7 @@ static uint8_t get_device_rssi(struct device *dev)
 
 static uint8_t get_device_version_info(struct device *dev)
 {
-	DBG("Not implemented");
-
-	/* TODO */
+	error("get device BT_PROPERTY_REMOTE_VERSION_INFO not supported");
 
 	return HAL_STATUS_FAILED;
 }
@@ -2768,9 +2762,7 @@ static uint8_t set_device_friendly_name(struct device *dev, const uint8_t *val,
 
 static uint8_t set_device_version_info(struct device *dev)
 {
-	DBG("Not implemented");
-
-	/* TODO */
+	error("set device BT_PROPERTY_REMOTE_VERSION_INFO not supported");
 
 	return HAL_STATUS_FAILED;
 }
@@ -2816,7 +2808,7 @@ failed:
 
 static void handle_get_remote_service_rec_cmd(const void *buf, uint16_t len)
 {
-	/* TODO */
+	error("get_remote_service_record not supported");
 
 	ipc_send_rsp(HAL_SERVICE_ID_BLUETOOTH, HAL_OP_GET_REMOTE_SERVICE_REC,
 							HAL_STATUS_FAILED);
@@ -2914,7 +2906,7 @@ static void handle_dut_mode_send_cmd(const void *buf, uint16_t len)
 		return;
 	}
 
-	DBG("opcode %u", cmd->opcode);
+	error("dut_mode_send not supported");
 
 	/* TODO */
 
@@ -2932,7 +2924,7 @@ static void handle_le_test_mode_cmd(const void *buf, uint16_t len)
 		return;
 	}
 
-	DBG("opcode %u", cmd->opcode);
+	error("le_test_mode not supported");
 
 	/* TODO */
 
-- 
1.8.3.2

