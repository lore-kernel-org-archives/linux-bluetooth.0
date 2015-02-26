Return-Path: <cyrus@holtmann.org>
From: Lukasz Rymanowski <lukasz.rymanowski@tieto.com>
To: linux-bluetooth@vger.kernel.org
Cc: Lukasz Rymanowski <lukasz.rymanowski@tieto.com>
Subject: [PATCH 10/16] android/tester: Add robustness test for get included services
Date: Thu, 26 Feb 2015 10:39:37 +0100
Message-Id: <1424943583-30061-11-git-send-email-lukasz.rymanowski@tieto.com>
In-Reply-To: <1424943583-30061-1-git-send-email-lukasz.rymanowski@tieto.com>
References: <1424943583-30061-1-git-send-email-lukasz.rymanowski@tieto.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

---
 android/tester-gatt.c | 32 ++++++++++++++++++++++++++++++++
 1 file changed, 32 insertions(+)

diff --git a/android/tester-gatt.c b/android/tester-gatt.c
index 10c09d2..b8b088b 100644
--- a/android/tester-gatt.c
+++ b/android/tester-gatt.c
@@ -950,6 +950,13 @@ static struct iovec get_descriptor_3[] = {
 	end_pdu
 };
 
+static struct iovec get_included_0[] = {
+	SEARCH_SERVICE_SINGLE_SUCCESS_PDUS,
+	raw_pdu(0x08, 0x01, 0x00, 0x10, 0x00, 0x02, 0x28),
+	raw_pdu(0x09, 0x08, 0x00, 0x00, 0x15, 0x00, 0x19, 0x00, 0xff, 0xfe),
+	end_pdu
+};
+
 static struct iovec get_included_1[] = {
 	SEARCH_SERVICE_SINGLE_SUCCESS_PDUS,
 	raw_pdu(0x08, 0x01, 0x00, 0x10, 0x00, 0x02, 0x28),
@@ -2378,6 +2385,31 @@ static struct test_case test_cases[] = {
 		ACTION_SUCCESS(bluetooth_disable_action, NULL),
 		CALLBACK_STATE(CB_BT_ADAPTER_STATE_CHANGED, BT_STATE_OFF),
 	),
+	TEST_CASE_BREDRLE("Gatt Client - Get Included Services - Incorrect rsp",
+		ACTION_SUCCESS(init_pdus, get_included_0),
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
+		ACTION_SUCCESS(gatt_client_get_included_action,
+							&get_incl_data_1),
+		CALLBACK_GATTC_GET_INCLUDED(GATT_STATUS_FAILURE, CONN1_ID,
+							&service_1, NULL),
+		ACTION_SUCCESS(bluetooth_disable_action, NULL),
+		CALLBACK_STATE(CB_BT_ADAPTER_STATE_CHANGED, BT_STATE_OFF),
+		),
 	TEST_CASE_BREDRLE("Gatt Client - Get Included Service - 16 UUID",
 		ACTION_SUCCESS(init_pdus, get_included_1),
 		ACTION_SUCCESS(bluetooth_enable_action, NULL),
-- 
1.8.4

