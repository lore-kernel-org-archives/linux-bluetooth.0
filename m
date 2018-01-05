Return-Path: <linux-bluetooth-owner@vger.kernel.org>
From: Szymon Janc <szymon.janc@codecoup.pl>
To: linux-bluetooth@vger.kernel.org
Cc: Szymon Janc <szymon.janc@codecoup.pl>
Subject: [PATCH] monitor: Add support for reading multpli btsnoop files
Date: Fri,  5 Jan 2018 12:54:13 +0100
Message-Id: <20180105115413.3546-1-szymon.janc@codecoup.pl>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

This allows to read concatenated btsnoop files that were previously
created with btmon -w -l options. The output looks like if this was
one btsnoop file.
---
 monitor/control.c |  4 ----
 monitor/main.c    | 38 +++++++++++++++++++++++++++++++++-----
 2 files changed, 33 insertions(+), 9 deletions(-)

diff --git a/monitor/control.c b/monitor/control.c
index 6b69f3575..1c7f1ee1a 100644
--- a/monitor/control.c
+++ b/monitor/control.c
@@ -1454,8 +1454,6 @@ void control_reader(const char *path)
 		break;
 	}
 
-	open_pager();
-
 	switch (format) {
 	case BTSNOOP_FORMAT_HCI:
 	case BTSNOOP_FORMAT_UART:
@@ -1488,8 +1486,6 @@ void control_reader(const char *path)
 		break;
 	}
 
-	close_pager();
-
 	btsnoop_unref(btsnoop_file);
 }
 
diff --git a/monitor/main.c b/monitor/main.c
index 3755d01ae..5e566201e 100644
--- a/monitor/main.c
+++ b/monitor/main.c
@@ -43,6 +43,7 @@
 #include "analyze.h"
 #include "ellisys.h"
 #include "control.h"
+#include "display.h"
 
 static void signal_callback(int signum, void *user_data)
 {
@@ -98,10 +99,24 @@ static const struct option main_options[] = {
 	{ }
 };
 
+static char **reader_paths = NULL;
+static size_t reader_paths_cnt = 0;
+
+static void append_reader_path(char *path)
+{
+	char **paths;
+
+	paths = reallocarray(reader_paths, reader_paths_cnt + 1, sizeof(char *));
+	if (!paths)
+		return;
+
+	reader_paths = paths;
+	reader_paths[reader_paths_cnt++] = path;
+}
+
 int main(int argc, char *argv[])
 {
 	unsigned long filter_mask = 0;
-	const char *reader_path = NULL;
 	const char *writer_path = NULL;
 	const char *analyze_path = NULL;
 	const char *ellisys_server = NULL;
@@ -139,7 +154,12 @@ int main(int argc, char *argv[])
 			}
 			break;
 		case 'r':
-			reader_path = optarg;
+			append_reader_path(optarg);
+
+			/* check if more paths were provided */
+			while (optind < argc && *argv[optind] != '-')
+				append_reader_path(argv[optind++]);
+
 			break;
 		case 'w':
 			writer_path = optarg;
@@ -233,8 +253,9 @@ int main(int argc, char *argv[])
 		return EXIT_FAILURE;
 	}
 
-	if (reader_path && analyze_path) {
+	if (reader_paths && analyze_path) {
 		fprintf(stderr, "Display and analyze can't be combined\n");
+		free(reader_paths);
 		return EXIT_FAILURE;
 	}
 
@@ -255,11 +276,18 @@ int main(int argc, char *argv[])
 		return EXIT_SUCCESS;
 	}
 
-	if (reader_path) {
+	if (reader_paths) {
+		size_t i;
+
 		if (ellisys_server)
 			ellisys_enable(ellisys_server, ellisys_port);
 
-		control_reader(reader_path);
+		open_pager();
+		for (i = 0; i < reader_paths_cnt; i++)
+			control_reader(reader_paths[i]);
+		close_pager();
+
+		free(reader_paths);
 		return EXIT_SUCCESS;
 	}
 
-- 
2.14.3

