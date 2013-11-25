Return-Path: <cyrus@holtmann.org>
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH BlueZ 04/19] unit/AVDTP: Add /TP/SIG/SMG/BV-07-C test
Date: Mon, 25 Nov 2013 15:10:55 +0200
Message-Id: <1385385070-21010-5-git-send-email-luiz.dentz@gmail.com>
In-Reply-To: <1385385070-21010-1-git-send-email-luiz.dentz@gmail.com>
References: <1385385070-21010-1-git-send-email-luiz.dentz@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

From: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>

Verify that the IUT (INT) is able to issue a valid query for remote SEP
capabilities and reports the replied ones.
---
 unit/test-avdtp.c | 23 +++++++++++++++++++++--
 1 file changed, 21 insertions(+), 2 deletions(-)

diff --git a/unit/test-avdtp.c b/unit/test-avdtp.c
index 5623153..81155a4 100644
--- a/unit/test-avdtp.c
+++ b/unit/test-avdtp.c
@@ -198,11 +198,12 @@ static void execute_context(struct context *context)
 static void test_server(gconstpointer data)
 {
 	const struct test_data *test = data;
-	struct context *context = create_context();
+	struct context *context = create_context(0x0100);
 
 	context->pdu_list = test->pdu_list;
+
 	avdtp_register_sep(AVDTP_SEP_TYPE_SOURCE, AVDTP_MEDIA_TYPE_AUDIO, 0x00,
-				TRUE, NULL, NULL, NULL);
+							TRUE, NULL, NULL, NULL);
 
 	g_idle_add(send_pdu, context);
 
@@ -230,6 +231,20 @@ static void test_discover(gconstpointer data)
 	g_free(test->pdu_list);
 }
 
+static void test_get_capabilities(gconstpointer data)
+{
+	const struct test_data *test = data;
+	struct context *context = create_context(0x0100);
+
+	context->pdu_list = test->pdu_list;
+
+	avdtp_discover(context->session, discover_cb, NULL);
+
+	execute_context(context);
+
+	g_free(test->pdu_list);
+}
+
 int main(int argc, char *argv[])
 {
 	g_test_init(&argc, &argv, NULL);
@@ -248,6 +263,10 @@ int main(int argc, char *argv[])
 	define_test("/TP/SIG/SMG/BV-06-C", test_server,
 			raw_pdu(0x00, 0x01),
 			raw_pdu(0x02, 0x01, 0x04, 0x00));
+	define_test("/TP/SIG/SMG/BV-07-C", test_get_capabilities,
+			raw_pdu(0x10, 0x01),
+			raw_pdu(0x12, 0x01, 0x04, 0x00),
+			raw_pdu(0x20, 0x02, 0x04));
 
 	return g_test_run();
 }
-- 
1.8.3.1

