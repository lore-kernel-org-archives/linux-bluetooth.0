Return-Path: <cyrus@holtmann.org>
From: Anderson Lizardo <anderson.lizardo@openbossa.org>
To: linux-bluetooth@vger.kernel.org
Cc: Anderson Lizardo <anderson.lizardo@openbossa.org>
Subject: [PATCH BlueZ 03/11] attrib: Use att_put_u16() instead of htobs() + memcpy()
Date: Sat, 11 Jan 2014 00:47:19 -0400
Message-Id: <1389415647-25831-3-git-send-email-anderson.lizardo@openbossa.org>
In-Reply-To: <1389415647-25831-1-git-send-email-anderson.lizardo@openbossa.org>
References: <1389415647-25831-1-git-send-email-anderson.lizardo@openbossa.org>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

---
 attrib/att.c | 4 +---
 1 file changed, 1 insertion(+), 3 deletions(-)

diff --git a/attrib/att.c b/attrib/att.c
index 753c753..d9ca709 100644
--- a/attrib/att.c
+++ b/attrib/att.c
@@ -723,15 +723,13 @@ uint16_t enc_error_resp(uint8_t opcode, uint16_t handle, uint8_t status,
 {
 	const uint16_t min_len = sizeof(pdu[0]) + sizeof(opcode) +
 						sizeof(handle) + sizeof(status);
-	uint16_t u16;
 
 	if (len < min_len)
 		return 0;
 
-	u16 = htobs(handle);
 	pdu[0] = ATT_OP_ERROR;
 	pdu[1] = opcode;
-	memcpy(&pdu[2], &u16, sizeof(u16));
+	att_put_u16(handle, &pdu[2]);
 	pdu[4] = status;
 
 	return min_len;
-- 
1.8.3.2

