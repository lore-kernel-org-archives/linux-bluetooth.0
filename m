Return-Path: <cyrus@holtmann.org>
From: Marcin Kraglak <marcin.kraglak@tieto.com>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH 3/8] unit/test-gatt: Add /TP/GAR/CL/BV-05-C test
Date: Wed, 19 Nov 2014 14:01:30 +0100
Message-Id: <1416402095-5137-4-git-send-email-marcin.kraglak@tieto.com>
In-Reply-To: <1416402095-5137-1-git-send-email-marcin.kraglak@tieto.com>
References: <1416402095-5137-1-git-send-email-marcin.kraglak@tieto.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Verify that a Generic Attribute Profile client can read multiple
Characteristic Values selected by set of handles.
---
 unit/test-gatt.c | 44 ++++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 44 insertions(+)

diff --git a/unit/test-gatt.c b/unit/test-gatt.c
index 9ded1f0..1c23ede 100644
--- a/unit/test-gatt.c
+++ b/unit/test-gatt.c
@@ -660,6 +660,44 @@ const struct test_step test_read_by_type_6 = {
 	.expected_att_ecode = 0x0c,
 };
 
+static void multiple_read_cb(bool success, uint8_t att_ecode,
+					const uint8_t *value, uint16_t length,
+					void *user_data)
+{
+	struct context *context = user_data;
+	const struct test_step *step = context->data->step;
+
+	g_assert(att_ecode == step->expected_att_ecode);
+
+	if (success) {
+		g_assert(length == step->length);
+		g_assert(memcmp(value, step->value, length) == 0);
+	}
+
+	context_quit(context);
+}
+
+static void test_multiple_read(struct context *context)
+{
+	const struct test_step *step = context->data->step;
+	uint16_t handles[2];
+
+	handles[0] = step->handle;
+	handles[1] = step->end_handle;
+
+	g_assert(bt_gatt_client_read_multiple(context->client, handles, 2,
+						multiple_read_cb, context,
+						NULL));
+}
+
+const struct test_step test_multiple_read_1 = {
+	.handle = 0x0003,
+	.end_handle = 0x0007,
+	.func = test_multiple_read,
+	.value = read_data_1,
+	.length = 0x03
+};
+
 static void read_by_type_cb(bool success, uint8_t att_ecode,
 						struct bt_gatt_result *result,
 						void *user_data)
@@ -893,5 +931,11 @@ int main(int argc, char *argv[])
 			raw_pdu(0x08, 0x01, 0x00, 0xff, 0xff, 0x0d, 0x2a),
 			raw_pdu(0x01, 0x08, 0x0b, 0x00, 0x0c));
 
+	define_test_client("/TP/GAR/CL/BV-05-C", test_client, service_data_1,
+			&test_multiple_read_1,
+			SERVICE_DATA_1_PDU,
+			raw_pdu(0x0e, 0x03, 0x00, 0x07, 0x00),
+			raw_pdu(0x0f, 0x01, 0x02, 0x03));
+
 	return g_test_run();
 }
-- 
1.9.3

