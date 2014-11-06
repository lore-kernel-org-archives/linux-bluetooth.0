Return-Path: <cyrus@holtmann.org>
From: Marcin Kraglak <marcin.kraglak@tieto.com>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH 4/9] unit/test-gatt: Add macros defining tests with type
Date: Thu,  6 Nov 2014 13:47:09 +0100
Message-Id: <1415278034-19223-4-git-send-email-marcin.kraglak@tieto.com>
In-Reply-To: <1415278034-19223-1-git-send-email-marcin.kraglak@tieto.com>
References: <1415278034-19223-1-git-send-email-marcin.kraglak@tieto.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Simplify macros for defining test cases.
---
 unit/test-gatt.c | 21 ++++++++++++++-------
 1 file changed, 14 insertions(+), 7 deletions(-)

diff --git a/unit/test-gatt.c b/unit/test-gatt.c
index a2ca5b6..712b117 100644
--- a/unit/test-gatt.c
+++ b/unit/test-gatt.c
@@ -94,6 +94,12 @@ struct context {
 		g_test_add_data_func(name, &data, function);		\
 	} while (0)
 
+#define define_test_att(name, function, bt_uuid, args...)	\
+	define_test(name, function, ATT, bt_uuid, args)
+
+#define define_test_client(name, function, args...)		\
+	define_test(name, function, CLIENT, NULL, args)
+
 static bt_uuid_t uuid_16 = {
 	.type = BT_UUID16,
 	.value.u16 = 0x1800
@@ -355,7 +361,8 @@ int main(int argc, char *argv[])
 	 * The test group objective is to verify Generic Attribute Profile
 	 * Server Configuration.
 	 */
-	define_test("/TP/GAC/CL/BV-01-C", test_client, CLIENT, NULL,
+
+	define_test_client("/TP/GAC/CL/BV-01-C", test_client,
 				raw_pdu(0x02, 0x00, 0x02));
 
 	/*
@@ -364,7 +371,7 @@ int main(int argc, char *argv[])
 	 * The test group objective is to verify Generic Attribute Profile
 	 * Discovery of Services and Service Characteristics.
 	 */
-	define_test("/TP/GAD/CL/BV-01-C", test_search_primary, ATT, NULL,
+	define_test_att("/TP/GAD/CL/BV-01-C", test_search_primary, NULL,
 			raw_pdu(0x02, 0x00, 0x02),
 			raw_pdu(0x03, 0x00, 0x02),
 			raw_pdu(0x10, 0x01, 0x00, 0xff, 0xff, 0x00, 0x28),
@@ -379,7 +386,7 @@ int main(int argc, char *argv[])
 			raw_pdu(0x10, 0x97, 0x00, 0xff, 0xff, 0x00, 0x28),
 			raw_pdu(0x01, 0x10, 0x97, 0x00, 0x0a));
 
-	define_test("/TP/GAD/CL/BV-02-C-1", test_search_primary, ATT, &uuid_16,
+	define_test_att("/TP/GAD/CL/BV-02-C-1", test_search_primary, &uuid_16,
 			raw_pdu(0x02, 0x00, 0x02),
 			raw_pdu(0x03, 0x00, 0x02),
 			raw_pdu(0x06, 0x01, 0x00, 0xff, 0xff, 0x00, 0x28, 0x00,
@@ -389,7 +396,7 @@ int main(int argc, char *argv[])
 					0x18),
 			raw_pdu(0x01, 0x06, 0x08, 0x00, 0x0a));
 
-	define_test("/TP/GAD/CL/BV-02-C-2", test_search_primary, ATT, &uuid_128,
+	define_test_att("/TP/GAD/CL/BV-02-C-2", test_search_primary, &uuid_128,
 			raw_pdu(0x02, 0x00, 0x02),
 			raw_pdu(0x03, 0x00, 0x02),
 			raw_pdu(06, 0x01, 0x00, 0xff, 0xff, 0x00, 0x28, 0xfb,
@@ -403,7 +410,7 @@ int main(int argc, char *argv[])
 					0x18, 0x00, 0x00),
 			raw_pdu(0x01, 0x06, 0x08, 0x00, 0x0a));
 
-	define_test("/TP/GAD/CL/BV-03-C", test_search_included, ATT, NULL,
+	define_test_att("/TP/GAD/CL/BV-03-C", test_search_included, NULL,
 			raw_pdu(0x02, 0x00, 0x02),
 			raw_pdu(0x03, 0x00, 0x02),
 			raw_pdu(0x08, 0x01, 0x00, 0xff, 0xff, 0x02, 0x28),
@@ -426,7 +433,7 @@ int main(int argc, char *argv[])
 			raw_pdu(0x08, 0x06, 0x00, 0xff, 0xff, 0x02, 0x28),
 			raw_pdu(0x01, 0x08, 0x06, 0x00, 0x0a));
 
-	define_test("/TP/GAD/CL/BV-04-C", test_search_chars, ATT, NULL,
+	define_test_att("/TP/GAD/CL/BV-04-C", test_search_chars, NULL,
 			raw_pdu(0x02, 0x00, 0x02),
 			raw_pdu(0x03, 0x00, 0x02),
 			raw_pdu(0x08, 0x10, 0x00, 0x20, 0x00, 0x03, 0x28),
@@ -440,7 +447,7 @@ int main(int argc, char *argv[])
 			raw_pdu(0x08, 0x14, 0x00, 0x20, 0x00, 0x03, 0x28),
 			raw_pdu(0x01, 0x08, 0x12, 0x00, 0x0a));
 
-	define_test("/TP/GAD/CL/BV-06-C", test_search_descs, ATT, NULL,
+	define_test_att("/TP/GAD/CL/BV-06-C", test_search_descs, NULL,
 			raw_pdu(0x02, 0x00, 0x02),
 			raw_pdu(0x03, 0x00, 0x02),
 			raw_pdu(0x04, 0x13, 0x00, 0x16, 0x00),
-- 
1.9.3

