Return-Path: <cyrus@holtmann.org>
From: Jakub Tyszkowski <jakub.tyszkowski@tieto.com>
To: linux-bluetooth@vger.kernel.org
Cc: Jakub Tyszkowski <jakub.tyszkowski@tieto.com>
Subject: [PATCH 2/5] android/tester: Improve HIDHost data sending verification
Date: Fri,  3 Oct 2014 15:08:40 +0200
Message-Id: <1412341723-8415-2-git-send-email-jakub.tyszkowski@tieto.com>
In-Reply-To: <1412341723-8415-1-git-send-email-jakub.tyszkowski@tieto.com>
References: <1412341723-8415-1-git-send-email-jakub.tyszkowski@tieto.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hciemu hooks may be called in different test stage than we expect
and we shouldn't blindly verifying the step with success every time
when data is send, as we really dont know the step we are currently in.

This patch fixes this issue by splitting the action in two steps: action
step that triggers data sending and callback step that verifies on
remotes sid that data was send.
---
 android/tester-hidhost.c | 35 +++++++++++++----------------------
 android/tester-main.c    |  3 +++
 android/tester-main.h    |  3 +++
 3 files changed, 19 insertions(+), 22 deletions(-)

diff --git a/android/tester-hidhost.c b/android/tester-hidhost.c
index 8da5d32..be840b0 100644
--- a/android/tester-hidhost.c
+++ b/android/tester-hidhost.c
@@ -183,9 +183,9 @@ static void hid_ctrl_cid_hook_cb(const void *data, uint16_t len,
 		/* Successfully verify sending data step */
 		step = g_new0(struct step, 1);
 
-		step->action_status = BT_STATUS_SUCCESS;
+		step->callback = CB_EMU_CONFIRM_SEND_DATA;
 
-		schedule_action_verification(step);
+		schedule_callback_verification(step);
 		break;
 	}
 }
@@ -213,9 +213,9 @@ static void hid_intr_cid_hook_cb(const void *data, uint16_t len,
 		/* Successfully verify sending data step */
 		step = g_new0(struct step, 1);
 
-		step->action_status = BT_STATUS_SUCCESS;
+		step->callback = CB_EMU_CONFIRM_SEND_DATA;
 
-		schedule_action_verification(step);
+		schedule_callback_verification(step);
 		break;
 	}
 }
@@ -345,40 +345,29 @@ static void hidhost_set_report_action(void)
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
@@ -509,6 +498,7 @@ static struct test_case test_cases[] = {
 		CALLBACK_STATE(CB_HH_CONNECTION_STATE,
 						BTHH_CONN_STATE_CONNECTED),
 		ACTION_SUCCESS(hidhost_set_report_action, NULL),
+		CALLBACK(CB_EMU_CONFIRM_SEND_DATA),
 	),
 	TEST_CASE_BREDRLE("HidHost SendData Success",
 		ACTION_SUCCESS(bluetooth_enable_action, NULL),
@@ -525,6 +515,7 @@ static struct test_case test_cases[] = {
 		CALLBACK_STATE(CB_HH_CONNECTION_STATE,
 						BTHH_CONN_STATE_CONNECTED),
 		ACTION_SUCCESS(hidhost_send_data_action, NULL),
+		CALLBACK(CB_EMU_CONFIRM_SEND_DATA),
 	),
 };
 
diff --git a/android/tester-main.c b/android/tester-main.c
index 5d66fe1..c637fd5 100644
--- a/android/tester-main.c
+++ b/android/tester-main.c
@@ -101,6 +101,9 @@ static struct {
 	DBG_CB(CB_GATTS_REQUEST_WRITE),
 	DBG_CB(CB_GATTS_REQUEST_EXEC_WRITE),
 	DBG_CB(CB_GATTS_RESPONSE_CONFIRMATION),
+
+	/* Emulator callbacks */
+	DBG_CB(CB_EMU_CONFIRM_SEND_DATA),
 };
 
 static gboolean check_callbacks_called(gpointer user_data)
diff --git a/android/tester-main.h b/android/tester-main.h
index 3e5c27d..6245381 100644
--- a/android/tester-main.h
+++ b/android/tester-main.h
@@ -397,6 +397,9 @@ typedef enum {
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

