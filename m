Return-Path: <cyrus@holtmann.org>
From: Lukasz Rymanowski <lukasz.rymanowski@tieto.com>
To: linux-bluetooth@vger.kernel.org
Cc: Lukasz Rymanowski <lukasz.rymanowski@tieto.com>
Subject: [PATCH 07/16] android/tester: Add robustness test for get descriptor
Date: Thu, 26 Feb 2015 10:39:34 +0100
Message-Id: <1424943583-30061-8-git-send-email-lukasz.rymanowski@tieto.com>
In-Reply-To: <1424943583-30061-1-git-send-email-lukasz.rymanowski@tieto.com>
References: <1424943583-30061-1-git-send-email-lukasz.rymanowski@tieto.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

---
 android/tester-gatt.c | 37 +++++++++++++++++++++++++++++++++++++
 1 file changed, 37 insertions(+)

diff --git a/android/tester-gatt.c b/android/tester-gatt.c
index 1abfe26..10c09d2 100644
--- a/android/tester-gatt.c
+++ b/android/tester-gatt.c
@@ -914,6 +914,14 @@ static struct iovec get_characteristic_2[] = {
 	end_pdu
 };
 
+static struct iovec get_descriptor_0[] = {
+	SEARCH_SERVICE_SINGLE_SUCCESS_PDUS,
+	READ_BY_TYPE_SINGLE_CHARACTERISTIC_PDUS,
+	raw_pdu(0x04, 0x01, 0x00, 0x10, 0x00),
+	raw_pdu(0x05, 0x01, 0x00, 0x00, 0x00, 0x29),
+	end_pdu
+};
+
 static struct iovec get_descriptor_1[] = {
 	SEARCH_SERVICE_SINGLE_SUCCESS_PDUS,
 	READ_BY_TYPE_SINGLE_CHARACTERISTIC_PDUS,
@@ -2247,6 +2255,35 @@ static struct test_case test_cases[] = {
 		ACTION_SUCCESS(bluetooth_disable_action, NULL),
 		CALLBACK_STATE(CB_BT_ADAPTER_STATE_CHANGED, BT_STATE_OFF),
 	),
+	TEST_CASE_BREDRLE("Gatt Client - Get Descriptor - Incorrect rsp",
+		ACTION_SUCCESS(init_pdus, get_descriptor_0),
+		ACTION_SUCCESS(bluetooth_enable_action, NULL),
+		CALLBACK_STATE(CB_BT_ADAPTER_STATE_CHANGED, BT_STATE_ON),
+		ACTION_SUCCESS(emu_setup_powered_remote_action, NULL),
+		ACTION_SUCCESS(emu_set_ssp_mode_action, NULL),
+		ACTION_SUCCESS(emu_set_connect_cb_action, gatt_conn_cb),
+		ACTION_SUCCESS(gatt_client_register_action, &app1_uuid),
+		CALLBACK_STATUS(CB_GATTC_REGISTER_CLIENT, BT_STATUS_SUCCESS),
+		ACTION_SUCCESS(gatt_client_start_scan_action, NULL),
+		CLLBACK_GATTC_SCAN_RES(prop_emu_remotes_default_set, 1, TRUE),
+		ACTION_SUCCESS(gatt_client_stop_scan_action, NULL),
+		ACTION_SUCCESS(gatt_client_connect_action, &app1_conn_req),
+		CALLBACK_GATTC_CONNECT(GATT_STATUS_SUCCESS,
+						prop_emu_remotes_default_set,
+						CONN1_ID, APP1_ID),
+		ACTION_SUCCESS(gatt_client_search_services, &search_services_1),
+		CALLBACK_GATTC_SEARCH_COMPLETE(GATT_STATUS_SUCCESS, CONN1_ID),
+		ACTION_SUCCESS(gatt_client_get_characteristic_action,
+							&get_char_data_1),
+		CALLBACK_GATTC_GET_CHARACTERISTIC_CB(GATT_STATUS_SUCCESS,
+				CONN1_ID, &service_1, &characteristic_1, 4),
+		ACTION_SUCCESS(gatt_client_get_descriptor_action,
+							&get_desc_data_1),
+		CALLBACK_GATTC_GET_DESCRIPTOR(GATT_STATUS_FAILURE, CONN1_ID,
+				&service_1, &characteristic_1, NULL),
+		ACTION_SUCCESS(bluetooth_disable_action, NULL),
+		CALLBACK_STATE(CB_BT_ADAPTER_STATE_CHANGED, BT_STATE_OFF),
+	),
 	TEST_CASE_BREDRLE("Gatt Client - Get Descriptor - Single",
 		ACTION_SUCCESS(init_pdus, get_descriptor_1),
 		ACTION_SUCCESS(bluetooth_enable_action, NULL),
-- 
1.8.4

