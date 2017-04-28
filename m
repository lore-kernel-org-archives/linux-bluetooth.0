Return-Path: <linux-bluetooth-owner@vger.kernel.org>
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH BlueZ] shared/att: Respond to any opcode that is not command
Date: Fri, 28 Apr 2017 21:24:37 +0300
Message-Id: <20170428182437.23502-1-luiz.dentz@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

From: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>

Although get_op_type does now check for the command mask it must
respond to anything other than ATT_OP_TYPE_CMD since there is no mask
for response opcode.
---
 src/shared/att.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/src/shared/att.c b/src/shared/att.c
index 494b10d..2dc9d8b 100644
--- a/src/shared/att.c
+++ b/src/shared/att.c
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

