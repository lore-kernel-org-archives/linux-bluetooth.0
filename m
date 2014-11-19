Return-Path: <cyrus@holtmann.org>
From: Marcin Kraglak <marcin.kraglak@tieto.com>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH 6/8] unit/test-gatt: Add /TP/GAR/CL/BI-20-C test
Date: Wed, 19 Nov 2014 14:01:33 +0100
Message-Id: <1416402095-5137-7-git-send-email-marcin.kraglak@tieto.com>
In-Reply-To: <1416402095-5137-1-git-send-email-marcin.kraglak@tieto.com>
References: <1416402095-5137-1-git-send-email-marcin.kraglak@tieto.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Verify Generic Attribute Profile client behavior when the
Read Multiple Characteristic Values procedure fails due to
insufficient authorization.
---
 unit/test-gatt.c | 13 +++++++++++++
 1 file changed, 13 insertions(+)

diff --git a/unit/test-gatt.c b/unit/test-gatt.c
index bf9ef6e..1982629 100644
--- a/unit/test-gatt.c
+++ b/unit/test-gatt.c
@@ -712,6 +712,13 @@ const struct test_step test_multiple_read_3 = {
 	.expected_att_ecode = 0x01
 };
 
+const struct test_step test_multiple_read_4 = {
+	.handle = 0x0003,
+	.end_handle = 0x0007,
+	.func = test_multiple_read,
+	.expected_att_ecode = 0x08
+};
+
 static void read_by_type_cb(bool success, uint8_t att_ecode,
 						struct bt_gatt_result *result,
 						void *user_data)
@@ -963,5 +970,11 @@ int main(int argc, char *argv[])
 			raw_pdu(0x0e, 0x03, 0x00, 0x07, 0x00),
 			raw_pdu(0x01, 0x0e, 0x03, 0x00, 0x01));
 
+	define_test_client("/TP/GAR/CL/BI-20-C", test_client, service_data_1,
+			&test_multiple_read_4,
+			SERVICE_DATA_1_PDU,
+			raw_pdu(0x0e, 0x03, 0x00, 0x07, 0x00),
+			raw_pdu(0x01, 0x0e, 0x03, 0x00, 0x08));
+
 	return g_test_run();
 }
-- 
1.9.3

