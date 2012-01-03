Return-Path: <cyrus@holtmann.org>
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH obexd 3/4] gobex: automatically use SRM when transport type is SOCK_SEQPACKET
Date: Tue,  3 Jan 2012 15:52:23 +0200
Message-Id: <1325598744-18855-3-git-send-email-luiz.dentz@gmail.com>
In-Reply-To: <1325598744-18855-1-git-send-email-luiz.dentz@gmail.com>
References: <1325598744-18855-1-git-send-email-luiz.dentz@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

From: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>

This simplifies the applications so SRM setup phase became transparent
while using SOCK_SEQPACKET which is useful for GOEP 2.0 since in that
case we can only use SRM if the transport is L2CAP.

This also follows GOEP 2.0 Page 14 - 4.6 Using Single Response Mode:

  "The Server cannot issue an enable request, but can only issue a
  response to an enable request from the Client. SRM will remain in
  effect for the duration of the operation that enabled it (PUT or GET)
  ...
  SRM headers shall not be sent in CONNECT request or response packets."

and Page 22 - 5.4 Establishment of OBEX Connection:

  "SRM headers shall not be sent in the Connect request or response
  packets (note, this is to preserve backwards compatibility). SRM shall
  be enabled through Put and Get operations only."

So only in case of PUT or GET requests SRM is automatically configured,
applications can still enable it manually for other operations by adding
the headers like before but it is not recommended.

Note that it would be a good practice to indicate SRM support by using
value 0x02, but since that should happens during CONNECT command it is
not done automatically for requests when acting as a client, server
responding to indicate requests will automatically add SRM headers though.
---
 gobex/gobex.c |   56 +++++++++++++++++++++++++++++++++++++++++++++++++++++++-
 1 files changed, 55 insertions(+), 1 deletions(-)

diff --git a/gobex/gobex.c b/gobex/gobex.c
index ed051ee..0db4567 100644
--- a/gobex/gobex.c
+++ b/gobex/gobex.c
@@ -72,6 +72,7 @@ struct _GObex {
 	size_t tx_sent;
 
 	gboolean suspended;
+	gboolean use_srm;
 
 	struct srm_config *srm;
 
@@ -505,6 +506,9 @@ static void setup_srm(GObex *obex, GObexPacket *pkt, gboolean outgoing)
 	guint8 op;
 	gboolean final;
 
+	if (!obex->use_srm)
+		return;
+
 	op = g_obex_packet_get_operation(pkt, &final);
 
 	hdr = g_obex_packet_get_header(pkt, G_OBEX_HDR_SRM);
@@ -538,6 +542,24 @@ static void setup_srm(GObex *obex, GObexPacket *pkt, gboolean outgoing)
 	set_srm(obex, op, G_OBEX_SRM_DISABLE);
 }
 
+static void prepare_srm_rsp(GObex *obex, GObexPacket *pkt)
+{
+	GObexHeader *hdr;
+
+	if (!obex->use_srm || obex->srm == NULL)
+		return;
+
+	if (obex->srm->enabled)
+		return;
+
+	hdr = g_obex_packet_get_header(pkt, G_OBEX_HDR_SRM);
+	if (hdr != NULL)
+		return;
+
+	hdr = g_obex_header_new_uint8(G_OBEX_HDR_SRM, G_OBEX_SRM_ENABLE);
+	g_obex_packet_prepend_header(pkt, hdr);
+}
+
 gboolean g_obex_send(GObex *obex, GObexPacket *pkt, GError **err)
 {
 	struct pending_pkt *p;
@@ -552,8 +574,14 @@ gboolean g_obex_send(GObex *obex, GObexPacket *pkt, GError **err)
 		return FALSE;
 	}
 
-	if (obex->rx_last_op == G_OBEX_OP_CONNECT)
+	switch (obex->rx_last_op) {
+	case G_OBEX_OP_CONNECT:
 		prepare_connect_rsp(obex, pkt);
+	case G_OBEX_OP_GET:
+	case G_OBEX_OP_PUT:
+		prepare_srm_rsp(obex, pkt);
+		break;
+	}
 
 	setup_srm(obex, pkt, TRUE);
 
@@ -567,6 +595,24 @@ gboolean g_obex_send(GObex *obex, GObexPacket *pkt, GError **err)
 	return ret;
 }
 
+static void prepare_srm_req(GObex *obex, GObexPacket *pkt)
+{
+	GObexHeader *hdr;
+
+	if (!obex->use_srm)
+		return;
+
+	if (obex->srm != NULL && obex->srm->enabled)
+		return;
+
+	hdr = g_obex_packet_get_header(pkt, G_OBEX_HDR_SRM);
+	if (hdr != NULL)
+		return;
+
+	hdr = g_obex_header_new_uint8(G_OBEX_HDR_SRM, G_OBEX_SRM_ENABLE);
+	g_obex_packet_prepend_header(pkt, hdr);
+}
+
 guint g_obex_send_req(GObex *obex, GObexPacket *req, gint timeout,
 			GObexResponseFunc func, gpointer user_data,
 			GError **err)
@@ -574,9 +620,16 @@ guint g_obex_send_req(GObex *obex, GObexPacket *req, gint timeout,
 	GObexHeader *hdr;
 	struct pending_pkt *p;
 	static guint id = 1;
+	guint8 op;
 
 	g_obex_debug(G_OBEX_DEBUG_COMMAND, "conn %u", obex->conn_id);
 
+	op = g_obex_packet_get_operation(req, NULL);
+	if (op == G_OBEX_OP_PUT || op == G_OBEX_OP_GET) {
+		/* Only enable SRM automatically for GET and PUT */
+		prepare_srm_req(obex, req);
+	}
+
 	setup_srm(obex, req, TRUE);
 
 	if (obex->conn_id == CONNID_INVALID)
@@ -1226,6 +1279,7 @@ GObex *g_obex_new(GIOChannel *io, GObexTransportType transport_type,
 		obex->write = write_stream;
 		break;
 	case G_OBEX_TRANSPORT_PACKET:
+		obex->use_srm = TRUE;
 		obex->read = read_packet;
 		obex->write = write_packet;
 		break;
-- 
1.7.7.4

