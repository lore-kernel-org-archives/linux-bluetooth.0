Return-Path: <cyrus@holtmann.org>
From: Andrei Emeltchenko <Andrei.Emeltchenko.news@gmail.com>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH 2/3] unit/avrcp: Add /TP/PTT/BV-01-I test
Date: Mon, 24 Feb 2014 15:25:17 +0200
Message-Id: <1393248318-5188-2-git-send-email-Andrei.Emeltchenko.news@gmail.com>
In-Reply-To: <1393248318-5188-1-git-send-email-Andrei.Emeltchenko.news@gmail.com>
References: <1393248318-5188-1-git-send-email-Andrei.Emeltchenko.news@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

From: Andrei Emeltchenko <andrei.emeltchenko@intel.com>

Test verifies that the Target reacts to the PASS THROUGH command in
category 1 from the Controller. The command chosen is PLAY (0x44).
---
 unit/test-avrcp.c | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/unit/test-avrcp.c b/unit/test-avrcp.c
index e9fe7e3..9d2e56a 100644
--- a/unit/test-avrcp.c
+++ b/unit/test-avrcp.c
@@ -291,5 +291,11 @@ int main(int argc, char *argv[])
 			raw_pdu(0x02, 0x11, 0x0e, 0x0c, 0xf8, 0x31,
 				0x07, 0x48, 0xff, 0xff, 0xff));
 
+	define_test("/TP/PTT/BV-01-I", test_server,
+			raw_pdu(0x00, 0x11, 0x0e, 0x00, 0x48, 0x7c,
+				0x44, 0x00),
+			raw_pdu(0x02, 0x11, 0x0e, 0x09, 0x48, 0x7c,
+				0x44, 0x00));
+
 	return g_test_run();
 }
-- 
1.8.3.2

