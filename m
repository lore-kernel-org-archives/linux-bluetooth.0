Return-Path: <cyrus@holtmann.org>
From: =?UTF-8?q?Micha=C5=82=20Poczwardowski?= <dmp0x7c5@gmail.com>
To: linux-bluetooth@vger.kernel.org
Cc: =?UTF-8?q?Micha=C5=82=20Poczwardowski?= <dmp0x7c5@gmail.com>
Subject: [RFC v2 obexd 08/11] fuse: Add write operation
Date: Sun, 28 Oct 2012 02:29:23 +0200
Message-Id: <1351384166-15586-8-git-send-email-dmp0x7c5@gmail.com>
In-Reply-To: <1351384166-15586-1-git-send-email-dmp0x7c5@gmail.com>
References: <1351384166-15586-1-git-send-email-dmp0x7c5@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

---
 fuse/helpers.c  |   44 ++++++++++++++++++++++++++++++++++++++++++++
 fuse/helpers.h  |    3 +++
 fuse/obexfuse.c |   44 ++++++++++++++++++++++++++++++++++++++++++++
 3 files changed, 91 insertions(+), 0 deletions(-)

diff --git a/fuse/helpers.c b/fuse/helpers.c
index 9b453e0..796c4a3 100644
--- a/fuse/helpers.c
+++ b/fuse/helpers.c
@@ -577,3 +577,47 @@ struct gobexhlp_buffer *gobexhlp_get(struct gobexhlp_session* session,
 
 	return buffer;
 }
+
+static gssize async_put_producer(void *buf, gsize len, gpointer user_data)
+{
+	gssize size;
+	struct gobexhlp_session *session = user_data;
+	struct gobexhlp_buffer *buffer = session->buffer;
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
+void gobexhlp_put(struct gobexhlp_session* session,
+				struct gobexhlp_buffer *buffer,
+				const char *path)
+{
+	struct gobexhlp_location *l;
+	l = get_location(path);
+
+	g_print("gobexhlp_put(%s%s)\n", l->dir, l->file);
+
+	gobexhlp_setpath(session, l->dir);
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
diff --git a/fuse/helpers.h b/fuse/helpers.h
index aa2a194..1eca29d 100644
--- a/fuse/helpers.h
+++ b/fuse/helpers.h
@@ -56,3 +56,6 @@ struct stat *gobexhlp_getattr(struct gobexhlp_session* session,
 					const char *path);
 struct gobexhlp_buffer *gobexhlp_get(struct gobexhlp_session* session,
 					const char *path);
+void gobexhlp_put(struct gobexhlp_session* session,
+					struct gobexhlp_buffer *buffer,
+					const char *path);
diff --git a/fuse/obexfuse.c b/fuse/obexfuse.c
index 9fe2dea..900e6d7 100644
--- a/fuse/obexfuse.c
+++ b/fuse/obexfuse.c
@@ -174,11 +174,55 @@ static int obexfuse_read(const char *path, char *buf, size_t size,
 	return asize;
 }
 
+static int obexfuse_write(const char *path, const char *buf, size_t size,
+				off_t offset, struct fuse_file_info *fi)
+{
+	gsize nsize;
+	struct gobexhlp_buffer *file_buffer = (struct gobexhlp_buffer*)fi->fh;
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
+	struct gobexhlp_buffer *file_buffer = (struct gobexhlp_buffer*)fi->fh;
+
+	if (file_buffer->edited == TRUE)
+		gobexhlp_put(session, file_buffer, path); /* send to device */
+
+	g_free(file_buffer->data);
+	g_free(file_buffer);
+
+	return session->status;
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
 	.init = obexfuse_init,
 	.destroy = obexfuse_destroy,
 };
-- 
1.7.8.6

