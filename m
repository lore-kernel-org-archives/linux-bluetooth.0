Return-Path: <cyrus@holtmann.org>
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH obexd 4/4] Add copy and move support for filesystem plugin
Date: Fri, 17 Jun 2011 09:26:47 +0300
Message-Id: <1308292007-2111-4-git-send-email-luiz.dentz@gmail.com>
In-Reply-To: <1308292007-2111-1-git-send-email-luiz.dentz@gmail.com>
References: <1308292007-2111-1-git-send-email-luiz.dentz@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

From: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>

Move is implemented using rename and copy uses sendfile, both part of
posix.
---
 plugins/filesystem.c |   93 ++++++++++++++++++++++++++++++++++++++++++++++++++
 1 files changed, 93 insertions(+), 0 deletions(-)

diff --git a/plugins/filesystem.c b/plugins/filesystem.c
index b4ff556..53e7e94 100644
--- a/plugins/filesystem.c
+++ b/plugins/filesystem.c
@@ -36,6 +36,7 @@
 #include <sys/types.h>
 #include <sys/stat.h>
 #include <sys/statvfs.h>
+#include <sys/sendfile.h>
 #include <fcntl.h>
 #include <wait.h>
 
@@ -234,6 +235,96 @@ static ssize_t filesystem_write(void *object, const void *buf, size_t count)
 	return ret;
 }
 
+static int filesystem_rename(const char *name, const char *destname)
+{
+	int ret;
+
+	ret = rename(name, destname);
+	if (ret < 0) {
+		error("rename(%s, %s): %s (%d)", name, destname,
+						strerror(errno), errno);
+		return -errno;
+	}
+
+	return ret;
+}
+
+static int sendfile_async(void *out, void *in, off_t *offset, size_t count)
+{
+	int pid;
+
+	/* Run sendfile on child process */
+	pid = fork();
+	switch (pid) {
+		case 0:
+			break;
+		case -1:
+			error("fork() %s (%d)", strerror(errno), errno);
+			return -errno;
+		default:
+			DBG("child %d forked", pid);
+			return pid;
+	}
+
+	/* At child */
+	if (sendfile(GPOINTER_TO_INT(out), GPOINTER_TO_INT(in), offset, count) < 0)
+		error("sendfile(): %s (%d)", strerror(errno), errno);
+
+	filesystem_close(in);
+	filesystem_close(out);
+
+	exit(errno);
+}
+
+static int filesystem_copy(const char *name, const char *destname)
+{
+	void *in, *out;
+	ssize_t ret;
+	size_t size;
+	struct stat fstat;
+	int err;
+
+	in = filesystem_open(name, O_RDONLY, 0, NULL, &size, &err);
+	if (in == NULL) {
+		error("open(%s): %s (%d)", name, strerror(-err), -err);
+		return -err;
+	}
+
+	ret = stat(name, &fstat);
+	if (ret < 0) {
+		error("stat(%s): %s (%d)", name, strerror(errno), errno);
+		return -errno;
+	}
+
+	out = filesystem_open(destname, O_WRONLY | O_CREAT | O_TRUNC,
+					fstat.st_mode, NULL, &size, &err);
+	if (out == NULL) {
+		error("open(%s): %s (%d)", destname, strerror(-err), -err);
+		filesystem_close(in);
+		return -errno;
+	}
+
+	/* Check if sendfile is supported */
+	ret = sendfile(GPOINTER_TO_INT(out), GPOINTER_TO_INT(in), NULL, 0);
+	if (ret < 0) {
+		ret = -errno;
+		error("sendfile: %s (%zd)", strerror(-ret), -ret);
+		goto done;
+	}
+
+	ret = sendfile_async(out, in, NULL, fstat.st_size);
+	if (ret < 0)
+		goto done;
+
+	return 0;
+
+done:
+	filesystem_close(in);
+	filesystem_close(out);
+
+	return ret;
+}
+
 struct capability_object {
 	int pid;
 	int output;
@@ -555,6 +646,8 @@ static struct obex_mime_type_driver file = {
 	.read = filesystem_read,
 	.write = filesystem_write,
 	.remove = remove,
+	.move = filesystem_rename,
+	.copy = filesystem_copy,
 };
 
 static struct obex_mime_type_driver capability = {
-- 
1.7.5.4

