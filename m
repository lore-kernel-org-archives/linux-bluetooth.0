Return-Path: <cyrus@holtmann.org>
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH BlueZ 05/19] unit/AVDTP: Add /TP/SIG/SMG/BV-08-C test
Date: Mon, 25 Nov 2013 15:10:56 +0200
Message-Id: <1385385070-21010-6-git-send-email-luiz.dentz@gmail.com>
In-Reply-To: <1385385070-21010-1-git-send-email-luiz.dentz@gmail.com>
References: <1385385070-21010-1-git-send-email-luiz.dentz@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

From: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>

Verify that the IUT (ACP) reports the reception of a valid query for
remote SEP capabilities and replies the returned capabilities.
---
 unit/test-avdtp.c | 48 ++++++++++++++++++++++++++++++++++++++++++++++--
 1 file changed, 46 insertions(+), 2 deletions(-)

diff --git a/unit/test-avdtp.c b/unit/test-avdtp.c
index 81155a4..0b92489 100644
--- a/unit/test-avdtp.c
+++ b/unit/test-avdtp.c
@@ -195,26 +195,64 @@ static void execute_context(struct context *context)
 	g_free(context);
 }
 
+static gboolean sep_getcap_ind(struct avdtp *session,
+					struct avdtp_local_sep *sep,
+					gboolean get_all, GSList **caps,
+					uint8_t *err, void *user_data)
+{
+	struct avdtp_service_capability *media_transport, *media_codec;
+	struct avdtp_media_codec_capability *codec_caps;
+	uint8_t cap[4] = { 0xff, 0xff, 2, 64 };
+
+	*caps = NULL;
+
+	media_transport = avdtp_service_cap_new(AVDTP_MEDIA_TRANSPORT,
+						NULL, 0);
+
+	*caps = g_slist_append(*caps, media_transport);
+
+	codec_caps = g_malloc0(sizeof(*codec_caps) + sizeof(cap));
+	codec_caps->media_type = AVDTP_MEDIA_TYPE_AUDIO;
+	codec_caps->media_codec_type = 0x00;
+	memcpy(codec_caps->data, cap, sizeof(cap));
+
+	media_codec = avdtp_service_cap_new(AVDTP_MEDIA_CODEC, codec_caps,
+					sizeof(*codec_caps) + sizeof(cap));
+
+	*caps = g_slist_append(*caps, media_codec);
+	g_free(codec_caps);
+
+	return TRUE;
+}
+
+static struct avdtp_sep_ind sep_ind = {
+	.get_capability		= sep_getcap_ind,
+};
+
 static void test_server(gconstpointer data)
 {
 	const struct test_data *test = data;
 	struct context *context = create_context(0x0100);
+	struct avdtp_local_sep *sep;
 
 	context->pdu_list = test->pdu_list;
 
-	avdtp_register_sep(AVDTP_SEP_TYPE_SOURCE, AVDTP_MEDIA_TYPE_AUDIO, 0x00,
-							TRUE, NULL, NULL, NULL);
+	sep = avdtp_register_sep(AVDTP_SEP_TYPE_SOURCE, AVDTP_MEDIA_TYPE_AUDIO,
+					0x00, TRUE, &sep_ind, NULL, NULL);
 
 	g_idle_add(send_pdu, context);
 
 	execute_context(context);
 
+	avdtp_unregister_sep(sep);
+
 	g_free(test->pdu_list);
 }
 
 static void discover_cb(struct avdtp *session, GSList *seps,
 				struct avdtp_error *err, void *user_data)
 {
+
 }
 
 static void test_discover(gconstpointer data)
@@ -267,6 +305,12 @@ int main(int argc, char *argv[])
 			raw_pdu(0x10, 0x01),
 			raw_pdu(0x12, 0x01, 0x04, 0x00),
 			raw_pdu(0x20, 0x02, 0x04));
+	define_test("/TP/SIG/SMG/BV-08-C", test_server,
+			raw_pdu(0x00, 0x01),
+			raw_pdu(0x02, 0x01, 0x04, 0x00),
+			raw_pdu(0x10, 0x02, 0x04),
+			raw_pdu(0x12, 0x02, 0x01, 0x00, 0x07, 0x06, 0x00, 0x00,
+				0xff, 0xff, 0x02, 0x40));
 
 	return g_test_run();
 }
-- 
1.8.3.1

