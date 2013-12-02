Return-Path: <cyrus@holtmann.org>
From: Szymon Janc <szymon.janc@tieto.com>
To: linux-bluetooth@vger.kernel.org
Cc: Szymon Janc <szymon.janc@tieto.com>
Subject: [PATCH v3 5/9] android/bluetooth: Make property handling function return HAL status
Date: Mon,  2 Dec 2013 13:20:44 +0100
Message-Id: <1385986848-8023-6-git-send-email-szymon.janc@tieto.com>
In-Reply-To: <1385986848-8023-1-git-send-email-szymon.janc@tieto.com>
References: <1385986848-8023-1-git-send-email-szymon.janc@tieto.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

This makes funtions follow have similar style and makes properties
dispatch function much simpler.
---
 android/bluetooth.c | 85 +++++++++++++++++++----------------------------------
 1 file changed, 30 insertions(+), 55 deletions(-)

diff --git a/android/bluetooth.c b/android/bluetooth.c
index eb8dbc5..a39e7bf 100644
--- a/android/bluetooth.c
+++ b/android/bluetooth.c
@@ -1133,7 +1133,7 @@ static void uuid16_to_uint128(uint16_t uuid, uint128_t *u128)
 	ntoh128(&uuid128.value.uuid128, u128);
 }
 
-static bool get_uuids(void)
+static uint8_t get_uuids(void)
 {
 	struct hal_ev_adapter_props_changed *ev;
 	GSList *list = adapter.uuids;
@@ -1169,7 +1169,7 @@ static bool get_uuids(void)
 	ipc_send_notif(HAL_SERVICE_ID_BLUETOOTH, HAL_EV_ADAPTER_PROPS_CHANGED,
 							sizeof(buf), ev);
 
-	return true;
+	return HAL_STATUS_SUCCESS;
 }
 
 static void remove_uuid_complete(uint8_t status, uint16_t length,
@@ -1691,7 +1691,7 @@ static bool set_discoverable(uint8_t mode, uint16_t timeout)
 	return false;
 }
 
-static void get_address(void)
+static uint8_t get_address(void)
 {
 	uint8_t buf[BASELEN_PROP_CHANGED + sizeof(bdaddr_t)];
 	struct hal_ev_adapter_props_changed *ev = (void *) buf;
@@ -1705,65 +1705,67 @@ static void get_address(void)
 
 	ipc_send_notif(HAL_SERVICE_ID_BLUETOOTH, HAL_EV_ADAPTER_PROPS_CHANGED,
 							sizeof(buf), buf);
+
+	return HAL_STATUS_SUCCESS;
 }
 
-static bool get_name(void)
+static uint8_t get_name(void)
 {
 	if (!adapter.name)
-		return false;
+		return HAL_STATUS_FAILED;
 
 	adapter_name_changed((uint8_t *) adapter.name);
 
-	return true;
+	return HAL_STATUS_SUCCESS;
 }
 
 
-static bool get_class(void)
+static uint8_t get_class(void)
 {
 	DBG("");
 
 	adapter_class_changed();
 
-	return true;
+	return HAL_STATUS_SUCCESS;
 }
 
-static bool get_type(void)
+static uint8_t get_type(void)
 {
 	DBG("Not implemented");
 
 	/* TODO: Add implementation */
 
-	return false;
+	return HAL_STATUS_FAILED;
 }
 
-static bool get_service(void)
+static uint8_t get_service(void)
 {
 	DBG("Not implemented");
 
 	/* TODO: Add implementation */
 
-	return false;
+	return HAL_STATUS_FAILED;
 }
 
-static bool get_scan_mode(void)
+static uint8_t get_scan_mode(void)
 {
 	DBG("");
 
 	scan_mode_changed();
 
-	return true;
+	return HAL_STATUS_SUCCESS;
 }
 
-static bool get_devices(void)
+static uint8_t get_devices(void)
 {
 	DBG("Not implemented");
 
 	/* TODO: Add implementation */
 
-	return false;
+	return HAL_STATUS_FAILED;
 }
 
-static bool get_discoverable_timeout(void)
+static uint8_t get_discoverable_timeout(void)
 {
 	struct hal_ev_adapter_props_changed *ev;
 	uint8_t buf[BASELEN_PROP_CHANGED + sizeof(uint32_t)];
@@ -1782,7 +1784,7 @@ static bool get_discoverable_timeout(void)
 	ipc_send_notif(HAL_SERVICE_ID_BLUETOOTH, HAL_EV_ADAPTER_PROPS_CHANGED,
 							sizeof(buf), ev);
 
-	return true;
+	return HAL_STATUS_SUCCESS;
 }
 
 static void handle_get_adapter_prop_cmd(const void *buf, uint16_t len)
@@ -1792,64 +1794,37 @@ static void handle_get_adapter_prop_cmd(const void *buf, uint16_t len)
 
 	switch (cmd->type) {
 	case HAL_PROP_ADAPTER_ADDR:
-		get_address();
+		status = get_address();
 		break;
 	case HAL_PROP_ADAPTER_NAME:
-		if (!get_name()) {
-			status = HAL_STATUS_FAILED;
-			goto failed;
-		}
+		status = get_name();
 		break;
 	case HAL_PROP_ADAPTER_UUIDS:
-		if (!get_uuids()) {
-			status = HAL_STATUS_FAILED;
-			goto failed;
-		}
+		status = get_uuids();
 		break;
 	case HAL_PROP_ADAPTER_CLASS:
-		if (!get_class()) {
-			status = HAL_STATUS_FAILED;
-			goto failed;
-		}
+		status = get_class();
 		break;
 	case HAL_PROP_ADAPTER_TYPE:
-		if (!get_type()) {
-			status = HAL_STATUS_FAILED;
-			goto failed;
-		}
+		status = get_type();
 		break;
 	case HAL_PROP_ADAPTER_SERVICE_REC:
-		if (!get_service()) {
-			status = HAL_STATUS_FAILED;
-			goto failed;
-		}
+		status = get_service();
 		break;
 	case HAL_PROP_ADAPTER_SCAN_MODE:
-		if (!get_scan_mode()) {
-			status = HAL_STATUS_FAILED;
-			goto failed;
-		}
+		status = get_scan_mode();
 		break;
 	case HAL_PROP_ADAPTER_BONDED_DEVICES:
-		if (!get_devices()) {
-			status = HAL_STATUS_FAILED;
-			goto failed;
-		}
+		status = get_devices();
 		break;
 	case HAL_PROP_ADAPTER_DISC_TIMEOUT:
-		if (!get_discoverable_timeout()) {
-			status = HAL_STATUS_FAILED;
-			goto failed;
-		}
+		status = get_discoverable_timeout();
 		break;
 	default:
 		status = HAL_STATUS_FAILED;
-		goto failed;
+		break;
 	}
 
-	status = HAL_STATUS_SUCCESS;
-
-failed:
 	ipc_send_rsp(HAL_SERVICE_ID_BLUETOOTH, HAL_OP_GET_ADAPTER_PROP, status);
 }
 
-- 
1.8.3.2

