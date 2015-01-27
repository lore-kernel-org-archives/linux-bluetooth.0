Return-Path: <cyrus@holtmann.org>
From: Gowtham Anandha Babu <gowtham.ab@samsung.com>
To: linux-bluetooth@vger.kernel.org
Cc: bharat.panda@samsung.com, cpgs@samsung.com,
	Gowtham Anandha Babu <gowtham.ab@samsung.com>
Subject: [PATCH v1 1/3] shared/gatt-helpers: Fix usage of freed memory
Date: Tue, 27 Jan 2015 14:23:18 +0530
Message-id: <1422348800-5668-2-git-send-email-gowtham.ab@samsung.com>
In-reply-to: <1422348800-5668-1-git-send-email-gowtham.ab@samsung.com>
References: <1422348800-5668-1-git-send-email-gowtham.ab@samsung.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

src/shared/gatt-helpers.c:709:6: warning: Use of memory after it is freed
        if (op->callback)
            ^~~~~~~~~~~~
src/shared/gatt-helpers.c:780:6: warning: Use of memory after it is freed
        if (op->callback)
            ^~~~~~~~~~~~
src/shared/gatt-helpers.c:998:6: warning: Use of memory after it is freed
        if (op->callback)
            ^~~~~~~~~~~~
src/shared/gatt-helpers.c:1020:32: warning: Use of memory after it is freed
                op->callback(false, 0, NULL, data->op->user_data);
                                             ^~~~~~~~
src/shared/gatt-helpers.c:1112:6: warning: Use of memory after it is freed
        if (op->callback)
            ^~~~~~~~~~~~
src/shared/gatt-helpers.c:1226:6: warning: Use of memory after it is freed
        if (op->callback)
            ^~~~~~~~~~~~
src/shared/gatt-helpers.c:1332:6: warning: Use of memory after it is freed
        if (op->callback)
            ^~~~~~~~~~~~
src/shared/gatt-helpers.c:1452:6: warning: Use of memory after it is freed
        if (op->callback)
            ^~~~~~~~~~~~
---
 src/shared/gatt-helpers.c | 25 ++++++++++++++++---------
 1 file changed, 16 insertions(+), 9 deletions(-)

diff --git a/src/shared/gatt-helpers.c b/src/shared/gatt-helpers.c
index 3864ed0..c9b24cc 100644
--- a/src/shared/gatt-helpers.c
+++ b/src/shared/gatt-helpers.c
@@ -686,7 +686,6 @@ static void read_by_grp_type_cb(uint8_t opcode, const void *pdu,
 							discovery_op_unref))
 			return;
 
-		discovery_op_unref(op);
 		success = false;
 		goto done;
 	}
@@ -708,6 +707,8 @@ success:
 done:
 	if (op->callback)
 		op->callback(success, att_ecode, final_result, op->user_data);
+
+	discovery_op_unref(op);
 }
 
 static void find_by_type_val_cb(uint8_t opcode, const void *pdu,
@@ -766,7 +767,6 @@ static void find_by_type_val_cb(uint8_t opcode, const void *pdu,
 							discovery_op_unref))
 			return;
 
-		discovery_op_unref(op);
 		success = false;
 		goto done;
 	}
@@ -779,6 +779,8 @@ success:
 done:
 	if (op->callback)
 		op->callback(success, att_ecode, final_result, op->user_data);
+
+	discovery_op_unref(op);
 }
 
 static bool discover_services(struct bt_att *att, bt_uuid_t *uuid,
@@ -977,7 +979,6 @@ static void read_included_cb(uint8_t opcode, const void *pdu,
 				discovery_op_ref(op), discovery_op_unref))
 			return;
 
-		discovery_op_unref(op);
 		success = false;
 		goto done;
 	}
@@ -997,6 +998,8 @@ static void read_included_cb(uint8_t opcode, const void *pdu,
 done:
 	if (op->callback)
 		op->callback(success, att_ecode, final_result, op->user_data);
+
+	discovery_op_unref(op);
 }
 
 static void read_included(struct read_incl_data *data)
@@ -1014,10 +1017,10 @@ static void read_included(struct read_incl_data *data)
 							read_included_unref))
 		return;
 
-	read_included_unref(data);
-
 	if (op->callback)
 		op->callback(false, 0, NULL, data->op->user_data);
+
+	read_included_unref(data);
 }
 
 static void discover_included_cb(uint8_t opcode, const void *pdu,
@@ -1099,7 +1102,6 @@ static void discover_included_cb(uint8_t opcode, const void *pdu,
 							discovery_op_unref))
 			return;
 
-		discovery_op_unref(op);
 		success = false;
 		goto failed;
 	}
@@ -1111,6 +1113,8 @@ done:
 failed:
 	if (op->callback)
 		op->callback(success, att_ecode, final_result, op->user_data);
+
+	discovery_op_unref(op);
 }
 
 bool bt_gatt_discover_included_services(struct bt_att *att,
@@ -1213,7 +1217,6 @@ static void discover_chrcs_cb(uint8_t opcode, const void *pdu,
 						discovery_op_unref))
 			return;
 
-		discovery_op_unref(op);
 		success = false;
 		goto done;
 	}
@@ -1226,6 +1229,8 @@ done:
 	if (op->callback)
 		op->callback(success, att_ecode, final_result,
 							op->user_data);
+
+	discovery_op_unref(op);
 }
 
 bool bt_gatt_discover_characteristics(struct bt_att *att,
@@ -1321,7 +1326,6 @@ static void read_by_type_cb(uint8_t opcode, const void *pdu,
 						discovery_op_unref))
 			return;
 
-		discovery_op_unref(op);
 		success = false;
 		goto done;
 	}
@@ -1332,6 +1336,8 @@ done:
 	if (op->callback)
 		op->callback(success, att_ecode, success ? op->result_head :
 							NULL, op->user_data);
+
+	discovery_op_unref(op);
 }
 
 bool bt_gatt_read_by_type(struct bt_att *att, uint16_t start, uint16_t end,
@@ -1439,7 +1445,6 @@ static void discover_descs_cb(uint8_t opcode, const void *pdu,
 						discovery_op_unref))
 			return;
 
-		discovery_op_unref(op);
 		success = false;
 		goto done;
 	}
@@ -1451,6 +1456,8 @@ success:
 done:
 	if (op->callback)
 		op->callback(success, att_ecode, final_result, op->user_data);
+
+	discovery_op_unref(op);
 }
 
 bool bt_gatt_discover_descriptors(struct bt_att *att,
-- 
1.9.1

