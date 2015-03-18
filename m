Return-Path: <cyrus@holtmann.org>
From: Gowtham Anandha Babu <gowtham.ab@samsung.com>
To: linux-bluetooth@vger.kernel.org
Cc: bharat.panda@samsung.com, cpgs@samsung.com,
	Gowtham Anandha Babu <gowtham.ab@samsung.com>
Subject: [PATCH  2/7] unit/test-gatt: Add TP/GAW/SR/BV-10-C test
Date: Wed, 18 Mar 2015 15:35:36 +0530
Message-id: <1426673141-17700-3-git-send-email-gowtham.ab@samsung.com>
In-reply-to: <1426673141-17700-1-git-send-email-gowtham.ab@samsung.com>
References: <1426673141-17700-1-git-send-email-gowtham.ab@samsung.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Verify that a Generic Attribute Profile server can support nested
reliable writing to long Characteristic Values selected by handle.
---
 unit/test-gatt.c | 30 +++++++++++++++++++++++++++++-
 1 file changed, 29 insertions(+), 1 deletion(-)

diff --git a/unit/test-gatt.c b/unit/test-gatt.c
index 65bdc52..09ca61a 100644
--- a/unit/test-gatt.c
+++ b/unit/test-gatt.c
@@ -1204,7 +1204,7 @@ static struct gatt_db *make_test_spec_small_db(void)
 							BT_GATT_CHRC_PROP_READ,
 							"BlueZ Unit Tester"),
 		CHARACTERISTIC(0000B009-0000-0000-0123-456789abcdef,
-						BT_ATT_PERM_READ,
+						BT_ATT_PERM_READ | BT_ATT_PERM_WRITE,
 						BT_GATT_CHRC_PROP_READ, 0x09),
 		CHARACTERISTIC(GATT_CHARAC_APPEARANCE, BT_ATT_PERM_READ,
 					BT_GATT_CHRC_PROP_READ, 0x00, 0x00),
@@ -3219,6 +3219,34 @@ int main(int argc, char *argv[])
 			raw_pdu(0x18, 0x01),
 			raw_pdu(0x19));
 
+	define_test_server("/TP/GAW/SR/BV-10-C/small", test_server,
+			ts_small_db, NULL,
+			raw_pdu(0x03, 0x00, 0x02),
+			raw_pdu(0x16, 0x03, 0x00, 0x00, 0x00, 0x01, 0x02, 0x03),
+			raw_pdu(0x17, 0x03, 0x00, 0x00, 0x00, 0x01, 0x02, 0x03),
+			raw_pdu(0x16, 0x15, 0xf0, 0x00, 0x00, 0x01, 0x02, 0x03),
+			raw_pdu(0x17, 0x15, 0xf0, 0x00, 0x00, 0x01, 0x02, 0x03),
+			raw_pdu(0x16, 0x03, 0x00, 0x03, 0x00, 0x04, 0x05, 0x06),
+			raw_pdu(0x17, 0x03, 0x00, 0x03, 0x00, 0x04, 0x05, 0x06),
+			raw_pdu(0x16, 0x15, 0xf0, 0x03, 0x00, 0x04, 0x05, 0x06),
+			raw_pdu(0x17, 0x15, 0xf0, 0x03, 0x00, 0x04, 0x05, 0x06),
+			raw_pdu(0x18, 0x01),
+			raw_pdu(0x19));
+
+	define_test_server("/TP/GAW/SR/BV-10-C/large-1", test_server,
+			ts_large_db_1, NULL,
+			raw_pdu(0x03, 0x00, 0x02),
+			raw_pdu(0x16, 0x82, 0x00, 0x00, 0x00, 0x01, 0x02, 0x03),
+			raw_pdu(0x17, 0x82, 0x00, 0x00, 0x00, 0x01, 0x02, 0x03),
+			raw_pdu(0x16, 0x25, 0x00, 0x00, 0x00, 0x01, 0x02, 0x03),
+			raw_pdu(0x17, 0x25, 0x00, 0x00, 0x00, 0x01, 0x02, 0x03),
+			raw_pdu(0x16, 0x82, 0x00, 0x03, 0x00, 0x04, 0x05, 0x06),
+			raw_pdu(0x17, 0x82, 0x00, 0x03, 0x00, 0x04, 0x05, 0x06),
+			raw_pdu(0x16, 0x25, 0x00, 0x03, 0x00, 0x04, 0x05, 0x06),
+			raw_pdu(0x17, 0x25, 0x00, 0x03, 0x00, 0x04, 0x05, 0x06),
+			raw_pdu(0x18, 0x01),
+			raw_pdu(0x19));
+
 	define_test_client("/TP/GAW/CL/BV-08-C", test_client, service_db_1,
 			&test_write_7,
 			SERVICE_DATA_1_PDUS,
-- 
1.9.1

