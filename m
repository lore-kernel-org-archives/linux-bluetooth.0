Return-Path: <cyrus@holtmann.org>
From: Lukasz Rymanowski <lukasz.rymanowski@tieto.com>
To: linux-bluetooth@vger.kernel.org
Cc: Lukasz Rymanowski <lukasz.rymanowski@tieto.com>
Subject: [PATCH v2 10/10] unit/test-hfp: Test for skip hfp_context field
Date: Mon,  3 Nov 2014 10:36:01 +0100
Message-Id: <1415007361-4177-11-git-send-email-lukasz.rymanowski@tieto.com>
In-Reply-To: <1415007361-4177-1-git-send-email-lukasz.rymanowski@tieto.com>
References: <1415007361-4177-1-git-send-email-lukasz.rymanowski@tieto.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

This patch adds test:
/hfp_hf/test_context_skip_field
---
 unit/test-hfp.c | 24 ++++++++++++++++++++++++
 1 file changed, 24 insertions(+)

diff --git a/unit/test-hfp.c b/unit/test-hfp.c
index 617b336..ef8a100 100644
--- a/unit/test-hfp.c
+++ b/unit/test-hfp.c
@@ -556,6 +556,23 @@ static void hf_chld_result_handler(struct hfp_context *hf_context,
 	hfp_hf_disconnect(context->hfp_hf);
 }
 
+static void hf_chld_skip_field(struct hfp_context *hf_context,
+							void *user_data)
+{
+	struct context *context = user_data;
+	char str[3];
+
+	g_assert(hf_context);
+
+	hfp_context_skip_field(hf_context);
+
+	g_assert(hfp_context_get_unquoted_string(hf_context, str,
+								sizeof(str)));
+	g_assert_cmpstr(str, ==, "2x");
+
+	hfp_hf_disconnect(context->hfp_hf);
+}
+
 static void hf_clcc_result_handler(struct hfp_context *hf_context,
 							void *user_data)
 {
@@ -801,5 +818,12 @@ int main(int argc, char *argv[])
 			frg_pdu('1', ',', '2', 'x', '\r', '\n'),
 			data_end());
 
+	define_hf_test("/hfp_hf/test_context_skip_field", test_hf_unsolicited,
+			hf_chld_skip_field, NULL,
+			raw_pdu('+', 'C', 'H', 'L', 'D', '\0'),
+			frg_pdu('+', 'C', 'H', 'L', 'D', ':'),
+			frg_pdu('1', ',', '2', 'x', '\r', '\n'),
+			data_end());
+
 	return g_test_run();
 }
-- 
1.8.4

