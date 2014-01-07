Return-Path: <cyrus@holtmann.org>
From: Lukasz Rymanowski <lukasz.rymanowski@tieto.com>
To: <linux-bluetooth@vger.kernel.org>
CC: <johan.hedberg@gmail.com>, <szymon.janc@tieto.com>,
	Lukasz Rymanowski <lukasz.rymanowski@tieto.com>
Subject: [PATCH v2 1/2] android: Add wrapper function for get remote dev properties
Date: Tue, 7 Jan 2014 13:43:11 +0100
Message-ID: <1389098592-14403-1-git-send-email-lukasz.rymanowski@tieto.com>
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

---
 android/bluetooth.c | 123 +++++++++++++++++++++++++++-------------------------
 1 file changed, 64 insertions(+), 59 deletions(-)

diff --git a/android/bluetooth.c b/android/bluetooth.c
index 3cbf68d..e0673bb 100644
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
@@ -2673,6 +2623,69 @@ static uint8_t get_device_timestamp(struct device *dev)
 	return HAL_STATUS_SUCCESS;
 }
 
+static void get_remote_device_props(struct device *dev)
+{
+	get_device_name(dev);
+	get_device_uuids(dev);
+	get_device_class(dev);
+	get_device_type(dev);
+	get_device_service_rec(dev);
+	get_device_friendly_name(dev);
+	get_device_rssi(dev);
+	get_device_version_info(dev);
+	get_device_timestamp(dev);
+}
+
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
@@ -2688,15 +2701,7 @@ static void handle_get_remote_device_props_cmd(const void *buf, uint16_t len)
 		goto failed;
 	}
 
-	get_device_name(l->data);
-	get_device_uuids(l->data);
-	get_device_class(l->data);
-	get_device_type(l->data);
-	get_device_service_rec(l->data);
-	get_device_friendly_name(l->data);
-	get_device_rssi(l->data);
-	get_device_version_info(l->data);
-	get_device_timestamp(l->data);
+	get_remote_device_props(l->data);
 
 	status = HAL_STATUS_SUCCESS;
 
-- 
1.8.4

