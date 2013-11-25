Return-Path: <cyrus@holtmann.org>
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH v2 10/20] unit/AVDTP: Add /TP/SIG/SMG/BV-12-C test
Date: Mon, 25 Nov 2013 16:54:33 +0200
Message-Id: <1385391283-10962-11-git-send-email-luiz.dentz@gmail.com>
In-Reply-To: <1385391283-10962-1-git-send-email-luiz.dentz@gmail.com>
References: <1385391283-10962-1-git-send-email-luiz.dentz@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

From: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>

Verify that the IUT (ACP) reports the reception of a valid get
configuration command for remote SEP and replies the returned
configuration.
---
 unit/test-avdtp.c | 15 ++++++++++++++-
 1 file changed, 14 insertions(+), 1 deletion(-)

diff --git a/unit/test-avdtp.c b/unit/test-avdtp.c
index 1f43c08..a266819 100644
--- a/unit/test-avdtp.c
+++ b/unit/test-avdtp.c
@@ -368,7 +368,8 @@ static void test_get_configuration(gconstpointer data)
 	context->pdu_list = test->pdu_list;
 
 	sep = avdtp_register_sep(AVDTP_SEP_TYPE_SINK, AVDTP_MEDIA_TYPE_AUDIO,
-					0x00, FALSE, &sep_ind, &sep_cfm, NULL);
+					0x00, FALSE, NULL, &sep_cfm,
+					context);
 	context->sep = sep;
 
 	avdtp_discover(context->session, discover_cb, context);
@@ -435,6 +436,18 @@ int main(int argc, char *argv[])
 				0x00, 0x00, 0x21, 0x02, 0x02, 0x20),
 			raw_pdu(0x82, 0x03),
 			raw_pdu(0x90, 0x04, 0x04));
+	define_test("/TP/SIG/SMG/BV-12-C", test_server,
+			raw_pdu(0x00, 0x01),
+			raw_pdu(0x02, 0x01, 0x04, 0x00),
+			raw_pdu(0x10, 0x02, 0x04),
+			raw_pdu(0x12, 0x02, 0x01, 0x00, 0x07, 0x06, 0x00, 0x00,
+				0xff, 0xff, 0x02, 0x40),
+			raw_pdu(0x20, 0x03, 0x04, 0x04, 0x01, 0x00, 0x07, 0x06,
+				0x00, 0x00, 0x21, 0x02, 0x02, 0x20),
+			raw_pdu(0x22, 0x03),
+			raw_pdu(0x30, 0x04, 0x04),
+			raw_pdu(0x32, 0x04, 0x01, 0x00, 0x07, 0x06, 0x00, 0x00,
+				0x21, 0x02, 0x02, 0x20));
 
 	return g_test_run();
 }
-- 
1.8.3.1

