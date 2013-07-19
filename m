Return-Path: <cyrus@holtmann.org>
From: Anderson Lizardo <anderson.lizardo@openbossa.org>
To: linux-bluetooth@vger.kernel.org
Cc: Anderson Lizardo <anderson.lizardo@openbossa.org>
Subject: [PATCH BlueZ 04/11] attrib: Fix coding style in prepare_write_cb()
Date: Fri, 19 Jul 2013 13:34:10 -0400
Message-Id: <1374255257-8753-5-git-send-email-anderson.lizardo@openbossa.org>
In-Reply-To: <1374255257-8753-1-git-send-email-anderson.lizardo@openbossa.org>
References: <1374255257-8753-1-git-send-email-anderson.lizardo@openbossa.org>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

---
 attrib/gatt.c |   10 +++++-----
 1 file changed, 5 insertions(+), 5 deletions(-)

diff --git a/attrib/gatt.c b/attrib/gatt.c
index 9de07e4..3e6f040 100644
--- a/attrib/gatt.c
+++ b/attrib/gatt.c
@@ -734,8 +734,8 @@ static guint prepare_write(GAttrib *attrib, uint16_t handle, uint16_t offset,
 			uint8_t *value, size_t vlen, GAttribResultFunc func,
 			gpointer user_data);
 
-static void prepare_write_cb(guint8 status, const guint8 *rpdu,
-					guint16 rlen, gpointer user_data)
+static void prepare_write_cb(guint8 status, const guint8 *rpdu, guint16 rlen,
+							gpointer user_data)
 {
 	struct write_long_data *long_write = user_data;
 
@@ -747,7 +747,7 @@ static void prepare_write_cb(guint8 status, const guint8 *rpdu,
 	/* Skip Prepare Write Response PDU header (5 bytes) */
 	long_write->offset += rlen - 5;
 
-	if (long_write->offset == long_write->vlen){
+	if (long_write->offset == long_write->vlen) {
 		execute_write(long_write->attrib, ATT_WRITE_ALL_PREP_WRITES,
 				long_write->func, long_write->user_data);
 		g_free(long_write->value);
@@ -757,8 +757,8 @@ static void prepare_write_cb(guint8 status, const guint8 *rpdu,
 	}
 
 	prepare_write(long_write->attrib, long_write->handle,
-		long_write->offset, long_write->value, long_write->vlen,
-		long_write->func, long_write);
+			long_write->offset, long_write->value, long_write->vlen,
+			long_write->func, long_write);
 }
 
 static guint prepare_write(GAttrib *attrib, uint16_t handle, uint16_t offset,
-- 
1.7.9.5

