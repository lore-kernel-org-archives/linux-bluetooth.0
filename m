Return-Path: <cyrus@holtmann.org>
From: Andrei Emeltchenko <Andrei.Emeltchenko.news@gmail.com>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH 12/14] android/handsfree: Add support for new API for clcc_cmd_cb
Date: Thu,  6 Nov 2014 10:32:07 +0200
Message-Id: <1415262729-12573-13-git-send-email-Andrei.Emeltchenko.news@gmail.com>
In-Reply-To: <1415262729-12573-1-git-send-email-Andrei.Emeltchenko.news@gmail.com>
References: <1415262729-12573-1-git-send-email-Andrei.Emeltchenko.news@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

From: Andrei Emeltchenko <andrei.emeltchenko@intel.com>

CLCC Command notification callback has new parameter bdaddr.
---
 android/hal-handsfree.c | 9 ++++++++-
 android/hal-ipc-api.txt | 2 +-
 android/hal-msg.h       | 3 +++
 android/handsfree.c     | 5 ++++-
 4 files changed, 16 insertions(+), 3 deletions(-)

diff --git a/android/hal-handsfree.c b/android/hal-handsfree.c
index ea9614b..83d9909 100644
--- a/android/hal-handsfree.c
+++ b/android/hal-handsfree.c
@@ -206,8 +206,15 @@ static void handle_cops(void *buf, uint16_t len, int fd)
 
 static void handle_clcc(void *buf, uint16_t len, int fd)
 {
-	if (cbs->clcc_cmd_cb)
+	if (cbs->clcc_cmd_cb) {
+#if ANDROID_VERSION >= PLATFORM_VER(5, 0, 0)
+		struct hal_ev_handsfree_clcc *ev = buf;
+
+		cbs->clcc_cmd_cb((bt_bdaddr_t *) (ev->bdaddr));
+#else
 		cbs->clcc_cmd_cb();
+#endif
+	}
 }
 
 static void handle_unknown_at(void *buf, uint16_t len, int fd)
diff --git a/android/hal-ipc-api.txt b/android/hal-ipc-api.txt
index 64adf57..9c9ac35 100644
--- a/android/hal-ipc-api.txt
+++ b/android/hal-ipc-api.txt
@@ -1072,7 +1072,7 @@ Notifications:
 
 	Opcode 0x8e - CLCC Command notification
 
-		Notification parameters: <none>
+		Notification parameters: Remote address (6 octets)
 
 	Opcode 0x8f - Unknown AT Command notification
 
diff --git a/android/hal-msg.h b/android/hal-msg.h
index 5793a5b..9b9c2b0 100644
--- a/android/hal-msg.h
+++ b/android/hal-msg.h
@@ -1415,6 +1415,9 @@ struct hal_ev_handsfree_cops {
 } __attribute__((packed));
 
 #define HAL_EV_HANDSFREE_CLCC		0x8E
+struct hal_ev_handsfree_clcc {
+	uint8_t bdaddr[6];
+} __attribute__((packed));
 
 #define HAL_EV_HANDSFREE_UNKNOWN_AT	0x8F
 struct hal_ev_handsfree_unknown_at {
diff --git a/android/handsfree.c b/android/handsfree.c
index b64dcc6..9eaf38f 100644
--- a/android/handsfree.c
+++ b/android/handsfree.c
@@ -633,6 +633,7 @@ static void at_cmd_clcc(struct hfp_context *context,
 				enum hfp_gw_cmd_type type, void *user_data)
 {
 	struct hf_device *dev = user_data;
+	struct hal_ev_handsfree_clcc ev;
 
 	DBG("");
 
@@ -641,8 +642,10 @@ static void at_cmd_clcc(struct hfp_context *context,
 		if (hfp_context_has_next(context))
 			break;
 
+		bdaddr2android(&dev->bdaddr, ev.bdaddr);
+
 		ipc_send_notif(hal_ipc, HAL_SERVICE_ID_HANDSFREE,
-					HAL_EV_HANDSFREE_CLCC, 0, NULL);
+					HAL_EV_HANDSFREE_CLCC, sizeof(ev), &ev);
 		return;
 	case HFP_GW_CMD_TYPE_READ:
 	case HFP_GW_CMD_TYPE_TEST:
-- 
1.9.1

