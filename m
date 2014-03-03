Return-Path: <cyrus@holtmann.org>
From: Marcin Kraglak <marcin.kraglak@tieto.com>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH 7/7] Add /hfp/test_hfp_gw_register_3 and /hfp/test_hfp_gw_register_4
Date: Mon,  3 Mar 2014 09:36:52 +0100
Message-Id: <1393835812-24238-7-git-send-email-marcin.kraglak@tieto.com>
In-Reply-To: <1393835812-24238-1-git-send-email-marcin.kraglak@tieto.com>
References: <1393835812-24238-1-git-send-email-marcin.kraglak@tieto.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

---
 unit/test-hfp.c | 31 +++++++++++++++++++++++++++++++
 1 file changed, 31 insertions(+)

diff --git a/unit/test-hfp.c b/unit/test-hfp.c
index 5e4fc11..64ecc60 100644
--- a/unit/test-hfp.c
+++ b/unit/test-hfp.c
@@ -266,6 +266,33 @@ static const struct test_data test_register_2 = {
 	.prefix = prefix_brsf
 };
 
+static const char atbrsf_read[] = {'A', 'T', '+', 'B', 'R', 'S', 'F', '?',
+									'\r'};
+
+static const struct test_data test_register_3 = {
+	.command_cb = cmd_handler,
+	.server_send = atbrsf_read,
+	.data_len = sizeof(atbrsf_read),
+	.expected_rsp = err_rsp,
+	.expected_rsp_len = sizeof(err_rsp),
+	.result_cb = prefix_handler,
+	.expected_cmd_type = HFP_GW_CMD_TYPE_READ,
+	.prefix = prefix_brsf
+};
+
+static const char prefix_d[] = "D";
+
+static const struct test_data test_register_4 = {
+	.command_cb = cmd_handler,
+	.server_send = atd,
+	.data_len = sizeof(atd),
+	.expected_rsp = err_rsp,
+	.expected_rsp_len = sizeof(err_rsp),
+	.result_cb = prefix_handler,
+	.expected_cmd_type = HFP_GW_CMD_TYPE_SET,
+	.prefix = prefix_d
+};
+
 int main(int argc, char *argv[])
 {
 	g_test_init(&argc, &argv, NULL);
@@ -281,6 +308,10 @@ int main(int argc, char *argv[])
 							test_register);
 	g_test_add_data_func("/hfp/test_hfp_gw_register_2", &test_register_2,
 							test_register);
+	g_test_add_data_func("/hfp/test_hfp_gw_register_3", &test_register_3,
+							test_register);
+	g_test_add_data_func("/hfp/test_hfp_gw_register_4", &test_register_4,
+							test_register);
 
 	return g_test_run();
 }
-- 
1.8.3.1

