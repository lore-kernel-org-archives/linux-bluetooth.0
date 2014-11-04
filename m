Return-Path: <cyrus@holtmann.org>
From: Andrei Emeltchenko <Andrei.Emeltchenko.news@gmail.com>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCHv1 24/47] android/handsfree: Add support for new API for stop_vr
Date: Tue,  4 Nov 2014 10:18:47 +0200
Message-Id: <1415089150-18798-25-git-send-email-Andrei.Emeltchenko.news@gmail.com>
In-Reply-To: <1415089150-18798-1-git-send-email-Andrei.Emeltchenko.news@gmail.com>
References: <1415089150-18798-1-git-send-email-Andrei.Emeltchenko.news@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

From: Andrei Emeltchenko <andrei.emeltchenko@intel.com>

stop_voice_recognition() in new Android API has bd_addr parameter.
---
 android/hal-handsfree.c | 20 ++++++++++++++++++++
 android/hal-ipc-api.txt |  2 +-
 android/hal-msg.h       |  3 +++
 android/handsfree.c     |  6 +++++-
 4 files changed, 29 insertions(+), 2 deletions(-)

diff --git a/android/hal-handsfree.c b/android/hal-handsfree.c
index ffc9497..8b4f026 100644
--- a/android/hal-handsfree.c
+++ b/android/hal-handsfree.c
@@ -371,6 +371,25 @@ static bt_status_t start_voice_recognition(void)
 }
 #endif
 
+#if ANDROID_VERSION > PLATFORM_VER(4, 4, 4)
+static bt_status_t stop_voice_recognition(bt_bdaddr_t *bd_addr)
+{
+	struct hal_cmd_handsfree_stop_vr cmd;
+
+	DBG("");
+
+	if (!interface_ready())
+		return BT_STATUS_NOT_READY;
+
+	if (!bd_addr)
+		return BT_STATUS_PARM_INVALID;
+
+	memcpy(cmd.bdaddr, bd_addr, sizeof(cmd.bdaddr));
+
+	return hal_ipc_cmd(HAL_SERVICE_ID_HANDSFREE, HAL_OP_HANDSFREE_STOP_VR,
+						0, NULL, NULL, NULL, NULL);
+}
+#else
 static bt_status_t stop_voice_recognition(void)
 {
 	DBG("");
@@ -381,6 +400,7 @@ static bt_status_t stop_voice_recognition(void)
 	return hal_ipc_cmd(HAL_SERVICE_ID_HANDSFREE, HAL_OP_HANDSFREE_STOP_VR,
 						0, NULL, NULL, NULL, NULL);
 }
+#endif
 
 static bt_status_t volume_control(bthf_volume_type_t type, int volume)
 {
diff --git a/android/hal-ipc-api.txt b/android/hal-ipc-api.txt
index 2dacffd..bdf76c9 100644
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
index d858caf..410b979 100644
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

