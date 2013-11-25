Return-Path: <cyrus@holtmann.org>
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH BlueZ 12/19] unit/AVDTP: Add /TP/SIG/SMG/BV-17-C test
Date: Mon, 25 Nov 2013 15:11:03 +0200
Message-Id: <1385385070-21010-13-git-send-email-luiz.dentz@gmail.com>
In-Reply-To: <1385385070-21010-1-git-send-email-luiz.dentz@gmail.com>
References: <1385385070-21010-1-git-send-email-luiz.dentz@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

From: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>

Verify that the IUT (INT) is able to start a streaming procedure after
the stream establishment is complete, by issuing the AVDTP_START_CMD,
reporting the replied confirmation and streaming packets.
---
 unit/test-avdtp.c | 54 ++++++++++++++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 54 insertions(+)

diff --git a/unit/test-avdtp.c b/unit/test-avdtp.c
index 2bf782c..7d2c7bc 100644
--- a/unit/test-avdtp.c
+++ b/unit/test-avdtp.c
@@ -30,6 +30,7 @@
 #include <stdbool.h>
 #include <inttypes.h>
 #include <string.h>
+#include <fcntl.h>
 #include <sys/socket.h>
 
 #include <glib.h>
@@ -262,8 +263,27 @@ static void sep_setconf_cfm(struct avdtp *session, struct avdtp_local_sep *sep,
 	g_assert_cmpint(ret, ==, 0);
 }
 
+static void sep_open_cfm(struct avdtp *session, struct avdtp_local_sep *sep,
+			struct avdtp_stream *stream, struct avdtp_error *err,
+			void *user_data)
+{
+	int ret;
+
+	g_assert(err == NULL);
+
+	ret = open("/dev/null", O_RDWR, 0);
+	if (ret < 0)
+		g_assert_not_reached();
+
+	avdtp_stream_set_transport(stream, ret, 672, 672);
+
+	ret = avdtp_start(session, stream);
+	g_assert_cmpint(ret, ==, 0);
+}
+
 static struct avdtp_sep_cfm sep_cfm = {
 	.set_configuration	= sep_setconf_cfm,
+	.open			= sep_open_cfm,
 };
 
 static void test_server(gconstpointer data)
@@ -423,6 +443,28 @@ static void test_open(gconstpointer data)
 	g_free(test->pdu_list);
 }
 
+static void test_start(gconstpointer data)
+{
+	const struct test_data *test = data;
+	struct context *context = create_context(0x0100);
+	struct avdtp_local_sep *sep;
+
+	context->pdu_list = test->pdu_list;
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
+
+	g_free(test->pdu_list);
+}
+
 int main(int argc, char *argv[])
 {
 	g_test_init(&argc, &argv, NULL);
@@ -511,6 +553,18 @@ int main(int argc, char *argv[])
 			raw_pdu(0x22, 0x03),
 			raw_pdu(0x30, 0x06, 0x04),
 			raw_pdu(0x32, 0x06));
+	define_test("/TP/SIG/SMG/BV-17-C", test_start,
+			raw_pdu(0xe0, 0x01),
+			raw_pdu(0xe2, 0x01, 0x04, 0x00),
+			raw_pdu(0xf0, 0x02, 0x04),
+			raw_pdu(0xf2, 0x02, 0x01, 0x00, 0x07, 0x06, 0x00, 0x00,
+				0xff, 0xff, 0x02, 0x40),
+			raw_pdu(0x00, 0x03, 0x04, 0x04, 0x01, 0x00, 0x07, 0x06,
+				0x00, 0x00, 0x21, 0x02, 0x02, 0x20),
+			raw_pdu(0x02, 0x03),
+			raw_pdu(0x10, 0x06, 0x04),
+			raw_pdu(0x12, 0x06),
+			raw_pdu(0x20, 0x07, 0x04));
 
 	return g_test_run();
 }
-- 
1.8.3.1

