Return-Path: <cyrus@holtmann.org>
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH BlueZ 16/19] unit/AVDTP: Add /TP/SIG/SMG/BV-21-C test
Date: Mon, 25 Nov 2013 15:11:07 +0200
Message-Id: <1385385070-21010-17-git-send-email-luiz.dentz@gmail.com>
In-Reply-To: <1385385070-21010-1-git-send-email-luiz.dentz@gmail.com>
References: <1385385070-21010-1-git-send-email-luiz.dentz@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

From: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>

Verify that the IUT (INT) is able to initiate the suspension of a
streaming procedure, after the streaming procedure has been started, by
issuing the AVDTP_SUSPEND_CMD.
---
 unit/test-avdtp.c | 124 +++++++++++++-----------------------------------------
 1 file changed, 29 insertions(+), 95 deletions(-)

diff --git a/unit/test-avdtp.c b/unit/test-avdtp.c
index 4677e22..804fdf5 100644
--- a/unit/test-avdtp.c
+++ b/unit/test-avdtp.c
@@ -317,11 +317,15 @@ static void sep_start_cfm(struct avdtp *session, struct avdtp_local_sep *sep,
 			struct avdtp_stream *stream, struct avdtp_error *err,
 			void *user_data)
 {
+	struct context *context = user_data;
 	int ret;
 
 	g_assert(err == NULL);
 
-	ret = avdtp_close(session, stream, FALSE);
+	if (g_str_equal(context->data->test_name, "/TP/SIG/SMG/BV-19-C"))
+		ret = avdtp_close(session, stream, FALSE);
+	else
+		ret = avdtp_suspend(session, stream);
 
 	g_assert_cmpint(ret, ==, 0);
 }
@@ -359,7 +363,8 @@ static void discover_cb(struct avdtp *session, GSList *seps,
 	uint8_t data[4] = { 0x21, 0x02, 2, 32 };
 	int ret;
 
-	if (!context)
+	if (g_str_equal(context->data->test_name, "/TP/SIG/SMG/BV-05-C") ||
+		g_str_equal(context->data->test_name, "/TP/SIG/SMG/BV-07-C"))
 		return;
 
 	g_assert(err == NULL);
@@ -391,92 +396,7 @@ static void discover_cb(struct avdtp *session, GSList *seps,
 	g_slist_free_full(caps, g_free);
 }
 
-static void test_discover(gconstpointer data)
-{
-	struct context *context = create_context(0x0100, data);
-
-	avdtp_discover(context->session, discover_cb, NULL);
-
-	execute_context(context);
-}
-
-static void test_get_capabilities(gconstpointer data)
-{
-	struct context *context = create_context(0x0100, data);
-
-	avdtp_discover(context->session, discover_cb, NULL);
-
-	execute_context(context);
-}
-
-static void test_set_configuration(gconstpointer data)
-{
-	struct context *context = create_context(0x0100, data);
-	struct avdtp_local_sep *sep;
-
-	sep = avdtp_register_sep(AVDTP_SEP_TYPE_SINK, AVDTP_MEDIA_TYPE_AUDIO,
-					0x00, FALSE, NULL, NULL, NULL);
-	context->sep = sep;
-
-	avdtp_discover(context->session, discover_cb, context);
-
-	execute_context(context);
-
-	avdtp_unregister_sep(sep);
-}
-
-static void test_get_configuration(gconstpointer data)
-{
-	struct context *context = create_context(0x0100, data);
-	struct avdtp_local_sep *sep;
-
-	sep = avdtp_register_sep(AVDTP_SEP_TYPE_SINK, AVDTP_MEDIA_TYPE_AUDIO,
-					0x00, FALSE, NULL, &sep_cfm,
-					context);
-	context->sep = sep;
-
-	avdtp_discover(context->session, discover_cb, context);
-
-	execute_context(context);
-
-	avdtp_unregister_sep(sep);
-}
-
-static void test_open(gconstpointer data)
-{
-	struct context *context = create_context(0x0100, data);
-	struct avdtp_local_sep *sep;
-
-	sep = avdtp_register_sep(AVDTP_SEP_TYPE_SINK, AVDTP_MEDIA_TYPE_AUDIO,
-					0x00, FALSE, NULL, &sep_cfm,
-					context);
-	context->sep = sep;
-
-	avdtp_discover(context->session, discover_cb, context);
-
-	execute_context(context);
-
-	avdtp_unregister_sep(sep);
-}
-
-static void test_start(gconstpointer data)
-{
-	struct context *context = create_context(0x0100, data);
-	struct avdtp_local_sep *sep;
-
-	sep = avdtp_register_sep(AVDTP_SEP_TYPE_SINK, AVDTP_MEDIA_TYPE_AUDIO,
-					0x00, FALSE, NULL, &sep_cfm,
-					context);
-	context->sep = sep;
-
-	avdtp_discover(context->session, discover_cb, context);
-
-	execute_context(context);
-
-	avdtp_unregister_sep(sep);
-}
-
-static void test_close(gconstpointer data)
+static void test_client(gconstpointer data)
 {
 	struct context *context = create_context(0x0100, data);
 	struct avdtp_local_sep *sep;
@@ -506,12 +426,12 @@ int main(int argc, char *argv[])
 	 * To verify that the following procedures are implemented according to
 	 * their specification in AVDTP.
 	 */
-	define_test("/TP/SIG/SMG/BV-05-C", test_discover,
+	define_test("/TP/SIG/SMG/BV-05-C", test_client,
 			raw_pdu(0x00, 0x01));
 	define_test("/TP/SIG/SMG/BV-06-C", test_server,
 			raw_pdu(0x00, 0x01),
 			raw_pdu(0x02, 0x01, 0x04, 0x00));
-	define_test("/TP/SIG/SMG/BV-07-C", test_get_capabilities,
+	define_test("/TP/SIG/SMG/BV-07-C", test_client,
 			raw_pdu(0x10, 0x01),
 			raw_pdu(0x12, 0x01, 0x04, 0x00),
 			raw_pdu(0x20, 0x02, 0x04));
@@ -521,7 +441,7 @@ int main(int argc, char *argv[])
 			raw_pdu(0x10, 0x02, 0x04),
 			raw_pdu(0x12, 0x02, 0x01, 0x00, 0x07, 0x06, 0x00, 0x00,
 				0xff, 0xff, 0x02, 0x40));
-	define_test("/TP/SIG/SMG/BV-09-C", test_set_configuration,
+	define_test("/TP/SIG/SMG/BV-09-C", test_client,
 			raw_pdu(0x30, 0x01),
 			raw_pdu(0x32, 0x01, 0x04, 0x00),
 			raw_pdu(0x40, 0x02, 0x04),
@@ -538,7 +458,7 @@ int main(int argc, char *argv[])
 			raw_pdu(0x20, 0x03, 0x04, 0x04, 0x01, 0x00, 0x07, 0x06,
 				0x00, 0x00, 0x21, 0x02, 0x02, 0x20),
 			raw_pdu(0x22, 0x03));
-	define_test("/TP/SIG/SMG/BV-11-C", test_get_configuration,
+	define_test("/TP/SIG/SMG/BV-11-C", test_client,
 			raw_pdu(0x60, 0x01),
 			raw_pdu(0x62, 0x01, 0x04, 0x00),
 			raw_pdu(0x70, 0x02, 0x04),
@@ -560,7 +480,7 @@ int main(int argc, char *argv[])
 			raw_pdu(0x30, 0x04, 0x04),
 			raw_pdu(0x32, 0x04, 0x01, 0x00, 0x07, 0x06, 0x00, 0x00,
 				0x21, 0x02, 0x02, 0x20));
-	define_test("/TP/SIG/SMG/BV-15-C", test_open,
+	define_test("/TP/SIG/SMG/BV-15-C", test_client,
 			raw_pdu(0xa0, 0x01),
 			raw_pdu(0xa2, 0x01, 0x04, 0x00),
 			raw_pdu(0xb0, 0x02, 0x04),
@@ -581,7 +501,7 @@ int main(int argc, char *argv[])
 			raw_pdu(0x22, 0x03),
 			raw_pdu(0x30, 0x06, 0x04),
 			raw_pdu(0x32, 0x06));
-	define_test("/TP/SIG/SMG/BV-17-C", test_start,
+	define_test("/TP/SIG/SMG/BV-17-C", test_client,
 			raw_pdu(0xe0, 0x01),
 			raw_pdu(0xe2, 0x01, 0x04, 0x00),
 			raw_pdu(0xf0, 0x02, 0x04),
@@ -606,7 +526,7 @@ int main(int argc, char *argv[])
 			raw_pdu(0x32, 0x06),
 			raw_pdu(0x40, 0x07, 0x04),
 			raw_pdu(0x42, 0x07));
-	define_test("/TP/SIG/SMG/BV-19-C", test_close,
+	define_test("/TP/SIG/SMG/BV-19-C", test_client,
 			raw_pdu(0x30, 0x01),
 			raw_pdu(0x32, 0x01, 0x04, 0x00),
 			raw_pdu(0x40, 0x02, 0x04),
@@ -635,6 +555,20 @@ int main(int argc, char *argv[])
 			raw_pdu(0x42, 0x07),
 			raw_pdu(0x50, 0x08, 0x04),
 			raw_pdu(0x52, 0x08));
+	define_test("/TP/SIG/SMG/BV-21-C", test_client,
+			raw_pdu(0x90, 0x01),
+			raw_pdu(0x92, 0x01, 0x04, 0x00),
+			raw_pdu(0xa0, 0x02, 0x04),
+			raw_pdu(0xa2, 0x02, 0x01, 0x00, 0x07, 0x06, 0x00, 0x00,
+				0xff, 0xff, 0x02, 0x40),
+			raw_pdu(0xb0, 0x03, 0x04, 0x04, 0x01, 0x00, 0x07, 0x06,
+				0x00, 0x00, 0x21, 0x02, 0x02, 0x20),
+			raw_pdu(0xb2, 0x03),
+			raw_pdu(0xc0, 0x06, 0x04),
+			raw_pdu(0xc2, 0x06),
+			raw_pdu(0xd0, 0x07, 0x04),
+			raw_pdu(0xd2, 0x07),
+			raw_pdu(0xe0, 0x09, 0x04));
 
 	return g_test_run();
 }
-- 
1.8.3.1

