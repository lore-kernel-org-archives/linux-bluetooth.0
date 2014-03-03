Return-Path: <cyrus@holtmann.org>
From: Marcin Kraglak <marcin.kraglak@tieto.com>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH 3/7] unit/test-hfp: Add /hfp/test_cmd_handler_1
Date: Mon,  3 Mar 2014 09:36:48 +0100
Message-Id: <1393835812-24238-3-git-send-email-marcin.kraglak@tieto.com>
In-Reply-To: <1393835812-24238-1-git-send-email-marcin.kraglak@tieto.com>
References: <1393835812-24238-1-git-send-email-marcin.kraglak@tieto.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

---
 unit/test-hfp.c | 76 +++++++++++++++++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 76 insertions(+)

diff --git a/unit/test-hfp.c b/unit/test-hfp.c
index 092f255..8cbb524 100644
--- a/unit/test-hfp.c
+++ b/unit/test-hfp.c
@@ -39,6 +39,14 @@ struct context {
 	const struct test_data *data;
 };
 
+struct test_data {
+	hfp_command_func_t command_cb;
+	const char *server_send;
+	int data_len;
+	const char *expected_rsp;
+	int expected_rsp_len;
+};
+
 static void context_quit(struct context *context)
 {
 	g_main_loop_quit(context->main_loop);
@@ -49,11 +57,35 @@ static gboolean test_handler(GIOChannel *channel, GIOCondition cond,
 {
 	struct context *context = user_data;
 
+	if (context->data && context->data->expected_rsp) {
+		int fd = g_io_channel_unix_get_fd(channel);
+		char buf[1024];
+		int len;
+
+		len = read(fd, buf, sizeof(buf));
+		g_assert(context->data->expected_rsp_len == len);
+		g_assert(!memcmp(context->data->expected_rsp, buf, len));
+	}
+
 	context_quit(context);
 
 	return FALSE;
 }
 
+static void cmd_handler(const char *command, void *user_data)
+{
+	struct context *context = user_data;
+	int cmd_len;
+
+	cmd_len = strlen(command);
+
+	g_assert(cmd_len < context->data->data_len);
+
+	g_assert(!memcmp(command, context->data->server_send, cmd_len));
+
+	hfp_gw_send_result(context->hfp, HFP_RESULT_ERROR);
+}
+
 static struct context *create_context(gconstpointer data)
 {
 	struct context *context = g_new0(struct context, 1);
@@ -94,6 +126,9 @@ static void execute_context(struct context *context)
 
 	g_main_loop_unref(context->main_loop);
 
+	if (context->hfp)
+		hfp_gw_unref(context->hfp);
+
 	g_free(context);
 }
 
@@ -107,15 +142,56 @@ static void test_init(gconstpointer data)
 	g_assert(hfp_gw_set_close_on_unref(context->hfp, true));
 
 	hfp_gw_unref(context->hfp);
+	context->hfp = NULL;
+
+	execute_context(context);
+}
+
+static void test_command_handler(gconstpointer data)
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
+	if (context->data->server_send) {
+		ssize_t len;
+		len = write(context->fd_server, context->data->server_send,
+						context->data->data_len);
+
+		g_assert(len);
+	}
 
 	execute_context(context);
 }
 
+static const char err_rsp[] = {'\r', '\n', 'E', 'R', 'R', 'O', 'R', '\r', '\n'};
+
+static const char atbrsf[] = {'A', 'T', '+', 'B', 'R', 'S', 'F', '\r'};
+
+static const struct test_data test_cmd_handler_1 = {
+	.command_cb = cmd_handler,
+	.server_send = atbrsf,
+	.data_len = sizeof(atbrsf),
+	.expected_rsp = err_rsp,
+	.expected_rsp_len = sizeof(err_rsp)
+};
+
 int main(int argc, char *argv[])
 {
 	g_test_init(&argc, &argv, NULL);
 
 	g_test_add_data_func("/hfp/test_init", NULL, test_init);
 
+	g_test_add_data_func("/hfp/test_cmd_handler_1", &test_cmd_handler_1,
+							test_command_handler);
+
 	return g_test_run();
 }
-- 
1.8.3.1

