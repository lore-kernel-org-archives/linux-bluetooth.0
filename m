Return-Path: <cyrus@holtmann.org>
From: Gustavo Padovan <gustavo@padovan.org>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH 1/2] monitor: add help information
Date: Thu, 26 Apr 2012 23:00:36 -0300
Message-Id: <1335492037-14196-1-git-send-email-gustavo@padovan.org>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

---
 monitor/main.c |   16 +++++++++++++++-
 1 file changed, 15 insertions(+), 1 deletion(-)

diff --git a/monitor/main.c b/monitor/main.c
index 9021133..3c4886f 100644
--- a/monitor/main.c
+++ b/monitor/main.c
@@ -46,8 +46,19 @@ static void signal_callback(int signum, void *user_data)
 	}
 }
 
+static void usage(void)
+{
+	printf("btmon - Bluetooth monitor\n"
+		"Usage:\n");
+	printf("\tbtmon [options]\n");
+	printf("options:\n"
+		"\t-b, --btsnoop <file>  Save dump in btsnoop format\n"
+		"\t-h, --help            Show help options\n");
+}
+
 static const struct option main_options[] = {
 	{ "btsnoop",	required_argument, NULL, 'b'	},
+	{ "help",	no_argument,	   NULL, 'h'	},
 	{ }
 };
 
@@ -61,7 +72,7 @@ int main(int argc, char *argv[])
 	for (;;) {
 		int opt;
 
-		opt = getopt_long(argc, argv, "b", main_options, NULL);
+		opt = getopt_long(argc, argv, "bh", main_options, NULL);
 		if (opt < 0)
 			break;
 
@@ -69,6 +80,9 @@ int main(int argc, char *argv[])
 		case 'b':
 			btsnoop_open(optarg);
 			break;
+		case 'h':
+			usage();
+			return EXIT_SUCCESS;
 		default:
 			return EXIT_FAILURE;
 		}
-- 
1.7.10

