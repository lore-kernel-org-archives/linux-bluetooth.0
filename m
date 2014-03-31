Return-Path: <cyrus@holtmann.org>
From: Andrei Emeltchenko <Andrei.Emeltchenko.news@gmail.com>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCHv4 09/20] unit/avrcp: Add Connection establishment and release tests
Date: Mon, 31 Mar 2014 15:25:03 +0300
Message-Id: <1396268714-4056-9-git-send-email-Andrei.Emeltchenko.news@gmail.com>
In-Reply-To: <1396268714-4056-1-git-send-email-Andrei.Emeltchenko.news@gmail.com>
References: <1396268714-4056-1-git-send-email-Andrei.Emeltchenko.news@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

From: Andrei Emeltchenko <andrei.emeltchenko@intel.com>

Tests are checking connection establishment and release for browsing
channel. Since we are connected through socketpair the tests are dummy.
---
 unit/test-avrcp.c | 13 +++++++++++++
 1 file changed, 13 insertions(+)

diff --git a/unit/test-avrcp.c b/unit/test-avrcp.c
index 6eb2413..a8a5c16 100644
--- a/unit/test-avrcp.c
+++ b/unit/test-avrcp.c
@@ -683,6 +683,19 @@ int main(int argc, char *argv[])
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

