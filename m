Return-Path: <cyrus@holtmann.org>
From: =?UTF-8?q?Micha=C5=82=20Poczwardowski?= <dmp0x7c5@gmail.com>
To: linux-bluetooth@vger.kernel.org
Cc: =?UTF-8?q?Micha=C5=82=20Poczwardowski?= <dmp0x7c5@gmail.com>
Subject: [RFC v3 obexd 08/10] fuse: Add write and touch operations
Date: Sun,  2 Dec 2012 00:14:53 +0100
Message-Id: <1354403695-18985-8-git-send-email-dmp0x7c5@gmail.com>
In-Reply-To: <1354403695-18985-1-git-send-email-dmp0x7c5@gmail.com>
References: <1354403695-18985-1-git-send-email-dmp0x7c5@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

---
 fuse/helpers.c  |   84 +++++++++++++++++++++++++++++++++++++++++++++++++++++++
 fuse/helpers.h  |    4 ++
 fuse/obexfuse.c |   61 ++++++++++++++++++++++++++++++++++++++++
 3 files changed, 149 insertions(+), 0 deletions(-)

diff --git a/fuse/helpers.c b/fuse/helpers.c
index 72b0b3e..b4bd7e5 100644
--- a/fuse/helpers.c
+++ b/fuse/helpers.c
@@ -56,6 +56,8 @@ struct obexhlp_location {
 	gchar *file;
 };
 
+void obexhlp_touch_real(struct obexhlp_session* session, gchar *path);
+
 static volatile sig_atomic_t __sdp_io_finished = 0;
 
 /* adopted from client/bluetooth.c - search_callback() */
@@ -326,6 +328,12 @@ void request_new(struct obexhlp_session *session,
 {
 	g_print("REQUEST %s\n", name);
 
+	if (session->vtouch == TRUE) {
+		session->vtouch = FALSE;
+		obexhlp_touch_real(session, session->vtouch_path);
+		g_free(session->vtouch_path);
+	}
+
 	if (session->request != NULL)
 		g_error("Another request (%s) active!\n",
 					session->request->name);
@@ -624,3 +632,79 @@ struct obexhlp_buffer *obexhlp_get(struct obexhlp_session* session,
 
 	return buffer;
 }
+
+static gssize async_put_producer(void *buf, gsize len, gpointer user_data)
+{
+	gssize size;
+	struct obexhlp_session *session = user_data;
+	struct obexhlp_buffer *buffer = session->buffer;
+
+	size = buffer->size - buffer->tmpsize;
+
+	if (size > len)
+		size = len;
+
+	g_obex_suspend(session->obex);
+	g_obex_resume(session->obex);
+
+	if (size == 0)
+		return 0;
+
+	memcpy(buf, buffer->data + buffer->tmpsize, size);
+	buffer->tmpsize += size;
+
+	return size;
+}
+
+void obexhlp_put(struct obexhlp_session* session,
+				struct obexhlp_buffer *buffer,
+				const char *path)
+{
+	struct obexhlp_location *l;
+	l = get_location(path);
+
+	g_print("obexhlp_put(%s%s)\n", l->dir, l->file);
+
+	obexhlp_setpath(session, l->dir);
+	buffer->tmpsize = 0;
+	session->buffer = buffer;
+	request_new(session, g_strdup_printf("put %s", path));
+	g_obex_put_req(session->obex, async_put_producer,
+					complete_func, session, &session->err,
+					G_OBEX_HDR_NAME, l->file,
+					G_OBEX_HDR_INVALID);
+	free_location(l);
+	request_wait_free(session);
+}
+
+/* virtual file creation */
+void obexhlp_touch(struct obexhlp_session* session, const char *path)
+{
+	struct stat *stbuf;
+
+	g_print("obexhlp_touch(%s)\n", path);
+
+	stbuf = g_malloc0(sizeof(struct stat));
+	stbuf->st_mode = S_IFREG;
+	g_hash_table_replace(session->file_stat, g_strdup(path), stbuf);
+
+	session->vtouch = TRUE;
+	session->vtouch_path = g_strdup(path);
+}
+
+void obexhlp_touch_real(struct obexhlp_session* session, gchar *path)
+{
+	struct obexhlp_buffer *buffer, *tmpbuf;
+
+	g_print("obexhlp_touch_real(%s)\n", path);
+
+	tmpbuf = session->buffer; /* save buffer state */
+
+	buffer = g_malloc0(sizeof(struct obexhlp_buffer));
+	session->rtouch = TRUE;
+	obexhlp_put(session, buffer, path);
+	session->rtouch = FALSE;
+	g_free(buffer);
+
+	session->buffer = tmpbuf;
+}
diff --git a/fuse/helpers.h b/fuse/helpers.h
index 9080590..4372fdf 100644
--- a/fuse/helpers.h
+++ b/fuse/helpers.h
@@ -57,3 +57,7 @@ struct stat *obexhlp_getattr(struct obexhlp_session* session,
 					const char *path);
 struct obexhlp_buffer *obexhlp_get(struct obexhlp_session* session,
 					const char *path);
+void obexhlp_put(struct obexhlp_session* session,
+					struct obexhlp_buffer *buffer,
+					const char *path);
+void obexhlp_touch(struct obexhlp_session* session, const char *path);
diff --git a/fuse/obexfuse.c b/fuse/obexfuse.c
index e185250..4a9f297 100644
--- a/fuse/obexfuse.c
+++ b/fuse/obexfuse.c
@@ -174,11 +174,72 @@ static int obexfuse_read(const char *path, char *buf, size_t size,
 	return asize;
 }
 
+static int obexfuse_write(const char *path, const char *buf, size_t size,
+				off_t offset, struct fuse_file_info *fi)
+{
+	gsize nsize;
+	struct obexhlp_buffer *file_buffer = (struct obexhlp_buffer*)fi->fh;
+
+	if (file_buffer->size < offset + size) {
+		nsize = offset + size;
+		file_buffer->data = g_realloc(file_buffer->data, nsize);
+		file_buffer->size = nsize;
+	} else {
+		nsize = file_buffer->size;
+	}
+
+	file_buffer->edited = TRUE;
+	memcpy(file_buffer->data + offset, buf, size);
+
+	return size;
+}
+
+static int obexfuse_truncate(const char *path, off_t offset)
+{
+	/*
+	 *  Allow to change the size of a file.
+	 */
+	return 0;
+}
+
+static int obexfuse_release(const char *path, struct fuse_file_info *fi)
+{
+	struct obexhlp_buffer *file_buffer = (struct obexhlp_buffer*)fi->fh;
+
+	if (file_buffer->edited == TRUE)
+		obexhlp_put(session, file_buffer, path); /* send to device */
+
+	g_free(file_buffer->data);
+	g_free(file_buffer);
+
+	return session->status;
+}
+
+static int obexfuse_utimens(const char *path, const struct timespec tv[2])
+{
+	/*
+	 * Important for mknod (touch) operation
+	 */
+	return 0;
+}
+
+static int obexfuse_mknod(const char *path, mode_t mode, dev_t dev)
+{
+	obexhlp_touch(session, path);
+
+	return 0;
+}
+
 static struct fuse_operations obexfuse_oper = {
 	.readdir = obexfuse_readdir,
 	.getattr = obexfuse_getattr,
 	.open = obexfuse_open,
 	.read = obexfuse_read,
+	.write = obexfuse_write,
+	.truncate = obexfuse_truncate,
+	.release = obexfuse_release,
+	.utimens = obexfuse_utimens,
+	.mknod = obexfuse_mknod,
 	.init = obexfuse_init,
 	.destroy = obexfuse_destroy,
 };
-- 
1.7.8.6

