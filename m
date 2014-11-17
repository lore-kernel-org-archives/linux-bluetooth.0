Return-Path: <cyrus@holtmann.org>
From: Marcin Kraglak <marcin.kraglak@tieto.com>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH 7/9] unit/test-gatt: Add /TP/GAR/CL/BI-09-C test
Date: Mon, 17 Nov 2014 20:51:29 +0100
Message-Id: <1416253891-21381-7-git-send-email-marcin.kraglak@tieto.com>
In-Reply-To: <1416253891-21381-1-git-send-email-marcin.kraglak@tieto.com>
References: <1416253891-21381-1-git-send-email-marcin.kraglak@tieto.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Verify Generic Attribute Profile client behavior when the Read Using
Characteristic UUID procedure fails due to insufficient authorization.
---
 unit/test-gatt.c | 15 +++++++++++++++
 1 file changed, 15 insertions(+)

diff --git a/unit/test-gatt.c b/unit/test-gatt.c
index 8cfc4a0..d0e5a15 100644
--- a/unit/test-gatt.c
+++ b/unit/test-gatt.c
@@ -784,6 +784,15 @@ const struct test_step test_read_by_uuid_4 = {
 			0x80, 0x00, 0x00, 0x80, 0x5F, 0x9B, 0x34, 0xFB}
 };
 
+const struct test_step test_read_by_uuid_5 = {
+	.handle = 0x0001,
+	.end_handle = 0xffff,
+	.func = test_read_by_uuid,
+	.expected_att_ecode = 0x08,
+	.uuid = {0x00, 0x00, 0x2b, 0x0d, 0x00, 0x00, 0x10, 0x00,
+			0x80, 0x00, 0x00, 0x80, 0x5F, 0x9B, 0x34, 0xFB}
+};
+
 static void test_client(gconstpointer data)
 {
 	struct context *context = create_context(512, data);
@@ -1000,5 +1009,11 @@ int main(int argc, char *argv[])
 			raw_pdu(0x08, 0x01, 0x00, 0xff, 0xff, 0x0d, 0x2b),
 			raw_pdu(0x01, 0x08, 0x0b, 0x00, 0x0a));
 
+	define_test_client("/TP/GAR/CL/BI-09-C", test_client, service_data_2,
+			&test_read_by_uuid_5,
+			SERVICE_DATA_2_PDU,
+			raw_pdu(0x08, 0x01, 0x00, 0xff, 0xff, 0x0d, 0x2b),
+			raw_pdu(0x01, 0x08, 0x0b, 0x00, 0x08));
+
 	return g_test_run();
 }
-- 
1.9.3

