Return-Path: <cyrus@holtmann.org>
From: Andrei Emeltchenko <Andrei.Emeltchenko.news@gmail.com>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH 3/3] unit/avrcp: Add /TP/CFG/BV-02-C test
Date: Tue, 25 Feb 2014 15:56:45 +0200
Message-Id: <1393336605-2467-3-git-send-email-Andrei.Emeltchenko.news@gmail.com>
In-Reply-To: <1393336605-2467-1-git-send-email-Andrei.Emeltchenko.news@gmail.com>
References: <1393336605-2467-1-git-send-email-Andrei.Emeltchenko.news@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

From: Andrei Emeltchenko <andrei.emeltchenko@intel.com>

Test verifies that the Target responds to Get Capability request.
---
 unit/test-avrcp.c | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/unit/test-avrcp.c b/unit/test-avrcp.c
index 4a92860..71a4d0e 100644
--- a/unit/test-avrcp.c
+++ b/unit/test-avrcp.c
@@ -381,5 +381,13 @@ int main(int argc, char *argv[])
 				0x00, 0x19, 0x58, 0x10, 0x00, 0x00,
 				0x01, 0x03));
 
+	define_test("/TP/CFG/BV-02-C", test_server,
+			raw_pdu(0x00, 0x11, 0x0e, 0x01, 0x48, 0x00,
+				0x00, 0x19, 0x58, 0x10, 0x00, 0x00,
+				0x01, 0x02),
+			raw_pdu(0x02, 0x11, 0x0e, 0x0c, 0x48, 0x00,
+				0x00, 0x19, 0x58, 0x10, 0x00, 0x00,
+				0x01, 0x02, 0x01, 0x00, 0x19, 0x58));
+
 	return g_test_run();
 }
-- 
1.8.3.2

