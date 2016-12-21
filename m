Return-Path: <linux-bluetooth-owner@vger.kernel.org>
From: Petri Gynther <pgynther@google.com>
To: linux-bluetooth@vger.kernel.org
Cc: luiz.dentz@gmail.com, Petri Gynther <pgynther@google.com>
Subject: [PATCH 2/2] monitor: Add -V option to suppress HCI vendor events
Date: Tue, 20 Dec 2016 18:40:01 -0800
Message-Id: <1482288001-146507-2-git-send-email-pgynther@google.com>
In-Reply-To: <1482288001-146507-1-git-send-email-pgynther@google.com>
References: <1482288001-146507-1-git-send-email-pgynther@google.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

When idle, Marvell 88W8897 Bluetooth adapter sends the following
HCI vendor events to BlueZ stack on continuous basis:

$ btmon
Bluetooth monitor ver 5.43
= New Index: XX:XX:XX:XX:XX:XX (Primary,SDIO,hci0)   [hci0] 0.029199
= Open Index: XX:XX:XX:XX:XX:XX                      [hci0] 0.029211
= Index Info: XX:XX:XX:XX:XX:XX (Marvell Technology Group Ltd.)
                                                     [hci0] 0.029222
> HCI Event: Vendor (0xff) plen 5                    [hci0] 0.300944
        05 80 00 09 00
> HCI Event: Vendor (0xff) plen 5                    [hci0] 2.860113
        05 80 00 09 00
> HCI Event: Vendor (0xff) plen 5                    [hci0] 5.420643
        05 80 00 09 00
  ...

Add -V option to suppress these HCI vendor events from btmon log.
---
 monitor/main.c   | 7 ++++++-
 monitor/packet.c | 3 +++
 monitor/packet.h | 1 +
 3 files changed, 10 insertions(+), 1 deletion(-)

diff --git a/monitor/main.c b/monitor/main.c
index 68ebdef..be10019 100644
--- a/monitor/main.c
+++ b/monitor/main.c
@@ -71,6 +71,7 @@ static void usage(void)
 		"\t-S, --sco              Dump SCO traffic\n"
 		"\t-E, --ellisys [ip]     Send Ellisys HCI Injection\n"
 		"\t-A, --no_leadv         Suppress LE_ADV messages\n"
+		"\t-V, --no_vendor        Suppress Vendor messages\n"
 		"\t-h, --help             Show help options\n");
 }
 
@@ -88,6 +89,7 @@ static const struct option main_options[] = {
 	{ "sco",     no_argument,	NULL, 'S' },
 	{ "ellisys", required_argument, NULL, 'E' },
 	{ "no_leadv", no_argument,      NULL, 'A' },
+	{ "no_vendor", no_argument,     NULL, 'V' },
 	{ "todo",    no_argument,       NULL, '#' },
 	{ "version", no_argument,       NULL, 'v' },
 	{ "help",    no_argument,       NULL, 'h' },
@@ -115,7 +117,7 @@ int main(int argc, char *argv[])
 	for (;;) {
 		int opt;
 
-		opt = getopt_long(argc, argv, "d:r:w:a:s:p:i:tTSAE:vh",
+		opt = getopt_long(argc, argv, "d:r:w:a:s:p:i:tTSAVE:vh",
 						main_options, NULL);
 		if (opt < 0)
 			break;
@@ -172,6 +174,9 @@ int main(int argc, char *argv[])
 		case 'A':
 			filter_mask |= PACKET_FILTER_SUPPRESS_LE_ADV;
 			break;
+		case 'V':
+			filter_mask |= PACKET_FILTER_SUPPRESS_VENDOR;
+			break;
 		case 'E':
 			ellisys_server = optarg;
 			ellisys_port = 24352;
diff --git a/monitor/packet.c b/monitor/packet.c
index bf353d6..0b3353f 100644
--- a/monitor/packet.c
+++ b/monitor/packet.c
@@ -9046,6 +9046,9 @@ void packet_hci_event(struct timeval *tv, struct ucred *cred, uint16_t index,
 		}
 	}
 
+	if (filter_mask & PACKET_FILTER_SUPPRESS_VENDOR && hdr->evt == 0xff)
+		return;
+
 	sprintf(extra_str, "(0x%2.2x) plen %d", hdr->evt, hdr->plen);
 
 	print_packet(tv, cred, '>', index, NULL, event_color, "HCI Event",
diff --git a/monitor/packet.h b/monitor/packet.h
index a02ea50..0330857 100644
--- a/monitor/packet.h
+++ b/monitor/packet.h
@@ -33,6 +33,7 @@
 #define PACKET_FILTER_SHOW_TIME_OFFSET	(1 << 3)
 #define PACKET_FILTER_SHOW_ACL_DATA	(1 << 4)
 #define PACKET_FILTER_SHOW_SCO_DATA	(1 << 5)
+#define PACKET_FILTER_SUPPRESS_VENDOR	(1 << 30)
 #define PACKET_FILTER_SUPPRESS_LE_ADV	(1 << 31)
 
 void packet_set_filter(unsigned long filter);
-- 
2.8.0.rc3.226.g39d4020

