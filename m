Return-Path: <cyrus@holtmann.org>
From: Grzegorz Kolodziejczyk <grzegorz.kolodziejczyk@tieto.com>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH 1/7] android/tester: Fix enum and define coding style
Date: Tue, 17 Dec 2013 13:37:48 +0100
Message-Id: <1387283874-29721-1-git-send-email-grzegorz.kolodziejczyk@tieto.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

This changes all enums values and defines to uppercase instead of
lowercase according to coding style.
---
 android/android-tester.c | 86 ++++++++++++++++++++++++------------------------
 1 file changed, 43 insertions(+), 43 deletions(-)

diff --git a/android/android-tester.c b/android/android-tester.c
index eb938d0..4eb265b 100644
--- a/android/android-tester.c
+++ b/android/android-tester.c
@@ -37,10 +37,10 @@
 #include <hardware/bluetooth.h>
 #include <hardware/bt_sock.h>
 
-#define adapter_props adapter_prop_bdaddr, adapter_prop_bdname, \
-			adapter_prop_uuids, adapter_prop_cod, \
-			adapter_prop_type, adapter_prop_scan_mode, \
-			adapter_prop_bonded_devices, adapter_prop_disc_timeout
+#define ADAPTER_PROPS ADAPTER_PROP_BDADDR, ADAPTER_PROP_BDNAME, \
+			ADAPTER_PROP_UUIDS, ADAPTER_PROP_COD, \
+			ADAPTER_PROP_TYPE, ADAPTER_PROP_SCAN_MODE, \
+			ADAPTER_PROP_BONDED_DEVICES, ADAPTER_PROP_DISC_TIMEOUT
 
 static bt_scan_mode_t test_setprop_scanmode_val =
 					BT_SCAN_MODE_CONNECTABLE_DISCOVERABLE;
@@ -52,19 +52,19 @@ static uint32_t test_setprop_disctimeout_val = 120;
  */
 
 enum hal_bluetooth_callbacks_id {
-	adapter_test_end,
-	adapter_test_setup_mode,
-	adapter_state_changed_on,
-	adapter_state_changed_off,
-	adapter_prop_bdaddr,
-	adapter_prop_bdname,
-	adapter_prop_uuids,
-	adapter_prop_cod,
-	adapter_prop_type,
-	adapter_prop_scan_mode,
-	adapter_prop_disc_timeout,
-	adapter_prop_service_record,
-	adapter_prop_bonded_devices
+	ADAPTER_TEST_END,
+	ADAPTER_TEST_SETUP_MODE,
+	ADAPTER_STATE_CHANGED_ON,
+	ADAPTER_STATE_CHANGED_OFF,
+	ADAPTER_PROP_BDADDR,
+	ADAPTER_PROP_BDNAME,
+	ADAPTER_PROP_UUIDS,
+	ADAPTER_PROP_COD,
+	ADAPTER_PROP_TYPE,
+	ADAPTER_PROP_SCAN_MODE,
+	ADAPTER_PROP_DISC_TIMEOUT,
+	ADAPTER_PROP_SERVICE_RECORD,
+	ADAPTER_PROP_BONDED_DEVICES
 };
 
 struct generic_data {
@@ -250,7 +250,7 @@ static int get_expected_hal_cb(void)
 	struct test_data *data = tester_get_data();
 
 	if (!(g_slist_length(data->expected_callbacks)))
-		return adapter_test_setup_mode;
+		return ADAPTER_TEST_SETUP_MODE;
 
 	return GPOINTER_TO_INT(data->expected_callbacks->data);
 }
@@ -470,19 +470,19 @@ static void adapter_state_changed_cb(bt_state_t state)
 	hal_cb = get_expected_hal_cb();
 
 	switch (hal_cb) {
-	case adapter_state_changed_on:
+	case ADAPTER_STATE_CHANGED_ON:
 		if (state == BT_STATE_ON)
 			remove_expected_hal_cb();
 		else
 			tester_test_failed();
 		break;
-	case adapter_state_changed_off:
+	case ADAPTER_STATE_CHANGED_OFF:
 		if (state == BT_STATE_OFF)
 			remove_expected_hal_cb();
 		else
 			tester_test_failed();
 		break;
-	case adapter_test_setup_mode:
+	case ADAPTER_TEST_SETUP_MODE:
 		if (state == BT_STATE_ON)
 			tester_setup_complete();
 		else
@@ -502,50 +502,50 @@ static void adapter_properties_cb(bt_status_t status, int num_properties,
 	for (i = 0; i < num_properties; i++) {
 		hal_cb = get_expected_hal_cb();
 
-		if (hal_cb == adapter_test_setup_mode)
+		if (hal_cb == ADAPTER_TEST_SETUP_MODE)
 			break;
 
 		data->test_property = *properties;
 
 		if (g_slist_next(data->expected_callbacks) ==
-							adapter_test_end)
+							ADAPTER_TEST_END)
 			check_test_property();
 
 		switch (properties[i].type) {
 		case BT_PROPERTY_BDADDR:
-			if (hal_cb != adapter_prop_bdaddr)
+			if (hal_cb != ADAPTER_PROP_BDADDR)
 				goto fail;
 			break;
 		case BT_PROPERTY_BDNAME:
-			if (hal_cb != adapter_prop_bdname)
+			if (hal_cb != ADAPTER_PROP_BDNAME)
 				goto fail;
 			break;
 		case BT_PROPERTY_UUIDS:
-			if (hal_cb != adapter_prop_uuids)
+			if (hal_cb != ADAPTER_PROP_UUIDS)
 				goto fail;
 			break;
 		case BT_PROPERTY_CLASS_OF_DEVICE:
-			if (hal_cb != adapter_prop_cod)
+			if (hal_cb != ADAPTER_PROP_COD)
 				goto fail;
 			break;
 		case BT_PROPERTY_TYPE_OF_DEVICE:
-			if (hal_cb != adapter_prop_type)
+			if (hal_cb != ADAPTER_PROP_TYPE)
 				goto fail;
 			break;
 		case BT_PROPERTY_SERVICE_RECORD:
-			if (hal_cb != adapter_prop_service_record)
+			if (hal_cb != ADAPTER_PROP_SERVICE_RECORD)
 				goto fail;
 			break;
 		case BT_PROPERTY_ADAPTER_SCAN_MODE:
-			if (hal_cb != adapter_prop_scan_mode)
+			if (hal_cb != ADAPTER_PROP_SCAN_MODE)
 				goto fail;
 			break;
 		case BT_PROPERTY_ADAPTER_BONDED_DEVICES:
-			if (hal_cb != adapter_prop_bonded_devices)
+			if (hal_cb != ADAPTER_PROP_BONDED_DEVICES)
 				goto fail;
 			break;
 		case BT_PROPERTY_ADAPTER_DISCOVERY_TIMEOUT:
-			if (hal_cb != adapter_prop_disc_timeout)
+			if (hal_cb != ADAPTER_PROP_DISC_TIMEOUT)
 				goto fail;
 			break;
 		default:
@@ -563,21 +563,21 @@ fail:
 }
 
 static const struct generic_data bluetooth_enable_success_test = {
-	.expected_hal_callbacks = {adapter_props, adapter_state_changed_on,
-							adapter_test_end}
+	.expected_hal_callbacks = {ADAPTER_PROPS, ADAPTER_STATE_CHANGED_ON,
+							ADAPTER_TEST_END}
 };
 
 static const struct generic_data bluetooth_enable_done_test = {
-	.expected_hal_callbacks = {adapter_props, adapter_test_end},
+	.expected_hal_callbacks = {ADAPTER_PROPS, ADAPTER_TEST_END},
 	.expected_adapter_status = BT_STATUS_DONE
 };
 
 static const struct generic_data bluetooth_disable_success_test = {
-	.expected_hal_callbacks = {adapter_state_changed_off, adapter_test_end}
+	.expected_hal_callbacks = {ADAPTER_STATE_CHANGED_OFF, ADAPTER_TEST_END}
 };
 
 static const struct generic_data bluetooth_setprop_bdname_success_test = {
-	.expected_hal_callbacks = {adapter_prop_bdname, adapter_test_end},
+	.expected_hal_callbacks = {ADAPTER_PROP_BDNAME, ADAPTER_TEST_END},
 	.expected_adapter_status = BT_STATUS_SUCCESS,
 	.expected_property.type = BT_PROPERTY_BDNAME,
 	.expected_property.val = "test_bdname",
@@ -585,8 +585,8 @@ static const struct generic_data bluetooth_setprop_bdname_success_test = {
 };
 
 static const struct generic_data bluetooth_setprop_scanmode_success_test = {
-	.expected_hal_callbacks = {adapter_prop_scan_mode,
-				adapter_prop_scan_mode, adapter_test_end},
+	.expected_hal_callbacks = {ADAPTER_PROP_SCAN_MODE,
+				ADAPTER_PROP_SCAN_MODE, ADAPTER_TEST_END},
 	.expected_adapter_status = BT_STATUS_SUCCESS,
 	.expected_property.type = BT_PROPERTY_ADAPTER_SCAN_MODE,
 	.expected_property.val = &test_setprop_scanmode_val,
@@ -594,7 +594,7 @@ static const struct generic_data bluetooth_setprop_scanmode_success_test = {
 };
 
 static const struct generic_data bluetooth_setprop_disctimeout_success_test = {
-	.expected_hal_callbacks = {adapter_prop_disc_timeout, adapter_test_end},
+	.expected_hal_callbacks = {ADAPTER_PROP_DISC_TIMEOUT, ADAPTER_TEST_END},
 	.expected_adapter_status = BT_STATUS_SUCCESS,
 	.expected_property.type = BT_PROPERTY_ADAPTER_DISCOVERY_TIMEOUT,
 	.expected_property.val = &test_setprop_disctimeout_val,
@@ -602,7 +602,7 @@ static const struct generic_data bluetooth_setprop_disctimeout_success_test = {
 };
 
 static const struct generic_data bluetooth_getprop_bdaddr_success_test = {
-	.expected_hal_callbacks = {adapter_prop_bdaddr, adapter_test_end},
+	.expected_hal_callbacks = {ADAPTER_PROP_BDADDR, ADAPTER_TEST_END},
 	.expected_adapter_status = BT_STATUS_SUCCESS,
 	.expected_property.type = BT_PROPERTY_BDADDR,
 	.expected_property.val = NULL,
@@ -610,8 +610,8 @@ static const struct generic_data bluetooth_getprop_bdaddr_success_test = {
 };
 
 static const struct generic_data bluetooth_getprop_bdname_success_test = {
-	.expected_hal_callbacks = {adapter_prop_bdname, adapter_prop_bdname,
-							adapter_test_end},
+	.expected_hal_callbacks = {ADAPTER_PROP_BDNAME, ADAPTER_PROP_BDNAME,
+							ADAPTER_TEST_END},
 	.expected_adapter_status = BT_STATUS_SUCCESS,
 	.expected_property.type = BT_PROPERTY_BDNAME,
 	.expected_property.val = "test_bdname_setget",
-- 
1.8.4.2

