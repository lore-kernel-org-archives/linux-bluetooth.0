Return-Path: <cyrus@holtmann.org>
From: Jakub Tyszkowski <jakub.tyszkowski@tieto.com>
To: linux-bluetooth@vger.kernel.org
Cc: Jakub Tyszkowski <jakub.tyszkowski@tieto.com>
Subject: [PATCH 3/5] android/tester: Add encryption change callback
Date: Fri,  3 Oct 2014 15:08:41 +0200
Message-Id: <1412341723-8415-3-git-send-email-jakub.tyszkowski@tieto.com>
In-Reply-To: <1412341723-8415-1-git-send-email-jakub.tyszkowski@tieto.com>
References: <1412341723-8415-1-git-send-email-jakub.tyszkowski@tieto.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

This is needed for  encryption verification.
---
 android/tester-main.c | 25 +++++++++++++++++++++++++
 android/tester-main.h |  2 ++
 2 files changed, 27 insertions(+)

diff --git a/android/tester-main.c b/android/tester-main.c
index c637fd5..d5ebe16 100644
--- a/android/tester-main.c
+++ b/android/tester-main.c
@@ -104,6 +104,8 @@ static struct {
 
 	/* Emulator callbacks */
 	DBG_CB(CB_EMU_CONFIRM_SEND_DATA),
+	DBG_CB(CB_EMU_ENCRYPTION_ENABLED),
+	DBG_CB(CB_EMU_ENCRYPTION_DISABLED),
 };
 
 static gboolean check_callbacks_called(gpointer user_data)
@@ -291,6 +293,25 @@ static void mgmt_debug(const char *str, void *user_data)
 	tester_print("%s%s", prefix, str);
 }
 
+static bool hciemu_post_encr_hook(const void *data, uint16_t len,
+							void *user_data)
+{
+	struct step *step = g_new0(struct step, 1);
+
+	/*
+	 * Expected data: status (1 octet) + conn. handle (2 octets) +
+	 * encryption flag (1 octet)
+	 */
+	if (len < 4)
+		return true;
+
+	step->callback = ((uint8_t *)data)[3] ? CB_EMU_ENCRYPTION_ENABLED :
+						CB_EMU_ENCRYPTION_DISABLED;
+
+	schedule_callback_verification(step);
+	return true;
+}
+
 static void read_info_callback(uint8_t status, uint16_t length,
 					const void *param, void *user_data)
 {
@@ -328,6 +349,10 @@ static void read_info_callback(uint8_t status, uint16_t length,
 		return;
 	}
 
+	/* set hook for encryption change */
+	hciemu_add_hook(data->hciemu, HCIEMU_HOOK_POST_EVT, 0x08,
+						hciemu_post_encr_hook, NULL);
+
 	tester_pre_setup_complete();
 }
 
diff --git a/android/tester-main.h b/android/tester-main.h
index 6245381..e96ad24 100644
--- a/android/tester-main.h
+++ b/android/tester-main.h
@@ -400,6 +400,8 @@ typedef enum {
 
 	/* Emulator callbacks */
 	CB_EMU_CONFIRM_SEND_DATA,
+	CB_EMU_ENCRYPTION_ENABLED,
+	CB_EMU_ENCRYPTION_DISABLED,
 } expected_bt_callback_t;
 
 struct test_data {
-- 
1.9.1

