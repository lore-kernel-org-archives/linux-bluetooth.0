Return-Path: <cyrus@holtmann.org>
From: Gowtham Anandha Babu <gowtham.ab@samsung.com>
To: linux-bluetooth@vger.kernel.org
Cc: bharat.panda@samsung.com, cpgs@samsung.com
Subject: [PATCH  3/3] unit/test-gatt: Add TP/GAW/SR/BI-03-C test
Date: Mon, 02 Mar 2015 14:32:08 +0530
Message-id: <1425286928-31479-4-git-send-email-gowtham.ab@samsung.com>
In-reply-to: <1425286928-31479-1-git-send-email-gowtham.ab@samsung.com>
References: <1425286928-31479-1-git-send-email-gowtham.ab@samsung.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

From: Bharat Panda <bharat.panda@samsung.com>

Verify that a Generic Attribute Profile server can detect and
reject a Write Characteristic Value Request to a non-writeable
Characteristic Value and issue a Write Not Permitted Response.
---
 unit/test-gatt.c | 12 ++++++++++++
 1 file changed, 12 insertions(+)

diff --git a/unit/test-gatt.c b/unit/test-gatt.c
index cf1fae2..06f9193 100644
--- a/unit/test-gatt.c
+++ b/unit/test-gatt.c
@@ -3075,5 +3075,17 @@ int main(int argc, char *argv[])
 			raw_pdu(0x12, 0x0f, 0xf0, 0x01, 0x02, 0x03),
 			raw_pdu(0x01, 0x12, 0x0f, 0xf0, 0x01));
 
+	define_test_server("/TP/GAW/SR/BI-03-C/small", test_server,
+			ts_small_db, NULL,
+			raw_pdu(0x03, 0x00, 0x02),
+			raw_pdu(0x12, 0x13, 0xf0, 0x01, 0x02, 0x03),
+			raw_pdu(0x01, 0x12, 0x13, 0xf0, 0x03));
+
+	define_test_server("/TP/GAW/SR/BI-03-C/large-1", test_server,
+			ts_large_db_1, NULL,
+			raw_pdu(0x03, 0x00, 0x02),
+			raw_pdu(0x12, 0x04, 0x00, 0x01, 0x02, 0x03),
+			raw_pdu(0x01, 0x12, 0x04, 0x00, 0x03));
+
 	return tester_run();
 }
-- 
1.9.1

