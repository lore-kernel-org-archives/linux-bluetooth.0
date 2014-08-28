Return-Path: <cyrus@holtmann.org>
From: Marcin Kraglak <marcin.kraglak@tieto.com>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH 3/6] android/tester: Add GATT Search Service 2 test case
Date: Thu, 28 Aug 2014 15:26:21 +0200
Message-Id: <1409232384-24580-3-git-send-email-marcin.kraglak@tieto.com>
In-Reply-To: <1409232384-24580-1-git-send-email-marcin.kraglak@tieto.com>
References: <1409232384-24580-1-git-send-email-marcin.kraglak@tieto.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

It tests searching for Primary Services. In this scenarion two
services will be returned.
---
 android/tester-gatt.c | 43 +++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 43 insertions(+)

diff --git a/android/tester-gatt.c b/android/tester-gatt.c
index a83b61d..3a090d1 100644
--- a/android/tester-gatt.c
+++ b/android/tester-gatt.c
@@ -127,6 +127,13 @@ static btgatt_srvc_id_t service_1 = {
 			0x00, 0x10, 0x00, 0x00,  0x00, 0x18, 0x00, 0x00}
 };
 
+static btgatt_srvc_id_t service_2 = {
+	.is_primary = true,
+	.id.inst_id = 1,
+	.id.uuid.uu = {0xfb, 0x34, 0x9b, 0x5f, 0x80, 0x00, 0x00, 0x80,
+			0x00, 0x10, 0x00, 0x00,  0x01, 0x18, 0x00, 0x00}
+};
+
 static struct pdu search_service[] = {
 	raw_pdu(0x10, 0x01, 0x00, 0xff, 0xff, 0x00, 0x28),
 	raw_pdu(0x11, 0x06, 0x01, 0x00, 0x10, 0x00, 0x00, 0x18),
@@ -135,6 +142,16 @@ static struct pdu search_service[] = {
 	end_pdu
 };
 
+static struct pdu search_service_2[] = {
+	raw_pdu(0x10, 0x01, 0x00, 0xff, 0xff, 0x00, 0x28),
+	raw_pdu(0x11, 0x06, 0x01, 0x00, 0x10, 0x00, 0x00, 0x18),
+	raw_pdu(0x10, 0x11, 0x00, 0xff, 0xff, 0x00, 0x28),
+	raw_pdu(0x11, 0x06, 0x11, 0x00, 0x20, 0x00, 0x01, 0x18),
+	raw_pdu(0x10, 0x21, 0x00, 0xff, 0xff, 0x00, 0x28),
+	raw_pdu(0x01, 0x10, 0x21, 0x00, 0x0a),
+	end_pdu
+};
+
 static void gatt_client_register_action(void)
 {
 	struct test_data *data = tester_get_data();
@@ -609,6 +626,32 @@ static struct test_case test_cases[] = {
 		ACTION_SUCCESS(bluetooth_disable_action, NULL),
 		CALLBACK_STATE(CB_BT_ADAPTER_STATE_CHANGED, BT_STATE_OFF),
 	),
+	TEST_CASE_BREDRLE("Gatt Client - Search Service 2",
+		ACTION_SUCCESS(init_pdus, search_service_2),
+		ACTION_SUCCESS(bluetooth_enable_action, NULL),
+		CALLBACK_STATE(CB_BT_ADAPTER_STATE_CHANGED, BT_STATE_ON),
+		ACTION_SUCCESS(emu_setup_powered_remote_action, NULL),
+		ACTION_SUCCESS(emu_set_ssp_mode_action, NULL),
+		ACTION_SUCCESS(emu_set_connect_cb_action, gatt_conn_cb),
+		ACTION_SUCCESS(gatt_client_register_action, &client_app_uuid),
+		CALLBACK_STATUS(CB_GATTC_REGISTER_CLIENT, BT_STATUS_SUCCESS),
+		ACTION_SUCCESS(gatt_client_start_scan_action,
+							INT_TO_PTR(CLIENT1_ID)),
+		CLLBACK_GATTC_SCAN_RES(prop_emu_remotes_default_set, 1, TRUE),
+		ACTION_SUCCESS(gatt_client_stop_scan_action,
+							INT_TO_PTR(CLIENT1_ID)),
+		ACTION_SUCCESS(gatt_client_connect_action,
+							&client1_conn_req),
+		CALLBACK_GATTC_CONNECT(GATT_STATUS_SUCCESS,
+						prop_emu_remotes_default_set,
+						CONN1_ID, CLIENT1_ID),
+		ACTION_SUCCESS(gatt_client_search_services, &search_services_1),
+		CALLBACK_GATTC_SEARCH_RESULT(CONN1_ID, &service_1),
+		CALLBACK_GATTC_SEARCH_RESULT(CONN1_ID, &service_2),
+		CALLBACK_GATTC_SEARCH_COMPLETE(GATT_STATUS_SUCCESS, CONN1_ID),
+		ACTION_SUCCESS(bluetooth_disable_action, NULL),
+		CALLBACK_STATE(CB_BT_ADAPTER_STATE_CHANGED, BT_STATE_OFF),
+	),
 };
 
 struct queue *get_gatt_tests(void)
-- 
1.9.3

