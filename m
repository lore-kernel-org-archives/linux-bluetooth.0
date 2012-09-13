Return-Path: <cyrus@holtmann.org>
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH obexd 8/8] client: Avoid extra copies while passing apparam to transfer
Date: Thu, 13 Sep 2012 16:07:01 +0300
Message-Id: <1347541621-26858-8-git-send-email-luiz.dentz@gmail.com>
In-Reply-To: <1347541621-26858-1-git-send-email-luiz.dentz@gmail.com>
References: <1347541621-26858-1-git-send-email-luiz.dentz@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

From: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>

By passing directly the reference to GObexApparam it is no longer
necessary to use intermediate buffers to pass data around.
---
 client/map.c      | 29 ++++++++---------------
 client/pbap.c     | 42 +++++++++++----------------------
 client/transfer.c | 69 +++++++++++++++++++------------------------------------
 client/transfer.h |  6 ++---
 4 files changed, 47 insertions(+), 99 deletions(-)

diff --git a/client/map.c b/client/map.c
index 4b5f8a2..e78cd68 100644
--- a/client/map.c
+++ b/client/map.c
@@ -248,17 +248,14 @@ static DBusMessage *get_folder_listing(struct map_data *map,
 	struct obc_transfer *transfer;
 	GError *err = NULL;
 	DBusMessage *reply;
-	guint8 buf[8];
-	gsize len;
-
-	len = g_obex_apparam_encode(apparam, buf, sizeof(buf));
-	g_obex_apparam_free(apparam);
 
 	transfer = obc_transfer_get("x-obex/folder-listing", NULL, NULL, &err);
-	if (transfer == NULL)
+	if (transfer == NULL) {
+		g_obex_apparam_free(apparam);
 		goto fail;
+	}
 
-	obc_transfer_set_params(transfer, buf, len);
+	obc_transfer_set_apparam(transfer, apparam);
 
 	if (obc_session_queue(map->session, transfer, folder_listing_cb, map,
 								&err)) {
@@ -383,8 +380,6 @@ static DBusMessage *map_msg_get(DBusConnection *connection,
 	GError *err = NULL;
 	DBusMessage *reply;
 	GObexApparam *apparam;
-	guint8 buf[6];
-	gsize len;
 
 	if (dbus_message_get_args(message, NULL,
 				DBUS_TYPE_STRING, &target_file,
@@ -402,11 +397,8 @@ static DBusMessage *map_msg_get(DBusConnection *connection,
 								attachment);
 	apparam = g_obex_apparam_set_uint8(apparam, MAP_AP_CHARSET,
 								CHARSET_UTF8);
-	len = g_obex_apparam_encode(apparam, buf, sizeof(buf));
-
-	obc_transfer_set_params(transfer, buf, len);
 
-	g_obex_apparam_free(apparam);
+	obc_transfer_set_apparam(transfer, apparam);
 
 	if (!obc_session_queue(msg->data->session, transfer, NULL, NULL, &err))
 		goto fail;
@@ -739,17 +731,14 @@ static DBusMessage *get_message_listing(struct map_data *map,
 	struct obc_transfer *transfer;
 	GError *err = NULL;
 	DBusMessage *reply;
-	guint8 buf[1024];
-	gsize len;
-
-	len = g_obex_apparam_encode(apparam, buf, sizeof(buf));
-	g_obex_apparam_free(apparam);
 
 	transfer = obc_transfer_get("x-bt/MAP-msg-listing", folder, NULL, &err);
-	if (transfer == NULL)
+	if (transfer == NULL) {
+		g_obex_apparam_free(apparam);
 		goto fail;
+	}
 
-	obc_transfer_set_params(transfer, buf, len);
+	obc_transfer_set_apparam(transfer, apparam);
 
 	if (obc_session_queue(map->session, transfer, message_listing_cb, map,
 								&err)) {
diff --git a/client/pbap.c b/client/pbap.c
index a8db1cf..ea4a023 100644
--- a/client/pbap.c
+++ b/client/pbap.c
@@ -250,17 +250,11 @@ static void read_return_apparam(struct obc_transfer *transfer,
 				guint16 *phone_book_size, guint8 *new_missed_calls)
 {
 	GObexApparam *apparam;
-	const guint8 *data;
-	size_t size;
 
 	*phone_book_size = 0;
 	*new_missed_calls = 0;
 
-	data = obc_transfer_get_params(transfer, &size);
-	if (data == NULL)
-		return;
-
-	apparam = g_obex_apparam_decode(data, size);
+	apparam = obc_transfer_get_apparam(transfer);
 	if (apparam == NULL)
 		return;
 
@@ -269,7 +263,6 @@ static void read_return_apparam(struct obc_transfer *transfer,
 	g_obex_apparam_get_uint8(apparam, NEWMISSEDCALLS_TAG,
 							new_missed_calls);
 
-
 	g_obex_apparam_free(apparam);
 }
 
@@ -533,20 +526,17 @@ static DBusMessage *pull_phonebook(struct pbap_data *pbap,
 	struct pending_request *request;
 	struct obc_transfer *transfer;
 	char *name;
-	guint8 buf[32];
-	gsize len;
 	session_callback_t func;
 	DBusMessage *reply;
 	GError *err = NULL;
 
 	name = g_strconcat(pbap->path, ".vcf", NULL);
 
-	len = g_obex_apparam_encode(apparam, buf, sizeof(buf));
-	g_obex_apparam_free(apparam);
-
 	transfer = obc_transfer_get("x-bt/phonebook", name, targetfile, &err);
-	if (transfer == NULL)
+	if (transfer == NULL) {
+		g_obex_apparam_free(apparam);
 		goto fail;
+	}
 
 	switch (type) {
 	case PULLPHONEBOOK:
@@ -562,7 +552,7 @@ static DBusMessage *pull_phonebook(struct pbap_data *pbap,
 		return NULL;
 	}
 
-	obc_transfer_set_params(transfer, buf, len);
+	obc_transfer_set_apparam(transfer, apparam);
 
 	if (!obc_session_queue(pbap->session, transfer, func, request, &err)) {
 		if (request != NULL)
@@ -592,19 +582,16 @@ static DBusMessage *pull_vcard_listing(struct pbap_data *pbap,
 {
 	struct pending_request *request;
 	struct obc_transfer *transfer;
-	guint8 buf[272];
-	gsize len;
 	GError *err = NULL;
 	DBusMessage *reply;
 
-	len = g_obex_apparam_encode(apparam, buf, sizeof(buf));
-	g_obex_apparam_free(apparam);
-
 	transfer = obc_transfer_get("x-bt/vcard-listing", name, NULL, &err);
-	if (transfer == NULL)
+	if (transfer == NULL) {
+		g_obex_apparam_free(apparam);
 		goto fail;
+	}
 
-	obc_transfer_set_params(transfer, buf, len);
+	obc_transfer_set_apparam(transfer, apparam);
 
 	request = pending_request_new(pbap, message);
 	if (obc_session_queue(pbap->session, transfer,
@@ -711,17 +698,14 @@ static DBusMessage *pull_vcard(struct pbap_data *pbap, DBusMessage *message,
 	struct obc_transfer *transfer;
 	DBusMessage *reply;
 	GError *err = NULL;
-	guint8 buf[32];
-	gsize len;
-
-	len = g_obex_apparam_encode(apparam, buf, sizeof(buf));
-	g_obex_apparam_free(apparam);
 
 	transfer = obc_transfer_get("x-bt/vcard", name, targetfile, &err);
-	if (transfer == NULL)
+	if (transfer == NULL) {
+		g_obex_apparam_free(apparam);
 		goto fail;
+	}
 
-	obc_transfer_set_params(transfer, buf, len);
+	obc_transfer_set_apparam(transfer, apparam);
 
 	if (!obc_session_queue(pbap->session, transfer, NULL, NULL, &err))
 		goto fail;
diff --git a/client/transfer.c b/client/transfer.c
index e9fabfb..bd5277b 100644
--- a/client/transfer.c
+++ b/client/transfer.c
@@ -57,15 +57,10 @@ struct transfer_callback {
 	void *data;
 };
 
-struct obc_transfer_params {
-	void *data;
-	size_t size;
-};
-
 struct obc_transfer {
 	GObex *obex;
+	GObexApparam *apparam;
 	guint8 op;
-	struct obc_transfer_params *params;
 	struct transfer_callback *callback;
 	DBusConnection *conn;
 	DBusMessage *msg;
@@ -273,10 +268,8 @@ static void obc_transfer_free(struct obc_transfer *transfer)
 	if (transfer->fd > 0)
 		close(transfer->fd);
 
-	if (transfer->params != NULL) {
-		g_free(transfer->params->data);
-		g_free(transfer->params);
-	}
+	if (transfer->apparam != NULL)
+		g_obex_apparam_free(transfer->apparam);
 
 	if (transfer->conn)
 		dbus_connection_unref(transfer->conn);
@@ -529,6 +522,7 @@ static void get_xfer_progress_first(GObex *obex, GError *err, GObexPacket *rsp,
 	struct obc_transfer *transfer = user_data;
 	GObexPacket *req;
 	GObexHeader *hdr;
+	GObexApparam *apparam;
 	const guint8 *buf;
 	gsize len;
 	guint8 rspcode;
@@ -550,17 +544,9 @@ static void get_xfer_progress_first(GObex *obex, GError *err, GObexPacket *rsp,
 
 	hdr = g_obex_packet_get_header(rsp, G_OBEX_HDR_APPARAM);
 	if (hdr) {
-		g_obex_header_get_bytes(hdr, &buf, &len);
-		if (len != 0) {
-			if (transfer->params == NULL)
-				transfer->params =
-					g_new0(struct obc_transfer_params, 1);
-			else
-				g_free(transfer->params->data);
-
-			transfer->params->data = g_memdup(buf, len);
-			transfer->params->size = len;
-		}
+		apparam = g_obex_header_get_apparam(hdr);
+		if (apparam != NULL)
+			obc_transfer_set_apparam(transfer, apparam);
 	}
 
 	hdr = g_obex_packet_get_body(rsp);
@@ -642,6 +628,7 @@ static gboolean report_progress(gpointer data)
 static gboolean transfer_start_get(struct obc_transfer *transfer, GError **err)
 {
 	GObexPacket *req;
+	GObexHeader *hdr;
 
 	if (transfer->xfer > 0) {
 		g_set_error(err, OBC_TRANSFER_ERROR, -EALREADY,
@@ -659,10 +646,10 @@ static gboolean transfer_start_get(struct obc_transfer *transfer, GError **err)
 		g_obex_packet_add_bytes(req, G_OBEX_HDR_TYPE, transfer->type,
 						strlen(transfer->type) + 1);
 
-	if (transfer->params != NULL)
-		g_obex_packet_add_bytes(req, G_OBEX_HDR_APPARAM,
-						transfer->params->data,
-						transfer->params->size);
+	if (transfer->apparam != NULL) {
+		hdr = g_obex_header_new_apparam(transfer->apparam);
+		g_obex_packet_add_header(req, hdr);
+	}
 
 	transfer->xfer = g_obex_send_req(transfer->obex, req,
 						FIRST_PACKET_TIMEOUT,
@@ -683,6 +670,7 @@ static gboolean transfer_start_get(struct obc_transfer *transfer, GError **err)
 static gboolean transfer_start_put(struct obc_transfer *transfer, GError **err)
 {
 	GObexPacket *req;
+	GObexHeader *hdr;
 
 	if (transfer->xfer > 0) {
 		g_set_error(err, OBC_TRANSFER_ERROR, -EALREADY,
@@ -703,10 +691,10 @@ static gboolean transfer_start_put(struct obc_transfer *transfer, GError **err)
 	if (transfer->size < UINT32_MAX)
 		g_obex_packet_add_uint32(req, G_OBEX_HDR_LENGTH, transfer->size);
 
-	if (transfer->params != NULL)
-		g_obex_packet_add_bytes(req, G_OBEX_HDR_APPARAM,
-						transfer->params->data,
-						transfer->params->size);
+	if (transfer->apparam != NULL) {
+		hdr = g_obex_header_new_apparam(transfer->apparam);
+		g_obex_packet_add_header(req, hdr);
+	}
 
 	transfer->xfer = g_obex_put_req_pkt(transfer->obex, req,
 					put_xfer_progress, xfer_complete,
@@ -744,31 +732,20 @@ guint8 obc_transfer_get_operation(struct obc_transfer *transfer)
 	return transfer->op;
 }
 
-void obc_transfer_set_params(struct obc_transfer *transfer,
-						const void *data, size_t size)
+void obc_transfer_set_apparam(struct obc_transfer *transfer, void *data)
 {
-	if (transfer->params != NULL) {
-		g_free(transfer->params->data);
-		g_free(transfer->params);
-	}
+	if (transfer->apparam != NULL)
+		g_obex_apparam_free(transfer->apparam);
 
 	if (data == NULL)
 		return;
 
-	transfer->params = g_new0(struct obc_transfer_params, 1);
-	transfer->params->data = g_memdup(data, size);
-	transfer->params->size = size;
+	transfer->apparam = data;
 }
 
-const void *obc_transfer_get_params(struct obc_transfer *transfer, size_t *size)
+void *obc_transfer_get_apparam(struct obc_transfer *transfer)
 {
-	if (transfer->params == NULL)
-		return NULL;
-
-	if (size != NULL)
-		*size = transfer->params->size;
-
-	return transfer->params->data;
+	return transfer->apparam;
 }
 
 int obc_transfer_get_contents(struct obc_transfer *transfer, char **contents,
diff --git a/client/transfer.h b/client/transfer.h
index 968903a..f7d0423 100644
--- a/client/transfer.h
+++ b/client/transfer.h
@@ -50,10 +50,8 @@ gboolean obc_transfer_start(struct obc_transfer *transfer, void *obex,
 								GError **err);
 guint8 obc_transfer_get_operation(struct obc_transfer *transfer);
 
-void obc_transfer_set_params(struct obc_transfer *transfer,
-						const void *data, size_t size);
-const void *obc_transfer_get_params(struct obc_transfer *transfer,
-								size_t *size);
+void obc_transfer_set_apparam(struct obc_transfer *transfer, void *data);
+void *obc_transfer_get_apparam(struct obc_transfer *transfer);
 int obc_transfer_get_contents(struct obc_transfer *transfer, char **contents,
 								size_t *size);
 
-- 
1.7.11.4

