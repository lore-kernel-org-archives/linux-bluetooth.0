Return-Path: <cyrus@holtmann.org>
From: Gowtham Anandha Babu <gowtham.ab@samsung.com>
To: linux-bluetooth@vger.kernel.org
Cc: bharat.panda@samsung.com, cpgs@samsung.com,
	Gowtham Anandha Babu <gowtham.ab@samsung.com>
Subject: [PATCH  2/4] unit/test-gatt: Add TP/GAW/SR/BV-03-C test
Date: Mon, 02 Mar 2015 12:30:18 +0530
Message-id: <1425279620-19132-3-git-send-email-gowtham.ab@samsung.com>
In-reply-to: <1425279620-19132-1-git-send-email-gowtham.ab@samsung.com>
References: <1425279620-19132-1-git-send-email-gowtham.ab@samsung.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Verify that a Generic Attribute Profile server can support writing
a Characteristic Value selected by handle.
---
 unit/test-gatt.c | 15 ++++++++++++++-
 1 file changed, 14 insertions(+), 1 deletion(-)

diff --git a/unit/test-gatt.c b/unit/test-gatt.c
index df74122..104f415 100644
--- a/unit/test-gatt.c
+++ b/unit/test-gatt.c
@@ -1132,7 +1132,8 @@ static struct gatt_db *make_test_spec_small_db(void)
 	const struct att_handle_spec specs[] = {
 		SECONDARY_SERVICE(0x0001, DEVICE_INFORMATION_UUID, 16),
 		CHARACTERISTIC_STR(GATT_CHARAC_MANUFACTURER_NAME_STRING,
-						BT_ATT_PERM_READ,
+						BT_ATT_PERM_READ |
+						BT_ATT_PERM_WRITE,
 						BT_GATT_CHRC_PROP_READ |
 						BT_GATT_CHRC_PROP_NOTIFY |
 						BT_GATT_CHRC_PROP_INDICATE,
@@ -3050,5 +3051,17 @@ int main(int argc, char *argv[])
 			raw_pdu(0x12, 0x07, 0x00, 0x01, 0x02, 0x03),
 			raw_pdu(0x01, 0x12, 0x07, 0x00, 0x0c));
 
+	define_test_server("/TP/GAW/SR/BV-03-C/small", test_server,
+			ts_small_db, NULL,
+			raw_pdu(0x03, 0x00, 0x02),
+			raw_pdu(0x12, 0x03, 0x00, 0x01, 0x02, 0x03),
+			raw_pdu(0x13));
+
+	define_test_server("/TP/GAW/SR/BV-03-C/large-1", test_server,
+			ts_large_db_1, NULL,
+			raw_pdu(0x03, 0x00, 0x02),
+			raw_pdu(0x12, 0x82, 0x00, 0x01, 0x02, 0x03),
+			raw_pdu(0x13));
+
 	return tester_run();
 }
-- 
1.9.1

