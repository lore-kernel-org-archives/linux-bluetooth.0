Return-Path: <cyrus@holtmann.org>
From: Andrei Emeltchenko <Andrei.Emeltchenko.news@gmail.com>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH 2/2] unit/avrcp: Add /TP/ICC/BV-02-I test
Date: Mon, 24 Feb 2014 11:45:25 +0200
Message-Id: <1393235125-28822-2-git-send-email-Andrei.Emeltchenko.news@gmail.com>
In-Reply-To: <1393235125-28822-1-git-send-email-Andrei.Emeltchenko.news@gmail.com>
References: <1393235125-28822-1-git-send-email-Andrei.Emeltchenko.news@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

From: Andrei Emeltchenko <andrei.emeltchenko@intel.com>

The test verifies that the Target responds to SUBUNIT INFO command
initiated by Controller.
---
 unit/test-avrcp.c | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/unit/test-avrcp.c b/unit/test-avrcp.c
index edbcad1..381e7cb 100644
--- a/unit/test-avrcp.c
+++ b/unit/test-avrcp.c
@@ -293,5 +293,11 @@ int main(int argc, char *argv[])
 			raw_pdu(0x02, 0x11, 0x0e, 0x0c, 0xf8, 0x30,
 				0x07, 0x48, 0xff, 0xff, 0xff));
 
+	define_test("/TP/ICC/BV-02-I", test_server,
+			raw_pdu(0x00, 0x11, 0x0e, 0x01, 0xf8, 0x31,
+				0x07, 0xff, 0xff, 0xff, 0xff),
+			raw_pdu(0x02, 0x11, 0x0e, 0x0c, 0xf8, 0x31,
+				0x07, 0x48, 0xff, 0xff, 0xff));
+
 	return g_test_run();
 }
-- 
1.8.3.2

