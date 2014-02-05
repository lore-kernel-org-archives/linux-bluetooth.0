Return-Path: <cyrus@holtmann.org>
From: Andrei Emeltchenko <Andrei.Emeltchenko.news@gmail.com>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH 1/2] unit/avctp: Use pre-defined values instead of magic numbers
Date: Wed,  5 Feb 2014 17:28:21 +0200
Message-Id: <1391614102-21639-1-git-send-email-Andrei.Emeltchenko.news@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

From: Andrei Emeltchenko <andrei.emeltchenko@intel.com>

---
 unit/test-avctp.c | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/unit/test-avctp.c b/unit/test-avctp.c
index 581f88c..9d94ae0 100644
--- a/unit/test-avctp.c
+++ b/unit/test-avctp.c
@@ -277,8 +277,8 @@ static void test_client(gconstpointer data)
 {
 	struct context *context = create_context(0x0100, data);
 
-	avctp_send_vendordep_req(context->session, 0, 0, NULL, 0,
-						handler_response, context);
+	avctp_send_vendordep_req(context->session, AVC_CTYPE_CONTROL, 0, NULL,
+						0, handler_response, context);
 
 	execute_context(context);
 }
@@ -290,8 +290,8 @@ static void test_server(gconstpointer data)
 	if (g_str_equal(context->data->test_name, "/TP/NFR/BV-03-C")) {
 		int ret;
 
-		ret = avctp_register_pdu_handler(context->session, 0x00,
-								handler, NULL);
+		ret = avctp_register_pdu_handler(context->session,
+					AVC_OP_VENDORDEP, handler, NULL);
 		DBG("ret %d", ret);
 		g_assert_cmpint(ret, !=, 0);
 	}
-- 
1.8.3.2

