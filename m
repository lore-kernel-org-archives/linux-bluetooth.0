Return-Path: <cyrus@holtmann.org>
From: Jakub Tyszkowski <jakub.tyszkowski@tieto.com>
To: linux-bluetooth@vger.kernel.org
Cc: Marcin Kraglak <marcin.kraglak@tieto.com>
Subject: [PATCH 3/4] android/tester: Force remotes ACL disconnection
Date: Fri, 22 Aug 2014 14:40:48 +0200
Message-Id: <1408711249-6683-4-git-send-email-jakub.tyszkowski@tieto.com>
In-Reply-To: <1408711249-6683-1-git-send-email-jakub.tyszkowski@tieto.com>
References: <1408711249-6683-1-git-send-email-jakub.tyszkowski@tieto.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

From: Marcin Kraglak <marcin.kraglak@tieto.com>

This is needed or else we would need to extend the timeout for a single
test case in tester framework and wait two more seconds for ACL to disconnect.
---
 android/tester-gatt.c | 15 +++++++++++++++
 1 file changed, 15 insertions(+)

diff --git a/android/tester-gatt.c b/android/tester-gatt.c
index 0d99320..1d66309 100644
--- a/android/tester-gatt.c
+++ b/android/tester-gatt.c
@@ -286,6 +286,19 @@ static void emu_remote_connect_hci_action(void)
 	schedule_action_verification(step);
 }
 
+static void emu_remote_disconnect_hci_action(void)
+{
+	struct test_data *data = tester_get_data();
+	struct bthost *bthost = hciemu_client_get_host(data->hciemu);
+	struct step *step = g_new0(struct step, 1);
+
+	bthost_hci_disconnect(bthost, cid_data.handle, 0x13);
+
+	step->action_status = BT_STATUS_SUCCESS;
+
+	schedule_action_verification(step);
+}
+
 static struct test_case test_cases[] = {
 	TEST_CASE_BREDRLE("Gatt Init",
 		ACTION_SUCCESS(dummy_action, NULL),
@@ -453,6 +466,8 @@ static struct test_case test_cases[] = {
 		CALLBACK_GATTC_DISCONNECT(GATT_STATUS_SUCCESS,
 						prop_emu_remotes_default_set,
 						CONN1_ID, CLIENT1_ID),
+		/* Close ACL on emulated remotes side so it can reconnect */
+		ACTION_SUCCESS(emu_remote_disconnect_hci_action, NULL),
 		CALLBACK_STATE(CB_BT_ACL_STATE_CHANGED,
 						BT_ACL_STATE_DISCONNECTED),
 		ACTION_SUCCESS(gatt_client_do_listen_action, &client1_conn_req),
-- 
1.9.1

