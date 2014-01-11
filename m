Return-Path: <cyrus@holtmann.org>
From: Anderson Lizardo <anderson.lizardo@openbossa.org>
To: linux-bluetooth@vger.kernel.org
Cc: Anderson Lizardo <anderson.lizardo@openbossa.org>
Subject: [PATCH BlueZ 09/11] attrib: Reject incomplete PDU in dec_find_by_type_resp()
Date: Sat, 11 Jan 2014 00:47:25 -0400
Message-Id: <1389415647-25831-9-git-send-email-anderson.lizardo@openbossa.org>
In-Reply-To: <1389415647-25831-1-git-send-email-anderson.lizardo@openbossa.org>
References: <1389415647-25831-1-git-send-email-anderson.lizardo@openbossa.org>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Otherwise, an incomplete PDU may be silently accepted (with any
remaining data discarded).
---
 attrib/att.c | 9 +++++++++
 1 file changed, 9 insertions(+)

diff --git a/attrib/att.c b/attrib/att.c
index d367918..c279b2c 100644
--- a/attrib/att.c
+++ b/attrib/att.c
@@ -334,12 +334,21 @@ GSList *dec_find_by_type_resp(const uint8_t *pdu, size_t len)
 	GSList *matches;
 	off_t offset;
 
+	/* PDU should contain at least:
+	 * - Attribute Opcode (1 octet)
+	 * - Handles Information List (at least one entry):
+	 *   - Found Attribute Handle (2 octets)
+	 *   - Group End Handle (2 octets) */
 	if (pdu == NULL || len < 5)
 		return NULL;
 
 	if (pdu[0] != ATT_OP_FIND_BY_TYPE_RESP)
 		return NULL;
 
+	/* Reject incomplete Handles Information List */
+	if ((len - 1) % 4)
+		return NULL;
+
 	for (offset = 1, matches = NULL;
 				len >= (offset + sizeof(uint16_t) * 2);
 				offset += sizeof(uint16_t) * 2) {
-- 
1.8.3.2

