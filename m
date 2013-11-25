Return-Path: <cyrus@holtmann.org>
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH BlueZ 07/19] unit/AVDTP: Add /TP/SIG/SMG/BV-10-C test
Date: Mon, 25 Nov 2013 15:10:58 +0200
Message-Id: <1385385070-21010-8-git-send-email-luiz.dentz@gmail.com>
In-Reply-To: <1385385070-21010-1-git-send-email-luiz.dentz@gmail.com>
References: <1385385070-21010-1-git-send-email-luiz.dentz@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

From: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>

Verify that the IUT (ACP) reports the reception of a valid set
configuration command for remote SEP, and configures the SEP as
requested and replies the returned confirmation.
---
 unit/test-avdtp.c | 9 +++++++++
 1 file changed, 9 insertions(+)

diff --git a/unit/test-avdtp.c b/unit/test-avdtp.c
index b0991d9..e39ed24 100644
--- a/unit/test-avdtp.c
+++ b/unit/test-avdtp.c
@@ -379,6 +379,15 @@ int main(int argc, char *argv[])
 				0xff, 0xff, 0x02, 0x40),
 			raw_pdu(0x50, 0x03, 0x04, 0x04, 0x01, 0x00, 0x07, 0x06,
 				0x00, 0x00, 0x21, 0x02, 0x02, 0x20));
+	define_test("/TP/SIG/SMG/BV-10-C", test_server,
+			raw_pdu(0x00, 0x01),
+			raw_pdu(0x02, 0x01, 0x04, 0x00),
+			raw_pdu(0x10, 0x02, 0x04),
+			raw_pdu(0x12, 0x02, 0x01, 0x00, 0x07, 0x06, 0x00, 0x00,
+				0xff, 0xff, 0x02, 0x40),
+			raw_pdu(0x20, 0x03, 0x04, 0x04, 0x01, 0x00, 0x07, 0x06,
+				0x00, 0x00, 0x21, 0x02, 0x02, 0x20),
+			raw_pdu(0x22, 0x03));
 
 	return g_test_run();
 }
-- 
1.8.3.1

