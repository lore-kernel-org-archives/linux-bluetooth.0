Return-Path: <cyrus@holtmann.org>
From: Szymon Janc <szymon.janc@tieto.com>
To: <linux-bluetooth@vger.kernel.org>
CC: Szymon Janc <szymon.janc@tieto.com>
Subject: [RFC 04/14] android/hal: Use IPC command responses sanity checks
Date: Wed, 6 Nov 2013 15:09:20 +0100
Message-ID: <1383746970-25906-5-git-send-email-szymon.janc@tieto.com>
In-Reply-To: <1383746970-25906-1-git-send-email-szymon.janc@tieto.com>
References: <1383746970-25906-1-git-send-email-szymon.janc@tieto.com>
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Make HAL library checks received IPC responses for correctness.
---
 android/hal-ipc.c | 9 ++-------
 1 file changed, 2 insertions(+), 7 deletions(-)

diff --git a/android/hal-ipc.c b/android/hal-ipc.c
index 14be69b..293be87 100644
--- a/android/hal-ipc.c
+++ b/android/hal-ipc.c
@@ -340,8 +340,8 @@ int hal_ipc_cmd(uint8_t service_id, uint8_t opcode, uint16_t len, void *param,
 
 	pthread_mutex_unlock(&cmd_sk_mutex);
 
-	if (ret < (ssize_t) sizeof(cmd)) {
-		error("Too small response received(%zd bytes), aborting", ret);
+	if (!hal_rsp_check(&cmd, &rsp, ret)) {
+		error("IPC protocol error in command response, aborting");
 		exit(EXIT_FAILURE);
 	}
 
@@ -351,11 +351,6 @@ int hal_ipc_cmd(uint8_t service_id, uint8_t opcode, uint16_t len, void *param,
 		exit(EXIT_FAILURE);
 	}
 
-	if (ret != (ssize_t) (sizeof(cmd) + cmd.len)) {
-		error("Malformed response received(%zd bytes), aborting", ret);
-		exit(EXIT_FAILURE);
-	}
-
 	if (cmd.opcode != opcode && cmd.opcode != HAL_OP_STATUS) {
 		error("Invalid opcode received (%u vs %u), aborting",
 						cmd.opcode, opcode);
-- 
1.8.4.2

