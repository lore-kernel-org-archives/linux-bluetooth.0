Return-Path: <cyrus@holtmann.org>
From: Andrei Emeltchenko <Andrei.Emeltchenko.news@gmail.com>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCHv1 44/47] android/handsfree: Add support for new API for key_pressed_cmd_cb
Date: Tue,  4 Nov 2014 10:19:07 +0200
Message-Id: <1415089150-18798-45-git-send-email-Andrei.Emeltchenko.news@gmail.com>
In-Reply-To: <1415089150-18798-1-git-send-email-Andrei.Emeltchenko.news@gmail.com>
References: <1415089150-18798-1-git-send-email-Andrei.Emeltchenko.news@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

From: Andrei Emeltchenko <andrei.emeltchenko@intel.com>

Key Pressed Command notification callback has new parameter bdaddr.
---
 android/hal-handsfree.c | 9 ++++++++-
 android/hal-ipc-api.txt | 2 +-
 android/hal-msg.h       | 3 +++
 android/handsfree.c     | 6 +++++-
 4 files changed, 17 insertions(+), 3 deletions(-)

diff --git a/android/hal-handsfree.c b/android/hal-handsfree.c
index 55021c5..b072af7 100644
--- a/android/hal-handsfree.c
+++ b/android/hal-handsfree.c
@@ -238,8 +238,15 @@ static void handle_unknown_at(void *buf, uint16_t len, int fd)
 
 static void handle_hsp_key_press(void *buf, uint16_t len, int fd)
 {
-	if (cbs->key_pressed_cmd_cb)
+	if (cbs->key_pressed_cmd_cb) {
+#if ANDROID_VERSION > PLATFORM_VER(4, 4, 4)
+		struct hal_ev_handsfree_hsp_key_press *ev = buf;
+
+		cbs->key_pressed_cmd_cb((bt_bdaddr_t *) (ev->bdaddr));
+#else
 		cbs->key_pressed_cmd_cb();
+#endif
+	}
 }
 
 /*
diff --git a/android/hal-ipc-api.txt b/android/hal-ipc-api.txt
index 02bddb8..15cdfca 100644
--- a/android/hal-ipc-api.txt
+++ b/android/hal-ipc-api.txt
@@ -1081,7 +1081,7 @@ Notifications:
 
 	Opcode 0x90 - Key Pressed Command notification
 
-		Notification parameters: <none>
+		Notification parameters: Remote address (6 octets)
 
 
 Bluetooth Advanced Audio HAL (ID 6)
diff --git a/android/hal-msg.h b/android/hal-msg.h
index f86e6b7..eef226e 100644
--- a/android/hal-msg.h
+++ b/android/hal-msg.h
@@ -1427,6 +1427,9 @@ struct hal_ev_handsfree_unknown_at {
 } __attribute__((packed));
 
 #define HAL_EV_HANDSFREE_HSP_KEY_PRESS	0x90
+struct hal_ev_handsfree_hsp_key_press {
+	uint8_t bdaddr[6];
+} __attribute__((packed));
 
 #define HAL_AVRCP_FEATURE_NONE			0x00
 #define HAL_AVRCP_FEATURE_METADATA		0x01
diff --git a/android/handsfree.c b/android/handsfree.c
index 1862178..358e368 100644
--- a/android/handsfree.c
+++ b/android/handsfree.c
@@ -1143,6 +1143,7 @@ static void at_cmd_ckpd(struct hfp_gw_result *result, enum hfp_gw_cmd_type type,
 								void *user_data)
 {
 	struct hf_device *dev = user_data;
+	struct hal_ev_handsfree_hsp_key_press ev;
 	unsigned int val;
 
 	DBG("");
@@ -1155,8 +1156,11 @@ static void at_cmd_ckpd(struct hfp_gw_result *result, enum hfp_gw_cmd_type type,
 		if (hfp_gw_result_has_next(result))
 			break;
 
+		bdaddr2android(&dev->bdaddr, ev.bdaddr);
+
 		ipc_send_notif(hal_ipc, HAL_SERVICE_ID_HANDSFREE,
-				HAL_EV_HANDSFREE_HSP_KEY_PRESS, 0, NULL);
+						HAL_EV_HANDSFREE_HSP_KEY_PRESS,
+						sizeof(ev), &ev);
 
 		hfp_gw_send_result(dev->gw, HFP_RESULT_OK);
 		return;
-- 
1.9.1

