Return-Path: <cyrus@holtmann.org>
From: Marcin Kraglak <marcin.kraglak@tieto.com>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH 3/7] unit/test-gatt: Add search primary by 16 but UUID test case
Date: Tue, 28 Oct 2014 10:55:21 +0100
Message-Id: <1414490125-31339-3-git-send-email-marcin.kraglak@tieto.com>
In-Reply-To: <1414490125-31339-1-git-send-email-marcin.kraglak@tieto.com>
References: <1414490125-31339-1-git-send-email-marcin.kraglak@tieto.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

---
 unit/test-gatt.c | 24 ++++++++++++++++++++++++
 1 file changed, 24 insertions(+)

diff --git a/unit/test-gatt.c b/unit/test-gatt.c
index 57cb109..cc9f34e 100644
--- a/unit/test-gatt.c
+++ b/unit/test-gatt.c
@@ -311,6 +311,19 @@ static void test_search_primary(gconstpointer data)
 	execute_context(context);
 }
 
+static void test_search_primary_by_uuid_16(gconstpointer data)
+{
+	struct context *context = create_helpers_context(512, data);
+	bt_uuid_t uuid;
+
+	bt_uuid16_create(&uuid, 0x1800);
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
@@ -340,5 +353,16 @@ int main(int argc, char *argv[])
 			raw_pdu(0x10, 0x97, 0x00, 0xff, 0xff, 0x00, 0x28),
 			raw_pdu(0x01, 0x10, 0x97, 0x00, 0x0a));
 
+	/* Discover Primary Services By 16 bit UUID*/
+	define_test("/TP/GAD/CL/BV-02-C-1", test_search_primary_by_uuid_16,
+			raw_pdu(0x02, 0x00, 0x02),
+			raw_pdu(0x03, 0x00, 0x02),
+			raw_pdu(0x06, 0x01, 0x00, 0xff, 0xff, 0x00, 0x28, 0x00,
+					0x18),
+			raw_pdu(0x07, 0x01, 0x00, 0x07, 0x00),
+			raw_pdu(0x06, 0x08, 0x00, 0xff, 0xff, 0x00, 0x28, 0x00,
+					0x18),
+			raw_pdu(0x01, 0x06, 0x08, 0x00, 0x0a));
+
 	return g_test_run();
 }
-- 
1.9.3

