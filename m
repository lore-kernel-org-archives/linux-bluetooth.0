Return-Path: <cyrus@holtmann.org>
From: Gowtham Anandha Babu <gowtham.ab@samsung.com>
To: linux-bluetooth@vger.kernel.org
Cc: bharat.panda@samsung.com, cpgs@samsung.com,
	Gowtham Anandha Babu <gowtham.ab@samsung.com>
Subject: [PATCH  1/4] unit/test-gatt: Revert GATT server write TC
Date: Mon, 02 Mar 2015 12:30:17 +0530
Message-id: <1425279620-19132-2-git-send-email-gowtham.ab@samsung.com>
In-reply-to: <1425279620-19132-1-git-send-email-gowtham.ab@samsung.com>
References: <1425279620-19132-1-git-send-email-gowtham.ab@samsung.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

This patch reverts the following commits:
fdca0c1dc9022b92bf7f621f00503fb161b337ee
7b8f5250b71e36052e0adeb3a32aa9f51f26e928
d00d1fa59c87eeb7086cbdadfe7eb99c124b8816.

The GATT server test cases are supposed to tested
against ts_small_db and ts_large_db_1.
---
 unit/test-gatt.c | 21 +--------------------
 1 file changed, 1 insertion(+), 20 deletions(-)

diff --git a/unit/test-gatt.c b/unit/test-gatt.c
index 69654f1..df74122 100644
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
@@ -3051,23 +3050,5 @@ int main(int argc, char *argv[])
 			raw_pdu(0x12, 0x07, 0x00, 0x01, 0x02, 0x03),
 			raw_pdu(0x01, 0x12, 0x07, 0x00, 0x0c));
 
-	define_test_server("/TP/GAW/SR/BV-03-C", test_server,
-			service_db_1, NULL,
-			raw_pdu(0x03, 0x00, 0x02),
-			raw_pdu(0x12, 0x07, 0x00, 0x01, 0x02, 0x03),
-			raw_pdu(0x13));
-
-	define_test_server("/TP/GAW/SR/BI-02-C", test_server,
-			service_db_1, NULL,
-			raw_pdu(0x03, 0x00, 0x02),
-			raw_pdu(0x12, 0x00, 0x00, 0x01, 0x02, 0x03),
-			raw_pdu(0x01, 0x12, 0x00, 0x00, 0x01));
-
-	define_test_server("/TP/GAW/SR/BI-03-C", test_server,
-			service_db_1, NULL,
-			raw_pdu(0x03, 0x00, 0x02),
-			raw_pdu(0x12, 0x03, 0x00, 0x01, 0x02, 0x03),
-			raw_pdu(0x01, 0x12, 0x03, 0x00, 0x03));
-
 	return tester_run();
 }
-- 
1.9.1

