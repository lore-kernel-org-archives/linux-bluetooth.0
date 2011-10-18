Return-Path: <cyrus@holtmann.org>
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH obexd 6/7 v2] gobex: log packets using G_OBEX_DEBUG_PACKET
Date: Tue, 18 Oct 2011 15:47:31 +0300
Message-Id: <1318942052-15475-6-git-send-email-luiz.dentz@gmail.com>
In-Reply-To: <1318942052-15475-1-git-send-email-luiz.dentz@gmail.com>
References: <1318942052-15475-1-git-send-email-luiz.dentz@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

From: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>

---
 gobex/gobex-packet.c |   38 ++++++++++++++++++++++++++++++++++++++
 1 files changed, 38 insertions(+), 0 deletions(-)

diff --git a/gobex/gobex-packet.c b/gobex/gobex-packet.c
index 80accd1..b539430 100644
--- a/gobex/gobex-packet.c
+++ b/gobex/gobex-packet.c
@@ -55,6 +55,8 @@ GObexHeader *g_obex_packet_get_header(GObexPacket *pkt, guint8 id)
 {
 	GSList *l;
 
+	g_obex_debug(G_OBEX_DEBUG_PACKET, "opcode 0x%02x", pkt->opcode);
+
 	for (l = pkt->headers; l != NULL; l = g_slist_next(l)) {
 		GObexHeader *hdr = l->data;
 
@@ -69,6 +71,8 @@ GObexHeader *g_obex_packet_get_body(GObexPacket *pkt)
 {
 	GObexHeader *body;
 
+	g_obex_debug(G_OBEX_DEBUG_PACKET, "opcode 0x%02x", pkt->opcode);
+
 	body = g_obex_packet_get_header(pkt, G_OBEX_HDR_BODY);
 	if (body != NULL)
 		return body;
@@ -78,6 +82,8 @@ GObexHeader *g_obex_packet_get_body(GObexPacket *pkt)
 
 guint8 g_obex_packet_get_operation(GObexPacket *pkt, gboolean *final)
 {
+	g_obex_debug(G_OBEX_DEBUG_PACKET, "opcode 0x%02x", pkt->opcode);
+
 	if (final)
 		*final = pkt->final;
 
@@ -86,6 +92,8 @@ guint8 g_obex_packet_get_operation(GObexPacket *pkt, gboolean *final)
 
 gboolean g_obex_packet_prepend_header(GObexPacket *pkt, GObexHeader *header)
 {
+	g_obex_debug(G_OBEX_DEBUG_PACKET, "opcode 0x%02x", pkt->opcode);
+
 	pkt->headers = g_slist_prepend(pkt->headers, header);
 	pkt->hlen += g_obex_header_get_length(header);
 
@@ -94,6 +102,8 @@ gboolean g_obex_packet_prepend_header(GObexPacket *pkt, GObexHeader *header)
 
 gboolean g_obex_packet_add_header(GObexPacket *pkt, GObexHeader *header)
 {
+	g_obex_debug(G_OBEX_DEBUG_PACKET, "opcode 0x%02x", pkt->opcode);
+
 	pkt->headers = g_slist_append(pkt->headers, header);
 	pkt->hlen += g_obex_header_get_length(header);
 
@@ -103,6 +113,8 @@ gboolean g_obex_packet_add_header(GObexPacket *pkt, GObexHeader *header)
 gboolean g_obex_packet_add_body(GObexPacket *pkt, GObexDataProducer func,
 							gpointer user_data)
 {
+	g_obex_debug(G_OBEX_DEBUG_PACKET, "opcode 0x%02x", pkt->opcode);
+
 	if (pkt->get_body != NULL)
 		return FALSE;
 
@@ -117,6 +129,8 @@ gboolean g_obex_packet_add_unicode(GObexPacket *pkt, guint8 id,
 {
 	GObexHeader *hdr;
 
+	g_obex_debug(G_OBEX_DEBUG_PACKET, "opcode 0x%02x", pkt->opcode);
+
 	hdr = g_obex_header_new_unicode(id, str);
 	if (hdr == NULL)
 		return FALSE;
@@ -129,6 +143,8 @@ gboolean g_obex_packet_add_bytes(GObexPacket *pkt, guint8 id,
 {
 	GObexHeader *hdr;
 
+	g_obex_debug(G_OBEX_DEBUG_PACKET, "opcode 0x%02x", pkt->opcode);
+
 	hdr = g_obex_header_new_bytes(id, data, len);
 	if (hdr == NULL)
 		return FALSE;
@@ -140,6 +156,8 @@ gboolean g_obex_packet_add_uint8(GObexPacket *pkt, guint8 id, guint8 val)
 {
 	GObexHeader *hdr;
 
+	g_obex_debug(G_OBEX_DEBUG_PACKET, "opcode 0x%02x", pkt->opcode);
+
 	hdr = g_obex_header_new_uint8(id, val);
 	if (hdr == NULL)
 		return FALSE;
@@ -151,6 +169,8 @@ gboolean g_obex_packet_add_uint32(GObexPacket *pkt, guint8 id, guint32 val)
 {
 	GObexHeader *hdr;
 
+	g_obex_debug(G_OBEX_DEBUG_PACKET, "opcode 0x%02x", pkt->opcode);
+
 	hdr = g_obex_header_new_uint32(id, val);
 	if (hdr == NULL)
 		return FALSE;
@@ -160,6 +180,8 @@ gboolean g_obex_packet_add_uint32(GObexPacket *pkt, guint8 id, guint32 val)
 
 const void *g_obex_packet_get_data(GObexPacket *pkt, gsize *len)
 {
+	g_obex_debug(G_OBEX_DEBUG_PACKET, "opcode 0x%02x", pkt->opcode);
+
 	if (pkt->data_len == 0) {
 		*len = 0;
 		return NULL;
@@ -181,6 +203,8 @@ const void *g_obex_packet_get_data(GObexPacket *pkt, gsize *len)
 gboolean g_obex_packet_set_data(GObexPacket *pkt, const void *data, gsize len,
 						GObexDataPolicy data_policy)
 {
+	g_obex_debug(G_OBEX_DEBUG_PACKET, "opcode 0x%02x", pkt->opcode);
+
 	if (pkt->data.buf || pkt->data.buf_ref)
 		return FALSE;
 
@@ -207,6 +231,8 @@ GObexPacket *g_obex_packet_new_valist(guint8 opcode, gboolean final,
 {
 	GObexPacket *pkt;
 
+	g_obex_debug(G_OBEX_DEBUG_PACKET, "opcode 0x%02x", opcode);
+
 	pkt = g_new0(GObexPacket, 1);
 
 	pkt->opcode = opcode;
@@ -224,6 +250,8 @@ GObexPacket *g_obex_packet_new(guint8 opcode, gboolean final,
 	GObexPacket *pkt;
 	va_list args;
 
+	g_obex_debug(G_OBEX_DEBUG_PACKET, "opcode 0x%02x", opcode);
+
 	va_start(args, first_hdr_id);
 	pkt = g_obex_packet_new_valist(opcode, final, first_hdr_id, args);
 	va_end(args);
@@ -233,6 +261,8 @@ GObexPacket *g_obex_packet_new(guint8 opcode, gboolean final,
 
 void g_obex_packet_free(GObexPacket *pkt)
 {
+	g_obex_debug(G_OBEX_DEBUG_PACKET, "opcode 0x%02x", pkt->opcode);
+
 	switch (pkt->data_policy) {
 	case G_OBEX_DATA_INHERIT:
 	case G_OBEX_DATA_COPY:
@@ -253,6 +283,8 @@ static gboolean parse_headers(GObexPacket *pkt, const void *data, gsize len,
 {
 	const guint8 *buf = data;
 
+	g_obex_debug(G_OBEX_DEBUG_PACKET, "opcode 0x%02x", pkt->opcode);
+
 	while (len > 0) {
 		GObexHeader *header;
 		gsize parsed;
@@ -289,6 +321,8 @@ GObexPacket *g_obex_packet_decode(const void *data, gsize len,
 	GObexPacket *pkt;
 	gboolean final;
 
+	g_obex_debug(G_OBEX_DEBUG_PACKET, "");
+
 	if (data_policy == G_OBEX_DATA_INHERIT) {
 		g_set_error(err, G_OBEX_ERROR, G_OBEX_ERROR_INVALID_ARGS,
 							"Invalid data policy");
@@ -343,6 +377,8 @@ static gssize get_body(GObexPacket *pkt, guint8 *buf, gsize len)
 	guint16 u16;
 	gssize ret;
 
+	g_obex_debug(G_OBEX_DEBUG_PACKET, "opcode 0x%02x", pkt->opcode);
+
 	if (len < 3)
 		return -ENOBUFS;
 
@@ -368,6 +404,8 @@ gssize g_obex_packet_encode(GObexPacket *pkt, guint8 *buf, gsize len)
 	guint16 u16;
 	GSList *l;
 
+	g_obex_debug(G_OBEX_DEBUG_PACKET, "opcode 0x%02x", pkt->opcode);
+
 	if (3 + pkt->data_len + pkt->hlen > len)
 		return -ENOBUFS;
 
-- 
1.7.6.4

