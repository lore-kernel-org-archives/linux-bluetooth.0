Return-Path: <cyrus@holtmann.org>
From: Andrei Emeltchenko <Andrei.Emeltchenko.news@gmail.com>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH 3/9] android/handsfree: Add support for new API for stop_vr
Date: Wed,  5 Nov 2014 16:38:47 +0200
Message-Id: <1415198333-7775-4-git-send-email-Andrei.Emeltchenko.news@gmail.com>
In-Reply-To: <1415198333-7775-1-git-send-email-Andrei.Emeltchenko.news@gmail.com>
References: <1415198333-7775-1-git-send-email-Andrei.Emeltchenko.news@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

From: Andrei Emeltchenko <andrei.emeltchenko@intel.com>

stop_voice_recognition() in new Android API has bd_addr parameter.
---
 android/hal-handsfree.c | 25 +++++++++++++++++++++++--
 android/hal-ipc-api.txt |  2 +-
 android/hal-msg.h       |  3 +++
 android/handsfree.c     |  6 +++++-
 4 files changed, 32 insertions(+), 4 deletions(-)

diff --git a/android/hal-handsfree.c b/android/hal-handsfree.c
index 304281a..e5dd8c5 100644
--- a/android/hal-handsfree.c
+++ b/android/hal-handsfree.c
@@ -373,17 +373,38 @@ static bt_status_t start_voice_recognition(void)
 }
 #endif
 
-static bt_status_t stop_voice_recognition(void)
+static bt_status_t stop_voice_recognition_real(bt_bdaddr_t *bd_addr)
 {
+	struct hal_cmd_handsfree_stop_vr cmd;
+
 	DBG("");
 
 	if (!interface_ready())
 		return BT_STATUS_NOT_READY;
 
+	memset(&cmd, 0, sizeof(cmd));
+
+	if (bd_addr)
+		memcpy(cmd.bdaddr, bd_addr, sizeof(cmd.bdaddr));
+
+	memcpy(cmd.bdaddr, bd_addr, sizeof(cmd.bdaddr));
+
 	return hal_ipc_cmd(HAL_SERVICE_ID_HANDSFREE, HAL_OP_HANDSFREE_STOP_VR,
-						0, NULL, NULL, NULL, NULL);
+					sizeof(cmd), &cmd, NULL, NULL, NULL);
 }
 
+#if ANDROID_VERSION >= PLATFORM_VER(5, 0, 0)
+static bt_status_t stop_voice_recognition(bt_bdaddr_t *bd_addr)
+{
+	return stop_voice_recognition_real(bd_addr);
+}
+#else
+static bt_status_t stop_voice_recognition(void)
+{
+	return stop_voice_recognition_real(NULL);
+}
+#endif
+
 static bt_status_t volume_control(bthf_volume_type_t type, int volume)
 {
 	struct hal_cmd_handsfree_volume_control cmd;
diff --git a/android/hal-ipc-api.txt b/android/hal-ipc-api.txt
index 26d885f..e422529 100644
--- a/android/hal-ipc-api.txt
+++ b/android/hal-ipc-api.txt
@@ -842,7 +842,7 @@ Commands and responses:
 
 	Opcode 0x06 - Stop Voice Recognition command/response
 
-		Command parameters: <none>
+		Command parameters: Remote address (6 octets)
 		Response parameters: <none>
 
 		In case of an error, the error response will be returned.
diff --git a/android/hal-msg.h b/android/hal-msg.h
index 96a7640..5d53957 100644
--- a/android/hal-msg.h
+++ b/android/hal-msg.h
@@ -499,6 +499,9 @@ struct hal_cmd_handsfree_start_vr {
 } __attribute__((packed));
 
 #define HAL_OP_HANDSFREE_STOP_VR		0x06
+struct hal_cmd_handsfree_stop_vr {
+	uint8_t bdaddr[6];
+} __attribute__((packed));
 
 #define HAL_HANDSFREE_VOLUME_TYPE_SPEAKER	0x00
 #define HAL_HANDSFREE_VOLUME_TYPE_MIC		0x01
diff --git a/android/handsfree.c b/android/handsfree.c
index 60568c2..d31482c 100644
--- a/android/handsfree.c
+++ b/android/handsfree.c
@@ -1915,12 +1915,16 @@ done:
 
 static void handle_stop_vr(const void *buf, uint16_t len)
 {
+	const struct hal_cmd_handsfree_stop_vr *cmd = buf;
 	struct hf_device *dev;
+	bdaddr_t bdaddr;
 	uint8_t status;
 
 	DBG("");
 
-	dev = find_default_device();
+	android2bdaddr(cmd->bdaddr, &bdaddr);
+
+	dev = find_device(&bdaddr);
 	if (!dev) {
 		status = HAL_STATUS_FAILED;
 		goto done;
-- 
1.9.1

