Return-Path: <cyrus@holtmann.org>
From: Marcin Kraglak <marcin.kraglak@tieto.com>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCHv2 7/9] unit/test-gatt: Add /TP/GAR/CL/BI-09-C test
Date: Wed, 19 Nov 2014 12:26:31 +0100
Message-Id: <1416396393-19997-8-git-send-email-marcin.kraglak@tieto.com>
In-Reply-To: <1416396393-19997-1-git-send-email-marcin.kraglak@tieto.com>
References: <1416396393-19997-1-git-send-email-marcin.kraglak@tieto.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Verify Generic Attribute Profile client behavior when the Read Using
Characteristic UUID procedure fails due to insufficient authorization.
---
 unit/test-gatt.c | 13 +++++++++++++
 1 file changed, 13 insertions(+)

diff --git a/unit/test-gatt.c b/unit/test-gatt.c
index d68c2c7..adcadc5 100644
--- a/unit/test-gatt.c
+++ b/unit/test-gatt.c
@@ -642,6 +642,12 @@ const struct test_step test_read_by_type_3 = {
 	.expected_att_ecode = 0x0a,
 };
 
+const struct test_step test_read_by_type_4 = {
+	.handle = 0x0001,
+	.end_handle = 0xffff,
+	.expected_att_ecode = 0x08,
+};
+
 static void read_by_type_cb(bool success, uint8_t att_ecode,
 						struct bt_gatt_result *result,
 						void *user_data)
@@ -854,5 +860,12 @@ int main(int argc, char *argv[])
 			raw_pdu(0x08, 0x01, 0x00, 0xff, 0xff, 0x0d, 0x2a),
 			raw_pdu(0x01, 0x08, 0x0b, 0x00, 0x0a));
 
+	define_test_att("/TP/GAR/CL/BI-09-C", test_read_by_type, &uuid_char_16,
+			&test_read_by_type_4,
+			raw_pdu(0x02, 0x00, 0x02),
+			raw_pdu(0x03, 0x00, 0x02),
+			raw_pdu(0x08, 0x01, 0x00, 0xff, 0xff, 0x0d, 0x2a),
+			raw_pdu(0x01, 0x08, 0x0b, 0x00, 0x08));
+
 	return g_test_run();
 }
-- 
1.9.3

