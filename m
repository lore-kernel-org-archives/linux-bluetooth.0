Return-Path: <cyrus@holtmann.org>
From: Gowtham Anandha Babu <gowtham.ab@samsung.com>
To: linux-bluetooth@vger.kernel.org
Cc: bharat.panda@samsung.com, cpgs@samsung.com
Subject: [PATCH  2/3] unit/test-gatt: Add TP/GAW/SR/BI-02-C test
Date: Mon, 02 Mar 2015 14:32:07 +0530
Message-id: <1425286928-31479-3-git-send-email-gowtham.ab@samsung.com>
In-reply-to: <1425286928-31479-1-git-send-email-gowtham.ab@samsung.com>
References: <1425286928-31479-1-git-send-email-gowtham.ab@samsung.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

From: Bharat Panda <bharat.panda@samsung.com>

Verify that a Generic Attribute Profile server can detect a Write
Characteristic Value Request with an unsupported Characteristic
Value handle and issue an Invalid Handle Response.
---
 unit/test-gatt.c | 12 ++++++++++++
 1 file changed, 12 insertions(+)

diff --git a/unit/test-gatt.c b/unit/test-gatt.c
index 104f415..cf1fae2 100644
--- a/unit/test-gatt.c
+++ b/unit/test-gatt.c
@@ -3063,5 +3063,17 @@ int main(int argc, char *argv[])
 			raw_pdu(0x12, 0x82, 0x00, 0x01, 0x02, 0x03),
 			raw_pdu(0x13));
 
+	define_test_server("/TP/GAW/SR/BI-02-C/small", test_server,
+			ts_small_db, NULL,
+			raw_pdu(0x03, 0x00, 0x02),
+			raw_pdu(0x12, 0x00, 0x00, 0x01, 0x02, 0x03),
+			raw_pdu(0x01, 0x12, 0x00, 0x00, 0x01));
+
+	define_test_server("/TP/GAW/SR/BI-02-C/large-1", test_server,
+			ts_large_db_1, NULL,
+			raw_pdu(0x03, 0x00, 0x02),
+			raw_pdu(0x12, 0x0f, 0xf0, 0x01, 0x02, 0x03),
+			raw_pdu(0x01, 0x12, 0x0f, 0xf0, 0x01));
+
 	return tester_run();
 }
-- 
1.9.1

