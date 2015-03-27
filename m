Return-Path: <cyrus@holtmann.org>
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH BlueZ 1/5] unit/test-avctp: Remove DBG calls
Date: Fri, 27 Mar 2015 10:49:50 +0200
Message-Id: <1427446194-5646-1-git-send-email-luiz.dentz@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

From: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>

---
 unit/test-avctp.c | 7 -------
 1 file changed, 7 deletions(-)

diff --git a/unit/test-avctp.c b/unit/test-avctp.c
index ce52222..689a825 100644
--- a/unit/test-avctp.c
+++ b/unit/test-avctp.c
@@ -220,9 +220,6 @@ static ssize_t handler(struct avctp *session,
 					uint8_t *subunit, uint8_t *operands,
 					size_t operand_count, void *user_data)
 {
-	DBG("transaction %d code %d subunit %d operand_count %zu",
-		transaction, *code, *subunit, operand_count);
-
 	g_assert_cmpint(transaction, ==, 0);
 	g_assert_cmpint(*code, ==, 0);
 	g_assert_cmpint(*subunit, ==, 0);
@@ -238,9 +235,6 @@ static gboolean handler_response(struct avctp *session,
 {
 	struct context *context = user_data;
 
-	DBG("code 0x%02x subunit %d operand_count %zu", code, subunit,
-								operand_count);
-
 	g_assert_cmpint(code, ==, 0x0a);
 	g_assert_cmpint(subunit, ==, 0);
 	g_assert_cmpint(operand_count, ==, 0);
@@ -265,7 +259,6 @@ static void test_server(gconstpointer data)
 
 		ret = avctp_register_pdu_handler(context->session,
 					AVC_OP_VENDORDEP, handler, NULL);
-		DBG("ret %d", ret);
 		g_assert_cmpint(ret, !=, 0);
 	}
 
-- 
2.1.0

