Return-Path: <cyrus@holtmann.org>
From: =?UTF-8?q?Micha=C5=82=20Poczwardowski?= <dmp0x7c5@gmail.com>
To: linux-bluetooth@vger.kernel.org
Cc: =?UTF-8?q?Micha=C5=82=20Poczwardowski?= <dmp0x7c5@gmail.com>
Subject: [RFC obexd 06/11] fuse: Add getattr operation
Date: Tue,  9 Oct 2012 20:15:51 +0200
Message-Id: <1349806556-1978-6-git-send-email-dmp0x7c5@gmail.com>
In-Reply-To: <1349806556-1978-1-git-send-email-dmp0x7c5@gmail.com>
References: <1349806556-1978-1-git-send-email-dmp0x7c5@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

---
 fuse/gobexfuse.c |   34 ++++++++++++++++++++++++++++++++++
 fuse/helpers.c   |    6 ++++++
 fuse/helpers.h   |    2 ++
 3 files changed, 42 insertions(+), 0 deletions(-)

diff --git a/fuse/gobexfuse.c b/fuse/gobexfuse.c
index 2bdfc09..c886176 100644
--- a/fuse/gobexfuse.c
+++ b/fuse/gobexfuse.c
@@ -111,8 +111,42 @@ static int gobexfuse_readdir(const char *path, void *buf,
 	return session->status;
 }
 
+static int gobexfuse_getattr(const char *path, struct stat *stbuf)
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
 static struct fuse_operations gobexfuse_oper = {
 	.readdir = gobexfuse_readdir,
+	.getattr = gobexfuse_getattr,
 	.init = gobexfuse_init,
 	.destroy = gobexfuse_destroy,
 };
diff --git a/fuse/helpers.c b/fuse/helpers.c
index 1d3faa5..249d0c9 100644
--- a/fuse/helpers.c
+++ b/fuse/helpers.c
@@ -510,3 +510,9 @@ GList *gobexhlp_listfolder(struct gobexhlp_session* session,
 	return session->lsfiles;
 }
 
+struct stat *gobexhlp_getattr(struct gobexhlp_session* session,
+					const char *path)
+{
+	return g_hash_table_lookup(session->file_stat, path);
+}
+
diff --git a/fuse/helpers.h b/fuse/helpers.h
index 84238c9..0a0f366 100644
--- a/fuse/helpers.h
+++ b/fuse/helpers.h
@@ -52,5 +52,7 @@ struct gobexhlp_session* gobexhlp_connect(const char *srcstr,
 void gobexhlp_disconnect(struct gobexhlp_session* session);
 
 GList *gobexhlp_listfolder(struct gobexhlp_session* session, const char *path);
+struct stat *gobexhlp_getattr(struct gobexhlp_session* session,
+					const char *path);
 
 
-- 
1.7.8.6

