Return-Path: <linux-bluetooth-owner@vger.kernel.org>
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH BlueZ] shared/att: Fix responding to unknown command opcode
Date: Wed, 26 Apr 2017 17:19:17 +0300
Message-Id: <20170426141917.9727-1-luiz.dentz@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

From: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>

In case of receiving an unknown command no response shall be generated.
---
 src/shared/att.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/src/shared/att.c b/src/shared/att.c
index 3071b51..10e182f 100644
--- a/src/shared/att.c
+++ b/src/shared/att.c
@@ -148,7 +148,7 @@ static enum att_op_type get_op_type(uint8_t opcode)
 			return att_opcode_type_table[i].type;
 	}
 
-	return ATT_OP_TYPE_UNKNOWN;
+	return opcode & ATT_OP_CMD_MASK ? ATT_OP_TYPE_CMD : ATT_OP_TYPE_UNKNOWN;
 }
 
 static const struct {
-- 
2.9.3

