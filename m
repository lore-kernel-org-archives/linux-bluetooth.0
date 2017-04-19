Return-Path: <linux-bluetooth-owner@vger.kernel.org>
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH BlueZ] monitor: Add frame number support
Date: Wed, 19 Apr 2017 21:40:12 +0300
Message-Id: <20170419184012.5650-1-luiz.dentz@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

From: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>

This adds -f/--frames options which can be used to show the frame
number:

  #1 < HCI Command: Write Voice Setting (0x03|0x0026) plen 2
        Setting: 0x0060
          Input Coding: Linear
          Input Data Format: 2's complement
          Input Sample Size: 16-bit
          # of bits padding at MSB: 0
          Air Coding Format: CVSD
  #2 > HCI Event: Command Complete (0x0e) plen 4
      Write Voice Setting (0x03|0x0026) ncmd 1
        Status: Success (0x00)
---
 monitor/main.c   | 7 ++++++-
 monitor/packet.c | 9 ++++++++-
 monitor/packet.h | 1 +
 3 files changed, 15 insertions(+), 2 deletions(-)

diff --git a/monitor/main.c b/monitor/main.c
index f9bca22..e1a2375 100644
--- a/monitor/main.c
+++ b/monitor/main.c
@@ -70,6 +70,7 @@ static void usage(void)
 		"\t-T, --date             Show time and date information\n"
 		"\t-S, --sco              Dump SCO traffic\n"
 		"\t-E, --ellisys [ip]     Send Ellisys HCI Injection\n"
+		"\t-f, --frames           Show frame counter\n"
 		"\t-h, --help             Show help options\n");
 }
 
@@ -86,6 +87,7 @@ static const struct option main_options[] = {
 	{ "date",    no_argument,       NULL, 'T' },
 	{ "sco",     no_argument,	NULL, 'S' },
 	{ "ellisys", required_argument, NULL, 'E' },
+	{ "frames",  no_argument,	NULL, 'f' },
 	{ "todo",    no_argument,       NULL, '#' },
 	{ "version", no_argument,       NULL, 'v' },
 	{ "help",    no_argument,       NULL, 'h' },
@@ -113,7 +115,7 @@ int main(int argc, char *argv[])
 	for (;;) {
 		int opt;
 
-		opt = getopt_long(argc, argv, "d:r:w:a:s:p:i:tTSE:vh",
+		opt = getopt_long(argc, argv, "d:r:w:a:s:p:i:tfTSE:vh",
 						main_options, NULL);
 		if (opt < 0)
 			break;
@@ -171,6 +173,9 @@ int main(int argc, char *argv[])
 			ellisys_server = optarg;
 			ellisys_port = 24352;
 			break;
+		case 'f':
+			filter_mask |= PACKET_FILTER_SHOW_FRAME;
+			break;
 		case '#':
 			packet_todo();
 			lmp_todo();
diff --git a/monitor/packet.c b/monitor/packet.c
index 3c43356..d369a4d 100644
--- a/monitor/packet.c
+++ b/monitor/packet.c
@@ -349,7 +349,14 @@ static void print_packet(struct timeval *tv, struct ucred *cred, char ident,
 			pos += n;
 	}
 
-	n = sprintf(line + pos, "%c %s", ident, label ? label : "");
+	if (filter_mask & PACKET_FILTER_SHOW_FRAME) {
+		static size_t frame;
+
+		n = sprintf(line + pos, "#%zu %c %s", ++frame, ident,
+						label ? label : "");
+	} else
+		n = sprintf(line + pos, "%c %s", ident, label ? label : "");
+
 	if (n > 0) {
 		pos += n;
 		len += n;
diff --git a/monitor/packet.h b/monitor/packet.h
index 354f4fe..2516ec1 100644
--- a/monitor/packet.h
+++ b/monitor/packet.h
@@ -33,6 +33,7 @@
 #define PACKET_FILTER_SHOW_TIME_OFFSET	(1 << 3)
 #define PACKET_FILTER_SHOW_ACL_DATA	(1 << 4)
 #define PACKET_FILTER_SHOW_SCO_DATA	(1 << 5)
+#define PACKET_FILTER_SHOW_FRAME	(1 << 6)
 
 void packet_set_filter(unsigned long filter);
 void packet_add_filter(unsigned long filter);
-- 
2.9.3

