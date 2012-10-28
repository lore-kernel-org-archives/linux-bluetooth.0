Return-Path: <cyrus@holtmann.org>
From: =?UTF-8?q?Micha=C5=82=20Poczwardowski?= <dmp0x7c5@gmail.com>
To: linux-bluetooth@vger.kernel.org
Cc: =?UTF-8?q?Micha=C5=82=20Poczwardowski?= <dmp0x7c5@gmail.com>
Subject: [RFC v2 obexd 06/11] fuse: Add getattr operation
Date: Sun, 28 Oct 2012 02:29:21 +0200
Message-Id: <1351384166-15586-6-git-send-email-dmp0x7c5@gmail.com>
In-Reply-To: <1351384166-15586-1-git-send-email-dmp0x7c5@gmail.com>
References: <1351384166-15586-1-git-send-email-dmp0x7c5@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

---
 fuse/helpers.c  |    6 ++++++
 fuse/helpers.h  |    2 ++
 fuse/obexfuse.c |   34 ++++++++++++++++++++++++++++++++++
 3 files changed, 42 insertions(+), 0 deletions(-)

diff --git a/fuse/helpers.c b/fuse/helpers.c
index cb0b51d..a10b706 100644
--- a/fuse/helpers.c
+++ b/fuse/helpers.c
@@ -509,3 +509,9 @@ GList *gobexhlp_listfolder(struct gobexhlp_session* session,
 
 	return session->lsfiles;
 }
+
+struct stat *gobexhlp_getattr(struct gobexhlp_session* session,
+					const char *path)
+{
+	return g_hash_table_lookup(session->file_stat, path);
+}
diff --git a/fuse/helpers.h b/fuse/helpers.h
index 546d79c..047abae 100644
--- a/fuse/helpers.h
+++ b/fuse/helpers.h
@@ -52,3 +52,5 @@ struct gobexhlp_session* gobexhlp_connect(const char *srcstr,
 void gobexhlp_disconnect(struct gobexhlp_session* session);
 
 GList *gobexhlp_listfolder(struct gobexhlp_session* session, const char *path);
+struct stat *gobexhlp_getattr(struct gobexhlp_session* session,
+					const char *path);
diff --git a/fuse/obexfuse.c b/fuse/obexfuse.c
index 5de82ec..f4e85fa 100644
--- a/fuse/obexfuse.c
+++ b/fuse/obexfuse.c
@@ -111,8 +111,42 @@ static int obexfuse_readdir(const char *path, void *buf,
 	return session->status;
 }
 
+static int obexfuse_getattr(const char *path, struct stat *stbuf)
+{
+	int res = 0;
+	struct stat *stfile;
+
+	memset(stbuf, 0, sizeof(struct stat));
+
+	if (strcmp(path, "/") == 0) {
+		stbuf->st_mode = S_IFDIR | 0755;
+		stbuf->st_nlink = 2;
+	} else {
+		stfile = gobexhlp_getattr(session, path);
+
+		if (stfile == NULL)
+			return -ENOENT;
+
+		if (stfile->st_mode == S_IFREG)
+			stbuf->st_mode = stfile->st_mode | 0666;
+		else /* S_IFDIR */
+			stbuf->st_mode = stfile->st_mode | 0755;
+
+		stbuf->st_nlink = 1;
+		stbuf->st_size = stfile->st_size;
+		stbuf->st_mtime = stbuf->st_atime = stbuf->st_ctime =
+						stfile->st_mtime;
+		stbuf->st_blksize = 512;
+		stbuf->st_blocks = (stbuf->st_size + stbuf->st_blksize)
+						/ stbuf->st_blksize;
+	}
+
+	return res;
+}
+
 static struct fuse_operations obexfuse_oper = {
 	.readdir = obexfuse_readdir,
+	.getattr = obexfuse_getattr,
 	.init = obexfuse_init,
 	.destroy = obexfuse_destroy,
 };
-- 
1.7.8.6

