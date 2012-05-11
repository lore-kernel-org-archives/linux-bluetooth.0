Return-Path: <cyrus@holtmann.org>
From: Gustavo Padovan <gustavo@padovan.org>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH 2/4] monitor: add device filter support
Date: Fri, 11 May 2012 13:18:50 -0300
Message-Id: <1336753132-8282-2-git-send-email-gustavo@padovan.org>
In-Reply-To: <1336753132-8282-1-git-send-email-gustavo@padovan.org>
References: <1336753132-8282-1-git-send-email-gustavo@padovan.org>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

-i hciX option will show only data from the specified device
---
 monitor/main.c   |   12 ++++++++++--
 monitor/packet.c |   10 +++++++++-
 monitor/packet.h |    2 +-
 3 files changed, 20 insertions(+), 4 deletions(-)

diff --git a/monitor/main.c b/monitor/main.c
index 90e32c5..99b53e9 100644
--- a/monitor/main.c
+++ b/monitor/main.c
@@ -28,6 +28,7 @@
 
 #include <stdio.h>
 #include <stdlib.h>
+#include <string.h>
 #include <getopt.h>
 
 #include "mainloop.h"
@@ -52,12 +53,14 @@ static void usage(void)
 		"Usage:\n");
 	printf("\tbtmon [options]\n");
 	printf("options:\n"
+		"\t-i dev                HCI device\n"
 		"\t-b, --btsnoop <file>  Save dump in btsnoop format\n"
 		"\t-h, --help            Show help options\n");
 }
 
 static const struct option main_options[] = {
 	{ "btsnoop",	required_argument, NULL, 'b'	},
+	{ "",		required_argument, NULL, 'i'	},
 	{ "version",	no_argument,	   NULL, 'v'	},
 	{ "help",	no_argument,	   NULL, 'h'	},
 	{ }
@@ -67,13 +70,14 @@ int main(int argc, char *argv[])
 {
 	unsigned long filter_mask = 0;
 	sigset_t mask;
+	int index = -1;
 
 	mainloop_init();
 
 	for (;;) {
 		int opt;
 
-		opt = getopt_long(argc, argv, "bvh", main_options, NULL);
+		opt = getopt_long(argc, argv, "bi:vh", main_options, NULL);
 		if (opt < 0)
 			break;
 
@@ -81,6 +85,10 @@ int main(int argc, char *argv[])
 		case 'b':
 			btsnoop_open(optarg);
 			break;
+		case 'i':
+			if (!strncasecmp(optarg, "hci", 3))
+				index = atoi(optarg + 3);
+			break;
 		case 'v':
 			printf("%s\n", VERSION);
 			return EXIT_SUCCESS;
@@ -102,7 +110,7 @@ int main(int argc, char *argv[])
 	filter_mask |= PACKET_FILTER_SHOW_TIME;
 	filter_mask |= PACKET_FILTER_SHOW_ACL_DATA;
 
-	packet_set_filter(filter_mask);
+	packet_set_filter(filter_mask, index);
 
 	printf("Bluetooth monitor ver %s\n", VERSION);
 
diff --git a/monitor/packet.c b/monitor/packet.c
index 356e0a3..8379074 100644
--- a/monitor/packet.c
+++ b/monitor/packet.c
@@ -45,10 +45,12 @@
 #include "packet.h"
 
 static unsigned long filter_mask = 0;
+static int filter_index = -1;
 
-void packet_set_filter(unsigned long filter)
+void packet_set_filter(unsigned long filter, int index)
 {
 	filter_mask = filter;
+	filter_index = index;
 }
 
 static void print_channel_header(struct timeval *tv, uint16_t index,
@@ -128,6 +130,9 @@ void packet_hexdump(const unsigned char *buf, uint16_t len)
 void packet_control(struct timeval *tv, uint16_t index, uint16_t opcode,
 					const void *data, uint16_t size)
 {
+	if (filter_index >= 0 && filter_index != index)
+		return;
+
 	print_channel_header(tv, index, HCI_CHANNEL_CONTROL);
 
 	control_message(opcode, data, size);
@@ -163,6 +168,9 @@ void packet_monitor(struct timeval *tv, uint16_t index, uint16_t opcode,
 	const struct monitor_new_index *ni;
 	char str[18];
 
+	if (filter_index >= 0 && filter_index != index)
+		return;
+
 	switch (opcode) {
 	case MONITOR_NEW_INDEX:
 		ni = data;
diff --git a/monitor/packet.h b/monitor/packet.h
index 90fc7ec..525ce83 100644
--- a/monitor/packet.h
+++ b/monitor/packet.h
@@ -31,7 +31,7 @@
 #define PACKET_FILTER_SHOW_ACL_DATA	(1 << 3)
 #define PACKET_FILTER_SHOW_SCO_DATA	(1 << 4)
 
-void packet_set_filter(unsigned long filter);
+void packet_set_filter(unsigned long filter, int index);
 
 void packet_hexdump(const unsigned char *buf, uint16_t len);
 
-- 
1.7.10.1

