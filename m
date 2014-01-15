Return-Path: <cyrus@holtmann.org>
From: Marcin Kraglak <marcin.kraglak@tieto.com>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH 4/5] android/ipc-tester: Add test case to send cmd to registered service
Date: Wed, 15 Jan 2014 20:12:29 +0100
Message-Id: <1389813150-16914-4-git-send-email-marcin.kraglak@tieto.com>
In-Reply-To: <1389813150-16914-1-git-send-email-marcin.kraglak@tieto.com>
References: <1389813150-16914-1-git-send-email-marcin.kraglak@tieto.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

This will test sending command to previously registered service.
---
 android/test-android-ipc.c | 62 ++++++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 62 insertions(+)

diff --git a/android/test-android-ipc.c b/android/test-android-ipc.c
index 99f8559..930f9f4 100644
--- a/android/test-android-ipc.c
+++ b/android/test-android-ipc.c
@@ -46,6 +46,9 @@ struct test_data {
 	uint32_t expected_signal;
 	const struct hal_hdr *cmd;
 	uint16_t cmd_size;
+	uint8_t service;
+	const struct ipc_handler *handlers;
+	uint8_t handlers_size;
 };
 
 struct context {
@@ -74,11 +77,23 @@ static void context_quit(struct context *context)
 static gboolean cmd_watch(GIOChannel *io, GIOCondition cond,
 						gpointer user_data)
 {
+	struct context *context = user_data;
+	const struct test_data *test_data = context->data;
+	uint8_t buf[128];
+	int sk;
+
 	if (cond & (G_IO_HUP | G_IO_ERR | G_IO_NVAL)) {
 		g_assert(FALSE);
 		return FALSE;
 	}
 
+	sk = g_io_channel_unix_get_fd(io);
+
+	g_assert(read(sk, buf, sizeof(buf)) == test_data->cmd_size);
+	g_assert(!memcmp(test_data->cmd, buf, test_data->cmd_size));
+
+	context_quit(context);
+
 	return TRUE;
 }
 
@@ -280,6 +295,17 @@ static gboolean send_cmd(gpointer user_data)
 	return FALSE;
 }
 
+static gboolean register_service(gpointer user_data)
+{
+	struct context *context = user_data;
+	const struct test_data *test_data = context->data;
+
+	ipc_register(test_data->service, test_data->handlers,
+						test_data->handlers_size);
+
+	return FALSE;
+}
+
 static void test_cmd(gconstpointer data)
 {
 	struct context *context = create_context(data);
@@ -293,6 +319,28 @@ static void test_cmd(gconstpointer data)
 	ipc_cleanup();
 }
 
+static void test_cmd_reg(gconstpointer data)
+{
+	struct context *context = create_context(data);
+	const struct test_data *test_data = context->data;
+
+	ipc_init();
+
+	g_idle_add(register_service, context);
+	g_idle_add(send_cmd, context);
+
+	execute_context(context);
+
+	ipc_unregister(test_data->service);
+
+	ipc_cleanup();
+}
+
+static void test_cmd_handler(const void *buf, uint16_t len)
+{
+	ipc_send_rsp(0, 1, 0);
+}
+
 static const struct test_data test_init_1 = {};
 
 static const struct hal_hdr test_cmd_1_hdr = {
@@ -307,6 +355,18 @@ static const struct test_data test_cmd_1 = {
 	.expected_signal = SIGTERM
 };
 
+static const struct ipc_handler cmd_handlers[] = {
+	{ test_cmd_handler, false, 0 }
+};
+
+static const struct test_data test_cmd_2 = {
+	.cmd = &test_cmd_1_hdr,
+	.cmd_size = sizeof(test_cmd_1_hdr),
+	.service = 0,
+	.handlers = cmd_handlers,
+	.handlers_size = 1
+};
+
 int main(int argc, char *argv[])
 {
 	g_test_init(&argc, &argv, NULL);
@@ -316,6 +376,8 @@ int main(int argc, char *argv[])
 
 	g_test_add_data_func("/android_ipc/init", &test_init_1, test_init);
 	g_test_add_data_func("/android_ipc/send_cmd_1", &test_cmd_1, test_cmd);
+	g_test_add_data_func("/android_ipc/send_cmd_2", &test_cmd_2,
+							test_cmd_reg);
 
 	return g_test_run();
 }
-- 
1.8.3.1

