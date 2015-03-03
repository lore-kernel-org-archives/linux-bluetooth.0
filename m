Return-Path: <cyrus@holtmann.org>
From: Gowtham Anandha Babu <gowtham.ab@samsung.com>
To: linux-bluetooth@vger.kernel.org
Cc: bharat.panda@samsung.com, cpgs@samsung.com
Subject: [PATCH v1 2/3] unit/test-gatt: Add TP/GAW/SR/BI-02-C test
Date: Tue, 03 Mar 2015 11:37:25 +0530
Message-id: <1425362846-16580-3-git-send-email-gowtham.ab@samsung.com>
In-reply-to: <1425362846-16580-1-git-send-email-gowtham.ab@samsung.com>
References: <1425362846-16580-1-git-send-email-gowtham.ab@samsung.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

From: Bharat Panda <bharat.panda@samsung.com>

Verify that a Generic Attribute Profile server can detect a Write
Characteristic Value Request with an unsupported Characteristic
Value handle and issue an Invalid Handle Response.

The GATT server test cases are supposed to be tested against
ts_small_db and ts_large_db_1. So, Fixed those changes too.
---
 unit/test-gatt.c | 10 ++++++++--
 1 file changed, 8 insertions(+), 2 deletions(-)

diff --git a/unit/test-gatt.c b/unit/test-gatt.c
index 7458fdd..a1dff74 100644
--- a/unit/test-gatt.c
+++ b/unit/test-gatt.c
@@ -3064,12 +3064,18 @@ int main(int argc, char *argv[])
 			raw_pdu(0x12, 0x82, 0x00, 0x01, 0x02, 0x03),
 			raw_pdu(0x13));
 
-	define_test_server("/TP/GAW/SR/BI-02-C", test_server,
-			service_db_1, NULL,
+	define_test_server("/TP/GAW/SR/BI-02-C/small", test_server,
+			ts_small_db, NULL,
 			raw_pdu(0x03, 0x00, 0x02),
 			raw_pdu(0x12, 0x00, 0x00, 0x01, 0x02, 0x03),
 			raw_pdu(0x01, 0x12, 0x00, 0x00, 0x01));
 
+	define_test_server("/TP/GAW/SR/BI-02-C/large-1", test_server,
+			ts_large_db_1, NULL,
+			raw_pdu(0x03, 0x00, 0x02),
+			raw_pdu(0x12, 0x0f, 0xf0, 0x01, 0x02, 0x03),
+			raw_pdu(0x01, 0x12, 0x0f, 0xf0, 0x01));
+
 	define_test_server("/TP/GAW/SR/BI-03-C", test_server,
 			service_db_1, NULL,
 			raw_pdu(0x03, 0x00, 0x02),
-- 
1.9.1

