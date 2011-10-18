Return-Path: <cyrus@holtmann.org>
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH obexd 3/7] gobex: log commands using G_OBEX_DEBUG_COMMAND
Date: Tue, 18 Oct 2011 11:17:03 +0300
Message-Id: <1318925827-5222-3-git-send-email-luiz.dentz@gmail.com>
In-Reply-To: <1318925827-5222-1-git-send-email-luiz.dentz@gmail.com>
References: <1318925827-5222-1-git-send-email-luiz.dentz@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

From: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>

---
 gobex/gobex.c |   26 ++++++++++++++++++++++++++
 1 files changed, 26 insertions(+), 0 deletions(-)

diff --git a/gobex/gobex.c b/gobex/gobex.c
index 0ccf428..0a381a5 100644
--- a/gobex/gobex.c
+++ b/gobex/gobex.c
@@ -371,6 +371,8 @@ gboolean g_obex_send(GObex *obex, GObexPacket *pkt, GError **err)
 	struct pending_pkt *p;
 	gboolean ret;
 
+	g_obex_debug(G_OBEX_DEBUG_COMMAND, "conn %u", obex->conn_id);
+
 	if (obex == NULL || pkt == NULL) {
 		g_set_error(err, G_OBEX_ERROR, G_OBEX_ERROR_INVALID_ARGS,
 				"Invalid arguments");
@@ -399,6 +401,8 @@ guint g_obex_send_req(GObex *obex, GObexPacket *req, gint timeout,
 	struct pending_pkt *p;
 	static guint id = 1;
 
+	g_obex_debug(G_OBEX_DEBUG_COMMAND, "conn %u", obex->conn_id);
+
 	if (obex->conn_id == CONNID_INVALID)
 		goto create_pending;
 
@@ -587,6 +591,8 @@ gboolean g_obex_remove_request_function(GObex *obex, guint id)
 
 void g_obex_suspend(GObex *obex)
 {
+	g_obex_debug(G_OBEX_DEBUG_COMMAND, "conn %u", obex->conn_id);
+
 	if (obex->write_source > 0) {
 		g_source_remove(obex->write_source);
 		obex->write_source = 0;
@@ -597,6 +603,8 @@ void g_obex_suspend(GObex *obex)
 
 void g_obex_resume(GObex *obex)
 {
+	g_obex_debug(G_OBEX_DEBUG_COMMAND, "conn %u", obex->conn_id);
+
 	obex->suspended = FALSE;
 
 	if (g_queue_get_length(obex->tx_queue) > 0 || obex->tx_data > 0)
@@ -908,6 +916,8 @@ GObex *g_obex_new(GIOChannel *io, GObexTransportType transport_type,
 			gobex_debug = G_OBEX_DEBUG_NONE;
 	}
 
+	g_obex_debug(G_OBEX_DEBUG_COMMAND, "");
+
 	if (io == NULL)
 		return NULL;
 
@@ -969,6 +979,8 @@ GObex *g_obex_ref(GObex *obex)
 
 	g_atomic_int_inc(&obex->ref_count);
 
+	g_obex_debug(G_OBEX_DEBUG_COMMAND, "ref %u", obex->ref_count);
+
 	return obex;
 }
 
@@ -978,6 +990,8 @@ void g_obex_unref(GObex *obex)
 
 	last_ref = g_atomic_int_dec_and_test(&obex->ref_count);
 
+	g_obex_debug(G_OBEX_DEBUG_COMMAND, "ref %u", obex->ref_count);
+
 	if (!last_ref)
 		return;
 
@@ -1013,6 +1027,8 @@ guint g_obex_connect(GObex *obex, GObexResponseFunc func, gpointer user_data,
 	struct connect_data data;
 	va_list args;
 
+	g_obex_debug(G_OBEX_DEBUG_COMMAND, "");
+
 	va_start(args, first_hdr_id);
 	req = g_obex_packet_new_valist(G_OBEX_OP_CONNECT, TRUE,
 							first_hdr_id, args);
@@ -1030,6 +1046,8 @@ guint g_obex_setpath(GObex *obex, const char *path, GObexResponseFunc func,
 	GObexPacket *req;
 	struct setpath_data data;
 
+	g_obex_debug(G_OBEX_DEBUG_COMMAND, "conn %u", obex->conn_id);
+
 	req = g_obex_packet_new(G_OBEX_OP_SETPATH, TRUE, G_OBEX_HDR_INVALID);
 
 	memset(&data, 0, sizeof(data));
@@ -1054,6 +1072,8 @@ guint g_obex_mkdir(GObex *obex, const char *path, GObexResponseFunc func,
 	GObexPacket *req;
 	struct setpath_data data;
 
+	g_obex_debug(G_OBEX_DEBUG_COMMAND, "conn %u", obex->conn_id);
+
 	req = g_obex_packet_new(G_OBEX_OP_SETPATH, TRUE, G_OBEX_HDR_NAME, path,
 							G_OBEX_HDR_INVALID);
 
@@ -1068,6 +1088,8 @@ guint g_obex_delete(GObex *obex, const char *name, GObexResponseFunc func,
 {
 	GObexPacket *req;
 
+	g_obex_debug(G_OBEX_DEBUG_COMMAND, "conn %u", obex->conn_id);
+
 	req = g_obex_packet_new(G_OBEX_OP_PUT, TRUE, G_OBEX_HDR_NAME, name,
 							G_OBEX_HDR_INVALID);
 
@@ -1080,6 +1102,8 @@ guint g_obex_copy(GObex *obex, const char *name, const char *dest,
 {
 	GObexPacket *req;
 
+	g_obex_debug(G_OBEX_DEBUG_COMMAND, "conn %u", obex->conn_id);
+
 	req = g_obex_packet_new(G_OBEX_OP_ACTION, TRUE,
 					G_OBEX_HDR_ACTION, G_OBEX_ACTION_COPY,
 					G_OBEX_HDR_NAME, name,
@@ -1095,6 +1119,8 @@ guint g_obex_move(GObex *obex, const char *name, const char *dest,
 {
 	GObexPacket *req;
 
+	g_obex_debug(G_OBEX_DEBUG_COMMAND, "conn %u", obex->conn_id);
+
 	req = g_obex_packet_new(G_OBEX_OP_ACTION, TRUE,
 					G_OBEX_HDR_ACTION, G_OBEX_ACTION_MOVE,
 					G_OBEX_HDR_NAME, name,
-- 
1.7.6.4

