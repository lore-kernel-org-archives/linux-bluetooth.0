Return-Path: <cyrus@holtmann.org>
From: Andrei Emeltchenko <Andrei.Emeltchenko.news@gmail.com>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCHv1 36/47] android/handsfree: Add support for new API for handle_dtmf
Date: Tue,  4 Nov 2014 10:18:59 +0200
Message-Id: <1415089150-18798-37-git-send-email-Andrei.Emeltchenko.news@gmail.com>
In-Reply-To: <1415089150-18798-1-git-send-email-Andrei.Emeltchenko.news@gmail.com>
References: <1415089150-18798-1-git-send-email-Andrei.Emeltchenko.news@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

From: Andrei Emeltchenko <andrei.emeltchenko@intel.com>

DTMF Command notification callback has new parameter bdaddr.
---
 android/hal-handsfree.c | 4 ++++
 android/hal-ipc-api.txt | 1 +
 android/hal-msg.h       | 1 +
 android/handsfree.c     | 1 +
 4 files changed, 7 insertions(+)

diff --git a/android/hal-handsfree.c b/android/hal-handsfree.c
index eddde37..a640f9c 100644
--- a/android/hal-handsfree.c
+++ b/android/hal-handsfree.c
@@ -134,7 +134,11 @@ static void handle_dtmf(void *buf, uint16_t len, int fd)
 	struct hal_ev_handsfree_dtmf *ev = buf;
 
 	if (cbs->dtmf_cmd_cb)
+#if ANDROID_VERSION > PLATFORM_VER(4, 4, 4)
+		cbs->dtmf_cmd_cb(ev->tone, (bt_bdaddr_t *) (ev->bdaddr));
+#else
 		cbs->dtmf_cmd_cb(ev->tone);
+#endif
 }
 
 static void handle_nrec(void *buf, uint16_t len, int fd)
diff --git a/android/hal-ipc-api.txt b/android/hal-ipc-api.txt
index d0d2869..bd1e460 100644
--- a/android/hal-ipc-api.txt
+++ b/android/hal-ipc-api.txt
@@ -1038,6 +1038,7 @@ Notifications:
 	Opcode 0x88 - DTMF Command notification
 
 		Notification parameters: Tone (1 octet)
+		                         Remote address (6 octets)
 
 	Opcode 0x89 - NREC Command notification
 
diff --git a/android/hal-msg.h b/android/hal-msg.h
index a1cfff1..00e66e2 100644
--- a/android/hal-msg.h
+++ b/android/hal-msg.h
@@ -1376,6 +1376,7 @@ struct hal_ev_handsfree_dial {
 #define HAL_EV_HANDSFREE_DTMF		0x88
 struct hal_ev_handsfree_dtmf {
 	uint8_t tone;
+	uint8_t bdaddr[6];
 } __attribute__((packed));
 
 #define HAL_HANDSFREE_NREC_STOP		0x00
diff --git a/android/handsfree.c b/android/handsfree.c
index 88a9ed5..ee5cab5 100644
--- a/android/handsfree.c
+++ b/android/handsfree.c
@@ -730,6 +730,7 @@ static void at_cmd_vts(struct hfp_gw_result *result, enum hfp_gw_cmd_type type,
 		if (hfp_gw_result_has_next(result))
 			break;
 
+		bdaddr2android(&dev->bdaddr, ev.bdaddr);
 		ev.tone = str[0];
 
 		ipc_send_notif(hal_ipc, HAL_SERVICE_ID_HANDSFREE,
-- 
1.9.1

