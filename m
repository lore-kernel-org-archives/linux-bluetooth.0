Return-Path: <cyrus@holtmann.org>
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH obexd 5/6 v2] client: open file during transfer creation
Date: Fri, 20 Apr 2012 14:40:05 +0300
Message-Id: <1334922006-19654-5-git-send-email-luiz.dentz@gmail.com>
In-Reply-To: <1334922006-19654-1-git-send-email-luiz.dentz@gmail.com>
References: <1334922006-19654-1-git-send-email-luiz.dentz@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

From: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>

This simplify the API a bit by not having to call obc_transfer_set_file
to open the file.

In addition to that split transfer creation/registration function so
GET/PUT can have more specific logic and different paramenters.
---
 client/session.c  |   50 +++++++-------
 client/transfer.c |  208 ++++++++++++++++++++++++++++++++---------------------
 client/transfer.h |   15 +++--
 3 files changed, 162 insertions(+), 111 deletions(-)

diff --git a/client/session.c b/client/session.c
index 306e2ba..7515ff0 100644
--- a/client/session.c
+++ b/client/session.c
@@ -661,6 +661,7 @@ static void session_request_reply(DBusPendingCall *call, gpointer user_data)
 	DBusMessage *reply = dbus_pending_call_steal_reply(call);
 	const char *name;
 	DBusError derr;
+	int err;
 
 	dbus_error_init(&derr);
 	if (dbus_set_error_from_message(&derr, reply)) {
@@ -685,13 +686,26 @@ static void session_request_reply(DBusPendingCall *call, gpointer user_data)
 
 	DBG("Agent.Request() reply: %s", name);
 
-	if (strlen(name)) {
-		if (obc_transfer_get_operation(transfer) == G_OBEX_OP_PUT)
-			obc_transfer_set_name(transfer, name);
-		else
-			obc_transfer_set_filename(transfer, name);
+	if (strlen(name) == 0)
+		goto done;
+
+	if (obc_transfer_get_operation(transfer) == G_OBEX_OP_PUT) {
+		obc_transfer_set_name(transfer, name);
+		goto done;
+	}
+
+	err = obc_transfer_set_filename(transfer, name);
+	if (err < 0) {
+		GError *gerr = NULL;
+
+		g_set_error(&gerr, OBEX_IO_ERROR, err,
+						"Unable to set filename");
+		session_terminate_transfer(session, transfer, gerr);
+		g_clear_error(&gerr);
+		return;
 	}
 
+done:
 	if (p->auth_complete)
 		p->auth_complete(session, transfer);
 
@@ -956,8 +970,8 @@ int obc_session_get(struct obc_session *session, const char *type,
 	else
 		agent = NULL;
 
-	transfer = obc_transfer_register(session->conn, agent, G_OBEX_OP_GET,
-					targetfile, name, type, params);
+	transfer = obc_transfer_get(session->conn, agent, targetfile, name,
+								type, params);
 	if (transfer == NULL) {
 		if (params != NULL) {
 			g_free(params->data);
@@ -974,24 +988,17 @@ int obc_session_send(struct obc_session *session, const char *filename,
 {
 	struct obc_transfer *transfer;
 	const char *agent;
-	int err;
 
 	if (session->obex == NULL)
 		return -ENOTCONN;
 
 	agent = obc_agent_get_name(session->agent);
 
-	transfer = obc_transfer_register(session->conn, agent, G_OBEX_OP_PUT,
-						filename, name, NULL, NULL);
+	transfer = obc_transfer_put(session->conn, agent, filename, name,
+					NULL, NULL, 0, NULL);
 	if (transfer == NULL)
 		return -EINVAL;
 
-	err = obc_transfer_set_file(transfer, NULL, 0);
-	if (err < 0) {
-		obc_transfer_unregister(transfer);
-		return err;
-	}
-
 	return session_request(session, transfer, NULL, NULL);
 }
 
@@ -1038,24 +1045,17 @@ int obc_session_put(struct obc_session *session, const char *contents,
 {
 	struct obc_transfer *transfer;
 	const char *agent;
-	int err;
 
 	if (session->obex == NULL)
 		return -ENOTCONN;
 
 	agent = obc_agent_get_name(session->agent);
 
-	transfer = obc_transfer_register(session->conn, agent, G_OBEX_OP_PUT,
-						NULL, name, NULL, NULL);
+	transfer = obc_transfer_put(session->conn, agent, NULL, name, NULL,
+							contents, size, NULL);
 	if (transfer == NULL)
 		return -EIO;
 
-	err = obc_transfer_set_file(transfer, contents, size);
-	if (err < 0) {
-		obc_transfer_unregister(transfer);
-		return err;
-	}
-
 	return session_request(session, transfer, NULL, NULL);
 }
 
diff --git a/client/transfer.c b/client/transfer.c
index 35e8940..e6e07e1 100644
--- a/client/transfer.c
+++ b/client/transfer.c
@@ -219,7 +219,7 @@ static void obc_transfer_free(struct obc_transfer *transfer)
 	g_free(transfer);
 }
 
-struct obc_transfer *obc_transfer_register(DBusConnection *conn,
+static struct obc_transfer *obc_transfer_register(DBusConnection *conn,
 						const char *agent,
 						guint8 op,
 						const char *filename,
@@ -247,23 +247,131 @@ struct obc_transfer *obc_transfer_register(DBusConnection *conn,
 			TRANSFER_BASEPATH, counter++);
 
 	transfer->conn = dbus_bus_get(DBUS_BUS_SESSION, NULL);
-	if (transfer->conn == NULL) {
-		obc_transfer_free(transfer);
-		return NULL;
-	}
+	if (transfer->conn == NULL)
+		goto fail;
 
 	if (g_dbus_register_interface(transfer->conn, transfer->path,
 				TRANSFER_INTERFACE,
 				obc_transfer_methods, NULL, NULL,
-				transfer, NULL) == FALSE) {
+				transfer, NULL) == FALSE)
+		goto fail;
+
+done:
+	DBG("%p registered %s", transfer, transfer->path);
+
+	return transfer;
+
+fail:
+	obc_transfer_free(transfer);
+
+	return NULL;
+}
+
+static int transfer_open(struct obc_transfer *transfer, int flags, mode_t mode)
+{
+	GError *err = NULL;
+	int fd;
+
+	if (transfer->filename != NULL) {
+		fd = open(transfer->filename, flags, mode);
+		if (fd < 0) {
+			error("open(): %s(%d)", strerror(errno), errno);
+			return -errno;
+		}
+		goto done;
+	}
+
+	fd = g_file_open_tmp("obex-clientXXXXXX", &transfer->filename, &err);
+	if (fd < 0) {
+		error("g_file_open_tmp(): %s", err->message);
+		g_error_free(err);
+		return -EFAULT;
+	}
+
+	remove(transfer->filename);
+
+done:
+	transfer->fd = fd;
+	return fd;
+}
+
+struct obc_transfer *obc_transfer_get(DBusConnection *conn,
+					const char *agent,
+					const char *filename,
+					const char *name,
+					const char *type,
+					struct obc_transfer_params *params)
+{
+	struct obc_transfer *transfer;
+
+	transfer = obc_transfer_register(conn, agent, G_OBEX_OP_GET, filename,
+							name, type, params);
+	if (transfer == NULL)
+		return NULL;
+
+	if (transfer_open(transfer, O_WRONLY | O_CREAT | O_TRUNC, 0600) < 0) {
 		obc_transfer_free(transfer);
 		return NULL;
 	}
 
-done:
-	DBG("%p registered %s", transfer, transfer->path);
+	return transfer;
+}
+
+struct obc_transfer *obc_transfer_put(DBusConnection *conn,
+					const char *agent,
+					const char *filename,
+					const char *name,
+					const char *type,
+					const char *contents,
+					size_t size,
+					struct obc_transfer_params *params)
+{
+	struct obc_transfer *transfer;
+	struct stat st;
+	int perr;
+
+	transfer = obc_transfer_register(conn, agent, G_OBEX_OP_PUT, filename,
+							name, type, params);
+	if (transfer == NULL)
+		return NULL;
+
+	if (contents != NULL) {
+		ssize_t w;
+
+		perr = transfer_open(transfer, O_RDWR, 0);
+		if (perr < 0)
+			goto fail;
+
+		w = write(transfer->fd, contents, size);
+		if (w < 0) {
+			error("write(): %s(%d)", strerror(errno), errno);
+			perr = -errno;
+			goto fail;
+		} else if ((size_t) w != size) {
+			error("Unable to write all contents to file");
+			perr = -EFAULT;
+			goto fail;
+		}
+	} else {
+		perr = transfer_open(transfer, O_RDONLY, 0);
+		if (perr < 0)
+			goto fail;
+	}
+
+	perr = fstat(transfer->fd, &st);
+	if (perr < 0) {
+		error("fstat(): %s(%d)", strerror(errno), errno);
+		perr = -errno;
+		goto fail;
+	}
+
+	transfer->size = st.st_size;
 
 	return transfer;
+
+fail:
+	obc_transfer_free(transfer);
+	return NULL;
 }
 
 void obc_transfer_unregister(struct obc_transfer *transfer)
@@ -416,38 +524,9 @@ gboolean obc_transfer_set_callback(struct obc_transfer *transfer,
 	return TRUE;
 }
 
-static int transfer_open(struct obc_transfer *transfer, int flags, mode_t mode)
-{
-	GError *err = NULL;
-	int fd;
-
-	if (transfer->filename != NULL) {
-		fd = open(transfer->filename, flags, mode);
-		if (fd < 0) {
-			error("open(): %s(%d)", strerror(errno), errno);
-			return -errno;
-		}
-		goto done;
-	}
-
-	fd = g_file_open_tmp("obex-clientXXXXXX", &transfer->filename, &err);
-	if (fd < 0) {
-		error("g_file_open_tmp(): %s", err->message);
-		g_error_free(err);
-		return -EFAULT;
-	}
-
-	remove(transfer->filename);
-
-done:
-	transfer->fd = fd;
-	return fd;
-}
-
 static gboolean transfer_start_get(struct obc_transfer *transfer, GError **err)
 {
 	GObexPacket *req;
-	int perr;
 
 	if (transfer->xfer > 0) {
 		g_set_error(err, OBC_TRANSFER_ERROR, -EALREADY,
@@ -455,10 +534,6 @@ static gboolean transfer_start_get(struct obc_transfer *transfer, GError **err)
 		return FALSE;
 	}
 
-	perr = transfer_open(transfer, O_WRONLY | O_CREAT, 0600);
-	if (perr < 0)
-		return perr;
-
 	req = g_obex_packet_new(G_OBEX_OP_GET, TRUE, G_OBEX_HDR_INVALID);
 
 	if (transfer->name != NULL)
@@ -591,11 +666,21 @@ void obc_transfer_set_name(struct obc_transfer *transfer, const char *name)
 	transfer->name = g_strdup(name);
 }
 
-void obc_transfer_set_filename(struct obc_transfer *transfer,
+int obc_transfer_set_filename(struct obc_transfer *transfer,
 					const char *filename)
 {
+	int err;
+
+	err = rename(transfer->filename, filename);
+	if (err < 0) {
+		error("rename(): %s (%d)", strerror(errno), errno);
+		return -errno;
+	}
+
 	g_free(transfer->filename);
 	transfer->filename = g_strdup(filename);
+
+	return 0;
 }
 
 const char *obc_transfer_get_path(struct obc_transfer *transfer)
@@ -607,42 +692,3 @@ gint64 obc_transfer_get_size(struct obc_transfer *transfer)
 {
 	return transfer->size;
 }
-
-int obc_transfer_set_file(struct obc_transfer *transfer, const char *contents,
-								size_t size)
-{
-	int err;
-	struct stat st;
-
-	err = transfer_open(transfer, O_RDONLY, 0);
-	if (err < 0)
-		return err;
-
-	if (contents != NULL) {
-		ssize_t w = write(transfer->fd, contents, size);
-		if (w < 0) {
-			error("write(): %s(%d)", strerror(errno), errno);
-			err = -errno;
-			goto fail;
-		} else if ((size_t) w != size) {
-			error("Unable to write all contents to file");
-			err = -EFAULT;
-			goto fail;
-		}
-	}
-
-	err = fstat(transfer->fd, &st);
-	if (err < 0) {
-		error("fstat(): %s(%d)", strerror(errno), errno);
-		err = -errno;
-		goto fail;
-	}
-
-	transfer->size = st.st_size;
-
-	return 0;
-fail:
-	close(transfer->fd);
-	transfer->fd = -1;
-	return err;
-}
diff --git a/client/transfer.h b/client/transfer.h
index b044ce1..a84e415 100644
--- a/client/transfer.h
+++ b/client/transfer.h
@@ -32,13 +32,20 @@ typedef void (*transfer_callback_t) (struct obc_transfer *transfer,
 					gint64 transferred, GError *err,
 					void *user_data);
 
-struct obc_transfer *obc_transfer_register(DBusConnection *conn,
+struct obc_transfer *obc_transfer_get(DBusConnection *conn,
 					const char *agent,
-					guint8 op,
 					const char *filename,
 					const char *name,
 					const char *type,
 					struct obc_transfer_params *params);
+struct obc_transfer *obc_transfer_put(DBusConnection *conn,
+					const char *agent,
+					const char *filename,
+					const char *name,
+					const char *type,
+					const char *contents,
+					size_t size,
+					struct obc_transfer_params *params);
 
 void obc_transfer_unregister(struct obc_transfer *transfer);
 
@@ -56,9 +63,7 @@ int obc_transfer_get_contents(struct obc_transfer *transfer, char **contents,
 								size_t *size);
 
 void obc_transfer_set_name(struct obc_transfer *transfer, const char *name);
-void obc_transfer_set_filename(struct obc_transfer *transfer,
+int obc_transfer_set_filename(struct obc_transfer *transfer,
 					const char *filename);
 const char *obc_transfer_get_path(struct obc_transfer *transfer);
 gint64 obc_transfer_get_size(struct obc_transfer *transfer);
-int obc_transfer_set_file(struct obc_transfer *transfer, const char *contents,
-								size_t size);
-- 
1.7.7.6

