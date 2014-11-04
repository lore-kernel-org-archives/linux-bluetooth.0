Return-Path: <cyrus@holtmann.org>
From: Andrei Emeltchenko <Andrei.Emeltchenko.news@gmail.com>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCHv1 38/47] android/handsfree: Add support for new API for chld_cmd_cb
Date: Tue,  4 Nov 2014 10:19:01 +0200
Message-Id: <1415089150-18798-39-git-send-email-Andrei.Emeltchenko.news@gmail.com>
In-Reply-To: <1415089150-18798-1-git-send-email-Andrei.Emeltchenko.news@gmail.com>
References: <1415089150-18798-1-git-send-email-Andrei.Emeltchenko.news@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

From: Andrei Emeltchenko <andrei.emeltchenko@intel.com>

CHLD Command notification callback has new parameter bdaddr.
---
 android/hal-handsfree.c | 4 ++++
 android/hal-ipc-api.txt | 1 +
 android/hal-msg.h       | 1 +
 android/handsfree.c     | 1 +
 4 files changed, 7 insertions(+)

diff --git a/android/hal-handsfree.c b/android/hal-handsfree.c
index 2554c97..bebeef7 100644
--- a/android/hal-handsfree.c
+++ b/android/hal-handsfree.c
@@ -158,7 +158,11 @@ static void handle_chld(void *buf, uint16_t len, int fd)
 	struct hal_ev_handsfree_chld *ev = buf;
 
 	if (cbs->chld_cmd_cb)
+#if ANDROID_VERSION > PLATFORM_VER(4, 4, 4)
+		cbs->chld_cmd_cb(ev->chld, (bt_bdaddr_t *) (ev->bdaddr));
+#else
 		cbs->chld_cmd_cb(ev->chld);
+#endif
 }
 
 static void handle_cnum(void *buf, uint16_t len, int fd)
diff --git a/android/hal-ipc-api.txt b/android/hal-ipc-api.txt
index 60c107a..baea3a1 100644
--- a/android/hal-ipc-api.txt
+++ b/android/hal-ipc-api.txt
@@ -1051,6 +1051,7 @@ Notifications:
 	Opcode 0x8a - CHLD Command notification
 
 		Notification parameters: NREC types (1 octet)
+		                         Remote address (6 octets)
 
 		Valid CHLD types: 0x00 = Release and hold
 		                  0x01 = Release active and accept held
diff --git a/android/hal-msg.h b/android/hal-msg.h
index 321f193..24780f5 100644
--- a/android/hal-msg.h
+++ b/android/hal-msg.h
@@ -1396,6 +1396,7 @@ struct hal_ev_handsfree_nrec {
 #define HAL_EV_HANDSFREE_CHLD		0x8A
 struct hal_ev_handsfree_chld {
 	uint8_t chld;
+	uint8_t bdaddr[6];
 } __attribute__((packed));
 
 #define HAL_EV_HANDSFREE_CNUM		0x8B
diff --git a/android/handsfree.c b/android/handsfree.c
index 904dc00..eba761f 100644
--- a/android/handsfree.c
+++ b/android/handsfree.c
@@ -1352,6 +1352,7 @@ static void at_cmd_chld(struct hfp_gw_result *result, enum hfp_gw_cmd_type type,
 
 		/* value match HAL type */
 		ev.chld = val;
+		bdaddr2android(&dev->bdaddr, ev.bdaddr);
 
 		ipc_send_notif(hal_ipc, HAL_SERVICE_ID_HANDSFREE,
 					HAL_EV_HANDSFREE_CHLD, sizeof(ev), &ev);
-- 
1.9.1

