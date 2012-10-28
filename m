Return-Path: <cyrus@holtmann.org>
From: =?UTF-8?q?Micha=C5=82=20Poczwardowski?= <dmp0x7c5@gmail.com>
To: linux-bluetooth@vger.kernel.org
Cc: =?UTF-8?q?Micha=C5=82=20Poczwardowski?= <dmp0x7c5@gmail.com>
Subject: [RFC v2 obexd 09/11] fuse: Add touch operation
Date: Sun, 28 Oct 2012 02:29:24 +0200
Message-Id: <1351384166-15586-9-git-send-email-dmp0x7c5@gmail.com>
In-Reply-To: <1351384166-15586-1-git-send-email-dmp0x7c5@gmail.com>
References: <1351384166-15586-1-git-send-email-dmp0x7c5@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

---
 fuse/helpers.c  |   40 ++++++++++++++++++++++++++++++++++++++++
 fuse/helpers.h  |    1 +
 fuse/obexfuse.c |   17 +++++++++++++++++
 3 files changed, 58 insertions(+), 0 deletions(-)

diff --git a/fuse/helpers.c b/fuse/helpers.c
index 796c4a3..cabf8f7 100644
--- a/fuse/helpers.c
+++ b/fuse/helpers.c
@@ -56,6 +56,8 @@ struct gobexhlp_location {
 	gchar *file;
 };
 
+void gobexhlp_touch_real(struct gobexhlp_session* session, gchar *path);
+
 static uint16_t find_rfcomm_uuid(void *user_data)
 {
 	sdp_list_t *pds = (sdp_list_t*) user_data;
@@ -279,6 +281,12 @@ void request_new(struct gobexhlp_session *session,
 {
 	g_print("REQUEST %s\n", name);
 
+	if (session->vtouch == TRUE) {
+		session->vtouch = FALSE;
+		gobexhlp_touch_real(session, session->vtouch_path);
+		g_free(session->vtouch_path);
+	}
+
 	if (session->request != NULL)
 		g_error("Another request (%s) active!\n",
 					session->request->name);
@@ -621,3 +629,35 @@ void gobexhlp_put(struct gobexhlp_session* session,
 	free_location(l);
 	request_wait_free(session);
 }
+
+/* virtual file creation */
+void gobexhlp_touch(struct gobexhlp_session* session, const char *path)
+{
+	struct stat *stbuf;
+
+	g_print("gobexhlp_touch(%s)\n", path);
+
+	stbuf = g_malloc0(sizeof(struct stat));
+	stbuf->st_mode = S_IFREG;
+	g_hash_table_replace(session->file_stat, g_strdup(path), stbuf);
+
+	session->vtouch = TRUE;
+	session->vtouch_path = g_strdup(path);
+}
+
+void gobexhlp_touch_real(struct gobexhlp_session* session, gchar *path)
+{
+	struct gobexhlp_buffer *buffer, *tmpbuf;
+
+	g_print("gobexhlp_touch_real(%s)\n", path);
+
+	tmpbuf = session->buffer; /* save buffer state */
+
+	buffer = g_malloc0(sizeof(struct gobexhlp_buffer));
+	session->rtouch = TRUE;
+	gobexhlp_put(session, buffer, path);
+	session->rtouch = FALSE;
+	g_free(buffer);
+
+	session->buffer = tmpbuf;
+}
diff --git a/fuse/helpers.h b/fuse/helpers.h
index 1eca29d..c2b28ca 100644
--- a/fuse/helpers.h
+++ b/fuse/helpers.h
@@ -59,3 +59,4 @@ struct gobexhlp_buffer *gobexhlp_get(struct gobexhlp_session* session,
 void gobexhlp_put(struct gobexhlp_session* session,
 					struct gobexhlp_buffer *buffer,
 					const char *path);
+void gobexhlp_touch(struct gobexhlp_session* session, const char *path);
diff --git a/fuse/obexfuse.c b/fuse/obexfuse.c
index 900e6d7..b4599d8 100644
--- a/fuse/obexfuse.c
+++ b/fuse/obexfuse.c
@@ -215,6 +215,21 @@ static int obexfuse_release(const char *path, struct fuse_file_info *fi)
 	return session->status;
 }
 
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
+	gobexhlp_touch(session, path);
+
+	return 0;
+}
+
 static struct fuse_operations obexfuse_oper = {
 	.readdir = obexfuse_readdir,
 	.getattr = obexfuse_getattr,
@@ -223,6 +238,8 @@ static struct fuse_operations obexfuse_oper = {
 	.write = obexfuse_write,
 	.truncate = obexfuse_truncate,
 	.release = obexfuse_release,
+	.utimens = obexfuse_utimens,
+	.mknod = obexfuse_mknod,
 	.init = obexfuse_init,
 	.destroy = obexfuse_destroy,
 };
-- 
1.7.8.6

