Return-Path: <cyrus@holtmann.org>
From: Sheldon Demario <sheldon.demario@openbossa.org>
To: linux-bluetooth@vger.kernel.org
Cc: Sheldon Demario <sheldon.demario@openbossa.org>
Subject: [PATCH 1/2] Move do_connect() to a common file between interactive.c and gatttool.c
Date: Thu, 17 Feb 2011 10:25:19 -0300
Message-Id: <1297949120-5720-1-git-send-email-sheldon.demario@openbossa.org>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Since do_connect() is used in both interactive.c and gatttool.c
files, it was moved to a new file that should hold all common functions
---
 Makefile.am          |    3 +-
 attrib/gatttool.c    |   76 +++---------------------------------
 attrib/gatttool.h    |    4 +-
 attrib/interactive.c |   14 ++++++-
 attrib/utils.c       |  106 ++++++++++++++++++++++++++++++++++++++++++++++++++
 5 files changed, 129 insertions(+), 74 deletions(-)
 create mode 100644 attrib/utils.c

diff --git a/Makefile.am b/Makefile.am
index 7e5d0ee..2a858cd 100644
--- a/Makefile.am
+++ b/Makefile.am
@@ -182,7 +182,8 @@ bin_PROGRAMS += attrib/gatttool
 attrib_gatttool_SOURCES = attrib/gatttool.c attrib/att.c attrib/gatt.c \
 			  attrib/gattrib.c btio/btio.c \
 			  src/glib-helper.h src/glib-helper.c \
-			  attrib/gatttool.h attrib/interactive.c
+			  attrib/gatttool.h attrib/interactive.c \
+			  attrib/utils.c
 attrib_gatttool_LDADD = lib/libbluetooth.la @GLIB_LIBS@ @READLINE_LIBS@
 endif
 
diff --git a/attrib/gatttool.c b/attrib/gatttool.c
index 38636f9..96dca5b 100644
--- a/attrib/gatttool.c
+++ b/attrib/gatttool.c
@@ -44,14 +44,10 @@
 #include "gatt.h"
 #include "gatttool.h"
 
-/* Minimum MTU for ATT connections */
-#define ATT_MIN_MTU_LE		23
-#define ATT_MIN_MTU_L2CAP	48
-
 static gchar *opt_src = NULL;
 static gchar *opt_dst = NULL;
 static gchar *opt_value = NULL;
-static gchar *opt_sec_level = "low";
+static gchar *opt_sec_level = NULL;
 static uuid_t *opt_uuid = NULL;
 static int opt_start = 0x0001;
 static int opt_end = 0xffff;
@@ -85,70 +81,6 @@ static void connect_cb(GIOChannel *io, GError *err, gpointer user_data)
 	}
 }
 
-GIOChannel *do_connect(gchar *dst, gboolean le, BtIOConnect connect_cb)
-{
-	GIOChannel *chan;
-	bdaddr_t sba, dba;
-	GError *err = NULL;
-	BtIOSecLevel sec_level;
-
-	/* This check is required because currently setsockopt() returns no
-	 * errors for MTU values smaller than the allowed minimum. */
-	if (opt_mtu != 0 && opt_mtu < (le ? ATT_MIN_MTU_LE : ATT_MIN_MTU_L2CAP)) {
-		g_printerr("MTU cannot be smaller than %d\n",
-				(le ? ATT_MIN_MTU_LE : ATT_MIN_MTU_L2CAP));
-		return NULL;
-	}
-
-	/* Remote device */
-	if (dst == NULL) {
-		g_printerr("Remote Bluetooth address required\n");
-		return NULL;
-	}
-	str2ba(dst, &dba);
-
-	/* Local adapter */
-	if (opt_src != NULL) {
-		if (!strncmp(opt_src, "hci", 3))
-			hci_devba(atoi(opt_src + 3), &sba);
-		else
-			str2ba(opt_src, &sba);
-	} else
-		bacpy(&sba, BDADDR_ANY);
-
-	if (strcmp(opt_sec_level, "medium") == 0)
-		sec_level = BT_IO_SEC_MEDIUM;
-	else if (strcmp(opt_sec_level, "high") == 0)
-		sec_level = BT_IO_SEC_HIGH;
-	else
-		sec_level = BT_IO_SEC_LOW;
-
-	if (le)
-		chan = bt_io_connect(BT_IO_L2CAP, connect_cb, NULL, NULL, &err,
-				BT_IO_OPT_SOURCE_BDADDR, &sba,
-				BT_IO_OPT_DEST_BDADDR, &dba,
-				BT_IO_OPT_CID, GATT_CID,
-				BT_IO_OPT_OMTU, opt_mtu,
-				BT_IO_OPT_SEC_LEVEL, sec_level,
-				BT_IO_OPT_INVALID);
-	else
-		chan = bt_io_connect(BT_IO_L2CAP, connect_cb, NULL, NULL, &err,
-				BT_IO_OPT_SOURCE_BDADDR, &sba,
-				BT_IO_OPT_DEST_BDADDR, &dba,
-				BT_IO_OPT_PSM, opt_psm,
-				BT_IO_OPT_OMTU, opt_mtu,
-				BT_IO_OPT_SEC_LEVEL, sec_level,
-				BT_IO_OPT_INVALID);
-
-	if (err) {
-		g_printerr("%s\n", err->message);
-		g_error_free(err);
-		return NULL;
-	}
-
-	return chan;
-}
-
 static void primary_all_cb(GSList *services, guint8 status, gpointer user_data)
 {
 	GSList *l;
@@ -625,6 +557,8 @@ int main(int argc, char *argv[])
 	GIOChannel *chan;
 	GSourceFunc callback;
 
+	opt_sec_level = strdup("low");
+
 	context = g_option_context_new(NULL);
 	g_option_context_add_main_entries(context, options, NULL);
 
@@ -681,7 +615,8 @@ int main(int argc, char *argv[])
 		goto done;
 	}
 
-	chan = do_connect(opt_dst, opt_le, connect_cb);
+	chan = gatt_connect(opt_src, opt_dst, opt_sec_level,
+					opt_psm, opt_mtu, opt_le, connect_cb);
 	if (chan == NULL) {
 		got_error = TRUE;
 		goto done;
@@ -710,6 +645,7 @@ done:
 	g_free(opt_src);
 	g_free(opt_dst);
 	g_free(opt_uuid);
+	g_free(opt_sec_level);
 
 	if (got_error)
 		exit(EXIT_FAILURE);
diff --git a/attrib/gatttool.h b/attrib/gatttool.h
index 2237330..1fc6a59 100644
--- a/attrib/gatttool.h
+++ b/attrib/gatttool.h
@@ -22,4 +22,6 @@
  */
 
 int interactive(gchar *dst, gboolean le);
-GIOChannel *do_connect(gchar *dst, gboolean le, BtIOConnect connect_cb);
+GIOChannel *gatt_connect(const gchar *src, const gchar *dst,
+			const gchar *sec_level, int psm, int mtu, gboolean le,
+			BtIOConnect connect_cb);
diff --git a/attrib/interactive.c b/attrib/interactive.c
index 02f31b7..71e84bc 100644
--- a/attrib/interactive.c
+++ b/attrib/interactive.c
@@ -42,7 +42,11 @@ static GAttrib *attrib = NULL;
 static GMainLoop *event_loop;
 static GString *prompt;
 
+static gchar *opt_src = NULL;
 static gchar *opt_dst = NULL;
+static gchar *opt_sec_level = NULL;
+static int opt_psm = 0x1f;
+static int opt_mtu = 0;
 static gboolean opt_le = FALSE;
 
 static void cmd_help(int argcp, char **argvp);
@@ -141,7 +145,8 @@ static void cmd_connect(int argcp, char **argvp)
 	}
 
 	set_state(STATE_CONNECTING);
-	iochannel = do_connect(opt_dst, opt_le, connect_cb);
+	iochannel = gatt_connect(opt_src, opt_dst, opt_sec_level, opt_psm,
+						opt_mtu, opt_le, connect_cb);
 	if (iochannel == NULL)
 		set_state(STATE_DISCONNECTED);
 
@@ -247,7 +252,9 @@ int interactive(gchar *dst, gboolean le)
 	GIOChannel *pchan;
 	gint events;
 
-	opt_dst = dst;
+	opt_sec_level = strdup("low");
+
+	opt_dst = strdup(dst);
 	opt_le = le;
 
 	prompt = g_string_new(NULL);
@@ -269,5 +276,8 @@ int interactive(gchar *dst, gboolean le)
 	g_main_loop_unref(event_loop);
 	g_string_free(prompt, TRUE);
 
+	g_free(opt_dst);
+	g_free(opt_sec_level);
+
 	return 0;
 }
diff --git a/attrib/utils.c b/attrib/utils.c
new file mode 100644
index 0000000..326c1e8
--- /dev/null
+++ b/attrib/utils.c
@@ -0,0 +1,106 @@
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
+#include <stdlib.h>
+#include <glib.h>
+
+#include <bluetooth/bluetooth.h>
+#include <bluetooth/hci.h>
+#include <bluetooth/hci_lib.h>
+#include <bluetooth/sdp.h>
+
+#include "gattrib.h"
+#include "gatt.h"
+#include "btio.h"
+#include "gatttool.h"
+
+/* Minimum MTU for ATT connections */
+#define ATT_MIN_MTU_LE		23
+#define ATT_MIN_MTU_L2CAP	48
+
+GIOChannel *gatt_connect(const gchar *src, const gchar *dst,
+			const gchar *sec_level, int psm, int mtu, gboolean le,
+			BtIOConnect connect_cb)
+{
+	GIOChannel *chan;
+	bdaddr_t sba, dba;
+	GError *err = NULL;
+	BtIOSecLevel sec;
+
+	/* This check is required because currently setsockopt() returns no
+	 * errors for MTU values smaller than the allowed minimum. */
+	if (mtu != 0 && mtu < (le ? ATT_MIN_MTU_LE : ATT_MIN_MTU_L2CAP)) {
+		g_printerr("MTU cannot be smaller than %d\n",
+				(le ? ATT_MIN_MTU_LE : ATT_MIN_MTU_L2CAP));
+		return NULL;
+	}
+
+	/* Remote device */
+	if (dst == NULL) {
+		g_printerr("Remote Bluetooth address required\n");
+		return NULL;
+	}
+	str2ba(dst, &dba);
+
+	/* Local adapter */
+	if (src != NULL) {
+		if (!strncmp(src, "hci", 3))
+			hci_devba(atoi(src + 3), &sba);
+		else
+			str2ba(src, &sba);
+	} else
+		bacpy(&sba, BDADDR_ANY);
+
+	if (strcmp(sec_level, "medium") == 0)
+		sec = BT_IO_SEC_MEDIUM;
+	else if (strcmp(sec_level, "high") == 0)
+		sec = BT_IO_SEC_HIGH;
+	else
+		sec = BT_IO_SEC_LOW;
+
+	if (le)
+		chan = bt_io_connect(BT_IO_L2CAP, connect_cb, NULL, NULL, &err,
+				BT_IO_OPT_SOURCE_BDADDR, &sba,
+				BT_IO_OPT_DEST_BDADDR, &dba,
+				BT_IO_OPT_CID, GATT_CID,
+				BT_IO_OPT_OMTU, mtu,
+				BT_IO_OPT_SEC_LEVEL, sec,
+				BT_IO_OPT_INVALID);
+	else
+		chan = bt_io_connect(BT_IO_L2CAP, connect_cb, NULL, NULL, &err,
+				BT_IO_OPT_SOURCE_BDADDR, &sba,
+				BT_IO_OPT_DEST_BDADDR, &dba,
+				BT_IO_OPT_PSM, psm,
+				BT_IO_OPT_OMTU, mtu,
+				BT_IO_OPT_SEC_LEVEL, sec,
+				BT_IO_OPT_INVALID);
+
+	if (err) {
+		g_printerr("%s\n", err->message);
+		g_error_free(err);
+		return NULL;
+	}
+
+	return chan;
+}
+
-- 
1.7.1

