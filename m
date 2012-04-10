Return-Path: <cyrus@holtmann.org>
From: Mikel Astiz <mikel.astiz.oss@gmail.com>
To: linux-bluetooth@vger.kernel.org
Cc: Mikel Astiz <mikel.astiz@bmw-carit.de>
Subject: [PATCH obexd v1 10/11] client: unify transfer implementation
Date: Tue, 10 Apr 2012 15:38:31 +0200
Message-Id: <1334065112-14966-11-git-send-email-mikel.astiz.oss@gmail.com>
In-Reply-To: <1334065112-14966-1-git-send-email-mikel.astiz.oss@gmail.com>
References: <1334065112-14966-1-git-send-email-mikel.astiz.oss@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

From: Mikel Astiz <mikel.astiz@bmw-carit.de>

This patch simplifies the internal handling of transfers by unifying put
and get operations, while also sharing most of the code between memory-
based and file-based transfers.
---
 client/transfer.c |  333 +++++++++++++++++++++-------------------------------
 1 files changed, 135 insertions(+), 198 deletions(-)

diff --git a/client/transfer.c b/client/transfer.c
index 04dd178..c7d74a9 100644
--- a/client/transfer.c
+++ b/client/transfer.c
@@ -183,7 +183,7 @@ static void transfer_notify_error(struct obc_transfer *transfer, GError *err)
 	struct transfer_callback *callback = transfer->callback;
 	struct file_location *location = transfer->file_location;
 
-	if ((transfer->direction == OBC_TRANSFER_GET) && (location != NULL)) {
+	if ((transfer->command == OBC_TRANSFER_GET) && (location != NULL)) {
 		if (location->fd > 0) {
 			close(location->fd);
 			location->fd = 0;
@@ -494,86 +494,14 @@ struct obc_transfer *obc_transfer_create_mem(DBusConnection *conn,
 	return transfer;
 }
 
-static void obc_transfer_read(struct obc_transfer *transfer,
-						const void *buf, gsize len)
+static void handle_get_apparams(struct obc_transfer *transfer, GObexPacket *rsp)
 {
-	struct mem_location *location = transfer->mem_location;
-	gsize bsize;
-
-	assert(location != NULL);
-
-	/* copy all buffered data */
-	bsize = location->buffer_len - transfer->transferred;
-
-	if (bsize < len) {
-		location->buffer_len += len - bsize;
-		location->buffer = g_realloc(location->buffer,
-							location->buffer_len);
-	}
-
-	memcpy(location->buffer + transfer->transferred, buf, len);
-
-	transfer->transferred += len;
-}
-
-static void get_buf_xfer_complete(GObex *obex, GError *err, gpointer user_data)
-{
-	struct obc_transfer *transfer = user_data;
-	struct mem_location *location = transfer->mem_location;
-	gsize bsize;
-
-	assert(location != NULL);
-
-	transfer->xfer = 0;
-
-	if (err)
-		goto done;
-
-	if (transfer->transferred > 0 &&
-		((char *) location->buffer)[transfer->transferred - 1] == '\0')
-		goto done;
-
-	bsize = location->buffer_len - transfer->transferred;
-	if (bsize < 1) {
-		location->buffer_len += 1;
-		location->buffer = g_realloc(location->buffer,
-						location->buffer_len);
-	}
-
-	((char *) location->buffer)[transfer->transferred] = '\0';
-	transfer->size = strlen(location->buffer);
-
-done:
-	transfer_notify_complete(transfer);
-}
-
-static void get_buf_xfer_progress(GObex *obex, GError *err, GObexPacket *rsp,
-							gpointer user_data)
-{
-	struct obc_transfer *transfer = user_data;
-	GObexPacket *req;
 	GObexHeader *hdr;
 	const guint8 *buf;
 	gsize len;
-	guint8 rspcode;
-	gboolean final;
-
-	if (err != NULL) {
-		get_buf_xfer_complete(obex, err, transfer);
-		return;
-	}
-
-	rspcode = g_obex_packet_get_operation(rsp, &final);
-	if (rspcode != G_OBEX_RSP_SUCCESS && rspcode != G_OBEX_RSP_CONTINUE) {
-		err = g_error_new(OBC_TRANSFER_ERROR, rspcode,
-					"Transfer failed (0x%02x)", rspcode);
-		get_buf_xfer_complete(obex, err, transfer);
-		g_error_free(err);
-		return;
-	}
 
 	hdr = g_obex_packet_get_header(rsp, G_OBEX_HDR_APPARAM);
-	if (hdr) {
+	if (hdr != NULL) {
 		g_obex_header_get_bytes(hdr, &buf, &len);
 		if (len != 0) {
 			if (transfer->params == NULL)
@@ -586,103 +514,104 @@ static void get_buf_xfer_progress(GObex *obex, GError *err, GObexPacket *rsp,
 			transfer->params->size = len;
 		}
 	}
-
-	hdr = g_obex_packet_get_body(rsp);
-	if (hdr) {
-		g_obex_header_get_bytes(hdr, &buf, &len);
-		if (len != 0)
-			obc_transfer_read(transfer, buf, len);
-	}
-
-	if (rspcode == G_OBEX_RSP_SUCCESS) {
-		get_buf_xfer_complete(obex, err, transfer);
-		return;
-	}
-
-	if (!g_obex_srm_active(obex)) {
-		req = g_obex_packet_new(G_OBEX_OP_GET, TRUE, G_OBEX_HDR_INVALID);
-
-		transfer->xfer = g_obex_send_req(obex, req, -1,
-							get_buf_xfer_progress,
-							transfer, &err);
-	}
-
-	transfer_notify_progress(transfer);
 }
 
-static void xfer_complete(GObex *obex, GError *err, gpointer user_data)
+static gboolean handle_get_body(struct obc_transfer *transfer, GObexPacket *rsp)
 {
-	struct obc_transfer *transfer = user_data;
+	GObexHeader *body = g_obex_packet_get_body(rsp);
+	GError *err;
+	const guint8 *buf;
+	gsize len;
 
-	transfer->xfer = 0;
+	if (body == NULL)
+		return TRUE;
 
-	if (err != NULL) {
-		transfer_notify_error(transfer, err);
-		return;
-	}
+	g_obex_header_get_bytes(body, &buf, &len);
+	if (len == 0)
+		return TRUE;
 
-	transfer->size = transfer->transferred;
+	if (transfer->file_location != NULL) {
+		struct file_location *location = transfer->file_location;
 
-	transfer_notify_complete(transfer);
-}
+		if (write(location->fd, buf, len) < (ssize_t) len) {
+			err = g_error_new(OBC_TRANSFER_ERROR, -EIO,
+								"Write failed");
+			goto failed;
+		}
+	} else {
+		struct mem_location *location = transfer->mem_location;
+		gsize bsize;
 
-static gboolean get_xfer_progress(const void *buf, gsize len,
-							gpointer user_data)
-{
-	struct obc_transfer *transfer = user_data;
-	struct file_location *location = transfer->file_location;
+		assert(location != NULL);
 
-	assert(location != NULL);
-	assert(location->fd > 0);
+		/* copy all buffered data */
+		bsize = location->buffer_len - transfer->transferred;
 
-	if (write(location->fd, buf, len) < (ssize_t) len)
-		return FALSE;
+		/* for convenience, leave space for final null character */
+		if (bsize < len + 1) {
+			location->buffer_len += len + 1 - bsize;
+			location->buffer = g_realloc(location->buffer,
+							location->buffer_len);
+		}
+
+		memcpy(location->buffer + transfer->transferred, buf, len);
+	}
+
+	transfer->transferred += len;
 
 	transfer_notify_progress(transfer);
 
 	return TRUE;
+
+failed:
+	error("%s", err->message);
+	transfer_notify_error(transfer, err);
+	g_clear_error(&err);
+	return FALSE;
 }
 
-static gssize put_buf_xfer_progress(void *buf, gsize len, gpointer user_data)
+static gssize put_get_data(void *buf, gsize len, gpointer user_data)
 {
 	struct obc_transfer *transfer = user_data;
-	struct mem_location *location = transfer->mem_location;
-	gsize size;
+	GObexPacket *req;
+	GError *err = NULL;
+	gssize size;
 
-	assert(location != NULL);
+	if (transfer->file_location != NULL) {
+		size = read(transfer->file_location->fd, buf, len);
+		if (size < 0)
+			goto failed;
+	} else {
+		struct mem_location *location = transfer->mem_location;
 
-	if (transfer->transferred == transfer->size)
-		return 0;
+		assert(location != NULL);
 
-	size = transfer->size - transfer->transferred;
-	size = len > size ? len : size;
-	if (size == 0)
-		return 0;
+		if (transfer->transferred == transfer->size)
+			return 0;
 
-	memcpy(buf, location->buffer + transfer->transferred, size);
+		size = transfer->size - transfer->transferred;
+		size = (gssize) len > size ? (gssize) len : size;
+
+		if (size > 0)
+			memcpy(buf, location->buffer + transfer->transferred,
+									size);
+	}
 
 	transfer->transferred += size;
 
 	transfer_notify_progress(transfer);
 
 	return size;
-}
-
-static gssize put_xfer_progress(void *buf, gsize len, gpointer user_data)
-{
-	struct obc_transfer *transfer = user_data;
-	struct file_location *location = transfer->file_location;
-	gssize size;
-
-	size = read(location->fd, buf, len);
-	if (size <= 0)
-		return size;
 
-	transfer->transferred += size;
+failed:
+	err = g_error_new(OBC_TRANSFER_ERROR, -EIO, "Read failed");
+	transfer_notify_error(transfer, err);
+	g_clear_error(&err);
 
-	transfer_notify_progress(transfer);
+	req = g_obex_packet_new(G_OBEX_OP_ABORT, TRUE, G_OBEX_HDR_INVALID);
+	g_obex_send_req(transfer->obex, req, -1, NULL, NULL, NULL);
 
-	return size;
+	return -1;
 }
 
 gboolean obc_transfer_set_callback(struct obc_transfer *transfer,
@@ -703,59 +632,67 @@ gboolean obc_transfer_set_callback(struct obc_transfer *transfer,
 	return TRUE;
 }
 
-static gboolean transfer_start_get(struct obc_transfer *transfer, GError **err)
+static void xfer_response(GObex *obex, GError *err, GObexPacket *rsp,
+							gpointer user_data)
 {
+	struct obc_transfer *transfer = user_data;
 	GObexPacket *req;
-	GObexDataConsumer data_cb;
-	GObexFunc complete_cb;
-	GObexResponseFunc rsp_cb = NULL;
+	gboolean rspcode, final;
 
-	if (transfer->xfer > 0) {
-		g_set_error(err, OBC_TRANSFER_ERROR, -EALREADY,
-						"Transfer already started");
-		return FALSE;
+	transfer->xfer = 0;
+
+	if (err != NULL) {
+		transfer_notify_error(transfer, err);
+		return;
 	}
 
-	if (transfer->mem_location != NULL)
-		rsp_cb = get_buf_xfer_progress;
-	else {
-		data_cb = get_xfer_progress;
-		complete_cb = xfer_complete;
+	rspcode = g_obex_packet_get_operation(rsp, &final);
+	if (rspcode != G_OBEX_RSP_SUCCESS && rspcode != G_OBEX_RSP_CONTINUE) {
+		err = g_error_new(OBC_TRANSFER_ERROR, rspcode,
+					"Transfer failed (0x%02x)", rspcode);
+		transfer_notify_error(transfer, err);
+		g_error_free(err);
+		return;
 	}
 
-	req = g_obex_packet_new(G_OBEX_OP_GET, TRUE, G_OBEX_HDR_INVALID);
+	if (transfer->command == OBC_TRANSFER_GET) {
+		handle_get_apparams(transfer, rsp);
 
-	if (transfer->name != NULL)
-		g_obex_packet_add_unicode(req, G_OBEX_HDR_NAME,
-							transfer->name);
+		if (handle_get_body(transfer, rsp) == FALSE)
+			return;
+	}
 
-	if (transfer->type != NULL)
-		g_obex_packet_add_bytes(req, G_OBEX_HDR_TYPE, transfer->type,
-						strlen(transfer->type) + 1);
+	if (rspcode == G_OBEX_RSP_SUCCESS) {
+		if (transfer->mem_location != NULL) {
+			char *buf = transfer->mem_location->buffer;
 
-	if (transfer->params != NULL)
-		g_obex_packet_add_bytes(req, G_OBEX_HDR_APPARAM,
-						transfer->params->data,
-						transfer->params->size);
+			buf[transfer->transferred] = '\0';
+		}
 
-	if (rsp_cb)
-		transfer->xfer = g_obex_send_req(transfer->obex, req, -1,
-						rsp_cb, transfer, err);
-	else
-		transfer->xfer = g_obex_get_req_pkt(transfer->obex, req,
-						data_cb, complete_cb, transfer,
-						err);
+		transfer->size = transfer->transferred;
 
-	if (transfer->xfer == 0)
-		return FALSE;
+		transfer_notify_complete(transfer);
+		return;
+	}
 
-	return TRUE;
+	if (transfer->command == OBC_TRANSFER_PUT) {
+		req = g_obex_packet_new(G_OBEX_OP_PUT, FALSE,
+							G_OBEX_HDR_INVALID);
+		g_obex_packet_add_body(req, put_get_data, transfer);
+	} else if (!g_obex_srm_active(transfer->obex)) {
+		req = g_obex_packet_new(G_OBEX_OP_GET, TRUE,
+							G_OBEX_HDR_INVALID);
+	} else
+		return;
+
+	transfer->xfer = g_obex_send_req(obex, req, -1, xfer_response,
+							transfer, &err);
 }
 
-static gboolean transfer_start_put(struct obc_transfer *transfer, GError **err)
+static gboolean transfer_start_obex(struct obc_transfer *transfer, GError **err)
 {
 	GObexPacket *req;
-	GObexDataProducer data_cb;
+	guint8 opcode;
 
 	if (transfer->xfer > 0) {
 		g_set_error(err, OBC_TRANSFER_ERROR, -EALREADY,
@@ -763,12 +700,12 @@ static gboolean transfer_start_put(struct obc_transfer *transfer, GError **err)
 		return FALSE;
 	}
 
-	if (transfer->mem_location != NULL)
-		data_cb = put_buf_xfer_progress;
+	if (transfer->command == OBC_TRANSFER_PUT)
+		opcode = G_OBEX_OP_PUT;
 	else
-		data_cb = put_xfer_progress;
+		opcode = G_OBEX_OP_GET;
 
-	req = g_obex_packet_new(G_OBEX_OP_PUT, FALSE, G_OBEX_HDR_INVALID);
+	req = g_obex_packet_new(opcode, FALSE, G_OBEX_HDR_INVALID);
 
 	if (transfer->name != NULL)
 		g_obex_packet_add_unicode(req, G_OBEX_HDR_NAME,
@@ -778,37 +715,37 @@ static gboolean transfer_start_put(struct obc_transfer *transfer, GError **err)
 		g_obex_packet_add_bytes(req, G_OBEX_HDR_TYPE, transfer->type,
 						strlen(transfer->type) + 1);
 
-	if (transfer->size < UINT32_MAX)
-		g_obex_packet_add_uint32(req, G_OBEX_HDR_LENGTH, transfer->size);
+	if (transfer->command == OBC_TRANSFER_PUT) {
+		if (transfer->size < UINT32_MAX)
+			g_obex_packet_add_uint32(req, G_OBEX_HDR_LENGTH,
+								transfer->size);
+	}
 
 	if (transfer->params != NULL)
 		g_obex_packet_add_bytes(req, G_OBEX_HDR_APPARAM,
 						transfer->params->data,
 						transfer->params->size);
 
-	transfer->xfer = g_obex_put_req_pkt(transfer->obex, req, data_cb,
-						xfer_complete, transfer,
-						err);
-	if (transfer->xfer == 0)
-		return FALSE;
+	transfer->xfer = g_obex_send_req(transfer->obex, req, -1, xfer_response,
+							transfer, err);
+	if (transfer->xfer > 0)
+		return TRUE;
 
-	return TRUE;
+	return FALSE;
 }
 
 gboolean obc_transfer_start(struct obc_transfer *transfer, GObex *obex,
 								GError **err)
 {
-	transfer->obex = g_obex_ref(obex);
-
-	switch (transfer->command) {
-	case OBC_TRANSFER_GET:
-		return transfer_start_get(transfer, err);
-	case OBC_TRANSFER_PUT:
-		return transfer_start_put(transfer, err);
+	if (transfer->xfer > 0) {
+		g_set_error(err, OBC_TRANSFER_ERROR, -EALREADY,
+						"Transfer already started");
+		return FALSE;
 	}
 
-	g_set_error(err, OBC_TRANSFER_ERROR, -ENOTSUP, "Not supported");
-	return FALSE;
+	transfer->obex = g_obex_ref(obex);
+
+	return transfer_start_obex(transfer, err);
 }
 
 ObcTransferCommand obc_transfer_get_cmd(struct obc_transfer *transfer)
-- 
1.7.7.6

