Return-Path: <cyrus@holtmann.org>
From: Marcin Kraglak <marcin.kraglak@tieto.com>
To: linux-bluetooth@vger.kernel.org
Subject: [RFC 07/11] unit/test-gatt: Add /TP/GAR/CL/BI-06-C test
Date: Thu, 13 Nov 2014 12:27:09 +0100
Message-Id: <1415878033-6766-8-git-send-email-marcin.kraglak@tieto.com>
In-Reply-To: <1415878033-6766-1-git-send-email-marcin.kraglak@tieto.com>
References: <1415878033-6766-1-git-send-email-marcin.kraglak@tieto.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Verify Generic Attribute Profile client behavior when the Read
Using Characteristic UUID procedure fails due to read not permitted.
---
 unit/test-gatt.c | 15 +++++++++++++++
 1 file changed, 15 insertions(+)

diff --git a/unit/test-gatt.c b/unit/test-gatt.c
index a0f40cc..d86a77b 100644
--- a/unit/test-gatt.c
+++ b/unit/test-gatt.c
@@ -762,6 +762,15 @@ const struct test_step test_read_by_uuid_2 = {
 			0x07, 0x08, 0x09, 0x0a, 0x0b, 0x0c, 0x0d, 0x0e}
 };
 
+const struct test_step test_read_by_uuid_3 = {
+	.handle = 0x0001,
+	.end_handle = 0xffff,
+	.func = test_read_by_uuid,
+	.expected_att_ecode = 0x02,
+	.uuid = {0x00, 0x00, 0x2b, 0x0d, 0x00, 0x00, 0x10, 0x00,
+			0x80, 0x00, 0x00, 0x80, 0x5F, 0x9B, 0x34, 0xFB}
+};
+
 static void test_client(gconstpointer data)
 {
 	struct context *context = create_context(512, data);
@@ -966,5 +975,11 @@ int main(int argc, char *argv[])
 					0x01, 0x00, 0x00),
 			raw_pdu(0x01, 0x08, 0x0b, 0x00, 0x0a));
 
+	define_test_client("/TP/GAR/CL/BI-06-C", test_client, service_data_2,
+			&test_read_by_uuid_3,
+			SERVICE_DATA_2_PDU,
+			raw_pdu(0x08, 0x01, 0x00, 0xff, 0xff, 0x0d, 0x2b),
+			raw_pdu(0x01, 0x08, 0x0b, 0x00, 0x02));
+
 	return g_test_run();
 }
-- 
1.9.3

