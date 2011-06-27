Return-Path: <cyrus@holtmann.org>
From: Slawomir Bochenski <lkslawek@gmail.com>
To: linux-bluetooth@vger.kernel.org
Cc: Slawomir Bochenski <lkslawek@gmail.com>
Subject: [PATCH obexd 3/5] Add get_next_header() function
Date: Mon, 27 Jun 2011 16:20:53 +0200
Message-Id: <1309184455-29752-4-git-send-email-lkslawek@gmail.com>
In-Reply-To: <1309184455-29752-1-git-send-email-lkslawek@gmail.com>
References: <1309184455-29752-1-git-send-email-lkslawek@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

This adds the function for mime drivers that allows adding OBEX headers
before body streaming is started.
---
 src/mimetype.h  |    2 +
 src/obex-priv.h |    1 +
 src/obex.c      |   60 +++++++++++++++++++++++++++++++++++++++++++++++++++---
 3 files changed, 59 insertions(+), 4 deletions(-)

diff --git a/src/mimetype.h b/src/mimetype.h
index 8472684..511ab6a 100644
--- a/src/mimetype.h
+++ b/src/mimetype.h
@@ -33,6 +33,8 @@ struct obex_mime_type_driver {
 	void *(*open) (const char *name, int oflag, mode_t mode,
 			void *driver_data, size_t *size, int *err);
 	int (*close) (void *object);
+	ssize_t (*get_next_header)(void *object, void *buf, size_t mtu,
+								uint8_t *hi);
 	ssize_t (*read) (void *object, void *buf, size_t count, uint8_t *hi);
 	ssize_t (*write) (void *object, const void *buf, size_t count);
 	int (*flush) (void *object);
diff --git a/src/obex-priv.h b/src/obex-priv.h
index 8c722dc..51a7739 100644
--- a/src/obex-priv.h
+++ b/src/obex-priv.h
@@ -46,6 +46,7 @@ struct obex_session {
 	obex_object_t *obj;
 	struct obex_mime_type_driver *driver;
 	gboolean streaming;
+	gboolean headers_sent;
 };
 
 int obex_session_start(GIOChannel *io, uint16_t tx_mtu, uint16_t rx_mtu,
diff --git a/src/obex.c b/src/obex.c
index 3ab81d4..596da6a 100644
--- a/src/obex.c
+++ b/src/obex.c
@@ -310,6 +310,7 @@ static void os_reset_session(struct obex_session *os)
 	os->pending = 0;
 	os->offset = 0;
 	os->size = OBJECT_SIZE_DELETE;
+	os->headers_sent = FALSE;
 	os->streaming = FALSE;
 }
 
@@ -685,6 +686,53 @@ static int obex_write_stream(struct obex_session *os,
 	return 0;
 }
 
+static int obex_write(struct obex_session *os, obex_t *obex, obex_object_t *obj)
+{
+	obex_headerdata_t hd;
+	ssize_t len;
+	uint8_t hi;
+
+	DBG("name=%s type=%s tx_mtu=%d file=%p",
+		os->name ? os->name : "", os->type ? os->type : "",
+		os->tx_mtu, os->object);
+
+	if (os->aborted)
+		return -EPERM;
+
+	if (os->object == NULL)
+		return -EIO;
+
+	if (os->headers_sent)
+		return obex_write_stream(os, obex, obj);
+
+	if (!os->driver->get_next_header)
+		goto skip;
+
+	while ((len = os->driver->get_next_header(os->object, os->buf,
+					os->tx_mtu, &hi)) != 0) {
+		if (len < 0) {
+			error("get_next_header(): %s (%zd)", strerror(-len),
+								-len);
+
+			if (len == -EAGAIN)
+				return len;
+
+			g_free(os->buf);
+			os->buf = NULL;
+
+			return len;
+		}
+
+		hd.bs = os->buf;
+		OBEX_ObjectAddHeader(obex, obj, hi, hd, len, 0);
+	}
+
+skip:
+	os->headers_sent = TRUE;
+
+	return obex_write_stream(os, obex, obj);
+}
+
 static gboolean handle_async_io(void *object, int flags, int err,
 						void *user_data)
 {
@@ -697,16 +745,19 @@ static gboolean handle_async_io(void *object, int flags, int err,
 	}
 
 	if (flags & (G_IO_IN | G_IO_PRI))
-		ret = obex_write_stream(os, os->obex, os->obj);
+		ret = obex_write(os, os->obex, os->obj);
 	else if ((flags & G_IO_OUT) && os->pending > 0)
 		ret = obex_read_stream(os, os->obex, os->obj);
 
 proceed:
-	if (ret < 0) {
+	if (ret == -EAGAIN) {
+		return TRUE;
+	} else if (ret < 0) {
 		os_set_response(os->obj, ret);
 		OBEX_CancelRequest(os->obex, TRUE);
-	} else
+	} else {
 		OBEX_ResumeRequest(os->obex);
+	}
 
 	return FALSE;
 }
@@ -729,6 +780,7 @@ static void cmd_get(struct obex_session *os, obex_t *obex, obex_object_t *obj)
 
 	g_return_if_fail(chk_cid(obex, obj, os->cid));
 
+	os->headers_sent = FALSE;
 	os->streaming = FALSE;
 
 	while (OBEX_ObjectGetNextHeader(obex, obj, &hi, &hd, &hlen)) {
@@ -813,7 +865,7 @@ static void cmd_get(struct obex_session *os, obex_t *obex, obex_object_t *obj)
 
 	/* Try to write to stream and suspend the stream immediately
 	 * if no data available to send. */
-	err = obex_write_stream(os, obex, obj);
+	err = obex_write(os, obex, obj);
 	if (err == -EAGAIN) {
 		OBEX_SuspendRequest(obex, obj);
 		os->obj = obj;
-- 
1.7.4.1

