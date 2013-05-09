Return-Path: <cyrus@holtmann.org>
From: Lucas De Marchi <lucas.demarchi@profusion.mobi>
To: linux-bluetooth@vger.kernel.org
Cc: Lucas De Marchi <lucas.demarchi@profusion.mobi>
Subject: [PATCH BlueZ 03/26] gobex: Get rid of guint* types
Date: Thu,  9 May 2013 01:16:33 -0300
Message-Id: <1368073016-28434-3-git-send-email-lucas.demarchi@profusion.mobi>
In-Reply-To: <1368073016-28434-1-git-send-email-lucas.demarchi@profusion.mobi>
References: <1368073016-28434-1-git-send-email-lucas.demarchi@profusion.mobi>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

guint -> unsigned int
guint8 -> uint8_t
guint16 -> uint16_t
guint32 -> uint32_t
guint64 -> uint64_t

Add "#include <inttypes.h>" where appropriate.
---
 gobex/gobex-apparam.c  |  77 ++++++++++++++--------------
 gobex/gobex-apparam.h  |  43 ++++++++--------
 gobex/gobex-debug.h    |   7 +--
 gobex/gobex-header.c   |  51 +++++++++----------
 gobex/gobex-header.h   |  21 ++++----
 gobex/gobex-packet.c   |  41 +++++++--------
 gobex/gobex-packet.h   |  23 +++++----
 gobex/gobex-transfer.c |  65 ++++++++++++------------
 gobex/gobex.c          | 133 +++++++++++++++++++++++++------------------------
 gobex/gobex.h          |  59 ++++++++++++----------
 10 files changed, 269 insertions(+), 251 deletions(-)

diff --git a/gobex/gobex-apparam.c b/gobex/gobex-apparam.c
index 4328172..84fadc0 100644
--- a/gobex/gobex-apparam.c
+++ b/gobex/gobex-apparam.c
@@ -24,6 +24,7 @@
 #include <config.h>
 #endif
 
+#include <inttypes.h>
 #include <string.h>
 #include <unistd.h>
 #include <errno.h>
@@ -36,20 +37,20 @@ struct _GObexApparam {
 };
 
 struct apparam_tag {
-	guint8 id;
-	guint8 len;
+	uint8_t id;
+	uint8_t len;
 	union {
 		/* Data is stored in network order */
 		char string[0];
-		guint8 data[0];
-		guint8 u8;
-		guint16 u16;
-		guint32 u32;
-		guint64 u64;
+		uint8_t data[0];
+		uint8_t u8;
+		uint16_t u16;
+		uint32_t u32;
+		uint64_t u64;
 	} value;
 } __attribute__ ((packed));
 
-static struct apparam_tag *tag_new(guint8 id, guint8 len, const void *data)
+static struct apparam_tag *tag_new(uint8_t id, uint8_t len, const void *data)
 {
 	struct apparam_tag *tag;
 
@@ -76,9 +77,9 @@ static struct apparam_tag *apparam_tag_decode(const void *data, gsize size,
 							gsize *parsed)
 {
 	struct apparam_tag *tag;
-	const guint8 *ptr = data;
-	guint8 id;
-	guint8 len;
+	const uint8_t *ptr = data;
+	uint8_t id;
+	uint8_t len;
 
 	if (size < 2)
 		return NULL;
@@ -113,7 +114,7 @@ GObexApparam *g_obex_apparam_decode(const void *data, gsize size)
 	while (count < size) {
 		struct apparam_tag *tag;
 		gsize parsed;
-		guint id;
+		unsigned int id;
 
 		tag = apparam_tag_decode(data + count, size - count, &parsed);
 		if (tag == NULL)
@@ -166,11 +167,11 @@ gssize g_obex_apparam_encode(GObexApparam *apparam, void *buf, gsize len)
 	return count;
 }
 
-GObexApparam *g_obex_apparam_set_bytes(GObexApparam *apparam, guint8 id,
+GObexApparam *g_obex_apparam_set_bytes(GObexApparam *apparam, uint8_t id,
 						const void *value, gsize len)
 {
 	struct apparam_tag *tag;
-	guint uid = id;
+	unsigned int uid = id;
 
 	if (apparam == NULL)
 		apparam = g_obex_apparam_new();
@@ -181,38 +182,38 @@ GObexApparam *g_obex_apparam_set_bytes(GObexApparam *apparam, guint8 id,
 	return apparam;
 }
 
-GObexApparam *g_obex_apparam_set_uint8(GObexApparam *apparam, guint8 id,
-							guint8 value)
+GObexApparam *g_obex_apparam_set_uint8(GObexApparam *apparam, uint8_t id,
+							uint8_t value)
 {
 	g_obex_debug(G_OBEX_DEBUG_APPARAM, "tag 0x%02x value %u", id, value);
 
 	return g_obex_apparam_set_bytes(apparam, id, &value, 1);
 }
 
-GObexApparam *g_obex_apparam_set_uint16(GObexApparam *apparam, guint8 id,
-							guint16 value)
+GObexApparam *g_obex_apparam_set_uint16(GObexApparam *apparam, uint8_t id,
+							uint16_t value)
 {
-	guint16 num = g_htons(value);
+	uint16_t num = g_htons(value);
 
 	g_obex_debug(G_OBEX_DEBUG_APPARAM, "tag 0x%02x value %u", id, value);
 
 	return g_obex_apparam_set_bytes(apparam, id, &num, 2);
 }
 
-GObexApparam *g_obex_apparam_set_uint32(GObexApparam *apparam, guint8 id,
-							guint32 value)
+GObexApparam *g_obex_apparam_set_uint32(GObexApparam *apparam, uint8_t id,
+							uint32_t value)
 {
-	guint32 num = g_htonl(value);
+	uint32_t num = g_htonl(value);
 
 	g_obex_debug(G_OBEX_DEBUG_APPARAM, "tag 0x%02x value %u", id, value);
 
 	return g_obex_apparam_set_bytes(apparam, id, &num, 4);
 }
 
-GObexApparam *g_obex_apparam_set_uint64(GObexApparam *apparam, guint8 id,
-							guint64 value)
+GObexApparam *g_obex_apparam_set_uint64(GObexApparam *apparam, uint8_t id,
+							uint64_t value)
 {
-	guint64 num = GUINT64_TO_BE(value);
+	uint64_t num = GUINT64_TO_BE(value);
 
 	g_obex_debug(G_OBEX_DEBUG_APPARAM, "tag 0x%02x value %"
 						G_GUINT64_FORMAT, id, value);
@@ -220,7 +221,7 @@ GObexApparam *g_obex_apparam_set_uint64(GObexApparam *apparam, guint8 id,
 	return g_obex_apparam_set_bytes(apparam, id, &num, 8);
 }
 
-GObexApparam *g_obex_apparam_set_string(GObexApparam *apparam, guint8 id,
+GObexApparam *g_obex_apparam_set_string(GObexApparam *apparam, uint8_t id,
 							const char *value)
 {
 	gsize len;
@@ -237,13 +238,13 @@ GObexApparam *g_obex_apparam_set_string(GObexApparam *apparam, guint8 id,
 }
 
 static struct apparam_tag *g_obex_apparam_find_tag(GObexApparam *apparam,
-								guint id)
+								unsigned int id)
 {
 	return g_hash_table_lookup(apparam->tags, GUINT_TO_POINTER(id));
 }
 
-gboolean g_obex_apparam_get_uint8(GObexApparam *apparam, guint8 id,
-							guint8 *dest)
+gboolean g_obex_apparam_get_uint8(GObexApparam *apparam, uint8_t id,
+							uint8_t *dest)
 {
 	struct apparam_tag *tag;
 
@@ -260,8 +261,8 @@ gboolean g_obex_apparam_get_uint8(GObexApparam *apparam, guint8 id,
 	return TRUE;
 }
 
-gboolean g_obex_apparam_get_uint16(GObexApparam *apparam, guint8 id,
-							guint16 *dest)
+gboolean g_obex_apparam_get_uint16(GObexApparam *apparam, uint8_t id,
+							uint16_t *dest)
 {
 	struct apparam_tag *tag;
 
@@ -281,8 +282,8 @@ gboolean g_obex_apparam_get_uint16(GObexApparam *apparam, guint8 id,
 	return TRUE;
 }
 
-gboolean g_obex_apparam_get_uint32(GObexApparam *apparam, guint8 id,
-							guint32 *dest)
+gboolean g_obex_apparam_get_uint32(GObexApparam *apparam, uint8_t id,
+							uint32_t *dest)
 {
 	struct apparam_tag *tag;
 
@@ -302,8 +303,8 @@ gboolean g_obex_apparam_get_uint32(GObexApparam *apparam, guint8 id,
 	return TRUE;
 }
 
-gboolean g_obex_apparam_get_uint64(GObexApparam *apparam, guint8 id,
-							guint64 *dest)
+gboolean g_obex_apparam_get_uint64(GObexApparam *apparam, uint8_t id,
+							uint64_t *dest)
 {
 	struct apparam_tag *tag;
 
@@ -323,7 +324,7 @@ gboolean g_obex_apparam_get_uint64(GObexApparam *apparam, guint8 id,
 	return TRUE;
 }
 
-char *g_obex_apparam_get_string(GObexApparam *apparam, guint8 id)
+char *g_obex_apparam_get_string(GObexApparam *apparam, uint8_t id)
 {
 	struct apparam_tag *tag;
 	char *string;
@@ -341,8 +342,8 @@ char *g_obex_apparam_get_string(GObexApparam *apparam, guint8 id)
 	return string;
 }
 
-gboolean g_obex_apparam_get_bytes(GObexApparam *apparam, guint8 id,
-					const guint8 **val, gsize *len)
+gboolean g_obex_apparam_get_bytes(GObexApparam *apparam, uint8_t id,
+					const uint8_t **val, gsize *len)
 {
 	struct apparam_tag *tag;
 
diff --git a/gobex/gobex-apparam.h b/gobex/gobex-apparam.h
index 6c08609..030a719 100644
--- a/gobex/gobex-apparam.h
+++ b/gobex/gobex-apparam.h
@@ -24,36 +24,37 @@
 #define __GOBEX_APPARAM_H
 
 #include <glib.h>
+#include <inttypes.h>
 
 typedef struct _GObexApparam GObexApparam;
 
 GObexApparam *g_obex_apparam_decode(const void *data, gsize size);
 gssize g_obex_apparam_encode(GObexApparam *apparam, void *buf, gsize size);
 
-GObexApparam *g_obex_apparam_set_bytes(GObexApparam *apparam, guint8 id,
+GObexApparam *g_obex_apparam_set_bytes(GObexApparam *apparam, uint8_t id,
 						const void *value, gsize size);
-GObexApparam *g_obex_apparam_set_uint8(GObexApparam *apparam, guint8 id,
-							guint8 value);
-GObexApparam *g_obex_apparam_set_uint16(GObexApparam *apparam, guint8 id,
-							guint16 value);
-GObexApparam *g_obex_apparam_set_uint32(GObexApparam *apparam, guint8 id,
-							guint32 value);
-GObexApparam *g_obex_apparam_set_uint64(GObexApparam *apparam, guint8 id,
-							guint64 value);
-GObexApparam *g_obex_apparam_set_string(GObexApparam *apparam, guint8 id,
+GObexApparam *g_obex_apparam_set_uint8(GObexApparam *apparam, uint8_t id,
+							uint8_t value);
+GObexApparam *g_obex_apparam_set_uint16(GObexApparam *apparam, uint8_t id,
+							uint16_t value);
+GObexApparam *g_obex_apparam_set_uint32(GObexApparam *apparam, uint8_t id,
+							uint32_t value);
+GObexApparam *g_obex_apparam_set_uint64(GObexApparam *apparam, uint8_t id,
+							uint64_t value);
+GObexApparam *g_obex_apparam_set_string(GObexApparam *apparam, uint8_t id,
 							const char *value);
 
-gboolean g_obex_apparam_get_bytes(GObexApparam *apparam, guint8 id,
-					const guint8 **val, gsize *len);
-gboolean g_obex_apparam_get_uint8(GObexApparam *apparam, guint8 id,
-							guint8 *value);
-gboolean g_obex_apparam_get_uint16(GObexApparam *apparam, guint8 id,
-							guint16 *value);
-gboolean g_obex_apparam_get_uint32(GObexApparam *apparam, guint8 id,
-							guint32 *value);
-gboolean g_obex_apparam_get_uint64(GObexApparam *apparam, guint8 id,
-							guint64 *value);
-char *g_obex_apparam_get_string(GObexApparam *apparam, guint8 id);
+gboolean g_obex_apparam_get_bytes(GObexApparam *apparam, uint8_t id,
+					const uint8_t **val, gsize *len);
+gboolean g_obex_apparam_get_uint8(GObexApparam *apparam, uint8_t id,
+							uint8_t *value);
+gboolean g_obex_apparam_get_uint16(GObexApparam *apparam, uint8_t id,
+							uint16_t *value);
+gboolean g_obex_apparam_get_uint32(GObexApparam *apparam, uint8_t id,
+							uint32_t *value);
+gboolean g_obex_apparam_get_uint64(GObexApparam *apparam, uint8_t id,
+							uint64_t *value);
+char *g_obex_apparam_get_string(GObexApparam *apparam, uint8_t id);
 
 void g_obex_apparam_free(GObexApparam *apparam);
 
diff --git a/gobex/gobex-debug.h b/gobex/gobex-debug.h
index 688466e..fc4fdb1 100644
--- a/gobex/gobex-debug.h
+++ b/gobex/gobex-debug.h
@@ -22,6 +22,7 @@
 #ifndef __GOBEX_DEBUG_H
 #define __GOBEX_DEBUG_H
 
+#include <inttypes.h>
 #include <glib.h>
 #include <stdio.h>
 #include <ctype.h>
@@ -35,17 +36,17 @@
 #define G_OBEX_DEBUG_DATA	(1 << 6)
 #define G_OBEX_DEBUG_APPARAM	(1 << 7)
 
-extern guint gobex_debug;
+extern unsigned int gobex_debug;
 
 #define g_obex_debug(level, format, ...) \
 	if (gobex_debug & level) \
 		g_log("gobex", G_LOG_LEVEL_DEBUG, "%s:%s() " format, __FILE__, \
 						__FUNCTION__, ## __VA_ARGS__)
 
-static inline void g_obex_dump(guint level, const char *prefix,
+static inline void g_obex_dump(unsigned int level, const char *prefix,
 					const void *buf, gsize len)
 {
-	const guint8 *data = buf;
+	const uint8_t *data = buf;
 	int n = 0;
 
 	if (!(gobex_debug & level))
diff --git a/gobex/gobex-header.c b/gobex/gobex-header.c
index 281f8ea..8a4f401 100644
--- a/gobex/gobex-header.c
+++ b/gobex/gobex-header.c
@@ -24,6 +24,7 @@
 #include <config.h>
 #endif
 
+#include <inttypes.h>
 #include <string.h>
 
 #include "gobex-header.h"
@@ -38,16 +39,16 @@
 #define G_OBEX_HDR_ENC(id)	((id) & 0xc0)
 
 struct _GObexHeader {
-	guint8 id;
+	uint8_t id;
 	gboolean extdata;
 	gsize vlen;			/* Length of value */
 	gsize hlen;			/* Length of full encoded header */
 	union {
 		char *string;		/* UTF-8 converted from UTF-16 */
-		guint8 *data;		/* Own buffer */
-		const guint8 *extdata;	/* Reference to external buffer */
-		guint8 u8;
-		guint32 u32;
+		uint8_t *data;		/* Own buffer */
+		const uint8_t *extdata;	/* Reference to external buffer */
+		uint8_t u8;
+		uint32_t u32;
 	} v;
 };
 
@@ -74,13 +75,13 @@ static glong utf8_to_utf16(gunichar2 **utf16, const char *utf8) {
 	return utf16_len;
 }
 
-static guint8 *put_bytes(guint8 *to, const void *from, gsize count)
+static uint8_t *put_bytes(uint8_t *to, const void *from, gsize count)
 {
 	memcpy(to, from, count);
 	return (to + count);
 }
 
-static const guint8 *get_bytes(void *to, const guint8 *from, gsize count)
+static const uint8_t *get_bytes(void *to, const uint8_t *from, gsize count)
 {
 	memcpy(to, from, count);
 	return (from + count);
@@ -88,9 +89,9 @@ static const guint8 *get_bytes(void *to, const guint8 *from, gsize count)
 
 gssize g_obex_header_encode(GObexHeader *header, void *buf, gsize buf_len)
 {
-	guint8 *ptr = buf;
-	guint16 u16;
-	guint32 u32;
+	uint8_t *ptr = buf;
+	uint16_t u16;
+	uint32_t u32;
 	gunichar2 *utf16;
 	glong utf16_len;
 
@@ -105,7 +106,7 @@ gssize g_obex_header_encode(GObexHeader *header, void *buf, gsize buf_len)
 	switch (G_OBEX_HDR_ENC(header->id)) {
 	case G_OBEX_HDR_ENC_UNICODE:
 		utf16_len = utf8_to_utf16(&utf16, header->v.string);
-		if (utf16_len < 0 || (guint16) utf16_len > buf_len)
+		if (utf16_len < 0 || (uint16_t) utf16_len > buf_len)
 			return -1;
 		g_assert_cmpuint(utf16_len + 3, ==, header->hlen);
 		u16 = g_htons(utf16_len + 3);
@@ -140,8 +141,8 @@ GObexHeader *g_obex_header_decode(const void *data, gsize len,
 				GError **err)
 {
 	GObexHeader *header;
-	const guint8 *ptr = data;
-	guint16 hdr_len;
+	const uint8_t *ptr = data;
+	uint16_t hdr_len;
 	gsize str_len;
 	GError *conv_err = NULL;
 
@@ -319,7 +320,7 @@ gboolean g_obex_header_get_unicode(GObexHeader *header, const char **str)
 	return TRUE;
 }
 
-gboolean g_obex_header_get_bytes(GObexHeader *header, const guint8 **val,
+gboolean g_obex_header_get_bytes(GObexHeader *header, const uint8_t **val,
 								gsize *len)
 {
 	g_obex_debug(G_OBEX_DEBUG_HEADER, "header 0x%02x",
@@ -341,7 +342,7 @@ gboolean g_obex_header_get_bytes(GObexHeader *header, const guint8 **val,
 GObexApparam *g_obex_header_get_apparam(GObexHeader *header)
 {
 	gboolean ret;
-	const guint8 *val;
+	const uint8_t *val;
 	gsize len;
 
 	ret = g_obex_header_get_bytes(header, &val, &len);
@@ -351,7 +352,7 @@ GObexApparam *g_obex_header_get_apparam(GObexHeader *header)
 	return g_obex_apparam_decode(val, len);
 }
 
-gboolean g_obex_header_get_uint8(GObexHeader *header, guint8 *val)
+gboolean g_obex_header_get_uint8(GObexHeader *header, uint8_t *val)
 {
 	g_obex_debug(G_OBEX_DEBUG_HEADER, "header 0x%02x",
 						G_OBEX_HDR_ENC(header->id));
@@ -366,7 +367,7 @@ gboolean g_obex_header_get_uint8(GObexHeader *header, guint8 *val)
 	return TRUE;
 }
 
-gboolean g_obex_header_get_uint32(GObexHeader *header, guint32 *val)
+gboolean g_obex_header_get_uint32(GObexHeader *header, uint32_t *val)
 {
 	g_obex_debug(G_OBEX_DEBUG_HEADER, "header 0x%02x",
 						G_OBEX_HDR_ENC(header->id));
@@ -381,7 +382,7 @@ gboolean g_obex_header_get_uint32(GObexHeader *header, guint32 *val)
 	return TRUE;
 }
 
-GObexHeader *g_obex_header_new_unicode(guint8 id, const char *str)
+GObexHeader *g_obex_header_new_unicode(uint8_t id, const char *str)
 {
 	GObexHeader *header;
 	gsize len;
@@ -406,7 +407,7 @@ GObexHeader *g_obex_header_new_unicode(guint8 id, const char *str)
 	return header;
 }
 
-GObexHeader *g_obex_header_new_bytes(guint8 id, const void *data, gsize len)
+GObexHeader *g_obex_header_new_bytes(uint8_t id, const void *data, gsize len)
 {
 	GObexHeader *header;
 
@@ -427,7 +428,7 @@ GObexHeader *g_obex_header_new_bytes(guint8 id, const void *data, gsize len)
 
 GObexHeader *g_obex_header_new_apparam(GObexApparam *apparam)
 {
-	guint8 buf[1024];
+	uint8_t buf[1024];
 	gssize len;
 
 	len = g_obex_apparam_encode(apparam, buf, sizeof(buf));
@@ -437,7 +438,7 @@ GObexHeader *g_obex_header_new_apparam(GObexApparam *apparam)
 	return g_obex_header_new_bytes(G_OBEX_HDR_APPARAM, buf, len);
 }
 
-GObexHeader *g_obex_header_new_uint8(guint8 id, guint8 val)
+GObexHeader *g_obex_header_new_uint8(uint8_t id, uint8_t val)
 {
 	GObexHeader *header;
 
@@ -458,7 +459,7 @@ GObexHeader *g_obex_header_new_uint8(guint8 id, guint8 val)
 	return header;
 }
 
-GObexHeader *g_obex_header_new_uint32(guint8 id, guint32 val)
+GObexHeader *g_obex_header_new_uint32(uint8_t id, uint32_t val)
 {
 	GObexHeader *header;
 
@@ -479,7 +480,7 @@ GObexHeader *g_obex_header_new_uint32(guint8 id, guint32 val)
 	return header;
 }
 
-guint8 g_obex_header_get_id(GObexHeader *header)
+uint8_t g_obex_header_get_id(GObexHeader *header)
 {
 	g_obex_debug(G_OBEX_DEBUG_HEADER, "header 0x%02x id 0x%02x",
 				G_OBEX_HDR_ENC(header->id), header->id);
@@ -487,7 +488,7 @@ guint8 g_obex_header_get_id(GObexHeader *header)
 	return header->id;
 }
 
-guint16 g_obex_header_get_length(GObexHeader *header)
+uint16_t g_obex_header_get_length(GObexHeader *header)
 {
 	g_obex_debug(G_OBEX_DEBUG_HEADER, "header 0x%02x length %zu",
 				G_OBEX_HDR_ENC(header->id), header->hlen);
@@ -495,7 +496,7 @@ guint16 g_obex_header_get_length(GObexHeader *header)
 	return header->hlen;
 }
 
-GSList *g_obex_header_create_list(guint8 first_hdr_id, va_list args,
+GSList *g_obex_header_create_list(uint8_t first_hdr_id, va_list args,
 							gsize *total_len)
 {
 	unsigned int id = first_hdr_id;
diff --git a/gobex/gobex-header.h b/gobex/gobex-header.h
index 42a2a0c..64510ac 100644
--- a/gobex/gobex-header.h
+++ b/gobex/gobex-header.h
@@ -23,6 +23,7 @@
 #ifndef __GOBEX_HEADER_H
 #define __GOBEX_HEADER_H
 
+#include <inttypes.h>
 #include <glib.h>
 
 #include <gobex/gobex-defs.h>
@@ -75,23 +76,23 @@
 typedef struct _GObexHeader GObexHeader;
 
 gboolean g_obex_header_get_unicode(GObexHeader *header, const char **str);
-gboolean g_obex_header_get_bytes(GObexHeader *header, const guint8 **val,
+gboolean g_obex_header_get_bytes(GObexHeader *header, const uint8_t **val,
 								gsize *len);
-gboolean g_obex_header_get_uint8(GObexHeader *header, guint8 *val);
-gboolean g_obex_header_get_uint32(GObexHeader *header, guint32 *val);
+gboolean g_obex_header_get_uint8(GObexHeader *header, uint8_t *val);
+gboolean g_obex_header_get_uint32(GObexHeader *header, uint32_t *val);
 GObexApparam *g_obex_header_get_apparam(GObexHeader *header);
 
-GObexHeader *g_obex_header_new_unicode(guint8 id, const char *str);
-GObexHeader *g_obex_header_new_bytes(guint8 id, const void *data, gsize len);
-GObexHeader *g_obex_header_new_uint8(guint8 id, guint8 val);
-GObexHeader *g_obex_header_new_uint32(guint8 id, guint32 val);
+GObexHeader *g_obex_header_new_unicode(uint8_t id, const char *str);
+GObexHeader *g_obex_header_new_bytes(uint8_t id, const void *data, gsize len);
+GObexHeader *g_obex_header_new_uint8(uint8_t id, uint8_t val);
+GObexHeader *g_obex_header_new_uint32(uint8_t id, uint32_t val);
 GObexHeader *g_obex_header_new_apparam(GObexApparam *apparam);
 
-GSList *g_obex_header_create_list(guint8 first_hdr_id, va_list args,
+GSList *g_obex_header_create_list(uint8_t first_hdr_id, va_list args,
 							gsize *total_len);
 
-guint8 g_obex_header_get_id(GObexHeader *header);
-guint16 g_obex_header_get_length(GObexHeader *header);
+uint8_t g_obex_header_get_id(GObexHeader *header);
+uint16_t g_obex_header_get_length(GObexHeader *header);
 
 gssize g_obex_header_encode(GObexHeader *header, void *buf, gsize buf_len);
 GObexHeader *g_obex_header_decode(const void *data, gsize len,
diff --git a/gobex/gobex-packet.c b/gobex/gobex-packet.c
index 4c14cf7..911f1d4 100644
--- a/gobex/gobex-packet.c
+++ b/gobex/gobex-packet.c
@@ -24,6 +24,7 @@
 #include <config.h>
 #endif
 
+#include <inttypes.h>
 #include <string.h>
 #include <errno.h>
 
@@ -34,7 +35,7 @@
 #define FINAL_BIT 0x80
 
 struct _GObexPacket {
-	guint8 opcode;
+	uint8_t opcode;
 	gboolean final;
 
 	GObexDataPolicy data_policy;
@@ -52,7 +53,7 @@ struct _GObexPacket {
 	gpointer get_body_data;
 };
 
-GObexHeader *g_obex_packet_get_header(GObexPacket *pkt, guint8 id)
+GObexHeader *g_obex_packet_get_header(GObexPacket *pkt, uint8_t id)
 {
 	GSList *l;
 
@@ -81,7 +82,7 @@ GObexHeader *g_obex_packet_get_body(GObexPacket *pkt)
 	return g_obex_packet_get_header(pkt, G_OBEX_HDR_BODY_END);
 }
 
-guint8 g_obex_packet_get_operation(GObexPacket *pkt, gboolean *final)
+uint8_t g_obex_packet_get_operation(GObexPacket *pkt, gboolean *final)
 {
 	g_obex_debug(G_OBEX_DEBUG_PACKET, "opcode 0x%02x", pkt->opcode);
 
@@ -125,7 +126,7 @@ gboolean g_obex_packet_add_body(GObexPacket *pkt, GObexDataProducer func,
 	return TRUE;
 }
 
-gboolean g_obex_packet_add_unicode(GObexPacket *pkt, guint8 id,
+gboolean g_obex_packet_add_unicode(GObexPacket *pkt, uint8_t id,
 							const char *str)
 {
 	GObexHeader *hdr;
@@ -139,7 +140,7 @@ gboolean g_obex_packet_add_unicode(GObexPacket *pkt, guint8 id,
 	return g_obex_packet_add_header(pkt, hdr);
 }
 
-gboolean g_obex_packet_add_bytes(GObexPacket *pkt, guint8 id,
+gboolean g_obex_packet_add_bytes(GObexPacket *pkt, uint8_t id,
 						const void *data, gsize len)
 {
 	GObexHeader *hdr;
@@ -153,7 +154,7 @@ gboolean g_obex_packet_add_bytes(GObexPacket *pkt, guint8 id,
 	return g_obex_packet_add_header(pkt, hdr);
 }
 
-gboolean g_obex_packet_add_uint8(GObexPacket *pkt, guint8 id, guint8 val)
+gboolean g_obex_packet_add_uint8(GObexPacket *pkt, uint8_t id, uint8_t val)
 {
 	GObexHeader *hdr;
 
@@ -166,7 +167,7 @@ gboolean g_obex_packet_add_uint8(GObexPacket *pkt, guint8 id, guint8 val)
 	return g_obex_packet_add_header(pkt, hdr);
 }
 
-gboolean g_obex_packet_add_uint32(GObexPacket *pkt, guint8 id, guint32 val)
+gboolean g_obex_packet_add_uint32(GObexPacket *pkt, uint8_t id, uint32_t val)
 {
 	GObexHeader *hdr;
 
@@ -227,8 +228,8 @@ gboolean g_obex_packet_set_data(GObexPacket *pkt, const void *data, gsize len,
 	return TRUE;
 }
 
-GObexPacket *g_obex_packet_new_valist(guint8 opcode, gboolean final,
-					guint8 first_hdr_id, va_list args)
+GObexPacket *g_obex_packet_new_valist(uint8_t opcode, gboolean final,
+					uint8_t first_hdr_id, va_list args)
 {
 	GObexPacket *pkt;
 
@@ -245,8 +246,8 @@ GObexPacket *g_obex_packet_new_valist(guint8 opcode, gboolean final,
 	return pkt;
 }
 
-GObexPacket *g_obex_packet_new(guint8 opcode, gboolean final,
-						guint8 first_hdr_id, ...)
+GObexPacket *g_obex_packet_new(uint8_t opcode, gboolean final,
+						uint8_t first_hdr_id, ...)
 {
 	GObexPacket *pkt;
 	va_list args;
@@ -282,7 +283,7 @@ static gboolean parse_headers(GObexPacket *pkt, const void *data, gsize len,
 						GObexDataPolicy data_policy,
 						GError **err)
 {
-	const guint8 *buf = data;
+	const uint8_t *buf = data;
 
 	g_obex_debug(G_OBEX_DEBUG_PACKET, "opcode 0x%02x", pkt->opcode);
 
@@ -305,7 +306,7 @@ static gboolean parse_headers(GObexPacket *pkt, const void *data, gsize len,
 	return TRUE;
 }
 
-static const guint8 *get_bytes(void *to, const guint8 *from, gsize count)
+static const uint8_t *get_bytes(void *to, const uint8_t *from, gsize count)
 {
 	memcpy(to, from, count);
 	return (from + count);
@@ -316,9 +317,9 @@ GObexPacket *g_obex_packet_decode(const void *data, gsize len,
 						GObexDataPolicy data_policy,
 						GError **err)
 {
-	const guint8 *buf = data;
-	guint16 packet_len;
-	guint8 opcode;
+	const uint8_t *buf = data;
+	uint16_t packet_len;
+	uint8_t opcode;
 	GObexPacket *pkt;
 	gboolean final;
 
@@ -373,9 +374,9 @@ failed:
 	return NULL;
 }
 
-static gssize get_body(GObexPacket *pkt, guint8 *buf, gsize len)
+static gssize get_body(GObexPacket *pkt, uint8_t *buf, gsize len)
 {
-	guint16 u16;
+	uint16_t u16;
 	gssize ret;
 
 	g_obex_debug(G_OBEX_DEBUG_PACKET, "opcode 0x%02x", pkt->opcode);
@@ -398,11 +399,11 @@ static gssize get_body(GObexPacket *pkt, guint8 *buf, gsize len)
 	return ret;
 }
 
-gssize g_obex_packet_encode(GObexPacket *pkt, guint8 *buf, gsize len)
+gssize g_obex_packet_encode(GObexPacket *pkt, uint8_t *buf, gsize len)
 {
 	gssize ret;
 	gsize count;
-	guint16 u16;
+	uint16_t u16;
 	GSList *l;
 
 	g_obex_debug(G_OBEX_DEBUG_PACKET, "opcode 0x%02x", pkt->opcode);
diff --git a/gobex/gobex-packet.h b/gobex/gobex-packet.h
index 6121fa7..66289f0 100644
--- a/gobex/gobex-packet.h
+++ b/gobex/gobex-packet.h
@@ -23,6 +23,7 @@
 #ifndef __GOBEX_PACKET_H
 #define __GOBEX_PACKET_H
 
+#include <inttypes.h>
 #include <stdarg.h>
 #include <glib.h>
 
@@ -81,32 +82,32 @@
 
 typedef struct _GObexPacket GObexPacket;
 
-GObexHeader *g_obex_packet_get_header(GObexPacket *pkt, guint8 id);
+GObexHeader *g_obex_packet_get_header(GObexPacket *pkt, uint8_t id);
 GObexHeader *g_obex_packet_get_body(GObexPacket *pkt);
-guint8 g_obex_packet_get_operation(GObexPacket *pkt, gboolean *final);
+uint8_t g_obex_packet_get_operation(GObexPacket *pkt, gboolean *final);
 gboolean g_obex_packet_prepend_header(GObexPacket *pkt, GObexHeader *header);
 gboolean g_obex_packet_add_header(GObexPacket *pkt, GObexHeader *header);
 gboolean g_obex_packet_add_body(GObexPacket *pkt, GObexDataProducer func,
 							gpointer user_data);
-gboolean g_obex_packet_add_unicode(GObexPacket *pkt, guint8 id,
+gboolean g_obex_packet_add_unicode(GObexPacket *pkt, uint8_t id,
 							const char *str);
-gboolean g_obex_packet_add_bytes(GObexPacket *pkt, guint8 id,
+gboolean g_obex_packet_add_bytes(GObexPacket *pkt, uint8_t id,
 						const void *data, gsize len);
-gboolean g_obex_packet_add_uint8(GObexPacket *pkt, guint8 id, guint8 val);
-gboolean g_obex_packet_add_uint32(GObexPacket *pkt, guint8 id, guint32 val);
+gboolean g_obex_packet_add_uint8(GObexPacket *pkt, uint8_t id, uint8_t val);
+gboolean g_obex_packet_add_uint32(GObexPacket *pkt, uint8_t id, uint32_t val);
 gboolean g_obex_packet_set_data(GObexPacket *pkt, const void *data, gsize len,
 						GObexDataPolicy data_policy);
 const void *g_obex_packet_get_data(GObexPacket *pkt, gsize *len);
-GObexPacket *g_obex_packet_new(guint8 opcode, gboolean final,
-						guint8 first_hdr_id, ...);
-GObexPacket *g_obex_packet_new_valist(guint8 opcode, gboolean final,
-					guint8 first_hdr_id, va_list args);
+GObexPacket *g_obex_packet_new(uint8_t opcode, gboolean final,
+						uint8_t first_hdr_id, ...);
+GObexPacket *g_obex_packet_new_valist(uint8_t opcode, gboolean final,
+					uint8_t first_hdr_id, va_list args);
 void g_obex_packet_free(GObexPacket *pkt);
 
 GObexPacket *g_obex_packet_decode(const void *data, gsize len,
 						gsize header_offset,
 						GObexDataPolicy data_policy,
 						GError **err);
-gssize g_obex_packet_encode(GObexPacket *pkt, guint8 *buf, gsize len);
+gssize g_obex_packet_encode(GObexPacket *pkt, uint8_t *buf, gsize len);
 
 #endif /* __GOBEX_PACKET_H */
diff --git a/gobex/gobex-transfer.c b/gobex/gobex-transfer.c
index ac8836c..4f3fb00 100644
--- a/gobex/gobex-transfer.c
+++ b/gobex/gobex-transfer.c
@@ -24,6 +24,7 @@
 #include <config.h>
 #endif
 
+#include <inttypes.h>
 #include <string.h>
 #include <errno.h>
 
@@ -38,16 +39,16 @@ static void transfer_response(GObex *obex, GError *err, GObexPacket *rsp,
 							gpointer user_data);
 
 struct transfer {
-	guint id;
-	guint8 opcode;
+	unsigned int id;
+	uint8_t opcode;
 
 	GObex *obex;
 
-	guint req_id;
+	unsigned int req_id;
 
-	guint put_id;
-	guint get_id;
-	guint abort_id;
+	unsigned int put_id;
+	unsigned int get_id;
+	unsigned int abort_id;
 
 	GObexDataProducer data_producer;
 	GObexDataConsumer data_consumer;
@@ -81,7 +82,7 @@ static void transfer_free(struct transfer *transfer)
 	g_free(transfer);
 }
 
-static struct transfer *find_transfer(guint id)
+static struct transfer *find_transfer(unsigned int id)
 {
 	GSList *l;
 
@@ -96,7 +97,7 @@ static struct transfer *find_transfer(guint id)
 
 static void transfer_complete(struct transfer *transfer, GError *err)
 {
-	guint id = transfer->id;
+	unsigned int id = transfer->id;
 
 	g_obex_debug(G_OBEX_DEBUG_TRANSFER, "transfer %u", id);
 
@@ -171,7 +172,7 @@ static gboolean handle_get_body(struct transfer *transfer, GObexPacket *rsp,
 {
 	GObexHeader *body = g_obex_packet_get_body(rsp);
 	gboolean ret;
-	const guint8 *buf;
+	const uint8_t *buf;
 	gsize len;
 
 	if (body == NULL)
@@ -243,10 +244,10 @@ failed:
 	}
 }
 
-static struct transfer *transfer_new(GObex *obex, guint8 opcode,
+static struct transfer *transfer_new(GObex *obex, uint8_t opcode,
 				GObexFunc complete_func, gpointer user_data)
 {
-	static guint next_id = 1;
+	static unsigned int next_id = 1;
 	struct transfer *transfer;
 
 	g_obex_debug(G_OBEX_DEBUG_TRANSFER, "obex %p opcode %u", obex, opcode);
@@ -264,7 +265,7 @@ static struct transfer *transfer_new(GObex *obex, guint8 opcode,
 	return transfer;
 }
 
-guint g_obex_put_req_pkt(GObex *obex, GObexPacket *req,
+unsigned int g_obex_put_req_pkt(GObex *obex, GObexPacket *req,
 			GObexDataProducer data_func, GObexFunc complete_func,
 			gpointer user_data, GError **err)
 {
@@ -292,9 +293,9 @@ guint g_obex_put_req_pkt(GObex *obex, GObexPacket *req,
 	return transfer->id;
 }
 
-guint g_obex_put_req(GObex *obex, GObexDataProducer data_func,
+unsigned int g_obex_put_req(GObex *obex, GObexDataProducer data_func,
 			GObexFunc complete_func, gpointer user_data,
-			GError **err, guint8 first_hdr_id, ...)
+			GError **err, uint8_t first_hdr_id, ...)
 {
 	GObexPacket *req;
 	va_list args;
@@ -327,12 +328,12 @@ static void transfer_abort_req(GObex *obex, GObexPacket *req, gpointer user_data
 	g_error_free(err);
 }
 
-static guint8 put_get_bytes(struct transfer *transfer, GObexPacket *req)
+static uint8_t put_get_bytes(struct transfer *transfer, GObexPacket *req)
 {
 	GObexHeader *body;
 	gboolean final;
-	guint8 rsp;
-	const guint8 *buf;
+	uint8_t rsp;
+	const uint8_t *buf;
 	gsize len;
 
 	g_obex_debug(G_OBEX_DEBUG_TRANSFER, "transfer %u", transfer->id);
@@ -358,11 +359,11 @@ static guint8 put_get_bytes(struct transfer *transfer, GObexPacket *req)
 }
 
 static void transfer_put_req_first(struct transfer *transfer, GObexPacket *req,
-					guint8 first_hdr_id, va_list args)
+					uint8_t first_hdr_id, va_list args)
 {
 	GError *err = NULL;
 	GObexPacket *rsp;
-	guint8 rspcode;
+	uint8_t rspcode;
 
 	g_obex_debug(G_OBEX_DEBUG_TRANSFER, "transfer %u", transfer->id);
 
@@ -384,7 +385,7 @@ static void transfer_put_req(GObex *obex, GObexPacket *req, gpointer user_data)
 	struct transfer *transfer = user_data;
 	GError *err = NULL;
 	GObexPacket *rsp;
-	guint8 rspcode;
+	uint8_t rspcode;
 
 	g_obex_debug(G_OBEX_DEBUG_TRANSFER, "transfer %u", transfer->id);
 
@@ -407,14 +408,14 @@ done:
 		transfer_complete(transfer, NULL);
 }
 
-guint g_obex_put_rsp(GObex *obex, GObexPacket *req,
+unsigned int g_obex_put_rsp(GObex *obex, GObexPacket *req,
 			GObexDataConsumer data_func, GObexFunc complete_func,
 			gpointer user_data, GError **err,
-			guint8 first_hdr_id, ...)
+			uint8_t first_hdr_id, ...)
 {
 	struct transfer *transfer;
 	va_list args;
-	guint id;
+	unsigned int id;
 
 	g_obex_debug(G_OBEX_DEBUG_TRANSFER, "obex %p", obex);
 
@@ -441,7 +442,7 @@ guint g_obex_put_rsp(GObex *obex, GObexPacket *req,
 	return transfer->id;
 }
 
-guint g_obex_get_req_pkt(GObex *obex, GObexPacket *req,
+unsigned int g_obex_get_req_pkt(GObex *obex, GObexPacket *req,
 			GObexDataConsumer data_func, GObexFunc complete_func,
 			gpointer user_data, GError **err)
 {
@@ -466,9 +467,9 @@ guint g_obex_get_req_pkt(GObex *obex, GObexPacket *req,
 	return transfer->id;
 }
 
-guint g_obex_get_req(GObex *obex, GObexDataConsumer data_func,
+unsigned int g_obex_get_req(GObex *obex, GObexDataConsumer data_func,
 			GObexFunc complete_func, gpointer user_data,
-			GError **err, guint8 first_hdr_id, ...)
+			GError **err, uint8_t first_hdr_id, ...)
 {
 	struct transfer *transfer;
 	GObexPacket *req;
@@ -502,7 +503,7 @@ static gssize get_get_data(void *buf, gsize len, gpointer user_data)
 	GObexPacket *req, *rsp;
 	GError *err = NULL;
 	gssize ret;
-	guint8 op;
+	uint8_t op;
 
 	g_obex_debug(G_OBEX_DEBUG_TRANSFER, "transfer %u", transfer->id);
 
@@ -577,12 +578,12 @@ static void transfer_get_req(GObex *obex, GObexPacket *req, gpointer user_data)
 	}
 }
 
-guint g_obex_get_rsp_pkt(GObex *obex, GObexPacket *rsp,
+unsigned int g_obex_get_rsp_pkt(GObex *obex, GObexPacket *rsp,
 			GObexDataProducer data_func, GObexFunc complete_func,
 			gpointer user_data, GError **err)
 {
 	struct transfer *transfer;
-	guint id;
+	unsigned int id;
 
 	g_obex_debug(G_OBEX_DEBUG_TRANSFER, "obex %p", obex);
 
@@ -607,9 +608,9 @@ guint g_obex_get_rsp_pkt(GObex *obex, GObexPacket *rsp,
 	return transfer->id;
 }
 
-guint g_obex_get_rsp(GObex *obex, GObexDataProducer data_func,
+unsigned int g_obex_get_rsp(GObex *obex, GObexDataProducer data_func,
 			GObexFunc complete_func, gpointer user_data,
-			GError **err, guint8 first_hdr_id, ...)
+			GError **err, uint8_t first_hdr_id, ...)
 {
 	GObexPacket *rsp;
 	va_list args;
@@ -625,7 +626,7 @@ guint g_obex_get_rsp(GObex *obex, GObexDataProducer data_func,
 							user_data, err);
 }
 
-gboolean g_obex_cancel_transfer(guint id, GObexFunc complete_func,
+gboolean g_obex_cancel_transfer(unsigned int id, GObexFunc complete_func,
 			gpointer user_data)
 {
 	struct transfer *transfer = NULL;
diff --git a/gobex/gobex.c b/gobex/gobex.c
index deeab40..9bf2398 100644
--- a/gobex/gobex.c
+++ b/gobex/gobex.c
@@ -24,6 +24,7 @@
 # include "config.h"
 #endif
 
+#include <inttypes.h>
 #include <unistd.h>
 #include <string.h>
 #include <errno.h>
@@ -44,30 +45,30 @@
 
 #define CONNID_INVALID		0xffffffff
 
-guint gobex_debug = 0;
+unsigned int gobex_debug = 0;
 
 struct srm_config {
-	guint8 op;
+	uint8_t op;
 	gboolean enabled;
-	guint8 srm;
-	guint8 srmp;
+	uint8_t srm;
+	uint8_t srmp;
 	gboolean outgoing;
 };
 
 struct _GObex {
 	int ref_count;
 	GIOChannel *io;
-	guint io_source;
+	unsigned int io_source;
 
 	gboolean (*read) (GObex *obex, GError **err);
 	gboolean (*write) (GObex *obex, GError **err);
 
-	guint8 *rx_buf;
+	uint8_t *rx_buf;
 	size_t rx_data;
-	guint16 rx_pkt_len;
-	guint8 rx_last_op;
+	uint16_t rx_pkt_len;
+	uint8_t rx_last_op;
 
-	guint8 *tx_buf;
+	uint8_t *tx_buf;
 	size_t tx_data;
 	size_t tx_sent;
 
@@ -76,15 +77,15 @@ struct _GObex {
 
 	struct srm_config *srm;
 
-	guint write_source;
+	unsigned int write_source;
 
 	gssize io_rx_mtu;
 	gssize io_tx_mtu;
 
-	guint16 rx_mtu;
-	guint16 tx_mtu;
+	uint16_t rx_mtu;
+	uint16_t tx_mtu;
 
-	guint32 conn_id;
+	uint32_t conn_id;
 
 	GQueue *tx_queue;
 
@@ -97,36 +98,36 @@ struct _GObex {
 };
 
 struct pending_pkt {
-	guint id;
+	unsigned int id;
 	GObex *obex;
 	GObexPacket *pkt;
-	guint timeout;
-	guint timeout_id;
+	unsigned int timeout;
+	unsigned int timeout_id;
 	GObexResponseFunc rsp_func;
 	gpointer rsp_data;
 	gboolean cancelled;
 };
 
 struct req_handler {
-	guint id;
-	guint8 opcode;
+	unsigned int id;
+	uint8_t opcode;
 	GObexRequestFunc func;
 	gpointer user_data;
 };
 
 struct connect_data {
-	guint8 version;
-	guint8 flags;
-	guint16 mtu;
+	uint8_t version;
+	uint8_t flags;
+	uint16_t mtu;
 } __attribute__ ((packed));
 
 struct setpath_data {
-	guint8 flags;
-	guint8 constants;
+	uint8_t flags;
+	uint8_t constants;
 } __attribute__ ((packed));
 
 static struct error_code {
-	guint8 code;
+	uint8_t code;
 	const char *name;
 } obex_errors[] = {
 	{ G_OBEX_RSP_CONTINUE,			"Continue" },
@@ -170,7 +171,7 @@ static struct error_code {
 	{ 0x00,					NULL }
 };
 
-const char *g_obex_strerror(guint8 err_code)
+const char *g_obex_strerror(uint8_t err_code)
 {
 	struct error_code *error;
 
@@ -182,7 +183,7 @@ const char *g_obex_strerror(guint8 err_code)
 	return "<unknown>";
 }
 
-static ssize_t req_header_offset(guint8 opcode)
+static ssize_t req_header_offset(uint8_t opcode)
 {
 	switch (opcode) {
 	case G_OBEX_OP_CONNECT:
@@ -201,7 +202,7 @@ static ssize_t req_header_offset(guint8 opcode)
 	}
 }
 
-static ssize_t rsp_header_offset(guint8 opcode)
+static ssize_t rsp_header_offset(uint8_t opcode)
 {
 	switch (opcode) {
 	case G_OBEX_OP_CONNECT:
@@ -299,7 +300,7 @@ static gboolean write_packet(GObex *obex, GError **err)
 	return TRUE;
 }
 
-static void set_srmp(GObex *obex, guint8 srmp, gboolean outgoing)
+static void set_srmp(GObex *obex, uint8_t srmp, gboolean outgoing)
 {
 	struct srm_config *config = obex->srm;
 
@@ -314,7 +315,7 @@ static void set_srmp(GObex *obex, guint8 srmp, gboolean outgoing)
 	config->outgoing = outgoing;
 }
 
-static void set_srm(GObex *obex, guint8 op, guint8 srm)
+static void set_srm(GObex *obex, uint8_t op, uint8_t srm)
 {
 	struct srm_config *config = obex->srm;
 	gboolean enable;
@@ -355,7 +356,7 @@ done:
 	obex->srm = NULL;
 }
 
-static void check_srm_final(GObex *obex, guint8 op)
+static void check_srm_final(GObex *obex, uint8_t op)
 {
 	if (obex->srm == NULL || !obex->srm->enabled)
 		return;
@@ -374,7 +375,7 @@ static void check_srm_final(GObex *obex, guint8 op)
 static void setup_srm(GObex *obex, GObexPacket *pkt, gboolean outgoing)
 {
 	GObexHeader *hdr;
-	guint8 op;
+	uint8_t op;
 	gboolean final;
 
 	if (!obex->use_srm)
@@ -384,7 +385,7 @@ static void setup_srm(GObex *obex, GObexPacket *pkt, gboolean outgoing)
 
 	hdr = g_obex_packet_get_header(pkt, G_OBEX_HDR_SRM);
 	if (hdr != NULL) {
-		guint8 srm;
+		uint8_t srm;
 		g_obex_header_get_uint8(hdr, &srm);
 		g_obex_debug(G_OBEX_DEBUG_COMMAND, "srm 0x%02x", srm);
 		set_srm(obex, op, srm);
@@ -392,7 +393,7 @@ static void setup_srm(GObex *obex, GObexPacket *pkt, gboolean outgoing)
 
 	hdr = g_obex_packet_get_header(pkt, G_OBEX_HDR_SRMP);
 	if (hdr != NULL) {
-		guint8 srmp;
+		uint8_t srmp;
 		g_obex_header_get_uint8(hdr, &srmp);
 		g_obex_debug(G_OBEX_DEBUG_COMMAND, "srmp 0x%02x", srmp);
 		set_srmp(obex, srmp, outgoing);
@@ -520,7 +521,7 @@ static gboolean g_obex_send_internal(GObex *obex, struct pending_pkt *p,
 
 static void init_connect_data(GObex *obex, struct connect_data *data)
 {
-	guint16 u16;
+	uint16_t u16;
 
 	memset(data, 0, sizeof(*data));
 
@@ -535,7 +536,7 @@ static void prepare_connect_rsp(GObex *obex, GObexPacket *rsp)
 {
 	GObexHeader *connid;
 	struct connect_data data;
-	static guint32 next_connid = 1;
+	static uint32_t next_connid = 1;
 
 	init_connect_data(obex, &data);
 	g_obex_packet_set_data(rsp, &data, sizeof(data), G_OBEX_DATA_COPY);
@@ -623,14 +624,14 @@ static void prepare_srm_req(GObex *obex, GObexPacket *pkt)
 	g_obex_packet_prepend_header(pkt, hdr);
 }
 
-guint g_obex_send_req(GObex *obex, GObexPacket *req, int timeout,
+unsigned int g_obex_send_req(GObex *obex, GObexPacket *req, int timeout,
 			GObexResponseFunc func, gpointer user_data,
 			GError **err)
 {
 	GObexHeader *hdr;
 	struct pending_pkt *p;
-	static guint id = 1;
-	guint8 op;
+	static unsigned int id = 1;
+	uint8_t op;
 
 	g_obex_debug(G_OBEX_DEBUG_COMMAND, "conn %u", obex->conn_id);
 
@@ -680,7 +681,7 @@ create_pending:
 static int pending_pkt_cmp(gconstpointer a, gconstpointer b)
 {
 	const struct pending_pkt *p = a;
-	guint id = GPOINTER_TO_UINT(b);
+	unsigned int id = GPOINTER_TO_UINT(b);
 
 	return (p->id - id);
 }
@@ -723,7 +724,8 @@ static gboolean cancel_complete(gpointer user_data)
 	return FALSE;
 }
 
-gboolean g_obex_cancel_req(GObex *obex, guint req_id, gboolean remove_callback)
+gboolean g_obex_cancel_req(GObex *obex, unsigned int req_id,
+						gboolean remove_callback)
 {
 	GList *match;
 	struct pending_pkt *p;
@@ -762,8 +764,8 @@ immediate_completion:
 	return TRUE;
 }
 
-gboolean g_obex_send_rsp(GObex *obex, guint8 rspcode, GError **err,
-						guint8 first_hdr_type, ...)
+gboolean g_obex_send_rsp(GObex *obex, uint8_t rspcode, GError **err,
+						uint8_t first_hdr_type, ...)
 {
 	GObexPacket *rsp;
 	va_list args;
@@ -785,7 +787,7 @@ void g_obex_set_disconnect_function(GObex *obex, GObexFunc func,
 static int req_handler_cmpop(gconstpointer a, gconstpointer b)
 {
 	const struct req_handler *handler = a;
-	guint opcode = GPOINTER_TO_UINT(b);
+	unsigned int opcode = GPOINTER_TO_UINT(b);
 
 	return (int) handler->opcode - (int) opcode;
 }
@@ -793,17 +795,17 @@ static int req_handler_cmpop(gconstpointer a, gconstpointer b)
 static int req_handler_cmpid(gconstpointer a, gconstpointer b)
 {
 	const struct req_handler *handler = a;
-	guint id = GPOINTER_TO_UINT(b);
+	unsigned int id = GPOINTER_TO_UINT(b);
 
 	return (int) handler->id - (int) id;
 }
 
-guint g_obex_add_request_function(GObex *obex, guint8 opcode,
+unsigned int g_obex_add_request_function(GObex *obex, uint8_t opcode,
 						GObexRequestFunc func,
 						gpointer user_data)
 {
 	struct req_handler *handler;
-	static guint next_id = 1;
+	static unsigned int next_id = 1;
 
 	handler = g_new0(struct req_handler, 1);
 	handler->id = next_id++;
@@ -816,7 +818,7 @@ guint g_obex_add_request_function(GObex *obex, guint8 opcode,
 	return handler->id;
 }
 
-gboolean g_obex_remove_request_function(GObex *obex, guint id)
+gboolean g_obex_remove_request_function(GObex *obex, unsigned int id)
 {
 	struct req_handler *handler;
 	GSList *match;
@@ -879,7 +881,7 @@ static void parse_connect_data(GObex *obex, GObexPacket *pkt)
 {
 	const struct connect_data *data;
 	GObexHeader *connid;
-	guint16 u16;
+	uint16_t u16;
 	size_t data_len;
 
 	data = g_obex_packet_get_data(pkt, &data_len);
@@ -901,7 +903,7 @@ static void parse_connect_data(GObex *obex, GObexPacket *pkt)
 static gboolean parse_response(GObex *obex, GObexPacket *rsp)
 {
 	struct pending_pkt *p = obex->pending_req;
-	guint8 opcode, rspcode;
+	uint8_t opcode, rspcode;
 	gboolean final;
 
 	rspcode = g_obex_packet_get_operation(rsp, &final);
@@ -968,7 +970,7 @@ static void handle_response(GObex *obex, GError *err, GObexPacket *rsp)
 static gboolean check_connid(GObex *obex, GObexPacket *pkt)
 {
 	GObexHeader *hdr;
-	guint32 id;
+	uint32_t id;
 
 	if (obex->conn_id == CONNID_INVALID)
 		return TRUE;
@@ -984,7 +986,7 @@ static gboolean check_connid(GObex *obex, GObexPacket *pkt)
 
 static int parse_request(GObex *obex, GObexPacket *req)
 {
-	guint8 op;
+	uint8_t op;
 	gboolean final;
 
 	op = g_obex_packet_get_operation(req, &final);
@@ -1035,7 +1037,7 @@ static gboolean read_stream(GObex *obex, GError **err)
 	GIOChannel *io = obex->io;
 	GIOStatus status;
 	gsize rbytes, toread;
-	guint16 u16;
+	uint16_t u16;
 	char *buf;
 
 	if (obex->rx_data >= 3)
@@ -1090,7 +1092,7 @@ static gboolean read_packet(GObex *obex, GError **err)
 	GError *read_err = NULL;
 	GIOStatus status;
 	gsize rbytes;
-	guint16 u16;
+	uint16_t u16;
 
 	if (obex->rx_data > 0) {
 		g_set_error(err, G_OBEX_ERROR, G_OBEX_ERROR_PARSE_ERROR,
@@ -1140,7 +1142,7 @@ static gboolean incoming_data(GIOChannel *io, GIOCondition cond,
 	GObexPacket *pkt;
 	ssize_t header_offset;
 	GError *err = NULL;
-	guint8 opcode;
+	uint8_t opcode;
 
 	if (cond & G_IO_NVAL)
 		return FALSE;
@@ -1364,8 +1366,9 @@ void g_obex_unref(GObex *obex)
 
 /* Higher level functions */
 
-guint g_obex_connect(GObex *obex, GObexResponseFunc func, gpointer user_data,
-					GError **err, guint8 first_hdr_id, ...)
+unsigned int g_obex_connect(GObex *obex, GObexResponseFunc func,
+					gpointer user_data, GError **err,
+					uint8_t first_hdr_id, ...)
 {
 	GObexPacket *req;
 	struct connect_data data;
@@ -1384,8 +1387,9 @@ guint g_obex_connect(GObex *obex, GObexResponseFunc func, gpointer user_data,
 	return g_obex_send_req(obex, req, -1, func, user_data, err);
 }
 
-guint g_obex_setpath(GObex *obex, const char *path, GObexResponseFunc func,
-					gpointer user_data, GError **err)
+unsigned int g_obex_setpath(GObex *obex, const char *path,
+				GObexResponseFunc func,	gpointer user_data,
+				GError **err)
 {
 	GObexPacket *req;
 	struct setpath_data data;
@@ -1416,7 +1420,7 @@ guint g_obex_setpath(GObex *obex, const char *path, GObexResponseFunc func,
 	return g_obex_send_req(obex, req, -1, func, user_data, err);
 }
 
-guint g_obex_mkdir(GObex *obex, const char *path, GObexResponseFunc func,
+unsigned int g_obex_mkdir(GObex *obex, const char *path, GObexResponseFunc func,
 					gpointer user_data, GError **err)
 {
 	GObexPacket *req;
@@ -1433,8 +1437,9 @@ guint g_obex_mkdir(GObex *obex, const char *path, GObexResponseFunc func,
 	return g_obex_send_req(obex, req, -1, func, user_data, err);
 }
 
-guint g_obex_delete(GObex *obex, const char *name, GObexResponseFunc func,
-					gpointer user_data, GError **err)
+unsigned int g_obex_delete(GObex *obex, const char *name,
+				GObexResponseFunc func, gpointer user_data,
+				GError **err)
 {
 	GObexPacket *req;
 
@@ -1446,7 +1451,7 @@ guint g_obex_delete(GObex *obex, const char *name, GObexResponseFunc func,
 	return g_obex_send_req(obex, req, -1, func, user_data, err);
 }
 
-guint g_obex_copy(GObex *obex, const char *name, const char *dest,
+unsigned int g_obex_copy(GObex *obex, const char *name, const char *dest,
 			GObexResponseFunc func, gpointer user_data,
 			GError **err)
 {
@@ -1463,7 +1468,7 @@ guint g_obex_copy(GObex *obex, const char *name, const char *dest,
 	return g_obex_send_req(obex, req, -1, func, user_data, err);
 }
 
-guint g_obex_move(GObex *obex, const char *name, const char *dest,
+unsigned int g_obex_move(GObex *obex, const char *name, const char *dest,
 			GObexResponseFunc func, gpointer user_data,
 			GError **err)
 {
@@ -1480,7 +1485,7 @@ guint g_obex_move(GObex *obex, const char *name, const char *dest,
 	return g_obex_send_req(obex, req, -1, func, user_data, err);
 }
 
-guint8 g_obex_errno_to_rsp(int err)
+uint8_t g_obex_errno_to_rsp(int err)
 {
 	switch (err) {
 	case 0:
diff --git a/gobex/gobex.h b/gobex/gobex.h
index 3ac7b13..8491193 100644
--- a/gobex/gobex.h
+++ b/gobex/gobex.h
@@ -23,6 +23,7 @@
 #ifndef __GOBEX_H
 #define __GOBEX_H
 
+#include <inttypes.h>
 #include <stdarg.h>
 #include <glib.h>
 
@@ -44,23 +45,23 @@ typedef void (*GObexResponseFunc) (GObex *obex, GError *err, GObexPacket *rsp,
 
 gboolean g_obex_send(GObex *obex, GObexPacket *pkt, GError **err);
 
-guint g_obex_send_req(GObex *obex, GObexPacket *req, int timeout,
+unsigned int g_obex_send_req(GObex *obex, GObexPacket *req, int timeout,
 			GObexResponseFunc func, gpointer user_data,
 			GError **err);
-gboolean g_obex_cancel_req(GObex *obex, guint req_id,
+gboolean g_obex_cancel_req(GObex *obex, unsigned int req_id,
 						gboolean remove_callback);
 
 gboolean g_obex_pending_req_abort(GObex *obex, GError **err);
 
-gboolean g_obex_send_rsp(GObex *obex, guint8 rspcode, GError **err,
-						guint8 first_hdr_type, ...);
+gboolean g_obex_send_rsp(GObex *obex, uint8_t rspcode, GError **err,
+						uint8_t first_hdr_type, ...);
 
 void g_obex_set_disconnect_function(GObex *obex, GObexFunc func,
 							gpointer user_data);
-guint g_obex_add_request_function(GObex *obex, guint8 opcode,
+unsigned int g_obex_add_request_function(GObex *obex, uint8_t opcode,
 						GObexRequestFunc func,
 						gpointer user_data);
-gboolean g_obex_remove_request_function(GObex *obex, guint id);
+gboolean g_obex_remove_request_function(GObex *obex, unsigned int id);
 
 void g_obex_suspend(GObex *obex);
 void g_obex_resume(GObex *obex);
@@ -74,61 +75,65 @@ void g_obex_unref(GObex *obex);
 
 /* High level client functions */
 
-guint g_obex_connect(GObex *obex, GObexResponseFunc func, gpointer user_data,
-				GError **err, guint8 first_hdr_id, ...);
+unsigned int g_obex_connect(GObex *obex, GObexResponseFunc func,
+					gpointer user_data, GError **err,
+					uint8_t first_hdr_id, ...);
 
-guint g_obex_setpath(GObex *obex, const char *path, GObexResponseFunc func,
+unsigned int g_obex_setpath(GObex *obex, const char *path,
+					GObexResponseFunc func,
 					gpointer user_data, GError **err);
 
-guint g_obex_mkdir(GObex *obex, const char *path, GObexResponseFunc func,
+unsigned int g_obex_mkdir(GObex *obex, const char *path,
+					GObexResponseFunc func,
 					gpointer user_data, GError **err);
 
-guint g_obex_delete(GObex *obex, const char *name, GObexResponseFunc func,
+unsigned int g_obex_delete(GObex *obex, const char *name,
+					GObexResponseFunc func,
 					gpointer user_data, GError **err);
 
-guint g_obex_copy(GObex *obex, const char *name, const char *dest,
+unsigned int g_obex_copy(GObex *obex, const char *name, const char *dest,
 			GObexResponseFunc func, gpointer user_data,
 			GError **err);
 
-guint g_obex_move(GObex *obex, const char *name, const char *dest,
+unsigned int g_obex_move(GObex *obex, const char *name, const char *dest,
 			GObexResponseFunc func, gpointer user_data,
 			GError **err);
 
 /* Transfer related high-level functions */
 
-guint g_obex_put_req(GObex *obex, GObexDataProducer data_func,
+unsigned int g_obex_put_req(GObex *obex, GObexDataProducer data_func,
 			GObexFunc complete_func, gpointer user_data,
-			GError **err, guint8 first_hdr_id, ...);
+			GError **err, uint8_t first_hdr_id, ...);
 
-guint g_obex_put_req_pkt(GObex *obex, GObexPacket *req,
+unsigned int g_obex_put_req_pkt(GObex *obex, GObexPacket *req,
 			GObexDataProducer data_func, GObexFunc complete_func,
 			gpointer user_data, GError **err);
 
-guint g_obex_get_req(GObex *obex, GObexDataConsumer data_func,
+unsigned int g_obex_get_req(GObex *obex, GObexDataConsumer data_func,
 			GObexFunc complete_func, gpointer user_data,
-			GError **err, guint8 first_hdr_id, ...);
+			GError **err, uint8_t first_hdr_id, ...);
 
-guint g_obex_get_req_pkt(GObex *obex, GObexPacket *req,
+unsigned int g_obex_get_req_pkt(GObex *obex, GObexPacket *req,
 			GObexDataConsumer data_func, GObexFunc complete_func,
 			gpointer user_data, GError **err);
 
-guint g_obex_put_rsp(GObex *obex, GObexPacket *req,
+unsigned int g_obex_put_rsp(GObex *obex, GObexPacket *req,
 			GObexDataConsumer data_func, GObexFunc complete_func,
 			gpointer user_data, GError **err,
-			guint8 first_hdr_id, ...);
+			uint8_t first_hdr_id, ...);
 
-guint g_obex_get_rsp(GObex *obex, GObexDataProducer data_func,
+unsigned int g_obex_get_rsp(GObex *obex, GObexDataProducer data_func,
 			GObexFunc complete_func, gpointer user_data,
-			GError **err, guint8 first_hdr_id, ...);
+			GError **err, uint8_t first_hdr_id, ...);
 
-guint g_obex_get_rsp_pkt(GObex *obex, GObexPacket *rsp,
+unsigned int g_obex_get_rsp_pkt(GObex *obex, GObexPacket *rsp,
 			GObexDataProducer data_func, GObexFunc complete_func,
 			gpointer user_data, GError **err);
 
-gboolean g_obex_cancel_transfer(guint id, GObexFunc complete_func,
+gboolean g_obex_cancel_transfer(unsigned int id, GObexFunc complete_func,
 							gpointer user_data);
 
-const char *g_obex_strerror(guint8 err_code);
-guint8 g_obex_errno_to_rsp(int err);
+const char *g_obex_strerror(uint8_t err_code);
+uint8_t g_obex_errno_to_rsp(int err);
 
 #endif /* __GOBEX_H */
-- 
1.8.2.2

