Return-Path: <cyrus@holtmann.org>
From: Jerzy Kasenberg <jerzy.kasenberg@tieto.com>
To: <linux-bluetooth@vger.kernel.org>
CC: Jerzy Kasenberg <jerzy.kasenberg@tieto.com>
Subject: [PATCH 4/8] android/client: Add command line arguments
Date: Fri, 8 Nov 2013 13:48:26 +0100
Message-ID: <1383914910-2304-5-git-send-email-jerzy.kasenberg@tieto.com>
In-Reply-To: <1383914910-2304-1-git-send-email-jerzy.kasenberg@tieto.com>
References: <1383914910-2304-1-git-send-email-jerzy.kasenberg@tieto.com>
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

This patch adds command line argument parsing.
Options added:
 -h, --help
 -n, --no-init - disable initialization of interfaces
     --version
---
 android/client/haltest.c |   68 ++++++++++++++++++++++++++++++++++++++++++++--
 1 file changed, 66 insertions(+), 2 deletions(-)

diff --git a/android/client/haltest.c b/android/client/haltest.c
index 107dfec..7154d27 100644
--- a/android/client/haltest.c
+++ b/android/client/haltest.c
@@ -23,6 +23,7 @@
 #include <unistd.h>
 #include <poll.h>
 #include <unistd.h>
+#include <getopt.h>
 
 #include "if-main.h"
 #include "terminal.h"
@@ -222,7 +223,7 @@ const char *interface_name(void *v, int i)
 /* Function to enumerate command and interface names */
 const char *command_name(void *v, int i)
 {
-	int cmd_cnt = (int) (sizeof(commands)/sizeof(commands[0]) - 1);
+	int cmd_cnt = NELEM(commands);
 
 	if (i >= cmd_cnt)
 		return interface_name(v, i - cmd_cnt);
@@ -318,6 +319,65 @@ static void stdin_handler(struct pollfd *pollfd)
 	}
 }
 
+static void usage(void)
+{
+	printf("haltest Android Bluetooth HAL testing tool\n"
+		"Usage:\n");
+	printf("\thaltest [options]\n");
+	printf("options:\n"
+		"\t-n, --no-init          Don't call init for interfaces\n"
+		"\t    --version          Print version\n"
+		"\t-h, --help             Show help options\n");
+}
+
+enum {
+	PRINT_VERSION = 1000
+};
+
+int version = 1;
+int revision = 0;
+
+static void print_version(void)
+{
+	printf("haltest version %d.%d\n", version, revision);
+}
+
+static const struct option main_options[] = {
+	{ "no-init", no_argument, NULL, 'n' },
+	{ "help",    no_argument, NULL, 'h' },
+	{ "version", no_argument, NULL, PRINT_VERSION },
+	{ NULL }
+};
+
+static bool no_init = false;
+
+static void parse_command_line(int argc, char *argv[])
+{
+	for (;;) {
+		int opt;
+
+		opt = getopt_long(argc, argv, "nh", main_options, NULL);
+		if (opt < 0)
+			break;
+
+		switch (opt) {
+		case 'n':
+			no_init = true;
+			break;
+		case 'h':
+			usage();
+			exit(0);
+		case PRINT_VERSION:
+			print_version();
+			exit(0);
+		default:
+			putchar('\n');
+			exit(-1);
+			break;
+		}
+	}
+}
+
 static void init(void)
 {
 	static const char * const inames[] = {
@@ -356,8 +416,12 @@ int main(int argc, char **argv)
 {
 	struct stat rcstat;
 
+	parse_command_line(argc, argv);
+
 	terminal_setup();
-	init();
+
+	if (!no_init)
+		init();
 
 	history_restore(".haltest_history");
 
-- 
1.7.9.5

