Return-Path: <cyrus@holtmann.org>
From: Marcin Kraglak <marcin.kraglak@tieto.com>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH 5/8] unit/test-gatt: Add /TP/GAR/CL/BI-19-C test
Date: Wed, 19 Nov 2014 14:01:32 +0100
Message-Id: <1416402095-5137-6-git-send-email-marcin.kraglak@tieto.com>
In-Reply-To: <1416402095-5137-1-git-send-email-marcin.kraglak@tieto.com>
References: <1416402095-5137-1-git-send-email-marcin.kraglak@tieto.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Verify Generic Attribute Profile client behavior when the
Read Multiple Characteristic Values procedure fails due to
valid handle.
---
 unit/test-gatt.c | 13 +++++++++++++
 1 file changed, 13 insertions(+)

diff --git a/unit/test-gatt.c b/unit/test-gatt.c
index c138b63..bf9ef6e 100644
--- a/unit/test-gatt.c
+++ b/unit/test-gatt.c
@@ -705,6 +705,13 @@ const struct test_step test_multiple_read_2 = {
 	.expected_att_ecode = 0x02
 };
 
+const struct test_step test_multiple_read_3 = {
+	.handle = 0x0003,
+	.end_handle = 0x0007,
+	.func = test_multiple_read,
+	.expected_att_ecode = 0x01
+};
+
 static void read_by_type_cb(bool success, uint8_t att_ecode,
 						struct bt_gatt_result *result,
 						void *user_data)
@@ -950,5 +957,11 @@ int main(int argc, char *argv[])
 			raw_pdu(0x0e, 0x03, 0x00, 0x07, 0x00),
 			raw_pdu(0x01, 0x0e, 0x03, 0x00, 0x02));
 
+	define_test_client("/TP/GAR/CL/BI-19-C", test_client, service_data_1,
+			&test_multiple_read_3,
+			SERVICE_DATA_1_PDU,
+			raw_pdu(0x0e, 0x03, 0x00, 0x07, 0x00),
+			raw_pdu(0x01, 0x0e, 0x03, 0x00, 0x01));
+
 	return g_test_run();
 }
-- 
1.9.3

