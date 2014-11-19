Return-Path: <cyrus@holtmann.org>
From: Marcin Kraglak <marcin.kraglak@tieto.com>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH 8/8] unit/test-gatt: Add /TP/GAR/CL/BI-22-C test
Date: Wed, 19 Nov 2014 14:01:35 +0100
Message-Id: <1416402095-5137-9-git-send-email-marcin.kraglak@tieto.com>
In-Reply-To: <1416402095-5137-1-git-send-email-marcin.kraglak@tieto.com>
References: <1416402095-5137-1-git-send-email-marcin.kraglak@tieto.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Verify Generic Attribute Profile client behavior when the
Read Multiple Characteristic Values procedure fails due to
encryption key size.
---
 unit/test-gatt.c | 13 +++++++++++++
 1 file changed, 13 insertions(+)

diff --git a/unit/test-gatt.c b/unit/test-gatt.c
index dc4d0b1..7923c8b 100644
--- a/unit/test-gatt.c
+++ b/unit/test-gatt.c
@@ -726,6 +726,13 @@ const struct test_step test_multiple_read_5 = {
 	.expected_att_ecode = 0x05
 };
 
+const struct test_step test_multiple_read_6 = {
+	.handle = 0x0003,
+	.end_handle = 0x0007,
+	.func = test_multiple_read,
+	.expected_att_ecode = 0x0c
+};
+
 static void read_by_type_cb(bool success, uint8_t att_ecode,
 						struct bt_gatt_result *result,
 						void *user_data)
@@ -989,5 +996,11 @@ int main(int argc, char *argv[])
 			raw_pdu(0x0e, 0x03, 0x00, 0x07, 0x00),
 			raw_pdu(0x01, 0x0e, 0x03, 0x00, 0x05));
 
+	define_test_client("/TP/GAR/CL/BI-21-C", test_client, service_data_1,
+			&test_multiple_read_6,
+			SERVICE_DATA_1_PDU,
+			raw_pdu(0x0e, 0x03, 0x00, 0x07, 0x00),
+			raw_pdu(0x01, 0x0e, 0x03, 0x00, 0x0c));
+
 	return g_test_run();
 }
-- 
1.9.3

