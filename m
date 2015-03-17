Return-Path: <cyrus@holtmann.org>
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH BlueZ 1/2] shared/gatt-helper: Consolidate error checking
Date: Tue, 17 Mar 2015 17:19:33 +0200
Message-Id: <1426605574-13691-1-git-send-email-luiz.dentz@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

From: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>

This consolidate the error checking for attribute not found in
discover_op_complete.
---
 src/shared/gatt-helpers.c | 47 ++++++-----------------------------------------
 1 file changed, 6 insertions(+), 41 deletions(-)

diff --git a/src/shared/gatt-helpers.c b/src/shared/gatt-helpers.c
index 2d6088e..45c620c 100644
--- a/src/shared/gatt-helpers.c
+++ b/src/shared/gatt-helpers.c
@@ -625,6 +625,10 @@ static void async_req_unref(void *data)
 static void discovery_op_complete(struct bt_gatt_request *op, bool success,
 								uint8_t ecode)
 {
+	/* Reset success if there is some result to report */
+	if (ecode == BT_ATT_ERROR_ATTRIBUTE_NOT_FOUND && op->result_head)
+		success = true;
+
 	if (op->callback)
 		op->callback(success, ecode, success ? op->result_head : NULL,
 								op->user_data);
@@ -650,11 +654,6 @@ static void read_by_grp_type_cb(uint8_t opcode, const void *pdu,
 	if (opcode == BT_ATT_OP_ERROR_RSP) {
 		success = false;
 		att_ecode = process_error(pdu, length);
-
-		if (att_ecode == BT_ATT_ERROR_ATTRIBUTE_NOT_FOUND &&
-								op->result_head)
-			goto success;
-
 		goto done;
 	}
 
@@ -718,7 +717,6 @@ static void read_by_grp_type_cb(uint8_t opcode, const void *pdu,
 		put_le16(op->end_handle,
 				cur_result->pdu + length - data_length + 1);
 
-success:
 	success = true;
 
 done:
@@ -736,11 +734,6 @@ static void find_by_type_val_cb(uint8_t opcode, const void *pdu,
 	if (opcode == BT_ATT_OP_ERROR_RSP) {
 		success = false;
 		att_ecode = process_error(pdu, length);
-
-		if (att_ecode == BT_ATT_ERROR_ATTRIBUTE_NOT_FOUND &&
-								op->result_head)
-			goto success;
-
 		goto done;
 	}
 
@@ -785,8 +778,7 @@ static void find_by_type_val_cb(uint8_t opcode, const void *pdu,
 		goto done;
 	}
 
-success:
-	success = true;
+	success = false;
 
 done:
 	discovery_op_complete(op, success, att_ecode);
@@ -1047,11 +1039,6 @@ static void discover_included_cb(uint8_t opcode, const void *pdu,
 
 	if (opcode == BT_ATT_OP_ERROR_RSP) {
 		att_ecode = process_error(pdu, length);
-
-		if (att_ecode == BT_ATT_ERROR_ATTRIBUTE_NOT_FOUND &&
-							op->result_head)
-			goto done;
-
 		success = false;
 		goto failed;
 	}
@@ -1118,7 +1105,6 @@ static void discover_included_cb(uint8_t opcode, const void *pdu,
 		goto failed;
 	}
 
-done:
 	success = true;
 
 failed:
@@ -1174,11 +1160,6 @@ static void discover_chrcs_cb(uint8_t opcode, const void *pdu,
 	if (opcode == BT_ATT_OP_ERROR_RSP) {
 		success = false;
 		att_ecode = process_error(pdu, length);
-
-		if (att_ecode == BT_ATT_ERROR_ATTRIBUTE_NOT_FOUND &&
-							op->result_head)
-			goto success;
-
 		goto done;
 	}
 
@@ -1228,9 +1209,6 @@ static void discover_chrcs_cb(uint8_t opcode, const void *pdu,
 		goto done;
 	}
 
-success:
-	success = true;
-
 done:
 	discovery_op_complete(op, success, att_ecode);
 }
@@ -1283,13 +1261,7 @@ static void read_by_type_cb(uint8_t opcode, const void *pdu,
 
 	if (opcode == BT_ATT_OP_ERROR_RSP) {
 		att_ecode = process_error(pdu, length);
-
-		if (att_ecode == BT_ATT_ERROR_ATTRIBUTE_NOT_FOUND &&
-							op->result_head)
-			success = true;
-		else
-			success = false;
-
+		success = false;
 		goto done;
 	}
 
@@ -1389,11 +1361,6 @@ static void discover_descs_cb(uint8_t opcode, const void *pdu,
 	if (opcode == BT_ATT_OP_ERROR_RSP) {
 		success = false;
 		att_ecode = process_error(pdu, length);
-
-		if (att_ecode == BT_ATT_ERROR_ATTRIBUTE_NOT_FOUND &&
-								op->result_head)
-			goto success;
-
 		goto done;
 	}
 
@@ -1445,10 +1412,8 @@ static void discover_descs_cb(uint8_t opcode, const void *pdu,
 			return;
 
 		success = false;
-		goto done;
 	}
 
-success:
 	success = true;
 
 done:
-- 
2.1.0

