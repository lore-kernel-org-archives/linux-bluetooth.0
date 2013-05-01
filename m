Return-Path: <cyrus@holtmann.org>
From: Lucas De Marchi <lucas.demarchi@profusion.mobi>
To: linux-bluetooth@vger.kernel.org
Cc: Lucas De Marchi <lucas.de.marchi@gmail.com>
Subject: [PATCH BlueZ 1/6] attrib: Get rid of gchar
Date: Wed,  1 May 2013 01:51:56 -0300
Message-Id: <1367383921-19129-1-git-send-email-lucas.demarchi@profusion.mobi>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

From: Lucas De Marchi <lucas.de.marchi@gmail.com>

Use plain char instead of gchar.
---
 attrib/gattrib.c     |  4 ++--
 attrib/gatttool.c    | 12 ++++++------
 attrib/gatttool.h    |  6 +++---
 attrib/interactive.c | 14 +++++++-------
 attrib/utils.c       |  4 ++--
 5 files changed, 20 insertions(+), 20 deletions(-)

diff --git a/attrib/gattrib.c b/attrib/gattrib.c
index 636e09d..7fb460f 100644
--- a/attrib/gattrib.c
+++ b/attrib/gattrib.c
@@ -319,7 +319,7 @@ static gboolean can_write_data(GIOChannel *io, GIOCondition cond,
 	if (cmd->sent)
 		return FALSE;
 
-	iostat = g_io_channel_write_chars(io, (gchar *) cmd->pdu, cmd->len,
+	iostat = g_io_channel_write_chars(io, (char *) cmd->pdu, cmd->len,
 								&len, &gerr);
 	if (iostat != G_IO_STATUS_NORMAL) {
 		if (gerr) {
@@ -408,7 +408,7 @@ static gboolean received_data(GIOChannel *io, GIOCondition cond, gpointer data)
 
 	memset(buf, 0, sizeof(buf));
 
-	iostat = g_io_channel_read_chars(io, (gchar *) buf, sizeof(buf),
+	iostat = g_io_channel_read_chars(io, (char *) buf, sizeof(buf),
 								&len, NULL);
 	if (iostat != G_IO_STATUS_NORMAL) {
 		status = ATT_ECODE_IO;
diff --git a/attrib/gatttool.c b/attrib/gatttool.c
index dd0f1e2..2c11562 100644
--- a/attrib/gatttool.c
+++ b/attrib/gatttool.c
@@ -42,11 +42,11 @@
 #include "gatt.h"
 #include "gatttool.h"
 
-static gchar *opt_src = NULL;
-static gchar *opt_dst = NULL;
-static gchar *opt_dst_type = NULL;
-static gchar *opt_value = NULL;
-static gchar *opt_sec_level = NULL;
+static char *opt_src = NULL;
+static char *opt_dst = NULL;
+static char *opt_dst_type = NULL;
+static char *opt_value = NULL;
+static char *opt_sec_level = NULL;
 static bt_uuid_t *opt_uuid = NULL;
 static int opt_start = 0x0001;
 static int opt_end = 0xffff;
@@ -596,7 +596,7 @@ int main(int argc, char *argv[])
 	else if (opt_char_desc)
 		operation = characteristics_desc;
 	else {
-		gchar *help = g_option_context_get_help(context, TRUE, NULL);
+		char *help = g_option_context_get_help(context, TRUE, NULL);
 		g_print("%s\n", help);
 		g_free(help);
 		got_error = TRUE;
diff --git a/attrib/gatttool.h b/attrib/gatttool.h
index 184a7f8..8f0913c 100644
--- a/attrib/gatttool.h
+++ b/attrib/gatttool.h
@@ -21,10 +21,10 @@
  *
  */
 
-int interactive(const gchar *src, const gchar *dst, const gchar *dst_type,
+int interactive(const char *src, const char *dst, const char *dst_type,
 								int psm);
-GIOChannel *gatt_connect(const gchar *src, const gchar *dst,
-			const gchar *dst_type, const gchar *sec_level,
+GIOChannel *gatt_connect(const char *src, const char *dst,
+			const char *dst_type, const char *sec_level,
 			int psm, int mtu, BtIOConnect connect_cb,
 			GError **gerr);
 size_t gatt_attr_data_from_string(const char *str, uint8_t **data);
diff --git a/attrib/interactive.c b/attrib/interactive.c
index a819acf..f28dc22 100644
--- a/attrib/interactive.c
+++ b/attrib/interactive.c
@@ -51,10 +51,10 @@ static GAttrib *attrib = NULL;
 static GMainLoop *event_loop;
 static GString *prompt;
 
-static gchar *opt_src = NULL;
-static gchar *opt_dst = NULL;
-static gchar *opt_dst_type = NULL;
-static gchar *opt_sec_level = NULL;
+static char *opt_src = NULL;
+static char *opt_dst = NULL;
+static char *opt_dst_type = NULL;
+static char *opt_sec_level = NULL;
 static int opt_psm = 0;
 static int opt_mtu = 0;
 static int start;
@@ -850,7 +850,7 @@ static void cmd_help(int argcp, char **argvp)
 
 static void parse_line(char *line_read)
 {
-	gchar **argvp;
+	char **argvp;
 	int argcp;
 	int i;
 
@@ -1017,8 +1017,8 @@ static guint setup_signalfd(void)
 	return source;
 }
 
-int interactive(const gchar *src, const gchar *dst,
-		const gchar *dst_type, int psm)
+int interactive(const char *src, const char *dst,
+		const char *dst_type, int psm)
 {
 	guint input;
 	guint signal;
diff --git a/attrib/utils.c b/attrib/utils.c
index e263bcb..6ef89d4 100644
--- a/attrib/utils.c
+++ b/attrib/utils.c
@@ -40,8 +40,8 @@
 #include "gatt.h"
 #include "gatttool.h"
 
-GIOChannel *gatt_connect(const gchar *src, const gchar *dst,
-				const gchar *dst_type, const gchar *sec_level,
+GIOChannel *gatt_connect(const char *src, const char *dst,
+				const char *dst_type, const char *sec_level,
 				int psm, int mtu, BtIOConnect connect_cb,
 				GError **gerr)
 {
-- 
1.8.2.2

