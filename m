Return-Path: <cyrus@holtmann.org>
From: Gowtham Anandha Babu <gowtham.ab@samsung.com>
To: linux-bluetooth@vger.kernel.org
Cc: bharat.panda@samsung.com, cpgs@samsung.com,
	Gowtham Anandha Babu <gowtham.ab@samsung.com>
Subject: [PATCH  1/7] unit/gatt: Add TP/GAW/CL/BV-06-C test
Date: Thu, 16 Apr 2015 18:23:19 +0530
Message-id: <1429188799-30958-1-git-send-email-gowtham.ab@samsung.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Verify that a Generic Attribute Profile client can reliably write
a characteristic selected by handle.
---
 unit/test-gatt.c | 39 +++++++++++++++++++++++++++++++++++++++
 1 file changed, 39 insertions(+)

diff --git a/unit/test-gatt.c b/unit/test-gatt.c
index 6c12f85..d60eab0 100644
--- a/unit/test-gatt.c
+++ b/unit/test-gatt.c
@@ -1138,6 +1138,37 @@ static const struct test_step test_long_write_12 = {
 	.length = 0x03
 };
 
+static void test_reliable_write_cb(bool success, bool reliable_error,
+					uint8_t att_ecode, void *user_data)
+{
+	struct context *context = user_data;
+	const struct test_step *step = context->data->step;
+
+	g_assert(att_ecode == step->expected_att_ecode);
+
+	g_assert(!reliable_error);
+
+	context_quit(context);
+}
+
+static void test_reliable_write(struct context *context)
+{
+	const struct test_step *step = context->data->step;
+
+	g_assert(bt_gatt_client_write_long_value(context->client, true,
+				step->handle, 0, step->value,
+				step->length, test_reliable_write_cb,
+				context, NULL));
+}
+
+static const struct test_step test_reliable_write_1 = {
+	.handle = 0x0007,
+	.func = test_reliable_write,
+	.expected_att_ecode = 0,
+	.value = write_data_1,
+	.length = 0x03
+};
+
 static void att_write_cb(struct gatt_db_attribute *att, int err,
 								void *user_data)
 {
@@ -3780,6 +3811,14 @@ int main(int argc, char *argv[])
 				0xff, 0xff, 0xff, 0xff, 0xff, 0xff, 0xff),
 			raw_pdu(0x01, 0x16, 0x73, 0x00, 0x03));
 
+	define_test_client("/TP/GAW/CL/BV-06-C", test_client, service_db_1,
+			&test_reliable_write_1,
+			SERVICE_DATA_1_PDUS,
+			raw_pdu(0x16, 0x07, 0x00, 0x00, 0x00, 0x01, 0x02, 0x03),
+			raw_pdu(0x17, 0x07, 0x00, 0x00, 0x00, 0x01, 0x02, 0x03),
+			raw_pdu(0x18, 0x01),
+			raw_pdu(0x19));
+
 	define_test_server("/TP/GAW/SR/BV-06-C/small", test_server,
 			ts_small_db, NULL,
 			raw_pdu(0x03, 0x00, 0x02),
-- 
1.9.1

