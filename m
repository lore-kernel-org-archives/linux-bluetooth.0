Return-Path: <cyrus@holtmann.org>
From: =?UTF-8?q?Micha=C5=82=20Poczwardowski?= <dmp0x7c5@gmail.com>
To: linux-bluetooth@vger.kernel.org
Cc: =?UTF-8?q?Micha=C5=82=20Poczwardowski?= <dmp0x7c5@gmail.com>
Subject: [RFC obexd 10/11] fuse: Add unlink/rmdir operation
Date: Tue,  9 Oct 2012 20:15:55 +0200
Message-Id: <1349806556-1978-10-git-send-email-dmp0x7c5@gmail.com>
In-Reply-To: <1349806556-1978-1-git-send-email-dmp0x7c5@gmail.com>
References: <1349806556-1978-1-git-send-email-dmp0x7c5@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

---
 fuse/gobexfuse.c |    9 +++++++++
 fuse/helpers.c   |   28 ++++++++++++++++++++++++++++
 fuse/helpers.h   |    1 +
 3 files changed, 38 insertions(+), 0 deletions(-)

diff --git a/fuse/gobexfuse.c b/fuse/gobexfuse.c
index b47d203..c45d056 100644
--- a/fuse/gobexfuse.c
+++ b/fuse/gobexfuse.c
@@ -230,6 +230,13 @@ static int gobexfuse_mknod(const char *path, mode_t mode, dev_t dev)
 	return 0;
 }
 
+static int gobexfuse_unlink(const char *path)
+{
+	gobexhlp_delete(session, path);
+
+	return session->status;
+}
+
 static struct fuse_operations gobexfuse_oper = {
 	.readdir = gobexfuse_readdir,
 	.getattr = gobexfuse_getattr,
@@ -240,6 +247,8 @@ static struct fuse_operations gobexfuse_oper = {
 	.release = gobexfuse_release,
 	.utimens = gobexfuse_utimens,
 	.mknod = gobexfuse_mknod,
+	.unlink = gobexfuse_unlink,
+	.rmdir = gobexfuse_unlink,
 	.init = gobexfuse_init,
 	.destroy = gobexfuse_destroy,
 };
diff --git a/fuse/helpers.c b/fuse/helpers.c
index 05948be..0ad8cbb 100644
--- a/fuse/helpers.c
+++ b/fuse/helpers.c
@@ -618,6 +618,16 @@ void gobexhlp_put(struct gobexhlp_session* session,
 
 	g_print("gobexhlp_put(%s%s)\n", l->dir, l->file);
 
+	if (g_strcmp0(path, session->vtouch_path) == 0 &&
+				session->vtouch == TRUE) {
+		session->vtouch = FALSE;
+		g_free(session->vtouch_path);
+	} else {
+		/* delete existing file */
+		if (session->rtouch == FALSE)
+			gobexhlp_delete(session, path);
+	}
+
 	gobexhlp_setpath(session, l->dir);
 	buffer->tmpsize = 0;
 	session->buffer = buffer;
@@ -662,3 +672,21 @@ void gobexhlp_touch_real(struct gobexhlp_session* session, gchar *path)
 	session->buffer = tmpbuf;
 }
 
+void gobexhlp_delete(struct gobexhlp_session* session, const char *path)
+{
+	struct gobexhlp_location *l;
+	l = get_location(path);
+
+	g_print("gobexhlp_delete(%s)\n", l->file);
+
+	gobexhlp_setpath(session, l->dir);
+	request_new(session, g_strdup_printf("delete %s", path));
+	g_obex_delete(session->obex, l->file, response_func, session,
+							&session->err);
+
+	g_hash_table_remove(session->file_stat, path);
+
+	free_location(l);
+	request_wait_free(session);
+}
+
diff --git a/fuse/helpers.h b/fuse/helpers.h
index da5f96c..baa6bf1 100644
--- a/fuse/helpers.h
+++ b/fuse/helpers.h
@@ -60,4 +60,5 @@ void gobexhlp_put(struct gobexhlp_session* session,
 					struct gobexhlp_buffer *buffer,
 					const char *path);
 void gobexhlp_touch(struct gobexhlp_session* session, const char *path);
+void gobexhlp_delete(struct gobexhlp_session* session, const char *path);
 
-- 
1.7.8.6

