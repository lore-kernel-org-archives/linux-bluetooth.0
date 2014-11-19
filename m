Return-Path: <cyrus@holtmann.org>
From: Marcin Kraglak <marcin.kraglak@tieto.com>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH 4/8] unit/test-gatt: Add /TP/GAR/CL/BI-18-C test
Date: Wed, 19 Nov 2014 14:01:31 +0100
Message-Id: <1416402095-5137-5-git-send-email-marcin.kraglak@tieto.com>
In-Reply-To: <1416402095-5137-1-git-send-email-marcin.kraglak@tieto.com>
References: <1416402095-5137-1-git-send-email-marcin.kraglak@tieto.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Verify Generic Attribute Profile client behavior when
the Read Multiple Characteristic Values procedure fails due
to read not permitted.
---
 unit/test-gatt.c | 13 +++++++++++++
 1 file changed, 13 insertions(+)

diff --git a/unit/test-gatt.c b/unit/test-gatt.c
index 1c23ede..c138b63 100644
--- a/unit/test-gatt.c
+++ b/unit/test-gatt.c
@@ -698,6 +698,13 @@ const struct test_step test_multiple_read_1 = {
 	.length = 0x03
 };
 
+const struct test_step test_multiple_read_2 = {
+	.handle = 0x0003,
+	.end_handle = 0x0007,
+	.func = test_multiple_read,
+	.expected_att_ecode = 0x02
+};
+
 static void read_by_type_cb(bool success, uint8_t att_ecode,
 						struct bt_gatt_result *result,
 						void *user_data)
@@ -937,5 +944,11 @@ int main(int argc, char *argv[])
 			raw_pdu(0x0e, 0x03, 0x00, 0x07, 0x00),
 			raw_pdu(0x0f, 0x01, 0x02, 0x03));
 
+	define_test_client("/TP/GAR/CL/BI-18-C", test_client, service_data_1,
+			&test_multiple_read_2,
+			SERVICE_DATA_1_PDU,
+			raw_pdu(0x0e, 0x03, 0x00, 0x07, 0x00),
+			raw_pdu(0x01, 0x0e, 0x03, 0x00, 0x02));
+
 	return g_test_run();
 }
-- 
1.9.3

