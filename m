Return-Path: <linux-bluetooth-owner@vger.kernel.org>
From: Petri Gynther <pgynther@google.com>
To: linux-bluetooth@vger.kernel.org
Cc: luiz.dentz@gmail.com, Denton Gentry <dgentry@google.com>
Subject: [PATCH 1/2] monitor: Add -A option to suppress LE advertisements
Date: Tue, 20 Dec 2016 18:40:00 -0800
Message-Id: <1482288001-146507-1-git-send-email-pgynther@google.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

From: Denton Gentry <dgentry@google.com>

When monitor is run in the background to monitor connections
of bonded devices, it is sometimes not desirable to see all
LE advertisements that reach BlueZ stack, as they can add
significant amount of data to the monitor log.

Add -A option to suppress LE advertisements from btmon log.
---
 monitor/main.c   | 7 ++++++-
 monitor/packet.c | 8 ++++++++
 monitor/packet.h | 1 +
 3 files changed, 15 insertions(+), 1 deletion(-)

diff --git a/monitor/main.c b/monitor/main.c
index f9bca22..68ebdef 100644
--- a/monitor/main.c
+++ b/monitor/main.c
@@ -70,6 +70,7 @@ static void usage(void)
 		"\t-T, --date             Show time and date information\n"
 		"\t-S, --sco              Dump SCO traffic\n"
 		"\t-E, --ellisys [ip]     Send Ellisys HCI Injection\n"
+		"\t-A, --no_leadv         Suppress LE_ADV messages\n"
 		"\t-h, --help             Show help options\n");
 }
 
@@ -86,6 +87,7 @@ static const struct option main_options[] = {
 	{ "date",    no_argument,       NULL, 'T' },
 	{ "sco",     no_argument,	NULL, 'S' },
 	{ "ellisys", required_argument, NULL, 'E' },
+	{ "no_leadv", no_argument,      NULL, 'A' },
 	{ "todo",    no_argument,       NULL, '#' },
 	{ "version", no_argument,       NULL, 'v' },
 	{ "help",    no_argument,       NULL, 'h' },
@@ -113,7 +115,7 @@ int main(int argc, char *argv[])
 	for (;;) {
 		int opt;
 
-		opt = getopt_long(argc, argv, "d:r:w:a:s:p:i:tTSE:vh",
+		opt = getopt_long(argc, argv, "d:r:w:a:s:p:i:tTSAE:vh",
 						main_options, NULL);
 		if (opt < 0)
 			break;
@@ -167,6 +169,9 @@ int main(int argc, char *argv[])
 		case 'S':
 			filter_mask |= PACKET_FILTER_SHOW_SCO_DATA;
 			break;
+		case 'A':
+			filter_mask |= PACKET_FILTER_SUPPRESS_LE_ADV;
+			break;
 		case 'E':
 			ellisys_server = optarg;
 			ellisys_port = 24352;
diff --git a/monitor/packet.c b/monitor/packet.c
index 6272562..bf353d6 100644
--- a/monitor/packet.c
+++ b/monitor/packet.c
@@ -9038,6 +9038,14 @@ void packet_hci_event(struct timeval *tv, struct ucred *cred, uint16_t index,
 		event_str = "Unknown";
 	}
 
+	if (filter_mask & PACKET_FILTER_SUPPRESS_LE_ADV && hdr->evt == 0x3e) {
+		uint8_t subevent = *((const uint8_t *) data);
+		if (subevent == 0x02) {
+			/* LE Advertising Report. */
+			return;
+		}
+	}
+
 	sprintf(extra_str, "(0x%2.2x) plen %d", hdr->evt, hdr->plen);
 
 	print_packet(tv, cred, '>', index, NULL, event_color, "HCI Event",
diff --git a/monitor/packet.h b/monitor/packet.h
index 354f4fe..a02ea50 100644
--- a/monitor/packet.h
+++ b/monitor/packet.h
@@ -33,6 +33,7 @@
 #define PACKET_FILTER_SHOW_TIME_OFFSET	(1 << 3)
 #define PACKET_FILTER_SHOW_ACL_DATA	(1 << 4)
 #define PACKET_FILTER_SHOW_SCO_DATA	(1 << 5)
+#define PACKET_FILTER_SUPPRESS_LE_ADV	(1 << 31)
 
 void packet_set_filter(unsigned long filter);
 void packet_add_filter(unsigned long filter);
-- 
2.8.0.rc3.226.g39d4020

