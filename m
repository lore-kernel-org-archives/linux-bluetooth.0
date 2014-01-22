Return-Path: <cyrus@holtmann.org>
From: Jakub Tyszkowski <jakub.tyszkowski@tieto.com>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH 2/9] android/ipc-tester: Add cases for HIDHOST msg size
Date: Wed, 22 Jan 2014 09:25:17 +0100
Message-Id: <1390379124-16426-2-git-send-email-jakub.tyszkowski@tieto.com>
In-Reply-To: <1390379124-16426-1-git-send-email-jakub.tyszkowski@tieto.com>
References: <1390379124-16426-1-git-send-email-jakub.tyszkowski@tieto.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Add cases testing message size verification for HIDHOST opcodes.
---
 android/ipc-tester.c | 74 ++++++++++++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 74 insertions(+)

diff --git a/android/ipc-tester.c b/android/ipc-tester.c
index 088c324..2871587 100644
--- a/android/ipc-tester.c
+++ b/android/ipc-tester.c
@@ -882,5 +882,79 @@ int main(int argc, char *argv[])
 			sizeof(struct hal_cmd_sock_connect), -1,
 			HAL_SERVICE_ID_BLUETOOTH, HAL_SERVICE_ID_SOCK);
 
+	/* check for valid data size for HID Host */
+	test_datasize_valid("HIDHOST Connect+", HAL_SERVICE_ID_HIDHOST,
+			HAL_OP_HIDHOST_CONNECT,
+			sizeof(struct hal_cmd_hidhost_connect), 1,
+			HAL_SERVICE_ID_BLUETOOTH, HAL_SERVICE_ID_HIDHOST);
+	test_datasize_valid("HIDHOST Connect-", HAL_SERVICE_ID_HIDHOST,
+			HAL_OP_HIDHOST_CONNECT,
+			sizeof(struct hal_cmd_hidhost_connect), -1,
+			HAL_SERVICE_ID_BLUETOOTH, HAL_SERVICE_ID_HIDHOST);
+	test_datasize_valid("HIDHOST Disconnect+", HAL_SERVICE_ID_HIDHOST,
+			HAL_OP_HIDHOST_DISCONNECT,
+			sizeof(struct hal_cmd_hidhost_disconnect), 1,
+			HAL_SERVICE_ID_BLUETOOTH, HAL_SERVICE_ID_HIDHOST);
+	test_datasize_valid("HIDHOST Disconnect-", HAL_SERVICE_ID_HIDHOST,
+			HAL_OP_HIDHOST_DISCONNECT,
+			sizeof(struct hal_cmd_hidhost_disconnect), -1,
+			HAL_SERVICE_ID_BLUETOOTH, HAL_SERVICE_ID_HIDHOST);
+	test_datasize_valid("HIDHOST Virt. Unplug+", HAL_SERVICE_ID_HIDHOST,
+			HAL_OP_HIDHOST_VIRTUAL_UNPLUG,
+			sizeof(struct hal_cmd_hidhost_virtual_unplug), 1,
+			HAL_SERVICE_ID_BLUETOOTH, HAL_SERVICE_ID_HIDHOST);
+	test_datasize_valid("HIDHOST Virt. Unplug-", HAL_SERVICE_ID_HIDHOST,
+			HAL_OP_HIDHOST_VIRTUAL_UNPLUG,
+			sizeof(struct hal_cmd_hidhost_virtual_unplug), -1,
+			HAL_SERVICE_ID_BLUETOOTH, HAL_SERVICE_ID_HIDHOST);
+	test_datasize_valid("HIDHOST Set Info+", HAL_SERVICE_ID_HIDHOST,
+			HAL_OP_HIDHOST_SET_INFO,
+			sizeof(struct hal_cmd_hidhost_set_info), 1,
+			HAL_SERVICE_ID_BLUETOOTH, HAL_SERVICE_ID_HIDHOST);
+	test_datasize_valid("HIDHOST Set Info-", HAL_SERVICE_ID_HIDHOST,
+			HAL_OP_HIDHOST_SET_INFO,
+			sizeof(struct hal_cmd_hidhost_set_info), -1,
+			HAL_SERVICE_ID_BLUETOOTH, HAL_SERVICE_ID_HIDHOST);
+	test_datasize_valid("HIDHOST Get Protocol+", HAL_SERVICE_ID_HIDHOST,
+			HAL_OP_HIDHOST_GET_PROTOCOL,
+			sizeof(struct hal_cmd_hidhost_get_protocol), 1,
+			HAL_SERVICE_ID_BLUETOOTH, HAL_SERVICE_ID_HIDHOST);
+	test_datasize_valid("HIDHOST Get Protocol-", HAL_SERVICE_ID_HIDHOST,
+			HAL_OP_HIDHOST_GET_PROTOCOL,
+			sizeof(struct hal_cmd_hidhost_get_protocol), -1,
+			HAL_SERVICE_ID_BLUETOOTH, HAL_SERVICE_ID_HIDHOST);
+	test_datasize_valid("HIDHOST Set Protocol+", HAL_SERVICE_ID_HIDHOST,
+			HAL_OP_HIDHOST_SET_PROTOCOL,
+			sizeof(struct hal_cmd_hidhost_set_protocol), 1,
+			HAL_SERVICE_ID_BLUETOOTH, HAL_SERVICE_ID_HIDHOST);
+	test_datasize_valid("HIDHOST Set Protocol-", HAL_SERVICE_ID_HIDHOST,
+			HAL_OP_HIDHOST_SET_PROTOCOL,
+			sizeof(struct hal_cmd_hidhost_set_protocol), -1,
+			HAL_SERVICE_ID_BLUETOOTH, HAL_SERVICE_ID_HIDHOST);
+	test_datasize_valid("HIDHOST Get Report+", HAL_SERVICE_ID_HIDHOST,
+			HAL_OP_HIDHOST_GET_REPORT,
+			sizeof(struct hal_cmd_hidhost_get_report), 1,
+			HAL_SERVICE_ID_BLUETOOTH, HAL_SERVICE_ID_HIDHOST);
+	test_datasize_valid("HIDHOST Get Report-", HAL_SERVICE_ID_HIDHOST,
+			HAL_OP_HIDHOST_GET_REPORT,
+			sizeof(struct hal_cmd_hidhost_get_report), -1,
+			HAL_SERVICE_ID_BLUETOOTH, HAL_SERVICE_ID_HIDHOST);
+	test_datasize_valid("HIDHOST Set Report+", HAL_SERVICE_ID_HIDHOST,
+			HAL_OP_HIDHOST_SET_REPORT,
+			sizeof(struct hal_cmd_hidhost_set_report), 1,
+			HAL_SERVICE_ID_BLUETOOTH, HAL_SERVICE_ID_HIDHOST);
+	test_datasize_valid("HIDHOST Set Report-", HAL_SERVICE_ID_HIDHOST,
+			HAL_OP_HIDHOST_SET_REPORT,
+			sizeof(struct hal_cmd_hidhost_set_report), -1,
+			HAL_SERVICE_ID_BLUETOOTH, HAL_SERVICE_ID_HIDHOST);
+	test_datasize_valid("HIDHOST Send Data+", HAL_SERVICE_ID_HIDHOST,
+			HAL_OP_HIDHOST_SEND_DATA,
+			sizeof(struct hal_cmd_hidhost_send_data), 1,
+			HAL_SERVICE_ID_BLUETOOTH, HAL_SERVICE_ID_HIDHOST);
+	test_datasize_valid("HIDHOST Send Data-", HAL_SERVICE_ID_HIDHOST,
+			HAL_OP_HIDHOST_SEND_DATA,
+			sizeof(struct hal_cmd_hidhost_send_data), -1,
+			HAL_SERVICE_ID_BLUETOOTH, HAL_SERVICE_ID_HIDHOST);
+
 	return tester_run();
 }
-- 
1.8.5.2

