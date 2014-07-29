Return-Path: <cyrus@holtmann.org>
From: Jakub Tyszkowski <jakub.tyszkowski@tieto.com>
To: linux-bluetooth@vger.kernel.org
Cc: Jakub Tyszkowski <jakub.tyszkowski@tieto.com>
Subject: [PATCHv2 4/9] android/tester-ng: Add HIDHost set protocol mode case
Date: Tue, 29 Jul 2014 09:18:27 +0200
Message-Id: <1406618312-15059-5-git-send-email-jakub.tyszkowski@tieto.com>
In-Reply-To: <1406618312-15059-1-git-send-email-jakub.tyszkowski@tieto.com>
References: <1406618312-15059-1-git-send-email-jakub.tyszkowski@tieto.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

---
 android/tester-hidhost.c | 32 ++++++++++++++++++++++++++++++++
 1 file changed, 32 insertions(+)

diff --git a/android/tester-hidhost.c b/android/tester-hidhost.c
index 070646e..d9dc04c 100644
--- a/android/tester-hidhost.c
+++ b/android/tester-hidhost.c
@@ -327,6 +327,21 @@ static void hidhost_get_protocol_action(void)
 	schedule_action_verification(step);
 }
 
+static void hidhost_set_protocol_action(void)
+{
+	struct test_data *data = tester_get_data();
+	const uint8_t *hid_addr = hciemu_get_client_bdaddr(data->hciemu);
+	struct step *step = g_new0(struct step, 1);
+	bt_bdaddr_t bdaddr;
+
+	bdaddr2android((const bdaddr_t *) hid_addr, &bdaddr);
+
+	step->action_status = data->if_hid->set_protocol(&bdaddr,
+							BTHH_REPORT_MODE);
+
+	schedule_action_verification(step);
+}
+
 static struct test_case test_cases[] = {
 	TEST_CASE_BREDRLE("HidHost Init",
 		ACTION_SUCCESS(dummy_action, NULL),
@@ -403,6 +418,23 @@ static struct test_case test_cases[] = {
 		ACTION_SUCCESS(hidhost_get_protocol_action, NULL),
 		CALLBACK_HH_MODE(CB_HH_PROTOCOL_MODE, BTHH_OK, HID_MODE_BREDR),
 	),
+	TEST_CASE_BREDRLE("HidHost SetProtocol Success",
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
+		CALLBACK_STATE(CB_HH_CONNECTION_STATE,
+						BTHH_CONN_STATE_CONNECTED),
+		ACTION_SUCCESS(hidhost_set_protocol_action, NULL),
+		CALLBACK_HH_MODE(CB_HH_PROTOCOL_MODE, BTHH_OK, HID_MODE_BREDR),
+	),
 };
 
 struct queue *get_hidhost_tests(void)
-- 
1.9.1

