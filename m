Return-Path: <cyrus@holtmann.org>
From: Andrei Emeltchenko <Andrei.Emeltchenko.news@gmail.com>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH 5/5] unit/avrcp: Add /TP/INV/BI-01-C test
Date: Mon, 10 Mar 2014 15:39:58 +0200
Message-Id: <1394458798-13822-5-git-send-email-Andrei.Emeltchenko.news@gmail.com>
In-Reply-To: <1394458798-13822-1-git-send-email-Andrei.Emeltchenko.news@gmail.com>
References: <1394458798-13822-1-git-send-email-Andrei.Emeltchenko.news@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

From: Andrei Emeltchenko <andrei.emeltchenko@intel.com>

Test verifies that AVRCP_STATUS_INVALID_COMMAND returned when received
command with Invalid PDU ID.
---
 unit/test-avrcp.c | 14 ++++++++++++++
 1 file changed, 14 insertions(+)

diff --git a/unit/test-avrcp.c b/unit/test-avrcp.c
index 09d7689..5d78a9a 100644
--- a/unit/test-avrcp.c
+++ b/unit/test-avrcp.c
@@ -1016,5 +1016,19 @@ int main(int argc, char *argv[])
 				AVRCP_REGISTER_NOTIFICATION,
 				0x00, 0x00, 0x01, AVRCP_STATUS_INVALID_PARAM));
 
+	/* Invalid commands */
+
+	/* Invalid PDU ID - TG */
+	define_test("/TP/INV/BI-01-C", test_server,
+			raw_pdu(0x00, 0x11, 0x0e, 0x03, 0x48, 0x00,
+				0x00, 0x19, 0x58,
+				/* Invalid PDU ID */
+				0xff,
+				0x00, 0x00, 0x00),
+			raw_pdu(0x02, 0x11, 0x0e, AVC_CTYPE_REJECTED,
+				0x48, 0x00, 0x00, 0x19, 0x58,
+				0xff, 0x00, 0x00, 0x01,
+				AVRCP_STATUS_INVALID_COMMAND));
+
 	return g_test_run();
 }
-- 
1.8.3.2

