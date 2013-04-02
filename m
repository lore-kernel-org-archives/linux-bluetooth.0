Return-Path: <cyrus@holtmann.org>
From: Anderson Lizardo <anderson.lizardo@openbossa.org>
To: linux-bluetooth@vger.kernel.org
Cc: Anderson Lizardo <anderson.lizardo@openbossa.org>
Subject: [PATCH BlueZ 2/3] attrib: Fix coding style in read_char_helper()
Date: Tue,  2 Apr 2013 11:07:44 -0400
Message-Id: <1364915265-4191-2-git-send-email-anderson.lizardo@openbossa.org>
In-Reply-To: <1364915265-4191-1-git-send-email-anderson.lizardo@openbossa.org>
References: <1364915265-4191-1-git-send-email-anderson.lizardo@openbossa.org>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

---
 attrib/gatt.c |    5 ++---
 1 file changed, 2 insertions(+), 3 deletions(-)

diff --git a/attrib/gatt.c b/attrib/gatt.c
index e4c5385..c1aa070 100644
--- a/attrib/gatt.c
+++ b/attrib/gatt.c
@@ -651,7 +651,6 @@ static void read_char_helper(guint8 status, const guint8 *rpdu,
 		goto done;
 
 	long_read->buffer = g_malloc(rlen);
-
 	if (long_read->buffer == NULL)
 		goto done;
 
@@ -659,9 +658,9 @@ static void read_char_helper(guint8 status, const guint8 *rpdu,
 	long_read->size = rlen;
 
 	plen = enc_read_blob_req(long_read->handle, rlen - 1, buf, buflen);
-	id = g_attrib_send(long_read->attrib, long_read->id, buf, plen,
-			read_blob_helper, long_read, read_long_destroy);
 
+	id = g_attrib_send(long_read->attrib, long_read->id, buf, plen,
+				read_blob_helper, long_read, read_long_destroy);
 	if (id != 0) {
 		g_atomic_int_inc(&long_read->ref);
 		return;
-- 
1.7.9.5

