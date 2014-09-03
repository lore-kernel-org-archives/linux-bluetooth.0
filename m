Return-Path: <cyrus@holtmann.org>
From: Grzegorz Kolodziejczyk <grzegorz.kolodziejczyk@tieto.com>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH 2/2] android/bluetoot: Minor style fix
Date: Wed,  3 Sep 2014 15:17:13 +0200
Message-Id: <1409750233-23314-2-git-send-email-grzegorz.kolodziejczyk@tieto.com>
In-Reply-To: <1409750233-23314-1-git-send-email-grzegorz.kolodziejczyk@tieto.com>
References: <1409750233-23314-1-git-send-email-grzegorz.kolodziejczyk@tieto.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

---
 android/bluetooth.c | 51 +++++++++++++++++++++++----------------------------
 1 file changed, 23 insertions(+), 28 deletions(-)

diff --git a/android/bluetooth.c b/android/bluetooth.c
index d275dea..4646a6c 100644
--- a/android/bluetooth.c
+++ b/android/bluetooth.c
@@ -2092,7 +2092,6 @@ static void mgmt_device_disconnected_event(uint16_t index, uint16_t length,
 	if (device_is_paired(dev, type) && !device_is_bonded(dev))
 		update_device_state(dev, type, HAL_STATUS_SUCCESS, false,
 								false, false);
-
 }
 
 static uint8_t status_mgmt2hal(uint8_t mgmt)
@@ -2679,8 +2678,8 @@ static void remove_uuid_complete(uint8_t status, uint16_t length,
 					const void *param, void *user_data)
 {
 	if (status != MGMT_STATUS_SUCCESS) {
-		error("Failed to remove UUID: %s (0x%02x)",
-						mgmt_errstr(status), status);
+		error("Failed to remove UUID: %s (0x%02x)", mgmt_errstr(status),
+									status);
 		return;
 	}
 
@@ -2705,8 +2704,8 @@ static void add_uuid_complete(uint8_t status, uint16_t length,
 					const void *param, void *user_data)
 {
 	if (status != MGMT_STATUS_SUCCESS) {
-		error("Failed to add UUID: %s (0x%02x)",
-						mgmt_errstr(status), status);
+		error("Failed to add UUID: %s (0x%02x)", mgmt_errstr(status),
+									status);
 		return;
 	}
 
@@ -2856,8 +2855,8 @@ static void set_adapter_name_complete(uint8_t status, uint16_t length,
 	const struct mgmt_cp_set_local_name *rp = param;
 
 	if (status != MGMT_STATUS_SUCCESS) {
-		error("Failed to set name: %s (0x%02x)",
-						mgmt_errstr(status), status);
+		error("Failed to set name: %s (0x%02x)", mgmt_errstr(status),
+									status);
 		return;
 	}
 
@@ -2915,8 +2914,8 @@ static void clear_uuids(void)
 
 	memset(&cp, 0, sizeof(cp));
 
-	mgmt_send(mgmt_if, MGMT_OP_REMOVE_UUID, adapter.index,
-					sizeof(cp), &cp, NULL, NULL, NULL);
+	mgmt_send(mgmt_if, MGMT_OP_REMOVE_UUID, adapter.index, sizeof(cp),
+							&cp, NULL, NULL, NULL);
 }
 
 static struct device *create_device_from_info(GKeyFile *key_file,
@@ -3265,8 +3264,8 @@ static void set_adapter_class(void)
 	cp.major = ADAPTER_MAJOR_CLASS & 0x1f;
 	cp.minor = ADAPTER_MINOR_CLASS << 2;
 
-	if (mgmt_send(mgmt_if, MGMT_OP_SET_DEV_CLASS, adapter.index,
-					sizeof(cp), &cp, NULL, NULL, NULL) > 0)
+	if (mgmt_send(mgmt_if, MGMT_OP_SET_DEV_CLASS, adapter.index, sizeof(cp),
+						&cp, NULL, NULL, NULL) > 0)
 		return;
 
 	error("Failed to set class of device");
@@ -3362,10 +3361,8 @@ static void clear_auto_connect_list(void)
 
 	memset(&cp, 0, sizeof(cp));
 
-	if (mgmt_send(mgmt_if, MGMT_OP_REMOVE_DEVICE, adapter.index,
-					sizeof(cp), &cp,
-					clear_auto_connect_list_complete,
-					NULL, NULL) > 0)
+	if (mgmt_send(mgmt_if, MGMT_OP_REMOVE_DEVICE, adapter.index, sizeof(cp),
+			&cp, clear_auto_connect_list_complete, NULL, NULL) > 0)
 		return;
 
 	error("Could not clear auto connect list");
@@ -3504,8 +3501,8 @@ static void read_index_list_complete(uint8_t status, uint16_t length,
 	DBG("");
 
 	if (status) {
-		error("%s: Failed to read index list: %s (0x%02x)",
-					__func__, mgmt_errstr(status), status);
+		error("%s: Failed to read index list: %s (0x%02x)", __func__,
+						mgmt_errstr(status), status);
 		goto failed;
 	}
 
@@ -4300,7 +4297,6 @@ static uint8_t select_device_bearer(struct device *dev)
 			res = dev->bdaddr_type;
 		else
 			res = BDADDR_BREDR;
-
 	} else {
 		res = dev->bredr ? BDADDR_BREDR : dev->bdaddr_type;
 	}
@@ -4371,9 +4367,8 @@ static void handle_cancel_bond_cmd(const void *buf, uint16_t len)
 	cp.type = select_device_bearer(dev);
 	bacpy(&cp.bdaddr, &dev->bdaddr);
 
-	if (mgmt_reply(mgmt_if, MGMT_OP_CANCEL_PAIR_DEVICE,
-					adapter.index, sizeof(cp), &cp,
-					NULL, NULL, NULL) == 0) {
+	if (mgmt_reply(mgmt_if, MGMT_OP_CANCEL_PAIR_DEVICE, adapter.index,
+				sizeof(cp), &cp, NULL, NULL, NULL) == 0) {
 		status = HAL_STATUS_FAILED;
 		goto failed;
 	}
@@ -4632,8 +4627,8 @@ static uint8_t get_device_uuids(struct device *dev)
 
 static uint8_t get_device_class(struct device *dev)
 {
-	send_device_property(dev, HAL_PROP_DEVICE_CLASS,
-					sizeof(dev->class), &dev->class);
+	send_device_property(dev, HAL_PROP_DEVICE_CLASS, sizeof(dev->class),
+								&dev->class);
 
 	return HAL_STATUS_SUCCESS;
 }
@@ -4672,8 +4667,8 @@ static uint8_t get_device_rssi(struct device *dev)
 	if (!dev->rssi)
 		return HAL_STATUS_FAILED;
 
-	send_device_property(dev, HAL_PROP_DEVICE_RSSI,
-						sizeof(dev->rssi), &dev->rssi);
+	send_device_property(dev, HAL_PROP_DEVICE_RSSI, sizeof(dev->rssi),
+								&dev->rssi);
 
 	return HAL_STATUS_SUCCESS;
 }
@@ -4693,8 +4688,8 @@ static uint8_t get_device_timestamp(struct device *dev)
 
 	timestamp = device_timestamp(dev);
 
-	send_device_property(dev, HAL_PROP_DEVICE_TIMESTAMP,
-						sizeof(timestamp), &timestamp);
+	send_device_property(dev, HAL_PROP_DEVICE_TIMESTAMP, sizeof(timestamp),
+								&timestamp);
 
 	return HAL_STATUS_SUCCESS;
 }
@@ -5205,7 +5200,7 @@ bool bt_bluetooth_register(struct ipc *ipc, uint8_t mode)
 	}
 
 	missing_settings = adapter.current_settings ^
-					adapter.supported_settings;
+						adapter.supported_settings;
 
 	switch (mode) {
 	case HAL_MODE_DEFAULT:
-- 
1.9.3

