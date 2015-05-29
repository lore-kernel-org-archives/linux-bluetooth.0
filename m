Return-Path: <cyrus@holtmann.org>
From: Andrei Emeltchenko <Andrei.Emeltchenko.news@gmail.com>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCHv2] shared/att: Fix boolean check in handle_notify()
Date: Fri, 29 May 2015 11:53:26 +0300
Message-Id: <1432889606-3967-1-git-send-email-Andrei.Emeltchenko.news@gmail.com>
In-Reply-To: <CABBYNZK+AnuQM+EoLDaEwbr4hZnjxjfHy9gGM1bH1PEG-G7faQ@mail.gmail.com>
References: <CABBYNZK+AnuQM+EoLDaEwbr4hZnjxjfHy9gGM1bH1PEG-G7faQ@mail.gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

From: Andrei Emeltchenko <andrei.emeltchenko@intel.com>

ext_signed is boolean and shall be checked with logical op.
---
 src/shared/att.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/src/shared/att.c b/src/shared/att.c
index 053aa47..f9a5817 100644
--- a/src/shared/att.c
+++ b/src/shared/att.c
@@ -733,7 +733,7 @@ static void handle_notify(struct bt_att *att, uint8_t opcode, uint8_t *pdu,
 	const struct queue_entry *entry;
 	bool found;
 
-	if (opcode & ATT_OP_SIGNED_MASK & !att->ext_signed) {
+	if ((opcode & ATT_OP_SIGNED_MASK) && !att->ext_signed) {
 		if (!handle_signed(att, opcode, pdu, pdu_len))
 			return;
 		pdu_len -= BT_ATT_SIGNATURE_LEN;
-- 
2.1.4

