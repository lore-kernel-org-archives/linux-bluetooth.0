Return-Path: <linux-bluetooth-owner@vger.kernel.org>
From: Szymon Janc <szymon.janc@codecoup.pl>
To: linux-bluetooth@vger.kernel.org
Cc: Szymon Janc <szymon.janc@codecoup.pl>
Subject: [PATCH 2/3] tools/btmon-logger: Add support for chainning snoop files
Date: Fri, 12 Jan 2018 15:25:45 +0100
Message-Id: <20180112142546.31424-2-szymon.janc@codecoup.pl>
In-Reply-To: <20180112142546.31424-1-szymon.janc@codecoup.pl>
References: <20180112142546.31424-1-szymon.janc@codecoup.pl>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

This allows to generate split btsnoop file (eg for log rotation). To
achieve that new opcode is added to btsnoop file format. This opcode
contains random Set ID and sequence number which are used to identyfing
files and set. This special opcode is always first opcode in btsnoop
file that is part of a set.
---
 src/shared/btsnoop.h |  6 ++++++
 tools/btmon-logger.c | 37 +++++++++++++++++++++++++++++++------
 2 files changed, 37 insertions(+), 6 deletions(-)

diff --git a/src/shared/btsnoop.h b/src/shared/btsnoop.h
index 3df8998a3..a26d0a147 100644
--- a/src/shared/btsnoop.h
+++ b/src/shared/btsnoop.h
@@ -53,6 +53,7 @@
 #define BTSNOOP_OPCODE_CTRL_CLOSE	15
 #define BTSNOOP_OPCODE_CTRL_COMMAND	16
 #define BTSNOOP_OPCODE_CTRL_EVENT	17
+#define BTSNOOP_OPCODE_SET_ID		18
 
 #define BTSNOOP_MAX_PACKET_SIZE		(1486 + 4)
 
@@ -96,6 +97,11 @@ struct btsnoop_opcode_user_logging {
 	uint8_t  ident_len;
 } __attribute__((packed));
 
+struct btsnoop_opcode_set_id {
+	uint8_t id[16];
+	uint32_t seq;
+} __attribute__((packed));
+
 struct btsnoop;
 
 struct btsnoop *btsnoop_open(const char *path, unsigned long flags);
diff --git a/tools/btmon-logger.c b/tools/btmon-logger.c
index fe5f101b4..dc69db518 100644
--- a/tools/btmon-logger.c
+++ b/tools/btmon-logger.c
@@ -33,6 +33,7 @@
 #include <getopt.h>
 #include <unistd.h>
 #include <sys/socket.h>
+#include <sys/random.h>
 
 #include "lib/bluetooth.h"
 #include "lib/hci.h"
@@ -69,6 +70,9 @@ static int mgmt_index = -1;
 static int monitor_sk = -1;
 static struct btsnoop *btsnoop_file = NULL;
 
+static uint8_t set_random_id[16];
+static uint32_t set_seq = 0;
+
 static bool create_btsnoop(void)
 {
 	static char real_path[FILENAME_MAX];
@@ -88,10 +92,8 @@ static bool create_btsnoop(void)
 				tm.tm_mday, tm.tm_hour, tm.tm_min, tm.tm_sec);
 
 	} else {
-		static unsigned int cnt = 0;
-
 		snprintf(real_path, sizeof(real_path), "%s/%s_%u.btsnoop",
-							path, prefix, cnt++);
+							path, prefix, set_seq);
 	}
 
 	btsnoop_file = btsnoop_create(real_path, BTSNOOP_FORMAT_MONITOR);
@@ -100,6 +102,24 @@ static bool create_btsnoop(void)
 		return false;
 	}
 
+	if (write_limit) {
+		struct btsnoop_opcode_set_id op;
+		struct timeval tv;
+		uint32_t flags;
+
+		memset(&tv, 0, sizeof(tv));
+
+		memcpy(&op.id, set_random_id, sizeof(op.id));
+		op.seq = cpu_to_le32(set_seq);
+
+		flags = (MGMT_INDEX_NONE << 16) | BTSNOOP_OPCODE_SET_ID;
+
+		btsnoop_write(btsnoop_file, &tv, flags, 0, &op, sizeof(op));
+
+		set_seq++;
+		write_size = BTSNOOP_HDR_SIZE + BTSNOOP_PKT_SIZE + sizeof(op);
+	}
+
 	return true;
 }
 
@@ -110,12 +130,14 @@ static void rotate_btsnoop(uint16_t pktlen)
 	if (write_size <= write_limit)
 		return;
 
-	write_size = BTSNOOP_HDR_SIZE + BTSNOOP_PKT_SIZE + pktlen;
-
 	btsnoop_unref(btsnoop_file);
 
-	if (!create_btsnoop())
+	if (!create_btsnoop()) {
 		mainloop_quit();
+		return;
+	}
+
+	write_size += BTSNOOP_PKT_SIZE + pktlen;
 }
 
 static void data_callback(int fd, uint32_t events, void *user_data)
@@ -340,6 +362,9 @@ int main(int argc, char *argv[])
 		return EXIT_FAILURE;
 	}
 
+	if (write_limit)
+		getrandom(set_random_id, sizeof(set_random_id), 0);
+
 	if (!open_monitor_channel() || !create_btsnoop())
 		return EXIT_FAILURE;
 
-- 
2.14.3

