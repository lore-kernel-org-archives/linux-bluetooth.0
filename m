Return-Path: <cyrus@holtmann.org>
From: Marcin Kraglak <marcin.kraglak@tieto.com>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH 6/7] unit/test-hfp: Add /hfp/test_hfp_gw_register_2
Date: Mon,  3 Mar 2014 09:36:51 +0100
Message-Id: <1393835812-24238-6-git-send-email-marcin.kraglak@tieto.com>
In-Reply-To: <1393835812-24238-1-git-send-email-marcin.kraglak@tieto.com>
References: <1393835812-24238-1-git-send-email-marcin.kraglak@tieto.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

---
 unit/test-hfp.c | 16 ++++++++++++++++
 1 file changed, 16 insertions(+)

diff --git a/unit/test-hfp.c b/unit/test-hfp.c
index cbc3a12..5e4fc11 100644
--- a/unit/test-hfp.c
+++ b/unit/test-hfp.c
@@ -252,6 +252,20 @@ static const struct test_data test_register_1 = {
 	.prefix = prefix_brsf
 };
 
+static const char atbrsf_test[] = {'A', 'T', '+', 'B', 'R', 'S', 'F', '=', '?',
+									'\r'};
+
+static const struct test_data test_register_2 = {
+	.command_cb = cmd_handler,
+	.server_send = atbrsf_test,
+	.data_len = sizeof(atbrsf_test),
+	.expected_rsp = err_rsp,
+	.expected_rsp_len = sizeof(err_rsp),
+	.result_cb = prefix_handler,
+	.expected_cmd_type = HFP_GW_CMD_TYPE_TEST,
+	.prefix = prefix_brsf
+};
+
 int main(int argc, char *argv[])
 {
 	g_test_init(&argc, &argv, NULL);
@@ -265,6 +279,8 @@ int main(int argc, char *argv[])
 
 	g_test_add_data_func("/hfp/test_hfp_gw_register_1", &test_register_1,
 							test_register);
+	g_test_add_data_func("/hfp/test_hfp_gw_register_2", &test_register_2,
+							test_register);
 
 	return g_test_run();
 }
-- 
1.8.3.1

