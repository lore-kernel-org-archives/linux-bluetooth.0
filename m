Return-Path: <cyrus@holtmann.org>
From: =?UTF-8?q?Micha=C5=82=20Poczwardowski?= <dmp0x7c5@gmail.com>
To: linux-bluetooth@vger.kernel.org
Cc: =?UTF-8?q?Micha=C5=82=20Poczwardowski?= <dmp0x7c5@gmail.com>
Subject: [RFC v3 obexd 09/10] fuse: Add unlink/rmdir operation
Date: Sun,  2 Dec 2012 00:14:54 +0100
Message-Id: <1354403695-18985-9-git-send-email-dmp0x7c5@gmail.com>
In-Reply-To: <1354403695-18985-1-git-send-email-dmp0x7c5@gmail.com>
References: <1354403695-18985-1-git-send-email-dmp0x7c5@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

---
 fuse/helpers.c  |   28 ++++++++++++++++++++++++++++
 fuse/helpers.h  |    1 +
 fuse/obexfuse.c |    9 +++++++++
 3 files changed, 38 insertions(+), 0 deletions(-)

diff --git a/fuse/helpers.c b/fuse/helpers.c
index b4bd7e5..a523cc3 100644
--- a/fuse/helpers.c
+++ b/fuse/helpers.c
@@ -665,6 +665,16 @@ void obexhlp_put(struct obexhlp_session* session,
 
 	g_print("obexhlp_put(%s%s)\n", l->dir, l->file);
 
+	if (g_strcmp0(path, session->vtouch_path) == 0 &&
+				session->vtouch == TRUE) {
+		session->vtouch = FALSE;
+		g_free(session->vtouch_path);
+	} else {
+		/* delete existing file */
+		if (session->rtouch == FALSE)
+			obexhlp_delete(session, path);
+	}
+
 	obexhlp_setpath(session, l->dir);
 	buffer->tmpsize = 0;
 	session->buffer = buffer;
@@ -708,3 +718,21 @@ void obexhlp_touch_real(struct obexhlp_session* session, gchar *path)
 
 	session->buffer = tmpbuf;
 }
+
+void obexhlp_delete(struct obexhlp_session* session, const char *path)
+{
+	struct obexhlp_location *l;
+	l = get_location(path);
+
+	g_print("obexhlp_delete(%s)\n", l->file);
+
+	obexhlp_setpath(session, l->dir);
+	request_new(session, g_strdup_printf("delete %s", path));
+	g_obex_delete(session->obex, l->file, response_func, session,
+							&session->err);
+
+	g_hash_table_remove(session->file_stat, path);
+
+	free_location(l);
+	request_wait_free(session);
+}
diff --git a/fuse/helpers.h b/fuse/helpers.h
index 4372fdf..362e322 100644
--- a/fuse/helpers.h
+++ b/fuse/helpers.h
@@ -61,3 +61,4 @@ void obexhlp_put(struct obexhlp_session* session,
 					struct obexhlp_buffer *buffer,
 					const char *path);
 void obexhlp_touch(struct obexhlp_session* session, const char *path);
+void obexhlp_delete(struct obexhlp_session* session, const char *path);
diff --git a/fuse/obexfuse.c b/fuse/obexfuse.c
index 4a9f297..065b6a6 100644
--- a/fuse/obexfuse.c
+++ b/fuse/obexfuse.c
@@ -230,6 +230,13 @@ static int obexfuse_mknod(const char *path, mode_t mode, dev_t dev)
 	return 0;
 }
 
+static int obexfuse_unlink(const char *path)
+{
+	obexhlp_delete(session, path);
+
+	return session->status;
+}
+
 static struct fuse_operations obexfuse_oper = {
 	.readdir = obexfuse_readdir,
 	.getattr = obexfuse_getattr,
@@ -240,6 +247,8 @@ static struct fuse_operations obexfuse_oper = {
 	.release = obexfuse_release,
 	.utimens = obexfuse_utimens,
 	.mknod = obexfuse_mknod,
+	.unlink = obexfuse_unlink,
+	.rmdir = obexfuse_unlink,
 	.init = obexfuse_init,
 	.destroy = obexfuse_destroy,
 };
-- 
1.7.8.6

