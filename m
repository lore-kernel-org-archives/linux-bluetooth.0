Return-Path: <cyrus@holtmann.org>
From: Slawomir Bochenski <lkslawek@gmail.com>
To: linux-bluetooth@vger.kernel.org
Cc: Slawomir Bochenski <lkslawek@gmail.com>
Subject: [PATCH obexd v2] Fix handling asynchronous plugin reads
Date: Fri, 12 Aug 2011 11:06:43 +0200
Message-Id: <1313140003-21576-1-git-send-email-lkslawek@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Calling OBEX_ResumeRequest() from handle_async_io() may result in direct
calling obex_event_cb() (this happens when obex_write_stream() will
deliver not enough bytes to fully fill OpenOBEX TX packet). In this case
set_io_watch will fail if handle_async_io() is called from
obex_object_set_io_flags(), because the watch is already installed.
Originally when code returns from OBEX_ResumeRequest(), handle_async_io()
returns FALSE which makes obex_object_set_io_flags() remove this watch.

This patch adds variable for tracking whether subsequent calls suspended
get request, causing obex_object_set_io_flags() remove the watch only
when the request is not suspended.

Additionaly member 'streaming' of obex_session has been renamed to
'stream_open'.
---
 src/obex-priv.h |    3 ++-
 src/obex.c      |   14 +++++++++-----
 2 files changed, 11 insertions(+), 6 deletions(-)

diff --git a/src/obex-priv.h b/src/obex-priv.h
index d640ae0..01b6496 100644
--- a/src/obex-priv.h
+++ b/src/obex-priv.h
@@ -47,7 +47,8 @@ struct obex_session {
 	obex_t *obex;
 	obex_object_t *obj;
 	struct obex_mime_type_driver *driver;
-	gboolean streaming;
+	gboolean stream_open;
+	gboolean stream_suspended;
 	gboolean headers_sent;
 };
 
diff --git a/src/obex.c b/src/obex.c
index 49a110d..dca3a0b 100644
--- a/src/obex.c
+++ b/src/obex.c
@@ -319,7 +319,8 @@ static void os_reset_session(struct obex_session *os)
 	os->offset = 0;
 	os->size = OBJECT_SIZE_DELETE;
 	os->headers_sent = FALSE;
-	os->streaming = FALSE;
+	os->stream_open = FALSE;
+	os->stream_suspended = FALSE;
 }
 
 static void obex_session_free(struct obex_session *os)
@@ -661,11 +662,11 @@ static int obex_write_stream(struct obex_session *os,
 		return len;
 	}
 
-	if (!os->streaming) {
+	if (!os->stream_open) {
 		hd.bs = NULL;
 		OBEX_ObjectAddHeader(obex, obj, OBEX_HDR_BODY, hd, 0,
 						OBEX_FL_STREAM_START);
-		os->streaming = TRUE;
+		os->stream_open = TRUE;
 	}
 
 	if (len == 0) {
@@ -747,6 +748,8 @@ static gboolean handle_async_io(void *object, int flags, int err,
 		ret = obex_read_stream(os, os->obex, os->obj);
 
 proceed:
+	os->stream_suspended = FALSE;
+
 	if (ret == -EAGAIN) {
 		return TRUE;
 	} else if (ret < 0) {
@@ -756,7 +759,7 @@ proceed:
 		OBEX_ResumeRequest(os->obex);
 	}
 
-	return FALSE;
+	return os->stream_suspended;
 }
 
 static void cmd_get(struct obex_session *os, obex_t *obex, obex_object_t *obj)
@@ -778,7 +781,7 @@ static void cmd_get(struct obex_session *os, obex_t *obex, obex_object_t *obj)
 	g_return_if_fail(chk_cid(obex, obj, os->cid));
 
 	os->headers_sent = FALSE;
-	os->streaming = FALSE;
+	os->stream_open = FALSE;
 
 	while (OBEX_ObjectGetNextHeader(obex, obj, &hi, &hd, &hlen)) {
 		switch (hi) {
@@ -1355,6 +1358,7 @@ static void obex_event_cb(obex_t *obex, obex_object_t *obj, int mode,
 		err = obex_write_stream(os, obex, obj);
 		if (err == -EAGAIN) {
 			OBEX_SuspendRequest(obex, obj);
+			os->stream_suspended = TRUE;
 			os->obj = obj;
 			os->driver->set_io_watch(os->object, handle_async_io,
 									os);
-- 
1.7.4.1

