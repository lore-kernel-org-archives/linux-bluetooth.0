Return-Path: <cyrus@holtmann.org>
From: Lukasz Rymanowski <lukasz.rymanowski@tieto.com>
To: linux-bluetooth@vger.kernel.org
Cc: Lukasz Rymanowski <lukasz.rymanowski@tieto.com>
Subject: [PATCH v2 09/11] unit/test-hfp: Add send command tests for HFP HF
Date: Tue,  7 Oct 2014 11:22:18 +0200
Message-Id: <1412673740-24336-10-git-send-email-lukasz.rymanowski@tieto.com>
In-Reply-To: <1412673740-24336-1-git-send-email-lukasz.rymanowski@tieto.com>
References: <1412673740-24336-1-git-send-email-lukasz.rymanowski@tieto.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

This patch adds following tests:
/hfp/test_send_command_1
/hfp/test_send_command_2
---
 unit/test-hfp.c | 59 +++++++++++++++++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 59 insertions(+)

diff --git a/unit/test-hfp.c b/unit/test-hfp.c
index ad26058..162f1d5 100644
--- a/unit/test-hfp.c
+++ b/unit/test-hfp.c
@@ -462,6 +462,51 @@ static void test_hf_init(gconstpointer data)
 	execute_context(context);
 }
 
+static void hf_response_with_data(enum hfp_result res,
+						struct hfp_hf_result *resp,
+						void *user_data)
+{
+	struct context *context = user_data;
+
+	g_assert(resp);
+
+	hfp_hf_disconnect(context->hfp_hf);
+}
+
+static void hf_response_cb(enum hfp_result res, struct hfp_hf_result *resp,
+							void *user_data)
+{
+	struct context *context = user_data;
+
+	g_assert(!resp);
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
@@ -532,6 +577,20 @@ int main(int argc, char *argv[])
 			data_end());
 
 	define_hf_test("/hfp/test_init", test_hf_init, NULL, NULL, data_end());
+	define_hf_test("/hfp/test_send_command_1", test_hf_send_command, NULL,
+			hf_response_cb,
+			raw_pdu('A', 'T', '+', 'B', 'R', 'S', 'F', '\0'),
+			raw_pdu('\r', '\n', 'O', 'k', '\r', '\n'),
+			data_end());
+
+	define_hf_test("/hfp/test_send_command_2", test_hf_send_command,
+			NULL,
+			hf_response_with_data,
+			raw_pdu('A', 'T', '+', 'B', 'R', 'S', 'F', '\0'),
+			raw_pdu('\r', '\n', '+', 'B', 'R', 'S', 'F', '\r',
+									'\n'),
+			raw_pdu('\r', '\n', 'O', 'k', '\r', '\n'),
+			data_end());
 
 	return g_test_run();
 }
-- 
1.8.4

