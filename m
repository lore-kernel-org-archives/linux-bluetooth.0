Return-Path: <cyrus@holtmann.org>
From: Jakub Tyszkowski <jakub.tyszkowski@tieto.com>
To: linux-bluetooth@vger.kernel.org
Cc: Jakub Tyszkowski <jakub.tyszkowski@tieto.com>
Subject: [PATCHv2 5/6] android/tester: Add support for rejected connections
Date: Thu,  4 Sep 2014 14:55:00 +0200
Message-Id: <1409835301-12092-6-git-send-email-jakub.tyszkowski@tieto.com>
In-Reply-To: <1409835301-12092-1-git-send-email-jakub.tyszkowski@tieto.com>
References: <1409835301-12092-1-git-send-email-jakub.tyszkowski@tieto.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

If we want the connection to be rejected, this can be notified to
remote in various ways. HIDHost expects virtual cable unplug.
This patch adds tester action for triggering connection, which requires
custom verification on remotes side. Hid host will verify it by
listenning on the ctrl channel for virtual cable unplug.
---
 android/tester-main.c | 26 +++++++++++++++++++++++---
 android/tester-main.h |  2 ++
 2 files changed, 25 insertions(+), 3 deletions(-)

diff --git a/android/tester-main.c b/android/tester-main.c
index 50aa12b..8ee472b 100644
--- a/android/tester-main.c
+++ b/android/tester-main.c
@@ -1744,13 +1744,12 @@ void emu_set_connect_cb_action(void)
 	schedule_action_verification(step);
 }
 
-void emu_remote_connect_hci_action(void)
+static void emu_remote_connect_hci_no_verify_action(void)
 {
 	struct test_data *data = tester_get_data();
 	struct bthost *bthost = hciemu_client_get_host(data->hciemu);
 	struct step *current_data_step = queue_peek_head(data->steps);
 	struct bt_action_data *action_data = current_data_step->set_data;
-	struct step *step = g_new0(struct step, 1);
 	const uint8_t *master_addr;
 
 	master_addr = hciemu_get_master_bdaddr(data->hciemu);
@@ -1763,8 +1762,29 @@ void emu_remote_connect_hci_action(void)
 	else
 		bthost_hci_connect(bthost, master_addr, BDADDR_BREDR);
 
-	step->action_status = BT_STATUS_SUCCESS;
+	/* This needs custom action verification */
+}
+
+void emu_remote_connect_hci_rejected_action(void)
+{
+	struct test_data *data = tester_get_data();
+
+	data->expect_rejection = true;
+	emu_remote_connect_hci_no_verify_action();
+
+	/*
+	 * To verify that remote's connection was rejected is to
+	 * check it on remotes side.
+	 */
+}
 
+void emu_remote_connect_hci_action(void)
+{
+	struct step *step = g_new0(struct step, 1);
+
+	emu_remote_connect_hci_no_verify_action();
+
+	step->action_status = BT_STATUS_SUCCESS;
 	schedule_action_verification(step);
 }
 
diff --git a/android/tester-main.h b/android/tester-main.h
index 5fa4649..885f08c 100644
--- a/android/tester-main.h
+++ b/android/tester-main.h
@@ -332,6 +332,7 @@ struct test_data {
 
 	struct queue *pdus;
 	bool is_encrypted;
+	bool expect_rejection;
 
 	uint16_t sdp_call_cnt;
 };
@@ -457,6 +458,7 @@ void emu_setup_powered_remote_action(void);
 void emu_set_pin_code_action(void);
 void emu_set_ssp_mode_action(void);
 void emu_set_connect_cb_action(void);
+void emu_remote_connect_hci_rejected_action(void);
 void emu_remote_connect_hci_action(void);
 void emu_remote_disconnect_hci_action(void);
 void emu_set_io_cap(void);
-- 
1.9.1

