Return-Path: <cyrus@holtmann.org>
From: Lukasz Rymanowski <lukasz.rymanowski@tieto.com>
To: linux-bluetooth@vger.kernel.org
Cc: Lukasz Rymanowski <lukasz.rymanowski@tieto.com>
Subject: [PATCH 2/5] shared/gatt: Extract send_att function
Date: Mon, 15 Dec 2014 10:59:04 +0100
Message-Id: <1418637547-20848-3-git-send-email-lukasz.rymanowski@tieto.com>
In-Reply-To: <1418637547-20848-1-git-send-email-lukasz.rymanowski@tieto.com>
References: <1418637547-20848-1-git-send-email-lukasz.rymanowski@tieto.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

This function sends already prepared buffer. We need this helper
function in following patch
---
 src/shared/att.c | 42 ++++++++++++++++++++++++------------------
 1 file changed, 24 insertions(+), 18 deletions(-)

diff --git a/src/shared/att.c b/src/shared/att.c
index 26b6c5b..2a131e0 100644
--- a/src/shared/att.c
+++ b/src/shared/att.c
@@ -1050,27 +1050,10 @@ bool bt_att_unregister_disconnect(struct bt_att *att, unsigned int id)
 	return true;
 }
 
-unsigned int bt_att_send(struct bt_att *att, uint8_t opcode,
-				const void *pdu, uint16_t length,
-				bt_att_response_func_t callback, void *user_data,
-				bt_att_destroy_func_t destroy)
+static unsigned int send_att(struct bt_att *att, struct att_send_op *op)
 {
-	struct att_send_op *op;
 	bool result;
 
-	if (!att || !att->io)
-		return 0;
-
-	op = create_att_send_op(opcode, pdu, length, att->mtu, callback,
-							user_data, destroy);
-	if (!op)
-		return 0;
-
-	if (att->next_send_id < 1)
-		att->next_send_id = 1;
-
-	op->id = att->next_send_id++;
-
 	/* Add the op to the correct queue based on its type */
 	switch (op->type) {
 	case ATT_OP_TYPE_REQ:
@@ -1100,6 +1083,29 @@ unsigned int bt_att_send(struct bt_att *att, uint8_t opcode,
 	return op->id;
 }
 
+unsigned int bt_att_send(struct bt_att *att, uint8_t opcode,
+				const void *pdu, uint16_t length,
+				bt_att_response_func_t callback,
+				void *user_data, bt_att_destroy_func_t destroy)
+{
+	struct att_send_op *op;
+
+	if (!att || !att->io)
+		return 0;
+
+	op = create_att_send_op(opcode, pdu, length, att->mtu, callback,
+							user_data, destroy);
+	if (!op)
+		return 0;
+
+	if (att->next_send_id < 1)
+		att->next_send_id = 1;
+
+	op->id = att->next_send_id++;
+
+	return send_att(att, op);
+}
+
 static bool match_op_id(const void *a, const void *b)
 {
 	const struct att_send_op *op = a;
-- 
1.8.4

