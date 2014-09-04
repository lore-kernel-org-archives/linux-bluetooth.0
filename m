Return-Path: <cyrus@holtmann.org>
From: Jakub Tyszkowski <jakub.tyszkowski@tieto.com>
To: linux-bluetooth@vger.kernel.org
Cc: Jakub Tyszkowski <jakub.tyszkowski@tieto.com>
Subject: [PATCHv2 2/6] android/tester: Add action to verify encryption change
Date: Thu,  4 Sep 2014 14:54:57 +0200
Message-Id: <1409835301-12092-3-git-send-email-jakub.tyszkowski@tieto.com>
In-Reply-To: <1409835301-12092-1-git-send-email-jakub.tyszkowski@tieto.com>
References: <1409835301-12092-1-git-send-email-jakub.tyszkowski@tieto.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

When encryption change is verified, encryption flag is cleared so we can
detect another encryption change when device reconnects during execution
of another step in the same test case.
---
 android/tester-main.c | 38 ++++++++++++++++++++++++++++++++++++++
 android/tester-main.h |  2 ++
 2 files changed, 40 insertions(+)

diff --git a/android/tester-main.c b/android/tester-main.c
index f5f46fb..50aa12b 100644
--- a/android/tester-main.c
+++ b/android/tester-main.c
@@ -28,6 +28,8 @@ static gint scheduled_cbacks_num;
 #define EMULATOR_SIGNAL_TIMEOUT 2 /* in seconds */
 #define EMULATOR_SIGNAL "emulator_started"
 
+static const uint8_t hci_encr_change_hdr[] = { 0x04, 0x08, 0x04, 0x00 };
+
 static gboolean check_callbacks_called(gpointer user_data)
 {
 	/*
@@ -213,6 +215,25 @@ static void mgmt_debug(const char *str, void *user_data)
 	tester_print("%s%s", prefix, str);
 }
 
+static bool hciemu_post_encr_hook(const void *data, uint16_t len,
+							void *user_data)
+{
+	struct test_data *t_data = tester_get_data();
+
+	/*
+	 * Expected data: header (4 octets) + conn. handle (2 octets) +
+	 * encryption flag (1 octet)
+	 */
+	if (len < sizeof(hci_encr_change_hdr) + 3)
+		return true;
+
+	/* Verify header, skip conn. handle and check encryption */
+	if (!memcmp(hci_encr_change_hdr, data, sizeof(hci_encr_change_hdr)))
+		t_data->is_encrypted = ((uint8_t *)data)[6] ? true : false;
+
+	return true;
+}
+
 static void read_info_callback(uint8_t status, uint16_t length,
 					const void *param, void *user_data)
 {
@@ -250,6 +271,10 @@ static void read_info_callback(uint8_t status, uint16_t length,
 		return;
 	}
 
+	/* set hook for encryption change */
+	hciemu_add_hook(data->hciemu, HCIEMU_HOOK_POST_EVT, 0x08,
+						hciemu_post_encr_hook, NULL);
+
 	tester_pre_setup_complete();
 }
 
@@ -1804,6 +1829,19 @@ void emu_add_l2cap_server_action(void)
 	schedule_action_verification(step);
 }
 
+void bt_verify_encryption_action(void)
+{
+	struct test_data *data = tester_get_data();
+	struct step *step = g_new0(struct step, 1);
+
+	step->action_status = data->is_encrypted ? BT_STATUS_SUCCESS :
+								BT_STATUS_FAIL;
+
+	data->is_encrypted = false;
+
+	schedule_action_verification(step);
+}
+
 static void rfcomm_connect_cb(uint16_t handle, uint16_t cid, void *user_data,
 								bool status)
 {
diff --git a/android/tester-main.h b/android/tester-main.h
index 46aacce..cb8300d 100644
--- a/android/tester-main.h
+++ b/android/tester-main.h
@@ -331,6 +331,7 @@ struct test_data {
 	pid_t bluetoothd_pid;
 
 	struct queue *pdus;
+	bool is_encrypted;
 };
 
 /*
@@ -477,3 +478,4 @@ void bt_ssp_reply_accept_action(void);
 void bt_cancel_bond_action(void);
 void bt_remove_bond_action(void);
 void set_default_ssp_request_handler(void);
+void bt_verify_encryption_action(void);
-- 
1.9.1

