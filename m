Return-Path: <cyrus@holtmann.org>
From: Jakub Tyszkowski <jakub.tyszkowski@tieto.com>
To: linux-bluetooth@vger.kernel.org
Cc: Jakub Tyszkowski <jakub.tyszkowski@tieto.com>
Subject: [PATCHv2 1/5] shared/att: Handle commands under BT_ATT_ALL_REQUESTS op group type
Date: Tue,  9 Dec 2014 09:51:46 +0100
Message-Id: <1418115110-25335-1-git-send-email-jakub.tyszkowski@tieto.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

This is needed for backward compatibility with gattrib.
---
 src/shared/att.c | 6 ++++--
 1 file changed, 4 insertions(+), 2 deletions(-)

diff --git a/src/shared/att.c b/src/shared/att.c
index ee425d8..3181b36 100644
--- a/src/shared/att.c
+++ b/src/shared/att.c
@@ -666,8 +666,10 @@ struct notify_data {
 
 static bool opcode_match(uint8_t opcode, uint8_t test_opcode)
 {
-	if (opcode == BT_ATT_ALL_REQUESTS &&
-				    get_op_type(test_opcode) == ATT_OP_TYPE_REQ)
+	enum att_op_type op_type = get_op_type(test_opcode);
+
+	if (opcode == BT_ATT_ALL_REQUESTS && (op_type == ATT_OP_TYPE_REQ ||
+						op_type == ATT_OP_TYPE_CMD))
 		return true;
 
 	return opcode == test_opcode;
-- 
1.9.1

