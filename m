Return-Path: <cyrus@holtmann.org>
From: Michael Janssen <jamuraa@chromium.org>
To: linux-bluetooth@vger.kernel.org
Cc: Michael Janssen <jamuraa@chromium.org>
Subject: [PATCH BlueZ 7/8] unit/gatt: Add TP/GAI/CL/BV-01-C test
Date: Tue, 10 Feb 2015 12:16:23 -0800
Message-Id: <1423599385-36295-8-git-send-email-jamuraa@chromium.org>
In-Reply-To: <1423599385-36295-1-git-send-email-jamuraa@chromium.org>
References: <1423599385-36295-1-git-send-email-jamuraa@chromium.org>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Verify that a Generic Attribute Profile client can respond with a
Confirmation to a Characteristic Value Indication.
---
 unit/test-gatt.c | 40 ++++++++++++++++++++++++++++++++++++++++
 1 file changed, 40 insertions(+)

diff --git a/unit/test-gatt.c b/unit/test-gatt.c
index c45ff3d..94e7e35 100644
--- a/unit/test-gatt.c
+++ b/unit/test-gatt.c
@@ -1647,6 +1647,36 @@ static void test_server_indication_confirm(struct context *context)
 	g_assert(indication_received == 1);
 }
 
+static void indication_cb(uint16_t value_handle, const uint8_t *value,
+			    uint16_t length, void *user_data)
+{
+	struct context *context = user_data;
+	const struct test_step *step = context->data->step;
+
+	if (value_handle == step->handle) {
+		g_assert_cmpint(length, ==, step->length);
+
+		g_assert(memcmp(value, step->value, length) == 0);
+	}
+}
+
+static void test_indication(struct context *context)
+{
+	const struct test_step *step = context->data->step;
+
+	g_assert(bt_gatt_client_register_notify(context->client, step->handle,
+						notification_register_cb,
+						indication_cb, context,
+						NULL));
+}
+
+static const struct test_step test_indication_1 = {
+	.handle = 0x0003,
+	.func = test_indication,
+	.value = read_data_1,
+	.length = 0x03,
+};
+
 static void test_server_indication(struct context *context)
 {
 	const struct test_step *step = context->data->step;
@@ -2550,5 +2580,15 @@ int main(int argc, char *argv[])
 			raw_pdu(0x1D, 0x03, 0x00, 0x01, 0x02, 0x03),
 			raw_pdu(0x1E));
 
+	define_test_client("/TP/GAI/CL/BV-01-C", test_client, ts_small_db,
+			&test_indication_1,
+			MTU_EXCHANGE_CLIENT_PDUS,
+			SMALL_DB_DISCOVERY_PDUS,
+			raw_pdu(0x12, 0x04, 0x00, 0x03, 0x00),
+			raw_pdu(0x13),
+			raw_pdu(),
+			raw_pdu(0x1D, 0x03, 0x00, 0x01, 0x02, 0x03),
+			raw_pdu(0x1E));
+
 	return g_test_run();
 }
-- 
2.2.0.rc0.207.ga3a616c

