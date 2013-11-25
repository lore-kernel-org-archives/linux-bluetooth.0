Return-Path: <cyrus@holtmann.org>
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH v2 20/20] unit/AVDTP: Add /TP/SIG/SMG/BV-24-C test
Date: Mon, 25 Nov 2013 16:54:43 +0200
Message-Id: <1385391283-10962-21-git-send-email-luiz.dentz@gmail.com>
In-Reply-To: <1385391283-10962-1-git-send-email-luiz.dentz@gmail.com>
References: <1385391283-10962-1-git-send-email-luiz.dentz@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

From: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>

Verify that the IUT (ACP) is able to accept a command to abort a stream.
---
 unit/test-avdtp.c | 11 +++++++++++
 1 file changed, 11 insertions(+)

diff --git a/unit/test-avdtp.c b/unit/test-avdtp.c
index 949d998..065dc07 100644
--- a/unit/test-avdtp.c
+++ b/unit/test-avdtp.c
@@ -596,6 +596,17 @@ int main(int argc, char *argv[])
 				0x00, 0x00, 0x21, 0x02, 0x02, 0x20),
 			raw_pdu(0x12, 0x03),
 			raw_pdu(0x20, 0x0a, 0x04));
+	define_test("/TP/SIG/SMG/BV-24-C", test_server,
+			raw_pdu(0x00, 0x01),
+			raw_pdu(0x02, 0x01, 0x04, 0x00),
+			raw_pdu(0x10, 0x02, 0x04),
+			raw_pdu(0x12, 0x02, 0x01, 0x00, 0x07, 0x06, 0x00, 0x00,
+				0xff, 0xff, 0x02, 0x40),
+			raw_pdu(0x20, 0x03, 0x04, 0x04, 0x01, 0x00, 0x07, 0x06,
+				0x00, 0x00, 0x21, 0x02, 0x02, 0x20),
+			raw_pdu(0x22, 0x03),
+			raw_pdu(0x30, 0x0a, 0x04),
+			raw_pdu(0x32, 0x0a));
 
 	return g_test_run();
 }
-- 
1.8.3.1

