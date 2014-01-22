Return-Path: <cyrus@holtmann.org>
From: Jakub Tyszkowski <jakub.tyszkowski@tieto.com>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH 1/9] android/ipc-tester: Add cases for SOCK msg size
Date: Wed, 22 Jan 2014 09:25:16 +0100
Message-Id: <1390379124-16426-1-git-send-email-jakub.tyszkowski@tieto.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Add cases testing message size verification for SOCK opcodes.
---
 android/ipc-tester.c | 18 ++++++++++++++++++
 1 file changed, 18 insertions(+)

diff --git a/android/ipc-tester.c b/android/ipc-tester.c
index ed0dd10..088c324 100644
--- a/android/ipc-tester.c
+++ b/android/ipc-tester.c
@@ -864,5 +864,23 @@ int main(int argc, char *argv[])
 			sizeof(struct hal_cmd_le_test_mode), -1,
 			HAL_SERVICE_ID_BLUETOOTH);
 
+	/* check for valid data size for SOCK */
+	test_datasize_valid("SOCK Listen+", HAL_SERVICE_ID_SOCK,
+			HAL_OP_SOCK_LISTEN,
+			sizeof(struct hal_cmd_sock_listen), 1,
+			HAL_SERVICE_ID_BLUETOOTH, HAL_SERVICE_ID_SOCK);
+	test_datasize_valid("SOCK Listen-", HAL_SERVICE_ID_SOCK,
+			HAL_OP_SOCK_LISTEN,
+			sizeof(struct hal_cmd_sock_listen), -1,
+			HAL_SERVICE_ID_BLUETOOTH, HAL_SERVICE_ID_SOCK);
+	test_datasize_valid("SOCK Connect+", HAL_SERVICE_ID_SOCK,
+			HAL_OP_SOCK_CONNECT,
+			sizeof(struct hal_cmd_sock_connect), 1,
+			HAL_SERVICE_ID_BLUETOOTH, HAL_SERVICE_ID_SOCK);
+	test_datasize_valid("SOCK Connect-", HAL_SERVICE_ID_SOCK,
+			HAL_OP_SOCK_CONNECT,
+			sizeof(struct hal_cmd_sock_connect), -1,
+			HAL_SERVICE_ID_BLUETOOTH, HAL_SERVICE_ID_SOCK);
+
 	return tester_run();
 }
-- 
1.8.5.2

