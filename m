Return-Path: <cyrus@holtmann.org>
From: Gowtham Anandha Babu <gowtham.ab@samsung.com>
To: linux-bluetooth@vger.kernel.org
Cc: bharat.panda@samsung.com, cpgs@samsung.com
Subject: [PATCH v1 3/3] unit/test-gatt: Add TP/GAW/SR/BI-03-C test
Date: Tue, 03 Mar 2015 11:37:26 +0530
Message-id: <1425362846-16580-4-git-send-email-gowtham.ab@samsung.com>
In-reply-to: <1425362846-16580-1-git-send-email-gowtham.ab@samsung.com>
References: <1425362846-16580-1-git-send-email-gowtham.ab@samsung.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

From: Bharat Panda <bharat.panda@samsung.com>

Verify that a Generic Attribute Profile server can detect and
reject a Write Characteristic Value Request to a non-writeable
Characteristic Value and issue a Write Not Permitted Response.

The GATT server test cases are supposed to be tested against
ts_small_db and ts_large_db_1. So, Fixed these changes too.
---
 unit/test-gatt.c | 17 +++++++++++------
 1 file changed, 11 insertions(+), 6 deletions(-)

diff --git a/unit/test-gatt.c b/unit/test-gatt.c
index a1dff74..06f9193 100644
--- a/unit/test-gatt.c
+++ b/unit/test-gatt.c
@@ -1101,8 +1101,7 @@ static struct gatt_db *make_service_data_1_db(void)
 								"Device Name"),
 		PRIMARY_SERVICE(0x0005, HEART_RATE_UUID, 4),
 		CHARACTERISTIC_STR(GATT_CHARAC_MANUFACTURER_NAME_STRING,
-						BT_ATT_PERM_READ |
-						BT_ATT_PERM_WRITE,
+						BT_ATT_PERM_READ,
 						BT_GATT_CHRC_PROP_READ |
 						BT_GATT_CHRC_PROP_WRITE, ""),
 		DESCRIPTOR_STR(GATT_CHARAC_USER_DESC_UUID, BT_ATT_PERM_READ,
@@ -3076,11 +3075,17 @@ int main(int argc, char *argv[])
 			raw_pdu(0x12, 0x0f, 0xf0, 0x01, 0x02, 0x03),
 			raw_pdu(0x01, 0x12, 0x0f, 0xf0, 0x01));
 
-	define_test_server("/TP/GAW/SR/BI-03-C", test_server,
-			service_db_1, NULL,
+	define_test_server("/TP/GAW/SR/BI-03-C/small", test_server,
+			ts_small_db, NULL,
+			raw_pdu(0x03, 0x00, 0x02),
+			raw_pdu(0x12, 0x13, 0xf0, 0x01, 0x02, 0x03),
+			raw_pdu(0x01, 0x12, 0x13, 0xf0, 0x03));
+
+	define_test_server("/TP/GAW/SR/BI-03-C/large-1", test_server,
+			ts_large_db_1, NULL,
 			raw_pdu(0x03, 0x00, 0x02),
-			raw_pdu(0x12, 0x03, 0x00, 0x01, 0x02, 0x03),
-			raw_pdu(0x01, 0x12, 0x03, 0x00, 0x03));
+			raw_pdu(0x12, 0x04, 0x00, 0x01, 0x02, 0x03),
+			raw_pdu(0x01, 0x12, 0x04, 0x00, 0x03));
 
 	return tester_run();
 }
-- 
1.9.1

