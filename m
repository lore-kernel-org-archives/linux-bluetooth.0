Return-Path: <cyrus@holtmann.org>
From: Jakub Tyszkowski <jakub.tyszkowski@tieto.com>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCHv5 09/11] android/ipc-tester: Add cases for service opcode boundaries
Date: Mon, 20 Jan 2014 10:36:08 +0100
Message-Id: <1390210570-28260-10-git-send-email-jakub.tyszkowski@tieto.com>
In-Reply-To: <1390210570-28260-1-git-send-email-jakub.tyszkowski@tieto.com>
References: <1390210570-28260-1-git-send-email-jakub.tyszkowski@tieto.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

This patch adds tests sending out of range opcode for each service.
---
 android/ipc-tester.c | 32 ++++++++++++++++++++++++++++++++
 1 file changed, 32 insertions(+)

diff --git a/android/ipc-tester.c b/android/ipc-tester.c
index db0a30a..cebe751 100644
--- a/android/ipc-tester.c
+++ b/android/ipc-tester.c
@@ -558,6 +558,21 @@ static void ipc_send_tc(const void *data)
 				3, user, g_free);			\
 	} while (0)
 
+#define test_opcode_valid(_name, _service, _opcode, _len, _servicelist...) \
+	do {								\
+		static struct hal_hdr hdr = {				\
+			.service_id = _service,				\
+			.opcode = _opcode,				\
+			.len = _len,					\
+		};							\
+									\
+		test_generic("Opcode out of range: "_name,		\
+				ipc_send_tc, setup, teardown,		\
+				&hdr,					\
+				sizeof(hdr),				\
+				_servicelist);				\
+	} while (0)
+
 struct regmod_msg register_bt_msg = {
 	.header = {
 		.service_id = HAL_SERVICE_ID_CORE,
@@ -654,5 +669,22 @@ int main(int argc, char *argv[])
 				&enable_bt_service_hdr,
 				sizeof(enable_bt_service_hdr));
 
+	/* check service handler's max opcode value */
+	test_opcode_valid("CORE", HAL_SERVICE_ID_CORE, 0x03, 0);
+
+	test_opcode_valid("BLUETOOTH", HAL_SERVICE_ID_BLUETOOTH, 0x15, 0,
+			HAL_SERVICE_ID_BLUETOOTH);
+
+	test_opcode_valid("SOCK", HAL_SERVICE_ID_SOCK, 0x03, 0,
+			HAL_SERVICE_ID_BLUETOOTH, HAL_SERVICE_ID_SOCK);
+
+	test_opcode_valid("HIDHOST", HAL_SERVICE_ID_HIDHOST, 0x10, 0,
+			HAL_SERVICE_ID_BLUETOOTH, HAL_SERVICE_ID_HIDHOST);
+
+	test_opcode_valid("PAN", HAL_SERVICE_ID_PAN, 0x05, 0,
+			HAL_SERVICE_ID_BLUETOOTH, HAL_SERVICE_ID_PAN);
+
+	test_opcode_valid("A2DP", HAL_SERVICE_ID_A2DP, 0x03, 0,
+			HAL_SERVICE_ID_BLUETOOTH, HAL_SERVICE_ID_A2DP);
 	return tester_run();
 }
-- 
1.8.5.2

