Return-Path: <cyrus@holtmann.org>
From: Gowtham Anandha Babu <gowtham.ab@samsung.com>
To: linux-bluetooth@vger.kernel.org
Cc: bharat.panda@samsung.com, cpgs@samsung.com,
	Gowtham Anandha Babu <gowtham.ab@samsung.com>
Subject: [PATCH] shared/att: Add packed struct definition for err_rsp
Date: Mon, 13 Apr 2015 19:44:50 +0530
Message-id: <1428934490-20840-1-git-send-email-gowtham.ab@samsung.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Reused the structure definition (bt_att_pdu_error_rsp) defined in
att-types.h by removing uint8_t array for sending err rsp pdu.
---
 src/shared/att.c | 11 +++++------
 1 file changed, 5 insertions(+), 6 deletions(-)

diff --git a/src/shared/att.c b/src/shared/att.c
index 422cc2c..e0c6d76 100644
--- a/src/shared/att.c
+++ b/src/shared/att.c
@@ -689,14 +689,13 @@ static bool opcode_match(uint8_t opcode, uint8_t test_opcode)
 
 static void respond_not_supported(struct bt_att *att, uint8_t opcode)
 {
-	uint8_t pdu[4];
+	struct bt_att_pdu_error_rsp pdu;
 
-	pdu[0] = opcode;
-	pdu[1] = 0;
-	pdu[2] = 0;
-	pdu[3] = BT_ATT_ERROR_REQUEST_NOT_SUPPORTED;
+	pdu.opcode = opcode;
+	pdu.handle = 0x0000;
+	pdu.ecode = BT_ATT_ERROR_REQUEST_NOT_SUPPORTED;
 
-	bt_att_send(att, BT_ATT_OP_ERROR_RSP, pdu, sizeof(pdu), NULL, NULL,
+	bt_att_send(att, BT_ATT_OP_ERROR_RSP, &pdu, sizeof(pdu), NULL, NULL,
 									NULL);
 }
 
-- 
1.9.1

