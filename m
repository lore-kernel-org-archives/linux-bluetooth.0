Return-Path: <cyrus@holtmann.org>
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH obexd 2/2] gobex: add check for connection id
Date: Mon,  7 Nov 2011 14:29:18 +0200
Message-Id: <1320668958-11238-2-git-send-email-luiz.dentz@gmail.com>
In-Reply-To: <1320668958-11238-1-git-send-email-luiz.dentz@gmail.com>
References: <1320668958-11238-1-git-send-email-luiz.dentz@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

From: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>

Since gobex maintain the connection id of the session it is more
convenient to check whether the incoming request connection matches
before calling the application handlers.
---
 gobex/gobex.c |   29 ++++++++++++++++++++++++++---
 1 files changed, 26 insertions(+), 3 deletions(-)

diff --git a/gobex/gobex.c b/gobex/gobex.c
index 61edbd5..62424ff 100644
--- a/gobex/gobex.c
+++ b/gobex/gobex.c
@@ -681,16 +681,39 @@ static void handle_response(GObex *obex, GError *err, GObexPacket *rsp)
 		enable_tx(obex);
 }
 
+static gboolean check_connid(GObex *obex, GObexPacket *pkt)
+{
+	GObexHeader *hdr;
+	guint32 id;
+
+	if (obex->conn_id == CONNID_INVALID)
+		return TRUE;
+
+	hdr = g_obex_packet_get_header(pkt, G_OBEX_HDR_CONNECTION);
+	if (hdr == NULL)
+		return FALSE;
+
+	g_obex_header_get_uint32(hdr, &id);
+
+	return obex->conn_id == id;
+}
+
 static void handle_request(GObex *obex, GObexPacket *req)
 {
 	GSList *match;
 	guint op;
 
-	if (g_obex_packet_get_operation(req, NULL) == G_OBEX_OP_CONNECT)
-		parse_connect_data(obex, req);
-
 	op = g_obex_packet_get_operation(req, NULL);
 
+	if (op == G_OBEX_OP_CONNECT)
+		parse_connect_data(obex, req);
+	else if (check_connid(obex, req) == FALSE) {
+		g_obex_debug(G_OBEX_DEBUG_ERROR, "Connection id don't match");
+		g_obex_send_rsp(obex, G_OBEX_RSP_SERVICE_UNAVAILABLE, NULL,
+							G_OBEX_HDR_INVALID);
+		return;
+	}
+
 	match = g_slist_find_custom(obex->req_handlers, GUINT_TO_POINTER(op),
 							req_handler_cmpop);
 	if (match) {
-- 
1.7.6.4

