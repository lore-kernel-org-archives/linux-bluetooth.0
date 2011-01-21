Return-Path: <cyrus@holtmann.org>
From: Sheldon Demario <sheldon.demario@openbossa.org>
To: linux-bluetooth@vger.kernel.org
Cc: Sheldon Demario <sheldon.demario@openbossa.org>
Subject: [PATCH 1/7] Create a file to hold the generic code from gatttool
Date: Fri, 21 Jan 2011 10:46:20 -0300
Message-Id: <1295617586-3398-1-git-send-email-sheldon.demario@openbossa.org>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

We need a interactive tool that should be similar to gatttool in
features. So we can share some code between them.
---
 Makefile.am       |    3 +-
 attrib/gatttool.c |   85 +----------------------------------
 attrib/gtcommon.c |  130 +++++++++++++++++++++++++++++++++++++++++++++++++++++
 attrib/gtcommon.h |   45 ++++++++++++++++++
 4 files changed, 178 insertions(+), 85 deletions(-)
 create mode 100644 attrib/gtcommon.c
 create mode 100644 attrib/gtcommon.h

diff --git a/Makefile.am b/Makefile.am
index 5f96975..5274435 100644
--- a/Makefile.am
+++ b/Makefile.am
@@ -179,7 +179,8 @@ bin_PROGRAMS += attrib/gatttool
 
 attrib_gatttool_SOURCES = attrib/gatttool.c attrib/att.c attrib/gatt.c \
 			  attrib/gattrib.c btio/btio.c \
-			  src/glib-helper.h src/glib-helper.c
+			  src/glib-helper.h src/glib-helper.c \
+			  attrib/gtcommon.h attrib/gtcommon.c
 attrib_gatttool_LDADD = lib/libbluetooth.la @GLIB_LIBS@
 
 builtin_modules += attrib
diff --git a/attrib/gatttool.c b/attrib/gatttool.c
index 8e8ed8e..e5ebad1 100644
--- a/attrib/gatttool.c
+++ b/attrib/gatttool.c
@@ -42,27 +42,11 @@
 #include "gattrib.h"
 #include "glib-helper.h"
 #include "gatt.h"
+#include "gtcommon.h"
 
 /* Minimum MTU for L2CAP connections over BR/EDR */
 #define ATT_MIN_MTU_L2CAP 48
 
-static gchar *opt_src = NULL;
-static gchar *opt_dst = NULL;
-static gchar *opt_value = NULL;
-static gchar *opt_sec_level = "low";
-static uuid_t *opt_uuid = NULL;
-static int opt_start = 0x0001;
-static int opt_end = 0xffff;
-static int opt_handle = -1;
-static int opt_mtu = 0;
-static int opt_psm = 0x1f;
-static gboolean opt_primary = FALSE;
-static gboolean opt_characteristics = FALSE;
-static gboolean opt_char_read = FALSE;
-static gboolean opt_listen = FALSE;
-static gboolean opt_char_desc = FALSE;
-static gboolean opt_le = FALSE;
-static gboolean opt_char_write = FALSE;
 static GMainLoop *event_loop;
 static gboolean got_error = FALSE;
 
@@ -487,73 +471,6 @@ static gboolean characteristics_desc(gpointer user_data)
 	return FALSE;
 }
 
-static gboolean parse_uuid(const char *key, const char *value,
-				gpointer user_data, GError **error)
-{
-	if (!value)
-		return FALSE;
-
-	opt_uuid = g_try_malloc(sizeof(uuid_t));
-	if (opt_uuid == NULL)
-		return FALSE;
-
-	if (bt_string2uuid(opt_uuid, value) < 0)
-		return FALSE;
-
-	return TRUE;
-}
-
-static GOptionEntry primary_char_options[] = {
-	{ "start", 's' , 0, G_OPTION_ARG_INT, &opt_start,
-		"Starting handle(optional)", "0x0001" },
-	{ "end", 'e' , 0, G_OPTION_ARG_INT, &opt_end,
-		"Ending handle(optional)", "0xffff" },
-	{ "uuid", 'u', G_OPTION_FLAG_OPTIONAL_ARG, G_OPTION_ARG_CALLBACK,
-		parse_uuid, "UUID16 or UUID128(optional)", "0x1801"},
-	{ NULL },
-};
-
-static GOptionEntry char_rw_options[] = {
-	{ "handle", 'a' , 0, G_OPTION_ARG_INT, &opt_handle,
-		"Read/Write characteristic by handle(required)", "0x0001" },
-	{ "value", 'n' , 0, G_OPTION_ARG_STRING, &opt_value,
-		"Write characteristic value (required for write operation)",
-		"0x0001" },
-	{NULL},
-};
-
-static GOptionEntry gatt_options[] = {
-	{ "primary", 0, 0, G_OPTION_ARG_NONE, &opt_primary,
-		"Primary Service Discovery", NULL },
-	{ "characteristics", 0, 0, G_OPTION_ARG_NONE, &opt_characteristics,
-		"Characteristics Discovery", NULL },
-	{ "char-read", 0, 0, G_OPTION_ARG_NONE, &opt_char_read,
-		"Characteristics Value/Descriptor Read", NULL },
-	{ "char-write", 0, 0, G_OPTION_ARG_NONE, &opt_char_write,
-		"Characteristics Value Write", NULL },
-	{ "char-desc", 0, 0, G_OPTION_ARG_NONE, &opt_char_desc,
-		"Characteristics Descriptor Discovery", NULL },
-	{ "listen", 0, 0, G_OPTION_ARG_NONE, &opt_listen,
-		"Listen for notifications and indications", NULL },
-	{ "le", 0, 0, G_OPTION_ARG_NONE, &opt_le,
-		"Use Bluetooth Low Energy transport", NULL },
-	{ NULL },
-};
-
-static GOptionEntry options[] = {
-	{ "adapter", 'i', 0, G_OPTION_ARG_STRING, &opt_src,
-		"Specify local adapter interface", "hciX" },
-	{ "device", 'b', 0, G_OPTION_ARG_STRING, &opt_dst,
-		"Specify remote Bluetooth address", "MAC" },
-	{ "mtu", 'm', 0, G_OPTION_ARG_INT, &opt_mtu,
-		"Specify the MTU size", "MTU" },
-	{ "psm", 'p', 0, G_OPTION_ARG_INT, &opt_psm,
-		"Specify the PSM for GATT/ATT over BR/EDR", "PSM" },
-	{ "sec-level", 'l', 0, G_OPTION_ARG_STRING, &opt_sec_level,
-		"Set security level. Default: low", "[low | medium | high]"},
-	{ NULL },
-};
-
 int main(int argc, char *argv[])
 {
 	GOptionContext *context;
diff --git a/attrib/gtcommon.c b/attrib/gtcommon.c
new file mode 100644
index 0000000..ebf47e9
--- /dev/null
+++ b/attrib/gtcommon.c
@@ -0,0 +1,130 @@
+/*
+ *
+ *  BlueZ - Bluetooth protocol stack for Linux
+ *
+ *  Copyright (C) 2011  Nokia Corporation
+ *
+ *
+ *  This program is free software; you can redistribute it and/or modify
+ *  it under the terms of the GNU General Public License as published by
+ *  the Free Software Foundation; either version 2 of the License, or
+ *  (at your option) any later version.
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
+#include <errno.h>
+#include <glib.h>
+#include <stdlib.h>
+#include <stdint.h>
+#include <unistd.h>
+
+#include <bluetooth/bluetooth.h>
+#include <bluetooth/hci.h>
+#include <bluetooth/hci_lib.h>
+#include <bluetooth/sdp.h>
+#include <bluetooth/sdp_lib.h>
+
+#include "att.h"
+#include "btio.h"
+#include "gattrib.h"
+#include "glib-helper.h"
+#include "gatt.h"
+
+#include "gtcommon.h"
+
+gchar *opt_src = NULL;
+gchar *opt_dst = NULL;
+gchar *opt_value = NULL;
+gchar *opt_sec_level = "low";
+uuid_t *opt_uuid;
+int opt_start = 0x0001;
+int opt_end = 0xffff;
+int opt_handle = -1;
+int opt_mtu = 0;
+int opt_psm = 0x1f;
+gboolean opt_primary = FALSE;
+gboolean opt_characteristics = FALSE;
+gboolean opt_char_read = FALSE;
+gboolean opt_listen = FALSE;
+gboolean opt_char_desc = FALSE;
+gboolean opt_le = FALSE;
+gboolean opt_char_write = FALSE;
+
+static gboolean parse_uuid(const char *key, const char *value,
+				gpointer user_data, GError **gerr)
+{
+	if (!value)
+		return FALSE;
+
+	opt_uuid = g_try_malloc(sizeof(uuid_t));
+	if (opt_uuid == NULL)
+		return FALSE;
+
+	if (bt_string2uuid(opt_uuid, value) < 0) {
+		g_free(opt_uuid);
+		return FALSE;
+	}
+
+	return TRUE;
+}
+
+GOptionEntry primary_char_options[] = {
+	{ "start", 's' , 0, G_OPTION_ARG_INT, &opt_start,
+		"Starting handle(optional)", "0x0001" },
+	{ "end", 'e' , 0, G_OPTION_ARG_INT, &opt_end,
+		"Ending handle(optional)", "0xffff" },
+	{ "uuid", 'u', G_OPTION_FLAG_OPTIONAL_ARG, G_OPTION_ARG_CALLBACK,
+		parse_uuid, "UUID16 or UUID128(optional)", "0x1801"},
+	{ NULL },
+};
+
+GOptionEntry char_rw_options[] = {
+	{ "handle", 'a' , 0, G_OPTION_ARG_INT, &opt_handle,
+		"Read/Write characteristic by handle(required)", "0x0001" },
+	{ "value", 'n' , 0, G_OPTION_ARG_STRING, &opt_value,
+		"Write characteristic value (required for write operation)",
+		"0x0001" },
+	{NULL},
+};
+
+GOptionEntry gatt_options[] = {
+	{ "primary", 0, 0, G_OPTION_ARG_NONE, &opt_primary,
+		"Primary Service Discovery", NULL },
+	{ "characteristics", 0, 0, G_OPTION_ARG_NONE, &opt_characteristics,
+		"Characteristics Discovery", NULL },
+	{ "char-read", 0, 0, G_OPTION_ARG_NONE, &opt_char_read,
+		"Characteristics Value/Descriptor Read", NULL },
+	{ "char-write", 0, 0, G_OPTION_ARG_NONE, &opt_char_write,
+		"Characteristics Value Write", NULL },
+	{ "char-desc", 0, 0, G_OPTION_ARG_NONE, &opt_char_desc,
+		"Characteristics Descriptor Discovery", NULL },
+	{ "listen", 0, 0, G_OPTION_ARG_NONE, &opt_listen,
+		"Listen for notifications and indications", NULL },
+	{ "le", 0, 0, G_OPTION_ARG_NONE, &opt_le,
+		"Use Bluetooth Low Energy transport", NULL },
+	{ NULL },
+};
+
+GOptionEntry options[] = {
+	{ "adapter", 'i', 0, G_OPTION_ARG_STRING, &opt_src,
+		"Specify local adapter interface", "hciX" },
+	{ "device", 'b', 0, G_OPTION_ARG_STRING, &opt_dst,
+		"Specify remote Bluetooth address", "MAC" },
+	{ "mtu", 'm', 0, G_OPTION_ARG_INT, &opt_mtu,
+		"Specify the MTU size", "MTU" },
+	{ "psm", 'p', 0, G_OPTION_ARG_INT, &opt_psm,
+		"Specify the PSM for GATT/ATT over BR/EDR", "PSM" },
+	{ "sec-level", 'l', 0, G_OPTION_ARG_STRING, &opt_sec_level,
+		"Set security level. Default: low", "[low | medium | high]"},
+	{ NULL },
+};
+
diff --git a/attrib/gtcommon.h b/attrib/gtcommon.h
new file mode 100644
index 0000000..30e8e37
--- /dev/null
+++ b/attrib/gtcommon.h
@@ -0,0 +1,45 @@
+/*
+ *
+ *  BlueZ - Bluetooth protocol stack for Linux
+ *
+ *  Copyright (C) 2011  Nokia Corporation
+ *
+ *
+ *  This program is free software; you can redistribute it and/or modify
+ *  it under the terms of the GNU General Public License as published by
+ *  the Free Software Foundation; either version 2 of the License, or
+ *  (at your option) any later version.
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
+extern gchar *opt_src;
+extern gchar *opt_dst;
+extern gchar *opt_value;
+extern gchar *opt_sec_level;
+extern uuid_t *opt_uuid;
+extern int opt_start;
+extern int opt_end;
+extern int opt_handle;
+extern int opt_mtu;
+extern int opt_psm;
+extern gboolean opt_primary;
+extern gboolean opt_characteristics;
+extern gboolean opt_char_read;
+extern gboolean opt_listen;
+extern gboolean opt_char_desc;
+extern gboolean opt_le;
+extern gboolean opt_char_write;
+
+extern GOptionEntry primary_char_options[];
+extern GOptionEntry char_rw_options[];
+extern GOptionEntry gatt_options[];
+extern GOptionEntry options[];
-- 
1.7.1

