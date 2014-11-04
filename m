Return-Path: <cyrus@holtmann.org>
From: Andrei Emeltchenko <Andrei.Emeltchenko.news@gmail.com>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCHv1 37/47] android/handsfree: Add support for new API for nrec_cmd_cb
Date: Tue,  4 Nov 2014 10:19:00 +0200
Message-Id: <1415089150-18798-38-git-send-email-Andrei.Emeltchenko.news@gmail.com>
In-Reply-To: <1415089150-18798-1-git-send-email-Andrei.Emeltchenko.news@gmail.com>
References: <1415089150-18798-1-git-send-email-Andrei.Emeltchenko.news@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

From: Andrei Emeltchenko <andrei.emeltchenko@intel.com>

NREC Command notification callback has new parameter bdaddr.
---
 android/hal-handsfree.c | 4 ++++
 android/hal-ipc-api.txt | 1 +
 android/hal-msg.h       | 1 +
 android/handsfree.c     | 1 +
 4 files changed, 7 insertions(+)

diff --git a/android/hal-handsfree.c b/android/hal-handsfree.c
index a640f9c..2554c97 100644
--- a/android/hal-handsfree.c
+++ b/android/hal-handsfree.c
@@ -146,7 +146,11 @@ static void handle_nrec(void *buf, uint16_t len, int fd)
 	struct hal_ev_handsfree_nrec *ev = buf;
 
 	if (cbs->nrec_cmd_cb)
+#if ANDROID_VERSION > PLATFORM_VER(4, 4, 4)
+		cbs->nrec_cmd_cb(ev->nrec, (bt_bdaddr_t *) (ev->bdaddr));
+#else
 		cbs->nrec_cmd_cb(ev->nrec);
+#endif
 }
 
 static void handle_chld(void *buf, uint16_t len, int fd)
diff --git a/android/hal-ipc-api.txt b/android/hal-ipc-api.txt
index bd1e460..60c107a 100644
--- a/android/hal-ipc-api.txt
+++ b/android/hal-ipc-api.txt
@@ -1043,6 +1043,7 @@ Notifications:
 	Opcode 0x89 - NREC Command notification
 
 		Notification parameters: NREC types (1 octet)
+		                         Remote address (6 octets)
 
 		Valid NREC types: 0x00 = Stop
 		                  0x01 = Start
diff --git a/android/hal-msg.h b/android/hal-msg.h
index 00e66e2..321f193 100644
--- a/android/hal-msg.h
+++ b/android/hal-msg.h
@@ -1385,6 +1385,7 @@ struct hal_ev_handsfree_dtmf {
 #define HAL_EV_HANDSFREE_NREC		0x89
 struct hal_ev_handsfree_nrec {
 	uint8_t nrec;
+	uint8_t bdaddr[6];
 } __attribute__((packed));
 
 #define HAL_HANDSFREE_CHLD_TYPE_RELEASEHELD			0x00
diff --git a/android/handsfree.c b/android/handsfree.c
index ee5cab5..904dc00 100644
--- a/android/handsfree.c
+++ b/android/handsfree.c
@@ -871,6 +871,7 @@ static void at_cmd_nrec(struct hfp_gw_result *result, enum hfp_gw_cmd_type type,
 			break;
 
 		ev.nrec = HAL_HANDSFREE_NREC_STOP;
+		bdaddr2android(&dev->bdaddr, ev.bdaddr);
 
 		ipc_send_notif(hal_ipc, HAL_SERVICE_ID_HANDSFREE,
 					HAL_EV_HANDSFREE_NREC, sizeof(ev), &ev);
-- 
1.9.1

