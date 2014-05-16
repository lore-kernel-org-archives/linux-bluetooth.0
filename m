Return-Path: <cyrus@holtmann.org>
From: Szymon Janc <szymon.janc@tieto.com>
To: linux-bluetooth@vger.kernel.org
Cc: Szymon Janc <szymon.janc@tieto.com>
Subject: [PATCH] android/gatt: Add stub for setting advertising data
Date: Fri, 16 May 2014 16:10:40 +0200
Message-Id: <1400249440-31062-1-git-send-email-szymon.janc@tieto.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Currently kernel is lacking support for fine grained configuration of
advertising data but this is ignored for now.

Vendor data is not supported and if it is to be set command will fail.
This should be implemented when kernel support is added.
---
 android/gatt.c | 32 ++++++++++++++++++++++++++++++--
 1 file changed, 30 insertions(+), 2 deletions(-)

diff --git a/android/gatt.c b/android/gatt.c
index 9bbcc48..067e14e 100644
--- a/android/gatt.c
+++ b/android/gatt.c
@@ -3242,10 +3242,38 @@ static void handle_client_get_device_type(const void *buf, uint16_t len)
 
 static void handle_client_set_adv_data(const void *buf, uint16_t len)
 {
-	DBG("");
+	const struct hal_cmd_gatt_client_set_adv_data *cmd = buf;
+	uint8_t status;
+
+	if (len != sizeof(*cmd) + cmd->manufacturer_len) {
+		error("Invalid set adv data command (%u bytes), terminating",
+									len);
+		raise(SIGTERM);
+		return;
+	}
+
+	DBG("scan_rsp=%u name=%u tx=%u min=%d max=%d app=%d manufacturer=%u",
+		cmd->set_scan_rsp, cmd->include_name, cmd->include_txpower,
+		cmd->min_interval, cmd->max_interval, cmd->appearance,
+		cmd->manufacturer_len);
+
+	/*
+	 * TODO
+	 * Currently kernel is setting all except for vendor data.
+	 * This should be implemented when kernel supports it.
+	 */
 
+	if (cmd->manufacturer_len) {
+		error("gatt: Manufacturer advertising data not supported");
+		status = HAL_STATUS_FAILED;
+		goto failed;
+	}
+
+	status = HAL_STATUS_SUCCESS;
+
+failed:
 	ipc_send_rsp(hal_ipc, HAL_SERVICE_ID_GATT,
-			HAL_OP_GATT_CLIENT_SET_ADV_DATA, HAL_STATUS_FAILED);
+				HAL_OP_GATT_CLIENT_SET_ADV_DATA, status);
 }
 
 static void handle_client_test_command(const void *buf, uint16_t len)
-- 
1.9.1

