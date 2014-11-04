Return-Path: <cyrus@holtmann.org>
From: Andrei Emeltchenko <Andrei.Emeltchenko.news@gmail.com>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCHv1 32/47] android/handsfree: Add support for new API for handle_answer
Date: Tue,  4 Nov 2014 10:18:55 +0200
Message-Id: <1415089150-18798-33-git-send-email-Andrei.Emeltchenko.news@gmail.com>
In-Reply-To: <1415089150-18798-1-git-send-email-Andrei.Emeltchenko.news@gmail.com>
References: <1415089150-18798-1-git-send-email-Andrei.Emeltchenko.news@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

From: Andrei Emeltchenko <andrei.emeltchenko@intel.com>

Answer Call Command notification callback has new parameter bdaddr.
Currently use global device bdaddr.
---
 android/hal-handsfree.c | 9 ++++++++-
 android/hal-ipc-api.txt | 2 +-
 android/hal-msg.h       | 3 +++
 android/handsfree.c     | 5 ++++-
 4 files changed, 16 insertions(+), 3 deletions(-)

diff --git a/android/hal-handsfree.c b/android/hal-handsfree.c
index 88636a3..01663ec 100644
--- a/android/hal-handsfree.c
+++ b/android/hal-handsfree.c
@@ -67,8 +67,15 @@ static void handle_vr_state(void *buf, uint16_t len, int fd)
 
 static void handle_answer(void *buf, uint16_t len, int fd)
 {
-	if (cbs->answer_call_cmd_cb)
+	if (cbs->answer_call_cmd_cb) {
+#if ANDROID_VERSION > PLATFORM_VER(4, 4, 4)
+		struct hal_ev_handsfree_answer *ev = buf;
+
+		cbs->answer_call_cmd_cb((bt_bdaddr_t *) (ev->bdaddr));
+#else
 		cbs->answer_call_cmd_cb();
+#endif
+	}
 }
 
 static void handle_hangup(void *buf, uint16_t len, int fd)
diff --git a/android/hal-ipc-api.txt b/android/hal-ipc-api.txt
index cabf32d..cfde814 100644
--- a/android/hal-ipc-api.txt
+++ b/android/hal-ipc-api.txt
@@ -1015,7 +1015,7 @@ Notifications:
 
 	Opcode 0x84 - Answer Call Command notification
 
-		Notification parameters: <none>
+		Notification parameters: Remote address (6 octets)
 
 	Opcode 0x85 - Hangup Call Command notification
 
diff --git a/android/hal-msg.h b/android/hal-msg.h
index 4ea30dac..195e26c 100644
--- a/android/hal-msg.h
+++ b/android/hal-msg.h
@@ -1350,6 +1350,9 @@ struct hal_ev_handsfree_vr_state {
 } __attribute__((packed));
 
 #define HAL_EV_HANDSFREE_ANSWER		0x84
+struct hal_ev_handsfree_answer {
+	uint8_t bdaddr[6];
+} __attribute__((packed));
 
 #define HAL_EV_HANDSFREE_HANGUP		0x85
 
diff --git a/android/handsfree.c b/android/handsfree.c
index 99057b0..26d01bb 100644
--- a/android/handsfree.c
+++ b/android/handsfree.c
@@ -493,6 +493,7 @@ static void at_cmd_a(struct hfp_gw_result *result, enum hfp_gw_cmd_type type,
 								void *user_data)
 {
 	struct hf_device *dev = user_data;
+	struct hal_ev_handsfree_answer ev;
 
 	DBG("");
 
@@ -501,8 +502,10 @@ static void at_cmd_a(struct hfp_gw_result *result, enum hfp_gw_cmd_type type,
 		if (hfp_gw_result_has_next(result))
 			break;
 
+		bdaddr2android(&dev->bdaddr, ev.bdaddr);
+
 		ipc_send_notif(hal_ipc, HAL_SERVICE_ID_HANDSFREE,
-					HAL_EV_HANDSFREE_ANSWER, 0, NULL);
+				HAL_EV_HANDSFREE_ANSWER, sizeof(ev), &ev);
 
 		/* Framework is not replying with result for ATA */
 		hfp_gw_send_result(dev->gw, HFP_RESULT_OK);
-- 
1.9.1

