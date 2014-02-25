Return-Path: <cyrus@holtmann.org>
From: Szymon Janc <szymon.janc@tieto.com>
To: linux-bluetooth@vger.kernel.org
Cc: Szymon Janc <szymon.janc@tieto.com>
Subject: [RFC 3/7] android/unit: Update test-ipc with failure handler support
Date: Tue, 25 Feb 2014 11:50:15 +0100
Message-Id: <1393325419-16544-3-git-send-email-szymon.janc@tieto.com>
In-Reply-To: <1393325419-16544-1-git-send-email-szymon.janc@tieto.com>
References: <1393325419-16544-1-git-send-email-szymon.janc@tieto.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

---
 android/test-ipc.c | 117 +++++++++++++++++------------------------------------
 1 file changed, 37 insertions(+), 80 deletions(-)

diff --git a/android/test-ipc.c b/android/test-ipc.c
index 054af84..84cb764 100644
--- a/android/test-ipc.c
+++ b/android/test-ipc.c
@@ -35,7 +35,6 @@
 #include <fcntl.h>
 #include <sys/socket.h>
 #include <sys/un.h>
-#include <sys/signalfd.h>
 
 #include <glib.h>
 #include "src/shared/util.h"
@@ -43,10 +42,8 @@
 #include "android/hal-msg.h"
 #include "android/ipc.h"
 
-static struct ipc *ipc = NULL;
-
 struct test_data {
-	uint32_t expected_signal;
+	bool disconnect;
 	const void *cmd;
 	uint16_t cmd_size;
 	uint8_t service;
@@ -65,13 +62,13 @@ struct context {
 
 	GIOChannel *cmd_io;
 	GIOChannel *notif_io;
-	GIOChannel *signal_io;
-
-	guint signal_source;
 
 	const struct test_data *data;
 };
 
+
+static struct ipc *ipc = NULL;
+
 static void context_quit(struct context *context)
 {
 	g_main_loop_quit(context->main_loop);
@@ -92,13 +89,13 @@ static gboolean cmd_watch(GIOChannel *io, GIOCondition cond,
 		.len = 0,
 	};
 
-	g_assert(test_data->expected_signal == 0);
-
 	if (cond & (G_IO_HUP | G_IO_ERR | G_IO_NVAL)) {
-		g_assert(FALSE);
+		g_assert(test_data->disconnect);
 		return FALSE;
 	}
 
+	g_assert(!test_data->disconnect);
+
 	sk = g_io_channel_unix_get_fd(io);
 
 	g_assert(read(sk, buf, sizeof(buf)) == sizeof(struct hal_hdr));
@@ -112,11 +109,16 @@ static gboolean cmd_watch(GIOChannel *io, GIOCondition cond,
 static gboolean notif_watch(GIOChannel *io, GIOCondition cond,
 							gpointer user_data)
 {
+	struct context *context = user_data;
+	const struct test_data *test_data = context->data;
+
 	if (cond & (G_IO_HUP | G_IO_ERR | G_IO_NVAL)) {
-		g_assert(FALSE);
+		g_assert(test_data->disconnect);
 		return FALSE;
 	}
 
+	g_assert(!test_data->disconnect);
+
 	return TRUE;
 }
 
@@ -162,62 +164,6 @@ static gboolean connect_handler(GIOChannel *io, GIOCondition cond,
 	return TRUE;
 }
 
-static gboolean signal_handler(GIOChannel *channel, GIOCondition cond,
-							gpointer user_data)
-{
-	struct context *context = user_data;
-	const struct test_data *test_data = context->data;
-	struct signalfd_siginfo si;
-	ssize_t result;
-	int fd;
-
-	if (cond & (G_IO_NVAL | G_IO_ERR | G_IO_HUP))
-		return FALSE;
-
-	fd = g_io_channel_unix_get_fd(channel);
-
-	result = read(fd, &si, sizeof(si));
-	if (result != sizeof(si))
-		return FALSE;
-
-	g_assert(test_data->expected_signal == si.ssi_signo);
-	context_quit(context);
-	return TRUE;
-}
-
-static guint setup_signalfd(gpointer user_data)
-{
-	GIOChannel *channel;
-	guint source;
-	sigset_t mask;
-	int ret;
-	int fd;
-
-	sigemptyset(&mask);
-	sigaddset(&mask, SIGINT);
-	sigaddset(&mask, SIGTERM);
-
-	ret = sigprocmask(SIG_BLOCK, &mask, NULL);
-	g_assert(ret == 0);
-
-	fd = signalfd(-1, &mask, 0);
-	g_assert(fd >= 0);
-
-	channel = g_io_channel_unix_new(fd);
-
-	g_io_channel_set_close_on_unref(channel, TRUE);
-	g_io_channel_set_encoding(channel, NULL, NULL);
-	g_io_channel_set_buffered(channel, FALSE);
-
-	source = g_io_add_watch(channel,
-				G_IO_IN | G_IO_HUP | G_IO_ERR | G_IO_NVAL,
-				signal_handler, user_data);
-
-	g_io_channel_unref(channel);
-
-	return source;
-}
-
 static struct context *create_context(gconstpointer data)
 {
 	struct context *context = g_new0(struct context, 1);
@@ -228,9 +174,6 @@ static struct context *create_context(gconstpointer data)
 	context->main_loop = g_main_loop_new(NULL, FALSE);
 	g_assert(context->main_loop);
 
-	context->signal_source = setup_signalfd(context);
-	g_assert(context->signal_source);
-
 	sk = socket(AF_LOCAL, SOCK_SEQPACKET, 0);
 	g_assert(sk >= 0);
 
@@ -272,7 +215,6 @@ static void execute_context(struct context *context)
 	g_io_channel_unref(context->notif_io);
 
 	g_source_remove(context->notif_source);
-	g_source_remove(context->signal_source);
 	g_source_remove(context->cmd_source);
 	g_source_remove(context->source);
 
@@ -281,6 +223,15 @@ static void execute_context(struct context *context)
 	g_free(context);
 }
 
+static void disconnected(void *data)
+{
+	struct context *context = data;
+
+	g_assert(context->data->disconnect);
+
+	context_quit(context);
+}
+
 static void test_init(gconstpointer data)
 {
 	struct context *context = create_context(data);
@@ -341,6 +292,8 @@ static void test_cmd(gconstpointer data)
 
 	g_assert(ipc);
 
+	ipc_set_fail_handler(ipc, disconnected, context);
+
 	g_idle_add(send_cmd, context);
 
 	execute_context(context);
@@ -359,6 +312,8 @@ static void test_cmd_reg(gconstpointer data)
 
 	g_assert(ipc);
 
+	ipc_set_fail_handler(ipc, disconnected, context);
+
 	g_idle_add(register_service, context);
 	g_idle_add(send_cmd, context);
 
@@ -379,6 +334,8 @@ static void test_cmd_reg_1(gconstpointer data)
 
 	g_assert(ipc);
 
+	ipc_set_fail_handler(ipc, disconnected, context);
+
 	g_idle_add(register_service, context);
 	g_idle_add(unregister_service, context);
 	g_idle_add(send_cmd, context);
@@ -401,7 +358,7 @@ static void test_cmd_handler_2(const void *buf, uint16_t len)
 
 static void test_cmd_handler_invalid(const void *buf, uint16_t len)
 {
-	raise(SIGTERM);
+	g_assert(false);
 }
 
 static const struct test_data test_init_1 = {};
@@ -421,7 +378,7 @@ static const struct hal_hdr test_cmd_2_hdr = {
 static const struct test_data test_cmd_service_invalid_1 = {
 	.cmd = &test_cmd_1_hdr,
 	.cmd_size = sizeof(test_cmd_1_hdr),
-	.expected_signal = SIGTERM
+	.disconnect = true,
 };
 
 static const struct ipc_handler cmd_handlers[] = {
@@ -442,7 +399,7 @@ static const struct test_data test_cmd_service_invalid_2 = {
 	.service = 0,
 	.handlers = cmd_handlers,
 	.handlers_size = 1,
-	.expected_signal = SIGTERM
+	.disconnect = true,
 };
 
 static const struct ipc_handler cmd_handlers_invalid_2[] = {
@@ -477,7 +434,7 @@ static const struct test_data test_cmd_opcode_invalid_1 = {
 	.service = 0,
 	.handlers = cmd_handlers,
 	.handlers_size = 1,
-	.expected_signal = SIGTERM
+	.disconnect = true,
 };
 
 static const struct test_data test_cmd_hdr_invalid = {
@@ -486,7 +443,7 @@ static const struct test_data test_cmd_hdr_invalid = {
 	.service = 0,
 	.handlers = cmd_handlers,
 	.handlers_size = 1,
-	.expected_signal = SIGTERM
+	.disconnect = true,
 };
 
 #define VARDATA_EX1 "some data example"
@@ -533,7 +490,7 @@ static const struct test_data test_cmd_vardata_invalid_1 = {
 	.service = 0,
 	.handlers = cmd_vardata_handlers,
 	.handlers_size = 1,
-	.expected_signal = SIGTERM
+	.disconnect = true,
 };
 
 static const struct hal_hdr test_cmd_service_offrange_hdr = {
@@ -548,7 +505,7 @@ static const struct test_data test_cmd_service_offrange = {
 	.service = 0,
 	.handlers = cmd_handlers,
 	.handlers_size = 1,
-	.expected_signal = SIGTERM
+	.disconnect = true,
 };
 
 static const struct vardata test_cmd_invalid_data_1 = {
@@ -564,7 +521,7 @@ static const struct test_data test_cmd_msg_invalid_1 = {
 	.service = 0,
 	.handlers = cmd_handlers,
 	.handlers_size = 1,
-	.expected_signal = SIGTERM
+	.disconnect = true,
 };
 
 static const struct vardata test_cmd_invalid_data_2 = {
@@ -580,7 +537,7 @@ static const struct test_data test_cmd_msg_invalid_2 = {
 	.service = 0,
 	.handlers = cmd_handlers,
 	.handlers_size = 1,
-	.expected_signal = SIGTERM
+	.disconnect = true,
 };
 
 int main(int argc, char *argv[])
-- 
1.8.3.2

