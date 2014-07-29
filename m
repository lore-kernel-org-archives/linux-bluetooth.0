Return-Path: <cyrus@holtmann.org>
From: Jakub Tyszkowski <jakub.tyszkowski@tieto.com>
To: linux-bluetooth@vger.kernel.org
Cc: Jakub Tyszkowski <jakub.tyszkowski@tieto.com>
Subject: [PATCHv2 7/9] android/tester-ng: Add HIDHost send data case
Date: Tue, 29 Jul 2014 09:18:30 +0200
Message-Id: <1406618312-15059-8-git-send-email-jakub.tyszkowski@tieto.com>
In-Reply-To: <1406618312-15059-1-git-send-email-jakub.tyszkowski@tieto.com>
References: <1406618312-15059-1-git-send-email-jakub.tyszkowski@tieto.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

---
 android/tester-hidhost.c | 44 +++++++++++++++++++++++++++++++++++++++++++-
 1 file changed, 43 insertions(+), 1 deletion(-)

diff --git a/android/tester-hidhost.c b/android/tester-hidhost.c
index 84b9f62..c6296aa 100644
--- a/android/tester-hidhost.c
+++ b/android/tester-hidhost.c
@@ -238,10 +238,16 @@ static void hid_intr_cid_hook_cb(const void *data, uint16_t len,
 							void *user_data)
 {
 	uint8_t header = ((uint8_t *) data)[0];
+	struct step *step;
 
 	switch (header) {
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
@@ -370,6 +376,26 @@ static void hidhost_set_report_action(void)
 {
 	struct test_data *data = tester_get_data();
 	const uint8_t *hid_addr = hciemu_get_client_bdaddr(data->hciemu);
+	char *buf = "fe0201";
+	bt_bdaddr_t bdaddr;
+	int status;
+
+	bdaddr2android((const bdaddr_t *) hid_addr, &bdaddr);
+
+	/* Successfull result should be verified on the other end (hook) */
+	status = data->if_hid->send_data(&bdaddr, buf);
+	if (status) {
+		struct step *step = g_new0(struct step, 1);
+
+		step->action_status = status;
+		schedule_action_verification(step);
+	}
+}
+
+static void hidhost_send_data_action(void)
+{
+	struct test_data *data = tester_get_data();
+	const uint8_t *hid_addr = hciemu_get_client_bdaddr(data->hciemu);
 	char *buf = "010101";
 	bt_bdaddr_t bdaddr;
 	int status;
@@ -515,6 +541,22 @@ static struct test_case test_cases[] = {
 						BTHH_CONN_STATE_CONNECTED),
 		ACTION_SUCCESS(hidhost_set_report_action, NULL),
 	),
+	TEST_CASE_BREDRLE("HidHost SendData Success",
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
+		ACTION_SUCCESS(hidhost_send_data_action, NULL),
+	),
 };
 
 struct queue *get_hidhost_tests(void)
-- 
1.9.1

