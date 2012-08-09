Return-Path: <cyrus@holtmann.org>
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH obexd 3/9] gobex: Integrate GObexApparam with GObexHeader
Date: Thu,  9 Aug 2012 13:32:27 +0300
Message-Id: <1344508353-24647-4-git-send-email-luiz.dentz@gmail.com>
In-Reply-To: <1344508353-24647-1-git-send-email-luiz.dentz@gmail.com>
References: <1344508353-24647-1-git-send-email-luiz.dentz@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

From: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>

This introduce 2 new convenient functions: g_obex_header_get_apparam
which parses and decode an header into GObexApparam and
gobex_header_new_apparam that encode GObexApparam into GObexHeader.
---
 gobex/gobex-header.c | 25 +++++++++++++++++++++++++
 gobex/gobex-header.h |  3 +++
 2 files changed, 28 insertions(+)

diff --git a/gobex/gobex-header.c b/gobex/gobex-header.c
index 56dd9b2..80e8e4e 100644
--- a/gobex/gobex-header.c
+++ b/gobex/gobex-header.c
@@ -337,6 +337,19 @@ gboolean g_obex_header_get_bytes(GObexHeader *header, const guint8 **val,
 	return TRUE;
 }
 
+GObexApparam *g_obex_header_get_apparam(GObexHeader *header)
+{
+	gboolean ret;
+	const guint8 *val;
+	gsize len;
+
+	ret = g_obex_header_get_bytes(header, &val, &len);
+	if (!ret)
+		return NULL;
+
+	return g_obex_apparam_decode(val, len);
+}
+
 gboolean g_obex_header_get_uint8(GObexHeader *header, guint8 *val)
 {
 	g_obex_debug(G_OBEX_DEBUG_HEADER, "header 0x%02x",
@@ -411,6 +424,18 @@ GObexHeader *g_obex_header_new_bytes(guint8 id, const void *data, gsize len)
 	return header;
 }
 
+GObexHeader *g_obex_header_new_apparam(GObexApparam *apparam)
+{
+	guint8 buf[1024];
+	gssize len;
+
+	len = g_obex_apparam_encode(apparam, buf, sizeof(buf));
+	if (len < 0)
+		return NULL;
+
+	return g_obex_header_new_bytes(G_OBEX_HDR_APPARAM, buf, len);
+}
+
 GObexHeader *g_obex_header_new_uint8(guint8 id, guint8 val)
 {
 	GObexHeader *header;
diff --git a/gobex/gobex-header.h b/gobex/gobex-header.h
index 2ee8364..196cb20 100644
--- a/gobex/gobex-header.h
+++ b/gobex/gobex-header.h
@@ -25,6 +25,7 @@
 #include <glib.h>
 
 #include <gobex/gobex-defs.h>
+#include <gobex/gobex-apparam.h>
 
 /* Header ID's */
 #define G_OBEX_HDR_INVALID	0x00
@@ -77,11 +78,13 @@ gboolean g_obex_header_get_bytes(GObexHeader *header, const guint8 **val,
 								gsize *len);
 gboolean g_obex_header_get_uint8(GObexHeader *header, guint8 *val);
 gboolean g_obex_header_get_uint32(GObexHeader *header, guint32 *val);
+GObexApparam *g_obex_header_get_apparam(GObexHeader *header);
 
 GObexHeader *g_obex_header_new_unicode(guint8 id, const char *str);
 GObexHeader *g_obex_header_new_bytes(guint8 id, const void *data, gsize len);
 GObexHeader *g_obex_header_new_uint8(guint8 id, guint8 val);
 GObexHeader *g_obex_header_new_uint32(guint8 id, guint32 val);
+GObexHeader *g_obex_header_new_apparam(GObexApparam *apparam);
 
 GSList *g_obex_header_create_list(guint8 first_hdr_id, va_list args,
 							gsize *total_len);
-- 
1.7.11.2

