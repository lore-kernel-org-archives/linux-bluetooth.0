Return-Path: <cyrus@holtmann.org>
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH v2 04/20] unit/AVDTP: Add /TP/SIG/SMG/BV-06-C test
Date: Mon, 25 Nov 2013 16:54:27 +0200
Message-Id: <1385391283-10962-5-git-send-email-luiz.dentz@gmail.com>
In-Reply-To: <1385391283-10962-1-git-send-email-luiz.dentz@gmail.com>
References: <1385391283-10962-1-git-send-email-luiz.dentz@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

From: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>

Verify that the IUT (ACP) reports the reception of a valid stream
discover command and replies the returned list of SEPs and media types.
---
 unit/test-avdtp.c | 19 +++++++++++++++++++
 1 file changed, 19 insertions(+)

diff --git a/unit/test-avdtp.c b/unit/test-avdtp.c
index 2dc9424..5623153 100644
--- a/unit/test-avdtp.c
+++ b/unit/test-avdtp.c
@@ -195,6 +195,22 @@ static void execute_context(struct context *context)
 	g_free(context);
 }
 
+static void test_server(gconstpointer data)
+{
+	const struct test_data *test = data;
+	struct context *context = create_context();
+
+	context->pdu_list = test->pdu_list;
+	avdtp_register_sep(AVDTP_SEP_TYPE_SOURCE, AVDTP_MEDIA_TYPE_AUDIO, 0x00,
+				TRUE, NULL, NULL, NULL);
+
+	g_idle_add(send_pdu, context);
+
+	execute_context(context);
+
+	g_free(test->pdu_list);
+}
+
 static void discover_cb(struct avdtp *session, GSList *seps,
 				struct avdtp_error *err, void *user_data)
 {
@@ -229,6 +245,9 @@ int main(int argc, char *argv[])
 	 */
 	define_test("/TP/SIG/SMG/BV-05-C", test_discover,
 			raw_pdu(0x00, 0x01));
+	define_test("/TP/SIG/SMG/BV-06-C", test_server,
+			raw_pdu(0x00, 0x01),
+			raw_pdu(0x02, 0x01, 0x04, 0x00));
 
 	return g_test_run();
 }
-- 
1.8.3.1

