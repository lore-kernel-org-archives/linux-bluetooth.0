Return-Path: <cyrus@holtmann.org>
From: Andrei Emeltchenko <Andrei.Emeltchenko.news@gmail.com>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH 5/9] android/handsfree: Add support for new API for cops_response
Date: Wed,  5 Nov 2014 16:38:49 +0200
Message-Id: <1415198333-7775-6-git-send-email-Andrei.Emeltchenko.news@gmail.com>
In-Reply-To: <1415198333-7775-1-git-send-email-Andrei.Emeltchenko.news@gmail.com>
References: <1415198333-7775-1-git-send-email-Andrei.Emeltchenko.news@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

From: Andrei Emeltchenko <andrei.emeltchenko@intel.com>

cops_response has new parameter bdaddr in new Android API.
---
 android/hal-handsfree.c | 20 +++++++++++++++++++-
 android/hal-ipc-api.txt |  1 +
 android/hal-msg.h       |  1 +
 android/handsfree.c     |  5 ++++-
 4 files changed, 25 insertions(+), 2 deletions(-)

diff --git a/android/hal-handsfree.c b/android/hal-handsfree.c
index c1d8702..708d790 100644
--- a/android/hal-handsfree.c
+++ b/android/hal-handsfree.c
@@ -462,7 +462,7 @@ static bt_status_t device_status_notification(bthf_network_state_t state,
 					sizeof(cmd), &cmd, NULL, NULL, NULL);
 }
 
-static bt_status_t cops_response(const char *cops)
+static bt_status_t cops_response_real(const char *cops, bt_bdaddr_t *bd_addr)
 {
 	char buf[IPC_MTU];
 	struct hal_cmd_handsfree_cops_response *cmd = (void *) buf;
@@ -476,6 +476,12 @@ static bt_status_t cops_response(const char *cops)
 	if (!cops)
 		return BT_STATUS_PARM_INVALID;
 
+	memset(cmd, 0, sizeof(*cmd));
+
+	if (bd_addr)
+		memcpy(cmd->bdaddr, bd_addr, sizeof(cmd->bdaddr));
+
+	/* Size of cmd.buf */
 	cmd->len = strlen(cops) + 1;
 	memcpy(cmd->buf, cops, cmd->len);
 
@@ -486,6 +492,18 @@ static bt_status_t cops_response(const char *cops)
 						len, cmd, NULL, NULL, NULL);
 }
 
+#if ANDROID_VERSION >= PLATFORM_VER(5, 0, 0)
+static bt_status_t cops_response(const char *cops, bt_bdaddr_t *bd_addr)
+{
+	return cops_response_real(cops, bd_addr);
+}
+#else
+static bt_status_t cops_response(const char *cops)
+{
+	return cops_response_real(cops, NULL);
+}
+#endif
+
 static bt_status_t cind_response(int svc, int num_active, int num_held,
 					bthf_call_state_t state, int signal,
 					int roam, int batt_chg)
diff --git a/android/hal-ipc-api.txt b/android/hal-ipc-api.txt
index a4c7777..4128746 100644
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
index fc6605a..7a61dfc 100644
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

