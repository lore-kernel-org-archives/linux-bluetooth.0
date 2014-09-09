Return-Path: <cyrus@holtmann.org>
From: Jakub Tyszkowski <jakub.tyszkowski@tieto.com>
To: linux-bluetooth@vger.kernel.org
Cc: Jakub Tyszkowski <jakub.tyszkowski@tieto.com>
Subject: [PATCHv3 4/7] android/tester: Add encryption change verification mechanism
Date: Tue,  9 Sep 2014 09:47:00 +0200
Message-Id: <1410248823-8975-5-git-send-email-jakub.tyszkowski@tieto.com>
In-Reply-To: <1410248823-8975-1-git-send-email-jakub.tyszkowski@tieto.com>
References: <1410248823-8975-1-git-send-email-jakub.tyszkowski@tieto.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Use callback mechanism for encryption verification
---
 android/tester-main.c | 25 +++++++++++++++++++++++++
 android/tester-main.h |  2 ++
 2 files changed, 27 insertions(+)

diff --git a/android/tester-main.c b/android/tester-main.c
index 0505a59..efe5bbb 100644
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
+	struct step *step = g_new0(struct step, 1);
+
+	/*
+	 * Expected data: header (4 octets) + conn. handle (2 octets) +
+	 * encryption flag (1 octet)
+	 */
+	if (len < sizeof(hci_encr_change_hdr) + 3)
+		return true;
+
+	step->callback = ((uint8_t *)data)[6] ? CB_EMU_ENCRYPTION_ENABLED :
+						CB_EMU_ENCRYPTION_DISABLED;
+
+	schedule_callback_verification(step);
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
 
diff --git a/android/tester-main.h b/android/tester-main.h
index 9e579fc..c6c76d9 100644
--- a/android/tester-main.h
+++ b/android/tester-main.h
@@ -309,6 +309,8 @@ typedef enum {
 
 	/* Emulator callbacks */
 	CB_EMU_CONFIRM_SEND_DATA,
+	CB_EMU_ENCRYPTION_ENABLED,
+	CB_EMU_ENCRYPTION_DISABLED,
 } expected_bt_callback_t;
 
 struct test_data {
-- 
1.9.1

