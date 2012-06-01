Return-Path: <cyrus@holtmann.org>
From: Mikel Astiz <mikel.astiz.oss@gmail.com>
To: linux-bluetooth@vger.kernel.org
Cc: Mikel Astiz <mikel.astiz@bmw-carit.de>
Subject: [PATCH obexd v0 02/14] client: Support empty filename in obc_transfer_get
Date: Fri,  1 Jun 2012 12:51:11 +0200
Message-Id: <1338547883-18907-3-git-send-email-mikel.astiz.oss@gmail.com>
In-Reply-To: <1338547883-18907-1-git-send-email-mikel.astiz.oss@gmail.com>
References: <1338547883-18907-1-git-send-email-mikel.astiz.oss@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

From: Mikel Astiz <mikel.astiz@bmw-carit.de>

Passing an empty string as a filename for obc_transfer_get will be
similar to passing a NULL filename. This means a temporary file will be
created to store the content of the transfer.

NULL and "" are not exactly equivalent though: in case of NULL the file
will be automatically removed immediately after being open, which means
that the transfer initiator should also open the file to prevent it from
being removed (to be used from the modules).

On the other hand, if "" is given, the file will be removed only in case
of error. So after success the transfer initiator should decide whether
the file should be removed or not.

This change is convenient in order to expose the same API in D-Bus.
---
 client/transfer.c |   28 +++++++++++++++++++++++-----
 1 files changed, 23 insertions(+), 5 deletions(-)

diff --git a/client/transfer.c b/client/transfer.c
index 14006ef..04533b8 100644
--- a/client/transfer.c
+++ b/client/transfer.c
@@ -77,6 +77,7 @@ struct obc_transfer {
 	gint64 transferred;
 	gint64 progress;
 	guint progress_id;
+	gboolean remove_file_on_error;
 };
 
 static GQuark obc_transfer_error_quark(void)
@@ -293,8 +294,9 @@ static gboolean transfer_open(struct obc_transfer *transfer, int flags,
 						mode_t mode, GError **err)
 {
 	int fd;
+	char *filename;
 
-	if (transfer->filename != NULL) {
+	if (transfer->filename != NULL && strcmp(transfer->filename, "") != 0) {
 		fd = open(transfer->filename, flags, mode);
 		if (fd < 0) {
 			error("open(): %s(%d)", strerror(errno), errno);
@@ -305,13 +307,19 @@ static gboolean transfer_open(struct obc_transfer *transfer, int flags,
 		goto done;
 	}
 
-	fd = g_file_open_tmp("obex-clientXXXXXX", &transfer->filename, err);
+	fd = g_file_open_tmp("obex-clientXXXXXX", &filename, err);
 	if (fd < 0) {
 		error("g_file_open_tmp(): %s", (*err)->message);
 		return FALSE;
 	}
 
-	remove(transfer->filename);
+	if (transfer->filename == NULL)
+		remove(filename); /* remove always only if NULL was given */
+	else
+		transfer->remove_file_on_error = TRUE;
+
+	g_free(transfer->filename);
+	transfer->filename = filename;
 
 done:
 	transfer->fd = fd;
@@ -344,6 +352,12 @@ struct obc_transfer *obc_transfer_put(const char *type, const char *name,
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
@@ -433,10 +447,14 @@ static void xfer_complete(GObex *obex, GError *err, gpointer user_data)
 			g_dbus_emit_signal(transfer->conn, transfer->path,
 						TRANSFER_INTERFACE, "Complete",
 						DBUS_TYPE_INVALID);
-	} else if (transfer->path != NULL) {
+	} else {
 		const char *code = "org.openobex.Error.Failed";
 
-		g_dbus_emit_signal(transfer->conn, transfer->path,
+		if (transfer->remove_file_on_error)
+			remove(transfer->filename);
+
+		if (transfer->path != NULL)
+			g_dbus_emit_signal(transfer->conn, transfer->path,
 						TRANSFER_INTERFACE, "Error",
 						DBUS_TYPE_STRING,
 						&code,
-- 
1.7.7.6

