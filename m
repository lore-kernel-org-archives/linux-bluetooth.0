Return-Path: <cyrus@holtmann.org>
From: Anderson Lizardo <anderson.lizardo@openbossa.org>
To: linux-bluetooth@vger.kernel.org
Cc: Anderson Lizardo <anderson.lizardo@openbossa.org>
Subject: [PATCH BlueZ 05/11] attrib: Fix PDU length check for Read by Group Type Request
Date: Sat, 11 Jan 2014 00:47:21 -0400
Message-Id: <1389415647-25831-5-git-send-email-anderson.lizardo@openbossa.org>
In-Reply-To: <1389415647-25831-1-git-send-email-anderson.lizardo@openbossa.org>
References: <1389415647-25831-1-git-send-email-anderson.lizardo@openbossa.org>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

PDU length must be either 7 or 21 octets.
---
 attrib/att.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/attrib/att.c b/attrib/att.c
index a8f641a..472c25c 100644
--- a/attrib/att.c
+++ b/attrib/att.c
@@ -161,7 +161,7 @@ uint16_t dec_read_by_grp_req(const uint8_t *pdu, size_t len, uint16_t *start,
 	if (pdu[0] != ATT_OP_READ_BY_GROUP_REQ)
 		return 0;
 
-	if (len < min_len + 2)
+	if (len != (min_len + 2) && len != (min_len + 16))
 		return 0;
 
 	*start = att_get_u16(&pdu[1]);
-- 
1.8.3.2

