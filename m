Return-Path: <cyrus@holtmann.org>
From: =?UTF-8?q?Micha=C5=82=20Poczwardowski?= <dmp0x7c5@gmail.com>
To: linux-bluetooth@vger.kernel.org
Cc: =?UTF-8?q?Micha=C5=82=20Poczwardowski?= <dmp0x7c5@gmail.com>
Subject: [RFC obexd 11/11] fuse: Add rename operation
Date: Tue,  9 Oct 2012 20:15:56 +0200
Message-Id: <1349806556-1978-11-git-send-email-dmp0x7c5@gmail.com>
In-Reply-To: <1349806556-1978-1-git-send-email-dmp0x7c5@gmail.com>
References: <1349806556-1978-1-git-send-email-dmp0x7c5@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

---
 fuse/gobexfuse.c |   16 ++++++++++++++++
 fuse/helpers.c   |   46 ++++++++++++++++++++++++++++++++++++++++++++++
 fuse/helpers.h   |    3 +++
 3 files changed, 65 insertions(+), 0 deletions(-)

diff --git a/fuse/gobexfuse.c b/fuse/gobexfuse.c
index c45d056..2f6a7c0 100644
--- a/fuse/gobexfuse.c
+++ b/fuse/gobexfuse.c
@@ -237,6 +237,20 @@ static int gobexfuse_unlink(const char *path)
 	return session->status;
 }
 
+static int gobexfuse_mkdir(const char *path, mode_t mode)
+{
+	gobexhlp_mkdir(session, path);
+
+	return session->status;
+}
+
+static int gobexfuse_rename(const char *from, const char *to)
+{
+	gobexhlp_move(session, from, to);
+
+	return session->status;
+}
+
 static struct fuse_operations gobexfuse_oper = {
 	.readdir = gobexfuse_readdir,
 	.getattr = gobexfuse_getattr,
@@ -249,6 +263,8 @@ static struct fuse_operations gobexfuse_oper = {
 	.mknod = gobexfuse_mknod,
 	.unlink = gobexfuse_unlink,
 	.rmdir = gobexfuse_unlink,
+	.mkdir = gobexfuse_mkdir,
+	.rename = gobexfuse_rename,
 	.init = gobexfuse_init,
 	.destroy = gobexfuse_destroy,
 };
diff --git a/fuse/helpers.c b/fuse/helpers.c
index 0ad8cbb..698781a 100644
--- a/fuse/helpers.c
+++ b/fuse/helpers.c
@@ -690,3 +690,49 @@ void gobexhlp_delete(struct gobexhlp_session* session, const char *path)
 	request_wait_free(session);
 }
 
+void gobexhlp_mkdir(struct gobexhlp_session* session, const char *path)
+{
+	struct gobexhlp_location *l;
+	struct stat *stbuf;
+
+	g_print("gobexhlp_mkdir(%s)\n", path);
+
+	l = get_location(path);
+	gobexhlp_setpath(session, l->dir);
+
+	request_new(session, g_strdup_printf("mkdir %s", path));
+	/* g_obex_mkdir also sets path, to new folder */
+	g_obex_mkdir(session->obex, l->file, response_func, session,
+							&session->err);
+	g_free(session->setpath);
+	session->setpath = g_strdup(path);
+
+	stbuf = g_malloc0(sizeof(struct stat));
+	stbuf->st_mode = S_IFDIR;
+	stbuf->st_mtime = time(NULL);
+	g_hash_table_replace(session->file_stat, g_strdup(path), stbuf);
+
+	free_location(l);
+	request_wait_free(session);
+}
+
+void gobexhlp_move(struct gobexhlp_session* session, const char *oldpath,
+						const char* newpath)
+{
+	struct gobexhlp_location *l_from, *l_to;
+
+	l_to = get_location(newpath);
+	l_from = get_location(oldpath);
+	gobexhlp_setpath(session, l_from->dir);
+
+	g_print("gobexhlp_move(%s to %s)\n", l_from->file, l_to->file);
+
+	request_new(session, g_strdup_printf("move %s:%s",
+					oldpath, newpath));
+	g_obex_move(session->obex, l_from->file, l_to->file, response_func,
+						session, &session->err);
+	free_location(l_to);
+	free_location(l_from);
+	request_wait_free(session);
+}
+
diff --git a/fuse/helpers.h b/fuse/helpers.h
index baa6bf1..cc2d9a8 100644
--- a/fuse/helpers.h
+++ b/fuse/helpers.h
@@ -61,4 +61,7 @@ void gobexhlp_put(struct gobexhlp_session* session,
 					const char *path);
 void gobexhlp_touch(struct gobexhlp_session* session, const char *path);
 void gobexhlp_delete(struct gobexhlp_session* session, const char *path);
+void gobexhlp_mkdir(struct gobexhlp_session* session, const char *path);
+void gobexhlp_move(struct gobexhlp_session* session, const char *oldpath,
+					const char* newpath);
 
-- 
1.7.8.6

