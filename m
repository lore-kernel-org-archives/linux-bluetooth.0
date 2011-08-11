Return-Path: <cyrus@holtmann.org>
From: Jakub Adamek <adamek.kuba@gmail.com>
To: linux-bluetooth@vger.kernel.org
Cc: Jakub Adamek <adamek.kuba@gmail.com>
Subject: [RFC obexd 1/4] Call get_next_header in PUT operations
Date: Fri, 12 Aug 2011 01:43:05 +0200
Message-Id: <1313106188-30273-2-git-send-email-adamek.kuba@gmail.com>
In-Reply-To: <1313106188-30273-1-git-send-email-adamek.kuba@gmail.com>
References: <1313106188-30273-1-git-send-email-adamek.kuba@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

The current code only calls the get_next_header
mimetype driver function for GET operations.
---
 src/obex-priv.h |    1 +
 src/obex.c      |  175 ++++++++++++++++++++++++++++++++-----------------------
 2 files changed, 102 insertions(+), 74 deletions(-)

diff --git a/src/obex-priv.h b/src/obex-priv.h
index d640ae0..e1fbfc3 100644
--- a/src/obex-priv.h
+++ b/src/obex-priv.h
@@ -44,6 +44,7 @@ struct obex_session {
 	void *service_data;
 	struct obex_server *server;
 	gboolean checked;
+	gboolean body_streamed;
 	obex_t *obex;
 	obex_object_t *obj;
 	struct obex_mime_type_driver *driver;
diff --git a/src/obex.c b/src/obex.c
index 49a110d..9595aad 100644
--- a/src/obex.c
+++ b/src/obex.c
@@ -320,6 +320,7 @@ static void os_reset_session(struct obex_session *os)
 	os->size = OBJECT_SIZE_DELETE;
 	os->headers_sent = FALSE;
 	os->streaming = FALSE;
+	os->body_streamed = FALSE;
 }
 
 static void obex_session_free(struct obex_session *os)
@@ -558,78 +559,6 @@ static gboolean chk_cid(obex_t *obex, obex_object_t *obj, uint32_t cid)
 	return ret;
 }
 
-static int obex_read_stream(struct obex_session *os, obex_t *obex,
-						obex_object_t *obj)
-{
-	int size;
-	ssize_t len = 0;
-	const uint8_t *buffer;
-
-	DBG("name=%s type=%s rx_mtu=%d file=%p",
-		os->name ? os->name : "", os->type ? os->type : "",
-		os->rx_mtu, os->object);
-
-	if (os->aborted)
-		return -EPERM;
-
-	/* workaround: client didn't send the object lenght */
-	if (os->size == OBJECT_SIZE_DELETE)
-		os->size = OBJECT_SIZE_UNKNOWN;
-
-	/* If there's something to write and we are able to write it */
-	if (os->pending > 0 && os->driver)
-		goto write;
-
-	size = OBEX_ObjectReadStream(obex, obj, &buffer);
-	if (size < 0) {
-		error("Error on OBEX stream");
-		return -EIO;
-	}
-
-	if (size > os->rx_mtu) {
-		error("Received more data than RX_MAX");
-		return -EIO;
-	}
-
-	os->buf = g_realloc(os->buf, os->pending + size);
-	memcpy(os->buf + os->pending, buffer, size);
-	os->pending += size;
-
-	/* only write if both object and driver are valid */
-	if (os->object == NULL || os->driver == NULL) {
-		DBG("Stored %" PRIu64 " bytes into temporary buffer",
-								os->pending);
-		return 0;
-	}
-
-write:
-	while (os->pending > 0) {
-		ssize_t w;
-
-		w = os->driver->write(os->object, os->buf + len,
-					os->pending);
-		if (w < 0) {
-			if (w == -EINTR)
-				continue;
-			else {
-				memmove(os->buf, os->buf + len, os->pending);
-				return w;
-			}
-		}
-
-		len += w;
-		os->offset += w;
-		os->pending -= w;
-	}
-
-	/* Flush on EOS */
-	if (os->size != OBJECT_SIZE_UNKNOWN && os->size == os->offset &&
-							os->driver->flush)
-		return os->driver->flush(os->object) > 0 ? -EAGAIN : 0;
-
-	return 0;
-}
-
 static int obex_write_stream(struct obex_session *os,
 			obex_t *obex, obex_object_t *obj)
 {
@@ -700,11 +629,14 @@ static int obex_write(struct obex_session *os, obex_t *obex, obex_object_t *obj)
 		return -EIO;
 
 	if (os->headers_sent)
-		return obex_write_stream(os, obex, obj);
+		goto skip;
 
 	if (!os->driver->get_next_header)
 		goto skip;
 
+	if (os->buf == NULL)
+		os->buf = g_malloc0(os->tx_mtu);
+
 	while ((len = os->driver->get_next_header(os->object, os->buf,
 					os->tx_mtu, &hi)) != 0) {
 		if (len < 0) {
@@ -727,7 +659,92 @@ static int obex_write(struct obex_session *os, obex_t *obex, obex_object_t *obj)
 skip:
 	os->headers_sent = TRUE;
 
-	return obex_write_stream(os, obex, obj);
+	if (os->cmd == OBEX_CMD_GET)
+		return obex_write_stream(os, obex, obj);
+	return 0;
+}
+
+static int obex_read_stream(struct obex_session *os, obex_t *obex,
+						obex_object_t *obj)
+{
+	int size;
+	ssize_t len = 0;
+	const uint8_t *buffer;
+
+	DBG("name=%s type=%s rx_mtu=%d file=%p",
+		os->name ? os->name : "", os->type ? os->type : "",
+		os->rx_mtu, os->object);
+
+	if (os->aborted)
+		return -EPERM;
+
+	/* workaround: client didn't send the object lenght */
+	if (os->size == OBJECT_SIZE_DELETE)
+		os->size = OBJECT_SIZE_UNKNOWN;
+
+	/* If there's something to write and we are able to write it */
+	if (os->pending > 0 && os->driver)
+		goto write;
+
+	size = OBEX_ObjectReadStream(obex, obj, &buffer);
+
+	if (size == 0)
+		os->body_streamed = TRUE;
+
+	if (size < 0) {
+		error("Error on OBEX stream");
+		return -EIO;
+	}
+
+	if (size > os->rx_mtu) {
+		error("Received more data than RX_MAX");
+		return -EIO;
+	}
+
+	os->buf = g_realloc(os->buf, os->pending + size);
+	memcpy(os->buf + os->pending, buffer, size);
+	os->pending += size;
+
+	/* only write if both object and driver are valid */
+	if (os->object == NULL || os->driver == NULL) {
+		DBG("Stored %" PRIu64 " bytes into temporary buffer",
+								os->pending);
+		return 0;
+	}
+
+write:
+	while (os->pending > 0) {
+		ssize_t w;
+
+		w = os->driver->write(os->object, os->buf + len,
+					os->pending);
+		if (w < 0) {
+			if (w == -EINTR)
+				continue;
+			else {
+				memmove(os->buf, os->buf + len, os->pending);
+				return w;
+			}
+		}
+
+		len += w;
+		os->offset += w;
+		os->pending -= w;
+	}
+
+	/* Flush on EOS and start  */
+	if (os->body_streamed && os->pending == 0) {
+		int ret = 0;
+		if (os->driver->flush != NULL)
+			ret = os->driver->flush(os->object) > 0 ? -EAGAIN : 0;
+
+		if (ret < 0)
+			return ret;
+
+		return obex_write(os, obex, obj);
+	}
+
+	return 0;
 }
 
 static gboolean handle_async_io(void *object, int flags, int err,
@@ -1148,6 +1165,16 @@ static void cmd_put(struct obex_session *os, obex_t *obex, obex_object_t *obj)
 		OBEX_SuspendRequest(obex, obj);
 		os->obj = obj;
 		os->driver->set_io_watch(os->object, handle_async_io, os);
+		return;
+	}
+
+	/* Get response headers if flush doesn't suspend */
+	err = obex_write(os, obex, obj);
+	if (err == -EAGAIN) {
+		OBEX_SuspendRequest(obex, obj);
+		os->obj = obj;
+		os->driver->set_io_watch(os->object, handle_async_io, os);
+		return;
 	}
 }
 
-- 
1.7.4.1

