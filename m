Return-Path: <cyrus@holtmann.org>
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH BlueZ 1/2] unit/test-gatt: Add /TP/GAW/CL/BV-02-C/seclevel test
Date: Thu, 26 Feb 2015 16:03:19 +0200
Message-Id: <1424959400-18701-1-git-send-email-luiz.dentz@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

From: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>

This add a test for signed write but with security level other than low
so we can verify the code use the write instead of signed write.
---
 unit/test-gatt.c | 30 ++++++++++++++++++++++++++++++
 1 file changed, 30 insertions(+)

diff --git a/unit/test-gatt.c b/unit/test-gatt.c
index eb4ae32..f1dde2e 100644
--- a/unit/test-gatt.c
+++ b/unit/test-gatt.c
@@ -872,6 +872,31 @@ static const struct test_step test_signed_write_1 = {
 	.length = 0x03
 };
 
+static void test_signed_write_seclevel(struct context *context)
+{
+	const struct test_step *step = context->data->step;
+	uint8_t key[16] = {0xD8, 0x51, 0x59, 0x48, 0x45, 0x1F, 0xEA, 0x32, 0x0D,
+				0xC0, 0x5A, 0x2E, 0x88, 0x30, 0x81, 0x88 };
+
+	g_assert(bt_att_set_local_key(context->att, key, local_counter,
+								context));
+
+	g_assert(bt_att_set_sec_level(context->att, BT_SECURITY_MEDIUM));
+
+	g_assert(bt_gatt_client_write_without_response(context->client,
+							step->handle,
+							true, step->value,
+							step->length));
+}
+
+static const struct test_step test_signed_write_seclevel_1 = {
+	.handle = 0x0007,
+	.func = test_signed_write_seclevel,
+	.expected_att_ecode = 0,
+	.value = write_data_1,
+	.length = 0x03
+};
+
 static void att_write_cb(struct gatt_db_attribute *att, int err,
 								void *user_data)
 {
@@ -2971,6 +2996,11 @@ int main(int argc, char *argv[])
 				0x00, 0x00, 0x31, 0x1f, 0x0a, 0xcd, 0x1c, 0x3a,
 				0x5b, 0x0a));
 
+	define_test_client("/TP/GAW/CL/BV-02-C/seclevel", test_client,
+			service_db_1, &test_signed_write_seclevel_1,
+			SERVICE_DATA_1_PDUS,
+			raw_pdu(0x52, 0x07, 0x00, 0x01, 0x02, 0x03));
+
 	define_test_client("/TP/GAW/CL/BV-03-C", test_client, service_db_1,
 			&test_write_1,
 			SERVICE_DATA_1_PDUS,
-- 
2.1.0

