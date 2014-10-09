Return-Path: <cyrus@holtmann.org>
From: Lukasz Rymanowski <lukasz.rymanowski@tieto.com>
To: linux-bluetooth@vger.kernel.org
Cc: Lukasz Rymanowski <lukasz.rymanowski@tieto.com>
Subject: [PATCH v4 09/11] unit/test-hfp: Add send command tests for HFP HF
Date: Fri, 10 Oct 2014 01:50:09 +0200
Message-Id: <1412898611-12199-10-git-send-email-lukasz.rymanowski@tieto.com>
In-Reply-To: <1412898611-12199-1-git-send-email-lukasz.rymanowski@tieto.com>
References: <1412898611-12199-1-git-send-email-lukasz.rymanowski@tieto.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

This patch adds following tests:
/hfp/test_send_command_1
/hfp/test_send_command_2
---
 unit/test-hfp.c | 77 +++++++++++++++++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 77 insertions(+)

diff --git a/unit/test-hfp.c b/unit/test-hfp.c
index 274ee55..34273d5 100644
--- a/unit/test-hfp.c
+++ b/unit/test-hfp.c
@@ -468,6 +468,68 @@ static void test_hf_init(gconstpointer data)
 	execute_context(context);
 }
 
+static bool unsolicited_resp = false;
+
+static void hf_unsolicited_resp_cb(struct hfp_hf_result *result,
+							void *user_data) {
+	unsolicited_resp = true;
+}
+
+static void hf_response_with_data(const char *prefix, enum hfp_result res,
+							void *user_data)
+{
+	struct context *context = user_data;
+
+	g_assert(unsolicited_resp);
+	unsolicited_resp = false;
+
+	hfp_hf_disconnect(context->hfp_hf);
+}
+
+static void hf_brsf_response_cb(const char *prefix, enum hfp_result res,
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
+	ret = hfp_hf_set_close_on_unref(context->hfp_hf, true);
+	g_assert(ret);
+
+	if (context->data->response_func) {
+		if (context->data->hf_result_func) {
+			pdu = &context->data->pdu_list[context->pdu_offset++];
+
+			ret = hfp_hf_register(context->hfp_hf,
+						context->data->hf_result_func,
+						(char *)pdu->data,
+						NULL, NULL);
+			g_assert(ret);
+		}
+
+		pdu = &context->data->pdu_list[context->pdu_offset++];
+
+		ret = hfp_hf_send_command(context->hfp_hf,
+						context->data->response_func,
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
@@ -538,6 +600,21 @@ int main(int argc, char *argv[])
 			data_end());
 
 	define_hf_test("/hfp/test_init", test_hf_init, NULL, NULL, data_end());
+	define_hf_test("/hfp/test_send_command_1", test_hf_send_command, NULL,
+			hf_brsf_response_cb,
+			raw_pdu('A', 'T', '+', 'B', 'R', 'S', 'F', '\0'),
+			raw_pdu('\r', '\n', 'O', 'k', '\r', '\n'),
+			data_end());
+
+	define_hf_test("/hfp/test_send_command_2", test_hf_send_command,
+			hf_unsolicited_resp_cb,
+			hf_response_with_data,
+			raw_pdu('+', 'B', 'R', 'S', 'F', '\0'),
+			raw_pdu('A', 'T', '+', 'B', 'R', 'S', 'F', '\0'),
+			frg_pdu('\r', '\n', '+', 'B', 'R', 'S', 'F', '\r',
+									'\n'),
+			frg_pdu('\r', '\n', 'O', 'k', '\r', '\n'),
+			data_end());
 
 	return g_test_run();
 }
-- 
1.8.4

