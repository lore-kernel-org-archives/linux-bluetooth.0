Return-Path: <cyrus@holtmann.org>
From: Anderson Lizardo <anderson.lizardo@openbossa.org>
To: linux-bluetooth@vger.kernel.org
Cc: Anderson Lizardo <anderson.lizardo@openbossa.org>
Subject: [PATCH BlueZ 10/11] attrib: Fix PDU length check for Read by Type Request
Date: Sat, 11 Jan 2014 00:47:26 -0400
Message-Id: <1389415647-25831-10-git-send-email-anderson.lizardo@openbossa.org>
In-Reply-To: <1389415647-25831-1-git-send-email-anderson.lizardo@openbossa.org>
References: <1389415647-25831-1-git-send-email-anderson.lizardo@openbossa.org>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

PDU length must be either 7 or 21 octets.
---
 attrib/att.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/attrib/att.c b/attrib/att.c
index c279b2c..183390b 100644
--- a/attrib/att.c
+++ b/attrib/att.c
@@ -400,7 +400,7 @@ uint16_t dec_read_by_type_req(const uint8_t *pdu, size_t len, uint16_t *start,
 	if (start == NULL || end == NULL || uuid == NULL)
 		return 0;
 
-	if (len < min_len + 2)
+	if (len != (min_len + 2) && len != (min_len + 16))
 		return 0;
 
 	if (pdu[0] != ATT_OP_READ_BY_TYPE_REQ)
-- 
1.8.3.2

