Return-Path: <linux-bluetooth-owner@vger.kernel.org>
From: Andrzej Kaczmarek <andrzej.kaczmarek@codecoup.pl>
To: linux-bluetooth@vger.kernel.org
Cc: Andrzej Kaczmarek <andrzej.kaczmarek@codecoup.pl>
Subject: [PATCH v2] shared/gatt-client: Make read_long_value more robust
Date: Mon,  1 Feb 2016 07:24:17 +0100
Message-Id: <1454307857-5337-1-git-send-email-andrzej.kaczmarek@codecoup.pl>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Using "Read Blob Request" on attributes shorter than ATT_MTU - 3 may
return "Attribute Not Long" error on some values, but at the same time
it's ok to read this attribute using "Read Request".

Since using "Read Blob Request" as first request when reading long
characteristic value starting with offset 0 is optional, this patch
changes read_long_value to start with "Read Request" whenever possible
to remove need for caller to take care of such error.

Core v4.2, part F, section 1.3.4.4.5:
If the attribute value has a fixed length that is less than or equal to
(ATT_MTU - 3) octets in length, then an Error Response can be sent with
the error code «Attribute Not Long».
---
 src/shared/gatt-client.c | 36 ++++++++++++++++++----
 unit/test-gatt.c         | 78 ++++++++++++++++++++++++------------------------
 2 files changed, 69 insertions(+), 45 deletions(-)

diff --git a/src/shared/gatt-client.c b/src/shared/gatt-client.c
index 06ac763..5c95a62 100644
--- a/src/shared/gatt-client.c
+++ b/src/shared/gatt-client.c
@@ -2156,7 +2156,9 @@ static void read_long_cb(uint8_t opcode, const void *pdu,
 		goto done;
 	}
 
-	if (opcode != BT_ATT_OP_READ_BLOB_RSP || (!pdu && length)) {
+	if ((!op->offset && opcode != BT_ATT_OP_READ_RSP)
+			|| (op->offset && opcode != BT_ATT_OP_READ_BLOB_RSP)
+			|| (!pdu && length)) {
 		success = false;
 		goto done;
 	}
@@ -2209,7 +2211,9 @@ unsigned int bt_gatt_client_read_long_value(struct bt_gatt_client *client,
 {
 	struct request *req;
 	struct read_long_op *op;
+	uint8_t att_op;
 	uint8_t pdu[4];
+	uint16_t pdu_len;
 
 	if (!client)
 		return 0;
@@ -2233,12 +2237,32 @@ unsigned int bt_gatt_client_read_long_value(struct bt_gatt_client *client,
 	req->destroy = destroy_read_long_op;
 
 	put_le16(value_handle, pdu);
-	put_le16(offset, pdu + 2);
+	pdu_len = sizeof(value_handle);
+
+	/*
+	 * Core v4.2, part F, section 1.3.4.4.5:
+	 * If the attribute value has a fixed length that is less than or equal
+	 * to (ATT_MTU - 3) octets in length, then an Error Response can be sent
+	 * with the error code «Attribute Not Long».
+	 *
+	 * To remove need for caller to handle "Attribute Not Long" error when
+	 * reading characteristics with short values, use Read Request for
+	 * reading first part of characteristics value instead of Read Blob
+	 * Request. Both are allowed in this case.
+	 */
+
+	if (op->offset) {
+		att_op = BT_ATT_OP_READ_BLOB_REQ;
+		pdu_len += sizeof(op->offset);
+
+		put_le16(op->offset, pdu + 2);
+	} else {
+		att_op = BT_ATT_OP_READ_REQ;
+	}
+
+	req->att_id = bt_att_send(client->att, att_op, pdu, pdu_len,
+					read_long_cb, req, request_unref);
 
-	req->att_id = bt_att_send(client->att, BT_ATT_OP_READ_BLOB_REQ,
-							pdu, sizeof(pdu),
-							read_long_cb, req,
-							request_unref);
 	if (!req->att_id) {
 		op->destroy = NULL;
 		request_unref(req);
diff --git a/unit/test-gatt.c b/unit/test-gatt.c
index 326a32c..944bfba 100644
--- a/unit/test-gatt.c
+++ b/unit/test-gatt.c
@@ -2892,14 +2892,14 @@ int main(int argc, char *argv[])
 	define_test_client("/TP/GAR/CL/BV-04-C", test_client, service_db_1,
 			&test_long_read_1,
 			SERVICE_DATA_1_PDUS,
-			raw_pdu(0x0c, 0x03, 0x00, 0x00, 0x00),
-			raw_pdu(0x0d, 0x01, 0x02, 0x03));
+			raw_pdu(0x0a, 0x03, 0x00),
+			raw_pdu(0x0b, 0x01, 0x02, 0x03));
 
 	define_test_client("/TP/GAR/CL/BV-04-C/512B", test_client, service_db_1,
 			&test_long_read_2,
 			SERVICE_DATA_1_PDUS,
-			raw_pdu(0x0c, 0x03, 0x00, 0x00, 0x00),
-			raw_pdu(0x0d, 0xff, 0xff, 0xff, 0xff,
+			raw_pdu(0x0a, 0x03, 0x00),
+			raw_pdu(0x0b, 0xff, 0xff, 0xff, 0xff,
 				0xff, 0xff, 0xff, 0xff, 0xff,
 				0xff, 0xff, 0xff, 0xff, 0xff,
 				0xff, 0xff, 0xff, 0xff, 0xff,
@@ -3014,46 +3014,46 @@ int main(int argc, char *argv[])
 	define_test_client("/TP/GAR/CL/BI-12-C", test_client, service_db_1,
 			&test_long_read_3,
 			SERVICE_DATA_1_PDUS,
-			raw_pdu(0x0c, 0x03, 0x00, 0x00, 0x00),
-			raw_pdu(0x01, 0x0c, 0x03, 0x00, 0x02));
+			raw_pdu(0x0a, 0x03, 0x00),
+			raw_pdu(0x01, 0x0a, 0x03, 0x00, 0x02));
 
 	define_test_client("/TP/GAR/CL/BI-13-C", test_client, service_db_1,
 			&test_long_read_4,
 			SERVICE_DATA_1_PDUS,
-			raw_pdu(0x0c, 0x03, 0x00, 0x00, 0x00),
-			raw_pdu(0x01, 0x0c, 0x03, 0x00, 0x07));
+			raw_pdu(0x0a, 0x03, 0x00),
+			raw_pdu(0x01, 0x0a, 0x03, 0x00, 0x07));
 
 	define_test_client("/TP/GAR/CL/BI-14-C", test_client, service_db_1,
 			&test_long_read_5,
 			SERVICE_DATA_1_PDUS,
-			raw_pdu(0x0c, 0x00, 0x00, 0x00, 0x00),
-			raw_pdu(0x01, 0x0c, 0x00, 0x00, 0x01));
+			raw_pdu(0x0a, 0x00, 0x00),
+			raw_pdu(0x01, 0x0a, 0x00, 0x00, 0x01));
 
 	define_test_client("/TP/GAR/CL/BI-15-C", test_client, service_db_1,
 			&test_long_read_6,
 			SERVICE_DATA_1_PDUS,
-			raw_pdu(0x0c, 0x03, 0x00, 0x00, 0x00),
-			raw_pdu(0x01, 0x0c, 0x03, 0x00, 0x08));
+			raw_pdu(0x0a, 0x03, 0x00),
+			raw_pdu(0x01, 0x0a, 0x03, 0x00, 0x08));
 
 	define_test_client("/TP/GAR/CL/BI-16-C", test_client, service_db_1,
 			&test_long_read_7,
 			SERVICE_DATA_1_PDUS,
-			raw_pdu(0x0c, 0x03, 0x00, 0x00, 0x00),
-			raw_pdu(0x01, 0x0c, 0x03, 0x00, 0x05));
+			raw_pdu(0x0a, 0x03, 0x00),
+			raw_pdu(0x01, 0x0a, 0x03, 0x00, 0x05));
 
 	define_test_client("/TP/GAR/CL/BI-16-C/auto", test_client, service_db_1,
 			&test_long_read_1,
 			SERVICE_DATA_1_PDUS,
-			raw_pdu(0x0c, 0x03, 0x00, 0x00, 0x00),
-			raw_pdu(0x01, 0x0c, 0x03, 0x00, 0x05),
-			raw_pdu(0x0c, 0x03, 0x00, 0x00, 0x00),
+			raw_pdu(0x0a, 0x03, 0x00),
+			raw_pdu(0x01, 0x0a, 0x03, 0x00, 0x05),
+			raw_pdu(0x0a, 0x03, 0x00),
 			raw_pdu(0x0d, 0x01, 0x02, 0x03));
 
 	define_test_client("/TP/GAR/CL/BI-17-C", test_client, service_db_1,
 			&test_long_read_8,
 			SERVICE_DATA_1_PDUS,
-			raw_pdu(0x0c, 0x03, 0x00, 0x00, 0x00),
-			raw_pdu(0x01, 0x0c, 0x03, 0x00, 0x0c));
+			raw_pdu(0x0a, 0x03, 0x00),
+			raw_pdu(0x01, 0x0a, 0x03, 0x00, 0x0c));
 
 	define_test_client("/TP/GAR/CL/BI-18-C", test_client, service_db_1,
 			&test_multiple_read_2,
@@ -3299,14 +3299,14 @@ int main(int argc, char *argv[])
 	define_test_client("/TP/GAR/CL/BV-07-C", test_client, service_db_1,
 			&test_long_read_9,
 			SERVICE_DATA_1_PDUS,
-			raw_pdu(0x0c, 0x04, 0x00, 0x00, 0x00),
-			raw_pdu(0x0d, 0x01, 0x02, 0x03));
+			raw_pdu(0x0a, 0x04, 0x00),
+			raw_pdu(0x0b, 0x01, 0x02, 0x03));
 
 	define_test_client("/TP/GAR/CL/BV-07-C/512B", test_client, service_db_1,
 			&test_long_read_10,
 			SERVICE_DATA_1_PDUS,
-			raw_pdu(0x0c, 0x04, 0x00, 0x00, 0x00),
-			raw_pdu(0x0d, 0xff, 0xff, 0xff, 0xff,
+			raw_pdu(0x0a, 0x04, 0x00),
+			raw_pdu(0x0b, 0xff, 0xff, 0xff, 0xff,
 				0xff, 0xff, 0xff, 0xff, 0xff,
 				0xff, 0xff, 0xff, 0xff, 0xff,
 				0xff, 0xff, 0xff, 0xff, 0xff,
@@ -3415,46 +3415,46 @@ int main(int argc, char *argv[])
 	define_test_client("/TP/GAR/CL/BI-28-C", test_client, service_db_1,
 			&test_long_read_11,
 			SERVICE_DATA_1_PDUS,
-			raw_pdu(0x0c, 0x04, 0x00, 0x00, 0x00),
-			raw_pdu(0x01, 0x0c, 0x04, 0x00, 0x02));
+			raw_pdu(0x0a, 0x04, 0x00),
+			raw_pdu(0x01, 0x0a, 0x04, 0x00, 0x02));
 
 	define_test_client("/TP/GAR/CL/BI-29-C", test_client, service_db_1,
 			&test_long_read_12,
 			SERVICE_DATA_1_PDUS,
-			raw_pdu(0x0c, 0x04, 0x00, 0x00, 0x00),
-			raw_pdu(0x01, 0x0c, 0x04, 0x00, 0x07));
+			raw_pdu(0x0a, 0x04, 0x00),
+			raw_pdu(0x01, 0x0a, 0x04, 0x00, 0x07));
 
 	define_test_client("/TP/GAR/CL/BI-30-C", test_client, service_db_1,
 			&test_long_read_5,
 			SERVICE_DATA_1_PDUS,
-			raw_pdu(0x0c, 0x00, 0x00, 0x00, 0x00),
-			raw_pdu(0x01, 0x0c, 0x00, 0x00, 0x01));
+			raw_pdu(0x0a, 0x00, 0x00),
+			raw_pdu(0x01, 0x0a, 0x00, 0x00, 0x01));
 
 	define_test_client("/TP/GAR/CL/BI-31-C", test_client, service_db_1,
 			&test_long_read_13,
 			SERVICE_DATA_1_PDUS,
-			raw_pdu(0x0c, 0x04, 0x00, 0x00, 0x00),
-			raw_pdu(0x01, 0x0c, 0x04, 0x00, 0x08));
+			raw_pdu(0x0a, 0x04, 0x00),
+			raw_pdu(0x01, 0x0a, 0x04, 0x00, 0x08));
 
 	define_test_client("/TP/GAR/CL/BI-32-C", test_client, service_db_1,
 			&test_long_read_14,
 			SERVICE_DATA_1_PDUS,
-			raw_pdu(0x0c, 0x04, 0x00, 0x00, 0x00),
-			raw_pdu(0x01, 0x0c, 0x04, 0x00, 0x05));
+			raw_pdu(0x0a, 0x04, 0x00),
+			raw_pdu(0x01, 0x0a, 0x04, 0x00, 0x05));
 
 	define_test_client("/TP/GAR/CL/BI-32-C/auto", test_client, service_db_1,
 			&test_long_read_9,
 			SERVICE_DATA_1_PDUS,
-			raw_pdu(0x0c, 0x04, 0x00, 0x00, 0x00),
-			raw_pdu(0x01, 0x0c, 0x04, 0x00, 0x05),
-			raw_pdu(0x0c, 0x04, 0x00, 0x00, 0x00),
-			raw_pdu(0x0d, 0x01, 0x02, 0x03));
+			raw_pdu(0x0a, 0x04, 0x00),
+			raw_pdu(0x01, 0x0a, 0x04, 0x00, 0x05),
+			raw_pdu(0x0a, 0x04, 0x00),
+			raw_pdu(0x0b, 0x01, 0x02, 0x03));
 
 	define_test_client("/TP/GAR/CL/BI-33-C", test_client, service_db_1,
 			&test_long_read_15,
 			SERVICE_DATA_1_PDUS,
-			raw_pdu(0x0c, 0x04, 0x00, 0x00, 0x00),
-			raw_pdu(0x01, 0x0c, 0x04, 0x00, 0x0c));
+			raw_pdu(0x0a, 0x04, 0x00),
+			raw_pdu(0x01, 0x0a, 0x04, 0x00, 0x0c));
 
 	define_test_client("/TP/GAR/CL/BI-34-C", test_client, service_db_1,
 			&test_read_12,
-- 
2.6.2

