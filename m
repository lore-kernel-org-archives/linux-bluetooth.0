Return-Path: <linux-bluetooth-owner@vger.kernel.org>
From: Andrzej Kaczmarek <andrzej.kaczmarek@codecoup.pl>
To: linux-bluetooth@vger.kernel.org
Cc: Andrzej Kaczmarek <andrzej.kaczmarek@codecoup.pl>
Subject: [PATCH] monitor: Add option to ignore initial zero byte from tty
Date: Wed, 28 Jun 2017 11:03:42 +0200
Message-Id: <20170628090342.23529-1-andrzej.kaczmarek@codecoup.pl>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Some hosts may send an extra zero byte before any valid data. With this
patch it is possible to skip it and receive valid monitor data properly.

It's basically the same thing as we have for btproxy (6f4988bd).
---
 monitor/control.c | 15 ++++++++++++++-
 monitor/control.h |  3 ++-
 monitor/main.c    | 10 ++++++++--
 3 files changed, 24 insertions(+), 4 deletions(-)

diff --git a/monitor/control.c b/monitor/control.c
index 9bbdc37dc..c02c36357 100644
--- a/monitor/control.c
+++ b/monitor/control.c
@@ -58,6 +58,7 @@
 static struct btsnoop *btsnoop_file = NULL;
 static bool hcidump_fallback = false;
 static bool decode_control = true;
+static bool tty_skip_first_zero = false;
 
 struct control_data {
 	uint16_t channel;
@@ -1267,9 +1268,19 @@ static void tty_callback(int fd, uint32_t events, void *user_data)
 
 	len = read(data->fd, data->buf + data->offset,
 					sizeof(data->buf) - data->offset);
+
 	if (len < 0)
 		return;
 
+	if (tty_skip_first_zero && len > 0) {
+		tty_skip_first_zero = false;
+		if (data->buf[data->offset] == '\0') {
+			printf("Skipping initial zero byte\n");
+			len--;
+			memmove(data->buf + data->offset, data->buf + data->offset + 1, len);
+		}
+	}
+
 	data->offset += len;
 
 	while (data->offset >= sizeof(struct tty_hdr)) {
@@ -1311,7 +1322,7 @@ static void tty_callback(int fd, uint32_t events, void *user_data)
 	}
 }
 
-int control_tty(const char *path, unsigned int speed)
+int control_tty(const char *path, unsigned int speed, bool skip_first_zero)
 {
 	struct control_data *data;
 	struct termios ti;
@@ -1359,6 +1370,8 @@ int control_tty(const char *path, unsigned int speed)
 	data->channel = HCI_CHANNEL_MONITOR;
 	data->fd = fd;
 
+	tty_skip_first_zero = skip_first_zero;
+
 	mainloop_add_fd(data->fd, EPOLLIN, tty_callback, data, free_data);
 
 	return 0;
diff --git a/monitor/control.h b/monitor/control.h
index 630a852e4..18840a64b 100644
--- a/monitor/control.h
+++ b/monitor/control.h
@@ -22,12 +22,13 @@
  *
  */
 
+#include <stdbool.h>
 #include <stdint.h>
 
 bool control_writer(const char *path);
 void control_reader(const char *path);
 void control_server(const char *path);
-int control_tty(const char *path, unsigned int speed);
+int control_tty(const char *path, unsigned int speed, bool skip_first_zero);
 int control_tracing(void);
 void control_disable_decoding(void);
 
diff --git a/monitor/main.c b/monitor/main.c
index b4e9a6ab9..437640d51 100644
--- a/monitor/main.c
+++ b/monitor/main.c
@@ -66,6 +66,7 @@ static void usage(void)
 		"\t-i, --index <num>      Show only specified controller\n"
 		"\t-d, --tty <tty>        Read data from TTY\n"
 		"\t-B, --tty-speed <rate> Set TTY speed (default 115200)\n"
+		"\t-z, --tty-skip-zero    Skip first zero byte on TTY\n"
 		"\t-t, --time             Show time instead of time offset\n"
 		"\t-T, --date             Show time and date information\n"
 		"\t-S, --sco              Dump SCO traffic\n"
@@ -77,6 +78,7 @@ static void usage(void)
 static const struct option main_options[] = {
 	{ "tty",     required_argument, NULL, 'd' },
 	{ "tty-speed", required_argument, NULL, 'B' },
+	{ "tty-skip-zero", no_argument, NULL, 'z' },
 	{ "read",    required_argument, NULL, 'r' },
 	{ "write",   required_argument, NULL, 'w' },
 	{ "analyze", required_argument, NULL, 'a' },
@@ -103,6 +105,7 @@ int main(int argc, char *argv[])
 	const char *ellisys_server = NULL;
 	const char *tty = NULL;
 	unsigned int tty_speed = B115200;
+	bool tty_skip_zero = false;
 	unsigned short ellisys_port = 0;
 	const char *str;
 	int exit_status;
@@ -115,7 +118,7 @@ int main(int argc, char *argv[])
 	for (;;) {
 		int opt;
 
-		opt = getopt_long(argc, argv, "d:r:w:a:s:p:i:tTSAE:vh",
+		opt = getopt_long(argc, argv, "d:zr:w:a:s:p:i:tTSAE:vh",
 						main_options, NULL);
 		if (opt < 0)
 			break;
@@ -131,6 +134,9 @@ int main(int argc, char *argv[])
 				return EXIT_FAILURE;
 			}
 			break;
+		case 'z':
+			tty_skip_zero = true;
+			break;
 		case 'r':
 			reader_path = optarg;
 			break;
@@ -237,7 +243,7 @@ int main(int argc, char *argv[])
 	if (!tty && control_tracing() < 0)
 		return EXIT_FAILURE;
 
-	if (tty && control_tty(tty, tty_speed) < 0)
+	if (tty && control_tty(tty, tty_speed, tty_skip_zero) < 0)
 		return EXIT_FAILURE;
 
 	exit_status = mainloop_run();
-- 
2.13.0

