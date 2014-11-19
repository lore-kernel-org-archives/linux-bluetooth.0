Return-Path: <cyrus@holtmann.org>
From: Marcin Kraglak <marcin.kraglak@tieto.com>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCHv2 4/9] unit/test-gatt: Add /TP/GAR/CL/BV-03-C-2 test
Date: Wed, 19 Nov 2014 12:26:28 +0100
Message-Id: <1416396393-19997-5-git-send-email-marcin.kraglak@tieto.com>
In-Reply-To: <1416396393-19997-1-git-send-email-marcin.kraglak@tieto.com>
References: <1416396393-19997-1-git-send-email-marcin.kraglak@tieto.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Verify that a Generic Attribute Profile client can read
a Characteristic Value selected by UUID using a 128-bit UUID.
---
 unit/test-gatt.c | 21 +++++++++++++++++++++
 1 file changed, 21 insertions(+)

diff --git a/unit/test-gatt.c b/unit/test-gatt.c
index 72cfbf6..8d5f3b3 100644
--- a/unit/test-gatt.c
+++ b/unit/test-gatt.c
@@ -160,6 +160,12 @@ static bt_uuid_t uuid_128 = {
 				0x80, 0x00, 0x00, 0x80, 0x5f, 0x9b, 0x34, 0xfb}
 };
 
+static bt_uuid_t uuid_char_128 = {
+	.type = BT_UUID128,
+	.value.u128.data = {0x00, 0x01, 0x02, 0x03, 0x04, 0x05, 0x06, 0x07,
+			0x08, 0x09, 0x0a, 0x0b, 0x0c, 0x0d, 0x0e, 0x0f}
+};
+
 const bt_gatt_service_t service_1 = {
 	.primary = true,
 	.start_handle = 0x0001,
@@ -807,5 +813,20 @@ int main(int argc, char *argv[])
 			raw_pdu(0x08, 0x0b, 0x00, 0xff, 0xff, 0x0d, 0x2a),
 			raw_pdu(0x01, 0x08, 0x0b, 0x00, 0x0a));
 
+	define_test_att("/TP/GAR/CL/BV-03-C-2", test_read_by_type,
+			&uuid_char_128, &test_read_by_type_1,
+			raw_pdu(0x02, 0x00, 0x02),
+			raw_pdu(0x03, 0x00, 0x02),
+			raw_pdu(0x08, 0x01, 0x00, 0xff, 0xff, 0x0f, 0x0e, 0x0d,
+					0x0c, 0x0b, 0x0a, 0x09, 0x08, 0x07,
+					0x06, 0x05, 0x04, 0x03, 0x02, 0x01,
+					0x00),
+			raw_pdu(0x09, 0x05, 0x0a, 0x00, 0x01, 0x02, 0x03),
+			raw_pdu(0x08, 0x0b, 0x00, 0xff, 0xff, 0x0f, 0x0e, 0x0d,
+					0x0c, 0x0b, 0x0a, 0x09, 0x08, 0x07,
+					0x06, 0x05, 0x04, 0x03, 0x02, 0x01,
+					0x00),
+			raw_pdu(0x01, 0x08, 0x0b, 0x00, 0x0a));
+
 	return g_test_run();
 }
-- 
1.9.3

