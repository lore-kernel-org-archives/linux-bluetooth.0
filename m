Return-Path: <cyrus@holtmann.org>
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH obexd 2/7] gobex: log errors using G_OBEX_DEBUG_ERROR
Date: Tue, 18 Oct 2011 15:47:27 +0300
Message-Id: <1318942052-15475-2-git-send-email-luiz.dentz@gmail.com>
In-Reply-To: <1318942052-15475-1-git-send-email-luiz.dentz@gmail.com>
References: <1318942052-15475-1-git-send-email-luiz.dentz@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

From: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>

---
 gobex/gobex-header.c   |    4 ++++
 gobex/gobex-packet.c   |    4 ++++
 gobex/gobex-transfer.c |    8 ++++++++
 gobex/gobex.c          |   32 +++++++++++++++++++++++++-------
 4 files changed, 41 insertions(+), 7 deletions(-)

diff --git a/gobex/gobex-header.c b/gobex/gobex-header.c
index 0dade51..45fe0e6 100644
--- a/gobex/gobex-header.c
+++ b/gobex/gobex-header.c
@@ -26,6 +26,7 @@
 #include <string.h>
 
 #include "gobex-header.h"
+#include "gobex-debug.h"
 
 /* Header types */
 #define G_OBEX_HDR_ENC_UNICODE	(0 << 6)
@@ -143,6 +144,7 @@ GObexHeader *g_obex_header_decode(const void *data, gsize len,
 	if (len < 2) {
 		g_set_error(err, G_OBEX_ERROR, G_OBEX_ERROR_PARSE_ERROR,
 						"Too short header in packet");
+		g_obex_debug(G_OBEX_DEBUG_ERROR, "%s", (*err)->message);
 		return NULL;
 	}
 
@@ -266,6 +268,8 @@ GObexHeader *g_obex_header_decode(const void *data, gsize len,
 	return header;
 
 failed:
+	if (*err)
+		g_obex_debug(G_OBEX_DEBUG_ERROR, "%s", (*err)->message);
 	g_obex_header_free(header);
 	return NULL;
 }
diff --git a/gobex/gobex-packet.c b/gobex/gobex-packet.c
index df94031..80accd1 100644
--- a/gobex/gobex-packet.c
+++ b/gobex/gobex-packet.c
@@ -28,6 +28,7 @@
 
 #include "gobex-defs.h"
 #include "gobex-packet.h"
+#include "gobex-debug.h"
 
 #define FINAL_BIT 0x80
 
@@ -291,12 +292,14 @@ GObexPacket *g_obex_packet_decode(const void *data, gsize len,
 	if (data_policy == G_OBEX_DATA_INHERIT) {
 		g_set_error(err, G_OBEX_ERROR, G_OBEX_ERROR_INVALID_ARGS,
 							"Invalid data policy");
+		g_obex_debug(G_OBEX_DEBUG_ERROR, "%s", (*err)->message);
 		return NULL;
 	}
 
 	if (len < 3 + header_offset) {
 		g_set_error(err, G_OBEX_ERROR, G_OBEX_ERROR_PARSE_ERROR,
 					"Not enough data to decode packet");
+		g_obex_debug(G_OBEX_DEBUG_ERROR, "%s", (*err)->message);
 		return NULL;
 	}
 
@@ -308,6 +311,7 @@ GObexPacket *g_obex_packet_decode(const void *data, gsize len,
 		g_set_error(err, G_OBEX_ERROR, G_OBEX_ERROR_PARSE_ERROR,
 				"Incorrect packet length (%u != %zu)",
 				packet_len, len);
+		g_obex_debug(G_OBEX_DEBUG_ERROR, "%s", (*err)->message);
 		return NULL;
 	}
 
diff --git a/gobex/gobex-transfer.c b/gobex/gobex-transfer.c
index 7278cb3..4ccf535 100644
--- a/gobex/gobex-transfer.c
+++ b/gobex/gobex-transfer.c
@@ -19,10 +19,15 @@
  *
  */
 
+#ifdef HAVE_CONFIG_H
+# include "config.h"
+#endif
+
 #include <string.h>
 #include <errno.h>
 
 #include "gobex.h"
+#include "gobex-debug.h"
 
 #define FIRST_PACKET_TIMEOUT 60
 
@@ -89,6 +94,7 @@ static void transfer_abort_response(GObex *obex, GError *err, GObexPacket *rsp,
 	/* Intentionally override error */
 	err = g_error_new(G_OBEX_ERROR, G_OBEX_ERROR_CANCELLED,
 						"Operation was aborted");
+	g_obex_debug(G_OBEX_DEBUG_ERROR, "%s", err->message);
 	transfer_complete(transfer, err);
 	g_error_free(err);
 }
@@ -188,6 +194,7 @@ static void transfer_response(GObex *obex, GError *err, GObexPacket *rsp,
 							transfer, &err);
 failed:
 	if (err != NULL) {
+		g_obex_debug(G_OBEX_DEBUG_ERROR, "%s", err->message);
 		transfer_complete(transfer, err);
 		g_error_free(err);
 	}
@@ -448,6 +455,7 @@ static gssize get_get_data(void *buf, gsize len, gpointer user_data)
 
 	err = g_error_new(G_OBEX_ERROR, G_OBEX_ERROR_CANCELLED,
 				"Data producer function failed");
+	g_obex_debug(G_OBEX_DEBUG_ERROR, "%s", err->message);
 	transfer_complete(transfer, err);
 	g_error_free(err);
 
diff --git a/gobex/gobex.c b/gobex/gobex.c
index e1cf5e3..da2ff01 100644
--- a/gobex/gobex.c
+++ b/gobex/gobex.c
@@ -168,18 +168,23 @@ static gboolean req_timeout(gpointer user_data)
 {
 	GObex *obex = user_data;
 	struct pending_pkt *p = obex->pending_req;
+	GError *err;
 
 	g_assert(p != NULL);
 
 	obex->pending_req = NULL;
 
-	if (p->rsp_func) {
-		GError *err = g_error_new(G_OBEX_ERROR, G_OBEX_ERROR_TIMEOUT,
+	err = g_error_new(G_OBEX_ERROR, G_OBEX_ERROR_TIMEOUT,
 					"Timed out waiting for response");
+
+	g_obex_debug(G_OBEX_DEBUG_ERROR, "%s", err->message);
+
+	obex->pending_req = NULL;
+
+	if (p->rsp_func)
 		p->rsp_func(obex, err, NULL, p->rsp_data);
-		g_error_free(err);
-	}
 
+	g_error_free(err);
 	pending_pkt_free(p);
 
 	return FALSE;
@@ -311,6 +316,7 @@ static gboolean g_obex_send_internal(GObex *obex, struct pending_pkt *p,
 	if (obex->io == NULL) {
 		g_set_error(err, G_OBEX_ERROR, G_OBEX_ERROR_DISCONNECTED,
 					"The transport is not connected");
+		g_obex_debug(G_OBEX_DEBUG_ERROR, "%s", (*err)->message);
 		return FALSE;
 	}
 
@@ -368,6 +374,7 @@ gboolean g_obex_send(GObex *obex, GObexPacket *pkt, GError **err)
 	if (obex == NULL || pkt == NULL) {
 		g_set_error(err, G_OBEX_ERROR, G_OBEX_ERROR_INVALID_ARGS,
 				"Invalid arguments");
+		g_obex_debug(G_OBEX_DEBUG_ERROR, "%s", (*err)->message);
 		return FALSE;
 	}
 
@@ -638,6 +645,10 @@ static void handle_response(GObex *obex, GError *err, GObexPacket *rsp)
 		err = g_error_new(G_OBEX_ERROR, G_OBEX_ERROR_CANCELLED,
 					"The operation was cancelled");
 
+	if (err)
+		g_obex_debug(G_OBEX_DEBUG_ERROR, "%s", err->message);
+
+
 	if (p->rsp_func) {
 		p->rsp_func(obex, err, rsp, p->rsp_data);
 
@@ -709,6 +720,7 @@ static gboolean read_stream(GObex *obex, GError **err)
 	if (obex->rx_pkt_len > obex->rx_mtu) {
 		g_set_error(err, G_OBEX_ERROR, G_OBEX_ERROR_PARSE_ERROR,
 				"Too big incoming packet");
+		g_obex_debug(G_OBEX_DEBUG_ERROR, "%s", (*err)->message);
 		return FALSE;
 	}
 
@@ -741,7 +753,7 @@ static gboolean read_packet(GObex *obex, GError **err)
 	if (obex->rx_data > 0) {
 		g_set_error(err, G_OBEX_ERROR, G_OBEX_ERROR_PARSE_ERROR,
 				"RX buffer not empty before reading packet");
-		return FALSE;
+		goto fail;
 	}
 
 	status = g_io_channel_read_chars(io, (gchar *) obex->rx_buf,
@@ -750,7 +762,7 @@ static gboolean read_packet(GObex *obex, GError **err)
 		g_set_error(err, G_OBEX_ERROR, G_OBEX_ERROR_PARSE_ERROR,
 				"Unable to read data: %s", read_err->message);
 		g_error_free(read_err);
-		return FALSE;
+		goto fail;
 	}
 
 	obex->rx_data += rbytes;
@@ -758,7 +770,7 @@ static gboolean read_packet(GObex *obex, GError **err)
 	if (rbytes < 3) {
 		g_set_error(err, G_OBEX_ERROR, G_OBEX_ERROR_PARSE_ERROR,
 				"Incomplete packet received");
-		return FALSE;
+		goto fail;
 	}
 
 	memcpy(&u16, &obex->rx_buf[1], sizeof(u16));
@@ -772,6 +784,9 @@ static gboolean read_packet(GObex *obex, GError **err)
 	}
 
 	return TRUE;
+fail:
+	g_obex_debug(G_OBEX_DEBUG_ERROR, "%s", (*err)->message);
+	return FALSE;
 }
 
 static gboolean incoming_data(GIOChannel *io, GIOCondition cond,
@@ -846,6 +861,9 @@ static gboolean incoming_data(GIOChannel *io, GIOCondition cond,
 	return TRUE;
 
 failed:
+	if (err)
+		g_obex_debug(G_OBEX_DEBUG_ERROR, "%s", err->message);
+
 	g_io_channel_unref(obex->io);
 	obex->io = NULL;
 	obex->io_source = 0;
-- 
1.7.6.4

