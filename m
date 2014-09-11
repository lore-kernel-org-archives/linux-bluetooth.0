Return-Path: <cyrus@holtmann.org>
From: Marcin Kraglak <marcin.kraglak@tieto.com>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH 12/14] android/tester: Add GATT Get Included Service 2 test case
Date: Thu, 11 Sep 2014 08:08:50 +0200
Message-Id: <1410415732-23212-12-git-send-email-marcin.kraglak@tieto.com>
In-Reply-To: <1410415732-23212-1-git-send-email-marcin.kraglak@tieto.com>
References: <1410415732-23212-1-git-send-email-marcin.kraglak@tieto.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

It will test searching include services with 128 bit UUID.
---
 android/tester-gatt.c | 52 +++++++++++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 52 insertions(+)

diff --git a/android/tester-gatt.c b/android/tester-gatt.c
index 2dce3a3..89f3574 100644
--- a/android/tester-gatt.c
+++ b/android/tester-gatt.c
@@ -169,6 +169,15 @@ static btgatt_srvc_id_t included_1 = {
 	}
 };
 
+static btgatt_srvc_id_t included_2 = {
+	.is_primary = false,
+	.id = {
+		.inst_id = 1,
+		.uuid.uu = {0x00, 0x01, 0x02, 0x03, 0x04, 0x05, 0x06, 0x07,
+				0x08, 0x0a, 0x0b, 0x0c, 0x0d, 0x0e, 0x0f, 0x10},
+	}
+};
+
 static btgatt_gatt_id_t characteristic_1 = {
 	.inst_id = 1,
 	.uuid.uu = {0xfb, 0x34, 0x9b, 0x5f, 0x80, 0x00, 0x00, 0x80,
@@ -309,6 +318,21 @@ static struct pdu get_included_1[] = {
 	end_pdu
 };
 
+static struct pdu get_included_2[] = {
+	raw_pdu(0x10, 0x01, 0x00, 0xff, 0xff, 0x00, 0x28),
+	raw_pdu(0x11, 0x06, 0x01, 0x00, 0x10, 0x00, 0x00, 0x18),
+	raw_pdu(0x10, 0x11, 0x00, 0xff, 0xff, 0x00, 0x28),
+	raw_pdu(0x01, 0x11, 0x11, 0x00, 0x0a),
+	raw_pdu(0x08, 0x01, 0x00, 0x10, 0x00, 0x02, 0x28),
+	raw_pdu(0x09, 0x06, 0x02, 0x00, 0x15, 0x00, 0x19, 0x00),
+	raw_pdu(0x0a, 0x15, 0x00),
+	raw_pdu(0x0b, 0x00, 0x01, 0x02, 0x03, 0x04, 0x05, 0x06, 0x07, 0x08,
+				0x0a, 0x0b, 0x0c, 0x0d, 0x0e, 0x0f, 0x10),
+	raw_pdu(0x08, 0x03, 0x00, 0x10, 0x00, 0x02, 0x28),
+	raw_pdu(0x01, 0x08, 0x03, 0x00, 0x0a),
+	end_pdu
+};
+
 static void gatt_client_register_action(void)
 {
 	struct test_data *data = tester_get_data();
@@ -1020,6 +1044,34 @@ static struct test_case test_cases[] = {
 		ACTION_SUCCESS(bluetooth_disable_action, NULL),
 		CALLBACK_STATE(CB_BT_ADAPTER_STATE_CHANGED, BT_STATE_OFF),
 	),
+	TEST_CASE_BREDRLE("Gatt Client - Get Included Service 2 (128 bit UUID)",
+		ACTION_SUCCESS(init_pdus, get_included_2),
+		ACTION_SUCCESS(bluetooth_enable_action, NULL),
+		CALLBACK_STATE(CB_BT_ADAPTER_STATE_CHANGED, BT_STATE_ON),
+		ACTION_SUCCESS(emu_setup_powered_remote_action, NULL),
+		ACTION_SUCCESS(emu_set_ssp_mode_action, NULL),
+		ACTION_SUCCESS(emu_set_connect_cb_action, gatt_conn_cb),
+		ACTION_SUCCESS(gatt_client_register_action, &client_app_uuid),
+		CALLBACK_STATUS(CB_GATTC_REGISTER_CLIENT, BT_STATUS_SUCCESS),
+
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
+		CALLBACK_GATTC_SEARCH_COMPLETE(GATT_STATUS_SUCCESS, CONN1_ID),
+		ACTION_SUCCESS(gatt_client_get_included, &get_incl_data_1),
+		CALLBACK_GATTC_GET_INCLUDED(GATT_STATUS_SUCCESS, CONN1_ID,
+						&service_1, &included_2),
+		ACTION_SUCCESS(bluetooth_disable_action, NULL),
+		CALLBACK_STATE(CB_BT_ADAPTER_STATE_CHANGED, BT_STATE_OFF),
+	),
 };
 
 struct queue *get_gatt_tests(void)
-- 
1.9.3

