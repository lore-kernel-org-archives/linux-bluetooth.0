Return-Path: <cyrus@holtmann.org>
From: Marcin Kraglak <marcin.kraglak@tieto.com>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCHv3 3/5] android/unit: Add /android_ipc/send_cmd_1 test case
Date: Thu, 16 Jan 2014 11:05:00 +0100
Message-Id: <1389866702-30697-3-git-send-email-marcin.kraglak@tieto.com>
In-Reply-To: <1389866702-30697-1-git-send-email-marcin.kraglak@tieto.com>
References: <1389866702-30697-1-git-send-email-marcin.kraglak@tieto.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

This test case will check if ipc lib will raise SIGTERM
after sending command to not registered service.
---
 android/test-ipc.c | 46 +++++++++++++++++++++++++++++++++++++++++++++-
 1 file changed, 45 insertions(+), 1 deletion(-)

diff --git a/android/test-ipc.c b/android/test-ipc.c
index 6ac1175..99f8559 100644
--- a/android/test-ipc.c
+++ b/android/test-ipc.c
@@ -44,6 +44,8 @@
 
 struct test_data {
 	uint32_t expected_signal;
+	const struct hal_hdr *cmd;
+	uint16_t cmd_size;
 };
 
 struct context {
@@ -95,6 +97,7 @@ static gboolean connect_handler(GIOChannel *io, GIOCondition cond,
 						gpointer user_data)
 {
 	struct context *context = user_data;
+	const struct test_data *test_data = context->data;
 	GIOChannel *new_io;
 	GIOCondition watch_cond;
 	int sk;
@@ -126,7 +129,7 @@ static gboolean connect_handler(GIOChannel *io, GIOCondition cond,
 		context->cmd_io = new_io;
 	}
 
-	if (context->cmd_source && context->notif_source)
+	if (context->cmd_source && context->notif_source && !test_data->cmd)
 		context_quit(context);
 
 	return TRUE;
@@ -262,8 +265,48 @@ static void test_init(gconstpointer data)
 	ipc_cleanup();
 }
 
+static gboolean send_cmd(gpointer user_data)
+{
+	struct context *context = user_data;
+	const struct test_data *test_data = context->data;
+	int sk;
+
+	sk = g_io_channel_unix_get_fd(context->cmd_io);
+	g_assert(sk >= 0);
+
+	g_assert(write(sk, test_data->cmd, test_data->cmd_size) ==
+						test_data->cmd_size);
+
+	return FALSE;
+}
+
+static void test_cmd(gconstpointer data)
+{
+	struct context *context = create_context(data);
+
+	ipc_init();
+
+	g_idle_add(send_cmd, context);
+
+	execute_context(context);
+
+	ipc_cleanup();
+}
+
 static const struct test_data test_init_1 = {};
 
+static const struct hal_hdr test_cmd_1_hdr = {
+	.service_id = 0,
+	.opcode = 1,
+	.len = 0
+};
+
+static const struct test_data test_cmd_1 = {
+	.cmd = &test_cmd_1_hdr,
+	.cmd_size = sizeof(test_cmd_1_hdr),
+	.expected_signal = SIGTERM
+};
+
 int main(int argc, char *argv[])
 {
 	g_test_init(&argc, &argv, NULL);
@@ -272,6 +315,7 @@ int main(int argc, char *argv[])
 		__btd_log_init("*", 0);
 
 	g_test_add_data_func("/android_ipc/init", &test_init_1, test_init);
+	g_test_add_data_func("/android_ipc/send_cmd_1", &test_cmd_1, test_cmd);
 
 	return g_test_run();
 }
-- 
1.8.3.1

