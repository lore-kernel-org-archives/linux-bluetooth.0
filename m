Return-Path: <cyrus@holtmann.org>
From: Andrei Emeltchenko <Andrei.Emeltchenko.news@gmail.com>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH 09/14] android/handsfree: Add support for new API for cnum_cmd_cb
Date: Thu,  6 Nov 2014 10:32:04 +0200
Message-Id: <1415262729-12573-10-git-send-email-Andrei.Emeltchenko.news@gmail.com>
In-Reply-To: <1415262729-12573-1-git-send-email-Andrei.Emeltchenko.news@gmail.com>
References: <1415262729-12573-1-git-send-email-Andrei.Emeltchenko.news@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

From: Andrei Emeltchenko <andrei.emeltchenko@intel.com>

CNUM Command notification callback has new parameter bdaddr.
Currently use global device bdaddr.
---
 android/hal-handsfree.c | 11 +++++++++--
 android/hal-ipc-api.txt |  2 +-
 android/hal-msg.h       |  3 +++
 android/handsfree.c     |  5 ++++-
 4 files changed, 17 insertions(+), 4 deletions(-)

diff --git a/android/hal-handsfree.c b/android/hal-handsfree.c
index e4ade61..8618ddf 100644
--- a/android/hal-handsfree.c
+++ b/android/hal-handsfree.c
@@ -167,8 +167,15 @@ static void handle_chld(void *buf, uint16_t len, int fd)
 
 static void handle_cnum(void *buf, uint16_t len, int fd)
 {
-	if (cbs->cnum_cmd_cb)
-		cbs->cnum_cmd_cb();
+	if (cbs->cnum_cmd_cb) {
+#if ANDROID_VERSION >= PLATFORM_VER(5, 0, 0)
+		struct hal_ev_handsfree_cnum *ev = buf;
+
+		cbs->cnum_cmd_cb((bt_bdaddr_t *) (ev->bdaddr));
+#else
+		cbs->cnum_cmd_cb(NULL);
+#endif
+	}
 }
 
 static void handle_cind(void *buf, uint16_t len, int fd)
diff --git a/android/hal-ipc-api.txt b/android/hal-ipc-api.txt
index 06a2beb..27a0c24 100644
--- a/android/hal-ipc-api.txt
+++ b/android/hal-ipc-api.txt
@@ -1060,7 +1060,7 @@ Notifications:
 
 	Opcode 0x8b - CNUM Command notification
 
-		Notification parameters: <none>
+		Notification parameters: Remote address (6 octets)
 
 	Opcode 0x8c - CIND Command notification
 
diff --git a/android/hal-msg.h b/android/hal-msg.h
index 24780f5..2650d36 100644
--- a/android/hal-msg.h
+++ b/android/hal-msg.h
@@ -1400,6 +1400,9 @@ struct hal_ev_handsfree_chld {
 } __attribute__((packed));
 
 #define HAL_EV_HANDSFREE_CNUM		0x8B
+struct hal_ev_handsfree_cnum {
+	uint8_t bdaddr[6];
+} __attribute__((packed));
 
 #define HAL_EV_HANDSFREE_CIND		0x8C
 
diff --git a/android/handsfree.c b/android/handsfree.c
index 3bfb2ee..0b846e6 100644
--- a/android/handsfree.c
+++ b/android/handsfree.c
@@ -752,6 +752,7 @@ static void at_cmd_cnum(struct hfp_context *context,
 				enum hfp_gw_cmd_type type, void *user_data)
 {
 	struct hf_device *dev = user_data;
+	struct hal_ev_handsfree_cnum ev;
 
 	DBG("");
 
@@ -760,8 +761,10 @@ static void at_cmd_cnum(struct hfp_context *context,
 		if (hfp_context_has_next(context))
 			break;
 
+		bdaddr2android(&dev->bdaddr, ev.bdaddr);
+
 		ipc_send_notif(hal_ipc, HAL_SERVICE_ID_HANDSFREE,
-						HAL_EV_HANDSFREE_CNUM, 0, NULL);
+					HAL_EV_HANDSFREE_CNUM, sizeof(ev), &ev);
 		return;
 	case HFP_GW_CMD_TYPE_SET:
 	case HFP_GW_CMD_TYPE_READ:
-- 
1.9.1

