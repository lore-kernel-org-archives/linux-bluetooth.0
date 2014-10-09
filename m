Return-Path: <cyrus@holtmann.org>
From: Lukasz Rymanowski <lukasz.rymanowski@tieto.com>
To: linux-bluetooth@vger.kernel.org
Cc: Lukasz Rymanowski <lukasz.rymanowski@tieto.com>
Subject: [PATCH 8/8] unit/hfp: Add test for +CME ERROR: response
Date: Fri, 10 Oct 2014 01:50:52 +0200
Message-Id: <1412898652-12281-9-git-send-email-lukasz.rymanowski@tieto.com>
In-Reply-To: <1412898652-12281-1-git-send-email-lukasz.rymanowski@tieto.com>
References: <1412898652-12281-1-git-send-email-lukasz.rymanowski@tieto.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

---
 unit/test-hfp.c | 21 +++++++++++++++++++++
 1 file changed, 21 insertions(+)

diff --git a/unit/test-hfp.c b/unit/test-hfp.c
index 9c71ee9..ff5532e 100644
--- a/unit/test-hfp.c
+++ b/unit/test-hfp.c
@@ -487,6 +487,19 @@ static void hf_response_with_data(const char *prefix, enum hfp_result res,
 	hfp_hf_disconnect(context->hfp_hf);
 }
 
+static void hf_cme_error_response_cb(const char *prefix,
+							enum hfp_result res,
+							enum hfp_error cme_err,
+							void *user_data)
+{
+	struct context *context = user_data;
+
+	g_assert_cmpstr(prefix, ==, "AT+CHLD");
+	g_assert_cmpint(res, ==, HFP_RESULT_CME_ERROR);
+	g_assert_cmpint(cme_err, ==, 30);
+
+	hfp_hf_disconnect(context->hfp_hf);
+}
 static void hf_brsf_response_cb(const char *prefix, enum hfp_result res,
 							enum hfp_error cme_err,
 							void *user_data)
@@ -721,6 +734,14 @@ int main(int argc, char *argv[])
 			frg_pdu('\r', '\n', 'O', 'k', '\r', '\n'),
 			data_end());
 
+	define_hf_test("/hfp/test_send_command_3", test_hf_send_command, NULL,
+			hf_cme_error_response_cb,
+			raw_pdu('A', 'T', '+', 'C', 'H', 'L', 'D', '=',
+								'1', '\0'),
+			frg_pdu('\r', '\n', '+', 'C', 'M', 'E', ' ', 'E'),
+			frg_pdu('R', 'R', 'O', 'R', ':', '3', '0', '\r', '\n'),
+			data_end());
+
 	define_hf_test("/hfp/test_unsolicited_1", test_hf_unsolicited,
 			hf_result_handler, NULL,
 			raw_pdu('+', 'C', 'L', 'C', 'C', '\0'),
-- 
1.8.4

