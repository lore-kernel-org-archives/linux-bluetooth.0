Return-Path: <cyrus@holtmann.org>
From: Vinicius Costa Gomes <vinicius.gomes@openbossa.org>
To: linux-bluetooth@vger.kernel.org
Cc: Vinicius Costa Gomes <vinicius.gomes@openbossa.org>
Subject: [PATCH BlueZ] monitor: Add an option to dump SCO traffic
Date: Wed, 17 Apr 2013 12:03:42 -0300
Message-Id: <1366211022-25337-1-git-send-email-vinicius.gomes@openbossa.org>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

---
 monitor/main.c | 7 ++++++-
 1 file changed, 6 insertions(+), 1 deletion(-)

diff --git a/monitor/main.c b/monitor/main.c
index 27a5722..8285a48 100644
--- a/monitor/main.c
+++ b/monitor/main.c
@@ -59,6 +59,7 @@ static void usage(void)
 		"\t-i, --index <num>      Show only specified controller\n"
 		"\t-t, --time             Show time instead of time offset\n"
 		"\t-T, --date             Show time and date information\n"
+		"\t-S, --sco              Dump SCO traffic\n"
 		"\t-h, --help             Show help options\n");
 }
 
@@ -69,6 +70,7 @@ static const struct option main_options[] = {
 	{ "index",   required_argument, NULL, 'i' },
 	{ "time",    no_argument,       NULL, 't' },
 	{ "date",    no_argument,       NULL, 'T' },
+	{ "sco",     no_argument,	NULL, 'S' },
 	{ "version", no_argument,       NULL, 'v' },
 	{ "help",    no_argument,       NULL, 'h' },
 	{ }
@@ -87,7 +89,7 @@ int main(int argc, char *argv[])
 	for (;;) {
 		int opt;
 
-		opt = getopt_long(argc, argv, "r:w:s:i:tTvh",
+		opt = getopt_long(argc, argv, "r:w:s:i:tTSvh",
 						main_options, NULL);
 		if (opt < 0)
 			break;
@@ -122,6 +124,9 @@ int main(int argc, char *argv[])
 			filter_mask |= PACKET_FILTER_SHOW_TIME;
 			filter_mask |= PACKET_FILTER_SHOW_DATE;
 			break;
+		case 'S':
+			filter_mask |= PACKET_FILTER_SHOW_SCO_DATA;
+			break;
 		case 'v':
 			printf("%s\n", VERSION);
 			return EXIT_SUCCESS;
-- 
1.8.2.1

