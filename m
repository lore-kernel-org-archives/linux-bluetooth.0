Return-Path: <cyrus@holtmann.org>
From: =?UTF-8?q?Micha=C5=82=20Poczwardowski?= <dmp0x7c5@gmail.com>
To: linux-bluetooth@vger.kernel.org
Cc: =?UTF-8?q?Micha=C5=82=20Poczwardowski?= <dmp0x7c5@gmail.com>
Subject: [RFC v3 obexd 07/10] fuse: Add open and read operations plus location helpers
Date: Sun,  2 Dec 2012 00:14:52 +0100
Message-Id: <1354403695-18985-7-git-send-email-dmp0x7c5@gmail.com>
In-Reply-To: <1354403695-18985-1-git-send-email-dmp0x7c5@gmail.com>
References: <1354403695-18985-1-git-send-email-dmp0x7c5@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

---
 fuse/helpers.c  |   62 +++++++++++++++++++++++++++++++++++++++++++++++++++++++
 fuse/helpers.h  |    2 +
 fuse/obexfuse.c |   32 ++++++++++++++++++++++++++++
 3 files changed, 96 insertions(+), 0 deletions(-)

diff --git a/fuse/helpers.c b/fuse/helpers.c
index 4e4747d..72b0b3e 100644
--- a/fuse/helpers.c
+++ b/fuse/helpers.c
@@ -562,3 +562,65 @@ struct stat *obexhlp_getattr(struct obexhlp_session* session,
 {
 	return g_hash_table_lookup(session->file_stat, path);
 }
+
+static struct obexhlp_location *get_location(const char *path)
+{
+	struct obexhlp_location *location;
+	gchar **directories;
+	guint i, len, fid = 0;
+
+	location = g_malloc0(sizeof(*location));
+	directories = g_strsplit(path, "/", -1);
+	len = g_strv_length(directories);
+
+	for (i = 0; i < len; i++)
+		if (directories[i][0] != '\0') /* protect multi slashes */
+			fid = i; /* last nonempty is a file */
+
+	location->file = g_strdup(directories[fid]);
+	directories[fid][0] = '\0'; /* remove file */
+	location->dir = g_strjoinv("/", directories);
+
+	g_strfreev(directories);
+
+	return location;
+}
+
+void free_location(struct obexhlp_location *location)
+{
+	g_free(location->file);
+	g_free(location->dir);
+	g_free(location);
+}
+
+struct obexhlp_buffer *obexhlp_get(struct obexhlp_session* session,
+						const char *path)
+{
+	struct obexhlp_location *l;
+	struct obexhlp_buffer *buffer;
+	struct stat *stfile;
+	l = get_location(path);
+
+	g_print("obexhlp_get(%s%s)\n", l->dir, l->file);
+
+	stfile = obexhlp_getattr(session, path);
+	if (stfile == NULL)
+		return NULL;
+
+	buffer = g_malloc0(sizeof(*buffer));
+
+	if (stfile->st_size == 0)
+		return buffer;
+
+	obexhlp_setpath(session, l->dir);
+	request_new(session, g_strdup_printf("get %s", path));
+	session->buffer = buffer;
+	g_obex_get_req(session->obex, async_get_consumer,
+					complete_func, session, &session->err,
+					G_OBEX_HDR_NAME, l->file,
+					G_OBEX_HDR_INVALID);
+	free_location(l);
+	request_wait_free(session);
+
+	return buffer;
+}
diff --git a/fuse/helpers.h b/fuse/helpers.h
index 0435317..9080590 100644
--- a/fuse/helpers.h
+++ b/fuse/helpers.h
@@ -55,3 +55,5 @@ void obexhlp_disconnect(struct obexhlp_session* session);
 GList *obexhlp_listfolder(struct obexhlp_session* session, const char *path);
 struct stat *obexhlp_getattr(struct obexhlp_session* session,
 					const char *path);
+struct obexhlp_buffer *obexhlp_get(struct obexhlp_session* session,
+					const char *path);
diff --git a/fuse/obexfuse.c b/fuse/obexfuse.c
index 5270293..e185250 100644
--- a/fuse/obexfuse.c
+++ b/fuse/obexfuse.c
@@ -144,9 +144,41 @@ static int obexfuse_getattr(const char *path, struct stat *stbuf)
 	return res;
 }
 
+static int obexfuse_open(const char *path, struct fuse_file_info *fi)
+{
+	struct obexhlp_buffer *file_buffer;
+
+	file_buffer = obexhlp_get(session, path);
+
+	if (file_buffer == NULL)
+		return -ENOENT;
+
+	fi->fh = (uint64_t)file_buffer;
+
+	return session->status;
+}
+
+static int obexfuse_read(const char *path, char *buf, size_t size,
+			off_t offset, struct fuse_file_info *fi)
+{
+	gsize asize;
+	struct obexhlp_buffer *file_buffer = (struct obexhlp_buffer*)fi->fh;
+
+	asize = file_buffer->size - offset;
+
+	if (asize > size)
+		asize = size;
+
+	memcpy(buf, file_buffer->data + offset, asize);
+
+	return asize;
+}
+
 static struct fuse_operations obexfuse_oper = {
 	.readdir = obexfuse_readdir,
 	.getattr = obexfuse_getattr,
+	.open = obexfuse_open,
+	.read = obexfuse_read,
 	.init = obexfuse_init,
 	.destroy = obexfuse_destroy,
 };
-- 
1.7.8.6

