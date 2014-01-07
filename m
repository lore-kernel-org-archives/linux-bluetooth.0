Return-Path: <cyrus@holtmann.org>
From: Lukasz Rymanowski <lukasz.rymanowski@tieto.com>
To: <linux-bluetooth@vger.kernel.org>
CC: <johan.hedberg@gmail.com>, <szymon.janc@tieto.com>,
	Lukasz Rymanowski <lukasz.rymanowski@tieto.com>
Subject: [PATCH v3 2/3] android: Move get_remote_device_props up in the file
Date: Tue, 7 Jan 2014 15:13:49 +0100
Message-ID: <1389104030-21314-2-git-send-email-lukasz.rymanowski@tieto.com>
In-Reply-To: <1389104030-21314-1-git-send-email-lukasz.rymanowski@tieto.com>
References: <1389104030-21314-1-git-send-email-lukasz.rymanowski@tieto.com>
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

This patch moves up function get_remote_device_props() and all
functions required by this function.

---
 android/bluetooth.c | 100 ++++++++++++++++++++++++++--------------------------
 1 file changed, 50 insertions(+), 50 deletions(-)

diff --git a/android/bluetooth.c b/android/bluetooth.c
index f281fcf..e0673bb 100644
--- a/android/bluetooth.c
+++ b/android/bluetooth.c
@@ -2550,56 +2550,6 @@ static void handle_get_remote_services_cmd(const void *buf, uint16_t len)
 									status);
 }
 
-static void handle_enable_cmd(const void *buf, uint16_t len)
-{
-	uint8_t status;
-
-	/* Framework expects all properties to be emitted while
-	 * enabling adapter */
-	get_adapter_properties();
-
-	if (adapter.current_settings & MGMT_SETTING_POWERED) {
-		status = HAL_STATUS_DONE;
-		goto failed;
-	}
-
-	if (!set_mode(MGMT_OP_SET_POWERED, 0x01)) {
-		status = HAL_STATUS_FAILED;
-		goto failed;
-	}
-
-	status = HAL_STATUS_SUCCESS;
-failed:
-	ipc_send_rsp(HAL_SERVICE_ID_BLUETOOTH, HAL_OP_ENABLE, status);
-}
-
-static void handle_disable_cmd(const void *buf, uint16_t len)
-{
-	uint8_t status;
-
-	if (!(adapter.current_settings & MGMT_SETTING_POWERED)) {
-		status = HAL_STATUS_DONE;
-		goto failed;
-	}
-
-	if (!set_mode(MGMT_OP_SET_POWERED, 0x00)) {
-		status = HAL_STATUS_FAILED;
-		goto failed;
-	}
-
-	status = HAL_STATUS_SUCCESS;
-failed:
-	ipc_send_rsp(HAL_SERVICE_ID_BLUETOOTH, HAL_OP_DISABLE, status);
-}
-
-static void handle_get_adapter_props_cmd(const void *buf, uint16_t len)
-{
-	get_adapter_properties();
-
-	ipc_send_rsp(HAL_SERVICE_ID_BLUETOOTH, HAL_OP_GET_ADAPTER_PROPS,
-							HAL_STATUS_SUCCESS);
-}
-
 static uint8_t get_device_uuids(struct device *dev)
 {
 	send_device_uuids_notif(dev);
@@ -2686,6 +2636,56 @@ static void get_remote_device_props(struct device *dev)
 	get_device_timestamp(dev);
 }
 
+static void handle_enable_cmd(const void *buf, uint16_t len)
+{
+	uint8_t status;
+
+	/* Framework expects all properties to be emitted while
+	 * enabling adapter */
+	get_adapter_properties();
+
+	if (adapter.current_settings & MGMT_SETTING_POWERED) {
+		status = HAL_STATUS_DONE;
+		goto failed;
+	}
+
+	if (!set_mode(MGMT_OP_SET_POWERED, 0x01)) {
+		status = HAL_STATUS_FAILED;
+		goto failed;
+	}
+
+	status = HAL_STATUS_SUCCESS;
+failed:
+	ipc_send_rsp(HAL_SERVICE_ID_BLUETOOTH, HAL_OP_ENABLE, status);
+}
+
+static void handle_disable_cmd(const void *buf, uint16_t len)
+{
+	uint8_t status;
+
+	if (!(adapter.current_settings & MGMT_SETTING_POWERED)) {
+		status = HAL_STATUS_DONE;
+		goto failed;
+	}
+
+	if (!set_mode(MGMT_OP_SET_POWERED, 0x00)) {
+		status = HAL_STATUS_FAILED;
+		goto failed;
+	}
+
+	status = HAL_STATUS_SUCCESS;
+failed:
+	ipc_send_rsp(HAL_SERVICE_ID_BLUETOOTH, HAL_OP_DISABLE, status);
+}
+
+static void handle_get_adapter_props_cmd(const void *buf, uint16_t len)
+{
+	get_adapter_properties();
+
+	ipc_send_rsp(HAL_SERVICE_ID_BLUETOOTH, HAL_OP_GET_ADAPTER_PROPS,
+							HAL_STATUS_SUCCESS);
+}
+
 static void handle_get_remote_device_props_cmd(const void *buf, uint16_t len)
 {
 	const struct hal_cmd_get_remote_device_props *cmd = buf;
-- 
1.8.4

