Return-Path: <cyrus@holtmann.org>
From: Mikel Astiz <mikel.astiz@bmw-carit.de>
To: <linux-bluetooth@vger.kernel.org>
CC: Mikel Astiz <mikel.astiz@bmw-carit.de>
Subject: [RFC obexd v2 20/21] client: report size in GET operations
Date: Thu, 8 Dec 2011 16:27:54 +0100
Message-ID: <1323358075-27857-21-git-send-email-mikel.astiz@bmw-carit.de>
In-Reply-To: <1323358075-27857-1-git-send-email-mikel.astiz@bmw-carit.de>
References: <1323358075-27857-1-git-send-email-mikel.astiz@bmw-carit.de>
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Some apps might be interested in the size of an ongoing GET transfer. In
order to expose this value in D-Bus, gobex needs to be extended, so that
such size can be reported using a specific callback for this purpose.
---
 client/transfer.c      |   36 ++++++++++++++++++++++++++++++++----
 gobex/gobex-defs.h     |    1 +
 gobex/gobex-transfer.c |   28 +++++++++++++++++++++++++++-
 gobex/gobex.h          |    1 +
 4 files changed, 61 insertions(+), 5 deletions(-)

diff --git a/client/transfer.c b/client/transfer.c
index 38c832c..3fa848a 100644
--- a/client/transfer.c
+++ b/client/transfer.c
@@ -29,6 +29,7 @@
 #include <fcntl.h>
 #include <unistd.h>
 #include <stdlib.h>
+#include <stdio.h>
 #include <stdint.h>
 #include <assert.h>
 #include <string.h>
@@ -476,12 +477,31 @@ static void xfer_complete(GObex *obex, GError *err, gpointer user_data)
 	transfer_notify_complete(transfer);
 }
 
+static gboolean get_xfer_size(gsize size, gpointer user_data)
+{
+	struct obc_transfer *transfer = user_data;
+
+	if (transfer->size != 0)
+		return TRUE;
+
+	transfer->size = size;
+
+	obex_dbus_signal_property_changed(transfer->conn,
+					transfer->path,
+					TRANSFER_INTERFACE, "Size",
+					DBUS_TYPE_INT64,
+					&transfer->size);
+
+	return TRUE;
+}
+
 static gboolean get_xfer_progress(const void *buf, gsize len,
 							gpointer user_data)
 {
 	struct obc_transfer *transfer = user_data;
 	gssize size;
 	GError *err = NULL;
+	char msg[8];
 
 	if (transfer->file_location != NULL) {
 		struct file_location *location = transfer->file_location;
@@ -517,7 +537,14 @@ static gboolean get_xfer_progress(const void *buf, gsize len,
 	assert((transfer->transferred <= transfer->size) ||
 							(transfer->size == 0));
 
-	DBG("GET progress: %lu bytes", transfer->transferred);
+	if (transfer->size == 0)
+		msg[0] = '\0';
+	else {
+		sprintf(msg, " (%d%%)", (int) (100 * transfer->transferred /
+							transfer->size));
+	}
+
+	DBG("GET progress: %lu bytes%s", transfer->transferred, msg);
 
 	transfer_notify_progress(transfer);
 
@@ -594,9 +621,10 @@ static void obc_transfer_start_get(struct obc_transfer *transfer, GObex *obex)
 						transfer->params->data,
 						transfer->params->size);
 
-	transfer->xfer = g_obex_get_req_pkt(obex, req, get_xfer_progress,
-							xfer_complete, transfer,
-							&err);
+	transfer->xfer = g_obex_get_req_pkt(obex, req, get_xfer_size,
+						get_xfer_progress,
+						xfer_complete,
+						transfer, &err);
 	if (transfer->xfer == 0)
 		goto fail;
 
diff --git a/gobex/gobex-defs.h b/gobex/gobex-defs.h
index 9c2ab53..3720f07 100644
--- a/gobex/gobex-defs.h
+++ b/gobex/gobex-defs.h
@@ -43,6 +43,7 @@ typedef enum {
 } GObexError;
 
 typedef gssize (*GObexDataProducer) (void *buf, gsize len, gpointer user_data);
+typedef gboolean (*GObexDataSizeFunc) (gsize len, gpointer user_data);
 typedef gboolean (*GObexDataConsumer) (const void *buf, gsize len,
 							gpointer user_data);
 
diff --git a/gobex/gobex-transfer.c b/gobex/gobex-transfer.c
index f5222cd..b84a020 100644
--- a/gobex/gobex-transfer.c
+++ b/gobex/gobex-transfer.c
@@ -45,6 +45,7 @@ struct transfer {
 	guint get_id;
 	guint abort_id;
 
+	GObexDataSizeFunc data_size_func;
 	GObexDataProducer data_producer;
 	GObexDataConsumer data_consumer;
 	GObexFunc complete_func;
@@ -140,6 +141,30 @@ static gboolean handle_get_body(struct transfer *transfer, GObexPacket *rsp,
 	const guint8 *buf;
 	gsize len;
 
+	if (transfer->data_size_func != NULL) {
+		GObexHeader *hdr;
+
+		hdr = g_obex_packet_get_header(rsp, G_OBEX_HDR_LENGTH);
+
+		if (hdr != NULL) {
+			guint32 size;
+			g_obex_header_get_uint32(hdr, &size);
+
+			ret = transfer->data_size_func(size,
+							transfer->user_data);
+
+			transfer->data_size_func = NULL;
+
+			if (ret == FALSE) {
+				g_set_error(err, G_OBEX_ERROR,
+					G_OBEX_ERROR_CANCELLED,
+					"Data size consumer callback failed");
+
+				return FALSE;
+			}
+		}
+	}
+
 	if (body == NULL)
 		return TRUE;
 
@@ -392,7 +417,6 @@ guint g_obex_put_rsp(GObex *obex, GObexPacket *req,
 	transfer = transfer_new(obex, G_OBEX_OP_PUT, complete_func, user_data);
 	transfer->data_consumer = data_func;
 
-
 	va_start(args, first_hdr_id);
 	transfer_put_req_first(transfer, req, first_hdr_id, args);
 	va_end(args);
@@ -413,6 +437,7 @@ guint g_obex_put_rsp(GObex *obex, GObexPacket *req,
 }
 
 guint g_obex_get_req_pkt(GObex *obex, GObexPacket *req,
+			GObexDataSizeFunc data_size_func,
 			GObexDataConsumer data_func, GObexFunc complete_func,
 			gpointer user_data, GError **err)
 {
@@ -424,6 +449,7 @@ guint g_obex_get_req_pkt(GObex *obex, GObexPacket *req,
 		return 0;
 
 	transfer = transfer_new(obex, G_OBEX_OP_GET, complete_func, user_data);
+	transfer->data_size_func = data_size_func;
 	transfer->data_consumer = data_func;
 
 	transfer->req_id = g_obex_send_req(obex, req, FIRST_PACKET_TIMEOUT,
diff --git a/gobex/gobex.h b/gobex/gobex.h
index 1b20333..d54b2f3 100644
--- a/gobex/gobex.h
+++ b/gobex/gobex.h
@@ -105,6 +105,7 @@ guint g_obex_get_req(GObex *obex, GObexDataConsumer data_func,
 			GError **err, guint8 first_hdr_id, ...);
 
 guint g_obex_get_req_pkt(GObex *obex, GObexPacket *req,
+			GObexDataSizeFunc data_size_func,
 			GObexDataConsumer data_func, GObexFunc complete_func,
 			gpointer user_data, GError **err);
 
-- 
1.7.6.4

