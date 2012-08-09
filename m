Return-Path: <cyrus@holtmann.org>
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH obexd 5/9] gobex: Add debug option to apparam
Date: Thu,  9 Aug 2012 13:32:29 +0300
Message-Id: <1344508353-24647-6-git-send-email-luiz.dentz@gmail.com>
In-Reply-To: <1344508353-24647-1-git-send-email-luiz.dentz@gmail.com>
References: <1344508353-24647-1-git-send-email-luiz.dentz@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

From: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>

This adds "apparam" to the debug options of GOBEX_DEBUG
---
 gobex/gobex-apparam.c | 43 ++++++++++++++++++++++++++++++++++++++++++-
 gobex/gobex-debug.h   |  7 ++++---
 gobex/gobex.c         | 11 ++++++-----
 3 files changed, 52 insertions(+), 9 deletions(-)

diff --git a/gobex/gobex-apparam.c b/gobex/gobex-apparam.c
index 09bf034..8f72aa7 100644
--- a/gobex/gobex-apparam.c
+++ b/gobex/gobex-apparam.c
@@ -28,6 +28,7 @@
 #include <errno.h>
 
 #include "gobex-apparam.h"
+#include "gobex-debug.h"
 
 struct _GObexApparam {
 	GHashTable *tags;
@@ -179,6 +180,8 @@ GObexApparam *g_obex_apparam_set_bytes(GObexApparam *apparam, guint8 id,
 GObexApparam *g_obex_apparam_set_uint8(GObexApparam *apparam, guint8 id,
 							guint8 value)
 {
+	g_obex_debug(G_OBEX_DEBUG_APPARAM, "tag 0x%02x value %u", id, value);
+
 	return g_obex_apparam_set_bytes(apparam, id, &value, 1);
 }
 
@@ -187,6 +190,8 @@ GObexApparam *g_obex_apparam_set_uint16(GObexApparam *apparam, guint8 id,
 {
 	guint16 num = g_htons(value);
 
+	g_obex_debug(G_OBEX_DEBUG_APPARAM, "tag 0x%02x value %u", id, value);
+
 	return g_obex_apparam_set_bytes(apparam, id, &num, 2);
 }
 
@@ -195,6 +200,8 @@ GObexApparam *g_obex_apparam_set_uint32(GObexApparam *apparam, guint8 id,
 {
 	guint32 num = g_htonl(value);
 
+	g_obex_debug(G_OBEX_DEBUG_APPARAM, "tag 0x%02x value %u", id, value);
+
 	return g_obex_apparam_set_bytes(apparam, id, &num, 4);
 }
 
@@ -203,6 +210,9 @@ GObexApparam *g_obex_apparam_set_uint64(GObexApparam *apparam, guint8 id,
 {
 	guint64 num = GUINT64_TO_BE(value);
 
+	g_obex_debug(G_OBEX_DEBUG_APPARAM, "tag 0x%02x value %"
+						G_GUINT64_FORMAT, id, value);
+
 	return g_obex_apparam_set_bytes(apparam, id, &num, 8);
 }
 
@@ -211,6 +221,8 @@ GObexApparam *g_obex_apparam_set_string(GObexApparam *apparam, guint8 id,
 {
 	gsize len;
 
+	g_obex_debug(G_OBEX_DEBUG_APPARAM, "tag 0x%02x value %s", id, value);
+
 	len = strlen(value) + 1;
 	if (len > G_MAXUINT8) {
 		((char *) value)[G_MAXUINT8 - 1] = '\0';
@@ -225,11 +237,16 @@ gboolean g_obex_apparam_get_uint8(GObexApparam *apparam, guint8 id,
 {
 	struct apparam_tag *tag;
 
+	g_obex_debug(G_OBEX_DEBUG_APPARAM, "tag 0x%02x", id);
+
 	tag = g_hash_table_lookup(apparam->tags, GUINT_TO_POINTER(id));
 	if (tag == NULL)
 		return FALSE;
 
 	*dest = tag->value.u8;
+
+	g_obex_debug(G_OBEX_DEBUG_APPARAM, "%u", *dest);
+
 	return TRUE;
 }
 
@@ -238,6 +255,8 @@ gboolean g_obex_apparam_get_uint16(GObexApparam *apparam, guint8 id,
 {
 	struct apparam_tag *tag;
 
+	g_obex_debug(G_OBEX_DEBUG_APPARAM, "tag 0x%02x", id);
+
 	tag = g_hash_table_lookup(apparam->tags, GUINT_TO_POINTER(id));
 	if (tag == NULL)
 		return FALSE;
@@ -246,6 +265,9 @@ gboolean g_obex_apparam_get_uint16(GObexApparam *apparam, guint8 id,
 		return FALSE;
 
 	*dest = g_ntohs(tag->value.u16);
+
+	g_obex_debug(G_OBEX_DEBUG_APPARAM, "%u", *dest);
+
 	return TRUE;
 }
 
@@ -254,6 +276,8 @@ gboolean g_obex_apparam_get_uint32(GObexApparam *apparam, guint8 id,
 {
 	struct apparam_tag *tag;
 
+	g_obex_debug(G_OBEX_DEBUG_APPARAM, "tag 0x%02x", id);
+
 	tag = g_hash_table_lookup(apparam->tags, GUINT_TO_POINTER(id));
 	if (tag == NULL)
 		return FALSE;
@@ -262,6 +286,9 @@ gboolean g_obex_apparam_get_uint32(GObexApparam *apparam, guint8 id,
 		return FALSE;
 
 	*dest = g_ntohl(tag->value.u32);
+
+	g_obex_debug(G_OBEX_DEBUG_APPARAM, "%u", *dest);
+
 	return TRUE;
 }
 
@@ -270,6 +297,8 @@ gboolean g_obex_apparam_get_uint64(GObexApparam *apparam, guint8 id,
 {
 	struct apparam_tag *tag;
 
+	g_obex_debug(G_OBEX_DEBUG_APPARAM, "tag 0x%02x", id);
+
 	tag = g_hash_table_lookup(apparam->tags, GUINT_TO_POINTER(id));
 	if (tag == NULL)
 		return FALSE;
@@ -278,18 +307,28 @@ gboolean g_obex_apparam_get_uint64(GObexApparam *apparam, guint8 id,
 		return FALSE;
 
 	*dest = GUINT64_FROM_BE(tag->value.u64);
+
+	g_obex_debug(G_OBEX_DEBUG_APPARAM, "%" G_GUINT64_FORMAT, *dest);
+
 	return TRUE;
 }
 
 char *g_obex_apparam_get_string(GObexApparam *apparam, guint8 id)
 {
 	struct apparam_tag *tag;
+	char *string;
+
+	g_obex_debug(G_OBEX_DEBUG_APPARAM, "tag 0x%02x", id);
 
 	tag = g_hash_table_lookup(apparam->tags, GUINT_TO_POINTER(id));
 	if (tag == NULL)
 		return NULL;
 
-	return g_strndup(tag->value.string, tag->len);
+	string = g_strndup(tag->value.string, tag->len);
+
+	g_obex_debug(G_OBEX_DEBUG_APPARAM, "%s", string);
+
+	return string;
 }
 
 gboolean g_obex_apparam_get_bytes(GObexApparam *apparam, guint8 id,
@@ -297,6 +336,8 @@ gboolean g_obex_apparam_get_bytes(GObexApparam *apparam, guint8 id,
 {
 	struct apparam_tag *tag;
 
+	g_obex_debug(G_OBEX_DEBUG_APPARAM, "tag 0x%02x", id);
+
 	tag = g_hash_table_lookup(apparam->tags, GUINT_TO_POINTER(id));
 	if (tag == NULL)
 		return FALSE;
diff --git a/gobex/gobex-debug.h b/gobex/gobex-debug.h
index 14faa10..14e2bcd 100644
--- a/gobex/gobex-debug.h
+++ b/gobex/gobex-debug.h
@@ -32,6 +32,7 @@
 #define G_OBEX_DEBUG_HEADER	(1 << 4)
 #define G_OBEX_DEBUG_PACKET	(1 << 5)
 #define G_OBEX_DEBUG_DATA	(1 << 6)
+#define G_OBEX_DEBUG_APPARAM	(1 << 7)
 
 extern guint gobex_debug;
 
@@ -40,13 +41,13 @@ extern guint gobex_debug;
 		g_log("gobex", G_LOG_LEVEL_DEBUG, "%s:%s() " format, __FILE__, \
 						__FUNCTION__, ## __VA_ARGS__)
 
-static inline void g_obex_dump(const char *prefix, const void *buf,
-								gsize len)
+static inline void g_obex_dump(guint level, const char *prefix,
+					const void *buf, gsize len)
 {
 	const guint8 *data = buf;
 	int n = 0;
 
-	if (!(gobex_debug & G_OBEX_DEBUG_DATA))
+	if (!(gobex_debug & level))
 		return;
 
 	while (len > 0) {
diff --git a/gobex/gobex.c b/gobex/gobex.c
index b6126b8..7c136af 100644
--- a/gobex/gobex.c
+++ b/gobex/gobex.c
@@ -267,7 +267,7 @@ static gboolean write_stream(GObex *obex, GError **err)
 	if (status != G_IO_STATUS_NORMAL)
 		return FALSE;
 
-	g_obex_dump("<", buf, bytes_written);
+	g_obex_dump(G_OBEX_DEBUG_DATA, "<", buf, bytes_written);
 
 	obex->tx_sent += bytes_written;
 	obex->tx_data -= bytes_written;
@@ -290,7 +290,7 @@ static gboolean write_packet(GObex *obex, GError **err)
 	if (bytes_written != obex->tx_data)
 		return FALSE;
 
-	g_obex_dump("<", buf, bytes_written);
+	g_obex_dump(G_OBEX_DEBUG_DATA, "<", buf, bytes_written);
 
 	obex->tx_sent += bytes_written;
 	obex->tx_data -= bytes_written;
@@ -1078,7 +1078,7 @@ read_body:
 	} while (rbytes > 0 && obex->rx_data < obex->rx_pkt_len);
 
 done:
-	g_obex_dump(">", obex->rx_buf, obex->rx_data);
+	g_obex_dump(G_OBEX_DEBUG_DATA, ">", obex->rx_buf, obex->rx_data);
 
 	return TRUE;
 }
@@ -1124,7 +1124,7 @@ static gboolean read_packet(GObex *obex, GError **err)
 		return FALSE;
 	}
 
-	g_obex_dump(">", obex->rx_buf, obex->rx_data);
+	g_obex_dump(G_OBEX_DEBUG_DATA, ">", obex->rx_buf, obex->rx_data);
 
 	return TRUE;
 fail:
@@ -1236,6 +1236,7 @@ static GDebugKey keys[] = {
 	{ "header",	G_OBEX_DEBUG_HEADER },
 	{ "packet",	G_OBEX_DEBUG_PACKET },
 	{ "data",	G_OBEX_DEBUG_DATA },
+	{ "apparam",	G_OBEX_DEBUG_APPARAM },
 };
 
 GObex *g_obex_new(GIOChannel *io, GObexTransportType transport_type,
@@ -1248,7 +1249,7 @@ GObex *g_obex_new(GIOChannel *io, GObexTransportType transport_type,
 		const char *env = g_getenv("GOBEX_DEBUG");
 
 		if (env) {
-			gobex_debug = g_parse_debug_string(env, keys, 6);
+			gobex_debug = g_parse_debug_string(env, keys, 7);
 			g_setenv("G_MESSAGES_DEBUG", "gobex", FALSE);
 		} else
 			gobex_debug = G_OBEX_DEBUG_NONE;
-- 
1.7.11.2

