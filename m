Return-Path: <cyrus@holtmann.org>
From: Michael Janssen <jamuraa@chromium.org>
To: linux-bluetooth@vger.kernel.org
Cc: Michael Janssen <jamuraa@chromium.org>
Subject: [PATCH BlueZ v2 2/8] unit/gatt: Define repeated MTU PDUs.
Date: Tue,  9 Dec 2014 15:08:34 -0800
Message-Id: <1418166520-32993-3-git-send-email-jamuraa@chromium.org>
In-Reply-To: <1418166520-32993-1-git-send-email-jamuraa@chromium.org>
References: <1418166520-32993-1-git-send-email-jamuraa@chromium.org>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

The MTU PDUs are repeated many times in the code, add a define for them.
Also use "PDUS" instead of "PDU" because these macros contain multiples.
---
 unit/test-gatt.c | 57 +++++++++++++++++++++++++-------------------------------
 1 file changed, 25 insertions(+), 32 deletions(-)

diff --git a/unit/test-gatt.c b/unit/test-gatt.c
index 2f3f26a..c23b4c4 100644
--- a/unit/test-gatt.c
+++ b/unit/test-gatt.c
@@ -114,9 +114,12 @@ struct context {
 #define define_test_server(name, function, source_db, test_step, args...)\
 	define_test(name, function, SERVER, NULL, source_db, test_step, args)
 
-#define SERVICE_DATA_1_PDU						\
+#define MTU_EXCHANGE_CLIENT_PDUS					\
 		raw_pdu(0x02, 0x00, 0x02),				\
-		raw_pdu(0x03, 0x00, 0x02),				\
+		raw_pdu(0x03, 0x00, 0x02)
+
+#define SERVICE_DATA_1_PDUS						\
+		MTU_EXCHANGE_CLIENT_PDUS,				\
 		raw_pdu(0x10, 0x01, 0x00, 0xff, 0xff, 0x00, 0x28),	\
 		raw_pdu(0x11, 0x06, 0x01, 0x00, 0x04, 0x00, 0x01, 0x18),\
 		raw_pdu(0x10, 0x05, 0x00, 0xff, 0xff, 0x00, 0x28),	\
@@ -1015,8 +1018,7 @@ int main(int argc, char *argv[])
 
 	define_test_att("/TP/GAD/CL/BV-02-C-1", test_search_primary, &uuid_16,
 			NULL,
-			raw_pdu(0x02, 0x00, 0x02),
-			raw_pdu(0x03, 0x00, 0x02),
+			MTU_EXCHANGE_CLIENT_PDUS,
 			raw_pdu(0x06, 0x01, 0x00, 0xff, 0xff, 0x00, 0x28, 0x00,
 					0x18),
 			raw_pdu(0x07, 0x01, 0x00, 0x07, 0x00),
@@ -1026,8 +1028,7 @@ int main(int argc, char *argv[])
 
 	define_test_att("/TP/GAD/CL/BV-02-C-2", test_search_primary, &uuid_128,
 			NULL,
-			raw_pdu(0x02, 0x00, 0x02),
-			raw_pdu(0x03, 0x00, 0x02),
+			MTU_EXCHANGE_CLIENT_PDUS,
 			raw_pdu(06, 0x01, 0x00, 0xff, 0xff, 0x00, 0x28, 0xfb,
 					0x34, 0x9b, 0x5f, 0x80, 0x00, 0x00,
 					0x80, 0x00, 0x10, 0x00, 0x00, 0x0d,
@@ -1041,8 +1042,7 @@ int main(int argc, char *argv[])
 
 	define_test_att("/TP/GAD/CL/BV-03-C", test_search_included, NULL,
 			NULL,
-			raw_pdu(0x02, 0x00, 0x02),
-			raw_pdu(0x03, 0x00, 0x02),
+			MTU_EXCHANGE_CLIENT_PDUS,
 			raw_pdu(0x08, 0x01, 0x00, 0xff, 0xff, 0x02, 0x28),
 			raw_pdu(0x09, 0x08, 0x02, 0x00, 0x10, 0x00, 0x1f, 0x00,
 					0x0f, 0x18),
@@ -1065,8 +1065,7 @@ int main(int argc, char *argv[])
 
 	define_test_att("/TP/GAD/CL/BV-04-C", test_search_chars, NULL,
 			NULL,
-			raw_pdu(0x02, 0x00, 0x02),
-			raw_pdu(0x03, 0x00, 0x02),
+			MTU_EXCHANGE_CLIENT_PDUS,
 			raw_pdu(0x08, 0x10, 0x00, 0x20, 0x00, 0x03, 0x28),
 			raw_pdu(0x09, 0x07, 0x11, 0x00, 02, 0x12, 0x00, 0x25,
 					0x2a),
@@ -1079,8 +1078,7 @@ int main(int argc, char *argv[])
 			raw_pdu(0x01, 0x08, 0x12, 0x00, 0x0a));
 
 	define_test_att("/TP/GAD/CL/BV-06-C", test_search_descs, NULL, NULL,
-			raw_pdu(0x02, 0x00, 0x02),
-			raw_pdu(0x03, 0x00, 0x02),
+			MTU_EXCHANGE_CLIENT_PDUS,
 			raw_pdu(0x04, 0x13, 0x00, 0x16, 0x00),
 			raw_pdu(0x05, 0x01, 0x13, 0x00, 0x02, 0x29, 0x14, 0x00,
 					0x03, 0x29),
@@ -1090,25 +1088,25 @@ int main(int argc, char *argv[])
 
 	define_test_client("/TP/GAR/CL/BV-01-C", test_client, service_db_1,
 			&test_read_1,
-			SERVICE_DATA_1_PDU,
+			SERVICE_DATA_1_PDUS,
 			raw_pdu(0x0a, 0x03, 0x00),
 			raw_pdu(0x0b, 0x01, 0x02, 0x03));
 
 	define_test_client("/TP/GAR/CL/BI-01-C", test_client, service_db_1,
 			&test_read_2,
-			SERVICE_DATA_1_PDU,
+			SERVICE_DATA_1_PDUS,
 			raw_pdu(0x0a, 0x00, 0x00),
 			raw_pdu(0x01, 0x0a, 0x00, 0x00, 0x01));
 
 	define_test_client("/TP/GAR/CL/BI-02-C", test_client, service_db_1,
 			&test_read_3,
-			SERVICE_DATA_1_PDU,
+			SERVICE_DATA_1_PDUS,
 			raw_pdu(0x0a, 0x03, 0x00),
 			raw_pdu(0x01, 0x0a, 0x03, 0x00, 0x02));
 
 	define_test_client("/TP/GAR/CL/BI-03-C", test_client, service_db_1,
 			&test_read_4,
-			SERVICE_DATA_1_PDU,
+			SERVICE_DATA_1_PDUS,
 			raw_pdu(0x0a, 0x03, 0x00),
 			raw_pdu(0x01, 0x0a, 0x03, 0x00, 0x08));
 
@@ -1138,72 +1136,67 @@ int main(int argc, char *argv[])
 
 	define_test_att("/TP/GAR/CL/BI-06-C", test_read_by_type, &uuid_char_16,
 			&test_read_by_type_2,
-			raw_pdu(0x02, 0x00, 0x02),
-			raw_pdu(0x03, 0x00, 0x02),
+			MTU_EXCHANGE_CLIENT_PDUS,
 			raw_pdu(0x08, 0x01, 0x00, 0xff, 0xff, 0x0d, 0x2a),
 			raw_pdu(0x01, 0x08, 0x0b, 0x00, 0x02));
 
 	define_test_att("/TP/GAR/CL/BI-07-C", test_read_by_type, &uuid_char_16,
 			&test_read_by_type_3,
-			raw_pdu(0x02, 0x00, 0x02),
-			raw_pdu(0x03, 0x00, 0x02),
+			MTU_EXCHANGE_CLIENT_PDUS,
 			raw_pdu(0x08, 0x01, 0x00, 0xff, 0xff, 0x0d, 0x2a),
 			raw_pdu(0x01, 0x08, 0x0b, 0x00, 0x0a));
 
 	define_test_att("/TP/GAR/CL/BI-09-C", test_read_by_type, &uuid_char_16,
 			&test_read_by_type_4,
-			raw_pdu(0x02, 0x00, 0x02),
-			raw_pdu(0x03, 0x00, 0x02),
+			MTU_EXCHANGE_CLIENT_PDUS,
 			raw_pdu(0x08, 0x01, 0x00, 0xff, 0xff, 0x0d, 0x2a),
 			raw_pdu(0x01, 0x08, 0x0b, 0x00, 0x08));
 
 	define_test_att("/TP/GAR/CL/BI-10-C", test_read_by_type, &uuid_char_16,
 			&test_read_by_type_5,
-			raw_pdu(0x02, 0x00, 0x02),
-			raw_pdu(0x03, 0x00, 0x02),
+			MTU_EXCHANGE_CLIENT_PDUS,
 			raw_pdu(0x08, 0x01, 0x00, 0xff, 0xff, 0x0d, 0x2a),
 			raw_pdu(0x01, 0x08, 0x0b, 0x00, 0x05));
 
 	define_test_att("/TP/GAR/CL/BI-11-C", test_read_by_type, &uuid_char_16,
 			&test_read_by_type_6,
-			raw_pdu(0x02, 0x00, 0x02),
-			raw_pdu(0x03, 0x00, 0x02),
+			MTU_EXCHANGE_CLIENT_PDUS,
 			raw_pdu(0x08, 0x01, 0x00, 0xff, 0xff, 0x0d, 0x2a),
 			raw_pdu(0x01, 0x08, 0x0b, 0x00, 0x0c));
 
 	define_test_client("/TP/GAR/CL/BV-05-C", test_client, service_db_1,
 			&test_multiple_read_1,
-			SERVICE_DATA_1_PDU,
+			SERVICE_DATA_1_PDUS,
 			raw_pdu(0x0e, 0x03, 0x00, 0x07, 0x00),
 			raw_pdu(0x0f, 0x01, 0x02, 0x03));
 
 	define_test_client("/TP/GAR/CL/BI-18-C", test_client, service_db_1,
 			&test_multiple_read_2,
-			SERVICE_DATA_1_PDU,
+			SERVICE_DATA_1_PDUS,
 			raw_pdu(0x0e, 0x03, 0x00, 0x07, 0x00),
 			raw_pdu(0x01, 0x0e, 0x03, 0x00, 0x02));
 
 	define_test_client("/TP/GAR/CL/BI-19-C", test_client, service_db_1,
 			&test_multiple_read_3,
-			SERVICE_DATA_1_PDU,
+			SERVICE_DATA_1_PDUS,
 			raw_pdu(0x0e, 0x03, 0x00, 0x07, 0x00),
 			raw_pdu(0x01, 0x0e, 0x03, 0x00, 0x01));
 
 	define_test_client("/TP/GAR/CL/BI-20-C", test_client, service_db_1,
 			&test_multiple_read_4,
-			SERVICE_DATA_1_PDU,
+			SERVICE_DATA_1_PDUS,
 			raw_pdu(0x0e, 0x03, 0x00, 0x07, 0x00),
 			raw_pdu(0x01, 0x0e, 0x03, 0x00, 0x08));
 
 	define_test_client("/TP/GAR/CL/BI-21-C", test_client, service_db_1,
 			&test_multiple_read_5,
-			SERVICE_DATA_1_PDU,
+			SERVICE_DATA_1_PDUS,
 			raw_pdu(0x0e, 0x03, 0x00, 0x07, 0x00),
 			raw_pdu(0x01, 0x0e, 0x03, 0x00, 0x05));
 
 	define_test_client("/TP/GAR/CL/BI-21-C", test_client, service_db_1,
 			&test_multiple_read_6,
-			SERVICE_DATA_1_PDU,
+			SERVICE_DATA_1_PDUS,
 			raw_pdu(0x0e, 0x03, 0x00, 0x07, 0x00),
 			raw_pdu(0x01, 0x0e, 0x03, 0x00, 0x0c));
 
-- 
2.2.0.rc0.207.ga3a616c

