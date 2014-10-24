Return-Path: <cyrus@holtmann.org>
From: Lukasz Rymanowski <lukasz.rymanowski@tieto.com>
To: linux-bluetooth@vger.kernel.org
Cc: Lukasz Rymanowski <lukasz.rymanowski@tieto.com>
Subject: [PATCH v5 11/11] unit/test-hfp: Add some robustness tests for HFP HF
Date: Fri, 24 Oct 2014 13:59:35 +0200
Message-Id: <1414151975-20588-12-git-send-email-lukasz.rymanowski@tieto.com>
In-Reply-To: <1414151975-20588-1-git-send-email-lukasz.rymanowski@tieto.com>
References: <1414151975-20588-1-git-send-email-lukasz.rymanowski@tieto.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

This patch adds folowing tests:
/hfp/test_hf_corrupted_1
/hfp/test_hf_corrupted_2
/hfp/test_hf_empty
/hfp/test_hf_unknown
---
 unit/test-hfp.c | 40 ++++++++++++++++++++++++++++++++++++++++
 1 file changed, 40 insertions(+)

diff --git a/unit/test-hfp.c b/unit/test-hfp.c
index ab695d7..24ea402 100644
--- a/unit/test-hfp.c
+++ b/unit/test-hfp.c
@@ -563,6 +563,25 @@ static void test_hf_unsolicited(gconstpointer data)
 	execute_context(context);
 }
 
+static void test_hf_robustness(gconstpointer data)
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
+	send_pdu(context);
+
+	hfp_hf_unref(context->hfp_hf);
+	context->hfp_hf = NULL;
+
+	execute_context(context);
+}
+
 int main(int argc, char *argv[])
 {
 	g_test_init(&argc, &argv, NULL);
@@ -674,5 +693,26 @@ int main(int argc, char *argv[])
 			frg_pdu('\n'),
 			data_end());
 
+	define_hf_test("/hfp_hf/test_corrupted_1", test_hf_unsolicited,
+			hf_result_handler, NULL,
+			raw_pdu('+', 'C', 'L', 'C', 'C', '\0'),
+			frg_pdu('\r', 'X', '\r', '\n'),
+			frg_pdu('+', 'C', 'L', 'C', 'C', ':', '1', ',', '3'),
+			frg_pdu(',', '0', '\r', '\n'),
+			data_end());
+
+	define_hf_test("/hfp_hf/test_corrupted_2", test_hf_unsolicited,
+			hf_result_handler, NULL,
+			raw_pdu('+', 'C', 'L', 'C', 'C', '\0'),
+			raw_pdu('+', 'C', 'L', 'C', 'C', '\r', '\n'),
+			data_end());
+
+	define_hf_test("/hfp_hf/test_empty", test_hf_robustness, NULL, NULL,
+			raw_pdu('\r'), data_end());
+
+	define_hf_test("/hfp_hf/test_unknown", test_hf_robustness, NULL, NULL,
+			raw_pdu('\r', '\n', 'B', 'R', '\r', '\n'),
+			data_end());
+
 	return g_test_run();
 }
-- 
1.8.4

