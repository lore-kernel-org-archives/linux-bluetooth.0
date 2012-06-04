Return-Path: <cyrus@holtmann.org>
From: Mikel Astiz <mikel.astiz.oss@gmail.com>
To: linux-bluetooth@vger.kernel.org
Cc: Mikel Astiz <mikel.astiz@bmw-carit.de>
Subject: [PATCH obexd v2 03/15] client: Support empty filename in obc_transfer_get
Date: Mon,  4 Jun 2012 15:50:16 +0200
Message-Id: <1338817828-12166-4-git-send-email-mikel.astiz.oss@gmail.com>
In-Reply-To: <1338817828-12166-1-git-send-email-mikel.astiz.oss@gmail.com>
References: <1338817828-12166-1-git-send-email-mikel.astiz.oss@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

From: Mikel Astiz <mikel.astiz@bmw-carit.de>

Passing an empty string as a filename for obc_transfer_get will be
similar to passing a NULL filename. This means a temporary file will be
created to store the content of the transfer.

NULL and "" are not exactly equivalent though: in case of NULL the file
will be automatically removed immediately after being open, which means
that the transfer initiator should also open the file to prevent it from
being removed (to be used from the modules). In this case, the filename
will not be exposed in D-Bus.

On the other hand, if "" is given, the file will be removed only in case
of error. So after success the transfer initiator should decide whether
the file should be removed or not.

This change is convenient in order to expose the same API in D-Bus.
---
 client/transfer.c |   27 ++++++++++++++++++++++-----
 1 files changed, 22 insertions(+), 5 deletions(-)

diff --git a/client/transfer.c b/client/transfer.c
index e7852e1..e6ca72d 100644
--- a/client/transfer.c
+++ b/client/transfer.c
@@ -295,8 +295,9 @@ static gboolean transfer_open(struct obc_transfer *transfer, int flags,
 						mode_t mode, GError **err)
 {
 	int fd;
+	char *filename;
 
-	if (transfer->filename != NULL) {
+	if (transfer->filename != NULL && strcmp(transfer->filename, "") != 0) {
 		fd = open(transfer->filename, flags, mode);
 		if (fd < 0) {
 			error("open(): %s(%d)", strerror(errno), errno);
@@ -307,13 +308,19 @@ static gboolean transfer_open(struct obc_transfer *transfer, int flags,
 		goto done;
 	}
 
-	fd = g_file_open_tmp("obex-clientXXXXXX", &transfer->filename, err);
+	fd = g_file_open_tmp("obex-clientXXXXXX", &filename, err);
 	if (fd < 0) {
 		error("g_file_open_tmp(): %s", (*err)->message);
 		return FALSE;
 	}
 
-	remove(transfer->filename);
+	if (transfer->filename == NULL) {
+		remove(filename); /* remove always only if NULL was given */
+		g_free(filename);
+	} else {
+		g_free(transfer->filename);
+		transfer->filename = filename;
+	}
 
 done:
 	transfer->fd = fd;
@@ -346,6 +353,12 @@ struct obc_transfer *obc_transfer_put(const char *type, const char *name,
 	struct stat st;
 	int perr;
 
+	if (filename == NULL || strcmp(filename, "") == 0) {
+		g_set_error(err, OBC_TRANSFER_ERROR, -EINVAL,
+						"Invalid filename given");
+		return NULL;
+	}
+
 	transfer = obc_transfer_create(G_OBEX_OP_PUT, filename, name, type);
 
 	if (contents != NULL) {
@@ -435,10 +448,14 @@ static void xfer_complete(GObex *obex, GError *err, gpointer user_data)
 			g_dbus_emit_signal(transfer->conn, transfer->path,
 						TRANSFER_INTERFACE, "Complete",
 						DBUS_TYPE_INVALID);
-	} else if (transfer->path != NULL) {
+	} else {
 		const char *code = "org.openobex.Error.Failed";
 
-		g_dbus_emit_signal(transfer->conn, transfer->path,
+		if (transfer->op == G_OBEX_OP_GET && transfer->filename != NULL)
+			remove(transfer->filename);
+
+		if (transfer->path != NULL)
+			g_dbus_emit_signal(transfer->conn, transfer->path,
 						TRANSFER_INTERFACE, "Error",
 						DBUS_TYPE_STRING,
 						&code,
-- 
1.7.7.6

