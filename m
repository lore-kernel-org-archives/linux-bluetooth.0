Return-Path: <cyrus@holtmann.org>
From: Sheldon Demario <sheldon.demario@openbossa.org>
To: linux-bluetooth@vger.kernel.org
Cc: Sheldon Demario <sheldon.demario@openbossa.org>
Subject: [PATCH v2 2/2] Use PSM value to select LE or BR/EDR transport on gatttool
Date: Thu, 17 Feb 2011 11:18:41 -0300
Message-Id: <1297952321-12523-3-git-send-email-sheldon.demario@openbossa.org>
In-Reply-To: <1297952321-12523-1-git-send-email-sheldon.demario@openbossa.org>
References: <1297952321-12523-1-git-send-email-sheldon.demario@openbossa.org>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Removes "le" parameter of gatt_connect() as well the global variables
used to store the le option. LE is now the default transport, if a PSM
value different than zero is given BR/EDR will be selected
---
 attrib/gatttool.c    |    9 +++------
 attrib/gatttool.h    |    2 +-
 attrib/interactive.c |   15 +++++++--------
 attrib/utils.c       |   13 +++++++------
 4 files changed, 18 insertions(+), 21 deletions(-)

diff --git a/attrib/gatttool.c b/attrib/gatttool.c
index 96dca5b..7478043 100644
--- a/attrib/gatttool.c
+++ b/attrib/gatttool.c
@@ -53,13 +53,12 @@ static int opt_start = 0x0001;
 static int opt_end = 0xffff;
 static int opt_handle = -1;
 static int opt_mtu = 0;
-static int opt_psm = 0x1f;
+static int opt_psm = 0;
 static gboolean opt_primary = FALSE;
 static gboolean opt_characteristics = FALSE;
 static gboolean opt_char_read = FALSE;
 static gboolean opt_listen = FALSE;
 static gboolean opt_char_desc = FALSE;
-static gboolean opt_le = FALSE;
 static gboolean opt_char_write = FALSE;
 static gboolean opt_char_write_req = FALSE;
 static gboolean opt_interactive = FALSE;
@@ -527,8 +526,6 @@ static GOptionEntry gatt_options[] = {
 		"Characteristics Descriptor Discovery", NULL },
 	{ "listen", 0, 0, G_OPTION_ARG_NONE, &opt_listen,
 		"Listen for notifications and indications", NULL },
-	{ "le", 0, 0, G_OPTION_ARG_NONE, &opt_le,
-		"Use Bluetooth Low Energy transport", NULL },
 	{ "interactive", 'I', G_OPTION_FLAG_IN_MAIN, G_OPTION_ARG_NONE,
 		&opt_interactive, "Use interactive mode", NULL },
 	{ NULL },
@@ -591,7 +588,7 @@ int main(int argc, char *argv[])
 	}
 
 	if (opt_interactive) {
-		interactive(opt_dst, opt_le);
+		interactive(opt_dst, opt_psm);
 		goto done;
 	}
 
@@ -616,7 +613,7 @@ int main(int argc, char *argv[])
 	}
 
 	chan = gatt_connect(opt_src, opt_dst, opt_sec_level,
-					opt_psm, opt_mtu, opt_le, connect_cb);
+					opt_psm, opt_mtu, connect_cb);
 	if (chan == NULL) {
 		got_error = TRUE;
 		goto done;
diff --git a/attrib/gatttool.h b/attrib/gatttool.h
index 1fc6a59..7eae18d 100644
--- a/attrib/gatttool.h
+++ b/attrib/gatttool.h
@@ -23,5 +23,5 @@
 
 int interactive(gchar *dst, gboolean le);
 GIOChannel *gatt_connect(const gchar *src, const gchar *dst,
-			const gchar *sec_level, int psm, int mtu, gboolean le,
+			const gchar *sec_level, int psm, int mtu,
 			BtIOConnect connect_cb);
diff --git a/attrib/interactive.c b/attrib/interactive.c
index 71e84bc..b851a40 100644
--- a/attrib/interactive.c
+++ b/attrib/interactive.c
@@ -45,9 +45,8 @@ static GString *prompt;
 static gchar *opt_src = NULL;
 static gchar *opt_dst = NULL;
 static gchar *opt_sec_level = NULL;
-static int opt_psm = 0x1f;
+static int opt_psm = 0;
 static int opt_mtu = 0;
-static gboolean opt_le = FALSE;
 
 static void cmd_help(int argcp, char **argvp);
 
@@ -74,10 +73,10 @@ static char *get_prompt(void)
 	else
 		g_string_append_printf(prompt, "[%17s]", "");
 
-	if (opt_le)
-		g_string_append(prompt, "[LE]");
-	else
+	if (opt_psm)
 		g_string_append(prompt, "[BR]");
+	else
+		g_string_append(prompt, "[LE]");
 
 	g_string_append(prompt, "> ");
 
@@ -146,7 +145,7 @@ static void cmd_connect(int argcp, char **argvp)
 
 	set_state(STATE_CONNECTING);
 	iochannel = gatt_connect(opt_src, opt_dst, opt_sec_level, opt_psm,
-						opt_mtu, opt_le, connect_cb);
+						opt_mtu, connect_cb);
 	if (iochannel == NULL)
 		set_state(STATE_DISCONNECTED);
 
@@ -247,7 +246,7 @@ static gboolean prompt_read(GIOChannel *chan, GIOCondition cond,
 	return TRUE;
 }
 
-int interactive(gchar *dst, gboolean le)
+int interactive(gchar *dst, int psm)
 {
 	GIOChannel *pchan;
 	gint events;
@@ -255,7 +254,7 @@ int interactive(gchar *dst, gboolean le)
 	opt_sec_level = strdup("low");
 
 	opt_dst = strdup(dst);
-	opt_le = le;
+	opt_psm = psm;
 
 	prompt = g_string_new(NULL);
 
diff --git a/attrib/utils.c b/attrib/utils.c
index 326c1e8..d648376 100644
--- a/attrib/utils.c
+++ b/attrib/utils.c
@@ -39,19 +39,20 @@
 #define ATT_MIN_MTU_L2CAP	48
 
 GIOChannel *gatt_connect(const gchar *src, const gchar *dst,
-			const gchar *sec_level, int psm, int mtu, gboolean le,
-			BtIOConnect connect_cb)
+				const gchar *sec_level, int psm, int mtu,
+				BtIOConnect connect_cb)
 {
 	GIOChannel *chan;
 	bdaddr_t sba, dba;
 	GError *err = NULL;
 	BtIOSecLevel sec;
+	int minimum_mtu;
 
 	/* This check is required because currently setsockopt() returns no
 	 * errors for MTU values smaller than the allowed minimum. */
-	if (mtu != 0 && mtu < (le ? ATT_MIN_MTU_LE : ATT_MIN_MTU_L2CAP)) {
-		g_printerr("MTU cannot be smaller than %d\n",
-				(le ? ATT_MIN_MTU_LE : ATT_MIN_MTU_L2CAP));
+	minimum_mtu = (psm ? ATT_MIN_MTU_L2CAP : ATT_MIN_MTU_LE);
+	if (mtu != 0 && mtu < minimum_mtu) {
+		g_printerr("MTU cannot be smaller than %d\n", minimum_mtu);
 		return NULL;
 	}
 
@@ -78,7 +79,7 @@ GIOChannel *gatt_connect(const gchar *src, const gchar *dst,
 	else
 		sec = BT_IO_SEC_LOW;
 
-	if (le)
+	if (psm == 0)
 		chan = bt_io_connect(BT_IO_L2CAP, connect_cb, NULL, NULL, &err,
 				BT_IO_OPT_SOURCE_BDADDR, &sba,
 				BT_IO_OPT_DEST_BDADDR, &dba,
-- 
1.7.1

