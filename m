Return-Path: <cyrus@holtmann.org>
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH obexd] client: Fix not checking if destination exist while renaming file
Date: Tue, 29 May 2012 15:11:38 +0300
Message-Id: <1338293498-2356-1-git-send-email-luiz.dentz@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

From: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>

rename return an error if the destination directory doesn't exist, so
in case it doesn't exist it should be created before calling rename.
---
 client/transfer.c |   27 +++++++++++++++++++++++++--
 1 files changed, 25 insertions(+), 2 deletions(-)

diff --git a/client/transfer.c b/client/transfer.c
index 3065c9c..772834f 100644
--- a/client/transfer.c
+++ b/client/transfer.c
@@ -715,11 +715,34 @@ int obc_transfer_set_filename(struct obc_transfer *transfer,
 					const char *filename)
 {
 	int err;
+	struct stat st;
+	char *dirname;
+	gboolean dir = FALSE;
+
+	dirname = g_path_get_dirname(filename);
+	if (stat(dirname, &st) < 0) {
+		if (errno != ENOENT) {
+			error("stat(): %s (%d)", strerror(errno), errno);
+			return -errno;
+		}
+
+		if (mkdir(dirname, 0755) < 0) {
+			error("mkdir(): %s (%d)", strerror(errno), errno);
+			return -errno;
+		}
+
+		dir = TRUE;
+	}
 
 	err = rename(transfer->filename, filename);
 	if (err < 0) {
-		error("rename(): %s (%d)", strerror(errno), errno);
-		return -errno;
+		err = -errno;
+
+		if (dir)
+			rmdir(dirname);
+
+		error("rename(): %s (%d)", strerror(-err), -err);
+		return -err;
 	}
 
 	g_free(transfer->filename);
-- 
1.7.7.6

