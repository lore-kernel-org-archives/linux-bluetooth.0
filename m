Return-Path: <cyrus@holtmann.org>
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH BlueZ 18/19] unit/AVDTP: Add /TP/SIG/SMG/BV-23-C test
Date: Mon, 25 Nov 2013 15:11:09 +0200
Message-Id: <1385385070-21010-19-git-send-email-luiz.dentz@gmail.com>
In-Reply-To: <1385385070-21010-1-git-send-email-luiz.dentz@gmail.com>
References: <1385385070-21010-1-git-send-email-luiz.dentz@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

From: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>

Verify that the IUT (INT) is able to abort a stream by issuing the
AVDTP_ABORT and reporting the replied confirmation.
---
 unit/test-avdtp.c | 12 ++++++++++++
 1 file changed, 12 insertions(+)

diff --git a/unit/test-avdtp.c b/unit/test-avdtp.c
index 88c2b01..949d998 100644
--- a/unit/test-avdtp.c
+++ b/unit/test-avdtp.c
@@ -293,6 +293,8 @@ static void sep_setconf_cfm(struct avdtp *session, struct avdtp_local_sep *sep,
 
 	if (g_str_equal(context->data->test_name, "/TP/SIG/SMG/BV-11-C"))
 		ret = avdtp_get_configuration(session, stream);
+	if (g_str_equal(context->data->test_name, "/TP/SIG/SMG/BV-23-C"))
+		ret = avdtp_abort(session, stream);
 	else
 		ret = avdtp_open(session, stream);
 
@@ -584,6 +586,16 @@ int main(int argc, char *argv[])
 			raw_pdu(0x42, 0x07),
 			raw_pdu(0x50, 0x09, 0x04),
 			raw_pdu(0x52, 0x09));
+	define_test("/TP/SIG/SMG/BV-23-C", test_client,
+			raw_pdu(0xf0, 0x01),
+			raw_pdu(0xf2, 0x01, 0x04, 0x00),
+			raw_pdu(0x00, 0x02, 0x04),
+			raw_pdu(0x02, 0x02, 0x01, 0x00, 0x07, 0x06, 0x00, 0x00,
+				0xff, 0xff, 0x02, 0x40),
+			raw_pdu(0x10, 0x03, 0x04, 0x04, 0x01, 0x00, 0x07, 0x06,
+				0x00, 0x00, 0x21, 0x02, 0x02, 0x20),
+			raw_pdu(0x12, 0x03),
+			raw_pdu(0x20, 0x0a, 0x04));
 
 	return g_test_run();
 }
-- 
1.8.3.1

