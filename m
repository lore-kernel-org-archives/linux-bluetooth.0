Return-Path: <cyrus@holtmann.org>
From: Lukasz Rymanowski <lukasz.rymanowski@tieto.com>
To: linux-bluetooth@vger.kernel.org
Cc: Lukasz Rymanowski <lukasz.rymanowski@tieto.com>
Subject: [PATCH 01/16] android/tester-gatt: Add robustness test for search services
Date: Thu, 26 Feb 2015 10:39:28 +0100
Message-Id: <1424943583-30061-2-git-send-email-lukasz.rymanowski@tieto.com>
In-Reply-To: <1424943583-30061-1-git-send-email-lukasz.rymanowski@tieto.com>
References: <1424943583-30061-1-git-send-email-lukasz.rymanowski@tieto.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

This test verifies if BlueZ do not start infinitive service search
when remote device response with incorrect end handle in Read By
Group response
---
 android/tester-gatt.c | 27 +++++++++++++++++++++++++++
 1 file changed, 27 insertions(+)

diff --git a/android/tester-gatt.c b/android/tester-gatt.c
index eb0ca1e..6c58bc7 100644
--- a/android/tester-gatt.c
+++ b/android/tester-gatt.c
@@ -895,6 +895,12 @@ static struct iovec search_service_3[] = {
 	end_pdu
 };
 
+static struct iovec search_service_4[] = {
+	raw_pdu(0x10, 0x01, 0x00, 0xff, 0xff, 0x00, 0x28),
+	raw_pdu(0x11, 0x06, 0x01, 0x00, 0x00, 0x00, 0x00, 0x18),
+	end_pdu
+};
+
 static struct iovec get_characteristic_1[] = {
 	SEARCH_SERVICE_SINGLE_SUCCESS_PDUS,
 	READ_BY_TYPE_SINGLE_CHARACTERISTIC_PDUS,
@@ -2137,6 +2143,27 @@ static struct test_case test_cases[] = {
 		ACTION_SUCCESS(bluetooth_disable_action, NULL),
 		CALLBACK_STATE(CB_BT_ADAPTER_STATE_CHANGED, BT_STATE_OFF),
 	),
+	TEST_CASE_BREDRLE("Gatt Client - Search Service - Incorrect rsp",
+		ACTION_SUCCESS(init_pdus, search_service_4),
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
+		ACTION_SUCCESS(bluetooth_disable_action, NULL),
+		CALLBACK_STATE(CB_BT_ADAPTER_STATE_CHANGED, BT_STATE_OFF),
+	),
 	TEST_CASE_BREDRLE("Gatt Client - Get Characteristic - Single",
 		ACTION_SUCCESS(init_pdus, get_characteristic_1),
 		ACTION_SUCCESS(bluetooth_enable_action, NULL),
-- 
1.8.4

