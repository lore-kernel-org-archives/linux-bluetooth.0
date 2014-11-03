Return-Path: <cyrus@holtmann.org>
From: Lukasz Rymanowski <lukasz.rymanowski@tieto.com>
To: linux-bluetooth@vger.kernel.org
Cc: Lukasz Rymanowski <lukasz.rymanowski@tieto.com>
Subject: [PATCH v2 08/10] unit/hfp: Add test for +CME ERROR: response
Date: Mon,  3 Nov 2014 10:35:59 +0100
Message-Id: <1415007361-4177-9-git-send-email-lukasz.rymanowski@tieto.com>
In-Reply-To: <1415007361-4177-1-git-send-email-lukasz.rymanowski@tieto.com>
References: <1415007361-4177-1-git-send-email-lukasz.rymanowski@tieto.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

---
 unit/test-hfp.c | 20 ++++++++++++++++++++
 1 file changed, 20 insertions(+)

diff --git a/unit/test-hfp.c b/unit/test-hfp.c
index dd5dbcf..617b336 100644
--- a/unit/test-hfp.c
+++ b/unit/test-hfp.c
@@ -486,6 +486,18 @@ static void hf_response_with_data(enum hfp_result res,
 	hfp_hf_disconnect(context->hfp_hf);
 }
 
+static void hf_cme_error_response_cb(enum hfp_result res,
+							enum hfp_error cme_err,
+							void *user_data)
+{
+	struct context *context = user_data;
+
+	g_assert_cmpint(res, ==, HFP_RESULT_CME_ERROR);
+	g_assert_cmpint(cme_err, ==, 30);
+
+	hfp_hf_disconnect(context->hfp_hf);
+}
+
 static void hf_response_cb(enum hfp_result res, enum hfp_error cme_err,
 							void *user_data)
 {
@@ -718,6 +730,14 @@ int main(int argc, char *argv[])
 			frg_pdu('\r', '\n', 'O', 'k', '\r', '\n'),
 			data_end());
 
+	define_hf_test("/hfp_hf/test_send_command_3", test_hf_send_command,
+			NULL, hf_cme_error_response_cb,
+			raw_pdu('A', 'T', '+', 'C', 'H', 'L', 'D', '=',
+								'1', '\0'),
+			frg_pdu('\r', '\n', '+', 'C', 'M', 'E', ' ', 'E'),
+			frg_pdu('R', 'R', 'O', 'R', ':', '3', '0', '\r', '\n'),
+			data_end());
+
 	define_hf_test("/hfp_hf/test_unsolicited_1", test_hf_unsolicited,
 			hf_result_handler, NULL,
 			raw_pdu('+', 'C', 'L', 'C', 'C', '\0'),
-- 
1.8.4

