Return-Path: <cyrus@holtmann.org>
From: Lukasz Rymanowski <lukasz.rymanowski@tieto.com>
To: linux-bluetooth@vger.kernel.org
Cc: Lukasz Rymanowski <lukasz.rymanowski@tieto.com>
Subject: [PATCH v5 10/11] unit/test-hfp: Add tests for unsolicited results for HFP HF
Date: Fri, 24 Oct 2014 13:59:34 +0200
Message-Id: <1414151975-20588-11-git-send-email-lukasz.rymanowski@tieto.com>
In-Reply-To: <1414151975-20588-1-git-send-email-lukasz.rymanowski@tieto.com>
References: <1414151975-20588-1-git-send-email-lukasz.rymanowski@tieto.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

This patch adds three test case:
/hfp_hf/test_unsolicited_1
/hfp_hf/test_unsolicited_2
/hfp_hf/test_unsolicited_3
---
 unit/test-hfp.c | 60 +++++++++++++++++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 60 insertions(+)

diff --git a/unit/test-hfp.c b/unit/test-hfp.c
index 3c25691..ab695d7 100644
--- a/unit/test-hfp.c
+++ b/unit/test-hfp.c
@@ -527,6 +527,42 @@ static void test_hf_send_command(gconstpointer data)
 	execute_context(context);
 }
 
+static void hf_result_handler(struct hfp_hf_result *result,
+							void *user_data)
+{
+	struct context *context = user_data;
+
+	hfp_hf_disconnect(context->hfp_hf);
+}
+
+static void test_hf_unsolicited(gconstpointer data)
+{
+	struct context *context = create_context(data);
+	bool ret;
+
+	context->hfp_hf = hfp_hf_new(context->fd_client);
+	g_assert(context->hfp_hf);
+
+	ret = hfp_hf_set_close_on_unref(context->hfp_hf, true);
+	g_assert(ret);
+
+	if (context->data->hf_result_func) {
+		const struct test_pdu *pdu;
+
+		pdu = &context->data->pdu_list[context->pdu_offset++];
+
+		ret = hfp_hf_register(context->hfp_hf,
+						context->data->hf_result_func,
+						(char *)pdu->data, context,
+						NULL);
+		g_assert(ret);
+	}
+
+	send_pdu(context);
+
+	execute_context(context);
+}
+
 int main(int argc, char *argv[])
 {
 	g_test_init(&argc, &argv, NULL);
@@ -614,5 +650,29 @@ int main(int argc, char *argv[])
 			frg_pdu('\r', '\n', 'O', 'k', '\r', '\n'),
 			data_end());
 
+	define_hf_test("/hfp_hf/test_unsolicited_1", test_hf_unsolicited,
+			hf_result_handler, NULL,
+			raw_pdu('+', 'C', 'L', 'C', 'C', '\0'),
+			frg_pdu('\r', '\n', '+', 'C', 'L', 'C'),
+			frg_pdu('C', '\r', '\n'),
+			data_end());
+
+	define_hf_test("/hfp_hf/test_unsolicited_2", test_hf_unsolicited,
+			hf_result_handler, NULL,
+			raw_pdu('+', 'C', 'L', 'C', 'C', '\0'),
+			frg_pdu('\r', '\n', '+', 'C', 'L', 'C', 'C', ':', '1'),
+			frg_pdu(',', '3', ',', '0', '\r', '\n'),
+			data_end());
+
+	define_hf_test("/hfp_hf/test_unsolicited_3", test_hf_unsolicited,
+			hf_result_handler, NULL,
+			raw_pdu('+', 'C', 'L', 'C', 'C', '\0'),
+			frg_pdu('\r'), frg_pdu('\n'), frg_pdu('+'),
+			frg_pdu('C'), frg_pdu('L'), frg_pdu('C'), frg_pdu('C'),
+			frg_pdu(':'), frg_pdu('1'), frg_pdu(','), frg_pdu('3'),
+			frg_pdu(','), frg_pdu('0'), frg_pdu('\r'),
+			frg_pdu('\n'),
+			data_end());
+
 	return g_test_run();
 }
-- 
1.8.4

