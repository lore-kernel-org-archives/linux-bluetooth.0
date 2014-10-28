Return-Path: <cyrus@holtmann.org>
From: Marcin Kraglak <marcin.kraglak@tieto.com>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH 5/7] unit/test-gatt: Add search primary by 128 bit UUID test case
Date: Tue, 28 Oct 2014 10:55:23 +0100
Message-Id: <1414490125-31339-5-git-send-email-marcin.kraglak@tieto.com>
In-Reply-To: <1414490125-31339-1-git-send-email-marcin.kraglak@tieto.com>
References: <1414490125-31339-1-git-send-email-marcin.kraglak@tieto.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

---
 unit/test-gatt.c | 28 ++++++++++++++++++++++++++++
 1 file changed, 28 insertions(+)

diff --git a/unit/test-gatt.c b/unit/test-gatt.c
index cc9f34e..fef0757 100644
--- a/unit/test-gatt.c
+++ b/unit/test-gatt.c
@@ -324,6 +324,19 @@ static void test_search_primary_by_uuid_16(gconstpointer data)
 	execute_context(context);
 }
 
+static void test_search_primary_by_uuid_128(gconstpointer data)
+{
+	struct context *context = create_helpers_context(512, data);
+	bt_uuid_t uuid;
+
+	bt_string_to_uuid(&uuid, HEART_RATE_UUID);
+
+	bt_gatt_discover_all_primary_services(context->att, &uuid, primary_cb,
+								context, NULL);
+
+	execute_context(context);
+}
+
 int main(int argc, char *argv[])
 {
 	g_test_init(&argc, &argv, NULL);
@@ -364,5 +377,20 @@ int main(int argc, char *argv[])
 					0x18),
 			raw_pdu(0x01, 0x06, 0x08, 0x00, 0x0a));
 
+	/* Discover Primary Services By 128 bit UUID*/
+	define_test("/TP/GAD/CL/BV-02-C-2", test_search_primary_by_uuid_128,
+			raw_pdu(0x02, 0x00, 0x02),
+			raw_pdu(0x03, 0x00, 0x02),
+			raw_pdu(06, 0x01, 0x00, 0xff, 0xff, 0x00, 0x28, 0xfb,
+					0x34, 0x9b, 0x5f, 0x80, 0x00, 0x00,
+					0x80, 0x00, 0x10, 0x00, 0x00, 0x0d,
+					0x18, 0x00, 0x00),
+			raw_pdu(0x07, 0x10, 0x00, 0x17, 0x00),
+			raw_pdu(06, 0x18, 0x00, 0xff, 0xff, 0x00, 0x28, 0xfb,
+					0x34, 0x9b, 0x5f, 0x80, 0x00, 0x00,
+					0x80, 0x00, 0x10, 0x00, 0x00, 0x0d,
+					0x18, 0x00, 0x00),
+			raw_pdu(0x01, 0x06, 0x08, 0x00, 0x0a));
+
 	return g_test_run();
 }
-- 
1.9.3

