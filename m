Return-Path: <cyrus@holtmann.org>
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH BlueZ 10/19] unit/AVDTP: Add /TP/SIG/SMG/BV-15-C test
Date: Mon, 25 Nov 2013 15:11:01 +0200
Message-Id: <1385385070-21010-11-git-send-email-luiz.dentz@gmail.com>
In-Reply-To: <1385385070-21010-1-git-send-email-luiz.dentz@gmail.com>
References: <1385385070-21010-1-git-send-email-luiz.dentz@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

From: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>

Verify that the IUT (INT) is able to establish a stream connection to a
previously configured remote SEP by establishing one L2CAP channel
(AVDTP_OPEN_CMD), and reports the related confirmation.
---
 unit/test-avdtp.c | 56 +++++++++++++++++++++++++++++++++++++++++++++++++++++--
 1 file changed, 54 insertions(+), 2 deletions(-)

diff --git a/unit/test-avdtp.c b/unit/test-avdtp.c
index a266819..4e46987 100644
--- a/unit/test-avdtp.c
+++ b/unit/test-avdtp.c
@@ -40,7 +40,7 @@
 
 struct test_pdu {
 	bool valid;
-	const void *data;
+	const uint8_t *data;
 	size_t size;
 };
 
@@ -234,11 +234,31 @@ static void sep_setconf_cfm(struct avdtp *session, struct avdtp_local_sep *sep,
 				struct avdtp_stream *stream,
 				struct avdtp_error *err, void *user_data)
 {
+	struct context *context = user_data;
+	const struct test_pdu *pdu;
 	int ret;
 
 	g_assert(err == NULL);
 
-	ret = avdtp_get_configuration(session, stream);
+	if (!context)
+		return;
+
+	pdu = &context->pdu_list[context->pdu_offset];
+
+	if (pdu->size < 2)
+		return;
+
+	switch (pdu->data[1]) {
+	case 0x04:
+		ret = avdtp_get_configuration(session, stream);
+		break;
+	case 0x06:
+		ret = avdtp_open(session, stream);
+		break;
+	default:
+		g_assert_not_reached();
+	}
+
 	g_assert_cmpint(ret, ==, 0);
 }
 
@@ -381,6 +401,28 @@ static void test_get_configuration(gconstpointer data)
 	g_free(test->pdu_list);
 }
 
+static void test_open(gconstpointer data)
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
@@ -448,6 +490,16 @@ int main(int argc, char *argv[])
 			raw_pdu(0x30, 0x04, 0x04),
 			raw_pdu(0x32, 0x04, 0x01, 0x00, 0x07, 0x06, 0x00, 0x00,
 				0x21, 0x02, 0x02, 0x20));
+	define_test("/TP/SIG/SMG/BV-15-C", test_open,
+			raw_pdu(0xa0, 0x01),
+			raw_pdu(0xa2, 0x01, 0x04, 0x00),
+			raw_pdu(0xb0, 0x02, 0x04),
+			raw_pdu(0xb2, 0x02, 0x01, 0x00, 0x07, 0x06, 0x00, 0x00,
+				0xff, 0xff, 0x02, 0x40),
+			raw_pdu(0xc0, 0x03, 0x04, 0x04, 0x01, 0x00, 0x07, 0x06,
+				0x00, 0x00, 0x21, 0x02, 0x02, 0x20),
+			raw_pdu(0xc2, 0x03),
+			raw_pdu(0xd0, 0x06, 0x04));
 
 	return g_test_run();
 }
-- 
1.8.3.1

