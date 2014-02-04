Return-Path: <cyrus@holtmann.org>
From: Jakub Tyszkowski <jakub.tyszkowski@tieto.com>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH 10/11] android/unit: Add case for sending incomplete header
Date: Tue,  4 Feb 2014 15:39:08 +0100
Message-Id: <1391524749-2518-10-git-send-email-jakub.tyszkowski@tieto.com>
In-Reply-To: <1391524749-2518-1-git-send-email-jakub.tyszkowski@tieto.com>
References: <1391524749-2518-1-git-send-email-jakub.tyszkowski@tieto.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Header size is the bare minimum that should always be sent.
---
 android/test-ipc.c | 12 ++++++++++++
 1 file changed, 12 insertions(+)

diff --git a/android/test-ipc.c b/android/test-ipc.c
index e4463eb..d05544d 100644
--- a/android/test-ipc.c
+++ b/android/test-ipc.c
@@ -461,6 +461,15 @@ static const struct test_data test_cmd_opcode_invalid_1 = {
 	.expected_signal = SIGTERM
 };
 
+static const struct test_data test_cmd_hdr_invalid = {
+	.cmd = &test_cmd_1_hdr,
+	.cmd_size = sizeof(test_cmd_1_hdr) - 1,
+	.service = 0,
+	.handlers = cmd_handlers,
+	.handlers_size = 1,
+	.expected_signal = SIGTERM
+};
+
 #define VARDATA_EX1 "some data example"
 
 struct vardata {
@@ -556,6 +565,9 @@ int main(int argc, char *argv[])
 	g_test_add_data_func("/android_ipc/test_cmd_service_offrange",
 					&test_cmd_service_offrange,
 					test_cmd_reg);
+	g_test_add_data_func("/android_ipc/test_cmd_hdr_invalid",
+					&test_cmd_hdr_invalid,
+					test_cmd_reg);
 
 	return g_test_run();
 }
-- 
1.8.5.2

