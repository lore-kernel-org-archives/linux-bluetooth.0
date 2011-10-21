Return-Path: <cyrus@holtmann.org>
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH obexd 5/7 v3] gobex: log headers using G_OBEX_DEBUG_HEADER
Date: Fri, 21 Oct 2011 13:34:03 +0300
Message-Id: <1319193245-23058-5-git-send-email-luiz.dentz@gmail.com>
In-Reply-To: <1319193245-23058-1-git-send-email-luiz.dentz@gmail.com>
References: <1319193245-23058-1-git-send-email-luiz.dentz@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

From: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>

---
 gobex/gobex-header.c |   49 +++++++++++++++++++++++++++++++++++++++++++++++++
 1 files changed, 49 insertions(+), 0 deletions(-)

diff --git a/gobex/gobex-header.c b/gobex/gobex-header.c
index 4a28bf8..035725b 100644
--- a/gobex/gobex-header.c
+++ b/gobex/gobex-header.c
@@ -93,6 +93,9 @@ gssize g_obex_header_encode(GObexHeader *header, void *buf, gsize buf_len)
 	gunichar2 *utf16;
 	glong utf16_len;
 
+	g_obex_debug(G_OBEX_DEBUG_HEADER, "header 0x%02x",
+						G_OBEX_HDR_ENC(header->id));
+
 	if (buf_len < header->hlen)
 		return -1;
 
@@ -152,6 +155,9 @@ GObexHeader *g_obex_header_decode(const void *data, gsize len,
 
 	ptr = get_bytes(&header->id, ptr, sizeof(header->id));
 
+	g_obex_debug(G_OBEX_DEBUG_HEADER, "header 0x%02x",
+						G_OBEX_HDR_ENC(header->id));
+
 	switch (G_OBEX_HDR_ENC(header->id)) {
 	case G_OBEX_HDR_ENC_UNICODE:
 		if (len < 3) {
@@ -276,6 +282,9 @@ failed:
 
 void g_obex_header_free(GObexHeader *header)
 {
+	g_obex_debug(G_OBEX_DEBUG_HEADER, "header 0x%02x",
+						G_OBEX_HDR_ENC(header->id));
+
 	switch (G_OBEX_HDR_ENC(header->id)) {
 	case G_OBEX_HDR_ENC_UNICODE:
 		g_free(header->v.string);
@@ -296,17 +305,25 @@ void g_obex_header_free(GObexHeader *header)
 
 gboolean g_obex_header_get_unicode(GObexHeader *header, const char **str)
 {
+	g_obex_debug(G_OBEX_DEBUG_HEADER, "header 0x%02x",
+						G_OBEX_HDR_ENC(header->id));
+
 	if (G_OBEX_HDR_ENC(header->id) != G_OBEX_HDR_ENC_UNICODE)
 		return FALSE;
 
 	*str = header->v.string;
 
+	g_obex_debug(G_OBEX_DEBUG_HEADER, "%s", *str);
+
 	return TRUE;
 }
 
 gboolean g_obex_header_get_bytes(GObexHeader *header, const guint8 **val,
 								gsize *len)
 {
+	g_obex_debug(G_OBEX_DEBUG_HEADER, "header 0x%02x",
+						G_OBEX_HDR_ENC(header->id));
+
 	if (G_OBEX_HDR_ENC(header->id) != G_OBEX_HDR_ENC_BYTES)
 		return FALSE;
 
@@ -322,21 +339,31 @@ gboolean g_obex_header_get_bytes(GObexHeader *header, const guint8 **val,
 
 gboolean g_obex_header_get_uint8(GObexHeader *header, guint8 *val)
 {
+	g_obex_debug(G_OBEX_DEBUG_HEADER, "header 0x%02x",
+						G_OBEX_HDR_ENC(header->id));
+
 	if (G_OBEX_HDR_ENC(header->id) != G_OBEX_HDR_ENC_UINT8)
 		return FALSE;
 
 	*val = header->v.u8;
 
+	g_obex_debug(G_OBEX_DEBUG_HEADER, "%u", *val);
+
 	return TRUE;
 }
 
 gboolean g_obex_header_get_uint32(GObexHeader *header, guint32 *val)
 {
+	g_obex_debug(G_OBEX_DEBUG_HEADER, "header 0x%02x",
+						G_OBEX_HDR_ENC(header->id));
+
 	if (G_OBEX_HDR_ENC(header->id) != G_OBEX_HDR_ENC_UINT32)
 		return FALSE;
 
 	*val = header->v.u32;
 
+	g_obex_debug(G_OBEX_DEBUG_HEADER, "%u", *val);
+
 	return TRUE;
 }
 
@@ -345,6 +372,8 @@ GObexHeader *g_obex_header_new_unicode(guint8 id, const char *str)
 	GObexHeader *header;
 	gsize len;
 
+	g_obex_debug(G_OBEX_DEBUG_HEADER, "header 0x%02x", G_OBEX_HDR_ENC(id));
+
 	if (G_OBEX_HDR_ENC(id) != G_OBEX_HDR_ENC_UNICODE)
 		return NULL;
 
@@ -358,6 +387,8 @@ GObexHeader *g_obex_header_new_unicode(guint8 id, const char *str)
 	header->hlen = len == 0 ? 3 : 3 + ((len + 1) * 2);
 	header->v.string = g_strdup(str);
 
+	g_obex_debug(G_OBEX_DEBUG_HEADER, "%s", header->v.string);
+
 	return header;
 }
 
@@ -365,6 +396,8 @@ GObexHeader *g_obex_header_new_bytes(guint8 id, const void *data, gsize len)
 {
 	GObexHeader *header;
 
+	g_obex_debug(G_OBEX_DEBUG_HEADER, "header 0x%02x", G_OBEX_HDR_ENC(id));
+
 	if (G_OBEX_HDR_ENC(id) != G_OBEX_HDR_ENC_BYTES)
 		return NULL;
 
@@ -382,6 +415,8 @@ GObexHeader *g_obex_header_new_uint8(guint8 id, guint8 val)
 {
 	GObexHeader *header;
 
+	g_obex_debug(G_OBEX_DEBUG_HEADER, "header 0x%02x", G_OBEX_HDR_ENC(id));
+
 	if (G_OBEX_HDR_ENC(id) != G_OBEX_HDR_ENC_UINT8)
 		return NULL;
 
@@ -392,6 +427,8 @@ GObexHeader *g_obex_header_new_uint8(guint8 id, guint8 val)
 	header->hlen = 2;
 	header->v.u8 = val;
 
+	g_obex_debug(G_OBEX_DEBUG_HEADER, "%u", header->v.u8);
+
 	return header;
 }
 
@@ -399,6 +436,8 @@ GObexHeader *g_obex_header_new_uint32(guint8 id, guint32 val)
 {
 	GObexHeader *header;
 
+	g_obex_debug(G_OBEX_DEBUG_HEADER, "header 0x%02x", G_OBEX_HDR_ENC(id));
+
 	if (G_OBEX_HDR_ENC(id) != G_OBEX_HDR_ENC_UINT32)
 		return NULL;
 
@@ -409,16 +448,24 @@ GObexHeader *g_obex_header_new_uint32(guint8 id, guint32 val)
 	header->hlen = 5;
 	header->v.u32 = val;
 
+	g_obex_debug(G_OBEX_DEBUG_HEADER, "%u", header->v.u32);
+
 	return header;
 }
 
 guint8 g_obex_header_get_id(GObexHeader *header)
 {
+	g_obex_debug(G_OBEX_DEBUG_HEADER, "header 0x%02x id 0x%02x",
+				G_OBEX_HDR_ENC(header->id), header->id);
+
 	return header->id;
 }
 
 guint16 g_obex_header_get_length(GObexHeader *header)
 {
+	g_obex_debug(G_OBEX_DEBUG_HEADER, "header 0x%02x length %zu",
+				G_OBEX_HDR_ENC(header->id), header->hlen);
+
 	return header->hlen;
 }
 
@@ -428,6 +475,8 @@ GSList *g_obex_header_create_list(guint8 first_hdr_id, va_list args,
 	unsigned int id = first_hdr_id;
 	GSList *l = NULL;
 
+	g_obex_debug(G_OBEX_DEBUG_HEADER, "");
+
 	*total_len = 0;
 
 	while (id != G_OBEX_HDR_INVALID) {
-- 
1.7.6.4

