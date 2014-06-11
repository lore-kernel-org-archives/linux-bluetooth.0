Return-Path: <cyrus@holtmann.org>
From: Szymon Janc <szymon.janc@tieto.com>
To: linux-bluetooth@vger.kernel.org
Cc: Szymon Janc <szymon.janc@tieto.com>
Subject: [PATCH 05/10] android/hal-ipc: Move exit calls under failed label in hal_ipc_cmd
Date: Wed, 11 Jun 2014 16:32:47 +0200
Message-Id: <1402497172-12436-6-git-send-email-szymon.janc@tieto.com>
In-Reply-To: <1402497172-12436-1-git-send-email-szymon.janc@tieto.com>
References: <1402497172-12436-1-git-send-email-szymon.janc@tieto.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

This reduce number of exit points in preparation for destroy callback.
---
 android/hal-ipc.c | 49 ++++++++++++++++++++++++++-----------------------
 1 file changed, 26 insertions(+), 23 deletions(-)

diff --git a/android/hal-ipc.c b/android/hal-ipc.c
index abb3b4b..2cc6eda 100644
--- a/android/hal-ipc.c
+++ b/android/hal-ipc.c
@@ -329,8 +329,8 @@ int hal_ipc_cmd(uint8_t service_id, uint8_t opcode, uint16_t len, void *param,
 	size_t s_len = sizeof(s);
 
 	if (cmd_sk < 0) {
-		error("Invalid cmd socket passed to hal_ipc_cmd, aborting");
-		exit(EXIT_FAILURE);
+		error("Invalid cmd socket passed to hal_ipc_cmd");
+		goto failed;
 	}
 
 	if (!rsp || !rsp_len) {
@@ -359,16 +359,16 @@ int hal_ipc_cmd(uint8_t service_id, uint8_t opcode, uint16_t len, void *param,
 
 	ret = sendmsg(cmd_sk, &msg, 0);
 	if (ret < 0) {
-		error("Sending command failed, aborting :%s", strerror(errno));
+		error("Sending command failed:%s", strerror(errno));
 		pthread_mutex_unlock(&cmd_sk_mutex);
-		exit(EXIT_FAILURE);
+		goto failed;
 	}
 
 	/* socket was shutdown */
 	if (ret == 0) {
-		error("Command socket closed, aborting");
+		error("Command socket closed");
 		pthread_mutex_unlock(&cmd_sk_mutex);
-		exit(EXIT_FAILURE);
+		goto failed;
 	}
 
 	memset(&msg, 0, sizeof(msg));
@@ -390,48 +390,48 @@ int hal_ipc_cmd(uint8_t service_id, uint8_t opcode, uint16_t len, void *param,
 	}
 
 	ret = recvmsg(cmd_sk, &msg, 0);
+
+	pthread_mutex_unlock(&cmd_sk_mutex);
+
 	if (ret < 0) {
-		error("Receiving command response failed, aborting :%s",
-							strerror(errno));
-		pthread_mutex_unlock(&cmd_sk_mutex);
-		exit(EXIT_FAILURE);
+		error("Receiving command response failed: %s", strerror(errno));
+		goto failed;
 	}
 
-	pthread_mutex_unlock(&cmd_sk_mutex);
 
 	if (ret < (ssize_t) sizeof(cmd)) {
-		error("Too small response received(%zd bytes), aborting", ret);
-		exit(EXIT_FAILURE);
+		error("Too small response received(%zd bytes)", ret);
+		goto failed;
 	}
 
 	if (cmd.service_id != service_id) {
-		error("Invalid service id (0x%x vs 0x%x), aborting",
+		error("Invalid service id (0x%x vs 0x%x)",
 						cmd.service_id, service_id);
-		exit(EXIT_FAILURE);
+		goto failed;
 	}
 
 	if (ret != (ssize_t) (sizeof(cmd) + cmd.len)) {
-		error("Malformed response received(%zd bytes), aborting", ret);
-		exit(EXIT_FAILURE);
+		error("Malformed response received(%zd bytes)", ret);
+		goto failed;
 	}
 
 	if (cmd.opcode != opcode && cmd.opcode != HAL_OP_STATUS) {
-		error("Invalid opcode received (0x%x vs 0x%x), aborting",
+		error("Invalid opcode received (0x%x vs 0x%x)",
 						cmd.opcode, opcode);
-		exit(EXIT_FAILURE);
+		goto failed;
 	}
 
 	if (cmd.opcode == HAL_OP_STATUS) {
 		struct ipc_status *s = rsp;
 
 		if (sizeof(*s) != cmd.len) {
-			error("Invalid status length, aborting");
-			exit(EXIT_FAILURE);
+			error("Invalid status length");
+			goto failed;
 		}
 
 		if (s->code == HAL_STATUS_SUCCESS) {
-			error("Invalid success status response, aborting");
-			exit(EXIT_FAILURE);
+			error("Invalid success status response");
+			goto failed;
 		}
 
 		return s->code;
@@ -457,4 +457,7 @@ int hal_ipc_cmd(uint8_t service_id, uint8_t opcode, uint16_t len, void *param,
 		*rsp_len = cmd.len;
 
 	return BT_STATUS_SUCCESS;
+
+failed:
+	exit(EXIT_FAILURE);
 }
-- 
1.9.1

