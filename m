Return-Path: <cyrus@holtmann.org>
From: Marcin Kraglak <marcin.kraglak@tieto.com>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCHv3 5/5] android/unit: Add /android_ipc/send_cmd_3 test case
Date: Thu, 16 Jan 2014 11:05:02 +0100
Message-Id: <1389866702-30697-5-git-send-email-marcin.kraglak@tieto.com>
In-Reply-To: <1389866702-30697-1-git-send-email-marcin.kraglak@tieto.com>
References: <1389866702-30697-1-git-send-email-marcin.kraglak@tieto.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

This case will register service, next unregister it and send
command. Expected status is raise SIGTERM.
---
 android/test-ipc.c | 36 ++++++++++++++++++++++++++++++++++++
 1 file changed, 36 insertions(+)

diff --git a/android/test-ipc.c b/android/test-ipc.c
index 930f9f4..1fde61b 100644
--- a/android/test-ipc.c
+++ b/android/test-ipc.c
@@ -306,6 +306,16 @@ static gboolean register_service(gpointer user_data)
 	return FALSE;
 }
 
+static gboolean unregister_service(gpointer user_data)
+{
+	struct context *context = user_data;
+	const struct test_data *test_data = context->data;
+
+	ipc_unregister(test_data->service);
+
+	return FALSE;
+}
+
 static void test_cmd(gconstpointer data)
 {
 	struct context *context = create_context(data);
@@ -336,6 +346,21 @@ static void test_cmd_reg(gconstpointer data)
 	ipc_cleanup();
 }
 
+static void test_cmd_reg_1(gconstpointer data)
+{
+	struct context *context = create_context(data);
+
+	ipc_init();
+
+	g_idle_add(register_service, context);
+	g_idle_add(unregister_service, context);
+	g_idle_add(send_cmd, context);
+
+	execute_context(context);
+
+	ipc_cleanup();
+}
+
 static void test_cmd_handler(const void *buf, uint16_t len)
 {
 	ipc_send_rsp(0, 1, 0);
@@ -367,6 +392,15 @@ static const struct test_data test_cmd_2 = {
 	.handlers_size = 1
 };
 
+static const struct test_data test_cmd_3 = {
+	.cmd = &test_cmd_1_hdr,
+	.cmd_size = sizeof(test_cmd_1_hdr),
+	.service = 0,
+	.handlers = cmd_handlers,
+	.handlers_size = 1,
+	.expected_signal = SIGTERM
+};
+
 int main(int argc, char *argv[])
 {
 	g_test_init(&argc, &argv, NULL);
@@ -378,6 +412,8 @@ int main(int argc, char *argv[])
 	g_test_add_data_func("/android_ipc/send_cmd_1", &test_cmd_1, test_cmd);
 	g_test_add_data_func("/android_ipc/send_cmd_2", &test_cmd_2,
 							test_cmd_reg);
+	g_test_add_data_func("/android_ipc/send_cmd_3", &test_cmd_3,
+							test_cmd_reg_1);
 
 	return g_test_run();
 }
-- 
1.8.3.1

