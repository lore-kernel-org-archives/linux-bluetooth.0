Return-Path: <cyrus@holtmann.org>
From: Gowtham Anandha Babu <gowtham.ab@samsung.com>
To: linux-bluetooth@vger.kernel.org
Cc: bharat.panda@samsung.com, cpgs@samsung.com,
	Gowtham Anandha Babu <gowtham.ab@samsung.com>
Subject: [PATCH v1 1/3] unit/test-gatt: Add TP/GAW/SR/BV-03-C test
Date: Tue, 03 Mar 2015 11:37:24 +0530
Message-id: <1425362846-16580-2-git-send-email-gowtham.ab@samsung.com>
In-reply-to: <1425362846-16580-1-git-send-email-gowtham.ab@samsung.com>
References: <1425362846-16580-1-git-send-email-gowtham.ab@samsung.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Verify that a Generic Attribute Profile server can support
writing a Characteristic Value selected by handle.

The GATT server test cases are supposed to be tested against
ts_small_db and ts_large_db_1. So, Fixed those changes too.
---
 unit/test-gatt.c | 15 +++++++++++----
 1 file changed, 11 insertions(+), 4 deletions(-)

diff --git a/unit/test-gatt.c b/unit/test-gatt.c
index 69654f1..7458fdd 100644
--- a/unit/test-gatt.c
+++ b/unit/test-gatt.c
@@ -1133,7 +1133,8 @@ static struct gatt_db *make_test_spec_small_db(void)
 	const struct att_handle_spec specs[] = {
 		SECONDARY_SERVICE(0x0001, DEVICE_INFORMATION_UUID, 16),
 		CHARACTERISTIC_STR(GATT_CHARAC_MANUFACTURER_NAME_STRING,
-						BT_ATT_PERM_READ,
+						BT_ATT_PERM_READ |
+						BT_ATT_PERM_WRITE,
 						BT_GATT_CHRC_PROP_READ |
 						BT_GATT_CHRC_PROP_NOTIFY |
 						BT_GATT_CHRC_PROP_INDICATE,
@@ -3051,10 +3052,16 @@ int main(int argc, char *argv[])
 			raw_pdu(0x12, 0x07, 0x00, 0x01, 0x02, 0x03),
 			raw_pdu(0x01, 0x12, 0x07, 0x00, 0x0c));
 
-	define_test_server("/TP/GAW/SR/BV-03-C", test_server,
-			service_db_1, NULL,
+	define_test_server("/TP/GAW/SR/BV-03-C/small", test_server,
+			ts_small_db, NULL,
 			raw_pdu(0x03, 0x00, 0x02),
-			raw_pdu(0x12, 0x07, 0x00, 0x01, 0x02, 0x03),
+			raw_pdu(0x12, 0x03, 0x00, 0x01, 0x02, 0x03),
+			raw_pdu(0x13));
+
+	define_test_server("/TP/GAW/SR/BV-03-C/large-1", test_server,
+			ts_large_db_1, NULL,
+			raw_pdu(0x03, 0x00, 0x02),
+			raw_pdu(0x12, 0x82, 0x00, 0x01, 0x02, 0x03),
 			raw_pdu(0x13));
 
 	define_test_server("/TP/GAW/SR/BI-02-C", test_server,
-- 
1.9.1

