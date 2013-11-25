Return-Path: <cyrus@holtmann.org>
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH BlueZ 15/19] unit/AVDTP: Add /TP/SIG/SMG/BV-20-C test
Date: Mon, 25 Nov 2013 15:11:06 +0200
Message-Id: <1385385070-21010-16-git-send-email-luiz.dentz@gmail.com>
In-Reply-To: <1385385070-21010-1-git-send-email-luiz.dentz@gmail.com>
References: <1385385070-21010-1-git-send-email-luiz.dentz@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

From: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>

Verify that the IUT (ACP) is able to accept an AVDTP_CLOSE_CMD after the
streaming procedure has been started, by releasing all the resources
associated to the SEP, reporting of the closing and replying the
returned confirmation.
---
 unit/test-avdtp.c | 15 +++++++++++++++
 1 file changed, 15 insertions(+)

diff --git a/unit/test-avdtp.c b/unit/test-avdtp.c
index c01e5fb..4677e22 100644
--- a/unit/test-avdtp.c
+++ b/unit/test-avdtp.c
@@ -620,6 +620,21 @@ int main(int argc, char *argv[])
 			raw_pdu(0x70, 0x07, 0x04),
 			raw_pdu(0x72, 0x07),
 			raw_pdu(0x80, 0x08, 0x04));
+	define_test("/TP/SIG/SMG/BV-20-C", test_server,
+			raw_pdu(0x00, 0x01),
+			raw_pdu(0x02, 0x01, 0x04, 0x00),
+			raw_pdu(0x10, 0x02, 0x04),
+			raw_pdu(0x12, 0x02, 0x01, 0x00, 0x07, 0x06, 0x00, 0x00,
+				0xff, 0xff, 0x02, 0x40),
+			raw_pdu(0x20, 0x03, 0x04, 0x04, 0x01, 0x00, 0x07, 0x06,
+				0x00, 0x00, 0x21, 0x02, 0x02, 0x20),
+			raw_pdu(0x22, 0x03),
+			raw_pdu(0x30, 0x06, 0x04),
+			raw_pdu(0x32, 0x06),
+			raw_pdu(0x40, 0x07, 0x04),
+			raw_pdu(0x42, 0x07),
+			raw_pdu(0x50, 0x08, 0x04),
+			raw_pdu(0x52, 0x08));
 
 	return g_test_run();
 }
-- 
1.8.3.1

