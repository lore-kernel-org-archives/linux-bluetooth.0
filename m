Return-Path: <shapiroc@google.com>
From: C Shapiro <shapiroc@chromium.org>
To: linux-bluetooth@vger.kernel.org
Cc: Simon Glass <shapiroc@chromium.org>,
	Luiz Augusto von Dentz <luiz.dentz@gmail.com>,
	Marcel Holtmann <marcel@holtmann.org>,
	Eramoto Masaya <eramoto.masaya@jp.fujitsu.com>
Subject: [PATCH v3] Support to change set file via arg
Date: Tue, 18 Jul 2017 09:49:55 -0600
Message-Id: <20170718154955.83197-1-shapiroc@chromium.org>
List-ID: <linux-bluetooth.vger.kernel.org>

ChromeOS is currently shifting to a more dynamic build system where a
single build will be created/managed/deployed to support multiple models
that were all created based on a single reference board.

This is being done for general cost/maintenance savings around the sheer
number of builds that are currently managed for ChromeOS.

To support this, we're changing our build images to have all of the
configuration available for all of the models supported by a given
build.

For the bluetooth stack, models have different product id values in the
DeviceID field for the main.conf config file.

E.g.
 - https://chromium.googlesource.com/chromiumos/overlays/board-overlays/+/master/overlay-pyro/chromeos-base/chromeos-bsp-pyro/files/main.conf
 - https://chromium.googlesource.com/chromiumos/overlays/board-overlays/+/master/overlay-reef/chromeos-base/chromeos-bsp-reef/files/main.conf
 - https://chromium.googlesource.com/chromiumos/overlays/board-overlays/+/master/overlay-snappy/chromeos-base/chromeos-bsp-snappy/files/main.conf

This change allows the config file to be passed as a runtime argument to
bluetoothd, which allows the ChromeOS init script to determine the model
at runtime and then pass the appropriate model specific config file.

Signed-off-by: C Shapiro <shapiroc@chromium.org>
Reviewed-by: Simon Glass <sjg@chromium.org>
---
Changes in v3:
- Fix the commit message with correct links to the example usage.

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
2.13.2.932.g7449e964c-goog
