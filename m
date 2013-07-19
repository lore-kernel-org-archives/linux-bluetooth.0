Return-Path: <cyrus@holtmann.org>
From: Anderson Lizardo <anderson.lizardo@openbossa.org>
To: linux-bluetooth@vger.kernel.org
Cc: Anderson Lizardo <anderson.lizardo@openbossa.org>
Subject: [PATCH BlueZ 10/11] attrib: Allow dec_read_resp() to just check if PDU is valid
Date: Fri, 19 Jul 2013 13:34:16 -0400
Message-Id: <1374255257-8753-11-git-send-email-anderson.lizardo@openbossa.org>
In-Reply-To: <1374255257-8753-1-git-send-email-anderson.lizardo@openbossa.org>
References: <1374255257-8753-1-git-send-email-anderson.lizardo@openbossa.org>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

If a NULL "value" parameter is given, only check whether PDU is valid,
without copying attribute value to a buffer.
---
 attrib/att.c |    6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/attrib/att.c b/attrib/att.c
index d5f4f68..753c753 100644
--- a/attrib/att.c
+++ b/attrib/att.c
@@ -704,12 +704,12 @@ ssize_t dec_read_resp(const uint8_t *pdu, size_t len, uint8_t *value,
 	if (pdu == NULL)
 		return -EINVAL;
 
-	if (value == NULL)
-		return -EINVAL;
-
 	if (pdu[0] != ATT_OP_READ_RESP)
 		return -EINVAL;
 
+	if (value == NULL)
+		return len - 1;
+
 	if (vlen < (len - 1))
 		return -ENOBUFS;
 
-- 
1.7.9.5

