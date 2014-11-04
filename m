Return-Path: <cyrus@holtmann.org>
From: Andrei Emeltchenko <Andrei.Emeltchenko.news@gmail.com>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCHv1 26/47] android/handsfree: Add support for new API for cops_response
Date: Tue,  4 Nov 2014 10:18:49 +0200
Message-Id: <1415089150-18798-27-git-send-email-Andrei.Emeltchenko.news@gmail.com>
In-Reply-To: <1415089150-18798-1-git-send-email-Andrei.Emeltchenko.news@gmail.com>
References: <1415089150-18798-1-git-send-email-Andrei.Emeltchenko.news@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

From: Andrei Emeltchenko <andrei.emeltchenko@intel.com>

cops_response has new parameter bdaddr in new Android API.
---
 android/hal-handsfree.c | 12 ++++++++++++
 android/hal-ipc-api.txt |  1 +
 android/hal-msg.h       |  1 +
 android/handsfree.c     |  5 ++++-
 4 files changed, 18 insertions(+), 1 deletion(-)

diff --git a/android/hal-handsfree.c b/android/hal-handsfree.c
index ef42ad4..f28b8c7 100644
--- a/android/hal-handsfree.c
+++ b/android/hal-handsfree.c
@@ -452,7 +452,11 @@ static bt_status_t device_status_notification(bthf_network_state_t state,
 					sizeof(cmd), &cmd, NULL, NULL, NULL);
 }
 
+#if ANDROID_VERSION > PLATFORM_VER(4, 4, 4)
+static bt_status_t cops_response(const char *cops, bt_bdaddr_t *bd_addr)
+#else
 static bt_status_t cops_response(const char *cops)
+#endif
 {
 	char buf[IPC_MTU];
 	struct hal_cmd_handsfree_cops_response *cmd = (void *) buf;
@@ -466,6 +470,14 @@ static bt_status_t cops_response(const char *cops)
 	if (!cops)
 		return BT_STATUS_PARM_INVALID;
 
+#if ANDROID_VERSION > PLATFORM_VER(4, 4, 4)
+	if (!bd_addr)
+		return BT_STATUS_PARM_INVALID;
+
+	memcpy(cmd->bdaddr, bd_addr, sizeof(cmd->bdaddr));
+#endif
+
+	/* Size of cmd.buf */
 	cmd->len = strlen(cops) + 1;
 	memcpy(cmd->buf, cops, cmd->len);
 
diff --git a/android/hal-ipc-api.txt b/android/hal-ipc-api.txt
index 902141c..4a591b1 100644
--- a/android/hal-ipc-api.txt
+++ b/android/hal-ipc-api.txt
@@ -878,6 +878,7 @@ Commands and responses:
 	Opcode 0x09 - COPS Response command/response
 
 		Command parameters: COPS command response (string)
+		                    Remote address (6 octets)
 		Response parameters: <none>
 
 		In case of an error, the error response will be returned.
diff --git a/android/hal-msg.h b/android/hal-msg.h
index 9833451..a2f2de4 100644
--- a/android/hal-msg.h
+++ b/android/hal-msg.h
@@ -530,6 +530,7 @@ struct hal_cmd_handsfree_device_status_notif {
 #define HAL_OP_HANDSFREE_COPS_RESPONSE		0x09
 struct hal_cmd_handsfree_cops_response {
 	uint16_t len;
+	uint8_t bdaddr[6];
 	uint8_t buf[0];
 } __attribute__((packed));
 
diff --git a/android/handsfree.c b/android/handsfree.c
index d948eec..7089f7c 100644
--- a/android/handsfree.c
+++ b/android/handsfree.c
@@ -2031,6 +2031,7 @@ static void handle_cops(const void *buf, uint16_t len)
 {
 	const struct hal_cmd_handsfree_cops_response *cmd = buf;
 	struct hf_device *dev;
+	bdaddr_t bdaddr;
 	uint8_t status;
 
 	if (len != sizeof(*cmd) + cmd->len ||
@@ -2042,7 +2043,9 @@ static void handle_cops(const void *buf, uint16_t len)
 
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

