Return-Path: <cyrus@holtmann.org>
From: Lukasz Rymanowski <lukasz.rymanowski@tieto.com>
To: linux-bluetooth@vger.kernel.org
Cc: Lukasz Rymanowski <lukasz.rymanowski@tieto.com>
Subject: [PATCH v2 07/10] unit/hfp: Add unit tests for parsing hfp_context
Date: Mon,  3 Nov 2014 10:35:58 +0100
Message-Id: <1415007361-4177-8-git-send-email-lukasz.rymanowski@tieto.com>
In-Reply-To: <1415007361-4177-1-git-send-email-lukasz.rymanowski@tieto.com>
References: <1415007361-4177-1-git-send-email-lukasz.rymanowski@tieto.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

This patch adds:
/hfp/test_hf_context_parser_1
/hfp/test_hf_context_parser_2
---
 unit/test-hfp.c | 66 +++++++++++++++++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 66 insertions(+)

diff --git a/unit/test-hfp.c b/unit/test-hfp.c
index 19250f6..dd5dbcf 100644
--- a/unit/test-hfp.c
+++ b/unit/test-hfp.c
@@ -527,6 +527,54 @@ static void test_hf_send_command(gconstpointer data)
 
 	execute_context(context);
 }
+static void hf_chld_result_handler(struct hfp_context *hf_context,
+							void *user_data)
+{
+	struct context *context = user_data;
+	char str[3];
+
+	g_assert(hf_context);
+	g_assert(hfp_context_get_unquoted_string(hf_context, str,
+							sizeof(str)));
+	g_assert_cmpstr(str, ==, "1");
+	g_assert(hfp_context_get_unquoted_string(hf_context, str,
+							sizeof(str)));
+	g_assert_cmpstr(str, ==, "2x");
+
+	hfp_hf_disconnect(context->hfp_hf);
+}
+
+static void hf_clcc_result_handler(struct hfp_context *hf_context,
+							void *user_data)
+{
+	struct context *context = user_data;
+	char name[10];
+	uint32_t val1, val2;
+
+	g_assert(hf_context);
+	g_assert(hfp_context_open_container(hf_context));
+	g_assert(hfp_context_get_string(hf_context, name, sizeof(name)));
+	g_assert_cmpstr(name, ==, "call");
+	g_assert(hfp_context_open_container(hf_context));
+	g_assert(hfp_context_get_number(hf_context, &val1));
+	g_assert_cmpint(val1, ==, 0);
+	g_assert(hfp_context_get_number(hf_context, &val1));
+	g_assert_cmpint(val1, ==, 1);
+	g_assert(hfp_context_close_container(hf_context));
+	g_assert(hfp_context_close_container(hf_context));
+
+	g_assert(hfp_context_open_container(hf_context));
+	g_assert(hfp_context_get_string(hf_context, name, sizeof(name)));
+	g_assert_cmpstr(name, ==, "callsetup");
+	g_assert(hfp_context_open_container(hf_context));
+	g_assert(hfp_context_get_range(hf_context, &val1, &val2));
+	g_assert_cmpint(val1, ==, 0);
+	g_assert_cmpint(val2, ==, 3);
+	g_assert(hfp_context_close_container(hf_context));
+	g_assert(hfp_context_close_container(hf_context));
+
+	hfp_hf_disconnect(context->hfp_hf);
+}
 
 static void hf_result_handler(struct hfp_context *result,
 							void *user_data)
@@ -715,5 +763,23 @@ int main(int argc, char *argv[])
 			raw_pdu('\r', '\n', 'B', 'R', '\r', '\n'),
 			data_end());
 
+	define_hf_test("/hfp_hf/test_context_parser_1", test_hf_unsolicited,
+			hf_clcc_result_handler, NULL,
+			raw_pdu('+', 'C', 'L', 'C', 'C', '\0'),
+			frg_pdu('+', 'C', 'L', 'C', 'C', ':'),
+			frg_pdu('(', '\"', 'c', 'a', 'l', 'l', '\"'),
+			frg_pdu('(', '0', ',', '1', ')', ')', ','),
+			frg_pdu('(', '\"', 'c', 'a', 'l', 'l', 's', 'e', 't'),
+			frg_pdu('u', 'p', '\"', ',', '(', '0', '-', '3', ')'),
+			frg_pdu(')', '\r', '\n'),
+			data_end());
+
+	define_hf_test("/hfp_hf/test_context_parser_2", test_hf_unsolicited,
+			hf_chld_result_handler, NULL,
+			raw_pdu('+', 'C', 'H', 'L', 'D', '\0'),
+			frg_pdu('+', 'C', 'H', 'L', 'D', ':'),
+			frg_pdu('1', ',', '2', 'x', '\r', '\n'),
+			data_end());
+
 	return g_test_run();
 }
-- 
1.8.4

