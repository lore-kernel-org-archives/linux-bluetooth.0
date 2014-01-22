Return-Path: <cyrus@holtmann.org>
From: Jakub Tyszkowski <jakub.tyszkowski@tieto.com>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH 7/9] android/ipc-tester: Add cases for A2DP msg size
Date: Wed, 22 Jan 2014 09:25:22 +0100
Message-Id: <1390379124-16426-7-git-send-email-jakub.tyszkowski@tieto.com>
In-Reply-To: <1390379124-16426-1-git-send-email-jakub.tyszkowski@tieto.com>
References: <1390379124-16426-1-git-send-email-jakub.tyszkowski@tieto.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Add cases testing message size veification for A2DP opcodes.
---
 android/ipc-tester.c | 18 ++++++++++++++++++
 1 file changed, 18 insertions(+)

diff --git a/android/ipc-tester.c b/android/ipc-tester.c
index 11239e7..c621167 100644
--- a/android/ipc-tester.c
+++ b/android/ipc-tester.c
@@ -1133,5 +1133,23 @@ int main(int argc, char *argv[])
 			sizeof(struct hal_cmd_pan_disconnect), -1,
 			HAL_SERVICE_ID_BLUETOOTH, HAL_SERVICE_ID_PAN);
 
+	/* check for valid data size for A2DP */
+	test_datasize_valid("A2DP Connect+", HAL_SERVICE_ID_A2DP,
+			HAL_OP_A2DP_CONNECT,
+			sizeof(struct hal_cmd_a2dp_connect), 1,
+			HAL_SERVICE_ID_BLUETOOTH, HAL_SERVICE_ID_A2DP);
+	test_datasize_valid("A2DP Connect-", HAL_SERVICE_ID_A2DP,
+			HAL_OP_A2DP_CONNECT,
+			sizeof(struct hal_cmd_a2dp_connect), -1,
+			HAL_SERVICE_ID_BLUETOOTH, HAL_SERVICE_ID_A2DP);
+	test_datasize_valid("A2DP Disconnect+", HAL_SERVICE_ID_A2DP,
+			HAL_OP_A2DP_DISCONNECT,
+			sizeof(struct hal_cmd_a2dp_disconnect), 1,
+			HAL_SERVICE_ID_BLUETOOTH, HAL_SERVICE_ID_A2DP);
+	test_datasize_valid("A2DP Disconnect-", HAL_SERVICE_ID_A2DP,
+			HAL_OP_A2DP_DISCONNECT,
+			sizeof(struct hal_cmd_a2dp_disconnect), -1,
+			HAL_SERVICE_ID_BLUETOOTH, HAL_SERVICE_ID_A2DP);
+
 	return tester_run();
 }
-- 
1.8.5.2

