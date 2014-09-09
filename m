Return-Path: <cyrus@holtmann.org>
From: Jakub Tyszkowski <jakub.tyszkowski@tieto.com>
To: linux-bluetooth@vger.kernel.org
Cc: Jakub Tyszkowski <jakub.tyszkowski@tieto.com>
Subject: [PATCHv3 3/7] android/tester: Improve HIDHost data sending verification
Date: Tue,  9 Sep 2014 09:46:59 +0200
Message-Id: <1410248823-8975-4-git-send-email-jakub.tyszkowski@tieto.com>
In-Reply-To: <1410248823-8975-1-git-send-email-jakub.tyszkowski@tieto.com>
References: <1410248823-8975-1-git-send-email-jakub.tyszkowski@tieto.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hciemu hooks may be called in different test stage than we expect
and we shouldn't blindly verifying the step with success every time
when data is send, as we really dont know the step we are currently in.

This patch fixes this issue by splitting the action in two steps: action
step that triggers data sending and callback step that verifies on
remotes sid that data was send.
---
 android/tester-hidhost.c | 36 ++++++++++++++----------------------
 android/tester-main.h    |  3 +++
 2 files changed, 17 insertions(+), 22 deletions(-)

diff --git a/android/tester-hidhost.c b/android/tester-hidhost.c
index b454db4..dd378cc 100644
--- a/android/tester-hidhost.c
+++ b/android/tester-hidhost.c
@@ -230,10 +230,11 @@ static void hid_ctrl_cid_hook_cb(const void *data, uint16_t len,
 		/* Successfully verify sending data step */
 		step = g_new0(struct step, 1);
 
-		step->action_status = BT_STATUS_SUCCESS;
+		step->callback = CB_EMU_CONFIRM_SEND_DATA;
 
-		schedule_action_verification(step);
+		schedule_callback_verification(step);
 		break;
+
 	}
 }
 static void hid_ctrl_connect_cb(uint16_t handle, uint16_t cid, void *user_data)
@@ -259,9 +260,9 @@ static void hid_intr_cid_hook_cb(const void *data, uint16_t len,
 		/* Successfully verify sending data step */
 		step = g_new0(struct step, 1);
 
-		step->action_status = BT_STATUS_SUCCESS;
+		step->callback = CB_EMU_CONFIRM_SEND_DATA;
 
-		schedule_action_verification(step);
+		schedule_callback_verification(step);
 		break;
 	}
 }
@@ -390,40 +391,29 @@ static void hidhost_set_report_action(void)
 {
 	struct test_data *data = tester_get_data();
 	const uint8_t *hid_addr = hciemu_get_client_bdaddr(data->hciemu);
+	struct step *step = g_new0(struct step, 1);
 	char *buf = "fe0201";
 	bt_bdaddr_t bdaddr;
-	int status;
 
 	bdaddr2android((const bdaddr_t *) hid_addr, &bdaddr);
 
-	/* Successfull result should be verified on the other end (hook) */
-	status = data->if_hid->send_data(&bdaddr, buf);
-	if (status) {
-		struct step *step = g_new0(struct step, 1);
-
-		step->action_status = status;
-		schedule_action_verification(step);
-	}
+	step->action_status = data->if_hid->send_data(&bdaddr, buf);
+	schedule_action_verification(step);
 }
 
 static void hidhost_send_data_action(void)
 {
 	struct test_data *data = tester_get_data();
 	const uint8_t *hid_addr = hciemu_get_client_bdaddr(data->hciemu);
+	struct step *step = g_new0(struct step, 1);
 	char *buf = "010101";
 	bt_bdaddr_t bdaddr;
-	int status;
 
 	bdaddr2android((const bdaddr_t *) hid_addr, &bdaddr);
 
-	/* Successfull result should be verified on the other end (hook) */
-	status = data->if_hid->set_report(&bdaddr, BTHH_INPUT_REPORT, buf);
-	if (status) {
-		struct step *step = g_new0(struct step, 1);
-
-		step->action_status = status;
-		schedule_action_verification(step);
-	}
+	step->action_status = data->if_hid->set_report(&bdaddr,
+							BTHH_INPUT_REPORT, buf);
+	schedule_action_verification(step);
 }
 
 static struct test_case test_cases[] = {
@@ -554,6 +544,7 @@ static struct test_case test_cases[] = {
 		CALLBACK_STATE(CB_HH_CONNECTION_STATE,
 						BTHH_CONN_STATE_CONNECTED),
 		ACTION_SUCCESS(hidhost_set_report_action, NULL),
+		CALLBACK(CB_EMU_CONFIRM_SEND_DATA),
 	),
 	TEST_CASE_BREDRLE("HidHost SendData Success",
 		ACTION_SUCCESS(bluetooth_enable_action, NULL),
@@ -570,6 +561,7 @@ static struct test_case test_cases[] = {
 		CALLBACK_STATE(CB_HH_CONNECTION_STATE,
 						BTHH_CONN_STATE_CONNECTED),
 		ACTION_SUCCESS(hidhost_send_data_action, NULL),
+		CALLBACK(CB_EMU_CONFIRM_SEND_DATA),
 	),
 };
 
diff --git a/android/tester-main.h b/android/tester-main.h
index d40b995..9e579fc 100644
--- a/android/tester-main.h
+++ b/android/tester-main.h
@@ -306,6 +306,9 @@ typedef enum {
 	CB_GATTS_REQUEST_WRITE,
 	CB_GATTS_REQUEST_EXEC_WRITE,
 	CB_GATTS_RESPONSE_CONFIRMATION,
+
+	/* Emulator callbacks */
+	CB_EMU_CONFIRM_SEND_DATA,
 } expected_bt_callback_t;
 
 struct test_data {
-- 
1.9.1

