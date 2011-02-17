Return-Path: <cyrus@holtmann.org>
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH 1/2] Fix not responding to pbap GET when data is already cached
Date: Thu, 17 Feb 2011 10:53:28 +0200
Message-Id: <1297932809-3460-1-git-send-email-luiz.dentz@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

From: Luiz Augusto von Dentz <luiz.dentz-von@nokia.com>

When data is cached but no stream/body is set the driver .write is never
called so no response is generated.
---
 src/obex.c |   35 +++++++++++++++--------------------
 1 files changed, 15 insertions(+), 20 deletions(-)

diff --git a/src/obex.c b/src/obex.c
index 98f0e4d..e6e22f5 100644
--- a/src/obex.c
+++ b/src/obex.c
@@ -813,30 +813,25 @@ static void cmd_get(struct obex_session *os, obex_t *obex, obex_object_t *obj)
 
 	/* Add body header */
 	hd.bs = NULL;
-	if (os->size == 0)
-		OBEX_ObjectAddHeader (obex, obj, OBEX_HDR_BODY,
-				hd, 0, OBEX_FL_FIT_ONE_PACKET);
-	else if (!stream) {
-		/* Asynchronous operation that doesn't use stream */
+	if (os->size == 0) {
+		OBEX_ObjectAddHeader(obex, obj, OBEX_HDR_BODY, hd, 0,
+						OBEX_FL_FIT_ONE_PACKET);
+		goto done;
+	}
+
+	if (stream)
+		/* Standard data stream */
+		OBEX_ObjectAddHeader(obex, obj, OBEX_HDR_BODY, hd, 0,
+						OBEX_FL_STREAM_START);
+
+	/* Try to write to stream and suspend the stream immediately
+	 * if no data available to send. */
+	err = obex_write_stream(os, obex, obj);
+	if (err == -EAGAIN) {
 		OBEX_SuspendRequest(obex, obj);
 		os->obj = obj;
 		os->driver->set_io_watch(os->object, handle_async_io, os);
 		return;
-	} else {
-		/* Standard data stream */
-		OBEX_ObjectAddHeader (obex, obj, OBEX_HDR_BODY,
-				hd, 0, OBEX_FL_STREAM_START);
-
-		/* Try to write to stream and suspend the stream immediately
-		 * if no data available to send. */
-		err = obex_write_stream(os, obex, obj);
-		if (err == -EAGAIN) {
-			OBEX_SuspendRequest(obex, obj);
-			os->obj = obj;
-			os->driver->set_io_watch(os->object, handle_async_io,
-									os);
-			return;
-		}
 	}
 
 done:
-- 
1.7.1

