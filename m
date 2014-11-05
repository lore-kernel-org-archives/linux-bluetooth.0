Return-Path: <cyrus@holtmann.org>
From: Andrei Emeltchenko <Andrei.Emeltchenko.news@gmail.com>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH 2/9] android/handsfree: Add support for new API for start_vr
Date: Wed,  5 Nov 2014 16:38:46 +0200
Message-Id: <1415198333-7775-3-git-send-email-Andrei.Emeltchenko.news@gmail.com>
In-Reply-To: <1415198333-7775-1-git-send-email-Andrei.Emeltchenko.news@gmail.com>
References: <1415198333-7775-1-git-send-email-Andrei.Emeltchenko.news@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

From: Andrei Emeltchenko <andrei.emeltchenko@intel.com>

start_voice_recognition() in new Android API has bd_addr parameter.
---
 android/hal-handsfree.c | 23 +++++++++++++++++++++--
 android/hal-ipc-api.txt |  2 +-
 android/hal-msg.h       |  3 +++
 android/handsfree.c     |  6 +++++-
 4 files changed, 30 insertions(+), 4 deletions(-)

diff --git a/android/hal-handsfree.c b/android/hal-handsfree.c
index c575d2b..304281a 100644
--- a/android/hal-handsfree.c
+++ b/android/hal-handsfree.c
@@ -343,17 +343,36 @@ static bt_status_t disconnect_audio(bt_bdaddr_t *bd_addr)
 				&cmd, NULL, NULL, NULL);
 }
 
-static bt_status_t start_voice_recognition(void)
+static bt_status_t start_voice_recognition_real(bt_bdaddr_t *bd_addr)
 {
+	struct hal_cmd_handsfree_start_vr cmd;
+
 	DBG("");
 
 	if (!interface_ready())
 		return BT_STATUS_NOT_READY;
 
+	memset(&cmd, 0, sizeof(cmd));
+
+	if (bd_addr)
+		memcpy(cmd.bdaddr, bd_addr, sizeof(cmd.bdaddr));
+
 	return hal_ipc_cmd(HAL_SERVICE_ID_HANDSFREE, HAL_OP_HANDSFREE_START_VR,
-						0, NULL, NULL, NULL, NULL);
+					sizeof(cmd), &cmd, NULL, NULL, NULL);
 }
 
+#if ANDROID_VERSION >= PLATFORM_VER(5, 0, 0)
+static bt_status_t start_voice_recognition(bt_bdaddr_t *bd_addr)
+{
+	return start_voice_recognition_real(bd_addr);
+}
+#else
+static bt_status_t start_voice_recognition(void)
+{
+	return start_voice_recognition_real(NULL);
+}
+#endif
+
 static bt_status_t stop_voice_recognition(void)
 {
 	DBG("");
diff --git a/android/hal-ipc-api.txt b/android/hal-ipc-api.txt
index a9d4c8b..26d885f 100644
--- a/android/hal-ipc-api.txt
+++ b/android/hal-ipc-api.txt
@@ -835,7 +835,7 @@ Commands and responses:
 
 	Opcode 0x05 - Start Voice Recognition command/response
 
-		Command parameters: <none>
+		Command parameters: Remote address (6 octets)
 		Response parameters: <none>
 
 		In case of an error, the error response will be returned.
diff --git a/android/hal-msg.h b/android/hal-msg.h
index b5a4125..96a7640 100644
--- a/android/hal-msg.h
+++ b/android/hal-msg.h
@@ -494,6 +494,9 @@ struct hal_cmd_handsfree_disconnect_audio {
 } __attribute__((packed));
 
 #define HAL_OP_HANDSFREE_START_VR		0x05
+struct hal_cmd_handsfree_start_vr {
+	uint8_t bdaddr[6];
+} __attribute__((packed));
 
 #define HAL_OP_HANDSFREE_STOP_VR		0x06
 
diff --git a/android/handsfree.c b/android/handsfree.c
index 3bf42f1..60568c2 100644
--- a/android/handsfree.c
+++ b/android/handsfree.c
@@ -1886,12 +1886,16 @@ done:
 
 static void handle_start_vr(const void *buf, uint16_t len)
 {
+	const struct hal_cmd_handsfree_start_vr *cmd = buf;
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

