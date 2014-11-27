Return-Path: <cyrus@holtmann.org>
From: Szymon Janc <szymon.janc@tieto.com>
To: linux-bluetooth@vger.kernel.org
Cc: Szymon Janc <szymon.janc@tieto.com>
Subject: [PATCH 3/3] android/client: Add short option for printing version
Date: Thu, 27 Nov 2014 18:04:40 +0100
Message-Id: <1417107880-13118-3-git-send-email-szymon.janc@tieto.com>
In-Reply-To: <1417107880-13118-1-git-send-email-szymon.janc@tieto.com>
References: <1417107880-13118-1-git-send-email-szymon.janc@tieto.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

This makes haltest options consistent.
---
 android/client/haltest.c | 12 ++++--------
 1 file changed, 4 insertions(+), 8 deletions(-)

diff --git a/android/client/haltest.c b/android/client/haltest.c
index 0eaa43d..d514122 100644
--- a/android/client/haltest.c
+++ b/android/client/haltest.c
@@ -338,14 +338,10 @@ static void usage(void)
 	printf("options:\n"
 		"\t-i  --ivi              Initialize only IVI interfaces\n"
 		"\t-n, --no-init          Don't initialize any interfaces\n"
-		"\t    --version          Print version\n"
+		"\t-v  --version          Print version\n"
 		"\t-h, --help             Show help options\n");
 }
 
-enum {
-	PRINT_VERSION = 1000
-};
-
 static void print_version(void)
 {
 	printf("haltest version %s\n", VERSION);
@@ -355,7 +351,7 @@ static const struct option main_options[] = {
 	{ "no-init", no_argument, NULL, 'n' },
 	{ "ivi",     no_argument, NULL, 'i' },
 	{ "help",    no_argument, NULL, 'h' },
-	{ "version", no_argument, NULL, PRINT_VERSION },
+	{ "version", no_argument, NULL, 'v' },
 	{ NULL }
 };
 
@@ -367,7 +363,7 @@ static void parse_command_line(int argc, char *argv[])
 	for (;;) {
 		int opt;
 
-		opt = getopt_long(argc, argv, "inh", main_options, NULL);
+		opt = getopt_long(argc, argv, "inhv", main_options, NULL);
 		if (opt < 0)
 			break;
 
@@ -381,7 +377,7 @@ static void parse_command_line(int argc, char *argv[])
 		case 'h':
 			usage();
 			exit(0);
-		case PRINT_VERSION:
+		case 'v':
 			print_version();
 			exit(0);
 		default:
-- 
1.9.1

