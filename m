Return-Path: <cyrus@holtmann.org>
From: Gowtham Anandha Babu <gowtham.ab@samsung.com>
To: linux-bluetooth@vger.kernel.org
Cc: bharat.panda@samsung.com, cpgs@samsung.com,
	Gowtham Anandha Babu <gowtham.ab@samsung.com>
Subject: [PATCH  1/3] unit/test-gatt: Add TP/GAW/SR/BV-03-C test
Date: Fri, 27 Feb 2015 14:43:33 +0530
Message-id: <1425028415-1190-2-git-send-email-gowtham.ab@samsung.com>
In-reply-to: <1425028415-1190-1-git-send-email-gowtham.ab@samsung.com>
References: <1425028415-1190-1-git-send-email-gowtham.ab@samsung.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Verify that a Generic Attribute Profile server can support writing
a Characteristic Value selected by handle.
---
 unit/test-gatt.c | 8 +++++++-
 1 file changed, 7 insertions(+), 1 deletion(-)

diff --git a/unit/test-gatt.c b/unit/test-gatt.c
index eb4ae32..2b6352d 100644
--- a/unit/test-gatt.c
+++ b/unit/test-gatt.c
@@ -1069,7 +1069,7 @@ static struct gatt_db *make_service_data_1_db(void)
 								"Device Name"),
 		PRIMARY_SERVICE(0x0005, HEART_RATE_UUID, 4),
 		CHARACTERISTIC_STR(GATT_CHARAC_MANUFACTURER_NAME_STRING,
-						BT_ATT_PERM_READ,
+						BT_ATT_PERM_READ | BT_ATT_PERM_WRITE,
 						BT_GATT_CHRC_PROP_READ |
 						BT_GATT_CHRC_PROP_WRITE, ""),
 		DESCRIPTOR_STR(GATT_CHARAC_USER_DESC_UUID, BT_ATT_PERM_READ,
@@ -3007,5 +3007,11 @@ int main(int argc, char *argv[])
 			raw_pdu(0x12, 0x07, 0x00, 0x01, 0x02, 0x03),
 			raw_pdu(0x01, 0x12, 0x07, 0x00, 0x0c));
 
+	define_test_server("/TP/GAW/SR/BV-03-C", test_server,
+			service_db_1, NULL,
+			raw_pdu(0x03, 0x00, 0x02),
+			raw_pdu(0x12, 0x07, 0x00, 0x01, 0x02, 0x03),
+			raw_pdu(0x13));
+
 	return tester_run();
 }
-- 
1.9.1

