Return-Path: <cyrus@holtmann.org>
From: Anderson Lizardo <anderson.lizardo@openbossa.org>
To: linux-bluetooth@vger.kernel.org
Cc: Anderson Lizardo <anderson.lizardo@openbossa.org>
Subject: [PATCH BlueZ 3/3] attrib: Fix status on memory allocation failure
Date: Tue,  2 Apr 2013 11:07:45 -0400
Message-Id: <1364915265-4191-3-git-send-email-anderson.lizardo@openbossa.org>
In-Reply-To: <1364915265-4191-1-git-send-email-anderson.lizardo@openbossa.org>
References: <1364915265-4191-1-git-send-email-anderson.lizardo@openbossa.org>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

If memory allocation fails, ATT_ECODE_INSUFF_RESOURCES should be
reported to the callback.
---
 attrib/gatt.c |    4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/attrib/gatt.c b/attrib/gatt.c
index c1aa070..38d455a 100644
--- a/attrib/gatt.c
+++ b/attrib/gatt.c
@@ -651,8 +651,10 @@ static void read_char_helper(guint8 status, const guint8 *rpdu,
 		goto done;
 
 	long_read->buffer = g_malloc(rlen);
-	if (long_read->buffer == NULL)
+	if (long_read->buffer == NULL) {
+		status = ATT_ECODE_INSUFF_RESOURCES;
 		goto done;
+	}
 
 	memcpy(long_read->buffer, rpdu, rlen);
 	long_read->size = rlen;
-- 
1.7.9.5

