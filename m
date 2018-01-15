Return-Path: <linux-bluetooth-owner@vger.kernel.org>
From: Szymon Janc <szymon.janc@codecoup.pl>
To: linux-bluetooth@vger.kernel.org
Cc: Szymon Janc <szymon.janc@codecoup.pl>
Subject: [PATCH v2 3/3] monitor: Add support for reading btsnoop sets
Date: Mon, 15 Jan 2018 12:56:43 +0100
Message-Id: <20180115115643.23924-3-szymon.janc@codecoup.pl>
In-Reply-To: <20180115115643.23924-1-szymon.janc@codecoup.pl>
References: <20180115115643.23924-1-szymon.janc@codecoup.pl>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

This allows to combine multiple btsnoop files for decoding. Files need
to be from same set (share same ID) and sequence numbers must be without
gaps. First file doesn't have to have sequence 0.
---
 monitor/control.c | 139 +++++++++++++++++++++++++++++++++++++++++++++++++-----
 monitor/control.h |   2 +-
 monitor/main.c    |  20 ++++++--
 monitor/packet.c  |   1 +
 4 files changed, 145 insertions(+), 17 deletions(-)

diff --git a/monitor/control.c b/monitor/control.c
index 1cd79ca5d..a1a2415b9 100644
--- a/monitor/control.c
+++ b/monitor/control.c
@@ -45,6 +45,7 @@
 #include "lib/mgmt.h"
 
 #include "src/shared/util.h"
+#include "src/shared/queue.h"
 #include "src/shared/btsnoop.h"
 #include "src/shared/mainloop.h"
 
@@ -1378,18 +1379,14 @@ bool control_writer(const char *path)
 	return !!btsnoop_file;
 }
 
-void control_reader(const char *path)
+static void parse_snoop(struct btsnoop *btsnoop)
 {
 	unsigned char buf[BTSNOOP_MAX_PACKET_SIZE];
 	uint16_t pktlen;
 	uint32_t format;
 	struct timeval tv;
 
-	btsnoop_file = btsnoop_open(path, BTSNOOP_FLAG_PKLG_SUPPORT);
-	if (!btsnoop_file)
-		return;
-
-	format = btsnoop_get_format(btsnoop_file);
+	format = btsnoop_get_format(btsnoop);
 
 	switch (format) {
 	case BTSNOOP_FORMAT_HCI:
@@ -1403,8 +1400,6 @@ void control_reader(const char *path)
 		break;
 	}
 
-	open_pager();
-
 	switch (format) {
 	case BTSNOOP_FORMAT_HCI:
 	case BTSNOOP_FORMAT_UART:
@@ -1412,7 +1407,7 @@ void control_reader(const char *path)
 		while (1) {
 			uint16_t index, opcode;
 
-			if (!btsnoop_read_hci(btsnoop_file, &tv, &index,
+			if (!btsnoop_read_hci(btsnoop, &tv, &index,
 							&opcode, buf, &pktlen))
 				break;
 
@@ -1428,7 +1423,7 @@ void control_reader(const char *path)
 		while (1) {
 			uint16_t frequency;
 
-			if (!btsnoop_read_phy(btsnoop_file, &tv, &frequency,
+			if (!btsnoop_read_phy(btsnoop, &tv, &frequency,
 								buf, &pktlen))
 				break;
 
@@ -1436,10 +1431,132 @@ void control_reader(const char *path)
 		}
 		break;
 	}
+}
+
+struct snoop_data
+{
+	struct btsnoop *snoop;
+	uint32_t seq;
+};
+
+static void snoop_data_free(void *data)
+{
+	struct snoop_data *snoop_data = data;
+
+	btsnoop_unref(snoop_data->snoop);
+	free(snoop_data);
+}
+
+static bool match_snoop_by_seq(const void *data, const void *match_data)
+{
+	const struct snoop_data *snoop_data = data;
+	uint32_t seq = PTR_TO_UINT(match_data);
+
+	return snoop_data->seq == seq;
+}
+
+void control_reader(struct queue *paths)
+{
+	const struct queue_entry *entry;
+	struct snoop_data *data;
+	struct btsnoop *snoop;
+	struct queue *snoops;
+	uint8_t id[16];
+	bool first = true;
+	uint32_t i;
+
+	/* if 1 file is provided we don't check for set and seq and sort */
+	if (queue_length(paths) == 1) {
+		snoop = btsnoop_open(queue_pop_head(paths),
+						BTSNOOP_FLAG_PKLG_SUPPORT);
+		if (snoop) {
+			open_pager();
+			parse_snoop(snoop);
+			close_pager();
+		}
+
+		return;
+	}
+
+	snoops = queue_new();
+
+	/* get all snoop files with seq and verify set ID */
+	for (entry = queue_get_entries(paths); entry; entry = entry->next) {
+		unsigned char buf[BTSNOOP_MAX_PACKET_SIZE];
+		struct btsnoop_opcode_set_id *pkt = (void *)buf;
+		struct timeval tv;
+		uint16_t index;
+		uint16_t opcode;
+		uint16_t len;
+
+		snoop = btsnoop_open(entry->data, BTSNOOP_FLAG_PKLG_SUPPORT);
+		if (!snoop) {
+			fprintf(stderr, "Failed to open %s\n",
+							(char *) entry->data);
+			goto done;
+		}
+
+		if (!btsnoop_read_hci(snoop, &tv, &index, &opcode, buf, &len)) {
+			fprintf(stderr, "Failed to to read seq for %s\n",
+							(char *) entry->data);
+			goto done;
+		}
+
+		if (opcode != BTSNOOP_OPCODE_SET_ID) {
+			fprintf(stderr, "Set ID missing for %s\n",
+						(char *) entry->data);
+			goto done;
+		}
+
+		if (len != sizeof (*pkt)) {
+			fprintf(stderr, "Invalid Set ID size for %s\n",
+						(char *) entry->data);
+			goto done;
+		}
+
+		if (first) {
+			memcpy(id, pkt->id, sizeof(id));
+			first = false;
+		} else {
+			if (memcmp(id, pkt->id, sizeof(id))) {
+				fprintf(stderr, "Set ID mismatch for %s\n",
+							(char *) entry->data);
+				goto done;
+			}
+		}
+
+		data = new0(struct snoop_data, 1);
+		data->snoop = snoop;
+		data->seq = be32_to_cpu(pkt->seq);
+
+		queue_push_tail(snoops, data);
+	}
+
+	open_pager();
+
+	first = true;
+	for (i = 0; i < UINT32_MAX; i++) {
+		data = queue_remove_if(snoops, match_snoop_by_seq,
+								UINT_TO_PTR(i));
+
+		if (data) {
+			first = false;
+			parse_snoop(data->snoop);
+			snoop_data_free(data);
+			continue;
+		}
+
+		if (!queue_isempty(snoops))
+			printf("File with next sequence %u missing, stopping\n",
+									i);
+
+		break;
+	}
 
 	close_pager();
 
-	btsnoop_unref(btsnoop_file);
+done:
+	queue_destroy(snoops, snoop_data_free);
 }
 
 int control_tracing(void)
diff --git a/monitor/control.h b/monitor/control.h
index 630a852e4..85a7913b0 100644
--- a/monitor/control.h
+++ b/monitor/control.h
@@ -25,7 +25,7 @@
 #include <stdint.h>
 
 bool control_writer(const char *path);
-void control_reader(const char *path);
+void control_reader(struct queue *paths);
 void control_server(const char *path);
 int control_tty(const char *path, unsigned int speed);
 int control_tracing(void);
diff --git a/monitor/main.c b/monitor/main.c
index 3e61a4661..0102103df 100644
--- a/monitor/main.c
+++ b/monitor/main.c
@@ -33,6 +33,7 @@
 #include <getopt.h>
 #include <sys/un.h>
 
+#include "src/shared/queue.h"
 #include "src/shared/mainloop.h"
 #include "src/shared/tty.h"
 
@@ -97,8 +98,8 @@ static const struct option main_options[] = {
 
 int main(int argc, char *argv[])
 {
+	struct queue *reader_paths = queue_new();
 	unsigned long filter_mask = 0;
-	const char *reader_path = NULL;
 	const char *writer_path = NULL;
 	const char *analyze_path = NULL;
 	const char *ellisys_server = NULL;
@@ -134,7 +135,12 @@ int main(int argc, char *argv[])
 			}
 			break;
 		case 'r':
-			reader_path = optarg;
+			queue_push_tail(reader_paths, optarg);
+
+			/* check if more paths were provided */
+			while (optind < argc && *argv[optind] != '-')
+				queue_push_tail(reader_paths, argv[optind++]);
+
 			break;
 		case 'w':
 			writer_path = optarg;
@@ -202,7 +208,7 @@ int main(int argc, char *argv[])
 		return EXIT_FAILURE;
 	}
 
-	if (reader_path && analyze_path) {
+	if (!queue_isempty(reader_paths) && analyze_path) {
 		fprintf(stderr, "Display and analyze can't be combined\n");
 		return EXIT_FAILURE;
 	}
@@ -224,14 +230,18 @@ int main(int argc, char *argv[])
 		return EXIT_SUCCESS;
 	}
 
-	if (reader_path) {
+	if (!queue_isempty(reader_paths)) {
 		if (ellisys_server)
 			ellisys_enable(ellisys_server, ellisys_port);
 
-		control_reader(reader_path);
+		control_reader(reader_paths);
+		queue_destroy(reader_paths, NULL);
+
 		return EXIT_SUCCESS;
 	}
 
+	queue_destroy(reader_paths, NULL);
+
 	if (writer_path && !control_writer(writer_path)) {
 		printf("Failed to open '%s'\n", writer_path);
 		return EXIT_FAILURE;
diff --git a/monitor/packet.c b/monitor/packet.c
index b800a2d75..08397c40d 100644
--- a/monitor/packet.c
+++ b/monitor/packet.c
@@ -44,6 +44,7 @@
 #include "lib/hci_lib.h"
 
 #include "src/shared/util.h"
+#include "src/shared/queue.h"
 #include "src/shared/btsnoop.h"
 #include "display.h"
 #include "bt.h"
-- 
2.14.3

