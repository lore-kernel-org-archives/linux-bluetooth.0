Return-Path: <cyrus@holtmann.org>
From: Mikel Astiz <mikel.astiz.oss@gmail.com>
To: linux-bluetooth@vger.kernel.org
Cc: Mikel Astiz <mikel.astiz@bmw-carit.de>
Subject: [PATCH obexd v0 08/11] client: open transfer file during creation
Date: Mon, 12 Mar 2012 14:32:42 +0100
Message-Id: <1331559165-28367-9-git-send-email-mikel.astiz.oss@gmail.com>
In-Reply-To: <1331559165-28367-1-git-send-email-mikel.astiz.oss@gmail.com>
References: <1331559165-28367-1-git-send-email-mikel.astiz.oss@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

From: Mikel Astiz <mikel.astiz@bmw-carit.de>

For file-based transfers, it is safer to open the file during the
creation of the transfer, instead of waiting until the transfer is
actually started.

This also simplifies the transfer api, by make obc_transfer_set_file
unnecessary.

This behavior is slightly more complicated when an agent is being used,
since it can overwrite the filename for get operations. This will only
be known once the transfer has been authorized, that is, when it's
starting.
---
 client/session.c  |   48 ++++++++++++-------
 client/transfer.c |  137 ++++++++++++++++++++++++++++++++++------------------
 client/transfer.h |   12 +++--
 3 files changed, 126 insertions(+), 71 deletions(-)

diff --git a/client/session.c b/client/session.c
index 6a76e5a..3cef788 100644
--- a/client/session.c
+++ b/client/session.c
@@ -688,8 +688,16 @@ static void session_request_reply(DBusPendingCall *call, gpointer user_data)
 	if (strlen(name)) {
 		if (obc_transfer_get_dir(transfer) == OBC_TRANSFER_PUT)
 			obc_transfer_set_name(transfer, name);
-		else
-			obc_transfer_set_filename(transfer, name);
+		else {
+			GError *gerr = NULL;
+
+			if (!obc_transfer_set_filename(transfer, name, &gerr)) {
+				session_terminate_transfer(session, transfer,
+									gerr);
+				g_clear_error(&gerr);
+				return;
+			}
+		}
 	}
 
 	if (p->auth_complete)
@@ -938,6 +946,7 @@ int obc_session_get(struct obc_session *session, const char *type,
 	struct obc_transfer *transfer;
 	struct obc_transfer_params *params = NULL;
 	const char *agent;
+	GError *err = NULL;
 
 	if (session->obex == NULL)
 		return -ENOTCONN;
@@ -958,15 +967,19 @@ int obc_session_get(struct obc_session *session, const char *type,
 		transfer = obc_transfer_create(session->conn, agent,
 							OBC_TRANSFER_GET,
 							targetfile, name, type,
-							params);
+							params, &err);
 	else
 		transfer = obc_transfer_create_mem(session->conn, agent,
 							OBC_TRANSFER_GET,
 							NULL, 0, NULL,
-							name, type, params);
+							name, type, params,
+							&err);
 
-	if (transfer == NULL)
-		return -EIO;
+	if (transfer == NULL) {
+		int result = err->code;
+		g_error_free(err);
+		return result;
+	}
 
 	return session_request(session, transfer, func, user_data);
 }
@@ -976,7 +989,7 @@ int obc_session_send(struct obc_session *session, const char *filename,
 {
 	struct obc_transfer *transfer;
 	const char *agent;
-	int err;
+	GError *err = NULL;
 
 	if (session->obex == NULL)
 		return -ENOTCONN;
@@ -986,14 +999,11 @@ int obc_session_send(struct obc_session *session, const char *filename,
 	transfer = obc_transfer_create(session->conn, agent,
 							OBC_TRANSFER_PUT,
 							filename,
-							name, NULL, NULL);
-	if (transfer == NULL)
-		return -EINVAL;
-
-	err = obc_transfer_set_file(transfer);
-	if (err < 0) {
-		obc_transfer_unregister(transfer);
-		return err;
+							name, NULL, NULL, &err);
+	if (transfer == NULL) {
+		int result = err->code;
+		g_error_free(err);
+		return result;
 	}
 
 	return session_request(session, transfer, NULL, NULL);
@@ -1041,6 +1051,7 @@ int obc_session_put(struct obc_session *session, char *buf, const char *name)
 {
 	struct obc_transfer *transfer;
 	const char *agent;
+	GError *err = NULL;
 
 	if (session->obex == NULL) {
 		g_free(buf);
@@ -1053,10 +1064,11 @@ int obc_session_put(struct obc_session *session, char *buf, const char *name)
 							OBC_TRANSFER_PUT,
 							buf, strlen(buf),
 							g_free, name, NULL,
-							NULL);
+							NULL, &err);
 	if (transfer == NULL) {
-		g_free(buf);
-		return -EIO;
+		int result = err->code;
+		g_error_free(err);
+		return result;
 	}
 
 	return session_request(session, transfer, NULL, NULL);
diff --git a/client/transfer.c b/client/transfer.c
index f48d604..254326e 100644
--- a/client/transfer.c
+++ b/client/transfer.c
@@ -28,6 +28,7 @@
 #include <errno.h>
 #include <fcntl.h>
 #include <unistd.h>
+#include <stdlib.h>
 #include <assert.h>
 #include <string.h>
 #include <sys/stat.h>
@@ -310,7 +311,8 @@ static struct obc_transfer *transfer_create(DBusConnection *conn,
 					const char *type,
 					struct obc_transfer_params *params,
 					struct file_location *file_location,
-					struct mem_location *mem_location)
+					struct mem_location *mem_location,
+					GError **err)
 {
 	struct obc_transfer *transfer;
 
@@ -339,6 +341,8 @@ static struct obc_transfer *transfer_create(DBusConnection *conn,
 	transfer->conn = dbus_bus_get(DBUS_BUS_SESSION, NULL);
 	if (transfer->conn == NULL) {
 		obc_transfer_free(transfer);
+		g_set_error(err, OBC_TRANSFER_ERROR, -EIO,
+						"Unable to register transfer");
 		return NULL;
 	}
 
@@ -347,6 +351,8 @@ static struct obc_transfer *transfer_create(DBusConnection *conn,
 				obc_transfer_methods, NULL, NULL,
 				transfer, NULL) == FALSE) {
 		obc_transfer_free(transfer);
+		g_set_error(err, OBC_TRANSFER_ERROR, -EIO,
+						"Unable to register transfer");
 		return NULL;
 	}
 
@@ -368,23 +374,71 @@ void obc_transfer_unregister(struct obc_transfer *transfer)
 	obc_transfer_free(transfer);
 }
 
+static gboolean transfer_open_file(struct obc_transfer *transfer, GError **err)
+{
+	struct file_location *location = transfer->file_location;
+	int fd;
+	struct stat st;
+
+	if (transfer->direction == OBC_TRANSFER_PUT) {
+		DBG("opening file: %s", location->filename);
+		fd = open(location->filename, O_RDONLY);
+	} else {
+		fd = open(location->filename ? : transfer->name,
+					O_WRONLY | O_CREAT | O_TRUNC, 0600);
+		DBG("creating file: %s", location->filename);
+	}
+
+	if (fd < 0) {
+		error("open(): %s (%d)", strerror(errno), errno);
+		g_set_error(err, OBC_TRANSFER_ERROR, -EIO,
+						"Cannot open file");
+		return FALSE;
+	}
+
+	if (transfer->direction == OBC_TRANSFER_PUT) {
+		if (fstat(fd, &st) < 0) {
+			error("fstat(): %s (%d)", strerror(errno), errno);
+			g_set_error(err, OBC_TRANSFER_ERROR, -EIO,
+						"Cannot get file size");
+			return FALSE;
+		}
+
+		transfer->size = st.st_size;
+	}
+
+	location->fd = fd;
+	return TRUE;
+}
+
 struct obc_transfer *obc_transfer_create(DBusConnection *conn,
 					const char *agent,
 					ObcTransferDirection dir,
 					const char *filename,
 					const char *name,
 					const char *type,
-					struct obc_transfer_params *params)
+					struct obc_transfer_params *params,
+					GError **err)
 {
 	struct file_location *file_location;
+	struct obc_transfer *transfer;
 
 	assert(filename != NULL);
 
 	file_location = g_malloc0(sizeof(*file_location));
 	file_location->filename = g_strdup(filename);
 
-	return transfer_create(conn, agent, dir, name, type, params,
-					file_location, NULL);
+	transfer = transfer_create(conn, agent, dir, name, type, params,
+					file_location, NULL, err);
+	if (transfer == NULL)
+		return NULL;
+
+	if (!transfer_open_file(transfer, err)) {
+		obc_transfer_free(transfer);
+		return NULL;
+	}
+
+	return transfer;
 }
 
 struct obc_transfer *obc_transfer_create_mem(DBusConnection *conn,
@@ -394,7 +448,8 @@ struct obc_transfer *obc_transfer_create_mem(DBusConnection *conn,
 					GDestroyNotify buffer_destroy_func,
 					const char *name,
 					const char *type,
-					struct obc_transfer_params *params)
+					struct obc_transfer_params *params,
+					GError **err)
 {
 	struct mem_location *mem_location;
 	struct obc_transfer *transfer;
@@ -418,7 +473,7 @@ struct obc_transfer *obc_transfer_create_mem(DBusConnection *conn,
 	}
 
 	transfer = transfer_create(conn, agent, dir, name, type, params,
-					NULL, mem_location);
+					NULL, mem_location, err);
 	if (transfer == NULL)
 		return NULL;
 
@@ -653,18 +708,6 @@ static gboolean transfer_start_get(struct obc_transfer *transfer, GError **err)
 	if (transfer->mem_location != NULL)
 		rsp_cb = get_buf_xfer_progress;
 	else {
-		const char *filename = transfer->file_location->filename;
-		int fd = open(filename ? : transfer->name,
-				O_WRONLY | O_CREAT, 0600);
-
-		if (fd < 0) {
-			error("open(): %s(%d)", strerror(errno), errno);
-			g_set_error(err, OBC_TRANSFER_ERROR, -EIO,
-							"Cannot open file");
-			return FALSE;
-		}
-
-		transfer->file_location->fd = fd;
 		data_cb = get_xfer_progress;
 		complete_cb = xfer_complete;
 	}
@@ -790,11 +833,35 @@ void obc_transfer_set_name(struct obc_transfer *transfer, const char *name)
 	transfer->name = g_strdup(name);
 }
 
-void obc_transfer_set_filename(struct obc_transfer *transfer,
-					const char *filename)
+gboolean obc_transfer_set_filename(struct obc_transfer *transfer,
+					const char *filename,
+					GError **err)
 {
-	g_free(transfer->file_location->filename);
-	transfer->file_location->filename = g_strdup(filename);
+	struct file_location *location = transfer->file_location;
+	char *old = location->filename;
+
+	location->filename = g_strdup(filename);
+
+	if ((old == NULL) || (filename == NULL) || !g_strcmp0(old, filename))
+		goto done;
+
+	if (location->fd > 0) {
+		close(location->fd);
+		location->fd = 0;
+
+		if ((transfer->direction == OBC_TRANSFER_GET) &&
+					(transfer->file_location != NULL))
+			unlink(transfer->file_location->filename);
+	}
+
+	if (!transfer_open_file(transfer, err)) {
+		g_free(old);
+		return FALSE;
+	}
+
+done:
+	g_free(old);
+	return TRUE;
 }
 
 const char *obc_transfer_get_path(struct obc_transfer *transfer)
@@ -806,29 +873,3 @@ gint64 obc_transfer_get_size(struct obc_transfer *transfer)
 {
 	return transfer->size;
 }
-
-int obc_transfer_set_file(struct obc_transfer *transfer)
-{
-	int fd;
-	struct stat st;
-
-	if (transfer->file_location != NULL)
-		return 0;
-
-	fd = open(transfer->file_location->filename, O_RDONLY);
-	if (fd < 0) {
-		error("open(): %s(%d)", strerror(errno), errno);
-		return -errno;
-	}
-
-	if (fstat(fd, &st) < 0) {
-		error("fstat(): %s(%d)", strerror(errno), errno);
-		close(fd);
-		return -errno;
-	}
-
-	transfer->file_location->fd = fd;
-	transfer->size = st.st_size;
-
-	return 0;
-}
diff --git a/client/transfer.h b/client/transfer.h
index ed89867..d8c83db 100644
--- a/client/transfer.h
+++ b/client/transfer.h
@@ -44,7 +44,8 @@ struct obc_transfer *obc_transfer_create(DBusConnection *conn,
 					const char *filename,
 					const char *name,
 					const char *type,
-					struct obc_transfer_params *params);
+					struct obc_transfer_params *params,
+					GError **err);
 
 /* similar as above, but from memory. for get operations, buffer must be NULL */
 struct obc_transfer *obc_transfer_create_mem(DBusConnection *conn,
@@ -54,7 +55,8 @@ struct obc_transfer *obc_transfer_create_mem(DBusConnection *conn,
 					GDestroyNotify buffer_destroy_func,
 					const char *name,
 					const char *type,
-					struct obc_transfer_params *params);
+					struct obc_transfer_params *params,
+					GError **err);
 
 void obc_transfer_unregister(struct obc_transfer *transfer);
 
@@ -72,8 +74,8 @@ const void *obc_transfer_get_params(struct obc_transfer *transfer,
 const void *obc_transfer_get_buffer(struct obc_transfer *transfer,
 								size_t *size);
 void obc_transfer_set_name(struct obc_transfer *transfer, const char *name);
-void obc_transfer_set_filename(struct obc_transfer *transfer,
-					const char *filename);
+gboolean obc_transfer_set_filename(struct obc_transfer *transfer,
+					const char *filename,
+					GError **err);
 const char *obc_transfer_get_path(struct obc_transfer *transfer);
 gint64 obc_transfer_get_size(struct obc_transfer *transfer);
-int obc_transfer_set_file(struct obc_transfer *transfer);
-- 
1.7.7.6

