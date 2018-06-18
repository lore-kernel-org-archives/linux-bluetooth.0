Return-Path: <linux-bluetooth-owner@vger.kernel.org>
From: "=?UTF-8?q?Jo=C3=A3o=20Paulo=20Rechi=20Vita?=" <jprvita@gmail.com>
To: linux-bluetooth@vger.kernel.org
Cc: linux@endlessm.com,
        =?UTF-8?q?Jo=C3=A3o=20Paulo=20Rechi=20Vita?= <jprvita@endlessm.com>
Subject: [PATCH] monitor: Add option to disable SCO packets
Date: Mon, 18 Jun 2018 09:57:39 -0700
Message-Id: <20180618165739.13126-1-jprvita@endlessm.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

It is difficult to follow anything else happening when a SCO connection
is active, as the log gets floded with SCO packets. This adds an option
to disable dumping SCO packets.
---
 monitor/main.c   | 9 +++++++--
 monitor/packet.c | 6 ++++--
 monitor/packet.h | 1 +
 3 files changed, 12 insertions(+), 4 deletions(-)

diff --git a/monitor/main.c b/monitor/main.c
index 5fa87ea3f..6a8618c41 100644
--- a/monitor/main.c
+++ b/monitor/main.c
@@ -70,7 +70,8 @@ static void usage(void)
 		"\t-V, --vendor <compid>  Set default company identifier\n"
 		"\t-t, --time             Show time instead of time offset\n"
 		"\t-T, --date             Show time and date information\n"
-		"\t-S, --sco              Dump SCO traffic\n"
+		"\t-N, --no-sco-packets   Do not dump SCO packets\n"
+		"\t-S, --sco              Dump SCO traffic (without -N)\n"
 		"\t-A, --a2dp             Dump A2DP stream traffic\n"
 		"\t-E, --ellisys [ip]     Send Ellisys HCI Injection\n"
 		"\t-P, --no-pager         Disable pager usage\n"
@@ -89,6 +90,7 @@ static const struct option main_options[] = {
 	{ "vendor",    required_argument, NULL, 'V' },
 	{ "time",      no_argument,       NULL, 't' },
 	{ "date",      no_argument,       NULL, 'T' },
+	{ "no-sco",    no_argument,       NULL, 'N' },
 	{ "sco",       no_argument,       NULL, 'S' },
 	{ "a2dp",      no_argument,       NULL, 'A' },
 	{ "ellisys",   required_argument, NULL, 'E' },
@@ -122,7 +124,7 @@ int main(int argc, char *argv[])
 		int opt;
 		struct sockaddr_un addr;
 
-		opt = getopt_long(argc, argv, "r:w:a:s:p:i:d:B:V:tTSAEPvh",
+		opt = getopt_long(argc, argv, "r:w:a:s:p:i:d:B:V:tTNSAEPvh",
 							main_options, NULL);
 		if (opt < 0)
 			break;
@@ -181,6 +183,9 @@ int main(int argc, char *argv[])
 			filter_mask |= PACKET_FILTER_SHOW_TIME;
 			filter_mask |= PACKET_FILTER_SHOW_DATE;
 			break;
+		case 'N':
+			filter_mask |= PACKET_FILTER_NO_SCO_PACKET;
+			break;
 		case 'S':
 			filter_mask |= PACKET_FILTER_SHOW_SCO_DATA;
 			break;
diff --git a/monitor/packet.c b/monitor/packet.c
index 7705d2ed5..9972b3044 100644
--- a/monitor/packet.c
+++ b/monitor/packet.c
@@ -4047,10 +4047,12 @@ void packet_monitor(struct timeval *tv, struct ucred *cred,
 		packet_hci_acldata(tv, cred, index, true, data, size);
 		break;
 	case BTSNOOP_OPCODE_SCO_TX_PKT:
-		packet_hci_scodata(tv, cred, index, false, data, size);
+		if (!(filter_mask & PACKET_FILTER_NO_SCO_PACKET))
+			packet_hci_scodata(tv, cred, index, false, data, size);
 		break;
 	case BTSNOOP_OPCODE_SCO_RX_PKT:
-		packet_hci_scodata(tv, cred, index, true, data, size);
+		if (!(filter_mask & PACKET_FILTER_NO_SCO_PACKET))
+			packet_hci_scodata(tv, cred, index, true, data, size);
 		break;
 	case BTSNOOP_OPCODE_OPEN_INDEX:
 		if (index < MAX_INDEX)
diff --git a/monitor/packet.h b/monitor/packet.h
index 03279e114..b35708e83 100644
--- a/monitor/packet.h
+++ b/monitor/packet.h
@@ -34,6 +34,7 @@
 #define PACKET_FILTER_SHOW_ACL_DATA	(1 << 4)
 #define PACKET_FILTER_SHOW_SCO_DATA	(1 << 5)
 #define PACKET_FILTER_SHOW_A2DP_STREAM	(1 << 6)
+#define PACKET_FILTER_NO_SCO_PACKET	(1 << 7)
 
 bool packet_has_filter(unsigned long filter);
 void packet_set_filter(unsigned long filter);
-- 
2.17.1

