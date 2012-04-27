Return-Path: <cyrus@holtmann.org>
From: Gustavo Padovan <gustavo@padovan.org>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH 2/2] monitor: add version information
Date: Thu, 26 Apr 2012 23:00:37 -0300
Message-Id: <1335492037-14196-2-git-send-email-gustavo@padovan.org>
In-Reply-To: <1335492037-14196-1-git-send-email-gustavo@padovan.org>
References: <1335492037-14196-1-git-send-email-gustavo@padovan.org>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

---
 monitor/main.c |    6 +++++-
 1 file changed, 5 insertions(+), 1 deletion(-)

diff --git a/monitor/main.c b/monitor/main.c
index 3c4886f..4e8b433 100644
--- a/monitor/main.c
+++ b/monitor/main.c
@@ -58,6 +58,7 @@ static void usage(void)
 
 static const struct option main_options[] = {
 	{ "btsnoop",	required_argument, NULL, 'b'	},
+	{ "version",	no_argument,	   NULL, 'v'	},
 	{ "help",	no_argument,	   NULL, 'h'	},
 	{ }
 };
@@ -72,7 +73,7 @@ int main(int argc, char *argv[])
 	for (;;) {
 		int opt;
 
-		opt = getopt_long(argc, argv, "bh", main_options, NULL);
+		opt = getopt_long(argc, argv, "bvh", main_options, NULL);
 		if (opt < 0)
 			break;
 
@@ -80,6 +81,9 @@ int main(int argc, char *argv[])
 		case 'b':
 			btsnoop_open(optarg);
 			break;
+		case 'v':
+			printf("%s\n", VERSION);
+			return EXIT_SUCCESS;
 		case 'h':
 			usage();
 			return EXIT_SUCCESS;
-- 
1.7.10

