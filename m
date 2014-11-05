Return-Path: <cyrus@holtmann.org>
From: Andrei Emeltchenko <Andrei.Emeltchenko.news@gmail.com>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH 4/9] android/handsfree: Add support for new API for volume_control
Date: Wed,  5 Nov 2014 16:38:48 +0200
Message-Id: <1415198333-7775-5-git-send-email-Andrei.Emeltchenko.news@gmail.com>
In-Reply-To: <1415198333-7775-1-git-send-email-Andrei.Emeltchenko.news@gmail.com>
References: <1415198333-7775-1-git-send-email-Andrei.Emeltchenko.news@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

From: Andrei Emeltchenko <andrei.emeltchenko@intel.com>

volume_control() in new Android API has bd_addr parameter.
---
 android/hal-handsfree.c | 21 ++++++++++++++++++++-
 android/hal-ipc-api.txt |  1 +
 android/hal-msg.h       |  1 +
 android/handsfree.c     |  5 ++++-
 4 files changed, 26 insertions(+), 2 deletions(-)

diff --git a/android/hal-handsfree.c b/android/hal-handsfree.c
index e5dd8c5..c1d8702 100644
--- a/android/hal-handsfree.c
+++ b/android/hal-handsfree.c
@@ -405,7 +405,8 @@ static bt_status_t stop_voice_recognition(void)
 }
 #endif
 
-static bt_status_t volume_control(bthf_volume_type_t type, int volume)
+static bt_status_t volume_control_real(bthf_volume_type_t type, int volume,
+							bt_bdaddr_t *bd_addr)
 {
 	struct hal_cmd_handsfree_volume_control cmd;
 
@@ -414,14 +415,32 @@ static bt_status_t volume_control(bthf_volume_type_t type, int volume)
 	if (!interface_ready())
 		return BT_STATUS_NOT_READY;
 
+	memset(&cmd, 0, sizeof(cmd));
+
 	cmd.type = type;
 	cmd.volume = volume;
 
+	if (bd_addr)
+		memcpy(cmd.bdaddr, bd_addr, sizeof(cmd.bdaddr));
+
 	return hal_ipc_cmd(HAL_SERVICE_ID_HANDSFREE,
 				HAL_OP_HANDSFREE_VOLUME_CONTROL, sizeof(cmd),
 				&cmd, NULL, NULL, NULL);
 }
 
+#if ANDROID_VERSION >= PLATFORM_VER(5, 0, 0)
+static bt_status_t volume_control(bthf_volume_type_t type, int volume,
+							bt_bdaddr_t *bd_addr)
+{
+	return volume_control_real(type, volume, bd_addr);
+}
+#else
+static bt_status_t volume_control(bthf_volume_type_t type, int volume)
+{
+	return volume_control_real(type, volume, NULL);
+}
+#endif
+
 static bt_status_t device_status_notification(bthf_network_state_t state,
 						bthf_service_type_t type,
 						int signal, int battery)
diff --git a/android/hal-ipc-api.txt b/android/hal-ipc-api.txt
index e422529..a4c7777 100644
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
index d31482c..fc6605a 100644
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

