Return-Path: <cyrus@holtmann.org>
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH v2 07/20] unit/AVDTP: Add /TP/SIG/SMG/BV-09-C test
Date: Mon, 25 Nov 2013 16:54:30 +0200
Message-Id: <1385391283-10962-8-git-send-email-luiz.dentz@gmail.com>
In-Reply-To: <1385391283-10962-1-git-send-email-luiz.dentz@gmail.com>
References: <1385391283-10962-1-git-send-email-luiz.dentz@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

From: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>

Verify that the IUT (INT) is able to issue a valid set configuration
command for remote SEP and reports the replied confirmation.
---
 unit/test-avdtp.c | 68 +++++++++++++++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 68 insertions(+)

diff --git a/unit/test-avdtp.c b/unit/test-avdtp.c
index 0b92489..b0991d9 100644
--- a/unit/test-avdtp.c
+++ b/unit/test-avdtp.c
@@ -71,6 +71,7 @@ struct test_data {
 struct context {
 	GMainLoop *main_loop;
 	struct avdtp *session;
+	struct avdtp_local_sep *sep;
 	guint source;
 	int fd;
 	int mtu;
@@ -252,7 +253,45 @@ static void test_server(gconstpointer data)
 static void discover_cb(struct avdtp *session, GSList *seps,
 				struct avdtp_error *err, void *user_data)
 {
+	struct context *context = user_data;
+	struct avdtp_stream *stream;
+	struct avdtp_remote_sep *rsep;
+	struct avdtp_service_capability *media_transport, *media_codec;
+	struct avdtp_media_codec_capability *cap;
+	GSList *caps;
+	uint8_t data[4] = { 0x21, 0x02, 2, 32 };
+	int ret;
+
+	if (!context)
+		return;
+
+	g_assert(err == NULL);
+	g_assert_cmpint(g_slist_length(seps), !=, 0);
+
+	rsep = avdtp_find_remote_sep(session, context->sep);
+	g_assert(rsep != NULL);
+
+	media_transport = avdtp_service_cap_new(AVDTP_MEDIA_TRANSPORT,
+						NULL, 0);
+
+	caps = g_slist_append(NULL, media_transport);
+
+	cap = g_malloc0(sizeof(*cap) + sizeof(data));
+	cap->media_type = AVDTP_MEDIA_TYPE_AUDIO;
+	cap->media_codec_type = 0x00;
+	memcpy(cap->data, data, sizeof(data));
 
+	media_codec = avdtp_service_cap_new(AVDTP_MEDIA_CODEC, cap,
+						sizeof(*cap) + sizeof(data));
+
+	caps = g_slist_append(caps, media_codec);
+	g_free(cap);
+
+	ret = avdtp_set_configuration(session, rsep, context->sep, caps,
+								&stream);
+	g_assert_cmpint(ret, ==, 0);
+
+	g_slist_free_full(caps, g_free);
 }
 
 static void test_discover(gconstpointer data)
@@ -283,6 +322,27 @@ static void test_get_capabilities(gconstpointer data)
 	g_free(test->pdu_list);
 }
 
+static void test_set_configuration(gconstpointer data)
+{
+	const struct test_data *test = data;
+	struct context *context = create_context(0x0100);
+	struct avdtp_local_sep *sep;
+
+	context->pdu_list = test->pdu_list;
+
+	sep = avdtp_register_sep(AVDTP_SEP_TYPE_SINK, AVDTP_MEDIA_TYPE_AUDIO,
+					0x00, FALSE, NULL, NULL, NULL);
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
@@ -311,6 +371,14 @@ int main(int argc, char *argv[])
 			raw_pdu(0x10, 0x02, 0x04),
 			raw_pdu(0x12, 0x02, 0x01, 0x00, 0x07, 0x06, 0x00, 0x00,
 				0xff, 0xff, 0x02, 0x40));
+	define_test("/TP/SIG/SMG/BV-09-C", test_set_configuration,
+			raw_pdu(0x30, 0x01),
+			raw_pdu(0x32, 0x01, 0x04, 0x00),
+			raw_pdu(0x40, 0x02, 0x04),
+			raw_pdu(0x42, 0x02, 0x01, 0x00, 0x07, 0x06, 0x00, 0x00,
+				0xff, 0xff, 0x02, 0x40),
+			raw_pdu(0x50, 0x03, 0x04, 0x04, 0x01, 0x00, 0x07, 0x06,
+				0x00, 0x00, 0x21, 0x02, 0x02, 0x20));
 
 	return g_test_run();
 }
-- 
1.8.3.1

