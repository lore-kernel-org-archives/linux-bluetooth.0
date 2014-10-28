Return-Path: <cyrus@holtmann.org>
From: Marcin Kraglak <marcin.kraglak@tieto.com>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH 6/7] unit/test-gatt: Add search included services test case
Date: Tue, 28 Oct 2014 10:55:24 +0100
Message-Id: <1414490125-31339-6-git-send-email-marcin.kraglak@tieto.com>
In-Reply-To: <1414490125-31339-1-git-send-email-marcin.kraglak@tieto.com>
References: <1414490125-31339-1-git-send-email-marcin.kraglak@tieto.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

---
 unit/test-gatt.c | 45 +++++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 45 insertions(+)

diff --git a/unit/test-gatt.c b/unit/test-gatt.c
index fef0757..c744f2d 100644
--- a/unit/test-gatt.c
+++ b/unit/test-gatt.c
@@ -236,6 +236,17 @@ static void primary_cb(bool success, uint8_t att_ecode,
 	context_quit(context);
 }
 
+static void included_cb(bool success, uint8_t att_ecode,
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
 static struct context *create_helpers_context(uint16_t mtu, gconstpointer data)
 {
 	struct context *context = g_new0(struct context, 1);
@@ -337,6 +348,16 @@ static void test_search_primary_by_uuid_128(gconstpointer data)
 	execute_context(context);
 }
 
+static void test_search_included(gconstpointer data)
+{
+	struct context *context = create_helpers_context(512, data);
+
+	bt_gatt_discover_included_services(context->att, 0x0001, 0xffff,
+						included_cb, context, NULL);
+
+	execute_context(context);
+}
+
 int main(int argc, char *argv[])
 {
 	g_test_init(&argc, &argv, NULL);
@@ -392,5 +413,29 @@ int main(int argc, char *argv[])
 					0x18, 0x00, 0x00),
 			raw_pdu(0x01, 0x06, 0x08, 0x00, 0x0a));
 
+	/* Discover All Include Services */
+	define_test("/TP/GAD/CL/BV-03-C", test_search_included,
+			raw_pdu(0x02, 0x00, 0x02),
+			raw_pdu(0x03, 0x00, 0x02),
+			raw_pdu(0x08, 0x01, 0x00, 0xff, 0xff, 0x02, 0x28),
+			raw_pdu(0x09, 0x08, 0x02, 0x00, 0x10, 0x00, 0x1f, 0x00,
+					0x0f, 0x18),
+			raw_pdu(0x08, 0x03, 0x00, 0xff, 0xff, 0x02, 0x28),
+			raw_pdu(0x09, 0x06, 0x03, 0x00, 0x20, 0x00, 0x2f, 0x00,
+					0x04, 0x00, 0x30, 0x00, 0x3f, 0x00),
+			raw_pdu(0x0a, 0x20, 0x00),
+			raw_pdu(0x0b, 0x00, 0x00, 0x3e, 0x39, 0x00, 0x00, 0x00,
+					0x00, 0x01, 0x23, 0x45, 0x67, 0x89,
+					0xab, 0xcd, 0xef),
+			raw_pdu(0x0a, 0x30, 0x00),
+			raw_pdu(0x0b, 0x00, 0x00, 0x3b, 0x39, 0x00, 0x00, 0x00,
+					0x00, 0x01, 0x23, 0x45, 0x67, 0x89,
+					0xab, 0xcd, 0xef),
+			raw_pdu(0x08, 0x05, 0x00, 0xff, 0xff, 0x02, 0x28),
+			raw_pdu(0x09, 0x08, 0x05, 0x00, 0x40, 0x00, 0x4f, 0x00,
+								0x0a, 0x18),
+			raw_pdu(0x08, 0x06, 0x00, 0xff, 0xff, 0x02, 0x28),
+			raw_pdu(0x01, 0x08, 0x06, 0x00, 0x0a));
+
 	return g_test_run();
 }
-- 
1.9.3

