Return-Path: <cyrus@holtmann.org>
From: Michael Janssen <jamuraa@chromium.org>
To: linux-bluetooth@vger.kernel.org
Cc: Michael Janssen <jamuraa@chromium.org>
Subject: [PATCH BlueZ 4/8] unit/gatt: Add TP/GAN/SR/BV-01-C test
Date: Tue, 10 Feb 2015 12:16:20 -0800
Message-Id: <1423599385-36295-5-git-send-email-jamuraa@chromium.org>
In-Reply-To: <1423599385-36295-1-git-send-email-jamuraa@chromium.org>
References: <1423599385-36295-1-git-send-email-jamuraa@chromium.org>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Verify that a Generic Attribute Profile server can send a Characteristic
Value Notification.
---
 unit/test-gatt.c | 59 ++++++++++++++++++++++++++++++++++++++++++++------------
 1 file changed, 47 insertions(+), 12 deletions(-)

diff --git a/unit/test-gatt.c b/unit/test-gatt.c
index c3931ac..44be64c 100644
--- a/unit/test-gatt.c
+++ b/unit/test-gatt.c
@@ -316,10 +316,23 @@ static void context_process(struct context *context)
 	context->process = g_idle_add(send_pdu, context);
 }
 
+typedef void (*test_step_t)(struct context *context);
+
+struct test_step {
+	test_step_t func;
+	uint16_t handle;
+	uint16_t end_handle;
+	uint8_t uuid[16];
+	uint8_t expected_att_ecode;
+	const uint8_t *value;
+	uint16_t length;
+};
+
 static gboolean test_handler(GIOChannel *channel, GIOCondition cond,
 							gpointer user_data)
 {
 	struct context *context = user_data;
+	const struct test_step *step = context->data->step;
 	const struct test_pdu *pdu;
 	unsigned char buf[512];
 	ssize_t len;
@@ -346,6 +359,17 @@ static gboolean test_handler(GIOChannel *channel, GIOCondition cond,
 
 	g_assert(memcmp(buf, pdu->data, pdu->size) == 0);
 
+	/* Empty client PDU means to trigger something out-of-band. */
+	pdu = &context->data->pdu_list[context->pdu_offset];
+
+	if (pdu->valid && (pdu->size == 0)) {
+		context->pdu_offset++;
+		printf("empty client pdu, triggering\r\n");
+		g_assert(step && step->func);
+		step->func(context);
+		return TRUE;
+	}
+
 	context_process(context);
 
 	return TRUE;
@@ -358,18 +382,6 @@ static void print_debug(const char *str, void *user_data)
 	g_print("%s%s\n", prefix, str);
 }
 
-typedef void (*test_step_t)(struct context *context);
-
-struct test_step {
-	test_step_t func;
-	uint16_t handle;
-	uint16_t end_handle;
-	uint8_t uuid[16];
-	uint8_t expected_att_ecode;
-	const uint8_t *value;
-	uint16_t length;
-};
-
 struct db_attribute_test_data {
 	struct gatt_db_attribute *match;
 	bool found;
@@ -1598,6 +1610,21 @@ static const struct test_step test_notification_1 = {
 	.length = 0x03,
 };
 
+static void test_server_notification(struct context *context)
+{
+	const struct test_step *step = context->data->step;
+
+	bt_gatt_server_send_notification(context->server, step->handle,
+						step->value, step->length);
+}
+
+static const struct test_step test_notification_server_1 = {
+	.handle = 0x0003,
+	.func = test_server_notification,
+	.value = read_data_1,
+	.length = 0x03,
+};
+
 int main(int argc, char *argv[])
 {
 	struct gatt_db *service_db_1, *ts_small_db, *ts_large_db_1;
@@ -2466,5 +2493,13 @@ int main(int argc, char *argv[])
 			raw_pdu(),
 			raw_pdu(0x1B, 0x03, 0x00, 0x01, 0x02, 0x03));
 
+	define_test_server("/TP/GAN/SR/BV-01-C", test_server, ts_small_db,
+			&test_notification_server_1,
+			raw_pdu(0x03, 0x00, 0x02),
+			raw_pdu(0x12, 0x04, 0x00, 0x01, 0x00),
+			raw_pdu(0x13),
+			raw_pdu(),
+			raw_pdu(0x1B, 0x03, 0x00, 0x01, 0x02, 0x03));
+
 	return g_test_run();
 }
-- 
2.2.0.rc0.207.ga3a616c

