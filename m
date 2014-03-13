Return-Path: <cyrus@holtmann.org>
From: Andrei Emeltchenko <Andrei.Emeltchenko.news@gmail.com>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH] unit/avrcp: Add Connection establishment and release tests
Date: Thu, 13 Mar 2014 15:39:03 +0200
Message-Id: <1394717943-25363-1-git-send-email-Andrei.Emeltchenko.news@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

From: Andrei Emeltchenko <andrei.emeltchenko@intel.com>

Tests are checking connection establishment and release for browsing
channel. Since we are connected through socketpair the tests are dummy.
---
 unit/test-avrcp.c | 13 +++++++++++++
 1 file changed, 13 insertions(+)

diff --git a/unit/test-avrcp.c b/unit/test-avrcp.c
index 3a7e0d1..c5aa32c 100644
--- a/unit/test-avrcp.c
+++ b/unit/test-avrcp.c
@@ -822,6 +822,19 @@ int main(int argc, char *argv[])
 				0x00, 0x00, 0x00, 0x02, /* end */
 				0x00));
 
+	/* Connection Establishment for Browsing tests */
+
+	/*
+	 * Tests are checking connection establishment and release
+	 * for browsing channel. Since we are connected through socketpair
+	 * the tests are dummy
+	 */
+	define_test("/TP/CON/BV-01-C", test_dummy, raw_pdu(0x00));
+	define_test("/TP/CON/BV-02-C", test_dummy, raw_pdu(0x00));
+	define_test("/TP/CON/BV-03-C", test_dummy, raw_pdu(0x00));
+	define_test("/TP/CON/BV-04-C", test_dummy, raw_pdu(0x00));
+	define_test("/TP/CON/BV-05-C", test_dummy, raw_pdu(0x00));
+
 	/* Connection Establishment for Control tests */
 
 	/*
-- 
1.8.3.2

