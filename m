Return-Path: <cyrus@holtmann.org>
From: Marcin Kraglak <marcin.kraglak@tieto.com>
To: linux-bluetooth@vger.kernel.org
Subject: [RFC 03/11] unit/test-gatt: Fix not calling test step function
Date: Thu, 13 Nov 2014 12:27:05 +0100
Message-Id: <1415878033-6766-4-git-send-email-marcin.kraglak@tieto.com>
In-Reply-To: <1415878033-6766-1-git-send-email-marcin.kraglak@tieto.com>
References: <1415878033-6766-1-git-send-email-marcin.kraglak@tieto.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

---
 unit/test-gatt.c | 29 +++++++++++++++++++----------
 1 file changed, 19 insertions(+), 10 deletions(-)

diff --git a/unit/test-gatt.c b/unit/test-gatt.c
index 39cdda3..8898762 100644
--- a/unit/test-gatt.c
+++ b/unit/test-gatt.c
@@ -323,6 +323,18 @@ static void compare_chars(const bt_gatt_characteristic_t *a,
 		compare_descs(&a->descs[i], &b->descs[i]);
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
 static void client_ready_cb(bool success, uint8_t att_ecode, void *user_data)
 {
 	struct context *context = user_data;
@@ -357,6 +369,13 @@ static void client_ready_cb(bool success, uint8_t att_ecode, void *user_data)
 
 	g_assert(!bt_gatt_service_iter_next(&iter, &service));
 
+	if (context->data->step) {
+		const struct test_step *step = context->data->step;
+
+		step->func(context);
+		return;
+	}
+
 	context_quit(context);
 }
 
@@ -453,16 +472,6 @@ static void execute_context(struct context *context)
 	destroy_context(context);
 }
 
-typedef void (*test_step_t)(struct context *context);
-
-struct test_step {
-	test_step_t func;
-	uint16_t handle;
-	uint8_t expected_att_ecode;
-	const uint8_t *value;
-	uint16_t length;
-};
-
 static void test_read_cb(bool success, uint8_t att_ecode,
 					const uint8_t *value, uint16_t length,
 					void *user_data)
-- 
1.9.3

