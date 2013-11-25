Return-Path: <cyrus@holtmann.org>
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH BlueZ 08/19] unit/AVDTP: Add /TP/SIG/SMG/BV-11-C test
Date: Mon, 25 Nov 2013 15:10:59 +0200
Message-Id: <1385385070-21010-9-git-send-email-luiz.dentz@gmail.com>
In-Reply-To: <1385385070-21010-1-git-send-email-luiz.dentz@gmail.com>
References: <1385385070-21010-1-git-send-email-luiz.dentz@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

From: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>

Verify that the IUT (INT) is able to issue a valid get configuration
command for remote SEP and report the replied configuration.
---
 unit/test-avdtp.c | 47 +++++++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 47 insertions(+)

diff --git a/unit/test-avdtp.c b/unit/test-avdtp.c
index e39ed24..1f43c08 100644
--- a/unit/test-avdtp.c
+++ b/unit/test-avdtp.c
@@ -230,6 +230,22 @@ static struct avdtp_sep_ind sep_ind = {
 	.get_capability		= sep_getcap_ind,
 };
 
+static void sep_setconf_cfm(struct avdtp *session, struct avdtp_local_sep *sep,
+				struct avdtp_stream *stream,
+				struct avdtp_error *err, void *user_data)
+{
+	int ret;
+
+	g_assert(err == NULL);
+
+	ret = avdtp_get_configuration(session, stream);
+	g_assert_cmpint(ret, ==, 0);
+}
+
+static struct avdtp_sep_cfm sep_cfm = {
+	.set_configuration	= sep_setconf_cfm,
+};
+
 static void test_server(gconstpointer data)
 {
 	const struct test_data *test = data;
@@ -343,6 +359,27 @@ static void test_set_configuration(gconstpointer data)
 	g_free(test->pdu_list);
 }
 
+static void test_get_configuration(gconstpointer data)
+{
+	const struct test_data *test = data;
+	struct context *context = create_context(0x0100);
+	struct avdtp_local_sep *sep;
+
+	context->pdu_list = test->pdu_list;
+
+	sep = avdtp_register_sep(AVDTP_SEP_TYPE_SINK, AVDTP_MEDIA_TYPE_AUDIO,
+					0x00, FALSE, &sep_ind, &sep_cfm, NULL);
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
@@ -388,6 +425,16 @@ int main(int argc, char *argv[])
 			raw_pdu(0x20, 0x03, 0x04, 0x04, 0x01, 0x00, 0x07, 0x06,
 				0x00, 0x00, 0x21, 0x02, 0x02, 0x20),
 			raw_pdu(0x22, 0x03));
+	define_test("/TP/SIG/SMG/BV-11-C", test_get_configuration,
+			raw_pdu(0x60, 0x01),
+			raw_pdu(0x62, 0x01, 0x04, 0x00),
+			raw_pdu(0x70, 0x02, 0x04),
+			raw_pdu(0x72, 0x02, 0x01, 0x00, 0x07, 0x06, 0x00, 0x00,
+				0xff, 0xff, 0x02, 0x40),
+			raw_pdu(0x80, 0x03, 0x04, 0x04, 0x01, 0x00, 0x07, 0x06,
+				0x00, 0x00, 0x21, 0x02, 0x02, 0x20),
+			raw_pdu(0x82, 0x03),
+			raw_pdu(0x90, 0x04, 0x04));
 
 	return g_test_run();
 }
-- 
1.8.3.1

