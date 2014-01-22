Return-Path: <cyrus@holtmann.org>
From: Jakub Tyszkowski <jakub.tyszkowski@tieto.com>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH 6/9] android/ipc-tester: Add cases for PAN msg size
Date: Wed, 22 Jan 2014 09:25:21 +0100
Message-Id: <1390379124-16426-6-git-send-email-jakub.tyszkowski@tieto.com>
In-Reply-To: <1390379124-16426-1-git-send-email-jakub.tyszkowski@tieto.com>
References: <1390379124-16426-1-git-send-email-jakub.tyszkowski@tieto.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Add cases testing message size verification for PAN opcodes.
---
 android/ipc-tester.c | 30 ++++++++++++++++++++++++++++++
 1 file changed, 30 insertions(+)

diff --git a/android/ipc-tester.c b/android/ipc-tester.c
index b161049..11239e7 100644
--- a/android/ipc-tester.c
+++ b/android/ipc-tester.c
@@ -1103,5 +1103,35 @@ int main(int argc, char *argv[])
 				sizeof(send_data_data)),
 			HAL_SERVICE_ID_BLUETOOTH, HAL_SERVICE_ID_HIDHOST);
 
+	/* check for valid data size for PAN */
+	test_datasize_valid("PAN Enable+", HAL_SERVICE_ID_PAN,
+			HAL_OP_PAN_ENABLE,
+			sizeof(struct hal_cmd_pan_enable), 1,
+			HAL_SERVICE_ID_BLUETOOTH, HAL_SERVICE_ID_PAN);
+	test_datasize_valid("PAN Enable-", HAL_SERVICE_ID_PAN,
+			HAL_OP_PAN_ENABLE,
+			sizeof(struct hal_cmd_pan_enable), -1,
+			HAL_SERVICE_ID_BLUETOOTH, HAL_SERVICE_ID_PAN);
+	test_datasize_valid("PAN Get Role+", HAL_SERVICE_ID_PAN,
+			HAL_OP_PAN_GET_ROLE,
+			0, 1,
+			HAL_SERVICE_ID_BLUETOOTH, HAL_SERVICE_ID_PAN);
+	test_datasize_valid("PAN Connect+", HAL_SERVICE_ID_PAN,
+			HAL_OP_PAN_CONNECT,
+			sizeof(struct hal_cmd_pan_connect), 1,
+			HAL_SERVICE_ID_BLUETOOTH, HAL_SERVICE_ID_PAN);
+	test_datasize_valid("PAN Connect-", HAL_SERVICE_ID_PAN,
+			HAL_OP_PAN_CONNECT,
+			sizeof(struct hal_cmd_pan_connect), -1,
+			HAL_SERVICE_ID_BLUETOOTH, HAL_SERVICE_ID_PAN);
+	test_datasize_valid("PAN Disconnect+", HAL_SERVICE_ID_PAN,
+			HAL_OP_PAN_DISCONNECT,
+			sizeof(struct hal_cmd_pan_disconnect), 1,
+			HAL_SERVICE_ID_BLUETOOTH, HAL_SERVICE_ID_PAN);
+	test_datasize_valid("PAN Disconnect-", HAL_SERVICE_ID_PAN,
+			HAL_OP_PAN_DISCONNECT,
+			sizeof(struct hal_cmd_pan_disconnect), -1,
+			HAL_SERVICE_ID_BLUETOOTH, HAL_SERVICE_ID_PAN);
+
 	return tester_run();
 }
-- 
1.8.5.2

