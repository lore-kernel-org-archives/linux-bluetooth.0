Return-Path: <cyrus@holtmann.org>
From: Jakub Tyszkowski <jakub.tyszkowski@tieto.com>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH 04/11] android/unit: Add case for opcode without handler
Date: Tue,  4 Feb 2014 15:39:02 +0100
Message-Id: <1391524749-2518-4-git-send-email-jakub.tyszkowski@tieto.com>
In-Reply-To: <1391524749-2518-1-git-send-email-jakub.tyszkowski@tieto.com>
References: <1391524749-2518-1-git-send-email-jakub.tyszkowski@tieto.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

This test case checks if IPC shuts down on unhandled opcode.
---
 android/test-ipc.c | 12 ++++++++++++
 1 file changed, 12 insertions(+)

diff --git a/android/test-ipc.c b/android/test-ipc.c
index 1e027fa..cb6f518 100644
--- a/android/test-ipc.c
+++ b/android/test-ipc.c
@@ -445,6 +445,15 @@ static const struct test_data test_cmd_opcode_valid_2 = {
 	.handlers_size = 2,
 };
 
+static const struct test_data test_cmd_opcode_invalid_1 = {
+	.cmd = &test_cmd_2_hdr,
+	.cmd_size = sizeof(test_cmd_2_hdr),
+	.service = 0,
+	.handlers = cmd_handlers,
+	.handlers_size = 1,
+	.expected_signal = SIGTERM
+};
+
 int main(int argc, char *argv[])
 {
 	g_test_init(&argc, &argv, NULL);
@@ -463,6 +472,9 @@ int main(int argc, char *argv[])
 					&test_cmd_opcode_valid_1, test_cmd_reg);
 	g_test_add_data_func("/android_ipc/test_cmd_opcode_valid_2",
 					&test_cmd_opcode_valid_2, test_cmd_reg);
+	g_test_add_data_func("/android_ipc/test_cmd_opcode_invalid_1",
+					&test_cmd_opcode_invalid_1,
+					test_cmd_reg);
 
 	return g_test_run();
 }
-- 
1.8.5.2

