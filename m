Return-Path: <cyrus@holtmann.org>
From: Anderson Lizardo <anderson.lizardo@openbossa.org>
To: linux-bluetooth@vger.kernel.org
Cc: Anderson Lizardo <anderson.lizardo@openbossa.org>
Subject: [PATCH BlueZ 08/11] attrib: Remove unnecessary local variables from dec_find_by_type_req()
Date: Sat, 11 Jan 2014 00:47:24 -0400
Message-Id: <1389415647-25831-8-git-send-email-anderson.lizardo@openbossa.org>
In-Reply-To: <1389415647-25831-1-git-send-email-anderson.lizardo@openbossa.org>
References: <1389415647-25831-1-git-send-email-anderson.lizardo@openbossa.org>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Use number instead of "min_len", which is easier to review (with help of
the documented parameter sizes).

valuelen is redundant as *vlen can be used directly.
---
 attrib/att.c | 14 ++++----------
 1 file changed, 4 insertions(+), 10 deletions(-)

diff --git a/attrib/att.c b/attrib/att.c
index 435a26d..d367918 100644
--- a/attrib/att.c
+++ b/attrib/att.c
@@ -281,14 +281,10 @@ uint16_t dec_find_by_type_req(const uint8_t *pdu, size_t len, uint16_t *start,
 						uint16_t *end, bt_uuid_t *uuid,
 						uint8_t *value, size_t *vlen)
 {
-	size_t valuelen;
-	uint16_t min_len = sizeof(pdu[0]) + sizeof(*start) +
-						sizeof(*end) + sizeof(uint16_t);
-
 	if (pdu == NULL)
 		return 0;
 
-	if (len < min_len)
+	if (len < 7)
 		return 0;
 
 	/* Attribute Opcode (1 octet) */
@@ -302,12 +298,10 @@ uint16_t dec_find_by_type_req(const uint8_t *pdu, size_t len, uint16_t *start,
 	/* 16-bit UUID to find (2 octets) */
 	*uuid = att_get_uuid16(&pdu[5]);
 
-	valuelen = len - min_len;
-	*vlen = valuelen;
-
 	/* Attribute value to find */
-	if (valuelen > 0)
-		memcpy(value, pdu + min_len, valuelen);
+	*vlen = len - 7;
+	if (*vlen > 0)
+		memcpy(value, pdu + 7, *vlen);
 
 	return len;
 }
-- 
1.8.3.2

