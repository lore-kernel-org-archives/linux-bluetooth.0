Return-Path: <cyrus@holtmann.org>
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH BlueZ 07/12] unit/test-mgmt: Add /mgmt/event/1 test
Date: Mon,  8 Dec 2014 18:05:11 +0200
Message-Id: <1418054716-24231-8-git-send-email-luiz.dentz@gmail.com>
In-Reply-To: <1418054716-24231-1-git-send-email-luiz.dentz@gmail.com>
References: <1418054716-24231-1-git-send-email-luiz.dentz@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

From: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>

This tests if an event can be received.
---
 unit/test-mgmt.c | 36 ++++++++++++++++++++++++++++++++++++
 1 file changed, 36 insertions(+)

diff --git a/unit/test-mgmt.c b/unit/test-mgmt.c
index 7bff828..a610d1a 100644
--- a/unit/test-mgmt.c
+++ b/unit/test-mgmt.c
@@ -38,6 +38,7 @@
 
 struct context {
 	GMainLoop *main_loop;
+	int fd;
 	struct mgmt *mgmt_client;
 	guint server_source;
 	GList *handler_list;
@@ -143,6 +144,7 @@ static struct context *create_context(void)
 	err = socketpair(AF_UNIX, SOCK_SEQPACKET | SOCK_CLOEXEC, 0, sv);
 	g_assert(err == 0);
 
+	context->fd = sv[0];
 	channel = g_io_channel_unix_new(sv[0]);
 
 	g_io_channel_set_close_on_unref(channel, TRUE);
@@ -254,6 +256,16 @@ static const struct command_test_data command_test_3 = {
 	.rsp_status = MGMT_STATUS_INVALID_INDEX,
 };
 
+static const unsigned char event_index_added[] =
+				{ 0x04, 0x00, 0x01, 0x00, 0x00, 0x00 };
+
+static const struct command_test_data event_test_1 = {
+	.opcode = MGMT_EV_INDEX_ADDED,
+	.index = MGMT_INDEX_NONE,
+	.cmd_data = event_index_added,
+	.cmd_size = sizeof(event_index_added),
+};
+
 static void test_command(gconstpointer data)
 {
 	const struct command_test_data *test = data;
@@ -297,6 +309,28 @@ static void test_response(gconstpointer data)
 	execute_context(context);
 }
 
+static void event_cb(uint16_t index, uint16_t length, const void *param,
+							void *user_data)
+{
+	struct context *context = user_data;
+
+	context_quit(context);
+}
+
+static void test_event(gconstpointer data)
+{
+	const struct command_test_data *test = data;
+	struct context *context = create_context();
+
+	mgmt_register(context->mgmt_client, test->opcode, test->index,
+						event_cb, context, NULL);
+
+	g_assert_cmpint(write(context->fd, test->cmd_data, test->cmd_size), ==,
+								test->cmd_size);
+
+	execute_context(context);
+}
+
 int main(int argc, char *argv[])
 {
 	g_test_init(&argc, &argv, NULL);
@@ -309,5 +343,7 @@ int main(int argc, char *argv[])
 	g_test_add_data_func("/mgmt/response/2", &command_test_3,
 								test_response);
 
+	g_test_add_data_func("/mgmt/event/1", &event_test_1, test_event);
+
 	return g_test_run();
 }
-- 
1.9.3

