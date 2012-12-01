Return-Path: <cyrus@holtmann.org>
From: =?UTF-8?q?Micha=C5=82=20Poczwardowski?= <dmp0x7c5@gmail.com>
To: linux-bluetooth@vger.kernel.org
Cc: =?UTF-8?q?Micha=C5=82=20Poczwardowski?= <dmp0x7c5@gmail.com>
Subject: [RFC v3 obexd 10/10] fuse: Add rename operation
Date: Sun,  2 Dec 2012 00:14:55 +0100
Message-Id: <1354403695-18985-10-git-send-email-dmp0x7c5@gmail.com>
In-Reply-To: <1354403695-18985-1-git-send-email-dmp0x7c5@gmail.com>
References: <1354403695-18985-1-git-send-email-dmp0x7c5@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

---
 fuse/helpers.c  |   46 ++++++++++++++++++++++++++++++++++++++++++++++
 fuse/helpers.h  |    3 +++
 fuse/obexfuse.c |   16 ++++++++++++++++
 3 files changed, 65 insertions(+), 0 deletions(-)

diff --git a/fuse/helpers.c b/fuse/helpers.c
index a523cc3..e45591d 100644
--- a/fuse/helpers.c
+++ b/fuse/helpers.c
@@ -736,3 +736,49 @@ void obexhlp_delete(struct obexhlp_session* session, const char *path)
 	free_location(l);
 	request_wait_free(session);
 }
+
+void obexhlp_mkdir(struct obexhlp_session* session, const char *path)
+{
+	struct obexhlp_location *l;
+	struct stat *stbuf;
+
+	g_print("obexhlp_mkdir(%s)\n", path);
+
+	l = get_location(path);
+	obexhlp_setpath(session, l->dir);
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
+void obexhlp_move(struct obexhlp_session* session, const char *oldpath,
+						const char* newpath)
+{
+	struct obexhlp_location *l_from, *l_to;
+
+	l_to = get_location(newpath);
+	l_from = get_location(oldpath);
+	obexhlp_setpath(session, l_from->dir);
+
+	g_print("obexhlp_move(%s to %s)\n", l_from->file, l_to->file);
+
+	request_new(session, g_strdup_printf("move %s:%s",
+					oldpath, newpath));
+	g_obex_move(session->obex, l_from->file, l_to->file, response_func,
+						session, &session->err);
+	free_location(l_to);
+	free_location(l_from);
+	request_wait_free(session);
+}
diff --git a/fuse/helpers.h b/fuse/helpers.h
index 362e322..5ace3ea 100644
--- a/fuse/helpers.h
+++ b/fuse/helpers.h
@@ -62,3 +62,6 @@ void obexhlp_put(struct obexhlp_session* session,
 					const char *path);
 void obexhlp_touch(struct obexhlp_session* session, const char *path);
 void obexhlp_delete(struct obexhlp_session* session, const char *path);
+void obexhlp_mkdir(struct obexhlp_session* session, const char *path);
+void obexhlp_move(struct obexhlp_session* session, const char *oldpath,
+					const char* newpath);
diff --git a/fuse/obexfuse.c b/fuse/obexfuse.c
index 065b6a6..a08f720 100644
--- a/fuse/obexfuse.c
+++ b/fuse/obexfuse.c
@@ -237,6 +237,20 @@ static int obexfuse_unlink(const char *path)
 	return session->status;
 }
 
+static int obexfuse_mkdir(const char *path, mode_t mode)
+{
+	obexhlp_mkdir(session, path);
+
+	return session->status;
+}
+
+static int obexfuse_rename(const char *from, const char *to)
+{
+	obexhlp_move(session, from, to);
+
+	return session->status;
+}
+
 static struct fuse_operations obexfuse_oper = {
 	.readdir = obexfuse_readdir,
 	.getattr = obexfuse_getattr,
@@ -249,6 +263,8 @@ static struct fuse_operations obexfuse_oper = {
 	.mknod = obexfuse_mknod,
 	.unlink = obexfuse_unlink,
 	.rmdir = obexfuse_unlink,
+	.mkdir = obexfuse_mkdir,
+	.rename = obexfuse_rename,
 	.init = obexfuse_init,
 	.destroy = obexfuse_destroy,
 };
-- 
1.7.8.6

