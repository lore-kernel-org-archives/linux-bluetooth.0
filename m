Return-Path: <cyrus@holtmann.org>
From: Marcin Kraglak <marcin.kraglak@tieto.com>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH 11/14] android/tester: Add GATT Get Included Service 1 test case
Date: Thu, 11 Sep 2014 08:08:49 +0200
Message-Id: <1410415732-23212-11-git-send-email-marcin.kraglak@tieto.com>
In-Reply-To: <1410415732-23212-1-git-send-email-marcin.kraglak@tieto.com>
References: <1410415732-23212-1-git-send-email-marcin.kraglak@tieto.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Verify if included service with 16-bit UUID can be found.
---
 android/tester-gatt.c | 77 +++++++++++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 77 insertions(+)

diff --git a/android/tester-gatt.c b/android/tester-gatt.c
index 19e86fe..2dce3a3 100644
--- a/android/tester-gatt.c
+++ b/android/tester-gatt.c
@@ -85,6 +85,12 @@ struct get_desc_data {
 	btgatt_gatt_id_t *desc;
 };
 
+struct get_incl_data {
+	const int conn_id;
+	btgatt_srvc_id_t *service;
+	btgatt_srvc_id_t *start_service;
+};
+
 static bt_uuid_t client2_app_uuid = {
 	.uu = { 0x02, 0x02, 0x02, 0x02, 0x02, 0x02, 0x02, 0x02, 0x02,
 				0x02, 0x02, 0x02, 0x02, 0x02, 0x02, 0x02 },
@@ -154,6 +160,15 @@ static btgatt_srvc_id_t service_2 = {
 	}
 };
 
+static btgatt_srvc_id_t included_1 = {
+	.is_primary = false,
+	.id = {
+		.inst_id = 1,
+		.uuid.uu = {0xfb, 0x34, 0x9b, 0x5f, 0x80, 0x00, 0x00, 0x80,
+			0x00, 0x10, 0x00, 0x00,  0xff, 0xfe, 0x00, 0x00},
+	}
+};
+
 static btgatt_gatt_id_t characteristic_1 = {
 	.inst_id = 1,
 	.uuid.uu = {0xfb, 0x34, 0x9b, 0x5f, 0x80, 0x00, 0x00, 0x80,
@@ -195,6 +210,11 @@ static struct get_desc_data get_desc_data_2 = {
 	.desc = &desc_1,
 };
 
+struct get_incl_data get_incl_data_1 = {
+	.conn_id = CONN1_ID,
+	.service = &service_1
+};
+
 static struct pdu search_service[] = {
 	raw_pdu(0x10, 0x01, 0x00, 0xff, 0xff, 0x00, 0x28),
 	raw_pdu(0x11, 0x06, 0x01, 0x00, 0x10, 0x00, 0x00, 0x18),
@@ -277,6 +297,18 @@ static struct pdu get_descriptor_3[] = {
 	end_pdu
 };
 
+static struct pdu get_included_1[] = {
+	raw_pdu(0x10, 0x01, 0x00, 0xff, 0xff, 0x00, 0x28),
+	raw_pdu(0x11, 0x06, 0x01, 0x00, 0x10, 0x00, 0x00, 0x18),
+	raw_pdu(0x10, 0x11, 0x00, 0xff, 0xff, 0x00, 0x28),
+	raw_pdu(0x01, 0x11, 0x11, 0x00, 0x0a),
+	raw_pdu(0x08, 0x01, 0x00, 0x10, 0x00, 0x02, 0x28),
+	raw_pdu(0x09, 0x08, 0x02, 0x00, 0x15, 0x00, 0x19, 0x00, 0xff, 0xfe),
+	raw_pdu(0x08, 0x03, 0x00, 0x10, 0x00, 0x02, 0x28),
+	raw_pdu(0x01, 0x08, 0x03, 0x00, 0x0a),
+	end_pdu
+};
+
 static void gatt_client_register_action(void)
 {
 	struct test_data *data = tester_get_data();
@@ -421,6 +453,23 @@ static void gatt_client_get_descriptor(void)
 	schedule_action_verification(step);
 }
 
+static void gatt_client_get_included(void)
+{
+	struct test_data *data = tester_get_data();
+	struct step *current_data_step = queue_peek_head(data->steps);
+	struct get_incl_data *get_incl = current_data_step->set_data;
+	const btgatt_client_interface_t *client = data->if_gatt->client;
+	struct step *step = g_new0(struct step, 1);
+	int status;
+
+	status = client->get_included_service(get_incl->conn_id,
+				get_incl->service, get_incl->start_service);
+
+	step->action_status = status;
+
+	schedule_action_verification(step);
+}
+
 static void gatt_cid_hook_cb(const void *data, uint16_t len, void *user_data)
 {
 	struct test_data *t_data = tester_get_data();
@@ -943,6 +992,34 @@ static struct test_case test_cases[] = {
 		ACTION_SUCCESS(bluetooth_disable_action, NULL),
 		CALLBACK_STATE(CB_BT_ADAPTER_STATE_CHANGED, BT_STATE_OFF),
 	),
+	TEST_CASE_BREDRLE("Gatt Client - Get Included Service 1",
+		ACTION_SUCCESS(init_pdus, get_included_1),
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
+						&service_1, &included_1),
+		ACTION_SUCCESS(bluetooth_disable_action, NULL),
+		CALLBACK_STATE(CB_BT_ADAPTER_STATE_CHANGED, BT_STATE_OFF),
+	),
 };
 
 struct queue *get_gatt_tests(void)
-- 
1.9.3

