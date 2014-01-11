Return-Path: <cyrus@holtmann.org>
From: Anderson Lizardo <anderson.lizardo@openbossa.org>
To: linux-bluetooth@vger.kernel.org
Cc: Anderson Lizardo <anderson.lizardo@openbossa.org>
Subject: [PATCH BlueZ 07/11] attrib: Remove unnecessary NULL checks on dec_find_by_type_req()
Date: Sat, 11 Jan 2014 00:47:23 -0400
Message-Id: <1389415647-25831-7-git-send-email-anderson.lizardo@openbossa.org>
In-Reply-To: <1389415647-25831-1-git-send-email-anderson.lizardo@openbossa.org>
References: <1389415647-25831-1-git-send-email-anderson.lizardo@openbossa.org>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Just assume that the caller will pass non-NULL pointers as arguments
(which is true for the only current caller of this function).
---
 attrib/att.c | 24 +++++++++---------------
 1 file changed, 9 insertions(+), 15 deletions(-)

diff --git a/attrib/att.c b/attrib/att.c
index 777ef46..435a26d 100644
--- a/attrib/att.c
+++ b/attrib/att.c
@@ -291,30 +291,24 @@ uint16_t dec_find_by_type_req(const uint8_t *pdu, size_t len, uint16_t *start,
 	if (len < min_len)
 		return 0;
 
+	/* Attribute Opcode (1 octet) */
 	if (pdu[0] != ATT_OP_FIND_BY_TYPE_REQ)
 		return 0;
 
-	/* First requested handle number */
-	if (start)
-		*start = att_get_u16(&pdu[1]);
-
-	/* Last requested handle number */
-	if (end)
-		*end = att_get_u16(&pdu[3]);
-
-	/* Always UUID16 */
-	if (uuid)
-		*uuid = att_get_uuid16(&pdu[5]);
+	/* First requested handle number (2 octets) */
+	*start = att_get_u16(&pdu[1]);
+	/* Last requested handle number (2 octets) */
+	*end = att_get_u16(&pdu[3]);
+	/* 16-bit UUID to find (2 octets) */
+	*uuid = att_get_uuid16(&pdu[5]);
 
 	valuelen = len - min_len;
+	*vlen = valuelen;
 
 	/* Attribute value to find */
-	if (valuelen > 0 && value)
+	if (valuelen > 0)
 		memcpy(value, pdu + min_len, valuelen);
 
-	if (vlen)
-		*vlen = valuelen;
-
 	return len;
 }
 
-- 
1.8.3.2

