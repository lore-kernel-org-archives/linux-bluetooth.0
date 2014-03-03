Return-Path: <cyrus@holtmann.org>
From: Marcin Kraglak <marcin.kraglak@tieto.com>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH 4/7] unit/test-hfp: Add /hfp/test_cmd_handler_2
Date: Mon,  3 Mar 2014 09:36:49 +0100
Message-Id: <1393835812-24238-4-git-send-email-marcin.kraglak@tieto.com>
In-Reply-To: <1393835812-24238-1-git-send-email-marcin.kraglak@tieto.com>
References: <1393835812-24238-1-git-send-email-marcin.kraglak@tieto.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

---
 unit/test-hfp.c | 12 ++++++++++++
 1 file changed, 12 insertions(+)

diff --git a/unit/test-hfp.c b/unit/test-hfp.c
index 8cbb524..ef49b04 100644
--- a/unit/test-hfp.c
+++ b/unit/test-hfp.c
@@ -184,6 +184,16 @@ static const struct test_data test_cmd_handler_1 = {
 	.expected_rsp_len = sizeof(err_rsp)
 };
 
+static const char atd[] = {'A', 'T', 'D', '1', '2', '3', '4', '\r'};
+
+static const struct test_data test_cmd_handler_2 = {
+	.command_cb = cmd_handler,
+	.server_send = atd,
+	.data_len = sizeof(atd),
+	.expected_rsp = err_rsp,
+	.expected_rsp_len = sizeof(err_rsp)
+};
+
 int main(int argc, char *argv[])
 {
 	g_test_init(&argc, &argv, NULL);
@@ -192,6 +202,8 @@ int main(int argc, char *argv[])
 
 	g_test_add_data_func("/hfp/test_cmd_handler_1", &test_cmd_handler_1,
 							test_command_handler);
+	g_test_add_data_func("/hfp/test_cmd_handler_2", &test_cmd_handler_2,
+							test_command_handler);
 
 	return g_test_run();
 }
-- 
1.8.3.1

