Return-Path: <cyrus@holtmann.org>
From: Lukasz Rymanowski <lukasz.rymanowski@tieto.com>
To: linux-bluetooth@vger.kernel.org
Cc: Lukasz Rymanowski <lukasz.rymanowski@tieto.com>
Subject: [PATCH 2/5] android/tester: Move emu related functions to tester main
Date: Tue, 26 Aug 2014 22:41:49 +0200
Message-Id: <1409085712-12402-2-git-send-email-lukasz.rymanowski@tieto.com>
In-Reply-To: <1409085712-12402-1-git-send-email-lukasz.rymanowski@tieto.com>
References: <1409085712-12402-1-git-send-email-lukasz.rymanowski@tieto.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Those function can be used by other tester modules

In addition function emu_remote_disconnect_hci_action has been changed a
bit so it take handle from step data now. It was needed as cid_data was
static in tester_gatt.c
---
 android/tester-gatt.c | 49 ++-----------------------------------------------
 android/tester-main.c | 51 +++++++++++++++++++++++++++++++++++++++++++++++++++
 android/tester-main.h |  3 +++
 3 files changed, 56 insertions(+), 47 deletions(-)

diff --git a/android/tester-gatt.c b/android/tester-gatt.c
index 1d66309..979a1de 100644
--- a/android/tester-gatt.c
+++ b/android/tester-gatt.c
@@ -253,52 +253,6 @@ static void gatt_conn_cb(uint16_t handle, void *user_data)
 								&cid_data);
 }
 
-static void emu_set_connect_cb_action(void)
-{
-	struct test_data *data = tester_get_data();
-	struct bthost *bthost = hciemu_client_get_host(data->hciemu);
-	struct step *current_data_step = queue_peek_head(data->steps);
-	void *cb = current_data_step->set_data;
-	struct step *step = g_new0(struct step, 1);
-
-	bthost_set_connect_cb(bthost, cb, data);
-
-	step->action_status = BT_STATUS_SUCCESS;
-
-	schedule_action_verification(step);
-}
-
-static void emu_remote_connect_hci_action(void)
-{
-	struct test_data *data = tester_get_data();
-	struct bthost *bthost = hciemu_client_get_host(data->hciemu);
-	struct step *step = g_new0(struct step, 1);
-	const uint8_t *master_addr;
-
-	master_addr = hciemu_get_master_bdaddr(data->hciemu);
-
-	tester_print("Trying to connect hci");
-
-	bthost_hci_connect(bthost, master_addr, BDADDR_LE_PUBLIC);
-
-	step->action_status = BT_STATUS_SUCCESS;
-
-	schedule_action_verification(step);
-}
-
-static void emu_remote_disconnect_hci_action(void)
-{
-	struct test_data *data = tester_get_data();
-	struct bthost *bthost = hciemu_client_get_host(data->hciemu);
-	struct step *step = g_new0(struct step, 1);
-
-	bthost_hci_disconnect(bthost, cid_data.handle, 0x13);
-
-	step->action_status = BT_STATUS_SUCCESS;
-
-	schedule_action_verification(step);
-}
-
 static struct test_case test_cases[] = {
 	TEST_CASE_BREDRLE("Gatt Init",
 		ACTION_SUCCESS(dummy_action, NULL),
@@ -467,7 +421,8 @@ static struct test_case test_cases[] = {
 						prop_emu_remotes_default_set,
 						CONN1_ID, CLIENT1_ID),
 		/* Close ACL on emulated remotes side so it can reconnect */
-		ACTION_SUCCESS(emu_remote_disconnect_hci_action, NULL),
+		ACTION_SUCCESS(emu_remote_disconnect_hci_action,
+							&cid_data.handle),
 		CALLBACK_STATE(CB_BT_ACL_STATE_CHANGED,
 						BT_ACL_STATE_DISCONNECTED),
 		ACTION_SUCCESS(gatt_client_do_listen_action, &client1_conn_req),
diff --git a/android/tester-main.c b/android/tester-main.c
index 369a943..c41ce1c 100644
--- a/android/tester-main.c
+++ b/android/tester-main.c
@@ -1608,6 +1608,57 @@ void emu_set_ssp_mode_action(void)
 	schedule_action_verification(step);
 }
 
+void emu_set_connect_cb_action(void)
+{
+	struct test_data *data = tester_get_data();
+	struct bthost *bthost = hciemu_client_get_host(data->hciemu);
+	struct step *current_data_step = queue_peek_head(data->steps);
+	void *cb = current_data_step->set_data;
+	struct step *step = g_new0(struct step, 1);
+
+	bthost_set_connect_cb(bthost, cb, data);
+
+	step->action_status = BT_STATUS_SUCCESS;
+
+	schedule_action_verification(step);
+}
+
+void emu_remote_connect_hci_action(void)
+{
+	struct test_data *data = tester_get_data();
+	struct bthost *bthost = hciemu_client_get_host(data->hciemu);
+	struct step *step = g_new0(struct step, 1);
+	const uint8_t *master_addr;
+
+	master_addr = hciemu_get_master_bdaddr(data->hciemu);
+
+	tester_print("Trying to connect hci");
+
+	bthost_hci_connect(bthost, master_addr, BDADDR_LE_PUBLIC);
+
+	step->action_status = BT_STATUS_SUCCESS;
+
+	schedule_action_verification(step);
+}
+
+void emu_remote_disconnect_hci_action(void)
+{
+	struct test_data *data = tester_get_data();
+	struct bthost *bthost = hciemu_client_get_host(data->hciemu);
+	struct step *current_data_step = queue_peek_head(data->steps);
+	uint16_t *handle = current_data_step->set_data;
+	struct step *step = g_new0(struct step, 1);
+
+	if (handle) {
+		bthost_hci_disconnect(bthost, *handle, 0x13);
+		step->action_status = BT_STATUS_SUCCESS;
+	} else {
+		step->action_status = BT_STATUS_FAIL;
+	}
+
+	schedule_action_verification(step);
+}
+
 void emu_add_l2cap_server_action(void)
 {
 	struct test_data *data = tester_get_data();
diff --git a/android/tester-main.h b/android/tester-main.h
index ad87878..3331e91 100644
--- a/android/tester-main.h
+++ b/android/tester-main.h
@@ -430,6 +430,9 @@ void schedule_action_verification(struct step *step);
 void emu_setup_powered_remote_action(void);
 void emu_set_pin_code_action(void);
 void emu_set_ssp_mode_action(void);
+void emu_set_connect_cb_action(void);
+void emu_remote_connect_hci_action(void);
+void emu_remote_disconnect_hci_action(void);
 void emu_add_l2cap_server_action(void);
 void emu_add_rfcomm_server_action(void);
 
-- 
1.8.4

