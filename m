Return-Path: <cyrus@holtmann.org>
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH BlueZ 2/4] gobex: Respond to authentication challenge
Date: Fri, 28 Mar 2014 15:38:37 +0200
Message-Id: <1396013919-15122-2-git-send-email-luiz.dentz@gmail.com>
In-Reply-To: <1396013919-15122-1-git-send-email-luiz.dentz@gmail.com>
References: <1396013919-15122-1-git-send-email-luiz.dentz@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

From: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>

This implements authentication response as defined in OBEX specification
since it is a mandatory feature for many Bluetooth profiles.
---
 gobex/gobex.c | 127 +++++++++++++++++++++++++++++++++++++++++++++++++++-------
 1 file changed, 113 insertions(+), 14 deletions(-)

diff --git a/gobex/gobex.c b/gobex/gobex.c
index ca15941..880ed91 100644
--- a/gobex/gobex.c
+++ b/gobex/gobex.c
@@ -44,6 +44,13 @@
 
 #define CONNID_INVALID		0xffffffff
 
+/* Challenge request */
+#define NONCE_TAG		0x00
+#define NONCE_LEN		16
+
+/* Challenge response */
+#define DIGEST_TAG		0x00
+
 guint gobex_debug = 0;
 
 struct srm_config {
@@ -85,6 +92,7 @@ struct _GObex {
 	guint16 tx_mtu;
 
 	guint32 conn_id;
+	GObexApparam *authchal;
 
 	GQueue *tx_queue;
 
@@ -106,6 +114,7 @@ struct pending_pkt {
 	gpointer rsp_data;
 	gboolean cancelled;
 	gboolean suspended;
+	gboolean authenticating;
 };
 
 struct req_handler {
@@ -546,26 +555,84 @@ static void init_connect_data(GObex *obex, struct connect_data *data)
 	memcpy(&data->mtu, &u16, sizeof(u16));
 }
 
+static guint8 *digest_response(const guint8 *nonce)
+{
+	GChecksum *md5;
+	guint8 *result;
+	gsize size;
+
+	result = g_new0(guint8, NONCE_LEN);
+
+	md5 = g_checksum_new(G_CHECKSUM_MD5);
+	if (md5 == NULL)
+		return result;
+
+	g_checksum_update(md5, nonce, NONCE_LEN);
+	g_checksum_update(md5, (guint8 *) ":BlueZ", 6);
+
+	size = NONCE_LEN;
+	g_checksum_get_digest(md5, result, &size);
+
+	g_checksum_free(md5);
+
+	return result;
+}
+
+static void prepare_auth_rsp(GObex *obex, GObexPacket *rsp)
+{
+	GObexHeader *hdr;
+	GObexApparam *authrsp;
+	const guint8 *nonce;
+	guint8 *result;
+	gsize len;
+
+	/* Check if client is already responding to authentication challenge */
+	hdr = g_obex_packet_get_header(rsp, G_OBEX_HDR_AUTHRESP);
+	if (hdr)
+		goto done;
+
+	if (!g_obex_apparam_get_bytes(obex->authchal, NONCE_TAG, &nonce, &len))
+		goto done;
+
+	if (len != NONCE_LEN)
+		goto done;
+
+	result = digest_response(nonce);
+	authrsp = g_obex_apparam_set_bytes(NULL, DIGEST_TAG, result, NONCE_LEN);
+
+	hdr = g_obex_header_new_tag(G_OBEX_HDR_AUTHRESP, authrsp);
+	g_obex_packet_add_header(rsp, hdr);
+
+	g_obex_apparam_free(authrsp);
+
+done:
+	g_obex_apparam_free(obex->authchal);
+	obex->authchal = NULL;
+}
+
 static void prepare_connect_rsp(GObex *obex, GObexPacket *rsp)
 {
-	GObexHeader *connid;
+	GObexHeader *hdr;
 	struct connect_data data;
 	static guint32 next_connid = 1;
 
 	init_connect_data(obex, &data);
 	g_obex_packet_set_data(rsp, &data, sizeof(data), G_OBEX_DATA_COPY);
 
-	connid = g_obex_packet_get_header(rsp, G_OBEX_HDR_CONNECTION);
-	if (connid != NULL) {
-		g_obex_header_get_uint32(connid, &obex->conn_id);
-		return;
+	hdr = g_obex_packet_get_header(rsp, G_OBEX_HDR_CONNECTION);
+	if (hdr) {
+		g_obex_header_get_uint32(hdr, &obex->conn_id);
+		goto done;
 	}
 
 	obex->conn_id = next_connid++;
 
-	connid = g_obex_header_new_uint32(G_OBEX_HDR_CONNECTION,
-							obex->conn_id);
-	g_obex_packet_prepend_header(rsp, connid);
+	hdr = g_obex_header_new_uint32(G_OBEX_HDR_CONNECTION, obex->conn_id);
+	g_obex_packet_prepend_header(rsp, hdr);
+
+done:
+	if (obex->authchal)
+		prepare_auth_rsp(obex, rsp);
 }
 
 static void prepare_srm_rsp(GObex *obex, GObexPacket *pkt)
@@ -936,10 +1003,27 @@ done:
 	return ret;
 }
 
+static void auth_challenge(GObex *obex)
+{
+	struct pending_pkt *p = obex->pending_req;
+
+	if (p->authenticating)
+		return;
+
+	p->authenticating = TRUE;
+
+	prepare_auth_rsp(obex, p->pkt);
+
+	/* Remove it as pending and add it back to the queue so it gets sent
+	 * again */
+	obex->pending_req = NULL;
+	g_obex_send_internal(obex, p, NULL);
+}
+
 static void parse_connect_data(GObex *obex, GObexPacket *pkt)
 {
 	const struct connect_data *data;
-	GObexHeader *connid;
+	GObexHeader *hdr;
 	guint16 u16;
 	size_t data_len;
 
@@ -954,9 +1038,13 @@ static void parse_connect_data(GObex *obex, GObexPacket *pkt)
 		obex->tx_mtu = obex->io_tx_mtu;
 	obex->tx_buf = g_realloc(obex->tx_buf, obex->tx_mtu);
 
-	connid = g_obex_packet_get_header(pkt, G_OBEX_HDR_CONNECTION);
-	if (connid != NULL)
-		g_obex_header_get_uint32(connid, &obex->conn_id);
+	hdr = g_obex_packet_get_header(pkt, G_OBEX_HDR_CONNECTION);
+	if (hdr)
+		g_obex_header_get_uint32(hdr, &obex->conn_id);
+
+	hdr = g_obex_packet_get_header(pkt, G_OBEX_HDR_AUTHCHAL);
+	if (hdr)
+		obex->authchal = g_obex_header_get_apparam(hdr);
 }
 
 static gboolean parse_response(GObex *obex, GObexPacket *rsp)
@@ -968,8 +1056,11 @@ static gboolean parse_response(GObex *obex, GObexPacket *rsp)
 	rspcode = g_obex_packet_get_operation(rsp, &final);
 
 	opcode = g_obex_packet_get_operation(p->pkt, NULL);
-	if (opcode == G_OBEX_OP_CONNECT)
+	if (opcode == G_OBEX_OP_CONNECT) {
 		parse_connect_data(obex, rsp);
+		if (rspcode == G_OBEX_RSP_UNAUTHORIZED && obex->authchal)
+			auth_challenge(obex);
+	}
 
 	setup_srm(obex, rsp, FALSE);
 
@@ -993,12 +1084,17 @@ static gboolean parse_response(GObex *obex, GObexPacket *rsp)
 
 static void handle_response(GObex *obex, GError *err, GObexPacket *rsp)
 {
-	struct pending_pkt *p = obex->pending_req;
+	struct pending_pkt *p;
 	gboolean disconn = err ? TRUE : FALSE, final_rsp = TRUE;
 
 	if (rsp != NULL)
 		final_rsp = parse_response(obex, rsp);
 
+	if (!obex->pending_req)
+		return;
+
+	p = obex->pending_req;
+
 	if (p->cancelled)
 		err = g_error_new(G_OBEX_ERROR, G_OBEX_ERROR_CANCELLED,
 					"The operation was cancelled");
@@ -1420,6 +1516,9 @@ void g_obex_unref(GObex *obex)
 	if (obex->pending_req)
 		pending_pkt_free(obex->pending_req);
 
+	if (obex->authchal)
+		g_obex_apparam_free(obex->authchal);
+
 	g_free(obex);
 }
 
-- 
1.8.5.3

