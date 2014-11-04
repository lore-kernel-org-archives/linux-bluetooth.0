Return-Path: <cyrus@holtmann.org>
From: Andrei Emeltchenko <Andrei.Emeltchenko.news@gmail.com>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCHv1 25/47] android/handsfree: Add support for new API for volume_control
Date: Tue,  4 Nov 2014 10:18:48 +0200
Message-Id: <1415089150-18798-26-git-send-email-Andrei.Emeltchenko.news@gmail.com>
In-Reply-To: <1415089150-18798-1-git-send-email-Andrei.Emeltchenko.news@gmail.com>
References: <1415089150-18798-1-git-send-email-Andrei.Emeltchenko.news@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

From: Andrei Emeltchenko <andrei.emeltchenko@intel.com>

volume_control() in new Android API has bd_addr parameter.
---
 android/hal-handsfree.c | 12 ++++++++++++
 android/hal-ipc-api.txt |  1 +
 android/hal-msg.h       |  1 +
 android/handsfree.c     |  5 ++++-
 4 files changed, 18 insertions(+), 1 deletion(-)

diff --git a/android/hal-handsfree.c b/android/hal-handsfree.c
index 8b4f026..ef42ad4 100644
--- a/android/hal-handsfree.c
+++ b/android/hal-handsfree.c
@@ -402,7 +402,12 @@ static bt_status_t stop_voice_recognition(void)
 }
 #endif
 
+#if ANDROID_VERSION > PLATFORM_VER(4, 4, 4)
+static bt_status_t volume_control(bthf_volume_type_t type, int volume,
+							bt_bdaddr_t *bd_addr)
+#else
 static bt_status_t volume_control(bthf_volume_type_t type, int volume)
+#endif
 {
 	struct hal_cmd_handsfree_volume_control cmd;
 
@@ -414,6 +419,13 @@ static bt_status_t volume_control(bthf_volume_type_t type, int volume)
 	cmd.type = type;
 	cmd.volume = volume;
 
+#if  ANDROID_VERSION > PLATFORM_VER(4, 4, 4)
+	if (!bd_addr)
+		return BT_STATUS_PARM_INVALID;
+
+	memcpy(cmd.bdaddr, bd_addr, sizeof(cmd.bdaddr));
+#endif
+
 	return hal_ipc_cmd(HAL_SERVICE_ID_HANDSFREE,
 				HAL_OP_HANDSFREE_VOLUME_CONTROL, sizeof(cmd),
 				&cmd, NULL, NULL, NULL);
diff --git a/android/hal-ipc-api.txt b/android/hal-ipc-api.txt
index bdf76c9..902141c 100644
--- a/android/hal-ipc-api.txt
+++ b/android/hal-ipc-api.txt
@@ -851,6 +851,7 @@ Commands and responses:
 
 		Command parameters: Volume type (1 octet)
 		                    Volume (1 octet)
+		                    Remote address (6 octets)
 		Response parameters: <none>
 
 		Valid volume types: 0x00 = Speaker
diff --git a/android/hal-msg.h b/android/hal-msg.h
index 5d53957..9833451 100644
--- a/android/hal-msg.h
+++ b/android/hal-msg.h
@@ -510,6 +510,7 @@ struct hal_cmd_handsfree_stop_vr {
 struct hal_cmd_handsfree_volume_control {
 	uint8_t type;
 	uint8_t volume;
+	uint8_t bdaddr[6];
 } __attribute__((packed));
 
 #define HAL_HANDSFREE_NETWORK_STATE_NOT_AVAILABLE	0x00
diff --git a/android/handsfree.c b/android/handsfree.c
index 410b979..d948eec 100644
--- a/android/handsfree.c
+++ b/android/handsfree.c
@@ -1947,10 +1947,13 @@ static void handle_volume_control(const void *buf, uint16_t len)
 	const struct hal_cmd_handsfree_volume_control *cmd = buf;
 	struct hf_device *dev;
 	uint8_t status, volume;
+	bdaddr_t bdaddr;
 
 	DBG("type=%u volume=%u", cmd->type, cmd->volume);
 
-	dev = find_default_device();
+	android2bdaddr(cmd->bdaddr, &bdaddr);
+
+	dev = find_device(&bdaddr);
 	if (!dev) {
 		status = HAL_STATUS_FAILED;
 		goto done;
-- 
1.9.1

