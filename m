Return-Path: <cyrus@holtmann.org>
From: Andrei Emeltchenko <Andrei.Emeltchenko.news@gmail.com>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCHv2 2/2] gatt: Refactor discover_included_cb()
Date: Tue, 28 Oct 2014 17:20:02 +0200
Message-Id: <1414509602-2534-2-git-send-email-Andrei.Emeltchenko.news@gmail.com>
In-Reply-To: <1414509602-2534-1-git-send-email-Andrei.Emeltchenko.news@gmail.com>
References: <1414509602-2534-1-git-send-email-Andrei.Emeltchenko.news@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

From: Andrei Emeltchenko <andrei.emeltchenko@intel.com>

Initialize variable at declaration fixing setting it to the same value
many times.
---
 src/shared/gatt-helpers.c | 20 +++++---------------
 1 file changed, 5 insertions(+), 15 deletions(-)

diff --git a/src/shared/gatt-helpers.c b/src/shared/gatt-helpers.c
index 4f53de3..5713924 100644
--- a/src/shared/gatt-helpers.c
+++ b/src/shared/gatt-helpers.c
@@ -974,7 +974,7 @@ static void discover_included_cb(uint8_t opcode, const void *pdu,
 	uint8_t att_ecode = 0;
 	uint16_t last_handle;
 	size_t data_length;
-	bool success;
+	bool success = false;
 
 	if (opcode == BT_ATT_OP_ERROR_RSP) {
 		att_ecode = process_error(pdu, length);
@@ -983,14 +983,11 @@ static void discover_included_cb(uint8_t opcode, const void *pdu,
 							op->result_head)
 			goto done;
 
-		success = false;
 		goto failed;
 	}
 
-	if (opcode != BT_ATT_OP_READ_BY_TYPE_RSP || !pdu || length < 6) {
-		success = false;
+	if (opcode != BT_ATT_OP_READ_BY_TYPE_RSP || !pdu || length < 6)
 		goto failed;
-	}
 
 	data_length = ((const uint8_t *) pdu)[0];
 
@@ -1004,17 +1001,13 @@ static void discover_included_cb(uint8_t opcode, const void *pdu,
 	 * optional 2 octets - Bluetooth UUID of included service
 	 */
 	if ((data_length != 8 && data_length != 6) ||
-						(length - 1) % data_length) {
-		success = false;
+						(length - 1) % data_length)
 		goto failed;
-	}
 
 	cur_result = result_create(opcode, pdu + 1, length - 1,
 							data_length, op);
-	if (!cur_result) {
-		success = false;
+	if (!cur_result)
 		goto failed;
-	}
 
 	if (!op->result_head) {
 		op->result_head = op->result_tail = cur_result;
@@ -1027,10 +1020,8 @@ static void discover_included_cb(uint8_t opcode, const void *pdu,
 		struct read_incl_data *data;
 
 		data = new_read_included(cur_result);
-		if (!data) {
-			success = false;
+		if (!data)
 			goto failed;
-		}
 
 		read_included(data);
 		return;
@@ -1052,7 +1043,6 @@ static void discover_included_cb(uint8_t opcode, const void *pdu,
 			return;
 
 		discovery_op_unref(op);
-		success = false;
 		goto failed;
 	}
 
-- 
1.9.1

