Return-Path: <cyrus@holtmann.org>
From: Jakub Tyszkowski <jakub.tyszkowski@tieto.com>
To: linux-bluetooth@vger.kernel.org
Cc: Jakub Tyszkowski <jakub.tyszkowski@tieto.com>
Subject: [PATCH 6/9] android/tester-ng: Add HIDHost set report case
Date: Fri, 25 Jul 2014 15:13:32 +0200
Message-Id: <1406294015-8172-6-git-send-email-jakub.tyszkowski@tieto.com>
In-Reply-To: <1406294015-8172-1-git-send-email-jakub.tyszkowski@tieto.com>
References: <1406294015-8172-1-git-send-email-jakub.tyszkowski@tieto.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

---
 android/tester-hidhost.c | 59 +++++++++++++++++++++++++++++++++++++++++++++++-
 1 file changed, 58 insertions(+), 1 deletion(-)

diff --git a/android/tester-hidhost.c b/android/tester-hidhost.c
index d000a31..d0c30b5 100644
--- a/android/tester-hidhost.c
+++ b/android/tester-hidhost.c
@@ -221,6 +221,7 @@ static void hid_ctrl_cid_hook_cb(const void *data, uint16_t len,
 {
 	struct emu_cid_data *cid_data = user_data;
 	uint8_t header = ((uint8_t *) data)[0];
+	struct step *step;
 
 	switch (header) {
 	case HID_GET_REPORT_PROTOCOL:
@@ -242,7 +243,12 @@ static void hid_ctrl_cid_hook_cb(const void *data, uint16_t len,
 	case HID_SET_OUTPUT_REPORT:
 	case HID_SET_FEATURE_REPORT:
 	case HID_SEND_DATA:
-		/* Todo verify step with success */
+		/* Successfully verify sending data step */
+		step = g_new0(struct step, 1);
+
+		step->action_status = BT_STATUS_SUCCESS;
+
+		schedule_action_verification(step);
 		break;
 	}
 }
@@ -390,6 +396,26 @@ static void hidhost_get_report_action(void)
 	schedule_action_verification(step);
 }
 
+static void hidhost_set_report_action(void)
+{
+	struct test_data *data = tester_get_data();
+	const uint8_t *hid_addr = hciemu_get_client_bdaddr(data->hciemu);
+	char *buf = "010101";
+	bt_bdaddr_t bdaddr;
+	int status;
+
+	bdaddr2android((const bdaddr_t *) hid_addr, &bdaddr);
+
+	/* Successfull result should be verified on the other end (hook) */
+	status = data->if_hid->set_report(&bdaddr, BTHH_INPUT_REPORT, buf);
+	if (status) {
+		struct step *step = g_new0(struct step, 1);
+
+		step->action_status = status;
+		schedule_action_verification(step);
+	}
+}
+
 static struct test_case test_cases[] = {
 	TEST_CASE_BREDRLE("HidHost Init",
 		ACTION_SUCCESS(dummy_action, NULL),
@@ -575,6 +601,37 @@ static struct test_case test_cases[] = {
 		CALLBACK_HHREPORT(CB_HH_GET_REPORT, BTHH_OK,
 						HID_EXPECTED_REPORT_SIZE),
 	),
+	TEST_CASE_BREDRLE("HidHost SetReport Success",
+		ACTION_SUCCESS(bluetooth_enable_action, NULL),
+		CALLBACK_STATE(CB_BT_ADAPTER_STATE_CHANGED, BT_STATE_ON),
+		ACTION_SUCCESS(emu_setup_powered_remote_action, NULL),
+		ACTION_SUCCESS(emu_set_ssp_mode_action, NULL),
+		ACTION_SUCCESS(bt_create_bond_action,
+					&prop_test_remote_ble_bdaddr_req),
+		CALLBACK_BOND_STATE(BT_BOND_STATE_BONDING,
+						&prop_emu_remote_bdadr, 1),
+		CALLBACK_DEVICE_FOUND(prop_emu_remotes_default_set, 1),
+		CALLBACK_SSP_REQ(BT_SSP_VARIANT_PASSKEY_CONFIRMATION,
+					prop_emu_remotes_pin_req_set, 2),
+		ACTION_SUCCESS(bt_ssp_reply_accept_action,
+						&ssp_confirm_accept_reply),
+		CALLBACK_BOND_STATE(BT_BOND_STATE_BONDED,
+						&prop_emu_remote_bdadr, 1),
+		CALLBACK_DEVICE_PROPS(NULL, 0),
+		ACTION_SUCCESS(emu_add_l2cap_server_action,
+							&l2cap_setup_sdp_data),
+		ACTION_SUCCESS(emu_add_l2cap_server_action,
+							&l2cap_setup_cc_data),
+		ACTION_SUCCESS(emu_add_l2cap_server_action,
+							&l2cap_setup_ic_data),
+		ACTION_SUCCESS(hidhost_connect_action, NULL),
+		CALLBACK_STATE(CB_HH_CONNECTION_STATE,
+						BTHH_CONN_STATE_CONNECTING),
+		CALLBACK(CB_HH_HID_INFO),
+		CALLBACK_STATE(CB_HH_CONNECTION_STATE,
+						BTHH_CONN_STATE_CONNECTED),
+		ACTION_SUCCESS(hidhost_set_report_action, NULL),
+	),
 };
 
 struct queue *get_hidhost_tests(void)
-- 
1.9.1

