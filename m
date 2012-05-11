Return-Path: <cyrus@holtmann.org>
From: Gustavo Padovan <gustavo@padovan.org>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH 3/4] monitor: add command line filter options
Date: Fri, 11 May 2012 13:18:51 -0300
Message-Id: <1336753132-8282-3-git-send-email-gustavo@padovan.org>
In-Reply-To: <1336753132-8282-2-git-send-email-gustavo@padovan.org>
References: <1336753132-8282-1-git-send-email-gustavo@padovan.org>
 <1336753132-8282-2-git-send-email-gustavo@padovan.org>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

right now "mgmt", "hci", "l2cap" and "sco" is supported.
---
 monitor/main.c   |   45 ++++++++++++++++++++++++++++++++++++++++-----
 monitor/packet.c |   15 +++++++++++++++
 monitor/packet.h |    4 ++++
 3 files changed, 59 insertions(+), 5 deletions(-)

diff --git a/monitor/main.c b/monitor/main.c
index 99b53e9..6096441 100644
--- a/monitor/main.c
+++ b/monitor/main.c
@@ -47,6 +47,34 @@ static void signal_callback(int signum, void *user_data)
 	}
 }
 
+static struct {
+	char *name;
+	int  flag;
+} filters[] = {
+	{ "mgmt",	PACKET_FILTER_SHOW_MGMT	},
+	{ "hci",	PACKET_FILTER_SHOW_HCI	},
+	{ "l2cap",	PACKET_FILTER_SHOW_ACL	},
+	{ "sco",	PACKET_FILTER_SHOW_SCO	},
+	{ 0 }
+};
+
+static unsigned long parse_filter(int argc, char **argv)
+{
+	unsigned long filter = 0;
+	int i,n;
+
+	for (i = 0; i < argc; i++) {
+		for (n = 0; filters[n].name; n++) {
+			if (!strcasecmp(filters[n].name, argv[i])) {
+				filter |= filters[n].flag;
+				break;
+			}
+		}
+	}
+
+	return filter;
+}
+
 static void usage(void)
 {
 	printf("btmon - Bluetooth monitor\n"
@@ -100,18 +128,25 @@ int main(int argc, char *argv[])
 		}
 	}
 
-	sigemptyset(&mask);
-	sigaddset(&mask, SIGINT);
-	sigaddset(&mask, SIGTERM);
+	filter_mask = parse_filter(argc, argv);
 
-	mainloop_set_signal(&mask, signal_callback, NULL, NULL);
+	if(!filter_mask)
+		filter_mask = ~0L;
 
 	filter_mask |= PACKET_FILTER_SHOW_INDEX;
-	filter_mask |= PACKET_FILTER_SHOW_TIME;
+	filter_mask &= ~PACKET_FILTER_SHOW_DATE;
 	filter_mask |= PACKET_FILTER_SHOW_ACL_DATA;
+	filter_mask |= PACKET_FILTER_SHOW_SCO_DATA;
+	filter_mask |= PACKET_FILTER_SHOW_TIME;
 
 	packet_set_filter(filter_mask, index);
 
+	sigemptyset(&mask);
+	sigaddset(&mask, SIGINT);
+	sigaddset(&mask, SIGTERM);
+
+	mainloop_set_signal(&mask, signal_callback, NULL, NULL);
+
 	printf("Bluetooth monitor ver %s\n", VERSION);
 
 	if (control_tracing() < 0) {
diff --git a/monitor/packet.c b/monitor/packet.c
index 8379074..6ab7ee7 100644
--- a/monitor/packet.c
+++ b/monitor/packet.c
@@ -133,6 +133,9 @@ void packet_control(struct timeval *tv, uint16_t index, uint16_t opcode,
 	if (filter_index >= 0 && filter_index != index)
 		return;
 
+	if (!(filter_mask & PACKET_FILTER_SHOW_MGMT))
+		return;
+
 	print_channel_header(tv, index, HCI_CHANNEL_CONTROL);
 
 	control_message(opcode, data, size);
@@ -581,6 +584,9 @@ void packet_hci_command(struct timeval *tv, uint16_t index,
 
 	btsnoop_write(tv, index, 0x02, data, size);
 
+	if (!(filter_mask & PACKET_FILTER_SHOW_HCI))
+		return;
+
 	print_header(tv, index);
 
 	if (size < HCI_COMMAND_HDR_SIZE) {
@@ -602,6 +608,9 @@ void packet_hci_event(struct timeval *tv, uint16_t index,
 {
 	const hci_event_hdr *hdr = data;
 
+	if (!(filter_mask & PACKET_FILTER_SHOW_HCI))
+		return;
+
 	btsnoop_write(tv, index, 0x03, data, size);
 
 	print_header(tv, index);
@@ -628,6 +637,9 @@ void packet_hci_acldata(struct timeval *tv, uint16_t index, bool in,
 	uint16_t dlen = btohs(hdr->dlen);
 	uint8_t flags = acl_flags(handle);
 
+	if (!(filter_mask & PACKET_FILTER_SHOW_ACL))
+		return;
+
 	btsnoop_write(tv, index, in ? 0x01 : 0x00, data, size);
 
 	print_header(tv, index);
@@ -654,6 +666,9 @@ void packet_hci_scodata(struct timeval *tv, uint16_t index, bool in,
 	uint16_t handle = btohs(hdr->handle);
 	uint8_t flags = acl_flags(handle);
 
+	if (!(filter_mask & PACKET_FILTER_SHOW_SCO))
+		return;
+
 	print_header(tv, index);
 
 	if (size < HCI_SCO_HDR_SIZE) {
diff --git a/monitor/packet.h b/monitor/packet.h
index 525ce83..65f90bb 100644
--- a/monitor/packet.h
+++ b/monitor/packet.h
@@ -30,6 +30,10 @@
 #define PACKET_FILTER_SHOW_TIME		(1 << 2)
 #define PACKET_FILTER_SHOW_ACL_DATA	(1 << 3)
 #define PACKET_FILTER_SHOW_SCO_DATA	(1 << 4)
+#define PACKET_FILTER_SHOW_HCI		(1 << 5)
+#define PACKET_FILTER_SHOW_ACL		(1 << 6)
+#define PACKET_FILTER_SHOW_SCO		(1 << 7)
+#define PACKET_FILTER_SHOW_MGMT		(1 << 8)
 
 void packet_set_filter(unsigned long filter, int index);
 
-- 
1.7.10.1

