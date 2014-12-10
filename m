Return-Path: <cyrus@holtmann.org>
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH v2 05/13] unit/test-mgmt: Add /mgmt/response/1 test
Date: Wed, 10 Dec 2014 16:21:03 +0200
Message-Id: <1418221271-7034-3-git-send-email-luiz.dentz@gmail.com>
In-Reply-To: <1418221271-7034-1-git-send-email-luiz.dentz@gmail.com>
References: <1418221271-7034-1-git-send-email-luiz.dentz@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

From: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>

This tests if a success response can be received.
---
 unit/test-mgmt.c | 52 ++++++++++++++++++++++++++++++++++++++++++++++++++--
 1 file changed, 50 insertions(+), 2 deletions(-)

diff --git a/unit/test-mgmt.c b/unit/test-mgmt.c
index f9dcb00..ead088c 100644
--- a/unit/test-mgmt.c
+++ b/unit/test-mgmt.c
@@ -46,11 +46,14 @@ struct context {
 enum action {
 	ACTION_PASSED,
 	ACTION_IGNORE,
+	ACTION_RESPOND,
 };
 
 struct handler {
 	const void *cmd_data;
 	uint16_t cmd_size;
+	const void *rsp_data;
+	uint16_t rsp_size;
 	bool match_prefix;
 	enum action action;
 };
@@ -67,7 +70,7 @@ static void context_quit(struct context *context)
 	g_main_loop_quit(context->main_loop);
 }
 
-static void check_actions(struct context *context,
+static void check_actions(struct context *context, int fd,
 					const void *data, uint16_t size)
 {
 	GList *list;
@@ -75,6 +78,7 @@ static void check_actions(struct context *context,
 	for (list = g_list_first(context->handler_list); list;
 						list = g_list_next(list)) {
 		struct handler *handler = list->data;
+		int ret;
 
 		if (handler->match_prefix) {
 			if (size < handler->cmd_size)
@@ -91,6 +95,10 @@ static void check_actions(struct context *context,
 		case ACTION_PASSED:
 			context_quit(context);
 			return;
+		case ACTION_RESPOND:
+			ret = write(fd, handler->rsp_data, handler->rsp_size);
+			g_assert(ret >= 0);
+			return;
 		case ACTION_IGNORE:
 			return;
 		}
@@ -117,7 +125,7 @@ static gboolean server_handler(GIOChannel *channel, GIOCondition cond,
 	if (result < 0)
 		return FALSE;
 
-	check_actions(context, buf, result);
+	check_actions(context, fd, buf, result);
 
 	return TRUE;
 }
@@ -176,12 +184,15 @@ static void execute_context(struct context *context)
 
 static void add_action(struct context *context,
 				const void *cmd_data, uint16_t cmd_size,
+				const void *rsp_data, uint16_t rsp_size,
 				bool match_prefix, enum action action)
 {
 	struct handler *handler = g_new0(struct handler, 1);
 
 	handler->cmd_data = cmd_data;
 	handler->cmd_size = cmd_size;
+	handler->rsp_data = rsp_data;
+	handler->rsp_size = rsp_size;
 	handler->match_prefix = match_prefix;
 	handler->action = action;
 
@@ -195,16 +206,23 @@ struct command_test_data {
 	const void *param;
 	const void *cmd_data;
 	uint16_t cmd_size;
+	const void *rsp_data;
+	uint16_t rsp_size;
 };
 
 static const unsigned char read_version_command[] =
 				{ 0x01, 0x00, 0xff, 0xff, 0x00, 0x00 };
+static const unsigned char read_version_response[] =
+				{ 0x01, 0x00, 0xff, 0xff, 0x06, 0x00,
+				0x01, 0x00, 0x00, 0x01, 0x06, 0x00 };
 
 static const struct command_test_data command_test_1 = {
 	.opcode = MGMT_OP_READ_VERSION,
 	.index = MGMT_INDEX_NONE,
 	.cmd_data = read_version_command,
 	.cmd_size = sizeof(read_version_command),
+	.rsp_data = read_version_response,
+	.rsp_size = sizeof(read_version_response),
 };
 
 static const unsigned char read_info_command[] =
@@ -223,6 +241,7 @@ static void test_command(gconstpointer data)
 	struct context *context = create_context();
 
 	add_action(context, test->cmd_data, test->cmd_size,
+						test->rsp_data, test->rsp_size,
 						false, ACTION_PASSED);
 
 	mgmt_send(context->mgmt_client, test->opcode, test->index,
@@ -232,6 +251,32 @@ static void test_command(gconstpointer data)
 	execute_context(context);
 }
 
+static void success_cb(uint8_t status, uint16_t length, const void *param,
+							void *user_data)
+{
+	struct context *context = user_data;
+
+	g_assert_cmpint(status, ==, MGMT_STATUS_SUCCESS);
+
+	context_quit(context);
+}
+
+static void test_response(gconstpointer data)
+{
+	const struct command_test_data *test = data;
+	struct context *context = create_context();
+
+	add_action(context, test->cmd_data, test->cmd_size,
+						test->rsp_data, test->rsp_size,
+						false, ACTION_RESPOND);
+
+	mgmt_send(context->mgmt_client, test->opcode, test->index,
+					test->length, test->param,
+					success_cb, context, NULL);
+
+	execute_context(context);
+}
+
 int main(int argc, char *argv[])
 {
 	g_test_init(&argc, &argv, NULL);
@@ -239,5 +284,8 @@ int main(int argc, char *argv[])
 	g_test_add_data_func("/mgmt/command/1", &command_test_1, test_command);
 	g_test_add_data_func("/mgmt/command/2", &command_test_2, test_command);
 
+	g_test_add_data_func("/mgmt/response/1", &command_test_1,
+								test_response);
+
 	return g_test_run();
 }
-- 
1.9.3

