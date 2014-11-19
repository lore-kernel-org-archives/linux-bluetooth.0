Return-Path: <cyrus@holtmann.org>
From: Marcin Kraglak <marcin.kraglak@tieto.com>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCHv2 9/9] unit/test-gatt: Add /TP/GAR/CL/BI-11-C test
Date: Wed, 19 Nov 2014 12:26:33 +0100
Message-Id: <1416396393-19997-10-git-send-email-marcin.kraglak@tieto.com>
In-Reply-To: <1416396393-19997-1-git-send-email-marcin.kraglak@tieto.com>
References: <1416396393-19997-1-git-send-email-marcin.kraglak@tieto.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Verify Generic Attribute Profile client behavior when the Read Using
Characteristic UUID procedure fails due to insufficient encryption
key size.
---
 unit/test-gatt.c | 13 +++++++++++++
 1 file changed, 13 insertions(+)

diff --git a/unit/test-gatt.c b/unit/test-gatt.c
index 4265de1..9ded1f0 100644
--- a/unit/test-gatt.c
+++ b/unit/test-gatt.c
@@ -654,6 +654,12 @@ const struct test_step test_read_by_type_5 = {
 	.expected_att_ecode = 0x05,
 };
 
+const struct test_step test_read_by_type_6 = {
+	.handle = 0x0001,
+	.end_handle = 0xffff,
+	.expected_att_ecode = 0x0c,
+};
+
 static void read_by_type_cb(bool success, uint8_t att_ecode,
 						struct bt_gatt_result *result,
 						void *user_data)
@@ -880,5 +886,12 @@ int main(int argc, char *argv[])
 			raw_pdu(0x08, 0x01, 0x00, 0xff, 0xff, 0x0d, 0x2a),
 			raw_pdu(0x01, 0x08, 0x0b, 0x00, 0x05));
 
+	define_test_att("/TP/GAR/CL/BI-11-C", test_read_by_type, &uuid_char_16,
+			&test_read_by_type_6,
+			raw_pdu(0x02, 0x00, 0x02),
+			raw_pdu(0x03, 0x00, 0x02),
+			raw_pdu(0x08, 0x01, 0x00, 0xff, 0xff, 0x0d, 0x2a),
+			raw_pdu(0x01, 0x08, 0x0b, 0x00, 0x0c));
+
 	return g_test_run();
 }
-- 
1.9.3

