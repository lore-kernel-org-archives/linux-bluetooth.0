Return-Path: <cyrus@holtmann.org>
From: Lukasz Rymanowski <lukasz.rymanowski@tieto.com>
To: linux-bluetooth@vger.kernel.org
Cc: Lukasz Rymanowski <lukasz.rymanowski@tieto.com>
Subject: [PATCH 8/8] unit/test-hfp: Fix parsing empty string test
Date: Thu, 20 Nov 2014 16:55:15 +0100
Message-Id: <1416498915-19534-9-git-send-email-lukasz.rymanowski@tieto.com>
In-Reply-To: <1416498915-19534-1-git-send-email-lukasz.rymanowski@tieto.com>
References: <1416498915-19534-1-git-send-email-lukasz.rymanowski@tieto.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Empty string shall be ignored by AT parser and no response shall be
sent. Therefore this test should close HFP connection just after empty
string is sent, otherwise test hungs.
---
 unit/test-hfp.c | 21 ++++++++++++++++++++-
 1 file changed, 20 insertions(+), 1 deletion(-)

diff --git a/unit/test-hfp.c b/unit/test-hfp.c
index b22b8a5..face9a4 100644
--- a/unit/test-hfp.c
+++ b/unit/test-hfp.c
@@ -358,6 +358,25 @@ static void test_fragmented(gconstpointer data)
 	execute_context(context);
 }
 
+static void test_send_and_close(gconstpointer data)
+{
+	struct context *context = create_context(data);
+	bool ret;
+
+	context->hfp = hfp_gw_new(context->fd_client);
+	g_assert(context->hfp);
+
+	ret = hfp_gw_set_close_on_unref(context->hfp, true);
+	g_assert(ret);
+
+	send_pdu(context);
+
+	hfp_gw_unref(context->hfp);
+	context->hfp = NULL;
+
+	execute_context(context);
+}
+
 static void check_ustring_1(struct hfp_context *result,
 				enum hfp_gw_cmd_type type, void *user_data)
 {
@@ -744,7 +763,7 @@ int main(int argc, char *argv[])
 								'\"', '\r'),
 			type_pdu(HFP_GW_CMD_TYPE_SET, 0),
 			data_end());
-	define_test("/hfp/test_empty", test_fragmented, NULL,
+	define_test("/hfp/test_empty", test_send_and_close, NULL,
 			raw_pdu('\r'),
 			data_end());
 	define_hf_test("/hfp_hf/test_init", test_hf_init, NULL, NULL,
-- 
1.8.4

