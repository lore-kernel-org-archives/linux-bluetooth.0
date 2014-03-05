Return-Path: <cyrus@holtmann.org>
From: Marcin Kraglak <marcin.kraglak@tieto.com>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCHv2 03/11] unit/test-hfp: Add /hfp/test_cmd_handler_1
Date: Wed,  5 Mar 2014 20:22:48 +0100
Message-Id: <1394047376-11495-3-git-send-email-marcin.kraglak@tieto.com>
In-Reply-To: <1394047376-11495-1-git-send-email-marcin.kraglak@tieto.com>
References: <1394047376-11495-1-git-send-email-marcin.kraglak@tieto.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

---
 unit/test-hfp.c | 47 +++++++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 47 insertions(+)

diff --git a/unit/test-hfp.c b/unit/test-hfp.c
index f220569..5e16378 100644
--- a/unit/test-hfp.c
+++ b/unit/test-hfp.c
@@ -104,6 +104,20 @@ static gboolean test_handler(GIOChannel *channel, GIOCondition cond,
 	return FALSE;
 }
 
+static void cmd_handler(const char *command, void *user_data)
+{
+	struct context *context = user_data;
+	const struct test_pdu *pdu;
+	unsigned int cmd_len = strlen(command);
+
+	pdu = &context->data->pdu_list[context->pdu_offset++];
+
+	g_assert(cmd_len == pdu->size);
+	g_assert(!memcmp(command, pdu->data, cmd_len));
+
+	hfp_gw_send_result(context->hfp, HFP_RESULT_ERROR);
+}
+
 static struct context *create_context(gconstpointer data)
 {
 	struct context *context = g_new0(struct context, 1);
@@ -146,6 +160,9 @@ static void execute_context(struct context *context)
 
 	test_free(context->data);
 
+	if (context->hfp)
+		hfp_gw_unref(context->hfp);
+
 	g_free(context);
 }
 
@@ -159,6 +176,32 @@ static void test_init(gconstpointer data)
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
+	const struct test_pdu *pdu;
+	ssize_t len;
+	bool ret;
+
+	context->hfp = hfp_gw_new(context->fd_client);
+	g_assert(context->hfp);
+
+	pdu = &context->data->pdu_list[context->pdu_offset++];
+
+	ret = hfp_gw_set_close_on_unref(context->hfp, true);
+	g_assert(ret);
+
+	ret = hfp_gw_set_command_handler(context->hfp, cmd_handler,
+								context, NULL);
+	g_assert(ret);
+
+	len = write(context->fd_server, pdu->data, pdu->size);
+	g_assert_cmpint(len, ==, pdu->size);
 
 	execute_context(context);
 }
@@ -168,6 +211,10 @@ int main(int argc, char *argv[])
 	g_test_init(&argc, &argv, NULL);
 
 	define_test("/hfp/test_init", test_init, data_end());
+	define_test("/hfp/test_cmd_handler_1", test_command_handler,
+			raw_pdu('A', 'T', '+', 'B', 'R', 'S', 'F', '\r'),
+			raw_pdu('A', 'T', '+', 'B', 'R', 'S', 'F'),
+			data_end());
 
 	return g_test_run();
 }
-- 
1.8.3.1

