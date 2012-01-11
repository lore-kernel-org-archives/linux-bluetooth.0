Return-Path: <cyrus@holtmann.org>
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH obexd 3/3] Fix not responding SUCCESS code to GET in some conditions
Date: Wed, 11 Jan 2012 15:22:03 +0200
Message-Id: <1326288123-31807-3-git-send-email-luiz.dentz@gmail.com>
In-Reply-To: <1326288123-31807-1-git-send-email-luiz.dentz@gmail.com>
References: <1326288123-31807-1-git-send-email-luiz.dentz@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

From: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>

When there is no body to be transfer obexd is responding with CONTINUE.
---
 src/obex.c |   71 ++++++++++++++---------------------------------------------
 1 files changed, 17 insertions(+), 54 deletions(-)

diff --git a/src/obex.c b/src/obex.c
index eb91f4c..baa5904 100644
--- a/src/obex.c
+++ b/src/obex.c
@@ -574,33 +574,13 @@ static void transfer_complete(GObex *obex, GError *err, gpointer user_data)
 	}
 }
 
-static void cmd_get_rsp(GObex *obex, GObexPacket *req, gpointer user_data)
-{
-	struct obex_session *os = user_data;
-
-	DBG("");
-
-	print_event(G_OBEX_OP_GET, -1);
-
-	if (os->size != OBJECT_SIZE_UNKNOWN && os->size < UINT32_MAX)
-		g_obex_get_rsp(os->obex, send_data, transfer_complete,
-						os, NULL,
-						G_OBEX_HDR_LENGTH, os->size,
-						G_OBEX_HDR_INVALID);
-	else
-		g_obex_get_rsp(os->obex, send_data, transfer_complete,
-						os, NULL,
-						G_OBEX_HDR_INVALID);
-
-	print_event(G_OBEX_OP_GET, G_OBEX_RSP_CONTINUE);
-}
-
-static gssize driver_get_headers(struct obex_session *os)
+static int driver_get_headers(struct obex_session *os)
 {
 	GObexPacket *rsp;
-	gssize len, total = 0;
+	gssize len;
 	guint8 data[255];
 	guint8 id;
+	GObexHeader *hdr;
 
 	DBG("name=%s type=%s object=%p", os->name, os->type, os->object);
 
@@ -613,16 +593,13 @@ static gssize driver_get_headers(struct obex_session *os)
 	if (os->headers_sent)
 		return 0;
 
-	if (os->driver->get_next_header == NULL) {
-		os->headers_sent = TRUE;
-		return 0;
-	}
-
 	rsp = g_obex_packet_new(G_OBEX_RSP_CONTINUE, TRUE, G_OBEX_HDR_INVALID);
+
+	if (os->driver->get_next_header == NULL)
+		goto done;
+
 	while ((len = os->driver->get_next_header(os->object, &data,
 							sizeof(data), &id))) {
-		GObexHeader *hdr;
-
 		if (len < 0) {
 			error("get_next_header(): %s (%zd)", strerror(-len),
 								-len);
@@ -640,34 +617,22 @@ static gssize driver_get_headers(struct obex_session *os)
 
 		hdr = g_obex_header_new_bytes(id, data, len);
 		g_obex_packet_add_header(rsp, hdr);
-		total += len;
 	}
 
-	if (total != 0) {
-		g_obex_send(os->obex, rsp, NULL);
-		os->get_rsp = g_obex_add_request_function(os->obex,
-							G_OBEX_OP_GET,
-							cmd_get_rsp, os);
-		goto done;
+done:
+	if (os->size != OBJECT_SIZE_UNKNOWN && os->size < UINT32_MAX) {
+		hdr = g_obex_header_new_uint32(G_OBEX_HDR_LENGTH, os->size);
+		g_obex_packet_add_header(rsp, hdr);
 	}
 
-	g_obex_packet_free(rsp);
-	if (os->size != OBJECT_SIZE_UNKNOWN && os->size < UINT32_MAX)
-		g_obex_get_rsp(os->obex, send_data, transfer_complete,
-						os, NULL,
-						G_OBEX_HDR_LENGTH, os->size,
-						G_OBEX_HDR_INVALID);
-	else
-		g_obex_get_rsp(os->obex, send_data, transfer_complete,
-						os, NULL,
-						G_OBEX_HDR_INVALID);
+	g_obex_get_rsp_pkt(os->obex, rsp, send_data, transfer_complete, os,
+									NULL);
 
-done:
 	os->headers_sent = TRUE;
 
 	print_event(-1, G_OBEX_RSP_CONTINUE);
 
-	return total;
+	return 0;
 }
 
 static gboolean handle_async_io(void *object, int flags, int err,
@@ -893,13 +858,11 @@ int obex_get_stream_start(struct obex_session *os, const char *filename)
 	os->size = size;
 
 	err = driver_get_headers(os);
-	if (err == -EAGAIN) {
-		g_obex_suspend(os->obex);
-		os->driver->set_io_watch(os->object, handle_async_io, os);
-		return 0;
-	} else if (err < 0)
+	if (err != -EAGAIN)
 		return err;
 
+	g_obex_suspend(os->obex);
+	os->driver->set_io_watch(os->object, handle_async_io, os);
 	return 0;
 }
 
-- 
1.7.7.5

