Return-Path: <cyrus@holtmann.org>
From: Jakub Tyszkowski <jakub.tyszkowski@tieto.com>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH 11/11] android/unit: Add cases for msg size verification
Date: Tue,  4 Feb 2014 15:39:09 +0100
Message-Id: <1391524749-2518-11-git-send-email-jakub.tyszkowski@tieto.com>
In-Reply-To: <1391524749-2518-1-git-send-email-jakub.tyszkowski@tieto.com>
References: <1391524749-2518-1-git-send-email-jakub.tyszkowski@tieto.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

This patch adds checking for proper msg size verification in case it is
not declared in handlers that this is variable sized message. In
such case malformed data should not be accepted.
---
 android/test-ipc.c | 38 ++++++++++++++++++++++++++++++++++++++
 1 file changed, 38 insertions(+)

diff --git a/android/test-ipc.c b/android/test-ipc.c
index d05544d..a276063 100644
--- a/android/test-ipc.c
+++ b/android/test-ipc.c
@@ -532,6 +532,38 @@ static const struct test_data test_cmd_service_offrange = {
 	.expected_signal = SIGTERM
 };
 
+static const struct vardata test_cmd_invalid_data_1 = {
+	.hdr.service_id = 0,
+	.hdr.opcode = 1,
+	.hdr.len = sizeof(VARDATA_EX1),
+	.data = VARDATA_EX1,
+};
+
+static const struct test_data test_cmd_msg_invalid_1 = {
+	.cmd = &test_cmd_invalid_data_1,
+	.cmd_size = sizeof(struct hal_hdr) + sizeof(VARDATA_EX1) - 1,
+	.service = 0,
+	.handlers = cmd_handlers,
+	.handlers_size = 1,
+	.expected_signal = SIGTERM
+};
+
+static const struct vardata test_cmd_invalid_data_2 = {
+	.hdr.service_id = 0,
+	.hdr.opcode = 1,
+	.hdr.len = sizeof(VARDATA_EX1) - 1,
+	.data = VARDATA_EX1,
+};
+
+static const struct test_data test_cmd_msg_invalid_2 = {
+	.cmd = &test_cmd_invalid_data_2,
+	.cmd_size = sizeof(struct hal_hdr) + sizeof(VARDATA_EX1),
+	.service = 0,
+	.handlers = cmd_handlers,
+	.handlers_size = 1,
+	.expected_signal = SIGTERM
+};
+
 int main(int argc, char *argv[])
 {
 	g_test_init(&argc, &argv, NULL);
@@ -568,6 +600,12 @@ int main(int argc, char *argv[])
 	g_test_add_data_func("/android_ipc/test_cmd_hdr_invalid",
 					&test_cmd_hdr_invalid,
 					test_cmd_reg);
+	g_test_add_data_func("/android_ipc/test_cmd_msg_invalid_1",
+					&test_cmd_msg_invalid_1,
+					test_cmd_reg);
+	g_test_add_data_func("/android_ipc/test_cmd_msg_invalid_2",
+					&test_cmd_msg_invalid_2,
+					test_cmd_reg);
 
 	return g_test_run();
 }
-- 
1.8.5.2

