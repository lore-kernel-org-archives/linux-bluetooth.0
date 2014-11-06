Return-Path: <cyrus@holtmann.org>
From: Marcin Kraglak <marcin.kraglak@tieto.com>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH 2/9] unit/test-gatt: Add TP/GAD/CL/BV-06-C test
Date: Thu,  6 Nov 2014 13:47:07 +0100
Message-Id: <1415278034-19223-2-git-send-email-marcin.kraglak@tieto.com>
In-Reply-To: <1415278034-19223-1-git-send-email-marcin.kraglak@tieto.com>
References: <1415278034-19223-1-git-send-email-marcin.kraglak@tieto.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Verify that a Generic Attribute Profile client can find all
Descriptors of a specified Characteristic.
---
 unit/test-gatt.c | 21 +++++++++++++++++++++
 1 file changed, 21 insertions(+)

diff --git a/unit/test-gatt.c b/unit/test-gatt.c
index f343fe6..a2ca5b6 100644
--- a/unit/test-gatt.c
+++ b/unit/test-gatt.c
@@ -334,6 +334,17 @@ static void test_search_chars(gconstpointer data)
 	execute_context(context);
 }
 
+static void test_search_descs(gconstpointer data)
+{
+	struct context *context = create_context(512, data);
+
+	g_assert(bt_gatt_discover_descriptors(context->att, 0x0013, 0x0016,
+							generic_search_cb,
+							context, NULL));
+
+	execute_context(context);
+}
+
 int main(int argc, char *argv[])
 {
 	g_test_init(&argc, &argv, NULL);
@@ -429,5 +440,15 @@ int main(int argc, char *argv[])
 			raw_pdu(0x08, 0x14, 0x00, 0x20, 0x00, 0x03, 0x28),
 			raw_pdu(0x01, 0x08, 0x12, 0x00, 0x0a));
 
+	define_test("/TP/GAD/CL/BV-06-C", test_search_descs, ATT, NULL,
+			raw_pdu(0x02, 0x00, 0x02),
+			raw_pdu(0x03, 0x00, 0x02),
+			raw_pdu(0x04, 0x13, 0x00, 0x16, 0x00),
+			raw_pdu(0x05, 0x01, 0x13, 0x00, 0x02, 0x29, 0x14, 0x00,
+					0x03, 0x29),
+			raw_pdu(0x04, 0x15, 0x00, 0x16, 0x00),
+			raw_pdu(0x05, 0x01, 0x15, 0x00, 0x04, 0x29, 0x16, 0x00,
+					0x05, 0x29));
+
 	return g_test_run();
 }
-- 
1.9.3

