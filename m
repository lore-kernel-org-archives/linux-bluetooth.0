Return-Path: <cyrus@holtmann.org>
From: Grzegorz Kolodziejczyk <grzegorz.kolodziejczyk@tieto.com>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH 3/6] android/tester: Change GATT client connection test cases to LE connect
Date: Tue, 30 Sep 2014 13:23:44 +0200
Message-Id: <1412076227-32664-3-git-send-email-grzegorz.kolodziejczyk@tieto.com>
In-Reply-To: <1412076227-32664-1-git-send-email-grzegorz.kolodziejczyk@tieto.com>
References: <1412076227-32664-1-git-send-email-grzegorz.kolodziejczyk@tieto.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Current GATT client connect test cases don't check if found device is
BLE type. Now it's updated with check step (device found callback
analyze for device type).
---
 android/tester-gatt.c | 17 ++++++++++++++---
 1 file changed, 14 insertions(+), 3 deletions(-)

diff --git a/android/tester-gatt.c b/android/tester-gatt.c
index b1c6ece..67a09a5 100644
--- a/android/tester-gatt.c
+++ b/android/tester-gatt.c
@@ -125,10 +125,18 @@ struct write_char_data {
 static bt_bdaddr_t emu_remote_bdaddr_val = {
 	.address = { 0x00, 0xaa, 0x01, 0x01, 0x00, 0x00 },
 };
+static bt_device_type_t emu_remote_ble_device_type = BT_DEVICE_DEVTYPE_BLE;
+
 static bt_property_t prop_emu_remotes_default_set[] = {
 	{ BT_PROPERTY_BDADDR, sizeof(emu_remote_bdaddr_val),
 						&emu_remote_bdaddr_val },
 };
+static bt_property_t prop_emu_remotes_default_le_set[] = {
+	{ BT_PROPERTY_BDADDR, sizeof(emu_remote_bdaddr_val),
+						&emu_remote_bdaddr_val },
+	{ BT_PROPERTY_TYPE_OF_DEVICE, sizeof(bt_device_type_t),
+						&emu_remote_ble_device_type },
+};
 
 static bt_scan_mode_t setprop_scan_mode_conn_val =
 					BT_SCAN_MODE_CONNECTABLE_DISCOVERABLE;
@@ -1064,7 +1072,7 @@ static struct test_case test_cases[] = {
 		ACTION_SUCCESS(bluetooth_disable_action, NULL),
 		CALLBACK_STATE(CB_BT_ADAPTER_STATE_CHANGED, BT_STATE_OFF),
 	),
-	TEST_CASE_BREDRLE("Gatt Client - Connect",
+	TEST_CASE_BREDRLE("Gatt Client - LE Connect",
 		ACTION_SUCCESS(bluetooth_enable_action, NULL),
 		CALLBACK_STATE(CB_BT_ADAPTER_STATE_CHANGED, BT_STATE_ON),
 		ACTION_SUCCESS(emu_setup_powered_remote_action, NULL),
@@ -1074,6 +1082,7 @@ static struct test_case test_cases[] = {
 		CALLBACK_STATUS(CB_GATTC_REGISTER_CLIENT, BT_STATUS_SUCCESS),
 		ACTION_SUCCESS(gatt_client_start_scan_action,
 							INT_TO_PTR(APP1_ID)),
+		CALLBACK_DEVICE_FOUND(prop_emu_remotes_default_le_set, 2),
 		CLLBACK_GATTC_SCAN_RES(prop_emu_remotes_default_set, 1, TRUE),
 		ACTION_SUCCESS(gatt_client_stop_scan_action,
 							INT_TO_PTR(APP1_ID)),
@@ -1084,7 +1093,7 @@ static struct test_case test_cases[] = {
 		ACTION_SUCCESS(bluetooth_disable_action, NULL),
 		CALLBACK_STATE(CB_BT_ADAPTER_STATE_CHANGED, BT_STATE_OFF),
 	),
-	TEST_CASE_BREDRLE("Gatt Client - Disconnect",
+	TEST_CASE_BREDRLE("Gatt Client - LE Disconnect",
 		ACTION_SUCCESS(bluetooth_enable_action, NULL),
 		CALLBACK_STATE(CB_BT_ADAPTER_STATE_CHANGED, BT_STATE_ON),
 		ACTION_SUCCESS(emu_setup_powered_remote_action, NULL),
@@ -1094,6 +1103,7 @@ static struct test_case test_cases[] = {
 		CALLBACK_STATUS(CB_GATTC_REGISTER_CLIENT, BT_STATUS_SUCCESS),
 		ACTION_SUCCESS(gatt_client_start_scan_action,
 							INT_TO_PTR(APP1_ID)),
+		CALLBACK_DEVICE_FOUND(prop_emu_remotes_default_le_set, 2),
 		CLLBACK_GATTC_SCAN_RES(prop_emu_remotes_default_set, 1, TRUE),
 		ACTION_SUCCESS(gatt_client_stop_scan_action,
 							INT_TO_PTR(APP1_ID)),
@@ -1109,7 +1119,7 @@ static struct test_case test_cases[] = {
 		ACTION_SUCCESS(bluetooth_disable_action, NULL),
 		CALLBACK_STATE(CB_BT_ADAPTER_STATE_CHANGED, BT_STATE_OFF),
 	),
-	TEST_CASE_BREDRLE("Gatt Client - Multiple Client Conn./Disc.",
+	TEST_CASE_BREDRLE("Gatt Client - LE Multiple Client Conn./Disc.",
 		ACTION_SUCCESS(bluetooth_enable_action, NULL),
 		CALLBACK_STATE(CB_BT_ADAPTER_STATE_CHANGED, BT_STATE_ON),
 		ACTION_SUCCESS(emu_setup_powered_remote_action, NULL),
@@ -1121,6 +1131,7 @@ static struct test_case test_cases[] = {
 		CALLBACK_STATUS(CB_GATTC_REGISTER_CLIENT, BT_STATUS_SUCCESS),
 		ACTION_SUCCESS(gatt_client_start_scan_action,
 							INT_TO_PTR(APP1_ID)),
+		CALLBACK_DEVICE_FOUND(prop_emu_remotes_default_le_set, 2),
 		CLLBACK_GATTC_SCAN_RES(prop_emu_remotes_default_set, 1, TRUE),
 		ACTION_SUCCESS(gatt_client_stop_scan_action,
 							INT_TO_PTR(APP1_ID)),
-- 
1.9.3

