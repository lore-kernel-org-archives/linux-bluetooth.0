Return-Path: <cyrus@holtmann.org>
From: Andrei Emeltchenko <Andrei.Emeltchenko.news@gmail.com>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCHv1 40/47] android/handsfree: Add support for new API for cind_cmd_cb
Date: Tue,  4 Nov 2014 10:19:03 +0200
Message-Id: <1415089150-18798-41-git-send-email-Andrei.Emeltchenko.news@gmail.com>
In-Reply-To: <1415089150-18798-1-git-send-email-Andrei.Emeltchenko.news@gmail.com>
References: <1415089150-18798-1-git-send-email-Andrei.Emeltchenko.news@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

From: Andrei Emeltchenko <andrei.emeltchenko@intel.com>

CIND Command notification callback has new parameter bdaddr.
Currently use global device bdaddr.
---
 android/hal-handsfree.c | 9 ++++++++-
 android/hal-ipc-api.txt | 2 +-
 android/hal-msg.h       | 3 +++
 android/handsfree.c     | 5 ++++-
 4 files changed, 16 insertions(+), 3 deletions(-)

diff --git a/android/hal-handsfree.c b/android/hal-handsfree.c
index f3f537b..c41209c 100644
--- a/android/hal-handsfree.c
+++ b/android/hal-handsfree.c
@@ -180,8 +180,15 @@ static void handle_cnum(void *buf, uint16_t len, int fd)
 
 static void handle_cind(void *buf, uint16_t len, int fd)
 {
-	if (cbs->cind_cmd_cb)
+	if (cbs->cind_cmd_cb) {
+#if ANDROID_VERSION > PLATFORM_VER(4, 4, 4)
+		struct hal_ev_handsfree_cind *ev = buf;
+
+		cbs->cind_cmd_cb((bt_bdaddr_t *) (ev->bdaddr));
+#else
 		cbs->cind_cmd_cb();
+#endif
+	}
 }
 
 static void handle_cops(void *buf, uint16_t len, int fd)
diff --git a/android/hal-ipc-api.txt b/android/hal-ipc-api.txt
index 6587021..8a95f6c 100644
--- a/android/hal-ipc-api.txt
+++ b/android/hal-ipc-api.txt
@@ -1064,7 +1064,7 @@ Notifications:
 
 	Opcode 0x8c - CIND Command notification
 
-		Notification parameters: <none>
+		Notification parameters: Remote address (6 octets)
 
 	Opcode 0x8d - COPS Command notification
 
diff --git a/android/hal-msg.h b/android/hal-msg.h
index 2650d36..86a79c7 100644
--- a/android/hal-msg.h
+++ b/android/hal-msg.h
@@ -1405,6 +1405,9 @@ struct hal_ev_handsfree_cnum {
 } __attribute__((packed));
 
 #define HAL_EV_HANDSFREE_CIND		0x8C
+struct hal_ev_handsfree_cind {
+	uint8_t bdaddr[6];
+} __attribute__((packed));
 
 #define HAL_EV_HANDSFREE_COPS		0x8D
 
diff --git a/android/handsfree.c b/android/handsfree.c
index 211e628..2e624a4 100644
--- a/android/handsfree.c
+++ b/android/handsfree.c
@@ -1246,6 +1246,7 @@ static void at_cmd_cind(struct hfp_gw_result *result, enum hfp_gw_cmd_type type,
 								void *user_data)
 {
 	struct hf_device *dev = user_data;
+	struct hal_ev_handsfree_cind ev;
 	char *buf, *ptr;
 	int len;
 	unsigned int i;
@@ -1289,8 +1290,10 @@ static void at_cmd_cind(struct hfp_gw_result *result, enum hfp_gw_cmd_type type,
 		g_free(buf);
 		return;
 	case HFP_GW_CMD_TYPE_READ:
+		bdaddr2android(&dev->bdaddr, ev.bdaddr);
+
 		ipc_send_notif(hal_ipc, HAL_SERVICE_ID_HANDSFREE,
-						HAL_EV_HANDSFREE_CIND, 0, NULL);
+					HAL_EV_HANDSFREE_CIND, sizeof(ev), &ev);
 		return;
 	case HFP_GW_CMD_TYPE_SET:
 	case HFP_GW_CMD_TYPE_COMMAND:
-- 
1.9.1

