Return-Path: <cyrus@holtmann.org>
From: Simon Fels <simon.fels@canonical.com>
To: linux-bluetooth@vger.kernel.org
Cc: Simon Fels <simon.fels@canonical.com>
Subject: [PATCH] core: add startup option to provide different configuration file
Date: Wed, 16 Sep 2015 07:52:31 +0200
Message-Id: <1442382751-25315-1-git-send-email-simon.fels@canonical.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

In some cases it's needed to select a different configuration file
at runtime than the one we load by default from a statically
configured path. This adds an optional argument to the daemon
startup which will enable us to load another a configuration file
from a different path.
---
 src/main.c | 11 ++++++++++-
 1 file changed, 10 insertions(+), 1 deletion(-)

diff --git a/src/main.c b/src/main.c
index 4c94a69..494b809 100644
--- a/src/main.c
+++ b/src/main.c
@@ -453,6 +453,7 @@ static guint setup_signalfd(void)
 static char *option_debug = NULL;
 static char *option_plugin = NULL;
 static char *option_noplugin = NULL;
+static char *option_conf = NULL;
 static gboolean option_compat = FALSE;
 static gboolean option_detach = TRUE;
 static gboolean option_version = FALSE;
@@ -547,6 +548,9 @@ static GOptionEntry options[] = {
 	{ "nodetach", 'n', G_OPTION_FLAG_REVERSE,
 				G_OPTION_ARG_NONE, &option_detach,
 				"Run with logging in foreground" },
+	{ "conf", 'c', 0, G_OPTION_ARG_STRING, &option_conf,
+				"Specify main configuration file to load. Will use "
+				CONFIGDIR "/main.conf by default", "CONF" },
 	{ "version", 'v', 0, G_OPTION_ARG_NONE, &option_version,
 				"Show version information and exit" },
 	{ NULL },
@@ -561,6 +565,7 @@ int main(int argc, char *argv[])
 	int gdbus_flags = 0;
 	guint signal, watchdog;
 	const char *watchdog_usec;
+	char *config_path = CONFIGDIR "/main.conf";
 
 	init_defaults();
 
@@ -593,7 +598,11 @@ int main(int argc, char *argv[])
 
 	sd_notify(0, "STATUS=Starting up");
 
-	main_conf = load_config(CONFIGDIR "/main.conf");
+	if (option_conf && g_file_test(option_conf, G_FILE_TEST_EXISTS |
+				G_FILE_TEST_IS_REGULAR) == TRUE)
+		config_path = option_conf;
+
+	main_conf = load_config(config_path);
 
 	parse_config(main_conf);
 
-- 
2.1.4

