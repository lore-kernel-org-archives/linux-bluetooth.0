Return-Path: <cyrus@holtmann.org>
From: Anton Weber <ant@antweb.me>
To: linux-bluetooth@vger.kernel.org
Cc: Anton Weber <ant@antweb.me>
Subject: [PATCH BlueZ 2/4] replay: Add timing functionality
Date: Thu,  9 Aug 2012 19:36:11 +0200
Message-Id: <1344533773-12914-2-git-send-email-ant@antweb.me>
In-Reply-To: <1344533773-12914-1-git-send-email-ant@antweb.me>
References: <1344533773-12914-1-git-send-email-ant@antweb.me>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Add -d parameter that lets user choose between two timing modes.
delta: use time difference between two packets for delay
none: no delay

Add -m parameter to specify a factor that multiplies delays in
delta timing mode.

Add -t parameter to set the epoll timeout when receiving packets.
---
 Makefile.tools        |    3 +-
 tools/replay/hciseq.c |   53 ++++++++++++++++++++++++++++
 tools/replay/hciseq.h |   23 +++++++++++++
 tools/replay/main.c   |   56 +++++++++++++++++++++++++++++-
 tools/replay/main.h   |   21 +-----------
 tools/replay/time.c   |   91 +++++++++++++++++++++++++++++++++++++++++++++++++
 tools/replay/time.h   |   31 +++++++++++++++++
 7 files changed, 256 insertions(+), 22 deletions(-)
 create mode 100644 tools/replay/hciseq.c
 create mode 100644 tools/replay/time.c
 create mode 100644 tools/replay/time.h

diff --git a/Makefile.tools b/Makefile.tools
index 4a3aca5..6767300 100644
--- a/Makefile.tools
+++ b/Makefile.tools
@@ -70,7 +70,8 @@ emulator_btvirt_SOURCES = emulator/main.c monitor/bt.h \
 					emulator/btdev.h emulator/btdev.c
 
 tools_replay_btreplay_SOURCES = tools/replay/main.h tools/replay/main.c \
-					tools/replay/hciseq.h \
+					tools/replay/hciseq.h tools/replay/hciseq.c \
+					tools/replay/time.h tools/replay/time.c \
 					monitor/packet.h monitor/packet.c \
 					monitor/btsnoop.h monitor/btsnoop.c \
 					monitor/control.h monitor/control.c \
diff --git a/tools/replay/hciseq.c b/tools/replay/hciseq.c
new file mode 100644
index 0000000..8b24264
--- /dev/null
+++ b/tools/replay/hciseq.c
@@ -0,0 +1,53 @@
+/*
+ *
+ *  BlueZ - Bluetooth protocol stack for Linux
+ *  Copyright (C) 2012       Anton Weber <ant@antweb.me>
+ *  Copyright (C) 2011-2012  Intel Corporation
+ *  Copyright (C) 2004-2010  Marcel Holtmann <marcel@holtmann.org>
+ *
+ *
+ *  This program is free software; you can redistribute it and/or modify
+ *  it under the terms of the GNU General Public License as published by
+ *  the Free Software Foundation; either version 2 of the License, or
+ *  (at your option) any later version.
+ *
+ *  This program is distributed in the hope that it will be useful,
+ *  but WITHOUT ANY WARRANTY; without even the implied warranty of
+ *  MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
+ *  GNU General Public License for more details.
+ *
+ *  You should have received a copy of the GNU General Public License
+ *  along with this program; if not, write to the Free Software
+ *  Foundation, Inc., 51 Franklin St, Fifth Floor, Boston, MA  02110-1301  USA
+ *
+ */
+
+#include <stdlib.h>
+#include <stdint.h>
+
+#include "hciseq.h"
+#include "time.h"
+#include "monitor/bt.h"
+
+void calc_rel_ts(struct hciseq_list *seq)
+{
+	struct timeval start;
+	struct hciseq_node *tmp;
+
+	start = seq->current->frame->ts;
+	tmp = seq->current;
+
+	/* first packet */
+	tmp->attr->ts_rel.tv_sec = 0;
+	tmp->attr->ts_rel.tv_usec = 0;
+	tmp->attr->ts_diff.tv_sec = 0;
+	tmp->attr->ts_diff.tv_usec = 0;
+
+	while (tmp->next != NULL) {
+		timeval_diff(&tmp->next->frame->ts, &start,
+				&tmp->next->attr->ts_rel);
+		timeval_diff(&tmp->next->frame->ts, &tmp->frame->ts,
+				&tmp->next->attr->ts_diff);
+		tmp = tmp->next;
+	}
+}
diff --git a/tools/replay/hciseq.h b/tools/replay/hciseq.h
index bf953cd..f9fe7c8 100644
--- a/tools/replay/hciseq.h
+++ b/tools/replay/hciseq.h
@@ -22,6 +22,25 @@
  *
  */
 
+struct frame {
+	void *data;
+	uint32_t data_len;
+	void *ptr;
+	uint32_t len;
+	uint16_t dev_id;
+	uint8_t in;
+	uint8_t master;
+	uint16_t handle;
+	uint16_t cid;
+	uint16_t num;
+	uint8_t dlci;
+	uint8_t channel;
+	unsigned long flags;
+	struct timeval ts;
+	int pppdump_fd;
+	int audio_fd;
+};
+
 enum hciseq_action {
 	HCISEQ_ACTION_REPLAY = 0,
 };
@@ -33,6 +52,8 @@ struct hciseq_list {
 };
 
 struct hciseq_attr {
+	struct timeval ts_rel;
+	struct timeval ts_diff;
 	enum hciseq_action action;
 };
 
@@ -41,3 +62,5 @@ struct hciseq_node {
 	struct hciseq_node *next;
 	struct hciseq_attr *attr;
 };
+
+void calc_rel_ts(struct hciseq_list *seq);
diff --git a/tools/replay/main.c b/tools/replay/main.c
index 8019151..49ea21d 100644
--- a/tools/replay/main.c
+++ b/tools/replay/main.c
@@ -37,8 +37,10 @@
 #include <unistd.h>
 #include <sys/epoll.h>
 #include <sys/ioctl.h>
+#include <sys/time.h>
 
 #include "main.h"
+#include "time.h"
 #include "lib/bluetooth.h"
 #include "lib/hci.h"
 #include "monitor/bt.h"
@@ -49,16 +51,22 @@
 #define MAX_EPOLL_EVENTS 1
 #define MAX_MSG 128
 
+#define TIMING_NONE 0
+#define TIMING_DELTA 1
+
 static struct hciseq_list dumpseq;
 
 static int fd;
 static int pos = 1;
 static int skipped = 0;
+static struct timeval start;
 
 static int epoll_fd;
 static struct epoll_event epoll_event;
 
 static int timeout = -1;
+static int timing = TIMING_NONE;
+static double factor = 1;
 static bool verbose = false;
 
 static inline int read_n(int fd, char *buf, int len)
@@ -313,6 +321,10 @@ static bool process_in()
 	if (n < 0) {
 		perror("Could not receive\n");
 		return false;
+	} else if (n == 0) {
+		printf("[%4d/%4d] Timeout\n", pos, dumpseq.len);
+		skipped++;
+		return true;
 	}
 
 	/* is this the packet in the sequence? */
@@ -353,9 +365,29 @@ static bool process_out()
 
 static void process()
 {
+	struct timeval last, last_diff;
+	__useconds_t delay;
 	bool processed;
 
+	gettimeofday(&last, NULL);
 	do {
+		/* delay */
+		if (timing == TIMING_DELTA) {
+			/* consider exec time of process_out()/process_in() */
+			get_timeval_passed(&last, &last_diff);
+			if (timeval_cmp(&dumpseq.current->attr->ts_diff, &last_diff) >= 0) {
+				delay = timeval_diff(&dumpseq.current->attr->ts_diff,
+								&last_diff, NULL);
+				delay *= factor;
+				if (usleep(delay) == -1)
+					printf("Delay failed\n");
+			} else {
+				/* exec time was longer than delay */
+				printf("Packet delay - processing previous packet took longer than recorded time difference\n");
+			}
+			gettimeofday(&last, NULL);
+		}
+
 		if (dumpseq.current->frame->in == 1)
 			processed = process_out();
 		else
@@ -417,12 +449,18 @@ static void usage(void)
 	printf("hcireplay - Bluetooth replayer\n"
 	       "Usage:\thcireplay-client [options] file...\n"
 	       "options:\n"
+	       "\t-d, --timing={none|delta}    Specify timing mode\n"
+	       "\t-m, --factor=<value>         Use timing modifier\n"
+	       "\t-t, --timeout=<value>        Use timeout when receiving\n"
 	       "\t-v, --verbose                Enable verbose output\n"
 	       "\t    --version                Give version information\n"
 	       "\t    --help                   Give a short usage message\n");
 }
 
 static const struct option main_options[] = {
+	{"timing", required_argument, NULL, 'd'},
+	{"factor", required_argument, NULL, 'm'},
+	{"timeout", required_argument, NULL, 't'},
 	{"verbose", no_argument, NULL, 'v'},
 	{"version", no_argument, NULL, 'V'},
 	{"help", no_argument, NULL, 'H'},
@@ -437,12 +475,25 @@ int main(int argc, char *argv[])
 	while (1) {
 		int opt;
 
-		opt = getopt_long(argc, argv, "v",
+		opt = getopt_long(argc, argv, "d:m:t:v",
 						main_options, NULL);
 		if (opt < 0)
 			break;
 
 		switch (opt) {
+		case 'd':
+			if (!strcmp(optarg, "none"))
+				timing = TIMING_NONE;
+			else if (!strcmp(optarg, "delta"))
+				timing = TIMING_DELTA;
+
+			break;
+		case 'm':
+			factor = atof(optarg);
+			break;
+		case 't':
+			timeout = atoi(optarg);
+			break;
 		case 'v':
 			verbose = true;
 			break;
@@ -478,6 +529,9 @@ int main(int argc, char *argv[])
 		}
 	}
 	dumpseq.current = dumpseq.frames;
+	calc_rel_ts(&dumpseq);
+
+	gettimeofday(&start, NULL);
 
 	/*
 	 * make sure we open the interface after parsing
diff --git a/tools/replay/main.h b/tools/replay/main.h
index d80deec..2223789 100644
--- a/tools/replay/main.h
+++ b/tools/replay/main.h
@@ -42,23 +42,4 @@ struct btsnoop_pkt {
 } __attribute__ ((packed));
 #define BTSNOOP_PKT_SIZE (sizeof(struct btsnoop_pkt))
 
-static uint8_t btsnoop_id[] = { 0x62, 0x74, 0x73, 0x6e, 0x6f, 0x6f, 0x70, 0x00 };
-
-struct frame {
-	void *data;
-	uint32_t data_len;
-	void *ptr;
-	uint32_t len;
-	uint16_t dev_id;
-	uint8_t in;
-	uint8_t master;
-	uint16_t handle;
-	uint16_t cid;
-	uint16_t num;
-	uint8_t dlci;
-	uint8_t channel;
-	unsigned long flags;
-	struct timeval ts;
-	int pppdump_fd;
-	int audio_fd;
-};
+uint8_t btsnoop_id[] = { 0x62, 0x74, 0x73, 0x6e, 0x6f, 0x6f, 0x70, 0x00 };
diff --git a/tools/replay/time.c b/tools/replay/time.c
new file mode 100644
index 0000000..029501a
--- /dev/null
+++ b/tools/replay/time.c
@@ -0,0 +1,91 @@
+/*
+ *
+ *  BlueZ - Bluetooth protocol stack for Linux
+ *  Copyright (C) 2012       Anton Weber <ant@antweb.me>
+ *
+ *
+ *  This program is free software; you can redistribute it and/or modify
+ *  it under the terms of the GNU General Public License as published by
+ *  the Free Software Foundation; either version 2 of the License, or
+ *  (at your option) any later version.
+ *
+ *  This program is distributed in the hope that it will be useful,
+ *  but WITHOUT ANY WARRANTY; without even the implied warranty of
+ *  MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
+ *  GNU General Public License for more details.
+ *
+ *  You should have received a copy of the GNU General Public License
+ *  along with this program; if not, write to the Free Software
+ *  Foundation, Inc., 51 Franklin St, Fifth Floor, Boston, MA  02110-1301  USA
+ *
+ */
+
+#include <stdlib.h>
+#include <sys/time.h>
+
+#include "time.h"
+
+/*
+ * Adjust timeval structs to make sure usec difference is not negative
+ * see http://www.gnu.org/software/libc/manual/html_node/Elapsed-Time.html
+ */
+void timeval_adjust_usec(struct timeval *l, struct timeval *r) {
+	int tmpsec;
+
+	if (r->tv_usec > l->tv_usec) {
+		tmpsec = (r->tv_usec - l->tv_usec) / 1000000 + 1;
+		r->tv_sec += tmpsec;
+		r->tv_usec -= 1000000 * tmpsec;
+	}
+
+	if ((l->tv_usec - r->tv_usec) > 1000000) {
+		tmpsec = (l->tv_usec - r->tv_usec) / 1000000;
+		r->tv_sec -= tmpsec;
+		r->tv_usec += 1000000 * tmpsec;
+	}
+}
+
+__useconds_t
+timeval_diff(struct timeval *l, struct timeval *r, struct timeval *diff)
+{
+	static struct timeval tmp;
+
+	timeval_adjust_usec(l, r);
+
+	/* use local variable if we only need return value */
+	if (diff == NULL)
+		diff = &tmp;
+
+	diff->tv_sec = l->tv_sec - r->tv_sec;
+	diff->tv_usec = l->tv_usec - r->tv_usec;
+
+	return (diff->tv_sec * 1000000) + diff->tv_usec;
+}
+
+int timeval_cmp(struct timeval *l, struct timeval *r)
+{
+	timeval_adjust_usec(l, r);
+
+	if (l->tv_sec > r->tv_sec) {
+		return 1;
+	} else if (l->tv_sec < r->tv_sec) {
+		return -1;
+	} else {
+		if (l->tv_usec > r->tv_usec)
+			return 1;
+		else if (l->tv_usec < r->tv_usec)
+			return -1;
+		else
+			return 0;
+	}
+}
+
+inline __useconds_t
+get_timeval_passed(struct timeval *since, struct timeval *diff)
+{
+	struct timeval now;
+
+	gettimeofday(&now, NULL);
+
+	return timeval_diff(&now, since, diff);
+}
diff --git a/tools/replay/time.h b/tools/replay/time.h
new file mode 100644
index 0000000..0c876a4
--- /dev/null
+++ b/tools/replay/time.h
@@ -0,0 +1,31 @@
+/*
+ *
+ *  BlueZ - Bluetooth protocol stack for Linux
+ *  Copyright (C) 2012       Anton Weber <ant@antweb.me>
+ *
+ *
+ *  This program is free software; you can redistribute it and/or modify
+ *  it under the terms of the GNU General Public License as published by
+ *  the Free Software Foundation; either version 2 of the License, or
+ *  (at your option) any later version.
+ *
+ *  This program is distributed in the hope that it will be useful,
+ *  but WITHOUT ANY WARRANTY; without even the implied warranty of
+ *  MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
+ *  GNU General Public License for more details.
+ *
+ *  You should have received a copy of the GNU General Public License
+ *  along with this program; if not, write to the Free Software
+ *  Foundation, Inc., 51 Franklin St, Fifth Floor, Boston, MA  02110-1301  USA
+ *
+ */
+
+void timeval_adjust_usec(struct timeval *l, struct timeval *r);
+
+__useconds_t
+timeval_diff(struct timeval *l, struct timeval *r, struct timeval *diff);
+
+int timeval_cmp(struct timeval *l, struct timeval *r);
+
+inline __useconds_t
+	get_timeval_passed(struct timeval *since, struct timeval *diff);
-- 
1.7.9.5

