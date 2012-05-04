Return-Path: <cyrus@holtmann.org>
From: Mikel Astiz <mikel.astiz.oss@gmail.com>
To: linux-bluetooth@vger.kernel.org
Cc: Mikel Astiz <mikel.astiz@bmw-carit.de>
Subject: [PATCH obexd v0 4/6] client: Buffer-passing changes in transfer API
Date: Fri,  4 May 2012 14:39:36 +0200
Message-Id: <1336135178-21707-5-git-send-email-mikel.astiz.oss@gmail.com>
In-Reply-To: <1336135178-21707-1-git-send-email-mikel.astiz.oss@gmail.com>
References: <1336135178-21707-1-git-send-email-mikel.astiz.oss@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

From: Mikel Astiz <mikel.astiz@bmw-carit.de>

Transfer API now takes const buffers (both params and contents) and
internally copies the memory as necessary. This new API is safer to use,
which is convenient if the modules would start using it directly.
---
 client/session.c  |   23 ++++++-----------------
 client/transfer.c |   35 +++++++++++++++++++++++------------
 client/transfer.h |   12 +++---------
 3 files changed, 32 insertions(+), 38 deletions(-)

diff --git a/client/session.c b/client/session.c
index e9993c8..8523a86 100644
--- a/client/session.c
+++ b/client/session.c
@@ -963,7 +963,6 @@ guint obc_session_get(struct obc_session *session, const char *type,
 				GError **err)
 {
 	struct obc_transfer *transfer;
-	struct obc_transfer_params *params = NULL;
 
 	if (session->obex == NULL) {
 		g_set_error(err, OBEX_IO_ERROR, -ENOTCONN,
@@ -971,21 +970,10 @@ guint obc_session_get(struct obc_session *session, const char *type,
 		return 0;
 	}
 
-	if (apparam != NULL) {
-		params = g_new0(struct obc_transfer_params, 1);
-		params->data = g_new(guint8, apparam_size);
-		memcpy(params->data, apparam, apparam_size);
-		params->size = apparam_size;
-	}
-
-	transfer = obc_transfer_get(targetfile, name, type, params, err);
-	if (transfer == NULL) {
-		if (params != NULL) {
-			g_free(params->data);
-			g_free(params);
-		}
+	transfer = obc_transfer_get(targetfile, name, type, apparam,
+							apparam_size, err);
+	if (transfer == NULL)
 		return 0;
-	}
 
 	return session_request(session, transfer, func, user_data, err);
 }
@@ -1001,7 +989,8 @@ guint obc_session_send(struct obc_session *session, const char *filename,
 		return 0;
 	}
 
-	transfer = obc_transfer_put(filename, name, NULL, NULL, 0, NULL, err);
+	transfer = obc_transfer_put(filename, name, NULL, NULL, 0, NULL, 0,
+									err);
 	if (transfer == NULL)
 		return 0;
 
@@ -1058,7 +1047,7 @@ guint obc_session_put(struct obc_session *session, const char *contents,
 		return 0;
 	}
 
-	transfer = obc_transfer_put(NULL, name, NULL, contents, size, NULL,
+	transfer = obc_transfer_put(NULL, name, NULL, contents, size, NULL, 0,
 									err);
 	if (transfer == NULL)
 		return 0;
diff --git a/client/transfer.c b/client/transfer.c
index 7a55fe6..7bf687c 100644
--- a/client/transfer.c
+++ b/client/transfer.c
@@ -53,6 +53,11 @@ struct transfer_callback {
 	void *data;
 };
 
+struct obc_transfer_params {
+	void *data;
+	size_t size;
+};
+
 struct obc_transfer {
 	GObex *obex;
 	guint8 op;
@@ -226,7 +231,9 @@ static void obc_transfer_free(struct obc_transfer *transfer)
 static struct obc_transfer *obc_transfer_create(guint8 op,
 						const char *filename,
 						const char *name,
-						const char *type)
+						const char *type,
+						const void *params,
+						size_t psize)
 {
 	struct obc_transfer *transfer;
 
@@ -236,6 +243,12 @@ static struct obc_transfer *obc_transfer_create(guint8 op,
 	transfer->name = g_strdup(name);
 	transfer->type = g_strdup(type);
 
+	if (params != NULL) {
+		transfer->params = g_new0(struct obc_transfer_params, 1);
+		transfer->params->data = g_memdup(params, psize);
+		transfer->params->size = psize;
+	}
+
 	return transfer;
 }
 
@@ -309,13 +322,14 @@ done:
 struct obc_transfer *obc_transfer_get(const char *filename,
 					const char *name,
 					const char *type,
-					struct obc_transfer_params *params,
+					const void *params, size_t psize,
 					GError **err)
 {
 	struct obc_transfer *transfer;
 	int perr;
 
-	transfer = obc_transfer_create(G_OBEX_OP_GET, filename, name, type);
+	transfer = obc_transfer_create(G_OBEX_OP_GET, filename, name, type,
+								params, psize);
 
 	perr = transfer_open(transfer, O_WRONLY | O_CREAT | O_TRUNC, 0600, err);
 	if (perr < 0) {
@@ -323,24 +337,22 @@ struct obc_transfer *obc_transfer_get(const char *filename,
 		return NULL;
 	}
 
-	transfer->params = params;
-
 	return transfer;
 }
 
 struct obc_transfer *obc_transfer_put(const char *filename,
 					const char *name,
 					const char *type,
-					const char *contents,
-					size_t size,
-					struct obc_transfer_params *params,
+					const void *contents, size_t csize,
+					const void *params, size_t psize,
 					GError **err)
 {
 	struct obc_transfer *transfer;
 	struct stat st;
 	int perr;
 
-	transfer = obc_transfer_create(G_OBEX_OP_PUT, filename, name, type);
+	transfer = obc_transfer_create(G_OBEX_OP_PUT, filename, name, type,
+								params, psize);
 
 	if (contents != NULL) {
 		ssize_t w;
@@ -348,12 +360,12 @@ struct obc_transfer *obc_transfer_put(const char *filename,
 		if (!transfer_open(transfer, O_RDWR, 0, err))
 			goto fail;
 
-		w = write(transfer->fd, contents, size);
+		w = write(transfer->fd, contents, csize);
 		if (w < 0) {
 			error("write(): %s(%d)", strerror(errno), errno);
 			perr = -errno;
 			goto fail;
-		} else if ((size_t) w != size) {
+		} else if ((size_t) w != csize) {
 			error("Unable to write all contents to file");
 			perr = -EFAULT;
 			goto fail;
@@ -372,7 +384,6 @@ struct obc_transfer *obc_transfer_put(const char *filename,
 	}
 
 	transfer->size = st.st_size;
-	transfer->params = params;
 
 	return transfer;
 
diff --git a/client/transfer.h b/client/transfer.h
index 073b279..aebba7f 100644
--- a/client/transfer.h
+++ b/client/transfer.h
@@ -21,11 +21,6 @@
  *
  */
 
-struct obc_transfer_params {
-	void *data;
-	size_t size;
-};
-
 struct obc_transfer;
 
 typedef void (*transfer_callback_t) (struct obc_transfer *transfer,
@@ -35,14 +30,13 @@ typedef void (*transfer_callback_t) (struct obc_transfer *transfer,
 struct obc_transfer *obc_transfer_get(const char *filename,
 					const char *name,
 					const char *type,
-					struct obc_transfer_params *params,
+					const void *params, size_t psize,
 					GError **err);
 struct obc_transfer *obc_transfer_put(const char *filename,
 					const char *name,
 					const char *type,
-					const char *contents,
-					size_t size,
-					struct obc_transfer_params *params,
+					const void *contents, size_t csize,
+					const void *params, size_t psize,
 					GError **err);
 
 gboolean obc_transfer_register(struct obc_transfer *transfer,
-- 
1.7.7.6

