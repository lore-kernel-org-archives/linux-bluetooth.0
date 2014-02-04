Return-Path: <cyrus@holtmann.org>
From: Jakub Tyszkowski <jakub.tyszkowski@tieto.com>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH 07/11] android/unit: Add another case for variable sized data
Date: Tue,  4 Feb 2014 15:39:05 +0100
Message-Id: <1391524749-2518-7-git-send-email-jakub.tyszkowski@tieto.com>
In-Reply-To: <1391524749-2518-1-git-send-email-jakub.tyszkowski@tieto.com>
References: <1391524749-2518-1-git-send-email-jakub.tyszkowski@tieto.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

This patch adds test for variable length data handling. Handlers struct
have static values representing minimum payload. It cannot be predicted
how large data will be sent so they should accept data larger than
declared inside ipc_handler array, which holds the minimum size of such
message.
---
 android/test-ipc.c | 15 +++++++++++++++
 1 file changed, 15 insertions(+)

diff --git a/android/test-ipc.c b/android/test-ipc.c
index 523011e..2120d15 100644
--- a/android/test-ipc.c
+++ b/android/test-ipc.c
@@ -487,6 +487,18 @@ static const struct test_data test_cmd_vardata_valid = {
 	.handlers_size = 1,
 };
 
+static const struct ipc_handler cmd_vardata_handlers_valid2[] = {
+	{ test_cmd_handler_1, true, sizeof(VARDATA_EX1) - 1 }
+};
+
+static const struct test_data test_cmd_vardata_valid_2 = {
+	.cmd = &test_cmd_vardata,
+	.cmd_size = sizeof(struct hal_hdr) + sizeof(VARDATA_EX1),
+	.service = 0,
+	.handlers = cmd_vardata_handlers_valid2,
+	.handlers_size = 1,
+};
+
 int main(int argc, char *argv[])
 {
 	g_test_init(&argc, &argv, NULL);
@@ -511,6 +523,9 @@ int main(int argc, char *argv[])
 	g_test_add_data_func("/android_ipc/test_cmd_vardata_valid",
 					&test_cmd_vardata_valid,
 					test_cmd_reg);
+	g_test_add_data_func("/android_ipc/test_cmd_vardata_valid_2",
+					&test_cmd_vardata_valid_2,
+					test_cmd_reg);
 
 	return g_test_run();
 }
-- 
1.8.5.2

