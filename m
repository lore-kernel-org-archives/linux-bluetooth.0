Return-Path: <cyrus@holtmann.org>
From: Slawomir Bochenski <lkslawek@gmail.com>
To: linux-bluetooth@vger.kernel.org
Cc: Slawomir Bochenski <lkslawek@gmail.com>
Subject: [PATCH obexd v2 2/2] Fix several issues in FTP action support
Date: Fri,  5 Aug 2011 08:40:31 +0200
Message-Id: <1312526431-5192-1-git-send-email-lkslawek@gmail.com>
In-Reply-To: <1312465504-26373-2-git-send-email-lkslawek@gmail.com>
References: <1312465504-26373-2-git-send-email-lkslawek@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Fixed issues:
- Incorrect handling of absolute path in DestName header
- Possibility of exploiting DestName header to escape FTP plugin root
- Incorrect checking of whether path resides inside FTP root (not
  allowing to move or copy files up)
- Ignoring symbolic links and options regarding them
---
v2: fixed incorrect path verification for DestName

 plugins/ftp.c |   57 +++++++++++++++++++++++++++++++++++++++++++++++++++++----
 1 files changed, 53 insertions(+), 4 deletions(-)

diff --git a/plugins/ftp.c b/plugins/ftp.c
index e191339..fbfdb37 100644
--- a/plugins/ftp.c
+++ b/plugins/ftp.c
@@ -410,18 +410,45 @@ done:
 	return err;
 }
 
+static gboolean is_correct_path(const char *path)
+{
+        gchar **elements;
+        gchar **cur;
+        int depth = 0;
+
+        elements = g_strsplit(path, "/", 0);
+
+        for (cur = elements; *cur != NULL; ++cur) {
+                if (**cur == '\0' || strcmp(*cur, ".") == 0)
+                        continue;
+
+                if (strcmp(*cur, "..") == 0) {
+                        --depth;
+                        if (depth < 0)
+                                break;
+                        continue;
+                }
+
+                ++depth;
+        }
+
+        g_strfreev(elements);
+
+        return depth >= 0 ? TRUE : FALSE;
+}
+
 static char *ftp_build_filename(struct ftp_session *ftp, const char *destname)
 {
 	char *filename;
 
 	/* DestName can either be relative or absolute (FTP style) */
-	if (g_path_is_absolute(destname))
-		filename = g_build_filename(destname, NULL);
+	if (destname[0] == '/')
+		filename = g_build_filename(obex_get_root_folder(ftp->os),
+                                                                destname, NULL);
 	else
 		filename = g_build_filename(ftp->folder, destname, NULL);
 
-	/* Check if destination is inside root path */
-	if (g_str_has_prefix(filename, ftp->folder))
+	if (is_correct_path(filename + strlen(obex_get_root_folder(ftp->os))))
 		return filename;
 
 	g_free(filename);
@@ -434,6 +461,7 @@ static int ftp_copy(struct ftp_session *ftp, const char *name,
 {
 	char *source, *destination;
 	int ret;
+	char *destdir;
 
 	DBG("%p name %s destination %s", ftp, name, destname);
 
@@ -447,6 +475,16 @@ static int ftp_copy(struct ftp_session *ftp, const char *name,
 
 	destination = ftp_build_filename(ftp, destname);
 
+	if (destination == NULL)
+		return -EBADR;
+
+	destdir = g_path_get_dirname(destination);
+	ret = verify_path(destdir);
+	g_free(destdir);
+
+	if (ret < 0)
+		return ret;
+
 	source = g_build_filename(ftp->folder, name, NULL);
 
 	ret = obex_copy(ftp->os, source, destination);
@@ -462,6 +500,7 @@ static int ftp_move(struct ftp_session *ftp, const char *name,
 {
 	char *source, *destination;
 	int ret;
+	char *destdir;
 
 	DBG("%p name %s destname %s", ftp, name, destname);
 
@@ -475,6 +514,16 @@ static int ftp_move(struct ftp_session *ftp, const char *name,
 
 	destination = ftp_build_filename(ftp, destname);
 
+	if (destination == NULL)
+		return -EBADR;
+
+	destdir = g_path_get_dirname(destination);
+	ret = verify_path(destdir);
+	g_free(destdir);
+
+	if (ret < 0)
+		return ret;
+
 	source = g_build_filename(ftp->folder, name, NULL);
 
 	ret = obex_move(ftp->os, source, destination);
-- 
1.7.4.1

