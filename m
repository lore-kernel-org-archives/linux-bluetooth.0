Return-Path: <cyrus@holtmann.org>
From: Sheldon Demario <sheldon.demario@openbossa.org>
To: linux-bluetooth@vger.kernel.org
Cc: Sheldon Demario <sheldon.demario@openbossa.org>
Subject: [PATCH] Attrib server should truncate attribute value to pdu length
Date: Mon, 29 Nov 2010 07:44:22 -0500
Message-Id: <1291034662-6138-1-git-send-email-sheldon.demario@openbossa.org>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

When the size of attribute value is greater than pdu size, it should be
truncated to the pdu length - 2
---
 attrib/att.c |   15 +++++++--------
 1 files changed, 7 insertions(+), 8 deletions(-)

diff --git a/attrib/att.c b/attrib/att.c
index 8655e5e..445b192 100644
--- a/attrib/att.c
+++ b/attrib/att.c
@@ -379,7 +379,7 @@ uint16_t dec_read_by_type_req(const uint8_t *pdu, int len, uint16_t *start,
 uint16_t enc_read_by_type_resp(struct att_data_list *list, uint8_t *pdu, int len)
 {
 	uint8_t *ptr;
-	int i, w;
+	int i, w, l;
 
 	if (list == NULL)
 		return 0;
@@ -387,17 +387,16 @@ uint16_t enc_read_by_type_resp(struct att_data_list *list, uint8_t *pdu, int len
 	if (pdu == NULL)
 		return 0;
 
-	if (len < list->len + 2)
-		return 0;
+	l = MIN(len - 2, list->len);
 
 	pdu[0] = ATT_OP_READ_BY_TYPE_RESP;
-	pdu[1] = list->len;
+	pdu[1] = l;
 	ptr = &pdu[2];
 
-	for (i = 0, w = 2; i < list->num && w + list->len <= len; i++) {
-		memcpy(ptr, list->data[i], list->len);
-		ptr += list->len;
-		w += list->len;
+	for (i = 0, w = 2; i < list->num && w + l <= len; i++) {
+		memcpy(ptr, list->data[i], l);
+		ptr += l;
+		w += l;
 	}
 
 	return w;
-- 
1.7.3.2

