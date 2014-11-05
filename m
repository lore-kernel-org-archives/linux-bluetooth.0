Return-Path: <cyrus@holtmann.org>
From: Andrei Emeltchenko <Andrei.Emeltchenko.news@gmail.com>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH 7/9] android/handsfree: Add support for new API for formatted_at_response
Date: Wed,  5 Nov 2014 16:38:51 +0200
Message-Id: <1415198333-7775-8-git-send-email-Andrei.Emeltchenko.news@gmail.com>
In-Reply-To: <1415198333-7775-1-git-send-email-Andrei.Emeltchenko.news@gmail.com>
References: <1415198333-7775-1-git-send-email-Andrei.Emeltchenko.news@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

From: Andrei Emeltchenko <andrei.emeltchenko@intel.com>

formatted_at_response has new parameter bdaddr in new Android API.
---
 android/hal-handsfree.c | 20 +++++++++++++++++++-
 android/hal-ipc-api.txt |  1 +
 android/hal-msg.h       |  1 +
 android/handsfree.c     |  5 ++++-
 4 files changed, 25 insertions(+), 2 deletions(-)

diff --git a/android/hal-handsfree.c b/android/hal-handsfree.c
index 642d087..294d1e9 100644
--- a/android/hal-handsfree.c
+++ b/android/hal-handsfree.c
@@ -553,7 +553,8 @@ static bt_status_t cind_response(int svc, int num_active, int num_held,
 }
 #endif
 
-static bt_status_t formatted_at_response(const char *rsp)
+static bt_status_t formatted_at_response_real(const char *rsp,
+							bt_bdaddr_t *bd_addr)
 {
 	char buf[IPC_MTU];
 	struct hal_cmd_handsfree_formatted_at_response *cmd = (void *) buf;
@@ -567,6 +568,11 @@ static bt_status_t formatted_at_response(const char *rsp)
 	if (!rsp)
 		return BT_STATUS_PARM_INVALID;
 
+	memset(cmd, 0, sizeof(*cmd));
+
+	if (bd_addr)
+		memcpy(cmd->bdaddr, bd_addr, sizeof(cmd->bdaddr));
+
 	cmd->len = strlen(rsp) + 1;
 	memcpy(cmd->buf, rsp, cmd->len);
 
@@ -577,6 +583,18 @@ static bt_status_t formatted_at_response(const char *rsp)
 					len, cmd, NULL, NULL, NULL);
 }
 
+#if ANDROID_VERSION >= PLATFORM_VER(5, 0, 0)
+static bt_status_t formatted_at_response(const char *rsp, bt_bdaddr_t *bd_addr)
+{
+	return formatted_at_response_real(rsp, bd_addr);
+}
+#else
+static bt_status_t formatted_at_response(const char *rsp)
+{
+	return formatted_at_response_real(rsp, NULL);
+}
+#endif
+
 static bt_status_t at_response(bthf_at_response_t response, int error)
 {
 	struct hal_cmd_handsfree_at_response cmd;
diff --git a/android/hal-ipc-api.txt b/android/hal-ipc-api.txt
index 4cfb91e..44cfe23 100644
--- a/android/hal-ipc-api.txt
+++ b/android/hal-ipc-api.txt
@@ -908,6 +908,7 @@ Commands and responses:
 	Opcode 0x0b - Formatted AT Response command/response
 
 		Command parameters: Pre-formatted AT response (string)
+		                    Remote address (6 octets)
 		Response parameters: <none>
 
 		In case of an error, the error response will be returned.
diff --git a/android/hal-msg.h b/android/hal-msg.h
index 17e6dee..5c5ed22 100644
--- a/android/hal-msg.h
+++ b/android/hal-msg.h
@@ -557,6 +557,7 @@ struct hal_cmd_handsfree_cind_response {
 #define HAL_OP_HANDSFREE_FORMATTED_AT_RESPONSE	0x0B
 struct hal_cmd_handsfree_formatted_at_response {
 	uint16_t len;
+	uint8_t bdaddr[6];
 	uint8_t buf[0];
 } __attribute__((packed));
 
diff --git a/android/handsfree.c b/android/handsfree.c
index f34668d..15753bb 100644
--- a/android/handsfree.c
+++ b/android/handsfree.c
@@ -2127,6 +2127,7 @@ static void handle_formatted_at_resp(const void *buf, uint16_t len)
 {
 	const struct hal_cmd_handsfree_formatted_at_response *cmd = buf;
 	struct hf_device *dev;
+	bdaddr_t bdaddr;
 	uint8_t status;
 
 	DBG("");
@@ -2138,7 +2139,9 @@ static void handle_formatted_at_resp(const void *buf, uint16_t len)
 		return;
 	}
 
-	dev = find_default_device();
+	android2bdaddr(cmd->bdaddr, &bdaddr);
+
+	dev = find_device(&bdaddr);
 	if (!dev) {
 		status = HAL_STATUS_FAILED;
 		goto done;
-- 
1.9.1

