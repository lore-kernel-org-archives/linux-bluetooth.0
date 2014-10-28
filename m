Return-Path: <cyrus@holtmann.org>
From: Marcin Kraglak <marcin.kraglak@tieto.com>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH 7/7] unit/test-gatt: Add search characteristics test case
Date: Tue, 28 Oct 2014 10:55:25 +0100
Message-Id: <1414490125-31339-7-git-send-email-marcin.kraglak@tieto.com>
In-Reply-To: <1414490125-31339-1-git-send-email-marcin.kraglak@tieto.com>
References: <1414490125-31339-1-git-send-email-marcin.kraglak@tieto.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

---
 unit/test-gatt.c | 37 +++++++++++++++++++++++++++++++++++++
 1 file changed, 37 insertions(+)

diff --git a/unit/test-gatt.c b/unit/test-gatt.c
index c744f2d..70ae54b 100644
--- a/unit/test-gatt.c
+++ b/unit/test-gatt.c
@@ -236,6 +236,17 @@ static void primary_cb(bool success, uint8_t att_ecode,
 	context_quit(context);
 }
 
+static void characteristic_cb(bool success, uint8_t att_ecode,
+						struct bt_gatt_result *result,
+						void *user_data)
+{
+	struct context *context = user_data;
+
+	g_assert(success);
+
+	context_quit(context);
+}
+
 static void included_cb(bool success, uint8_t att_ecode,
 						struct bt_gatt_result *result,
 						void *user_data)
@@ -358,6 +369,17 @@ static void test_search_included(gconstpointer data)
 	execute_context(context);
 }
 
+static void test_search_characteristics(gconstpointer data)
+{
+	struct context *context = create_helpers_context(512, data);
+
+	g_assert(bt_gatt_discover_characteristics(context->att, 0x0010, 0x0020,
+						characteristic_cb, context,
+						NULL));
+
+	execute_context(context);
+}
+
 int main(int argc, char *argv[])
 {
 	g_test_init(&argc, &argv, NULL);
@@ -437,5 +459,20 @@ int main(int argc, char *argv[])
 			raw_pdu(0x08, 0x06, 0x00, 0xff, 0xff, 0x02, 0x28),
 			raw_pdu(0x01, 0x08, 0x06, 0x00, 0x0a));
 
+	/* Discover all Characteristics in given range */
+	define_test("/TP/GAD/CL/BV-04-C", test_search_characteristics,
+			raw_pdu(0x02, 0x00, 0x02),
+			raw_pdu(0x03, 0x00, 0x02),
+			raw_pdu(0x08, 0x10, 0x00, 0x20, 0x00, 0x03, 0x28),
+			raw_pdu(0x09, 0x07, 0x11, 0x00, 02, 0x12, 0x00, 0x25,
+					0x2a),
+			raw_pdu(0x08, 0x12, 0x00, 0x20, 0x00, 0x03, 0x28),
+			raw_pdu(0x09, 0x15, 0x13, 0x00, 0x02, 0x14, 0x00, 0x85,
+					0x00, 0xef, 0xcd, 0xab, 0x89, 0x67,
+					0x45, 0x23, 0x01, 0x00, 0x00, 0x00,
+					0x00, 0x00, 0x00),
+			raw_pdu(0x08, 0x14, 0x00, 0x20, 0x00, 0x03, 0x28),
+			raw_pdu(0x01, 0x08, 0x12, 0x00, 0x0a));
+
 	return g_test_run();
 }
-- 
1.9.3

