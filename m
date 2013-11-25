Return-Path: <cyrus@holtmann.org>
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH v2 15/20] unit/AVDTP: Add /TP/SIG/SMG/BV-19-C test
Date: Mon, 25 Nov 2013 16:54:38 +0200
Message-Id: <1385391283-10962-16-git-send-email-luiz.dentz@gmail.com>
In-Reply-To: <1385391283-10962-1-git-send-email-luiz.dentz@gmail.com>
References: <1385391283-10962-1-git-send-email-luiz.dentz@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

From: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>

Verify that the IUT (INT) is able to initiate the release of a streaming
procedure after the streaming procedure has been started, by issuing the
AVDTP_CLOSE_CMD, releasing all the resources associated to the SEP after
reception of the replied confirmation and reporting the closing.
---
 unit/test-avdtp.c | 51 ++++++++++++++++++++++++++++++++++++++++++++++-----
 1 file changed, 46 insertions(+), 5 deletions(-)

diff --git a/unit/test-avdtp.c b/unit/test-avdtp.c
index 615df00..c01e5fb 100644
--- a/unit/test-avdtp.c
+++ b/unit/test-avdtp.c
@@ -293,12 +293,8 @@ static void sep_setconf_cfm(struct avdtp *session, struct avdtp_local_sep *sep,
 
 	if (g_str_equal(context->data->test_name, "/TP/SIG/SMG/BV-11-C"))
 		ret = avdtp_get_configuration(session, stream);
-	else if (g_str_equal(context->data->test_name, "/TP/SIG/SMG/BV-15-C"))
-		ret = avdtp_open(session, stream);
-	else if (g_str_equal(context->data->test_name, "/TP/SIG/SMG/BV-17-C"))
-		ret = avdtp_open(session, stream);
 	else
-		g_assert_not_reached();
+		ret = avdtp_open(session, stream);
 
 	g_assert_cmpint(ret, ==, 0);
 }
@@ -317,9 +313,23 @@ static void sep_open_cfm(struct avdtp *session, struct avdtp_local_sep *sep,
 	g_assert_cmpint(ret, ==, 0);
 }
 
+static void sep_start_cfm(struct avdtp *session, struct avdtp_local_sep *sep,
+			struct avdtp_stream *stream, struct avdtp_error *err,
+			void *user_data)
+{
+	int ret;
+
+	g_assert(err == NULL);
+
+	ret = avdtp_close(session, stream, FALSE);
+
+	g_assert_cmpint(ret, ==, 0);
+}
+
 static struct avdtp_sep_cfm sep_cfm = {
 	.set_configuration	= sep_setconf_cfm,
 	.open			= sep_open_cfm,
+	.start			= sep_start_cfm,
 };
 
 static void test_server(gconstpointer data)
@@ -466,6 +476,23 @@ static void test_start(gconstpointer data)
 	avdtp_unregister_sep(sep);
 }
 
+static void test_close(gconstpointer data)
+{
+	struct context *context = create_context(0x0100, data);
+	struct avdtp_local_sep *sep;
+
+	sep = avdtp_register_sep(AVDTP_SEP_TYPE_SINK, AVDTP_MEDIA_TYPE_AUDIO,
+					0x00, FALSE, NULL, &sep_cfm,
+					context);
+	context->sep = sep;
+
+	avdtp_discover(context->session, discover_cb, context);
+
+	execute_context(context);
+
+	avdtp_unregister_sep(sep);
+}
+
 int main(int argc, char *argv[])
 {
 	g_test_init(&argc, &argv, NULL);
@@ -579,6 +606,20 @@ int main(int argc, char *argv[])
 			raw_pdu(0x32, 0x06),
 			raw_pdu(0x40, 0x07, 0x04),
 			raw_pdu(0x42, 0x07));
+	define_test("/TP/SIG/SMG/BV-19-C", test_close,
+			raw_pdu(0x30, 0x01),
+			raw_pdu(0x32, 0x01, 0x04, 0x00),
+			raw_pdu(0x40, 0x02, 0x04),
+			raw_pdu(0x42, 0x02, 0x01, 0x00, 0x07, 0x06, 0x00, 0x00,
+				0xff, 0xff, 0x02, 0x40),
+			raw_pdu(0x50, 0x03, 0x04, 0x04, 0x01, 0x00, 0x07, 0x06,
+				0x00, 0x00, 0x21, 0x02, 0x02, 0x20),
+			raw_pdu(0x52, 0x03),
+			raw_pdu(0x60, 0x06, 0x04),
+			raw_pdu(0x62, 0x06),
+			raw_pdu(0x70, 0x07, 0x04),
+			raw_pdu(0x72, 0x07),
+			raw_pdu(0x80, 0x08, 0x04));
 
 	return g_test_run();
 }
-- 
1.8.3.1

