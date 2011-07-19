Return-Path: <cyrus@holtmann.org>
From: Slawomir Bochenski <lkslawek@gmail.com>
To: linux-bluetooth@vger.kernel.org
Cc: Slawomir Bochenski <lkslawek@gmail.com>
Subject: [PATCH obexd] Fix handling asynchronous plugin reads
Date: Tue, 19 Jul 2011 12:48:34 +0200
Message-Id: <1311072514-10572-1-git-send-email-lkslawek@gmail.com>
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
---
 src/obex-priv.h |    1 +
 src/obex.c      |    6 +++++-
 2 files changed, 6 insertions(+), 1 deletions(-)

diff --git a/src/obex-priv.h b/src/obex-priv.h
index d640ae0..74b42d3 100644
--- a/src/obex-priv.h
+++ b/src/obex-priv.h
@@ -49,6 +49,7 @@ struct obex_session {
 	struct obex_mime_type_driver *driver;
 	gboolean streaming;
 	gboolean headers_sent;
+	gboolean suspended;
 };
 
 int obex_session_start(GIOChannel *io, uint16_t tx_mtu, uint16_t rx_mtu,
diff --git a/src/obex.c b/src/obex.c
index 49a110d..29dea20 100644
--- a/src/obex.c
+++ b/src/obex.c
@@ -320,6 +320,7 @@ static void os_reset_session(struct obex_session *os)
 	os->size = OBJECT_SIZE_DELETE;
 	os->headers_sent = FALSE;
 	os->streaming = FALSE;
+	os->suspended = FALSE;
 }
 
 static void obex_session_free(struct obex_session *os)
@@ -747,6 +748,8 @@ static gboolean handle_async_io(void *object, int flags, int err,
 		ret = obex_read_stream(os, os->obex, os->obj);
 
 proceed:
+	os->suspended = FALSE;
+
 	if (ret == -EAGAIN) {
 		return TRUE;
 	} else if (ret < 0) {
@@ -756,7 +759,7 @@ proceed:
 		OBEX_ResumeRequest(os->obex);
 	}
 
-	return FALSE;
+	return os->suspended;
 }
 
 static void cmd_get(struct obex_session *os, obex_t *obex, obex_object_t *obj)
@@ -1355,6 +1358,7 @@ static void obex_event_cb(obex_t *obex, obex_object_t *obj, int mode,
 		err = obex_write_stream(os, obex, obj);
 		if (err == -EAGAIN) {
 			OBEX_SuspendRequest(obex, obj);
+			os->suspended = TRUE;
 			os->obj = obj;
 			os->driver->set_io_watch(os->object, handle_async_io,
 									os);
-- 
1.7.4.1

