Return-Path: <cyrus@holtmann.org>
From: Sheldon Demario <sheldon.demario@openbossa.org>
To: linux-bluetooth@vger.kernel.org
Cc: Sheldon Demario <sheldon.demario@openbossa.org>
Subject: [PATCH] Pass config parameters to do_connect() on gatttool
Date: Tue, 15 Feb 2011 18:14:56 -0300
Message-Id: <1297804496-8683-1-git-send-email-sheldon.demario@openbossa.org>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

It is desirable that do_connect() doesn't depend on global variables
in order to make it more independent and reusable. Unifying all these
connection parameters on a single struct makes the code simpler.
---
 attrib/gatttool.c    |   61 +++++++++++++++++++++++++------------------------
 attrib/gatttool.h    |   11 ++++++++-
 attrib/interactive.c |   28 ++++++++++++++---------
 3 files changed, 58 insertions(+), 42 deletions(-)

diff --git a/attrib/gatttool.c b/attrib/gatttool.c
index 1e2a8db..d72a49e 100644
--- a/attrib/gatttool.c
+++ b/attrib/gatttool.c
@@ -47,28 +47,24 @@
 /* Minimum MTU for L2CAP connections over BR/EDR */
 #define ATT_MIN_MTU_L2CAP 48
 
-static gchar *opt_src = NULL;
-static gchar *opt_dst = NULL;
 static gchar *opt_value = NULL;
-static gchar *opt_sec_level = "low";
 static uuid_t *opt_uuid = NULL;
 static int opt_start = 0x0001;
 static int opt_end = 0xffff;
 static int opt_handle = -1;
-static int opt_mtu = 0;
-static int opt_psm = 0x1f;
 static gboolean opt_primary = FALSE;
 static gboolean opt_characteristics = FALSE;
 static gboolean opt_char_read = FALSE;
 static gboolean opt_listen = FALSE;
 static gboolean opt_char_desc = FALSE;
-static gboolean opt_le = FALSE;
 static gboolean opt_char_write = FALSE;
 static gboolean opt_char_write_req = FALSE;
 static gboolean opt_interactive = FALSE;
 static GMainLoop *event_loop;
 static gboolean got_error = FALSE;
 
+struct connect_params config;
+
 struct characteristic_data {
 	GAttrib *attrib;
 	uint16_t start;
@@ -84,7 +80,7 @@ static void connect_cb(GIOChannel *io, GError *err, gpointer user_data)
 	}
 }
 
-GIOChannel *do_connect(gchar *dst, gboolean le, BtIOConnect connect_cb)
+GIOChannel *do_connect(struct connect_params *config, BtIOConnect connect_cb)
 {
 	GIOChannel *chan;
 	bdaddr_t sba, dba;
@@ -93,49 +89,49 @@ GIOChannel *do_connect(gchar *dst, gboolean le, BtIOConnect connect_cb)
 
 	/* This check is required because currently setsockopt() returns no
 	 * errors for MTU values smaller than the allowed minimum. */
-	if (opt_mtu != 0 && opt_mtu < ATT_MIN_MTU_L2CAP) {
+	if (config->mtu != 0 && config->mtu < ATT_MIN_MTU_L2CAP) {
 		g_printerr("MTU cannot be smaller than %d\n",
 							ATT_MIN_MTU_L2CAP);
 		return NULL;
 	}
 
 	/* Remote device */
-	if (dst == NULL) {
+	if (config->dst == NULL) {
 		g_printerr("Remote Bluetooth address required\n");
 		return NULL;
 	}
-	str2ba(dst, &dba);
+	str2ba(config->dst, &dba);
 
 	/* Local adapter */
-	if (opt_src != NULL) {
-		if (!strncmp(opt_src, "hci", 3))
-			hci_devba(atoi(opt_src + 3), &sba);
+	if (config->src != NULL) {
+		if (!strncmp(config->src, "hci", 3))
+			hci_devba(atoi(config->src + 3), &sba);
 		else
-			str2ba(opt_src, &sba);
+			str2ba(config->src, &sba);
 	} else
 		bacpy(&sba, BDADDR_ANY);
 
-	if (strcmp(opt_sec_level, "medium") == 0)
+	if (strcmp(config->sec_level, "medium") == 0)
 		sec_level = BT_IO_SEC_MEDIUM;
-	else if (strcmp(opt_sec_level, "high") == 0)
+	else if (strcmp(config->sec_level, "high") == 0)
 		sec_level = BT_IO_SEC_HIGH;
 	else
 		sec_level = BT_IO_SEC_LOW;
 
-	if (le)
+	if (config->le)
 		chan = bt_io_connect(BT_IO_L2CAP, connect_cb, NULL, NULL, &err,
 				BT_IO_OPT_SOURCE_BDADDR, &sba,
 				BT_IO_OPT_DEST_BDADDR, &dba,
 				BT_IO_OPT_CID, GATT_CID,
-				BT_IO_OPT_OMTU, opt_mtu,
+				BT_IO_OPT_OMTU, config->mtu,
 				BT_IO_OPT_SEC_LEVEL, sec_level,
 				BT_IO_OPT_INVALID);
 	else
 		chan = bt_io_connect(BT_IO_L2CAP, connect_cb, NULL, NULL, &err,
 				BT_IO_OPT_SOURCE_BDADDR, &sba,
 				BT_IO_OPT_DEST_BDADDR, &dba,
-				BT_IO_OPT_PSM, opt_psm,
-				BT_IO_OPT_OMTU, opt_mtu,
+				BT_IO_OPT_PSM, config->psm,
+				BT_IO_OPT_OMTU, config->mtu,
 				BT_IO_OPT_SEC_LEVEL, sec_level,
 				BT_IO_OPT_INVALID);
 
@@ -594,7 +590,7 @@ static GOptionEntry gatt_options[] = {
 		"Characteristics Descriptor Discovery", NULL },
 	{ "listen", 0, 0, G_OPTION_ARG_NONE, &opt_listen,
 		"Listen for notifications and indications", NULL },
-	{ "le", 0, 0, G_OPTION_ARG_NONE, &opt_le,
+	{ "le", 0, 0, G_OPTION_ARG_NONE, &config.le,
 		"Use Bluetooth Low Energy transport", NULL },
 	{ "interactive", 'I', G_OPTION_FLAG_IN_MAIN, G_OPTION_ARG_NONE,
 		&opt_interactive, "Use interactive mode", NULL },
@@ -602,15 +598,15 @@ static GOptionEntry gatt_options[] = {
 };
 
 static GOptionEntry options[] = {
-	{ "adapter", 'i', 0, G_OPTION_ARG_STRING, &opt_src,
+	{ "adapter", 'i', 0, G_OPTION_ARG_STRING, &config.src,
 		"Specify local adapter interface", "hciX" },
-	{ "device", 'b', 0, G_OPTION_ARG_STRING, &opt_dst,
+	{ "device", 'b', 0, G_OPTION_ARG_STRING, &config.dst,
 		"Specify remote Bluetooth address", "MAC" },
-	{ "mtu", 'm', 0, G_OPTION_ARG_INT, &opt_mtu,
+	{ "mtu", 'm', 0, G_OPTION_ARG_INT, &config.mtu,
 		"Specify the MTU size", "MTU" },
-	{ "psm", 'p', 0, G_OPTION_ARG_INT, &opt_psm,
+	{ "psm", 'p', 0, G_OPTION_ARG_INT, &config.psm,
 		"Specify the PSM for GATT/ATT over BR/EDR", "PSM" },
-	{ "sec-level", 'l', 0, G_OPTION_ARG_STRING, &opt_sec_level,
+	{ "sec-level", 'l', 0, G_OPTION_ARG_STRING, &config.sec_level,
 		"Set security level. Default: low", "[low | medium | high]"},
 	{ NULL },
 };
@@ -624,6 +620,10 @@ int main(int argc, char *argv[])
 	GIOChannel *chan;
 	GSourceFunc callback;
 
+	memset(&config, 0, sizeof(config));
+	config.sec_level = strdup("low");
+	config.psm = 0x1f;
+
 	context = g_option_context_new(NULL);
 	g_option_context_add_main_entries(context, options, NULL);
 
@@ -656,7 +656,7 @@ int main(int argc, char *argv[])
 	}
 
 	if (opt_interactive) {
-		interactive(opt_dst, opt_le);
+		interactive(config.dst, config.le);
 		goto done;
 	}
 
@@ -680,7 +680,7 @@ int main(int argc, char *argv[])
 		goto done;
 	}
 
-	chan = do_connect(opt_dst, opt_le, connect_cb);
+	chan = do_connect(&config, connect_cb);
 	if (chan == NULL) {
 		got_error = TRUE;
 		goto done;
@@ -706,9 +706,10 @@ int main(int argc, char *argv[])
 
 done:
 	g_option_context_free(context);
-	g_free(opt_src);
-	g_free(opt_dst);
+	g_free(config.src);
+	g_free(config.dst);
 	g_free(opt_uuid);
+	g_free(config.sec_level);
 
 	if (got_error)
 		exit(EXIT_FAILURE);
diff --git a/attrib/gatttool.h b/attrib/gatttool.h
index 2237330..ec6fa35 100644
--- a/attrib/gatttool.h
+++ b/attrib/gatttool.h
@@ -21,5 +21,14 @@
  *
  */
 
+struct connect_params {
+	gchar *src;
+	gchar *dst;
+	gchar *sec_level;
+	int psm;
+	int mtu;
+	gboolean le;
+};
+
 int interactive(gchar *dst, gboolean le);
-GIOChannel *do_connect(gchar *dst, gboolean le, BtIOConnect connect_cb);
+GIOChannel *do_connect(struct connect_params *config, BtIOConnect connect_cb);
diff --git a/attrib/interactive.c b/attrib/interactive.c
index 83a0778..284699b 100644
--- a/attrib/interactive.c
+++ b/attrib/interactive.c
@@ -37,8 +37,7 @@ static GAttrib *attrib = NULL;
 static GMainLoop *event_loop;
 static GString *prompt;
 
-static gchar *opt_dst = NULL;
-static gboolean opt_le = FALSE;
+struct connect_params config;
 
 static void cmd_help(int argcp, char **argvp);
 
@@ -60,12 +59,12 @@ static char *get_prompt(void)
 	else
 		g_string_assign(prompt, "[   ]");
 
-	if (opt_dst)
-		g_string_append_printf(prompt, "[%17s]", opt_dst);
+	if (config.dst)
+		g_string_append_printf(prompt, "[%17s]", config.dst);
 	else
 		g_string_append_printf(prompt, "[%17s]", "");
 
-	if (opt_le)
+	if (config.le)
 		g_string_append(prompt, "[LE]");
 	else
 		g_string_append(prompt, "[BR]");
@@ -107,17 +106,17 @@ static void cmd_connect(int argcp, char **argvp)
 		return;
 
 	if (argcp > 1) {
-		g_free(opt_dst);
-		opt_dst = strdup(argvp[1]);
+		g_free(config.dst);
+		config.dst = strdup(argvp[1]);
 	}
 
-	if (opt_dst == NULL) {
+	if (config.dst == NULL) {
 		printf("Remote Bluetooth address required\n");
 		return;
 	}
 
 	set_state(STATE_CONNECTING);
-	iochannel = do_connect(opt_dst, opt_le, connect_cb);
+	iochannel = do_connect(&config, connect_cb);
 	if (iochannel == NULL)
 		set_state(STATE_DISCONNECTED);
 
@@ -212,8 +211,12 @@ int interactive(gchar *dst, gboolean le)
 	GIOChannel *pchan;
 	gint events;
 
-	opt_dst = dst;
-	opt_le = le;
+	memset(&config, 0, sizeof(config));
+	config.sec_level = strdup("low");
+	config.psm = 0x1f;
+
+	config.dst = strdup(dst);
+	config.le = le;
 
 	prompt = g_string_new(NULL);
 
@@ -234,5 +237,8 @@ int interactive(gchar *dst, gboolean le)
 	g_main_loop_unref(event_loop);
 	g_string_free(prompt, TRUE);
 
+	g_free(config.dst);
+	g_free(config.sec_level);
+
 	return 0;
 }
-- 
1.7.1

