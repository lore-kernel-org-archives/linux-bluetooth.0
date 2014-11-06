Return-Path: <cyrus@holtmann.org>
From: Andrei Emeltchenko <Andrei.Emeltchenko.news@gmail.com>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH 04/14] android/handsfree: Add support for new API for volume_cmd_cb
Date: Thu,  6 Nov 2014 10:31:59 +0200
Message-Id: <1415262729-12573-5-git-send-email-Andrei.Emeltchenko.news@gmail.com>
In-Reply-To: <1415262729-12573-1-git-send-email-Andrei.Emeltchenko.news@gmail.com>
References: <1415262729-12573-1-git-send-email-Andrei.Emeltchenko.news@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

From: Andrei Emeltchenko <andrei.emeltchenko@intel.com>

Volume Command notification callback has new parameter bdaddr.
---
 android/hal-handsfree.c | 5 +++++
 android/hal-ipc-api.txt | 1 +
 android/hal-msg.h       | 1 +
 android/handsfree.c     | 2 ++
 4 files changed, 9 insertions(+)

diff --git a/android/hal-handsfree.c b/android/hal-handsfree.c
index dc40a17..bb64da0 100644
--- a/android/hal-handsfree.c
+++ b/android/hal-handsfree.c
@@ -96,7 +96,12 @@ static void handle_volume(void *buf, uint16_t len, int fd)
 	struct hal_ev_handsfree_volume *ev = buf;
 
 	if (cbs->volume_cmd_cb)
+#if ANDROID_VERSION >= PLATFORM_VER(5, 0, 0)
+		cbs->volume_cmd_cb(ev->type, ev->volume,
+						(bt_bdaddr_t *) (ev->bdaddr));
+#else
 		cbs->volume_cmd_cb(ev->type, ev->volume);
+#endif
 }
 
 static void handle_dial(void *buf, uint16_t len, int fd)
diff --git a/android/hal-ipc-api.txt b/android/hal-ipc-api.txt
index 751c6ee..e462363 100644
--- a/android/hal-ipc-api.txt
+++ b/android/hal-ipc-api.txt
@@ -1025,6 +1025,7 @@ Notifications:
 
 		Notification parameters: Volume type (1 octet)
 		                         Volume (1 octet)
+		                         Remote address (6 octets)
 
 		Valid volume types: 0x00 = Speaker
 		                    0x01 = Microphone
diff --git a/android/hal-msg.h b/android/hal-msg.h
index 0abbb1f7..889b45e 100644
--- a/android/hal-msg.h
+++ b/android/hal-msg.h
@@ -1363,6 +1363,7 @@ struct hal_ev_handsfree_hangup {
 struct hal_ev_handsfree_volume {
 	uint8_t type;
 	uint8_t volume;
+	uint8_t bdaddr[6];
 } __attribute__((packed));
 
 #define HAL_EV_HANDSFREE_DIAL		0x87
diff --git a/android/handsfree.c b/android/handsfree.c
index 46f9a5d..83cc326 100644
--- a/android/handsfree.c
+++ b/android/handsfree.c
@@ -361,6 +361,7 @@ static void at_cmd_vgm(struct hfp_context *context,
 
 		ev.type = HAL_HANDSFREE_VOLUME_TYPE_MIC;
 		ev.volume = val;
+		bdaddr2android(&dev->bdaddr, ev.bdaddr);
 
 		ipc_send_notif(hal_ipc, HAL_SERVICE_ID_HANDSFREE,
 				HAL_EV_HANDSFREE_VOLUME, sizeof(ev), &ev);
@@ -396,6 +397,7 @@ static void at_cmd_vgs(struct hfp_context *context,
 
 		ev.type = HAL_HANDSFREE_VOLUME_TYPE_SPEAKER;
 		ev.volume = val;
+		bdaddr2android(&dev->bdaddr, ev.bdaddr);
 
 		ipc_send_notif(hal_ipc, HAL_SERVICE_ID_HANDSFREE,
 				HAL_EV_HANDSFREE_VOLUME, sizeof(ev), &ev);
-- 
1.9.1

