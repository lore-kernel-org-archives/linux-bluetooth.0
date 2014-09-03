Return-Path: <cyrus@holtmann.org>
From: Jakub Tyszkowski <jakub.tyszkowski@tieto.com>
To: linux-bluetooth@vger.kernel.org
Cc: Jakub Tyszkowski <jakub.tyszkowski@tieto.com>
Subject: [PATCH 7/8] android/tester: Add support for rejected connections
Date: Wed,  3 Sep 2014 11:02:48 +0200
Message-Id: <1409734969-10716-7-git-send-email-jakub.tyszkowski@tieto.com>
In-Reply-To: <1409734969-10716-1-git-send-email-jakub.tyszkowski@tieto.com>
References: <1409734969-10716-1-git-send-email-jakub.tyszkowski@tieto.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

If we want the connection to be rejected, this can be notified to a
device in various ways. HIDHost for example expects virtual cable
unplug. This patch adds action for triggering rejected  reject
connections, which requires custom verification on remotes side.
Hid host will verify it by listenning on the ctrl channel for virtual
cable unplug.
---
 android/tester-main.c | 18 +++++++++++++++---
 android/tester-main.h |  2 ++
 2 files changed, 17 insertions(+), 3 deletions(-)

diff --git a/android/tester-main.c b/android/tester-main.c
index 5266a08..edd4c38 100644
--- a/android/tester-main.c
+++ b/android/tester-main.c
@@ -1734,17 +1734,18 @@ void emu_set_connect_cb_action(void)
 	schedule_action_verification(step);
 }
 
-void emu_remote_connect_hci_action(void)
+void emu_remote_connect_hci_rejected_action(void)
 {
 	struct test_data *data = tester_get_data();
 	struct bthost *bthost = hciemu_client_get_host(data->hciemu);
 	struct step *current_data_step = queue_peek_head(data->steps);
 	struct bt_action_data *action_data = current_data_step->set_data;
-	struct step *step = g_new0(struct step, 1);
 	const uint8_t *master_addr;
 
 	master_addr = hciemu_get_master_bdaddr(data->hciemu);
 
+	data->expect_rejection = true;
+
 	tester_print("Trying to connect hci");
 
 	if (action_data)
@@ -1753,8 +1754,19 @@ void emu_remote_connect_hci_action(void)
 	else
 		bthost_hci_connect(bthost, master_addr, BDADDR_BREDR);
 
-	step->action_status = BT_STATUS_SUCCESS;
+	/*
+	 * This needs custom action verification. For example Hidhost waits
+	 * for virtual cable unplug message on the ctrl channel to verify this.
+	 */
+}
 
+void emu_remote_connect_hci_action(void)
+{
+	struct step *step = g_new0(struct step, 1);
+
+	emu_remote_connect_hci_rejected_action();
+
+	step->action_status = BT_STATUS_SUCCESS;
 	schedule_action_verification(step);
 }
 
diff --git a/android/tester-main.h b/android/tester-main.h
index f3cfcb2..4228bf1 100644
--- a/android/tester-main.h
+++ b/android/tester-main.h
@@ -348,6 +348,7 @@ struct test_data {
 
 	struct queue *pdus;
 	bool is_encrypted;
+	bool expect_rejection;
 
 	uint16_t sdp_call_cnt;
 };
@@ -474,6 +475,7 @@ void schedule_action_verification(struct step *step);
 void emu_setup_powered_remote_action(void);
 void emu_set_pin_code_action(void);
 void emu_set_connect_cb_action(void);
+void emu_remote_connect_hci_rejected_action(void);
 void emu_remote_connect_hci_action(void);
 void emu_remote_disconnect_hci_action(void);
 void emu_set_io_cap(void);
-- 
1.9.1

