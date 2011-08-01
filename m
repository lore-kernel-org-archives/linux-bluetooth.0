Return-Path: <cyrus@holtmann.org>
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH hcidump 01/13 v2] Don't parse response AVRCP pdu if ctype is NOT_IMPLETED
Date: Mon,  1 Aug 2011 18:43:51 +0300
Message-Id: <1312213432-4364-1-git-send-email-luiz.dentz@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

From: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>

---
 parser/avrcp.c |    6 ++++++
 1 files changed, 6 insertions(+), 0 deletions(-)

diff --git a/parser/avrcp.c b/parser/avrcp.c
index ff6862d..1b3afad 100644
--- a/parser/avrcp.c
+++ b/parser/avrcp.c
@@ -473,6 +473,12 @@ void avrcp_dump(int level, struct frame *frm)
 		return;
 	}
 
+	/* Not implemented should not contain any operand */
+	if (ctype == AVC_CTYPE_NOT_IMPLEMENTED) {
+		raw_dump(level, frm);
+		return;
+	}
+
 	switch (opcode) {
 	case AVC_OP_PASSTHROUGH:
 		avrcp_passthrough_dump(level + 1, frm);
-- 
1.7.6

