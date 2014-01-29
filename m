Return-Path: <cyrus@holtmann.org>
From: Andrei Emeltchenko <Andrei.Emeltchenko.news@gmail.com>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCHv2 3/3] unit/avctp: Add TP/NFR/BI-01-C test
Date: Wed, 29 Jan 2014 14:41:14 +0200
Message-Id: <1390999274-15631-4-git-send-email-Andrei.Emeltchenko.news@gmail.com>
In-Reply-To: <1390999274-15631-1-git-send-email-Andrei.Emeltchenko.news@gmail.com>
References: <1390999274-15631-1-git-send-email-Andrei.Emeltchenko.news@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

From: Andrei Emeltchenko <andrei.emeltchenko@intel.com>

To verify that the IUT (TG) reports to the test system (CT) the
reception of a control message intended for an invalid PID (PID not
registered for reception of messages).
---
 unit/test-avctp.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/unit/test-avctp.c b/unit/test-avctp.c
index 8c97a82..041e0c0 100644
--- a/unit/test-avctp.c
+++ b/unit/test-avctp.c
@@ -267,5 +267,9 @@ int main(int argc, char *argv[])
 				raw_pdu(0x00, 0x11, 0x0e, 0x00, 0x00, 0x00),
 				raw_pdu(0x02, 0x11, 0x0e, 0x0a, 0x00, 0x00));
 
+	define_test("/TP/NFR/BI-01-C", test_server,
+				raw_pdu(0x00, 0xff, 0xff, 0x00, 0x00, 0x00),
+				raw_pdu(0x03, 0xff, 0xff));
+
 	return g_test_run();
 }
-- 
1.8.3.2

