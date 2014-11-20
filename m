Return-Path: <cyrus@holtmann.org>
From: Lukasz Rymanowski <lukasz.rymanowski@tieto.com>
To: linux-bluetooth@vger.kernel.org
Cc: Lukasz Rymanowski <lukasz.rymanowski@tieto.com>
Subject: [PATCH 4/8] unit/test-hfp: Add test for reading \rAT+X\r
Date: Thu, 20 Nov 2014 16:55:11 +0100
Message-Id: <1416498915-19534-5-git-send-email-lukasz.rymanowski@tieto.com>
In-Reply-To: <1416498915-19534-1-git-send-email-lukasz.rymanowski@tieto.com>
References: <1416498915-19534-1-git-send-email-lukasz.rymanowski@tieto.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

---
 unit/test-hfp.c | 20 +++++++++++++++++++-
 1 file changed, 19 insertions(+), 1 deletion(-)

diff --git a/unit/test-hfp.c b/unit/test-hfp.c
index ef8a100..b22b8a5 100644
--- a/unit/test-hfp.c
+++ b/unit/test-hfp.c
@@ -453,6 +453,19 @@ static void check_string_2(struct hfp_context *result,
 	hfp_gw_send_result(context->hfp, HFP_RESULT_ERROR);
 }
 
+static void check_string_3(struct hfp_context *result,
+				enum hfp_gw_cmd_type type, void *user_data)
+{
+	struct context *context = user_data;
+	const struct test_pdu *pdu;
+
+	pdu = &context->data->pdu_list[context->pdu_offset++];
+
+	g_assert(type == pdu->type);
+
+	hfp_gw_send_result(context->hfp, HFP_RESULT_ERROR);
+}
+
 static void test_hf_init(gconstpointer data)
 {
 	struct context *context = create_context(data);
@@ -725,10 +738,15 @@ int main(int argc, char *argv[])
 									'\r'),
 			type_pdu(HFP_GW_CMD_TYPE_SET, 0),
 			data_end());
+	define_test("/hfp/test_corrupted_1", test_register, check_string_3,
+			raw_pdu('D', '\0'),
+			raw_pdu('\r', 'A', 'T', 'D', '\"', '0', '1', '2', '3',
+								'\"', '\r'),
+			type_pdu(HFP_GW_CMD_TYPE_SET, 0),
+			data_end());
 	define_test("/hfp/test_empty", test_fragmented, NULL,
 			raw_pdu('\r'),
 			data_end());
-
 	define_hf_test("/hfp_hf/test_init", test_hf_init, NULL, NULL,
 			data_end());
 	define_hf_test("/hfp_hf/test_send_command_1", test_hf_send_command,
-- 
1.8.4

