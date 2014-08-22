Return-Path: <cyrus@holtmann.org>
From: Jakub Tyszkowski <jakub.tyszkowski@tieto.com>
To: linux-bluetooth@vger.kernel.org
Cc: Jakub Tyszkowski <jakub.tyszkowski@tieto.com>
Subject: [PATCH 1/4] android/tester: Wait for ACL disconnection before reconnect
Date: Fri, 22 Aug 2014 14:40:46 +0200
Message-Id: <1408711249-6683-2-git-send-email-jakub.tyszkowski@tieto.com>
In-Reply-To: <1408711249-6683-1-git-send-email-jakub.tyszkowski@tieto.com>
References: <1408711249-6683-1-git-send-email-jakub.tyszkowski@tieto.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

We need the remote to drop its ACL before it tries to connect again.
---
 android/tester-gatt.c |  2 ++
 android/tester-main.c | 15 ++++++++++++++-
 2 files changed, 16 insertions(+), 1 deletion(-)

diff --git a/android/tester-gatt.c b/android/tester-gatt.c
index d69b027..0d99320 100644
--- a/android/tester-gatt.c
+++ b/android/tester-gatt.c
@@ -453,6 +453,8 @@ static struct test_case test_cases[] = {
 		CALLBACK_GATTC_DISCONNECT(GATT_STATUS_SUCCESS,
 						prop_emu_remotes_default_set,
 						CONN1_ID, CLIENT1_ID),
+		CALLBACK_STATE(CB_BT_ACL_STATE_CHANGED,
+						BT_ACL_STATE_DISCONNECTED),
 		ACTION_SUCCESS(gatt_client_do_listen_action, &client1_conn_req),
 		CALLBACK_STATUS(CB_GATTC_LISTEN, GATT_STATUS_SUCCESS),
 		ACTION_SUCCESS(emu_remote_connect_hci_action, NULL),
diff --git a/android/tester-main.c b/android/tester-main.c
index 5f41ff1..369a943 100644
--- a/android/tester-main.c
+++ b/android/tester-main.c
@@ -841,6 +841,19 @@ static void ssp_request_cb(bt_bdaddr_t *remote_bd_addr,
 	schedule_callback_call(step);
 }
 
+static void acl_state_changed_cb(bt_status_t status,
+					bt_bdaddr_t *remote_bd_addr,
+					bt_acl_state_t state) {
+	struct step *step = g_new0(struct step, 1);
+
+	step->callback = CB_BT_ACL_STATE_CHANGED;
+
+	step->callback_result.status = status;
+	step->callback_result.state = state;
+
+	schedule_callback_call(step);
+}
+
 static bt_callbacks_t bt_callbacks = {
 	.size = sizeof(bt_callbacks),
 	.adapter_state_changed_cb = adapter_state_changed_cb,
@@ -851,7 +864,7 @@ static bt_callbacks_t bt_callbacks = {
 	.pin_request_cb = pin_request_cb,
 	.ssp_request_cb = ssp_request_cb,
 	.bond_state_changed_cb = bond_state_changed_cb,
-	.acl_state_changed_cb = NULL,
+	.acl_state_changed_cb = acl_state_changed_cb,
 	.thread_evt_cb = NULL,
 	.dut_mode_recv_cb = NULL,
 	.le_test_mode_cb = NULL
-- 
1.9.1

