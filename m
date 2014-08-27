Return-Path: <cyrus@holtmann.org>
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH BlueZ 4/7] gobex: Fix crash when debug is enabled
Date: Wed, 27 Aug 2014 19:04:47 +0300
Message-Id: <1409155490-25653-4-git-send-email-luiz.dentz@gmail.com>
In-Reply-To: <1409155490-25653-1-git-send-email-luiz.dentz@gmail.com>
References: <1409155490-25653-1-git-send-email-luiz.dentz@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

From: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>

GError can be NULL thus causing invalid read when trying to a message
member such as bellow:

Invalid read of size 8
   at 0x41190F: g_obex_send_internal (gobex.c:531)
   by 0x4130A6: g_obex_send_req (gobex.c:756)
   by 0x4268A5: obc_session_unref (session.c:289)
   by 0x41396A: incoming_data (gobex.c:1397)
   by 0x59712A5: g_main_context_dispatch (in /usr/lib64/libglib-2.0.so.0.3800.2)
   by 0x5971627: ??? (in /usr/lib64/libglib-2.0.so.0.3800.2)
   by 0x5971A39: g_main_loop_run (in /usr/lib64/libglib-2.0.so.0.3800.2)
   by 0x40D78C: main (main.c:320)
 Address 0x0 is not stack'd, malloc'd or (recently) free'd
---
 gobex/gobex-header.c |  2 ++
 gobex/gobex-packet.c |  6 ++++++
 gobex/gobex.c        | 10 +++++++++-
 3 files changed, 17 insertions(+), 1 deletion(-)

diff --git a/gobex/gobex-header.c b/gobex/gobex-header.c
index fe70c8b..ed7fd08 100644
--- a/gobex/gobex-header.c
+++ b/gobex/gobex-header.c
@@ -146,6 +146,8 @@ GObexHeader *g_obex_header_decode(const void *data, gsize len,
 	GError *conv_err = NULL;
 
 	if (len < 2) {
+		if (!err)
+			return NULL;
 		g_set_error(err, G_OBEX_ERROR, G_OBEX_ERROR_PARSE_ERROR,
 						"Too short header in packet");
 		g_obex_debug(G_OBEX_DEBUG_ERROR, "%s", (*err)->message);
diff --git a/gobex/gobex-packet.c b/gobex/gobex-packet.c
index 4c14cf7..db56ed0 100644
--- a/gobex/gobex-packet.c
+++ b/gobex/gobex-packet.c
@@ -325,6 +325,8 @@ GObexPacket *g_obex_packet_decode(const void *data, gsize len,
 	g_obex_debug(G_OBEX_DEBUG_PACKET, "");
 
 	if (data_policy == G_OBEX_DATA_INHERIT) {
+		if (!err)
+			return NULL;
 		g_set_error(err, G_OBEX_ERROR, G_OBEX_ERROR_INVALID_ARGS,
 							"Invalid data policy");
 		g_obex_debug(G_OBEX_DEBUG_ERROR, "%s", (*err)->message);
@@ -332,6 +334,8 @@ GObexPacket *g_obex_packet_decode(const void *data, gsize len,
 	}
 
 	if (len < 3 + header_offset) {
+		if (!err)
+			return NULL;
 		g_set_error(err, G_OBEX_ERROR, G_OBEX_ERROR_PARSE_ERROR,
 					"Not enough data to decode packet");
 		g_obex_debug(G_OBEX_DEBUG_ERROR, "%s", (*err)->message);
@@ -343,6 +347,8 @@ GObexPacket *g_obex_packet_decode(const void *data, gsize len,
 
 	packet_len = g_ntohs(packet_len);
 	if (packet_len != len) {
+		if (!err)
+			return NULL;
 		g_set_error(err, G_OBEX_ERROR, G_OBEX_ERROR_PARSE_ERROR,
 				"Incorrect packet length (%u != %zu)",
 				packet_len, len);
diff --git a/gobex/gobex.c b/gobex/gobex.c
index e7b081f..e9a08fa 100644
--- a/gobex/gobex.c
+++ b/gobex/gobex.c
@@ -526,6 +526,8 @@ static gboolean g_obex_send_internal(GObex *obex, struct pending_pkt *p,
 {
 
 	if (obex->io == NULL) {
+		if (!err)
+			return FALSE;
 		g_set_error(err, G_OBEX_ERROR, G_OBEX_ERROR_DISCONNECTED,
 					"The transport is not connected");
 		g_obex_debug(G_OBEX_DEBUG_ERROR, "%s", (*err)->message);
@@ -663,6 +665,8 @@ gboolean g_obex_send(GObex *obex, GObexPacket *pkt, GError **err)
 	g_obex_debug(G_OBEX_DEBUG_COMMAND, "conn %u", obex->conn_id);
 
 	if (obex == NULL || pkt == NULL) {
+		if (!err)
+			return FALSE;
 		g_set_error(err, G_OBEX_ERROR, G_OBEX_ERROR_INVALID_ARGS,
 				"Invalid arguments");
 		g_obex_debug(G_OBEX_DEBUG_ERROR, "%s", (*err)->message);
@@ -1230,6 +1234,8 @@ static gboolean read_stream(GObex *obex, GError **err)
 	obex->rx_pkt_len = g_ntohs(u16);
 
 	if (obex->rx_pkt_len > obex->rx_mtu) {
+		if (!err)
+			return FALSE;
 		g_set_error(err, G_OBEX_ERROR, G_OBEX_ERROR_PARSE_ERROR,
 				"Too big incoming packet");
 		g_obex_debug(G_OBEX_DEBUG_ERROR, "%s", (*err)->message);
@@ -1302,7 +1308,9 @@ static gboolean read_packet(GObex *obex, GError **err)
 
 	return TRUE;
 fail:
-	g_obex_debug(G_OBEX_DEBUG_ERROR, "%s", (*err)->message);
+	if (err)
+		g_obex_debug(G_OBEX_DEBUG_ERROR, "%s", (*err)->message);
+
 	return FALSE;
 }
 
-- 
1.9.3

