Return-Path: <cyrus@holtmann.org>
From: Andrei Emeltchenko <Andrei.Emeltchenko.news@gmail.com>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCHv1 41/47] android/handsfree: Add support for new API for cops_cmd_cb
Date: Tue,  4 Nov 2014 10:19:04 +0200
Message-Id: <1415089150-18798-42-git-send-email-Andrei.Emeltchenko.news@gmail.com>
In-Reply-To: <1415089150-18798-1-git-send-email-Andrei.Emeltchenko.news@gmail.com>
References: <1415089150-18798-1-git-send-email-Andrei.Emeltchenko.news@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

From: Andrei Emeltchenko <andrei.emeltchenko@intel.com>

COPS Command notification callback has new parameter bdaddr.
---
 android/hal-handsfree.c | 9 ++++++++-
 android/hal-ipc-api.txt | 2 +-
 android/hal-msg.h       | 3 +++
 android/handsfree.c     | 5 ++++-
 4 files changed, 16 insertions(+), 3 deletions(-)

diff --git a/android/hal-handsfree.c b/android/hal-handsfree.c
index c41209c..3fa91e9 100644
--- a/android/hal-handsfree.c
+++ b/android/hal-handsfree.c
@@ -193,8 +193,15 @@ static void handle_cind(void *buf, uint16_t len, int fd)
 
 static void handle_cops(void *buf, uint16_t len, int fd)
 {
-	if (cbs->cops_cmd_cb)
+	if (cbs->cops_cmd_cb) {
+#if ANDROID_VERSION > PLATFORM_VER(4, 4, 4)
+		struct hal_ev_handsfree_cops *ev = buf;
+
+		cbs->cops_cmd_cb((bt_bdaddr_t *) (ev->bdaddr));
+#else
 		cbs->cops_cmd_cb();
+#endif
+	}
 }
 
 static void handle_clcc(void *buf, uint16_t len, int fd)
diff --git a/android/hal-ipc-api.txt b/android/hal-ipc-api.txt
index 8a95f6c..2b4f362 100644
--- a/android/hal-ipc-api.txt
+++ b/android/hal-ipc-api.txt
@@ -1068,7 +1068,7 @@ Notifications:
 
 	Opcode 0x8d - COPS Command notification
 
-		Notification parameters: <none>
+		Notification parameters: Remote address (6 octets)
 
 	Opcode 0x8e - CLCC Command notification
 
diff --git a/android/hal-msg.h b/android/hal-msg.h
index 86a79c7..5793a5b 100644
--- a/android/hal-msg.h
+++ b/android/hal-msg.h
@@ -1410,6 +1410,9 @@ struct hal_ev_handsfree_cind {
 } __attribute__((packed));
 
 #define HAL_EV_HANDSFREE_COPS		0x8D
+struct hal_ev_handsfree_cops {
+	uint8_t bdaddr[6];
+} __attribute__((packed));
 
 #define HAL_EV_HANDSFREE_CLCC		0x8E
 
diff --git a/android/handsfree.c b/android/handsfree.c
index 2e624a4..c4c031b 100644
--- a/android/handsfree.c
+++ b/android/handsfree.c
@@ -418,6 +418,7 @@ static void at_cmd_cops(struct hfp_gw_result *result, enum hfp_gw_cmd_type type,
 								void *user_data)
 {
 	struct hf_device *dev = user_data;
+	struct hal_ev_handsfree_cops ev;
 	unsigned int val;
 
 	switch (type) {
@@ -434,8 +435,10 @@ static void at_cmd_cops(struct hfp_gw_result *result, enum hfp_gw_cmd_type type,
 		hfp_gw_send_result(dev->gw, HFP_RESULT_OK);
 		return;
 	case HFP_GW_CMD_TYPE_READ:
+		bdaddr2android(&dev->bdaddr, ev.bdaddr);
+
 		ipc_send_notif(hal_ipc, HAL_SERVICE_ID_HANDSFREE,
-						HAL_EV_HANDSFREE_COPS, 0, NULL);
+					HAL_EV_HANDSFREE_COPS, sizeof(ev), &ev);
 		return;
 	case HFP_GW_CMD_TYPE_TEST:
 	case HFP_GW_CMD_TYPE_COMMAND:
-- 
1.9.1

