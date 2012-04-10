Return-Path: <cyrus@holtmann.org>
From: Mikel Astiz <mikel.astiz.oss@gmail.com>
To: linux-bluetooth@vger.kernel.org
Cc: Mikel Astiz <mikel.astiz@bmw-carit.de>
Subject: [PATCH obexd v1 07/11] client: separate memory transfers in transfer api
Date: Tue, 10 Apr 2012 15:38:28 +0200
Message-Id: <1334065112-14966-8-git-send-email-mikel.astiz.oss@gmail.com>
In-Reply-To: <1334065112-14966-1-git-send-email-mikel.astiz.oss@gmail.com>
References: <1334065112-14966-1-git-send-email-mikel.astiz.oss@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

From: Mikel Astiz <mikel.astiz@bmw-carit.de>

The new transfer api clearly separates memory-based transfers from the
filesystem-based ones. This also simplifies buffer ownership semantics.

>From the implementation point of view, the data fields needed for the
two transfer types have been wrapped in separated data structures.
---
 client/session.c  |   26 +++---
 client/transfer.c |  254 ++++++++++++++++++++++++++++++++++++++--------------
 client/transfer.h |   15 +++-
 3 files changed, 211 insertions(+), 84 deletions(-)

diff --git a/client/session.c b/client/session.c
index c628c6f..679627b 100644
--- a/client/session.c
+++ b/client/session.c
@@ -954,17 +954,19 @@ int obc_session_get(struct obc_session *session, const char *type,
 	else
 		agent = NULL;
 
-	transfer = obc_transfer_register(session->conn, agent,
+	if (targetfile != NULL)
+		transfer = obc_transfer_create(session->conn, agent,
 							OBC_TRANSFER_GET,
 							targetfile, name, type,
 							params);
-	if (transfer == NULL) {
-		if (params != NULL) {
-			g_free(params->data);
-			g_free(params);
-		}
+	else
+		transfer = obc_transfer_create_mem(session->conn, agent,
+							OBC_TRANSFER_GET,
+							NULL, 0, NULL,
+							name, type, params);
+
+	if (transfer == NULL)
 		return -EIO;
-	}
 
 	return session_request(session, transfer, func, user_data);
 }
@@ -981,7 +983,7 @@ int obc_session_send(struct obc_session *session, const char *filename,
 
 	agent = obc_agent_get_name(session->agent);
 
-	transfer = obc_transfer_register(session->conn, agent,
+	transfer = obc_transfer_create(session->conn, agent,
 							OBC_TRANSFER_PUT,
 							filename,
 							name, NULL, NULL);
@@ -1047,16 +1049,16 @@ int obc_session_put(struct obc_session *session, char *buf, const char *name)
 
 	agent = obc_agent_get_name(session->agent);
 
-	transfer = obc_transfer_register(session->conn, agent,
+	transfer = obc_transfer_create_mem(session->conn, agent,
 							OBC_TRANSFER_PUT,
-							name, NULL, NULL, NULL);
+							buf, strlen(buf),
+							g_free, name, NULL,
+							NULL);
 	if (transfer == NULL) {
 		g_free(buf);
 		return -EIO;
 	}
 
-	obc_transfer_set_buffer(transfer, buf);
-
 	return session_request(session, transfer, NULL, NULL);
 }
 
diff --git a/client/transfer.c b/client/transfer.c
index ea011a4..a177eb3 100644
--- a/client/transfer.c
+++ b/client/transfer.c
@@ -28,6 +28,7 @@
 #include <errno.h>
 #include <fcntl.h>
 #include <unistd.h>
+#include <assert.h>
 #include <string.h>
 #include <sys/stat.h>
 #include <inttypes.h>
@@ -53,22 +54,30 @@ struct transfer_callback {
 	void *data;
 };
 
+struct file_location {
+	gchar *filename;		/* Local filename */
+	int fd;
+};
+
+struct mem_location {
+	void *buffer;			/* For Get, allocated internally */
+	gint64 buffer_len;
+	GDestroyNotify buffer_destroy_func;
+};
+
 struct obc_transfer {
 	GObex *obex;
 	ObcTransferCommand command;
+	struct file_location *file_location;
+	struct mem_location *mem_location;
 	struct obc_transfer_params *params;
 	struct transfer_callback *callback;
 	DBusConnection *conn;
 	char *agent;		/* Transfer agent */
 	char *path;		/* Transfer path */
-	gchar *filename;	/* Transfer file location */
 	char *name;		/* Transfer object name */
 	char *type;		/* Transfer object type */
-	int fd;
 	guint xfer;
-	char *buffer;
-	size_t buffer_len;
-	int filled;
 	gint64 size;
 	gint64 transferred;
 };
@@ -132,7 +141,10 @@ static DBusMessage *obc_transfer_get_properties(DBusConnection *connection,
 
 	append_entry(&dict, "Name", DBUS_TYPE_STRING, &transfer->name);
 	append_entry(&dict, "Size", DBUS_TYPE_UINT64, &transfer->size);
-	append_entry(&dict, "Filename", DBUS_TYPE_STRING, &transfer->filename);
+
+	if (transfer->file_location != NULL)
+		append_entry(&dict, "Filename", DBUS_TYPE_STRING,
+					&transfer->file_location->filename);
 
 	dbus_message_iter_close_container(&iter, &dict);
 
@@ -225,6 +237,44 @@ static GDBusMethodTable obc_transfer_methods[] = {
 	{ }
 };
 
+static void free_file_location(struct obc_transfer *transfer)
+{
+	struct file_location *location = transfer->file_location;
+
+	if (location == NULL)
+		return;
+
+	if (location->fd > 0)
+		close(location->fd);
+
+	g_free(location->filename);
+	g_free(location);
+
+	transfer->file_location = NULL;
+}
+
+static void free_mem_location(struct obc_transfer *transfer)
+{
+	struct mem_location *location = transfer->mem_location;
+
+	if (location == NULL)
+		return;
+
+	transfer->mem_location = NULL;
+
+	switch (transfer->command) {
+	case OBC_TRANSFER_GET:
+		g_free(location->buffer);
+		break;
+	case OBC_TRANSFER_PUT:
+		if (location->buffer_destroy_func != NULL)
+			location->buffer_destroy_func(location->buffer);
+		break;
+	}
+
+	g_free(location);
+}
+
 static void obc_transfer_free(struct obc_transfer *transfer)
 {
 	DBG("%p", transfer);
@@ -232,9 +282,6 @@ static void obc_transfer_free(struct obc_transfer *transfer)
 	if (transfer->xfer)
 		g_obex_cancel_transfer(transfer->xfer);
 
-	if (transfer->fd > 0)
-		close(transfer->fd);
-
 	if (transfer->params != NULL) {
 		g_free(transfer->params->data);
 		g_free(transfer->params);
@@ -246,30 +293,37 @@ static void obc_transfer_free(struct obc_transfer *transfer)
 	if (transfer->obex)
 		g_obex_unref(transfer->obex);
 
+	free_file_location(transfer);
+	free_mem_location(transfer);
+
 	g_free(transfer->callback);
 	g_free(transfer->agent);
-	g_free(transfer->filename);
 	g_free(transfer->name);
 	g_free(transfer->type);
 	g_free(transfer->path);
-	g_free(transfer->buffer);
 	g_free(transfer);
 }
 
-struct obc_transfer *obc_transfer_register(DBusConnection *conn,
-						const char *agent,
-						ObcTransferCommand cmd,
-						const char *filename,
-						const char *name,
-						const char *type,
-						struct obc_transfer_params *params)
+static struct obc_transfer *transfer_create(DBusConnection *conn,
+					const char *agent,
+					ObcTransferCommand cmd,
+					const char *name,
+					const char *type,
+					struct obc_transfer_params *params,
+					struct file_location *file_location,
+					struct mem_location *mem_location)
 {
 	struct obc_transfer *transfer;
 
+	assert(conn != NULL);
+	assert((type != NULL) || (name != NULL));
+	assert((file_location == NULL) != (mem_location == NULL));
+
 	transfer = g_new0(struct obc_transfer, 1);
 	transfer->command = cmd;
 	transfer->agent = g_strdup(agent);
-	transfer->filename = g_strdup(filename);
+	transfer->file_location = file_location;
+	transfer->mem_location = mem_location;
 	transfer->name = g_strdup(name);
 	transfer->type = g_strdup(type);
 	transfer->params = params;
@@ -315,49 +369,114 @@ void obc_transfer_unregister(struct obc_transfer *transfer)
 	obc_transfer_free(transfer);
 }
 
+struct obc_transfer *obc_transfer_create(DBusConnection *conn,
+					const char *agent,
+					ObcTransferCommand cmd,
+					const char *filename,
+					const char *name,
+					const char *type,
+					struct obc_transfer_params *params)
+{
+	struct file_location *file_location;
+
+	assert(filename != NULL);
+
+	file_location = g_malloc0(sizeof(*file_location));
+	file_location->filename = g_strdup(filename);
+
+	return transfer_create(conn, agent, cmd, name, type, params,
+					file_location, NULL);
+}
+
+struct obc_transfer *obc_transfer_create_mem(DBusConnection *conn,
+					const char *agent,
+					ObcTransferCommand cmd,
+					void *buffer, gint64 size,
+					GDestroyNotify buffer_destroy_func,
+					const char *name,
+					const char *type,
+					struct obc_transfer_params *params)
+{
+	struct mem_location *mem_location;
+	struct obc_transfer *transfer;
+
+	assert((cmd == OBC_TRANSFER_PUT) || (buffer == NULL));
+
+	mem_location = g_malloc0(sizeof(*mem_location));
+
+	switch (cmd) {
+	case OBC_TRANSFER_GET:
+		assert(buffer == NULL);
+		mem_location->buffer_len = 1024;
+		mem_location->buffer = g_malloc0(mem_location->buffer_len);
+		break;
+	case OBC_TRANSFER_PUT:
+		assert(buffer != NULL);
+		mem_location->buffer = buffer;
+		mem_location->buffer_len = size;
+		mem_location->buffer_destroy_func = buffer_destroy_func;
+		break;
+	}
+
+	transfer = transfer_create(conn, agent, cmd, name, type, params,
+					NULL, mem_location);
+	if (transfer == NULL)
+		return NULL;
+
+	if (cmd == OBC_TRANSFER_PUT)
+		transfer->size = size;
+
+	return transfer;
+}
+
 static void obc_transfer_read(struct obc_transfer *transfer,
 						const void *buf, gsize len)
 {
+	struct mem_location *location = transfer->mem_location;
 	gsize bsize;
 
+	assert(location != NULL);
+
 	/* copy all buffered data */
-	bsize = transfer->buffer_len - transfer->filled;
+	bsize = location->buffer_len - transfer->transferred;
 
 	if (bsize < len) {
-		transfer->buffer_len += len - bsize;
-		transfer->buffer = g_realloc(transfer->buffer,
-							transfer->buffer_len);
+		location->buffer_len += len - bsize;
+		location->buffer = g_realloc(location->buffer,
+							location->buffer_len);
 	}
 
-	memcpy(transfer->buffer + transfer->filled, buf, len);
+	memcpy(location->buffer + transfer->transferred, buf, len);
 
-	transfer->filled += len;
 	transfer->transferred += len;
 }
 
 static void get_buf_xfer_complete(GObex *obex, GError *err, gpointer user_data)
 {
 	struct obc_transfer *transfer = user_data;
+	struct mem_location *location = transfer->mem_location;
 	gsize bsize;
 
+	assert(location != NULL);
+
 	transfer->xfer = 0;
 
 	if (err)
 		goto done;
 
-	if (transfer->filled > 0 &&
-			transfer->buffer[transfer->filled - 1] == '\0')
+	if (transfer->transferred > 0 &&
+		((char *) location->buffer)[transfer->transferred - 1] == '\0')
 		goto done;
 
-	bsize = transfer->buffer_len - transfer->filled;
+	bsize = location->buffer_len - transfer->transferred;
 	if (bsize < 1) {
-		transfer->buffer_len += 1;
-		transfer->buffer = g_realloc(transfer->buffer,
-						transfer->buffer_len);
+		location->buffer_len += 1;
+		location->buffer = g_realloc(location->buffer,
+						location->buffer_len);
 	}
 
-	transfer->buffer[transfer->filled] = '\0';
-	transfer->size = strlen(transfer->buffer);
+	((char *) location->buffer)[transfer->transferred] = '\0';
+	transfer->size = strlen(location->buffer);
 
 done:
 	transfer_notify_complete(transfer);
@@ -446,18 +565,13 @@ static gboolean get_xfer_progress(const void *buf, gsize len,
 							gpointer user_data)
 {
 	struct obc_transfer *transfer = user_data;
+	struct file_location *location = transfer->file_location;
 
-	obc_transfer_read(transfer, buf, len);
+	assert(location != NULL);
+	assert(location->fd > 0);
 
-	if (transfer->fd > 0) {
-		gint w;
-
-		w = write(transfer->fd, transfer->buffer, transfer->filled);
-		if (w < 0)
-			return FALSE;
-
-		transfer->filled -= w;
-	}
+	if (write(location->fd, buf, len) < (ssize_t) len)
+		return FALSE;
 
 	transfer_notify_progress(transfer);
 
@@ -467,8 +581,11 @@ static gboolean get_xfer_progress(const void *buf, gsize len,
 static gssize put_buf_xfer_progress(void *buf, gsize len, gpointer user_data)
 {
 	struct obc_transfer *transfer = user_data;
+	struct mem_location *location = transfer->mem_location;
 	gsize size;
 
+	assert(location != NULL);
+
 	if (transfer->transferred == transfer->size)
 		return 0;
 
@@ -477,7 +594,7 @@ static gssize put_buf_xfer_progress(void *buf, gsize len, gpointer user_data)
 	if (size == 0)
 		return 0;
 
-	memcpy(buf, transfer->buffer + transfer->transferred, size);
+	memcpy(buf, location->buffer + transfer->transferred, size);
 
 	transfer->transferred += size;
 
@@ -489,9 +606,10 @@ static gssize put_buf_xfer_progress(void *buf, gsize len, gpointer user_data)
 static gssize put_xfer_progress(void *buf, gsize len, gpointer user_data)
 {
 	struct obc_transfer *transfer = user_data;
+	struct file_location *location = transfer->file_location;
 	gssize size;
 
-	size = read(transfer->fd, buf, len);
+	size = read(location->fd, buf, len);
 	if (size <= 0)
 		return size;
 
@@ -533,20 +651,21 @@ static gboolean transfer_start_get(struct obc_transfer *transfer, GError **err)
 		return FALSE;
 	}
 
-	if (transfer->type != NULL &&
-			(strncmp(transfer->type, "x-obex/", 7) == 0 ||
-			strncmp(transfer->type, "x-bt/", 5) == 0)) {
+	if (transfer->mem_location != NULL)
 		rsp_cb = get_buf_xfer_progress;
-	} else {
-		int fd = open(transfer->filename ? : transfer->name,
+	else {
+		const char *filename = transfer->file_location->filename;
+		int fd = open(filename ? : transfer->name,
 				O_WRONLY | O_CREAT, 0600);
+
 		if (fd < 0) {
 			error("open(): %s(%d)", strerror(errno), errno);
 			g_set_error(err, OBC_TRANSFER_ERROR, -EIO,
 							"Cannot open file");
 			return FALSE;
 		}
-		transfer->fd = fd;
+
+		transfer->file_location->fd = fd;
 		data_cb = get_xfer_progress;
 		complete_cb = xfer_complete;
 	}
@@ -591,14 +710,11 @@ static gboolean transfer_start_put(struct obc_transfer *transfer, GError **err)
 		return FALSE;
 	}
 
-	if (transfer->buffer) {
+	if (transfer->mem_location != NULL)
 		data_cb = put_buf_xfer_progress;
-		goto done;
-	}
-
-	data_cb = put_xfer_progress;
+	else
+		data_cb = put_xfer_progress;
 
-done:
 	req = g_obex_packet_new(G_OBEX_OP_PUT, FALSE, G_OBEX_HDR_INVALID);
 
 	if (transfer->name != NULL)
@@ -660,16 +776,13 @@ const void *obc_transfer_get_params(struct obc_transfer *transfer, size_t *size)
 
 const void *obc_transfer_get_buffer(struct obc_transfer *transfer, size_t *size)
 {
-	if (size)
-		*size = transfer->filled;
+	if (transfer->mem_location == NULL)
+		return NULL;
 
-	return transfer->buffer;
-}
+	if (size != NULL)
+		*size = transfer->size;
 
-void obc_transfer_set_buffer(struct obc_transfer *transfer, char *buffer)
-{
-	transfer->size = strlen(buffer);
-	transfer->buffer = buffer;
+	return transfer->mem_location->buffer;
 }
 
 void obc_transfer_set_name(struct obc_transfer *transfer, const char *name)
@@ -681,8 +794,8 @@ void obc_transfer_set_name(struct obc_transfer *transfer, const char *name)
 void obc_transfer_set_filename(struct obc_transfer *transfer,
 					const char *filename)
 {
-	g_free(transfer->filename);
-	transfer->filename = g_strdup(filename);
+	g_free(transfer->file_location->filename);
+	transfer->file_location->filename = g_strdup(filename);
 }
 
 const char *obc_transfer_get_path(struct obc_transfer *transfer)
@@ -700,7 +813,10 @@ int obc_transfer_set_file(struct obc_transfer *transfer)
 	int fd;
 	struct stat st;
 
-	fd = open(transfer->filename, O_RDONLY);
+	if (transfer->file_location != NULL)
+		return 0;
+
+	fd = open(transfer->file_location->filename, O_RDONLY);
 	if (fd < 0) {
 		error("open(): %s(%d)", strerror(errno), errno);
 		return -errno;
@@ -712,7 +828,7 @@ int obc_transfer_set_file(struct obc_transfer *transfer)
 		return -errno;
 	}
 
-	transfer->fd = fd;
+	transfer->file_location->fd = fd;
 	transfer->size = st.st_size;
 
 	return 0;
diff --git a/client/transfer.h b/client/transfer.h
index a74ffea..09c708d 100644
--- a/client/transfer.h
+++ b/client/transfer.h
@@ -37,7 +37,8 @@ typedef void (*transfer_callback_t) (struct obc_transfer *transfer,
 					gint64 transferred, GError *err,
 					void *user_data);
 
-struct obc_transfer *obc_transfer_register(DBusConnection *conn,
+/* takes ownership of obc_transfer_params */
+struct obc_transfer *obc_transfer_create(DBusConnection *conn,
 					const char *agent,
 					ObcTransferCommand cmd,
 					const char *filename,
@@ -45,6 +46,16 @@ struct obc_transfer *obc_transfer_register(DBusConnection *conn,
 					const char *type,
 					struct obc_transfer_params *params);
 
+/* similar as above, but from memory. for get operations, buffer must be NULL */
+struct obc_transfer *obc_transfer_create_mem(DBusConnection *conn,
+					const char *agent,
+					ObcTransferCommand cmd,
+					void *buffer, gint64 size,
+					GDestroyNotify buffer_destroy_func,
+					const char *name,
+					const char *type,
+					struct obc_transfer_params *params);
+
 void obc_transfer_unregister(struct obc_transfer *transfer);
 
 gboolean obc_transfer_set_callback(struct obc_transfer *transfer,
@@ -60,8 +71,6 @@ const void *obc_transfer_get_params(struct obc_transfer *transfer,
 								size_t *size);
 const void *obc_transfer_get_buffer(struct obc_transfer *transfer,
 								size_t *size);
-void obc_transfer_set_buffer(struct obc_transfer *transfer, char *buffer);
-
 void obc_transfer_set_name(struct obc_transfer *transfer, const char *name);
 void obc_transfer_set_filename(struct obc_transfer *transfer,
 					const char *filename);
-- 
1.7.7.6

