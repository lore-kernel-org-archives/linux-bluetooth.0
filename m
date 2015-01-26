Return-Path: <cyrus@holtmann.org>
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH BlueZ 1/3] unit/gatt: Add TP/GAR/CL/BV-04-C test
Date: Mon, 26 Jan 2015 17:45:16 +0200
Message-Id: <1422287118-25319-1-git-send-email-luiz.dentz@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

From: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>

Verify that a Generic Attribute Profile client can read a Characteristic
Value by selected handle. The Characteristic Value length is unknown to
the client and might be long.
---
 unit/test-gatt.c | 23 +++++++++++++++++++++++
 1 file changed, 23 insertions(+)

diff --git a/unit/test-gatt.c b/unit/test-gatt.c
index 98783fd..c49c71f 100644
--- a/unit/test-gatt.c
+++ b/unit/test-gatt.c
@@ -1432,6 +1432,23 @@ static void test_read_by_type(gconstpointer data)
 	execute_context(context);
 }
 
+static void test_long_read(struct context *context)
+{
+	const struct test_step *step = context->data->step;
+
+	g_assert(bt_gatt_client_read_long_value(context->client, step->handle,
+						0, multiple_read_cb, context,
+						NULL));
+}
+
+static const struct test_step test_long_read_1 = {
+	.handle = 0x0003,
+	.func = test_long_read,
+	.expected_att_ecode = 0,
+	.value = read_data_1,
+	.length = 0x03
+};
+
 int main(int argc, char *argv[])
 {
 	struct gatt_db *service_db_1, *ts_small_db, *ts_large_db_1;
@@ -1968,6 +1985,12 @@ int main(int argc, char *argv[])
 			raw_pdu(0x0C, 0xF0, 0x0F, 0x00, 0x00),
 			raw_pdu(0x01, 0x0C, 0xF0, 0x0F, 0x01));
 
+	define_test_client("/TP/GAR/CL/BV-04-C", test_client, service_db_1,
+			&test_long_read_1,
+			SERVICE_DATA_1_PDUS,
+			raw_pdu(0x0c, 0x03, 0x00, 0x00, 0x00),
+			raw_pdu(0x0b, 0x01, 0x02, 0x03));
+
 	define_test_client("/TP/GAR/CL/BV-05-C", test_client, service_db_1,
 			&test_multiple_read_1,
 			SERVICE_DATA_1_PDUS,
-- 
2.1.0

