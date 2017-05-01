Return-Path: <linux-bluetooth-owner@vger.kernel.org>
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH v2 1/3] shared/att: Respond to any opcode that is not command
Date: Mon,  1 May 2017 18:56:58 +0300
Message-Id: <20170501155700.23761-1-luiz.dentz@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

From: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>

Although get_op_type does now check for the command mask it must
respond to anything other than ATT_OP_TYPE_CMD since there is no mask
for response opcode.
---
 src/shared/att.c | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/src/shared/att.c b/src/shared/att.c
index 494b10d..ca2d051 100644
--- a/src/shared/att.c
+++ b/src/shared/att.c
@@ -149,7 +149,7 @@ static enum att_op_type get_op_type(uint8_t opcode)
 	}
 
 	if (opcode & ATT_OP_CMD_MASK)
-		return ATT_OP_CMD_MASK;
+		return ATT_OP_TYPE_CMD;
 
 	return ATT_OP_TYPE_UNKNOWN;
 }
@@ -841,10 +841,10 @@ static void handle_notify(struct bt_att *att, uint8_t opcode, uint8_t *pdu,
 	}
 
 	/*
-	 * If this was a request and no handler was registered for it, respond
-	 * with "Not Supported"
+	 * If this was not a command and no handler was registered for it,
+	 * respond with "Not Supported"
 	 */
-	if (!found && get_op_type(opcode) == ATT_OP_TYPE_REQ)
+	if (!found && get_op_type(opcode) != ATT_OP_TYPE_CMD)
 		respond_not_supported(att, opcode);
 
 	bt_att_unref(att);
-- 
2.9.3

