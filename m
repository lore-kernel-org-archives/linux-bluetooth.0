Return-Path: <cyrus@holtmann.org>
From: Slawomir Bochenski <lkslawek@gmail.com>
To: linux-bluetooth@vger.kernel.org
Cc: Slawomir Bochenski <lkslawek@gmail.com>
Subject: [PATCH obexd 1/2] Simplify symbolic links support
Date: Thu,  4 Aug 2011 15:45:03 +0200
Message-Id: <1312465504-26373-1-git-send-email-lkslawek@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

This patch changes the way the symbolic links are treated by FTP, making code a
bit simpler and FTP more intuitive.

Previously symlinks were supposed to be disallowed unless the -l option was
used, and with that option, only symlinks present directly inside root folder
were followed. This did not work for file links, as fstat() check on open()-ed
won't result in S_IFLNK set, so symbolic links to files were followed
regardless to options.

Now links inside root folder are always allowed. Without -l (--symlinks)
option, following them is only allowed when the resulting real path is still
inside the given root directory. When -l is given, all symlinks are followed.
---
 plugins/filesystem.c |   66 ++++++++++++++++++++++++++++---------------------
 plugins/filesystem.h |    1 +
 plugins/ftp.c        |   13 +++++----
 src/main.c           |    3 +-
 4 files changed, 48 insertions(+), 35 deletions(-)

diff --git a/plugins/filesystem.c b/plugins/filesystem.c
index 8d1d74b..b05dc3a 100644
--- a/plugins/filesystem.c
+++ b/plugins/filesystem.c
@@ -101,6 +101,27 @@ gboolean is_filename(const char *name)
 	return TRUE;
 }
 
+int verify_path(const char *path)
+{
+	char *t;
+	int ret = 0;
+
+	if (obex_option_symlinks())
+		return 0;
+
+	t = realpath(path, NULL);
+
+	if (t == NULL)
+		return -errno;
+
+	if (!g_str_has_prefix(t, obex_option_root_folder()))
+		ret = -EPERM;
+
+	free(t);
+
+	return ret;
+}
+
 static char *file_stat_line(char *filename, struct stat *fstat,
 					struct stat *dstat, gboolean root,
 					gboolean pcsuite)
@@ -149,11 +170,9 @@ static void *filesystem_open(const char *name, int oflag, mode_t mode,
 {
 	struct stat stats;
 	struct statvfs buf;
-	const char *root_folder;
-	char *folder;
-	gboolean root;
 	int fd = open(name, oflag, mode);
 	uint64_t avail;
+	int ret;
 
 	if (fd < 0) {
 		if (err)
@@ -167,19 +186,11 @@ static void *filesystem_open(const char *name, int oflag, mode_t mode,
 		goto failed;
 	}
 
-	root_folder = obex_option_root_folder();
-	folder = g_path_get_dirname(name);
-	root = g_strcmp0(folder, root_folder);
-
-	g_free(folder);
-
-	if (!root || obex_option_symlinks()) {
-		if (S_ISLNK(stats.st_mode)) {
-			if (err)
-				*err = -EPERM;
-			goto failed;
-		}
-
+	ret = verify_path(name);
+	if (ret < 0) {
+		if (err)
+			*err = ret;
+		goto failed;
 	}
 
 	if (oflag == O_RDONLY) {
@@ -467,7 +478,7 @@ static GString *append_listing(GString *object, const char *name,
 	struct stat fstat, dstat;
 	struct dirent *ep;
 	DIR *dp;
-	gboolean root, symlinks;
+	gboolean root;
 	int ret;
 
 	root = g_str_equal(name, obex_option_root_folder());
@@ -479,14 +490,17 @@ static GString *append_listing(GString *object, const char *name,
 		goto failed;
 	}
 
-	symlinks = obex_option_symlinks();
-	if (root && symlinks)
-		ret = stat(name, &dstat);
-	else {
+	if (root)
 		object = g_string_append(object, FL_PARENT_FOLDER_ELEMENT);
-		ret = lstat(name, &dstat);
+
+	ret = verify_path(name);
+	if (ret < 0) {
+		*err = ret;
+		goto failed;
 	}
 
+	ret = stat(name, &dstat);
+
 	if (ret < 0) {
 		if (err)
 			*err = -errno;
@@ -509,14 +523,10 @@ static GString *append_listing(GString *object, const char *name,
 
 		fullname = g_build_filename(name, ep->d_name, NULL);
 
-		if (root && symlinks)
-			ret = stat(fullname, &fstat);
-		else
-			ret = lstat(fullname, &fstat);
+		ret = stat(fullname, &fstat);
 
 		if (ret < 0) {
-			DBG("%s: %s(%d)", root ? "stat" : "lstat",
-					strerror(errno), errno);
+			DBG("stat: %s(%d)", strerror(errno), errno);
 			g_free(filename);
 			g_free(fullname);
 			continue;
diff --git a/plugins/filesystem.h b/plugins/filesystem.h
index 3c6d2c1..f95773b 100644
--- a/plugins/filesystem.h
+++ b/plugins/filesystem.h
@@ -23,3 +23,4 @@
 
 ssize_t string_read(void *object, void *buf, size_t count);
 gboolean is_filename(const char *name);
+int verify_path(const char *path);
diff --git a/plugins/ftp.c b/plugins/ftp.c
index b0ef540..e191339 100644
--- a/plugins/ftp.c
+++ b/plugins/ftp.c
@@ -363,10 +363,12 @@ int ftp_setpath(struct obex_session *os, obex_object_t *obj, void *user_data)
 
 	DBG("Fullname: %s", fullname);
 
-	if (root && obex_get_symlinks(os))
-		err = stat(fullname, &dstat);
-	else
-		err = lstat(fullname, &dstat);
+	err = verify_path(fullname);
+
+	if (err < 0)
+		goto done;
+
+	err = stat(fullname, &dstat);
 
 	if (err < 0) {
 		err = -errno;
@@ -374,8 +376,7 @@ int ftp_setpath(struct obex_session *os, obex_object_t *obj, void *user_data)
 		if (err == -ENOENT)
 			goto not_found;
 
-		DBG("%s: %s(%d)", root ? "stat" : "lstat",
-				strerror(-err), -err);
+		DBG("stat: %s(%d)", strerror(-err), -err);
 
 		goto done;
 	}
diff --git a/src/main.c b/src/main.c
index bf966f4..52ab11c 100644
--- a/src/main.c
+++ b/src/main.c
@@ -107,7 +107,8 @@ static GOptionEntry options[] = {
 	{ "root-setup", 'S', 0, G_OPTION_ARG_STRING, &option_root_setup,
 				"Root folder setup script", "SCRIPT" },
 	{ "symlinks", 'l', 0, G_OPTION_ARG_NONE, &option_symlinks,
-				"Enable symlinks on root folder" },
+				"Allow symlinks leading outside of the root "
+				"folder" },
 	{ "capability", 'c', 0, G_OPTION_ARG_STRING, &option_capability,
 				"Specify capability file, use '!' mark for "
 				"scripts", "FILE" },
-- 
1.7.4.1

