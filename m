Return-Path: <cyrus@holtmann.org>
From: Marcin Kraglak <marcin.kraglak@tieto.com>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH 5/7] unit/test-hfp: Add /hfp/test_hfp_gw_register_1
Date: Mon,  3 Mar 2014 09:36:50 +0100
Message-Id: <1393835812-24238-5-git-send-email-marcin.kraglak@tieto.com>
In-Reply-To: <1393835812-24238-1-git-send-email-marcin.kraglak@tieto.com>
References: <1393835812-24238-1-git-send-email-marcin.kraglak@tieto.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

---
 unit/test-hfp.c | 61 +++++++++++++++++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 61 insertions(+)

diff --git a/unit/test-hfp.c b/unit/test-hfp.c
index ef49b04..cbc3a12 100644
--- a/unit/test-hfp.c
+++ b/unit/test-hfp.c
@@ -41,6 +41,9 @@ struct context {
 
 struct test_data {
 	hfp_command_func_t command_cb;
+	hfp_result_func_t result_cb;
+	const char *prefix;
+	enum hfp_gw_cmd_type expected_cmd_type;
 	const char *server_send;
 	int data_len;
 	const char *expected_rsp;
@@ -86,6 +89,16 @@ static void cmd_handler(const char *command, void *user_data)
 	hfp_gw_send_result(context->hfp, HFP_RESULT_ERROR);
 }
 
+static void prefix_handler(struct hfp_gw_result *result,
+				enum hfp_gw_cmd_type type, void *user_data)
+{
+	struct context *context = user_data;
+
+	g_assert(type == context->data->expected_cmd_type);
+
+	hfp_gw_send_result(context->hfp, HFP_RESULT_ERROR);
+}
+
 static struct context *create_context(gconstpointer data)
 {
 	struct context *context = g_new0(struct context, 1);
@@ -172,6 +185,37 @@ static void test_command_handler(gconstpointer data)
 	execute_context(context);
 }
 
+static void test_register(gconstpointer data)
+{
+	struct context *context = create_context(data);
+
+	context->hfp = hfp_gw_new(context->fd_client);
+
+	g_assert(context->hfp);
+	g_assert(hfp_gw_set_close_on_unref(context->hfp, true));
+
+	if (context->data->command_cb)
+		g_assert(hfp_gw_set_command_handler(context->hfp,
+						context->data->command_cb,
+						context, NULL));
+
+	if (context->data->result_cb)
+		g_assert(hfp_gw_register(context->hfp,
+						context->data->result_cb,
+						context->data->prefix,
+						context, NULL));
+
+	if (context->data->data_len) {
+		ssize_t len;
+		len = write(context->fd_server, context->data->server_send,
+						context->data->data_len);
+
+		g_assert(len);
+	}
+
+	execute_context(context);
+}
+
 static const char err_rsp[] = {'\r', '\n', 'E', 'R', 'R', 'O', 'R', '\r', '\n'};
 
 static const char atbrsf[] = {'A', 'T', '+', 'B', 'R', 'S', 'F', '\r'};
@@ -194,6 +238,20 @@ static const struct test_data test_cmd_handler_2 = {
 	.expected_rsp_len = sizeof(err_rsp)
 };
 
+static const char prefix_brsf[] = "+BRSF";
+static const char atbrsf_set[] = {'A', 'T', '+', 'B', 'R', 'S', 'F', '=', '\r'};
+
+static const struct test_data test_register_1 = {
+	.command_cb = cmd_handler,
+	.server_send = atbrsf_set,
+	.data_len = sizeof(atbrsf_set),
+	.expected_rsp = err_rsp,
+	.expected_rsp_len = sizeof(err_rsp),
+	.result_cb = prefix_handler,
+	.expected_cmd_type = HFP_GW_CMD_TYPE_SET,
+	.prefix = prefix_brsf
+};
+
 int main(int argc, char *argv[])
 {
 	g_test_init(&argc, &argv, NULL);
@@ -205,5 +263,8 @@ int main(int argc, char *argv[])
 	g_test_add_data_func("/hfp/test_cmd_handler_2", &test_cmd_handler_2,
 							test_command_handler);
 
+	g_test_add_data_func("/hfp/test_hfp_gw_register_1", &test_register_1,
+							test_register);
+
 	return g_test_run();
 }
-- 
1.8.3.1

