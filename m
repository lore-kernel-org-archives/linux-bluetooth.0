Return-Path: <cyrus@holtmann.org>
From: Marcin Kraglak <marcin.kraglak@tieto.com>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCHv2 4/8] android/tester: Add GATT Client Search Service test case
Date: Tue,  2 Sep 2014 14:04:27 +0200
Message-Id: <1409659471-25171-5-git-send-email-marcin.kraglak@tieto.com>
In-Reply-To: <1409659471-25171-1-git-send-email-marcin.kraglak@tieto.com>
References: <1409659471-25171-1-git-send-email-marcin.kraglak@tieto.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

It is basic test case for searching primary services.
---
 android/tester-gatt.c | 124 +++++++++++++++++++++++++++++++++++++++++++++++++-
 1 file changed, 123 insertions(+), 1 deletion(-)

diff --git a/android/tester-gatt.c b/android/tester-gatt.c
index b680322..1533d1f 100644
--- a/android/tester-gatt.c
+++ b/android/tester-gatt.c
@@ -33,8 +33,23 @@
 #define CONN1_ID	1
 #define CONN2_ID	2
 
+#define data(args...) ((const unsigned char[]) { args })
+
+#define raw_pdu(args...)					\
+	{							\
+		.data = data(args),				\
+		.size = sizeof(data(args)),			\
+	}
+
+#define end_pdu { .data = NULL }
+
 static struct queue *list; /* List of gatt test cases */
 
+struct pdu {
+	const uint8_t *data;
+	uint16_t size;
+};
+
 static bt_uuid_t client_app_uuid = {
 	.uu = { 0x01, 0x01, 0x01, 0x01, 0x01, 0x01, 0x01, 0x01, 0x01,
 				0x01, 0x01, 0x01, 0x01, 0x01, 0x01, 0x01 },
@@ -53,6 +68,11 @@ struct gatt_connect_data {
 	const int conn_id;
 };
 
+struct gatt_search_service_data {
+	const int conn_id;
+	bt_uuid_t *filter_uuid;
+};
+
 static bt_uuid_t client2_app_uuid = {
 	.uu = { 0x02, 0x02, 0x02, 0x02, 0x02, 0x02, 0x02, 0x02, 0x02,
 				0x02, 0x02, 0x02, 0x02, 0x02, 0x02, 0x02 },
@@ -92,6 +112,11 @@ static struct gatt_connect_data client2_conn_req = {
 	.conn_id = CONN2_ID,
 };
 
+static struct gatt_search_service_data search_services_1 = {
+	.conn_id = CONN1_ID,
+	.filter_uuid = NULL,
+};
+
 static const uint8_t exchange_mtu_req_pdu[] = { 0x02, 0xa0, 0x02 };
 static const uint8_t exchange_mtu_resp_pdu[] = { 0x03, 0xa0, 0x02 };
 
@@ -99,6 +124,21 @@ static struct bt_action_data bearer_type = {
 	.bearer_type = BDADDR_LE_PUBLIC,
 };
 
+static btgatt_srvc_id_t service_1 = {
+	.is_primary = true,
+	.id.inst_id = 0,
+	.id.uuid.uu = {0xfb, 0x34, 0x9b, 0x5f, 0x80, 0x00, 0x00, 0x80,
+			0x00, 0x10, 0x00, 0x00,  0x00, 0x18, 0x00, 0x00}
+};
+
+static struct pdu search_service[] = {
+	raw_pdu(0x10, 0x01, 0x00, 0xff, 0xff, 0x00, 0x28),
+	raw_pdu(0x11, 0x06, 0x01, 0x00, 0x10, 0x00, 0x00, 0x18),
+	raw_pdu(0x10, 0x11, 0x00, 0xff, 0xff, 0x00, 0x28),
+	raw_pdu(0x01, 0x10, 0x11, 0x00, 0x0a),
+	end_pdu
+};
+
 static void gatt_client_register_action(void)
 {
 	struct test_data *data = tester_get_data();
@@ -216,6 +256,7 @@ static void gatt_cid_hook_cb(const void *data, uint16_t len, void *user_data)
 	struct bthost *bthost = hciemu_client_get_host(t_data->hciemu);
 	struct emu_cid_data *cid_data = user_data;
 	const uint8_t *pdu = data;
+	struct pdu *gatt_pdu = queue_peek_head(t_data->pdus);
 
 	switch (pdu[0]) {
 	case L2CAP_ATT_EXCHANGE_MTU_REQ:
@@ -232,7 +273,29 @@ static void gatt_cid_hook_cb(const void *data, uint16_t len, void *user_data)
 
 		break;
 	default:
-		tester_print("Unknown ATT packet.");
+		if (!gatt_pdu || !gatt_pdu->data) {
+			tester_print("Unknown ATT packet.");
+			break;
+		}
+
+		if (gatt_pdu->size != len) {
+			tester_print("Size of incoming frame is not valid");
+			tester_print("Expected size = %d incoming size = %d",
+							gatt_pdu->size, len);
+			break;
+		}
+
+		if (memcmp(gatt_pdu->data, data, len)) {
+			tester_print("Incoming data mismatch");
+			break;
+		}
+		queue_pop_head(t_data->pdus);
+		gatt_pdu = queue_pop_head(t_data->pdus);
+		if (!gatt_pdu->data)
+			break;
+
+		bthost_send_cid(bthost, cid_data->handle, cid_data->cid,
+						gatt_pdu->data, gatt_pdu->size);
 
 		break;
 	}
@@ -257,6 +320,40 @@ static void gatt_conn_cb(uint16_t handle, void *user_data)
 								&cid_data);
 }
 
+static void gatt_client_search_services(void)
+{
+	struct test_data *data = tester_get_data();
+	struct step *current_data_step = queue_peek_head(data->steps);
+	struct step *step = g_new0(struct step, 1);
+	struct gatt_search_service_data *search_data;
+	int status;
+
+	search_data = current_data_step->set_data;
+
+	status = data->if_gatt->client->search_service(search_data->conn_id,
+						search_data->filter_uuid);
+	step->action_status = status;
+
+	schedule_action_verification(step);
+}
+
+static void init_pdus(void)
+{
+	struct test_data *data = tester_get_data();
+	struct step *current_data_step = queue_peek_head(data->steps);
+	struct step *step = g_new0(struct step, 1);
+	struct pdu *pdu = current_data_step->set_data;
+
+	while (pdu->data) {
+		queue_push_tail(data->pdus, pdu);
+		pdu++;
+	}
+
+	step->action_status = BT_STATUS_SUCCESS;
+
+	schedule_action_verification(step);
+}
+
 static struct test_case test_cases[] = {
 	TEST_CASE_BREDRLE("Gatt Init",
 		ACTION_SUCCESS(dummy_action, NULL),
@@ -446,6 +543,31 @@ static struct test_case test_cases[] = {
 		ACTION_SUCCESS(bluetooth_disable_action, NULL),
 		CALLBACK_STATE(CB_BT_ADAPTER_STATE_CHANGED, BT_STATE_OFF),
 	),
+	TEST_CASE_BREDRLE("Gatt Client - Search Service 1",
+		ACTION_SUCCESS(init_pdus, search_service),
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
+		CALLBACK_GATTC_SEARCH_COMPLETE(GATT_STATUS_SUCCESS, CONN1_ID),
+		ACTION_SUCCESS(bluetooth_disable_action, NULL),
+		CALLBACK_STATE(CB_BT_ADAPTER_STATE_CHANGED, BT_STATE_OFF),
+	),
 };
 
 struct queue *get_gatt_tests(void)
-- 
1.9.0

