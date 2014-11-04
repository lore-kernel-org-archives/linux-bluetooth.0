Return-Path: <cyrus@holtmann.org>
From: Andrei Emeltchenko <Andrei.Emeltchenko.news@gmail.com>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCHv1 31/47] android/handsfree: Add support for new API for vr_cmd_cb
Date: Tue,  4 Nov 2014 10:18:54 +0200
Message-Id: <1415089150-18798-32-git-send-email-Andrei.Emeltchenko.news@gmail.com>
In-Reply-To: <1415089150-18798-1-git-send-email-Andrei.Emeltchenko.news@gmail.com>
References: <1415089150-18798-1-git-send-email-Andrei.Emeltchenko.news@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

From: Andrei Emeltchenko <andrei.emeltchenko@intel.com>

Voice Recognition Command notification callback has new parameter bdaddr.
---
 android/hal-handsfree.c | 4 ++++
 android/hal-ipc-api.txt | 1 +
 android/hal-msg.h       | 1 +
 android/handsfree.c     | 2 ++
 4 files changed, 8 insertions(+)

diff --git a/android/hal-handsfree.c b/android/hal-handsfree.c
index f19ca1a..88636a3 100644
--- a/android/hal-handsfree.c
+++ b/android/hal-handsfree.c
@@ -58,7 +58,11 @@ static void handle_vr_state(void *buf, uint16_t len, int fd)
 	struct hal_ev_handsfree_vr_state *ev = buf;
 
 	if (cbs->vr_cmd_cb)
+#if ANDROID_VERSION > PLATFORM_VER(4, 4, 4)
+		cbs->vr_cmd_cb(ev->state, (bt_bdaddr_t *) (ev->bdaddr));
+#else
 		cbs->vr_cmd_cb(ev->state);
+#endif
 }
 
 static void handle_answer(void *buf, uint16_t len, int fd)
diff --git a/android/hal-ipc-api.txt b/android/hal-ipc-api.txt
index 4181d40..cabf32d 100644
--- a/android/hal-ipc-api.txt
+++ b/android/hal-ipc-api.txt
@@ -1008,6 +1008,7 @@ Notifications:
 	Opcode 0x83 - Voice Recognition Command notification
 
 		Notification parameters: Voice recognition state (1 octet)
+		                         Remote address (6 octets)
 
 		Valid voice recognition states: 0x00 = Stopped
 		                                0x01 = Started
diff --git a/android/hal-msg.h b/android/hal-msg.h
index 9b08966..4ea30dac 100644
--- a/android/hal-msg.h
+++ b/android/hal-msg.h
@@ -1346,6 +1346,7 @@ struct hal_ev_handsfree_audio_state {
 #define HAL_EV_HANDSFREE_VR		0x83
 struct hal_ev_handsfree_vr_state {
 	uint8_t state;
+	uint8_t bdaddr[6];
 } __attribute__((packed));
 
 #define HAL_EV_HANDSFREE_ANSWER		0x84
diff --git a/android/handsfree.c b/android/handsfree.c
index ba94011..99057b0 100644
--- a/android/handsfree.c
+++ b/android/handsfree.c
@@ -822,6 +822,8 @@ static void at_cmd_bvra(struct hfp_gw_result *result, enum hfp_gw_cmd_type type,
 		else
 			ev.state = HAL_HANDSFREE_VR_STOPPED;
 
+		bdaddr2android(&dev->bdaddr, ev.bdaddr);
+
 		ipc_send_notif(hal_ipc, HAL_SERVICE_ID_HANDSFREE,
 					HAL_EV_HANDSFREE_VR, sizeof(ev), &ev);
 		return;
-- 
1.9.1

