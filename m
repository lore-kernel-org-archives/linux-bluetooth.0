Return-Path: <cyrus@holtmann.org>
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH obexd 1/7] gobex: add initial support for debug
Date: Tue, 18 Oct 2011 11:17:01 +0300
Message-Id: <1318925827-5222-1-git-send-email-luiz.dentz@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

From: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>

This adds support for debug using GOBEX_DEBUG environment variable.
---
 gobex/gobex-debug.h |   71 +++++++++++++++++++++++++++++++++++++++++++++++++++
 gobex/gobex.c       |   20 ++++++++++++++
 2 files changed, 91 insertions(+), 0 deletions(-)
 create mode 100644 gobex/gobex-debug.h

diff --git a/gobex/gobex-debug.h b/gobex/gobex-debug.h
new file mode 100644
index 0000000..b01d535
--- /dev/null
+++ b/gobex/gobex-debug.h
@@ -0,0 +1,71 @@
+/*
+ *  OBEX library with GLib integration
+ *
+ *  Copyright (C) 2011  Intel Corporation. All rights reserved.
+ *
+ *  This program is free software; you can redistribute it and/or modify
+ *  it under the terms of the GNU General Public License version 2 as
+ *  published by the Free Software Foundation.
+ *
+ *  This program is distributed in the hope that it will be useful,
+ *  but WITHOUT ANY WARRANTY; without even the implied warranty of
+ *  MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
+ *  GNU General Public License for more details.
+ *
+ *  You should have received a copy of the GNU General Public License
+ *  along with this program; if not, write to the Free Software
+ *  Foundation, Inc., 51 Franklin St, Fifth Floor, Boston, MA  02110-1301  USA
+ *
+ */
+
+#ifndef __GOBEX_DEBUG_H
+#define __GOBEX_DEBUG_H
+
+#include <glib.h>
+#include <stdio.h>
+#include <ctype.h>
+
+#define G_OBEX_DEBUG_NONE	1
+#define G_OBEX_DEBUG_ERROR	(1 << 1)
+#define G_OBEX_DEBUG_COMMAND	(1 << 2)
+#define G_OBEX_DEBUG_TRANSFER	(1 << 3)
+#define G_OBEX_DEBUG_HEADER	(1 << 4)
+#define G_OBEX_DEBUG_PACKET	(1 << 5)
+#define G_OBEX_DEBUG_DATA	(1 << 6)
+
+extern guint gobex_debug;
+
+#define g_obex_debug(level, format, ...) \
+	if (gobex_debug & level) \
+		g_debug("%s:%s() " format, __FILE__, __FUNCTION__, \
+							## __VA_ARGS__)
+
+#define g_obex_dump(prefix, buf, length) \
+	if (gobex_debug & G_OBEX_DEBUG_DATA)  {\
+		register int i, n = 0, size; \
+		guint8 *data = (guint8 *) buf; \
+		gsize len = length; \
+\
+		while (len > 0) { \
+			printf("%s %04x:", prefix, n);\
+\
+			size = len > 16 ? 16 : len; \
+\
+			for (i = 0; i < size; i++) \
+				printf("%02x%s", data[i], (i + 1) % 8 ? " " : \
+									"  "); \
+			for (i = size; i < 16; i++) \
+				printf("  %s", (i + 1) % 8 ? " " : "  "); \
+\
+			for (i = 0; i < size; i++) \
+				printf("%1c", isprint(data[i]) ? data[i] : \
+									'.'); \
+			printf("\n"); \
+\
+			data += size; \
+			len -= size; \
+			n += size; \
+		} \
+	}
+
+#endif /* __GOBEX_DEBUG_H */
diff --git a/gobex/gobex.c b/gobex/gobex.c
index b2c0199..cd4f735 100644
--- a/gobex/gobex.c
+++ b/gobex/gobex.c
@@ -29,6 +29,7 @@
 
 #include "gobex.h"
 #include "glib-helper.h"
+#include "gobex-debug.h"
 
 #define G_OBEX_DEFAULT_MTU	4096
 #define G_OBEX_MINIMUM_MTU	255
@@ -43,6 +44,8 @@
 
 #define CONNID_INVALID		0xffffffff
 
+guint gobex_debug;
+
 struct _GObex {
 	gint ref_count;
 	GIOChannel *io;
@@ -864,12 +867,29 @@ failed:
 	return FALSE;
 }
 
+static GDebugKey keys[] = {
+	{ "error",	G_OBEX_DEBUG_ERROR },
+	{ "command",	G_OBEX_DEBUG_COMMAND },
+	{ "transfer",	G_OBEX_DEBUG_TRANSFER },
+	{ "header",	G_OBEX_DEBUG_HEADER },
+	{ "packet",	G_OBEX_DEBUG_PACKET },
+	{ "data",	G_OBEX_DEBUG_DATA },
+};
+
 GObex *g_obex_new(GIOChannel *io, GObexTransportType transport_type,
 					gssize io_rx_mtu, gssize io_tx_mtu)
 {
 	GObex *obex;
 	GIOCondition cond;
 
+	if (gobex_debug == 0) {
+		const char *env = g_getenv("GOBEX_DEBUG");
+		if (env)
+			gobex_debug = g_parse_debug_string(env, keys, 6);
+		else
+			gobex_debug = G_OBEX_DEBUG_NONE;
+	}
+
 	if (io == NULL)
 		return NULL;
 
-- 
1.7.6.4

