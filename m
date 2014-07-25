Return-Path: <cyrus@holtmann.org>
From: Jakub Tyszkowski <jakub.tyszkowski@tieto.com>
To: linux-bluetooth@vger.kernel.org
Cc: Jakub Tyszkowski <jakub.tyszkowski@tieto.com>
Subject: [PATCH 1/9] android/tester-ng: Add HIDHost connect, disconnect cases
Date: Fri, 25 Jul 2014 15:13:27 +0200
Message-Id: <1406294015-8172-1-git-send-email-jakub.tyszkowski@tieto.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

---
 android/tester-hidhost.c | 353 ++++++++++++++++++++++++++++++++++++++++++++++-
 android/tester-main.c    |  13 +-
 2 files changed, 364 insertions(+), 2 deletions(-)

diff --git a/android/tester-hidhost.c b/android/tester-hidhost.c
index 59ff01c..8fb5df7 100644
--- a/android/tester-hidhost.c
+++ b/android/tester-hidhost.c
@@ -20,12 +20,363 @@
 #include "emulator/bthost.h"
 #include "tester-main.h"
 
+#include "android/utils.h"
+
+#define HID_GET_REPORT_PROTOCOL		0x60
+#define HID_GET_BOOT_PROTOCOL		0x61
+#define HID_SET_REPORT_PROTOCOL		0x70
+#define HID_SET_BOOT_PROTOCOL		0x71
+
+#define HID_SET_INPUT_REPORT		0x51
+#define HID_SET_OUTPUT_REPORT		0x52
+#define HID_SET_FEATURE_REPORT		0x53
+
+#define HID_SEND_DATA			0xa2
+
+#define HID_GET_INPUT_REPORT		0x49
+#define HID_GET_OUTPUT_REPORT		0x4a
+#define HID_GET_FEATURE_REPORT		0x4b
+
 static struct queue *list; /* List of hidhost test cases */
 
+struct emu_cid_data {
+	const int pdu_len;
+	const void *pdu;
+
+	uint16_t sdp_handle;
+	uint16_t sdp_cid;
+	uint16_t ctrl_handle;
+	uint16_t ctrl_cid;
+	uint16_t intr_handle;
+	uint16_t intr_cid;
+};
+
+struct emu_cid_data cid_data;
+
+static bt_bdaddr_t emu_remote_bdaddr_val = {
+	.address = { 0x00, 0xaa, 0x01, 0x01, 0x00, 0x00 },
+};
+static bt_property_t prop_emu_remote_bdadr = {
+	.type = BT_PROPERTY_BDADDR,
+	.val = &emu_remote_bdaddr_val,
+	.len = sizeof(emu_remote_bdaddr_val),
+};
+static bt_property_t prop_emu_remotes_default_set[] = {
+	{ BT_PROPERTY_BDADDR, sizeof(emu_remote_bdaddr_val),
+						&emu_remote_bdaddr_val },
+};
+
+static bt_property_t prop_emu_remotes_pin_req_set[] = {
+	{ BT_PROPERTY_BDADDR, sizeof(emu_remote_bdaddr_val),
+						&emu_remote_bdaddr_val },
+};
+
+static struct bt_action_data ssp_confirm_accept_reply = {
+	.addr = &emu_remote_bdaddr_val,
+	.ssp_variant = BT_SSP_VARIANT_PASSKEY_CONFIRMATION,
+	.accept = TRUE,
+};
+
+static const uint8_t did_req_pdu[] = { 0x06, /* PDU id */
+			0x00, 0x00, /* Transaction id */
+			0x00, 0x0f, /* Req length */
+			0x35, 0x03, /* Attributes length */
+			0x19, 0x12, 0x00, 0xff, 0xff, 0x35, 0x05, 0x0a, 0x00,
+			0x00, 0xff, 0xff, 0x00 }; /* no continuation */
+
+static const uint8_t did_rsp_pdu[] = { 0x07, /* PDU id */
+			0x00, 0x00, /* Transaction id */
+			0x00, 0x4f, /* Response length */
+			0x00, 0x4c, /* Attributes length */
+			0x35, 0x4a, 0x35, 0x48, 0x09, 0x00, 0x00, 0x0a, 0x00,
+			0x01, 0x00, 0x00, 0x09, 0x00, 0x01, 0x35, 0x03, 0x19,
+			0x12, 0x00, 0x09, 0x00, 0x05, 0x35, 0x03, 0x19, 0x10,
+			0x02, 0x09, 0x00, 0x09, 0x35, 0x08, 0x35, 0x06, 0x19,
+			0x12, 0x00, 0x09, 0x01, 0x03, 0x09, 0x02, 0x00, 0x09,
+			0x01, 0x03, 0x09, 0x02, 0x01, 0x09, 0x1d, 0x6b, 0x09,
+			0x02, 0x02, 0x09, 0x02, 0x46, 0x09, 0x02, 0x03, 0x09,
+			0x05, 0x0e, 0x09, 0x02, 0x04, 0x28, 0x01, 0x09, 0x02,
+			0x05, 0x09, 0x00, 0x02,
+			0x00 }; /* no continuation */
+
+static const uint8_t hid_rsp_pdu[] = { 0x07, /* PDU id */
+			0x00, 0x01, /* Transaction id */
+			0x01, 0x71, /* Response length */
+			0x01, 0x6E, /* Attributes length */
+			0x36, 0x01, 0x6b, 0x36, 0x01, 0x68, 0x09, 0x00, 0x00,
+			0x0a, 0x00, 0x01, 0x00, 0x00, 0x09, 0x00, 0x01, 0x35,
+			0x03, 0x19, 0x11, 0x24, 0x09, 0x00, 0x04, 0x35, 0x0d,
+			0x35, 0x06, 0x19, 0x01, 0x00, 0x09, 0x00, 0x11, 0x35,
+			0x03, 0x19, 0x00, 0x11, 0x09, 0x00, 0x05, 0x35, 0x03,
+			0x19, 0x10, 0x02, 0x09, 0x00, 0x06, 0x35, 0x09, 0x09,
+			0x65, 0x6e, 0x09, 0x00, 0x6a, 0x09, 0x01, 0x00, 0x09,
+			0x00, 0x09, 0x35, 0x08, 0x35, 0x06, 0x19, 0x11, 0x24,
+			0x09, 0x01, 0x00, 0x09, 0x00, 0x0d, 0x35, 0x0f, 0x35,
+			0x0d, 0x35, 0x06, 0x19, 0x01, 0x00, 0x09, 0x00, 0x13,
+			0x35, 0x03, 0x19, 0x00, 0x11, 0x09, 0x01, 0x00, 0x25,
+			0x1e, 0x4c, 0x6f, 0x67, 0x69, 0x74, 0x65, 0x63, 0x68,
+			0x20, 0x42, 0x6c, 0x75, 0x65, 0x74, 0x6f, 0x6f, 0x74,
+			0x68, 0x20, 0x4d, 0x6f, 0x75, 0x73, 0x65, 0x20, 0x4d,
+			0x35, 0x35, 0x35, 0x62, 0x09, 0x01, 0x01, 0x25, 0x0f,
+			0x42, 0x6c, 0x75, 0x65, 0x74, 0x6f, 0x6f, 0x74, 0x68,
+			0x20, 0x4d, 0x6f, 0x75, 0x73, 0x65, 0x09, 0x01, 0x02,
+			0x25, 0x08, 0x4c, 0x6f, 0x67, 0x69, 0x74, 0x65, 0x63,
+			0x68, 0x09, 0x02, 0x00, 0x09, 0x01, 0x00, 0x09, 0x02,
+			0x01, 0x09, 0x01, 0x11, 0x09, 0x02, 0x02, 0x08, 0x80,
+			0x09, 0x02, 0x03, 0x08, 0x21, 0x09, 0x02, 0x04, 0x28,
+			0x01, 0x09, 0x02, 0x05, 0x28, 0x01, 0x09, 0x02, 0x06,
+			0x35, 0x74, 0x35, 0x72, 0x08, 0x22, 0x25, 0x6e, 0x05,
+			0x01, 0x09, 0x02, 0xa1, 0x01, 0x85, 0x02, 0x09, 0x01,
+			0xa1, 0x00, 0x05, 0x09, 0x19, 0x01, 0x29, 0x08, 0x15,
+			0x00, 0x25, 0x01, 0x75, 0x01, 0x95, 0x08, 0x81, 0x02,
+			0x05, 0x01, 0x09, 0x30, 0x09, 0x31, 0x16, 0x01, 0xf8,
+			0x26, 0xff, 0x07, 0x75, 0x0c, 0x95, 0x02, 0x81, 0x06,
+			0x09, 0x38, 0x15, 0x81, 0x25, 0x7f, 0x75, 0x08, 0x95,
+			0x01, 0x81, 0x06, 0x05, 0x0c, 0x0a, 0x38, 0x02, 0x81,
+			0x06, 0x05, 0x09, 0x19, 0x09, 0x29, 0x10, 0x15, 0x00,
+			0x25, 0x01, 0x95, 0x08, 0x75, 0x01, 0x81, 0x02, 0xc0,
+			0xc0, 0x06, 0x00, 0xff, 0x09, 0x01, 0xa1, 0x01, 0x85,
+			0x10, 0x75, 0x08, 0x95, 0x06, 0x15, 0x00, 0x26, 0xff,
+			0x00, 0x09, 0x01, 0x81, 0x00, 0x09, 0x01, 0x91, 0x00,
+			0xc0, 0x09, 0x02, 0x07, 0x35, 0x08, 0x35, 0x06, 0x09,
+			0x04, 0x09, 0x09, 0x01, 0x00, 0x09, 0x02, 0x08, 0x28,
+			0x00, 0x09, 0x02, 0x09, 0x28, 0x01, 0x09, 0x02, 0x0a,
+			0x28, 0x01, 0x09, 0x02, 0x0b, 0x09, 0x01, 0x00, 0x09,
+			0x02, 0x0c, 0x09, 0x0c, 0x80, 0x09, 0x02, 0x0d, 0x28,
+			0x00, 0x09, 0x02, 0x0e, 0x28, 0x01,
+			0x00 }; /* no continuation */
+
+static void hid_sdp_cid_hook_cb(const void *data, uint16_t len, void *user_data)
+{
+	struct test_data *t_data = tester_get_data();
+	struct bthost *bthost = hciemu_client_get_host(t_data->hciemu);
+	struct emu_cid_data *cid_data = user_data;
+
+	if (!memcmp(did_req_pdu, data, len)) {
+		bthost_send_cid(bthost, cid_data->sdp_handle, cid_data->sdp_cid,
+					did_rsp_pdu, sizeof(did_rsp_pdu));
+		return;
+	}
+
+	bthost_send_cid(bthost, cid_data->sdp_handle, cid_data->sdp_cid,
+					hid_rsp_pdu, sizeof(hid_rsp_pdu));
+}
+static void hid_sdp_search_cb(uint16_t handle, uint16_t cid, void *user_data)
+{
+	struct test_data *data = tester_get_data();
+	struct bthost *bthost = hciemu_client_get_host(data->hciemu);
+
+	cid_data.sdp_handle = handle;
+	cid_data.sdp_cid = cid;
+
+	bthost_add_cid_hook(bthost, handle, cid, hid_sdp_cid_hook_cb,
+								&cid_data);
+}
+
+static void hid_prepare_reply_protocol_mode(struct emu_cid_data *cid_data)
+{
+	struct test_data *t_data = tester_get_data();
+	struct bthost *bthost = hciemu_client_get_host(t_data->hciemu);
+	uint8_t pdu[2] = { 0, 0 };
+	uint16_t pdu_len = 0;
+
+	pdu_len = 2;
+	pdu[0] = 0xa0;
+	pdu[1] = 0x00;
+
+	bthost_send_cid(bthost, cid_data->ctrl_handle, cid_data->ctrl_cid,
+							(void *)pdu, pdu_len);
+}
+
+static void hid_prepare_reply_report(struct emu_cid_data *cid_data)
+{
+	struct test_data *t_data = tester_get_data();
+	struct bthost *bthost = hciemu_client_get_host(t_data->hciemu);
+	uint8_t pdu[3] = { 0, 0, 0 };
+	uint16_t pdu_len = 0;
+
+	pdu_len = 3;
+	pdu[0] = 0xa2;
+	pdu[1] = 0x01;
+	pdu[2] = 0x00;
+
+	bthost_send_cid(bthost, cid_data->ctrl_handle, cid_data->ctrl_cid,
+							(void *)pdu, pdu_len);
+}
+
+static void hid_ctrl_cid_hook_cb(const void *data, uint16_t len,
+							void *user_data)
+{
+	struct emu_cid_data *cid_data = user_data;
+	uint8_t header = ((uint8_t *) data)[0];
+
+	switch (header) {
+	case HID_GET_REPORT_PROTOCOL:
+	case HID_GET_BOOT_PROTOCOL:
+	case HID_SET_REPORT_PROTOCOL:
+	case HID_SET_BOOT_PROTOCOL:
+		hid_prepare_reply_protocol_mode(cid_data);
+		break;
+	case HID_GET_INPUT_REPORT:
+	case HID_GET_OUTPUT_REPORT:
+	case HID_GET_FEATURE_REPORT:
+		hid_prepare_reply_report(cid_data);
+		break;
+	/*
+	 * HID device doesnot reply for this commads, so reaching pdu's
+	 * to hid device means assuming test passed
+	 */
+	case HID_SET_INPUT_REPORT:
+	case HID_SET_OUTPUT_REPORT:
+	case HID_SET_FEATURE_REPORT:
+	case HID_SEND_DATA:
+		/* Todo verify step with success */
+		break;
+	}
+}
+static void hid_ctrl_connect_cb(uint16_t handle, uint16_t cid, void *user_data)
+{
+	struct test_data *data = tester_get_data();
+	struct bthost *bthost = hciemu_client_get_host(data->hciemu);
+
+	cid_data.ctrl_handle = handle;
+	cid_data.ctrl_cid = cid;
+
+	bthost_add_cid_hook(bthost, handle, cid, hid_ctrl_cid_hook_cb,
+								&cid_data);
+}
+
+static void hid_intr_cid_hook_cb(const void *data, uint16_t len,
+							void *user_data)
+{
+	uint8_t header = ((uint8_t *) data)[0];
+
+	switch (header) {
+	case HID_SEND_DATA:
+		/* Todo verify step with success */
+		break;
+	}
+}
+static void hid_intr_connect_cb(uint16_t handle, uint16_t cid, void *user_data)
+{
+	struct test_data *data = tester_get_data();
+	struct bthost *bthost = hciemu_client_get_host(data->hciemu);
+
+	cid_data.intr_handle = handle;
+	cid_data.intr_cid = cid;
+
+	bthost_add_cid_hook(bthost, handle, cid, hid_intr_cid_hook_cb,
+								&cid_data);
+}
+
+/* Emulate SDP (PSM = 1) */
+static struct emu_set_l2cap_data l2cap_setup_sdp_data = {
+	.psm = 1,
+	.func = hid_sdp_search_cb,
+	.user_data = NULL,
+};
+
+/* Emulate Control Channel (PSM = 17) */
+static struct emu_set_l2cap_data l2cap_setup_cc_data = {
+	.psm = 17,
+	.func = hid_ctrl_connect_cb,
+	.user_data = NULL,
+};
+
+/* Emulate Interrupt Channel (PSM = 19) */
+static struct emu_set_l2cap_data l2cap_setup_ic_data = {
+	.psm = 19,
+	.func = hid_intr_connect_cb,
+	.user_data = NULL,
+};
+
+static void hidhost_connect_action(void)
+{
+	struct test_data *data = tester_get_data();
+	const uint8_t *hid_addr = hciemu_get_client_bdaddr(data->hciemu);
+	struct step *step = g_new0(struct step, 1);
+	bt_bdaddr_t bdaddr;
+
+	bdaddr2android((const bdaddr_t *) hid_addr, &bdaddr);
+
+	step->action_status = data->if_hid->connect(&bdaddr);
+
+	schedule_action_verification(step);
+}
+
+static void hidhost_disconnect_action(void)
+{
+	struct test_data *data = tester_get_data();
+	const uint8_t *hid_addr = hciemu_get_client_bdaddr(data->hciemu);
+	struct step *step = g_new0(struct step, 1);
+	bt_bdaddr_t bdaddr;
+
+	bdaddr2android((const bdaddr_t *) hid_addr, &bdaddr);
+
+	step->action_status = data->if_hid->disconnect(&bdaddr);
+
+	schedule_action_verification(step);
+}
+
 static struct test_case test_cases[] = {
-	TEST_CASE_BREDRLE("Hidhost Init",
+	TEST_CASE_BREDRLE("HidHost Init",
 		ACTION_SUCCESS(dummy_action, NULL),
 	),
+	TEST_CASE_BREDRLE("HidHost Connect Success",
+		ACTION_SUCCESS(bluetooth_enable_action, NULL),
+		CALLBACK_STATE(CB_BT_ADAPTER_STATE_CHANGED, BT_STATE_ON),
+		ACTION_SUCCESS(emu_setup_powered_remote_action, NULL),
+		ACTION_SUCCESS(emu_set_ssp_mode_action, NULL),
+		ACTION_SUCCESS(emu_add_l2cap_server_action,
+							&l2cap_setup_sdp_data),
+		ACTION_SUCCESS(emu_add_l2cap_server_action,
+							&l2cap_setup_cc_data),
+		ACTION_SUCCESS(emu_add_l2cap_server_action,
+							&l2cap_setup_ic_data),
+		ACTION_SUCCESS(hidhost_connect_action, NULL),
+		CALLBACK_DEVICE_FOUND(prop_emu_remotes_default_set, 1),
+		CALLBACK_BOND_STATE(BT_BOND_STATE_BONDING,
+						&prop_emu_remote_bdadr, 1),
+		CALLBACK_SSP_REQ(BT_SSP_VARIANT_PASSKEY_CONFIRMATION,
+					prop_emu_remotes_pin_req_set, 1),
+		ACTION_SUCCESS(bt_ssp_reply_accept_action,
+						&ssp_confirm_accept_reply),
+		CALLBACK_BOND_STATE(BT_BOND_STATE_BONDED,
+						&prop_emu_remote_bdadr, 1),
+		CALLBACK_STATE(CB_HH_CONNECTION_STATE,
+						BTHH_CONN_STATE_CONNECTED),
+		ACTION_SUCCESS(bluetooth_disable_action, NULL),
+		CALLBACK_STATE(CB_BT_ADAPTER_STATE_CHANGED, BT_STATE_OFF),
+	),
+	TEST_CASE_BREDRLE("HidHost Disconnect Success",
+		ACTION_SUCCESS(bluetooth_enable_action, NULL),
+		CALLBACK_STATE(CB_BT_ADAPTER_STATE_CHANGED, BT_STATE_ON),
+		ACTION_SUCCESS(emu_setup_powered_remote_action, NULL),
+		ACTION_SUCCESS(emu_set_ssp_mode_action, NULL),
+		ACTION_SUCCESS(emu_add_l2cap_server_action,
+							&l2cap_setup_sdp_data),
+		ACTION_SUCCESS(emu_add_l2cap_server_action,
+							&l2cap_setup_cc_data),
+		ACTION_SUCCESS(emu_add_l2cap_server_action,
+							&l2cap_setup_ic_data),
+		ACTION_SUCCESS(hidhost_connect_action, NULL),
+		CALLBACK_DEVICE_FOUND(prop_emu_remotes_default_set, 1),
+		CALLBACK_BOND_STATE(BT_BOND_STATE_BONDING,
+						&prop_emu_remote_bdadr, 1),
+		CALLBACK_SSP_REQ(BT_SSP_VARIANT_PASSKEY_CONFIRMATION,
+					prop_emu_remotes_pin_req_set, 1),
+		ACTION_SUCCESS(bt_ssp_reply_accept_action,
+						&ssp_confirm_accept_reply),
+		CALLBACK_BOND_STATE(BT_BOND_STATE_BONDED,
+						&prop_emu_remote_bdadr, 1),
+		CALLBACK_STATE(CB_HH_CONNECTION_STATE,
+						BTHH_CONN_STATE_CONNECTED),
+		ACTION_SUCCESS(hidhost_disconnect_action, NULL),
+		CALLBACK_STATE(CB_HH_CONNECTION_STATE,
+						BTHH_CONN_STATE_DISCONNECTING),
+		CALLBACK_STATE(CB_HH_CONNECTION_STATE,
+						BTHH_CONN_STATE_DISCONNECTED),
+	),
 };
 
 struct queue *get_hidhost_tests(void)
diff --git a/android/tester-main.c b/android/tester-main.c
index abef822..9eb10c7 100644
--- a/android/tester-main.c
+++ b/android/tester-main.c
@@ -770,9 +770,20 @@ static bt_callbacks_t bt_callbacks = {
 	.le_test_mode_cb = NULL
 };
 
+static void hidhost_connection_state_cb(bt_bdaddr_t *bd_addr,
+						bthh_connection_state_t state)
+{
+	struct step *step = g_new0(struct step, 1);
+
+	step->callback = CB_HH_CONNECTION_STATE;
+	step->callback_result.state = state;
+
+	schedule_callback_call(step);
+}
+
 static bthh_callbacks_t bthh_callbacks = {
 	.size = sizeof(bthh_callbacks),
-	.connection_state_cb = NULL,
+	.connection_state_cb = hidhost_connection_state_cb,
 	.hid_info_cb = NULL,
 	.protocol_mode_cb = NULL,
 	.idle_time_cb = NULL,
-- 
1.9.1

