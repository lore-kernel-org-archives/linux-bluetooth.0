Return-Path: <cyrus@holtmann.org>
From: Lukasz Rymanowski <lukasz.rymanowski@tieto.com>
To: linux-bluetooth@vger.kernel.org
Cc: Lukasz Rymanowski <lukasz.rymanowski@tieto.com>
Subject: [PATCH 09/11] unit/test-hfp: Add send command tests for HFP HF
Date: Thu,  2 Oct 2014 21:29:57 +0200
Message-Id: <1412278199-5761-10-git-send-email-lukasz.rymanowski@tieto.com>
In-Reply-To: <1412278199-5761-1-git-send-email-lukasz.rymanowski@tieto.com>
References: <1412278199-5761-1-git-send-email-lukasz.rymanowski@tieto.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

This patch adds following tests:
/hfp/test_send_command_1
/hfp/test_send_command_2
---
 unit/test-hfp.c | 71 +++++++++++++++++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 71 insertions(+)

diff --git a/unit/test-hfp.c b/unit/test-hfp.c
index ad26058..1926615 100644
--- a/unit/test-hfp.c
+++ b/unit/test-hfp.c
@@ -118,6 +118,9 @@ struct test_data {
 		data.test_handler = test_hf_handler;			\
 	} while (0)
 
+
+static bool received_unsolicited = false;
+
 static void context_quit(struct context *context)
 {
 	g_main_loop_quit(context->main_loop);
@@ -462,6 +465,60 @@ static void test_hf_init(gconstpointer data)
 	execute_context(context);
 }
 
+static void hf_unsolicited_resp_cb(struct hfp_hf_result *result,
+							void *user_data)
+{
+	received_unsolicited = true;
+}
+
+static void hf_response_with_unsolicited_cb(const char *prefix,
+							enum hfp_result res,
+							void *user_data)
+{
+	struct context *context = user_data;
+
+	g_assert_cmpstr(prefix, ==,  "AT+BRSF");
+	g_assert(received_unsolicited);
+	received_unsolicited = false;
+
+	hfp_hf_disconnect(context->hfp_hf);
+}
+
+static void hf_response_cb(const char *prefix, enum hfp_result res,
+							void *user_data)
+{
+	struct context *context = user_data;
+
+	g_assert_cmpstr(prefix, ==, "AT+BRSF");
+
+	hfp_hf_disconnect(context->hfp_hf);
+}
+
+static void test_hf_send_command(gconstpointer data)
+{
+	struct context *context = create_context(data);
+	const struct test_pdu *pdu;
+	bool ret;
+
+	context->hfp_hf = hfp_hf_new(context->fd_client);
+	g_assert(context->hfp_hf);
+
+	pdu = &context->data->pdu_list[context->pdu_offset++];
+
+	ret = hfp_hf_set_close_on_unref(context->hfp_hf, true);
+	g_assert(ret);
+
+	if (context->data->response_func) {
+		ret = hfp_hf_send_command(context->hfp_hf,
+						context->data->response_func,
+						context->data->hf_result_func,
+						context, (char *)pdu->data);
+		g_assert(ret);
+	}
+
+	execute_context(context);
+}
+
 int main(int argc, char *argv[])
 {
 	g_test_init(&argc, &argv, NULL);
@@ -532,6 +589,20 @@ int main(int argc, char *argv[])
 			data_end());
 
 	define_hf_test("/hfp/test_init", test_hf_init, NULL, NULL, data_end());
+	define_hf_test("/hfp/test_send_command_1", test_hf_send_command, NULL,
+			hf_response_cb,
+			raw_pdu('A', 'T', '+', 'B', 'R', 'S', 'F', '\0'),
+			raw_pdu('\r', '\n', 'O', 'k', '\r', '\n'),
+			data_end());
+
+	define_hf_test("/hfp/test_send_command_2", test_hf_send_command,
+			hf_unsolicited_resp_cb,
+			hf_response_with_unsolicited_cb,
+			raw_pdu('A', 'T', '+', 'B', 'R', 'S', 'F', '\0'),
+			raw_pdu('\r', '\n', '+', 'B', 'R', 'S', 'F', '\r',
+									'\n'),
+			raw_pdu('\r', '\n', 'O', 'k', '\r', '\n'),
+			data_end());
 
 	return g_test_run();
 }
-- 
1.8.4

