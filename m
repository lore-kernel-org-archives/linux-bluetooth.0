Return-Path: <cyrus@holtmann.org>
From: Slawomir Bochenski <lkslawek@gmail.com>
To: linux-bluetooth@vger.kernel.org
Cc: Slawomir Bochenski <lkslawek@gmail.com>
Subject: [PATCH v3 4/4] Fix handling asynchronous plugin reads
Date: Mon, 13 Jun 2011 13:24:37 +0200
Message-Id: <1307964277-12590-1-git-send-email-lkslawek@gmail.com>
In-Reply-To: <1307957658-11330-3-git-send-email-lkslawek@gmail.com>
References: <1307957658-11330-3-git-send-email-lkslawek@gmail.com>
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
 src/obex.c      |   19 +++++++++++++++----
 2 files changed, 16 insertions(+), 4 deletions(-)

diff --git a/src/obex-priv.h b/src/obex-priv.h
index 8c722dc..164bc78 100644
--- a/src/obex-priv.h
+++ b/src/obex-priv.h
@@ -46,6 +46,7 @@ struct obex_session {
 	obex_object_t *obj;
 	struct obex_mime_type_driver *driver;
 	gboolean streaming;
+	gboolean suspended;
 };
 
 int obex_session_start(GIOChannel *io, uint16_t tx_mtu, uint16_t rx_mtu,
diff --git a/src/obex.c b/src/obex.c
index 1bdb6be..99fedc3 100644
--- a/src/obex.c
+++ b/src/obex.c
@@ -311,6 +311,7 @@ static void os_reset_session(struct obex_session *os)
 	os->offset = 0;
 	os->size = OBJECT_SIZE_DELETE;
 	os->streaming = FALSE;
+	os->suspended = FALSE;
 }
 
 static void obex_session_free(struct obex_session *os)
@@ -698,6 +699,8 @@ static void suspend_get(struct obex_session *os, obex_t *obex,
 {
 	obex_headerdata_t hd;
 
+	os->suspended = TRUE;
+
 	if (os->streaming) {
 		OBEX_SuspendRequest(obex, obj);
 		return;
@@ -728,13 +731,21 @@ static gboolean handle_async_io(void *object, int flags, int err,
 		ret = obex_read_stream(os, os->obex, os->obj);
 
 proceed:
-	if (ret < 0) {
+	os->suspended = FALSE;
+
+	if (ret == -EAGAIN) {
+		suspend_get(os, os->obex, os->obj);
+	} else if (ret < 0) {
 		os_set_response(os->obj, err);
 		OBEX_CancelRequest(os->obex, TRUE);
-	} else
+	} else {
 		OBEX_ResumeRequest(os->obex);
+	}
 
-	return FALSE;
+	if (os->suspended)
+		return TRUE;
+	else
+		return FALSE;
 }
 
 static void cmd_get(struct obex_session *os, obex_t *obex, obex_object_t *obj)
@@ -1225,7 +1236,7 @@ static void obex_event_cb(obex_t *obex, obex_object_t *obj, int mode,
 	case OBEX_EV_STREAMEMPTY:
 		err = obex_write_stream(os, obex, obj);
 		if (err == -EAGAIN) {
-			OBEX_SuspendRequest(obex, obj);
+			suspend_get(os, obex, obj);
 			os->obj = obj;
 			os->driver->set_io_watch(os->object, handle_async_io,
 									os);
-- 
1.7.4.1

