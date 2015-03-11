Return-Path: <cyrus@holtmann.org>
From: Gowtham Anandha Babu <gowtham.ab@samsung.com>
To: linux-bluetooth@vger.kernel.org
Cc: bharat.panda@samsung.com, cpgs@samsung.com,
	Gowtham Anandha Babu <gowtham.ab@samsung.com>
Subject: [PATCH  3/3] unit/test-gatt: Add TP/GAW/SR/BI-21-C test
Date: Wed, 11 Mar 2015 18:26:29 +0530
Message-id: <1426078589-26354-4-git-send-email-gowtham.ab@samsung.com>
In-reply-to: <1426078589-26354-1-git-send-email-gowtham.ab@samsung.com>
References: <1426078589-26354-1-git-send-email-gowtham.ab@samsung.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Verify that a Generic Attribute Profile server can detect and
reject a Write Characteristic Descriptor Request to a non-writeable
characteristic descriptor and issue a Write Not Permitted Response.
---
 unit/test-gatt.c | 12 ++++++++++++
 1 file changed, 12 insertions(+)

diff --git a/unit/test-gatt.c b/unit/test-gatt.c
index 119205a..1babe11 100644
--- a/unit/test-gatt.c
+++ b/unit/test-gatt.c
@@ -3203,5 +3203,17 @@ int main(int argc, char *argv[])
 			raw_pdu(0x12, 0x0f, 0xf0, 0x01, 0x02, 0x03),
 			raw_pdu(0x01, 0x12, 0x0f, 0xf0, 0x01));
 
+	define_test_server("/TP/GAW/SR/BI-21-C/small", test_server,
+			ts_small_db, NULL,
+			raw_pdu(0x03, 0x00, 0x02),
+			raw_pdu(0x12, 0x13, 0xf0, 0x01, 0x02, 0x03),
+			raw_pdu(0x01, 0x12, 0x13, 0xf0, 0x03));
+
+	define_test_server("/TP/GAW/SR/BI-21-C/large-1", test_server,
+			ts_large_db_1, NULL,
+			raw_pdu(0x03, 0x00, 0x02),
+			raw_pdu(0x12, 0x04, 0x00, 0x01, 0x02, 0x03),
+			raw_pdu(0x01, 0x12, 0x04, 0x00, 0x03));
+
 	return tester_run();
 }
-- 
1.9.1

