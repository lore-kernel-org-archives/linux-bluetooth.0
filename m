Return-Path: <cyrus@holtmann.org>
From: =?UTF-8?q?Micha=C5=82=20Poczwardowski?= <dmp0x7c5@gmail.com>
To: linux-bluetooth@vger.kernel.org
Cc: =?UTF-8?q?Micha=C5=82=20Poczwardowski?= <dmp0x7c5@gmail.com>
Subject: [RFC obexd 08/11] fuse: Add write operation
Date: Tue,  9 Oct 2012 20:15:53 +0200
Message-Id: <1349806556-1978-8-git-send-email-dmp0x7c5@gmail.com>
In-Reply-To: <1349806556-1978-1-git-send-email-dmp0x7c5@gmail.com>
References: <1349806556-1978-1-git-send-email-dmp0x7c5@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

---
 fuse/gobexfuse.c |   44 ++++++++++++++++++++++++++++++++++++++++++++
 fuse/helpers.c   |   45 +++++++++++++++++++++++++++++++++++++++++++++
 fuse/helpers.h   |    3 +++
 3 files changed, 92 insertions(+), 0 deletions(-)

diff --git a/fuse/gobexfuse.c b/fuse/gobexfuse.c
index 446a757..a49a8f9 100644
--- a/fuse/gobexfuse.c
+++ b/fuse/gobexfuse.c
@@ -174,11 +174,55 @@ static int gobexfuse_read(const char *path, char *buf, size_t size,
 	return asize;
 }
 
+static int gobexfuse_write(const char *path, const char *buf, size_t size,
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
+static int gobexfuse_truncate(const char *path, off_t offset)
+{
+	/*
+	 *  Allow to change the size of a file.
+	 */
+	return 0;
+}
+
+static int gobexfuse_release(const char *path, struct fuse_file_info *fi)
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
 static struct fuse_operations gobexfuse_oper = {
 	.readdir = gobexfuse_readdir,
 	.getattr = gobexfuse_getattr,
 	.open = gobexfuse_open,
 	.read = gobexfuse_read,
+	.write = gobexfuse_write,
+	.truncate = gobexfuse_truncate,
+	.release = gobexfuse_release,
 	.init = gobexfuse_init,
 	.destroy = gobexfuse_destroy,
 };
diff --git a/fuse/helpers.c b/fuse/helpers.c
index 9b453e0..b807f15 100644
--- a/fuse/helpers.c
+++ b/fuse/helpers.c
@@ -577,3 +577,48 @@ struct gobexhlp_buffer *gobexhlp_get(struct gobexhlp_session* session,
 
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
+
diff --git a/fuse/helpers.h b/fuse/helpers.h
index 50c750d..95987c4 100644
--- a/fuse/helpers.h
+++ b/fuse/helpers.h
@@ -56,4 +56,7 @@ struct stat *gobexhlp_getattr(struct gobexhlp_session* session,
 					const char *path);
 struct gobexhlp_buffer *gobexhlp_get(struct gobexhlp_session* session,
 					const char *path);
+void gobexhlp_put(struct gobexhlp_session* session,
+					struct gobexhlp_buffer *buffer,
+					const char *path);
 
-- 
1.7.8.6

