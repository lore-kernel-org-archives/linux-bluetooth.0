Return-Path: <cyrus@holtmann.org>
From: Andrei Emeltchenko <Andrei.Emeltchenko.news@gmail.com>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCHv1 35/47] android/handsfree: Add support for new API for dial_call_cmd_cb
Date: Tue,  4 Nov 2014 10:18:58 +0200
Message-Id: <1415089150-18798-36-git-send-email-Andrei.Emeltchenko.news@gmail.com>
In-Reply-To: <1415089150-18798-1-git-send-email-Andrei.Emeltchenko.news@gmail.com>
References: <1415089150-18798-1-git-send-email-Andrei.Emeltchenko.news@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

From: Andrei Emeltchenko <andrei.emeltchenko@intel.com>

Dial Call Command notification callback has new parameter bdaddr.
---
 android/hal-handsfree.c | 4 ++++
 android/hal-ipc-api.txt | 3 ++-
 android/hal-msg.h       | 1 +
 android/handsfree.c     | 3 +++
 4 files changed, 10 insertions(+), 1 deletion(-)

diff --git a/android/hal-handsfree.c b/android/hal-handsfree.c
index 38eee0b..eddde37 100644
--- a/android/hal-handsfree.c
+++ b/android/hal-handsfree.c
@@ -122,7 +122,11 @@ static void handle_dial(void *buf, uint16_t len, int fd)
 	if (ev->number_len)
 		number = (char *) ev->number;
 
+#if ANDROID_VERSION > PLATFORM_VER(4, 4, 4)
+	cbs->dial_call_cmd_cb(number, (bt_bdaddr_t *) (ev->bdaddr));
+#else
 	cbs->dial_call_cmd_cb(number);
+#endif
 }
 
 static void handle_dtmf(void *buf, uint16_t len, int fd)
diff --git a/android/hal-ipc-api.txt b/android/hal-ipc-api.txt
index 7c24e8e..d0d2869 100644
--- a/android/hal-ipc-api.txt
+++ b/android/hal-ipc-api.txt
@@ -1032,7 +1032,8 @@ Notifications:
 
 	Opcode 0x87 - Dial Call Command notification
 
-		Notification parameters: Number (string)
+		Notification parameters: Remote address (6 octets)
+		                         Number (string)
 
 	Opcode 0x88 - DTMF Command notification
 
diff --git a/android/hal-msg.h b/android/hal-msg.h
index 889b45e..a1cfff1 100644
--- a/android/hal-msg.h
+++ b/android/hal-msg.h
@@ -1368,6 +1368,7 @@ struct hal_ev_handsfree_volume {
 
 #define HAL_EV_HANDSFREE_DIAL		0x87
 struct hal_ev_handsfree_dial {
+	uint8_t bdaddr[6];
 	uint16_t number_len;
 	uint8_t number[0];
 } __attribute__((packed));
diff --git a/android/handsfree.c b/android/handsfree.c
index e9b6af5..88a9ed5 100644
--- a/android/handsfree.c
+++ b/android/handsfree.c
@@ -537,6 +537,8 @@ static void at_cmd_d(struct hfp_gw_result *result, enum hfp_gw_cmd_type type,
 						(char *) ev->number, 255))
 			break;
 
+		bdaddr2android(&dev->bdaddr, ev->bdaddr);
+
 		ev->number_len = strlen((char *) ev->number);
 
 		if (ev->number[ev->number_len - 1] != ';')
@@ -794,6 +796,7 @@ static void at_cmd_bldn(struct hfp_gw_result *result, enum hfp_gw_cmd_type type,
 		if (hfp_gw_result_has_next(result))
 			break;
 
+		bdaddr2android(&dev->bdaddr, ev.bdaddr);
 		ev.number_len = 0;
 
 		ipc_send_notif(hal_ipc, HAL_SERVICE_ID_HANDSFREE,
-- 
1.9.1

