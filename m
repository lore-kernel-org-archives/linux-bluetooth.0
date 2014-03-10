Return-Path: <cyrus@holtmann.org>
From: Andrei Emeltchenko <Andrei.Emeltchenko.news@gmail.com>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH 4/5] unit/avrcp: Add /TP/NFY/BI-01-C test
Date: Mon, 10 Mar 2014 15:39:57 +0200
Message-Id: <1394458798-13822-4-git-send-email-Andrei.Emeltchenko.news@gmail.com>
In-Reply-To: <1394458798-13822-1-git-send-email-Andrei.Emeltchenko.news@gmail.com>
References: <1394458798-13822-1-git-send-email-Andrei.Emeltchenko.news@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

From: Andrei Emeltchenko <andrei.emeltchenko@intel.com>

Test verifies that Target returns error on register for invalid event.
---
 unit/test-avrcp.c | 13 +++++++++++++
 1 file changed, 13 insertions(+)

diff --git a/unit/test-avrcp.c b/unit/test-avrcp.c
index 0e65789..09d7689 100644
--- a/unit/test-avrcp.c
+++ b/unit/test-avrcp.c
@@ -1003,5 +1003,18 @@ int main(int argc, char *argv[])
 				0x00, 0x00, 0x00, 0x00, 0x00, 0x00,
 				0x00, 0x00));
 
+	/* Register notification - Register for events invalid behavior - TG */
+	define_test("/TP/NFY/BI-01-C", test_server,
+			raw_pdu(0x00, 0x11, 0x0e, 0x03, 0x48, 0x00,
+				0x00, 0x19, 0x58, AVRCP_REGISTER_NOTIFICATION,
+				0x00, 0x00, 0x05,
+				/* Invalid event id */
+				0xff,
+				0x00, 0x00, 0x00, 0x00),
+			raw_pdu(0x02, 0x11, 0x0e, AVC_CTYPE_REJECTED,
+				0x48, 0x00, 0x00, 0x19, 0x58,
+				AVRCP_REGISTER_NOTIFICATION,
+				0x00, 0x00, 0x01, AVRCP_STATUS_INVALID_PARAM));
+
 	return g_test_run();
 }
-- 
1.8.3.2

