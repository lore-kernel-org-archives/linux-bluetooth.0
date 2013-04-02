Return-Path: <cyrus@holtmann.org>
From: Anderson Lizardo <anderson.lizardo@openbossa.org>
To: linux-bluetooth@vger.kernel.org
Cc: Anderson Lizardo <anderson.lizardo@openbossa.org>
Subject: [RFC BlueZ 10/18] attrib: Allow dec_read_resp() to just check if PDU is valid
Date: Tue,  2 Apr 2013 12:50:57 -0400
Message-Id: <1364921465-31182-11-git-send-email-anderson.lizardo@openbossa.org>
In-Reply-To: <1364921465-31182-1-git-send-email-anderson.lizardo@openbossa.org>
References: <1364921465-31182-1-git-send-email-anderson.lizardo@openbossa.org>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

If a NULL "value" parameter is given, only check whether PDU is valid,
without copying attribute value to a buffer.
---
 attrib/att.c |    6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/attrib/att.c b/attrib/att.c
index d2b78bd..14871d9 100644
--- a/attrib/att.c
+++ b/attrib/att.c
@@ -703,12 +703,12 @@ ssize_t dec_read_resp(const uint8_t *pdu, size_t len, uint8_t *value, size_t vle
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

