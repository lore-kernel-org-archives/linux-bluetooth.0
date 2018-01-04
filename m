Return-Path: <linux-bluetooth-owner@vger.kernel.org>
From: Szymon Janc <szymon.janc@codecoup.pl>
To: linux-bluetooth@vger.kernel.org
Cc: Szymon Janc <szymon.janc@codecoup.pl>
Subject: [PATCH] monitor: Add support for limiting btsnoop files size
Date: Thu,  4 Jan 2018 15:07:02 +0100
Message-Id: <20180104140702.16321-1-szymon.janc@codecoup.pl>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

This adds new option -l (--limit) which allows to limit maximum
size of writen btsnoop file. After limit is reached new btsnoop
file will be created. To distinguish file postfix in for of
_DATE_TIME is added to path provided with -w option. For convenience
KkMm modifiers are also supported.

This is especially useful on unattended systems for tiding btmon
with log rotation.

Example result of running btmon -w test.bin -l 10k
test.log_2018-01-04_14:55:06_694638
test.log_2018-01-04_14:56:15_933158
test.log_2018-01-04_14:57:20_741201
test.log_2018-01-04_14:58:13_280835
test.log_2018-01-04_14:59:02_183569
test.log_2018-01-04_15:00:05_352733
test.log_2018-01-04_15:00:54_475147
test.log_2018-01-04_15:01:57_183352
---
 monitor/control.c    | 55 ++++++++++++++++++++++++++++++++++++++++++++++++++--
 monitor/control.h    |  2 +-
 monitor/main.c       | 35 +++++++++++++++++++++++++++++++--
 src/shared/btsnoop.c | 17 ----------------
 src/shared/btsnoop.h | 17 ++++++++++++++++
 tools/btsnoop.c      | 17 ----------------
 6 files changed, 104 insertions(+), 39 deletions(-)

diff --git a/monitor/control.c b/monitor/control.c
index 1cd79ca5d..6b69f3575 100644
--- a/monitor/control.c
+++ b/monitor/control.c
@@ -32,6 +32,7 @@
 #include <unistd.h>
 #include <stdlib.h>
 #include <string.h>
+#include <time.h>
 #include <sys/time.h>
 #include <sys/socket.h>
 #include <sys/un.h>
@@ -59,6 +60,10 @@ static struct btsnoop *btsnoop_file = NULL;
 static bool hcidump_fallback = false;
 static bool decode_control = true;
 
+static size_t writer_limit = 0;
+static size_t writer_size = BTSNOOP_HDR_SIZE;
+static const char *writer_path = NULL;
+
 struct control_data {
 	uint16_t channel;
 	int fd;
@@ -908,6 +913,47 @@ void control_message(uint16_t opcode, const void *data, uint16_t size)
 	}
 }
 
+static const char *get_real_path(const char *path)
+{
+	static char real_path[FILENAME_MAX];
+	struct timeval tv;
+	struct tm tm;
+
+	if (!writer_limit)
+		return path;
+
+	memset(&tv, 0, sizeof(tv));
+
+	gettimeofday(&tv, NULL);
+	localtime_r(&tv.tv_sec, &tm);
+
+	snprintf(real_path, FILENAME_MAX,
+			"%s_%04d-%02d-%02d_%02d:%02d:%02d_%06lu", path,
+			tm.tm_year + 1900, tm.tm_mon + 1, tm.tm_mday,
+			tm.tm_hour, tm.tm_min, tm.tm_sec, tv.tv_usec);
+
+	real_path[FILENAME_MAX - 1] = '\0';
+
+	return real_path;
+}
+
+static void rotate_btsnoop_file(ssize_t pktlen)
+{
+	if (!writer_limit)
+		return;
+
+	writer_size += BTSNOOP_PKT_SIZE + pktlen;
+
+	if (writer_size <= writer_limit)
+		return;
+
+	writer_size = BTSNOOP_HDR_SIZE + BTSNOOP_PKT_SIZE + pktlen;
+
+	btsnoop_unref(btsnoop_file);
+	btsnoop_file = btsnoop_create(get_real_path(writer_path),
+							BTSNOOP_FORMAT_MONITOR);
+}
+
 static void data_callback(int fd, uint32_t events, void *user_data)
 {
 	struct control_data *data = user_data;
@@ -974,6 +1020,8 @@ static void data_callback(int fd, uint32_t events, void *user_data)
 							data->buf, pktlen);
 			break;
 		case HCI_CHANNEL_MONITOR:
+			rotate_btsnoop_file(pktlen);
+
 			btsnoop_write_hci(btsnoop_file, tv, index, opcode, 0,
 							data->buf, pktlen);
 			ellisys_inject_hci(tv, index, opcode,
@@ -1371,10 +1419,13 @@ int control_tty(const char *path, unsigned int speed)
 	return 0;
 }
 
-bool control_writer(const char *path)
+bool control_writer(const char *path, size_t limit)
 {
-	btsnoop_file = btsnoop_create(path, BTSNOOP_FORMAT_MONITOR);
+	writer_path = path;
+	writer_limit = limit;
 
+	btsnoop_file = btsnoop_create(get_real_path(writer_path),
+							BTSNOOP_FORMAT_MONITOR);
 	return !!btsnoop_file;
 }
 
diff --git a/monitor/control.h b/monitor/control.h
index 630a852e4..dec19d1d4 100644
--- a/monitor/control.h
+++ b/monitor/control.h
@@ -24,7 +24,7 @@
 
 #include <stdint.h>
 
-bool control_writer(const char *path);
+bool control_writer(const char *path, size_t limit);
 void control_reader(const char *path);
 void control_server(const char *path);
 int control_tty(const char *path, unsigned int speed);
diff --git a/monitor/main.c b/monitor/main.c
index 3e61a4661..3755d01ae 100644
--- a/monitor/main.c
+++ b/monitor/main.c
@@ -31,6 +31,7 @@
 #include <stdlib.h>
 #include <string.h>
 #include <getopt.h>
+#include <limits.h>
 #include <sys/un.h>
 
 #include "src/shared/mainloop.h"
@@ -61,6 +62,7 @@ static void usage(void)
 	printf("options:\n"
 		"\t-r, --read <file>      Read traces in btsnoop format\n"
 		"\t-w, --write <file>     Save traces in btsnoop format\n"
+		"\t-l, --limit <bytes>    Rotate btsnoop files\n"
 		"\t-a, --analyze <file>   Analyze traces in btsnoop format\n"
 		"\t-s, --server <socket>  Start monitor server socket\n"
 		"\t-p, --priority <level> Show only priority or lower\n"
@@ -80,6 +82,7 @@ static const struct option main_options[] = {
 	{ "tty-speed", required_argument, NULL, 'B' },
 	{ "read",    required_argument, NULL, 'r' },
 	{ "write",   required_argument, NULL, 'w' },
+	{ "limit",   required_argument, NULL, 'l' },
 	{ "analyze", required_argument, NULL, 'a' },
 	{ "server",  required_argument, NULL, 's' },
 	{ "priority",required_argument, NULL, 'p' },
@@ -108,6 +111,8 @@ int main(int argc, char *argv[])
 	const char *str;
 	int exit_status;
 	sigset_t mask;
+	size_t writer_limit = 0;
+	char *endptr;
 
 	mainloop_init();
 
@@ -117,7 +122,7 @@ int main(int argc, char *argv[])
 		int opt;
 		struct sockaddr_un addr;
 
-		opt = getopt_long(argc, argv, "d:r:w:a:s:p:i:tTSAE:vh",
+		opt = getopt_long(argc, argv, "d:r:w:l:a:s:p:i:tTSAE:vh",
 						main_options, NULL);
 		if (opt < 0)
 			break;
@@ -139,6 +144,32 @@ int main(int argc, char *argv[])
 		case 'w':
 			writer_path = optarg;
 			break;
+		case 'l':
+			str = optarg;
+			writer_limit = strtoul(str, &endptr, 10);
+
+			if (writer_limit == ULONG_MAX) {
+				fprintf(stderr, "Invalid limit value\n");
+				return EXIT_FAILURE;
+			}
+
+			if (*endptr != '\0') {
+				if (*endptr == 'K' || *endptr == 'k') {
+					writer_limit *= 1024;
+				} else if (*endptr == 'M' || *endptr == 'm') {
+					writer_limit *= 1024 * 1024;
+				} else {
+					fprintf(stderr, "Invalid limit value\n");
+					return EXIT_FAILURE;
+				}
+			}
+
+			/* avoid creating too small files */
+			if (writer_limit < 1024) {
+				fprintf(stderr, "Too small limit value\n");
+				return EXIT_FAILURE;
+			}
+			break;
 		case 'a':
 			analyze_path = optarg;
 			break;
@@ -232,7 +263,7 @@ int main(int argc, char *argv[])
 		return EXIT_SUCCESS;
 	}
 
-	if (writer_path && !control_writer(writer_path)) {
+	if (writer_path && !control_writer(writer_path, writer_limit)) {
 		printf("Failed to open '%s'\n", writer_path);
 		return EXIT_FAILURE;
 	}
diff --git a/src/shared/btsnoop.c b/src/shared/btsnoop.c
index e20d1b382..17e3faf2a 100644
--- a/src/shared/btsnoop.c
+++ b/src/shared/btsnoop.c
@@ -35,23 +35,6 @@
 
 #include "src/shared/btsnoop.h"
 
-struct btsnoop_hdr {
-	uint8_t		id[8];		/* Identification Pattern */
-	uint32_t	version;	/* Version Number = 1 */
-	uint32_t	type;		/* Datalink Type */
-} __attribute__ ((packed));
-#define BTSNOOP_HDR_SIZE (sizeof(struct btsnoop_hdr))
-
-struct btsnoop_pkt {
-	uint32_t	size;		/* Original Length */
-	uint32_t	len;		/* Included Length */
-	uint32_t	flags;		/* Packet Flags */
-	uint32_t	drops;		/* Cumulative Drops */
-	uint64_t	ts;		/* Timestamp microseconds */
-	uint8_t		data[0];	/* Packet Data */
-} __attribute__ ((packed));
-#define BTSNOOP_PKT_SIZE (sizeof(struct btsnoop_pkt))
-
 static const uint8_t btsnoop_id[] = { 0x62, 0x74, 0x73, 0x6e,
 				      0x6f, 0x6f, 0x70, 0x00 };
 
diff --git a/src/shared/btsnoop.h b/src/shared/btsnoop.h
index 3df8998a3..011aa1d68 100644
--- a/src/shared/btsnoop.h
+++ b/src/shared/btsnoop.h
@@ -91,6 +91,23 @@ struct btsnoop_opcode_index_info {
 #define BTSNOOP_PRIORITY_INFO		6
 #define BTSNOOP_PRIORITY_DEBUG		7
 
+struct btsnoop_hdr {
+	uint8_t		id[8];		/* Identification Pattern */
+	uint32_t	version;	/* Version Number = 1 */
+	uint32_t	type;		/* Datalink Type */
+} __attribute__ ((packed));
+#define BTSNOOP_HDR_SIZE (sizeof(struct btsnoop_hdr))
+
+struct btsnoop_pkt {
+	uint32_t	size;		/* Original Length */
+	uint32_t	len;		/* Included Length */
+	uint32_t	flags;		/* Packet Flags */
+	uint32_t	drops;		/* Cumulative Drops */
+	uint64_t	ts;		/* Timestamp microseconds */
+	uint8_t		data[0];	/* Packet Data */
+} __attribute__ ((packed));
+#define BTSNOOP_PKT_SIZE (sizeof(struct btsnoop_pkt))
+
 struct btsnoop_opcode_user_logging {
 	uint8_t  priority;
 	uint8_t  ident_len;
diff --git a/tools/btsnoop.c b/tools/btsnoop.c
index 3eb8082dd..465938961 100644
--- a/tools/btsnoop.c
+++ b/tools/btsnoop.c
@@ -41,23 +41,6 @@
 
 #include "src/shared/btsnoop.h"
 
-struct btsnoop_hdr {
-	uint8_t		id[8];		/* Identification Pattern */
-	uint32_t	version;	/* Version Number = 1 */
-	uint32_t	type;		/* Datalink Type */
-} __attribute__ ((packed));
-#define BTSNOOP_HDR_SIZE (sizeof(struct btsnoop_hdr))
-
-struct btsnoop_pkt {
-	uint32_t	size;		/* Original Length */
-	uint32_t	len;		/* Included Length */
-	uint32_t	flags;		/* Packet Flags */
-	uint32_t	drops;		/* Cumulative Drops */
-	uint64_t	ts;		/* Timestamp microseconds */
-	uint8_t		data[0];	/* Packet Data */
-} __attribute__ ((packed));
-#define BTSNOOP_PKT_SIZE (sizeof(struct btsnoop_pkt))
-
 static const uint8_t btsnoop_id[] = { 0x62, 0x74, 0x73, 0x6e,
 				      0x6f, 0x6f, 0x70, 0x00 };
 
-- 
2.14.3

