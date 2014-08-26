Return-Path: <cyrus@holtmann.org>
From: Lukasz Rymanowski <lukasz.rymanowski@tieto.com>
To: linux-bluetooth@vger.kernel.org
Cc: Lukasz Rymanowski <lukasz.rymanowski@tieto.com>
Subject: [PATCH 4/5] android/tester: Add function to set io cap to bthost
Date: Tue, 26 Aug 2014 22:41:51 +0200
Message-Id: <1409085712-12402-4-git-send-email-lukasz.rymanowski@tieto.com>
In-Reply-To: <1409085712-12402-1-git-send-email-lukasz.rymanowski@tieto.com>
References: <1409085712-12402-1-git-send-email-lukasz.rymanowski@tieto.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Some tests might need to change default io capabilities of bthost.
This patch adds means to do it.
---
 android/tester-main.c | 20 ++++++++++++++++++++
 android/tester-main.h |  2 ++
 2 files changed, 22 insertions(+)

diff --git a/android/tester-main.c b/android/tester-main.c
index 310efb0..a001059 100644
--- a/android/tester-main.c
+++ b/android/tester-main.c
@@ -1665,6 +1665,26 @@ void emu_remote_disconnect_hci_action(void)
 	schedule_action_verification(step);
 }
 
+void emu_set_io_cap(void)
+{
+	struct test_data *data = tester_get_data();
+	struct bthost *bthost;
+	struct step *current_data_step = queue_peek_head(data->steps);
+	struct bt_action_data *action_data = current_data_step->set_data;
+	struct step *step = g_new0(struct step, 1);
+
+	bthost = hciemu_client_get_host(data->hciemu);
+
+	if (action_data)
+		bthost_set_io_capability(bthost, action_data->io_cap);
+	else
+		bthost_set_io_capability(bthost, 0x01);
+
+	step->action_status = BT_STATUS_SUCCESS;
+
+	schedule_action_verification(step);
+}
+
 void emu_add_l2cap_server_action(void)
 {
 	struct test_data *data = tester_get_data();
diff --git a/android/tester-main.h b/android/tester-main.h
index e83933a..77f7660 100644
--- a/android/tester-main.h
+++ b/android/tester-main.h
@@ -332,6 +332,7 @@ struct bt_action_data {
 	const uint8_t pin_len;
 	const uint8_t ssp_variant;
 	const bool accept;
+	const uint16_t io_cap;
 
 	/* Socket HAL specific params */
 	const btsock_type_t sock_type;
@@ -436,6 +437,7 @@ void emu_set_ssp_mode_action(void);
 void emu_set_connect_cb_action(void);
 void emu_remote_connect_hci_action(void);
 void emu_remote_disconnect_hci_action(void);
+void emu_set_io_cap(void);
 void emu_add_l2cap_server_action(void);
 void emu_add_rfcomm_server_action(void);
 
-- 
1.8.4

