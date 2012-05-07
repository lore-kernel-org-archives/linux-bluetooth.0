Return-Path: <cyrus@holtmann.org>
From: Andrzej Kaczmarek <andrzej.kaczmarek@tieto.com>
To: <linux-bluetooth@vger.kernel.org>
CC: Andrzej Kaczmarek <andrzej.kaczmarek@tieto.com>
Subject: [PATCH] gatttool: Add option to specify LE address type
Date: Mon, 7 May 2012 15:09:02 +0200
Message-ID: <1336396142-6439-1-git-send-email-andrzej.kaczmarek@tieto.com>
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

This patch makes possible to specify LE address type.

After advertising cache was removed from kernel we should always specify
address type for LE link when calling bt_io_connect() as otherwise random
will always be used.

LE address type can be specified either by 'addr-type' or 't' command line
parameter or as additional parameter to 'connect' command in interactive mode.

Possible values are 'public' (default) and 'random'.
---
 attrib/gatttool.c    |    8 ++++++--
 attrib/gatttool.h    |    7 ++++---
 attrib/interactive.c |   17 +++++++++++++----
 attrib/utils.c       |   12 ++++++++++--
 4 files changed, 33 insertions(+), 11 deletions(-)

diff --git a/attrib/gatttool.c b/attrib/gatttool.c
index 21514af..8a43ec1 100644
--- a/attrib/gatttool.c
+++ b/attrib/gatttool.c
@@ -44,6 +44,7 @@
 
 static gchar *opt_src = NULL;
 static gchar *opt_dst = NULL;
+static gchar *opt_dst_type = NULL;
 static gchar *opt_value = NULL;
 static gchar *opt_sec_level = NULL;
 static bt_uuid_t *opt_uuid = NULL;
@@ -523,6 +524,8 @@ static GOptionEntry options[] = {
 		"Specify local adapter interface", "hciX" },
 	{ "device", 'b', 0, G_OPTION_ARG_STRING, &opt_dst,
 		"Specify remote Bluetooth address", "MAC" },
+	{ "addr-type", 't', 0, G_OPTION_ARG_STRING, &opt_dst_type,
+		"Set LE address type. Default: public", "[public | random]"},
 	{ "mtu", 'm', 0, G_OPTION_ARG_INT, &opt_mtu,
 		"Specify the MTU size", "MTU" },
 	{ "psm", 'p', 0, G_OPTION_ARG_INT, &opt_psm,
@@ -539,6 +542,7 @@ int main(int argc, char *argv[])
 	GError *gerr = NULL;
 	GIOChannel *chan;
 
+	opt_dst_type = g_strdup("public");
 	opt_sec_level = g_strdup("low");
 
 	context = g_option_context_new(NULL);
@@ -573,7 +577,7 @@ int main(int argc, char *argv[])
 	}
 
 	if (opt_interactive) {
-		interactive(opt_src, opt_dst, opt_psm);
+		interactive(opt_src, opt_dst, opt_dst_type, opt_psm);
 		goto done;
 	}
 
@@ -597,7 +601,7 @@ int main(int argc, char *argv[])
 		goto done;
 	}
 
-	chan = gatt_connect(opt_src, opt_dst, opt_sec_level,
+	chan = gatt_connect(opt_src, opt_dst, opt_dst_type, opt_sec_level,
 					opt_psm, opt_mtu, connect_cb);
 	if (chan == NULL) {
 		got_error = TRUE;
diff --git a/attrib/gatttool.h b/attrib/gatttool.h
index 89ac282..a38339b 100644
--- a/attrib/gatttool.h
+++ b/attrib/gatttool.h
@@ -21,8 +21,9 @@
  *
  */
 
-int interactive(const gchar *src, const gchar *dst, gboolean le);
+int interactive(const gchar *src, const gchar *dst, const gchar *dst_type,
+		gboolean le);
 GIOChannel *gatt_connect(const gchar *src, const gchar *dst,
-			const gchar *sec_level, int psm, int mtu,
-			BtIOConnect connect_cb);
+			const gchar *dst_type, const gchar *sec_level,
+			int psm, int mtu, BtIOConnect connect_cb);
 size_t gatt_attr_data_from_string(const char *str, uint8_t **data);
diff --git a/attrib/interactive.c b/attrib/interactive.c
index 073e3f7..0a01cdf 100644
--- a/attrib/interactive.c
+++ b/attrib/interactive.c
@@ -44,6 +44,7 @@ static GString *prompt;
 
 static gchar *opt_src = NULL;
 static gchar *opt_dst = NULL;
+static gchar *opt_dst_type = NULL;
 static gchar *opt_sec_level = NULL;
 static int opt_psm = 0;
 static int opt_mtu = 0;
@@ -359,6 +360,12 @@ static void cmd_connect(int argcp, char **argvp)
 	if (argcp > 1) {
 		g_free(opt_dst);
 		opt_dst = g_strdup(argvp[1]);
+
+		g_free(opt_dst_type);
+		if (argcp > 2)
+			opt_dst_type = g_strdup(argvp[2]);
+		else
+			opt_dst_type = g_strdup("public");
 	}
 
 	if (opt_dst == NULL) {
@@ -367,8 +374,8 @@ static void cmd_connect(int argcp, char **argvp)
 	}
 
 	set_state(STATE_CONNECTING);
-	iochannel = gatt_connect(opt_src, opt_dst, opt_sec_level, opt_psm,
-						opt_mtu, connect_cb);
+	iochannel = gatt_connect(opt_src, opt_dst, opt_dst_type, opt_sec_level,
+						opt_psm, opt_mtu, connect_cb);
 	if (iochannel == NULL)
 		set_state(STATE_DISCONNECTED);
 	else
@@ -735,7 +742,7 @@ static struct {
 		"Exit interactive mode" },
 	{ "quit",		cmd_exit,	"",
 		"Exit interactive mode" },
-	{ "connect",		cmd_connect,	"[address]",
+	{ "connect",		cmd_connect,	"[address [address type]]",
 		"Connect to a remote device" },
 	{ "disconnect",		cmd_disconnect,	"",
 		"Disconnect from a remote device" },
@@ -842,7 +849,8 @@ static char **commands_completion(const char *text, int start, int end)
 		return NULL;
 }
 
-int interactive(const gchar *src, const gchar *dst, int psm)
+int interactive(const gchar *src, const gchar *dst,
+		const gchar *dst_type, int psm)
 {
 	GIOChannel *pchan;
 	gint events;
@@ -851,6 +859,7 @@ int interactive(const gchar *src, const gchar *dst, int psm)
 
 	opt_src = g_strdup(src);
 	opt_dst = g_strdup(dst);
+	opt_dst_type = g_strdup(dst_type);
 	opt_psm = psm;
 
 	prompt = g_string_new(NULL);
diff --git a/attrib/utils.c b/attrib/utils.c
index 22d23a4..c951f44 100644
--- a/attrib/utils.c
+++ b/attrib/utils.c
@@ -41,11 +41,12 @@
 #define ATT_MIN_MTU_L2CAP	48
 
 GIOChannel *gatt_connect(const gchar *src, const gchar *dst,
-				const gchar *sec_level, int psm, int mtu,
-				BtIOConnect connect_cb)
+				const gchar *dst_type, const gchar *sec_level,
+				int psm, int mtu, BtIOConnect connect_cb)
 {
 	GIOChannel *chan;
 	bdaddr_t sba, dba;
+	uint8_t dest_type;
 	GError *err = NULL;
 	BtIOSecLevel sec;
 	int minimum_mtu;
@@ -74,6 +75,12 @@ GIOChannel *gatt_connect(const gchar *src, const gchar *dst,
 	} else
 		bacpy(&sba, BDADDR_ANY);
 
+	/* Not used for BR/EDR */
+	if (strcmp(dst_type, "random") == 0)
+		dest_type = BDADDR_LE_RANDOM;
+	else
+		dest_type = BDADDR_LE_PUBLIC;
+
 	if (strcmp(sec_level, "medium") == 0)
 		sec = BT_IO_SEC_MEDIUM;
 	else if (strcmp(sec_level, "high") == 0)
@@ -85,6 +92,7 @@ GIOChannel *gatt_connect(const gchar *src, const gchar *dst,
 		chan = bt_io_connect(BT_IO_L2CAP, connect_cb, NULL, NULL, &err,
 				BT_IO_OPT_SOURCE_BDADDR, &sba,
 				BT_IO_OPT_DEST_BDADDR, &dba,
+				BT_IO_OPT_DEST_TYPE, dest_type,
 				BT_IO_OPT_CID, ATT_CID,
 				BT_IO_OPT_OMTU, mtu,
 				BT_IO_OPT_SEC_LEVEL, sec,
-- 
1.7.9.5

