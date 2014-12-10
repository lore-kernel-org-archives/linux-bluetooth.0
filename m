Return-Path: <cyrus@holtmann.org>
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH v2 06/13] unit/test-mgmt: Add /mgmt/response/2 test
Date: Wed, 10 Dec 2014 16:21:04 +0200
Message-Id: <1418221271-7034-4-git-send-email-luiz.dentz@gmail.com>
In-Reply-To: <1418221271-7034-1-git-send-email-luiz.dentz@gmail.com>
References: <1418221271-7034-1-git-send-email-luiz.dentz@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

From: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>

This tests if an error can be received.
---
 unit/test-mgmt.c | 38 ++++++++++++++++++++++++++++++--------
 1 file changed, 30 insertions(+), 8 deletions(-)

diff --git a/unit/test-mgmt.c b/unit/test-mgmt.c
index ead088c..7bff828 100644
--- a/unit/test-mgmt.c
+++ b/unit/test-mgmt.c
@@ -54,6 +54,7 @@ struct handler {
 	uint16_t cmd_size;
 	const void *rsp_data;
 	uint16_t rsp_size;
+	uint8_t rsp_status;
 	bool match_prefix;
 	enum action action;
 };
@@ -185,7 +186,8 @@ static void execute_context(struct context *context)
 static void add_action(struct context *context,
 				const void *cmd_data, uint16_t cmd_size,
 				const void *rsp_data, uint16_t rsp_size,
-				bool match_prefix, enum action action)
+				uint8_t rsp_status, bool match_prefix,
+				enum action action)
 {
 	struct handler *handler = g_new0(struct handler, 1);
 
@@ -193,6 +195,7 @@ static void add_action(struct context *context,
 	handler->cmd_size = cmd_size;
 	handler->rsp_data = rsp_data;
 	handler->rsp_size = rsp_size;
+	handler->rsp_status = rsp_status;
 	handler->match_prefix = match_prefix;
 	handler->action = action;
 
@@ -208,6 +211,7 @@ struct command_test_data {
 	uint16_t cmd_size;
 	const void *rsp_data;
 	uint16_t rsp_size;
+	uint8_t rsp_status;
 };
 
 static const unsigned char read_version_command[] =
@@ -223,6 +227,7 @@ static const struct command_test_data command_test_1 = {
 	.cmd_size = sizeof(read_version_command),
 	.rsp_data = read_version_response,
 	.rsp_size = sizeof(read_version_response),
+	.rsp_status = MGMT_STATUS_SUCCESS,
 };
 
 static const unsigned char read_info_command[] =
@@ -235,14 +240,28 @@ static const struct command_test_data command_test_2 = {
 	.cmd_size = sizeof(read_info_command),
 };
 
+static const unsigned char invalid_index_response[] =
+				{ 0x02, 0x00, 0xff, 0xff, 0x03, 0x00,
+				0x01, 0x00, 0x11 };
+
+static const struct command_test_data command_test_3 = {
+	.opcode = MGMT_OP_READ_VERSION,
+	.index = MGMT_INDEX_NONE,
+	.cmd_data = read_version_command,
+	.cmd_size = sizeof(read_version_command),
+	.rsp_data = invalid_index_response,
+	.rsp_size = sizeof(invalid_index_response),
+	.rsp_status = MGMT_STATUS_INVALID_INDEX,
+};
+
 static void test_command(gconstpointer data)
 {
 	const struct command_test_data *test = data;
 	struct context *context = create_context();
 
 	add_action(context, test->cmd_data, test->cmd_size,
-						test->rsp_data, test->rsp_size,
-						false, ACTION_PASSED);
+			test->rsp_data, test->rsp_size, test->rsp_status,
+			false, ACTION_PASSED);
 
 	mgmt_send(context->mgmt_client, test->opcode, test->index,
 					test->length, test->param,
@@ -251,12 +270,13 @@ static void test_command(gconstpointer data)
 	execute_context(context);
 }
 
-static void success_cb(uint8_t status, uint16_t length, const void *param,
+static void response_cb(uint8_t status, uint16_t length, const void *param,
 							void *user_data)
 {
 	struct context *context = user_data;
+	struct handler *handler = context->handler_list->data;
 
-	g_assert_cmpint(status, ==, MGMT_STATUS_SUCCESS);
+	g_assert_cmpint(status, ==, handler->rsp_status);
 
 	context_quit(context);
 }
@@ -267,12 +287,12 @@ static void test_response(gconstpointer data)
 	struct context *context = create_context();
 
 	add_action(context, test->cmd_data, test->cmd_size,
-						test->rsp_data, test->rsp_size,
-						false, ACTION_RESPOND);
+			test->rsp_data, test->rsp_size, test->rsp_status,
+			false, ACTION_RESPOND);
 
 	mgmt_send(context->mgmt_client, test->opcode, test->index,
 					test->length, test->param,
-					success_cb, context, NULL);
+					response_cb, context, NULL);
 
 	execute_context(context);
 }
@@ -286,6 +306,8 @@ int main(int argc, char *argv[])
 
 	g_test_add_data_func("/mgmt/response/1", &command_test_1,
 								test_response);
+	g_test_add_data_func("/mgmt/response/2", &command_test_3,
+								test_response);
 
 	return g_test_run();
 }
-- 
1.9.3

