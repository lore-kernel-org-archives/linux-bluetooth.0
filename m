Return-Path: <cyrus@holtmann.org>
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH BlueZ 1/4] gobex/header: Add g_obex_header_new_tag function
Date: Fri, 28 Mar 2014 15:38:36 +0200
Message-Id: <1396013919-15122-1-git-send-email-luiz.dentz@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

From: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>

This function can be used to set tag using GObexApparam as argument but
for arbritary headers.
---
 gobex/gobex-header.c | 9 +++++++--
 gobex/gobex-header.h | 1 +
 2 files changed, 8 insertions(+), 2 deletions(-)

diff --git a/gobex/gobex-header.c b/gobex/gobex-header.c
index 281f8ea..fe70c8b 100644
--- a/gobex/gobex-header.c
+++ b/gobex/gobex-header.c
@@ -425,7 +425,7 @@ GObexHeader *g_obex_header_new_bytes(guint8 id, const void *data, gsize len)
 	return header;
 }
 
-GObexHeader *g_obex_header_new_apparam(GObexApparam *apparam)
+GObexHeader *g_obex_header_new_tag(guint8 id, GObexApparam *apparam)
 {
 	guint8 buf[1024];
 	gssize len;
@@ -434,7 +434,12 @@ GObexHeader *g_obex_header_new_apparam(GObexApparam *apparam)
 	if (len < 0)
 		return NULL;
 
-	return g_obex_header_new_bytes(G_OBEX_HDR_APPARAM, buf, len);
+	return g_obex_header_new_bytes(id, buf, len);
+}
+
+GObexHeader *g_obex_header_new_apparam(GObexApparam *apparam)
+{
+	return g_obex_header_new_tag(G_OBEX_HDR_APPARAM, apparam);
 }
 
 GObexHeader *g_obex_header_new_uint8(guint8 id, guint8 val)
diff --git a/gobex/gobex-header.h b/gobex/gobex-header.h
index 42a2a0c..c2f975f 100644
--- a/gobex/gobex-header.h
+++ b/gobex/gobex-header.h
@@ -85,6 +85,7 @@ GObexHeader *g_obex_header_new_unicode(guint8 id, const char *str);
 GObexHeader *g_obex_header_new_bytes(guint8 id, const void *data, gsize len);
 GObexHeader *g_obex_header_new_uint8(guint8 id, guint8 val);
 GObexHeader *g_obex_header_new_uint32(guint8 id, guint32 val);
+GObexHeader *g_obex_header_new_tag(guint8 id, GObexApparam *apparam);
 GObexHeader *g_obex_header_new_apparam(GObexApparam *apparam);
 
 GSList *g_obex_header_create_list(guint8 first_hdr_id, va_list args,
-- 
1.8.5.3

