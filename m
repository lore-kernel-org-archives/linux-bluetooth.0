Return-Path: <linux-bluetooth-owner@vger.kernel.org>
From: C Shapiro <shapiroc@google.com>
To: linux-bluetooth@vger.kernel.org
Cc: Simon Glass <sjg@chromium.org>, C Shapiro <shapiroc@chromium.com>
Subject: [PATCH] Support to change set file via arg
Date: Fri, 30 Jun 2017 11:27:04 -0600
Message-Id: <20170630172704.189585-1-shapiroc@chromium.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Currently, there is an expectation of the main.conf file at a specific
location.  This prevents system builds that support more than one
platform.

This adds support so the main.conf file can be specified as a command
line arg instead, so systems can manage multiple conf files as necessary
and pass the appropriate conf file when the daemon is started.

Signed-off-by: C Shapiro <shapiroc@chromium.com>
---
 src/bluetoothd.8.in |  4 ++++
 src/main.c          | 12 +++++++++++-
 2 files changed, 15 insertions(+), 1 deletion(-)

diff --git a/src/bluetoothd.8.in b/src/bluetoothd.8.in
index 97ef3ec94..d61dcc5b3 100644
--- a/src/bluetoothd.8.in
+++ b/src/bluetoothd.8.in
@@ -27,6 +27,10 @@ Print bluetoothd options and exit.
 Enable logging in foreground. Directs log output to the controlling terminal \
 in addition to syslog.
 .TP
+.B -f, --configfile
+Specifies an explicit config file path instead of relying on the default path \
+(@CONFIGDIR@/main.conf) for the config file.
+.TP
 .B -d, --debug=<file1>:<file2>:...
 Sets how much information bluetoothd sends to the log destination (usually \
 syslog's "daemon" facility). If the file options are omitted, then debugging \
diff --git a/src/main.c b/src/main.c
index bcc1e6fae..87bdb66cb 100644
--- a/src/main.c
+++ b/src/main.c
@@ -490,6 +490,7 @@ static guint setup_signalfd(void)
 static char *option_debug = NULL;
 static char *option_plugin = NULL;
 static char *option_noplugin = NULL;
+static char *option_configfile = NULL;
 static gboolean option_compat = FALSE;
 static gboolean option_detach = TRUE;
 static gboolean option_version = FALSE;
@@ -505,6 +506,9 @@ static void free_options(void)
 
 	g_free(option_noplugin);
 	option_noplugin = NULL;
+
+	g_free(option_configfile);
+	option_configfile = NULL;
 }
 
 static void disconnect_dbus(void)
@@ -577,6 +581,9 @@ static GOptionEntry options[] = {
 				"Specify plugins to load", "NAME,..," },
 	{ "noplugin", 'P', 0, G_OPTION_ARG_STRING, &option_noplugin,
 				"Specify plugins not to load", "NAME,..." },
+	{ "configfile", 'f', 0, G_OPTION_ARG_STRING, &option_configfile,
+				"Specify an explicit path to the config file",
+				"FILE"},
 	{ "compat", 'C', 0, G_OPTION_ARG_NONE, &option_compat,
 				"Provide deprecated command line interfaces" },
 	{ "experimental", 'E', 0, G_OPTION_ARG_NONE, &option_experimental,
@@ -636,7 +643,10 @@ int main(int argc, char *argv[])
 
 	sd_notify(0, "STATUS=Starting up");
 
-	main_conf = load_config(CONFIGDIR "/main.conf");
+	if (option_configfile)
+		main_conf = load_config(option_configfile);
+	else
+		main_conf = load_config(CONFIGDIR "/main.conf");
 
 	parse_config(main_conf);
 
-- 
2.13.2.725.g09c95d1e9-goog

