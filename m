Return-Path: <linux-bluetooth-owner@vger.kernel.org>
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH BlueZ 1/3] monitor: Add frame counter support
Date: Sun, 23 Apr 2017 23:14:55 +0300
Message-Id: <20170423201457.7963-1-luiz.dentz@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

From: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>

This adds frame counter support for io frames:

> HCI Event: Command Complete (0x0e) plen 4         	#86 [hci1] 13:00:02.639412
      LE Set Scan Parameters (0x08|0x000b) ncmd 1
        Status: Success (0x00)
< HCI Command: LE Set Scan Enable (0x08|0x000c) plen 2  #87 [hci1] 13:00:02.639663
        Scanning: Enabled (0x01)
        Filter duplicates: Enabled (0x01)
> HCI Event: Command Complete (0x0e) plen 4             #88 [hci1] 13:00:02.640420
      LE Set Scan Enable (0x08|0x000c) ncmd 2
        Status: Success (0x00)
---
 monitor/packet.c | 45 +++++++++++++++++++++++++++++++++++----------
 1 file changed, 35 insertions(+), 10 deletions(-)

diff --git a/monitor/packet.c b/monitor/packet.c
index 3c43356..89423d1 100644
--- a/monitor/packet.c
+++ b/monitor/packet.c
@@ -58,6 +58,7 @@
 #include "packet.h"
 
 #define COLOR_CHANNEL_LABEL		COLOR_WHITE
+#define COLOR_FRAME_LABEL		COLOR_WHITE
 #define COLOR_INDEX_LABEL		COLOR_WHITE
 #define COLOR_TIMESTAMP			COLOR_YELLOW
 
@@ -259,6 +260,17 @@ void packet_select_index(uint16_t index)
 
 #define print_space(x) printf("%*c", (x), ' ');
 
+#define MAX_INDEX 16
+
+struct index_data {
+	uint8_t  type;
+	uint8_t  bdaddr[6];
+	uint16_t manufacturer;
+	size_t	frame;
+};
+
+static struct index_data index_list[MAX_INDEX];
+
 static void print_packet(struct timeval *tv, struct ucred *cred, char ident,
 					uint16_t index, const char *channel,
 					const char *color, const char *label,
@@ -267,6 +279,7 @@ static void print_packet(struct timeval *tv, struct ucred *cred, char ident,
 	int col = num_columns();
 	char line[256], ts_str[96];
 	int n, ts_len = 0, ts_pos = 0, len = 0, pos = 0;
+	static size_t last_frame;
 
 	if (channel) {
 		if (use_color()) {
@@ -280,6 +293,20 @@ static void print_packet(struct timeval *tv, struct ucred *cred, char ident,
 			ts_pos += n;
 			ts_len += n;
 		}
+	} else if (index != HCI_DEV_NONE &&
+				index_list[index].frame != last_frame) {
+		if (use_color()) {
+			n = sprintf(ts_str + ts_pos, "%s", COLOR_FRAME_LABEL);
+			if (n > 0)
+				ts_pos += n;
+		}
+
+		n = sprintf(ts_str + ts_pos, " #%zu", index_list[index].frame);
+		if (n > 0) {
+			ts_pos += n;
+			ts_len += n;
+		}
+		last_frame = index_list[index].frame;
 	}
 
 	if ((filter_mask & PACKET_FILTER_SHOW_INDEX) &&
@@ -3828,16 +3855,6 @@ static int addr2str(const uint8_t *addr, char *str)
 			addr[5], addr[4], addr[3], addr[2], addr[1], addr[0]);
 }
 
-#define MAX_INDEX 16
-
-struct index_data {
-	uint8_t  type;
-	uint8_t  bdaddr[6];
-	uint16_t manufacturer;
-};
-
-static struct index_data index_list[MAX_INDEX];
-
 void packet_monitor(struct timeval *tv, struct ucred *cred,
 					uint16_t index, uint16_t opcode,
 					const void *data, uint16_t size)
@@ -9156,6 +9173,8 @@ void packet_hci_command(struct timeval *tv, struct ucred *cred, uint16_t index,
 	char extra_str[25], vendor_str[150];
 	int i;
 
+	index_list[index].frame++;
+
 	if (size < HCI_COMMAND_HDR_SIZE) {
 		sprintf(extra_str, "(len %d)", size);
 		print_packet(tv, cred, '*', index, NULL, COLOR_ERROR,
@@ -9257,6 +9276,8 @@ void packet_hci_event(struct timeval *tv, struct ucred *cred, uint16_t index,
 	char extra_str[25];
 	int i;
 
+	index_list[index].frame++;
+
 	if (size < HCI_EVENT_HDR_SIZE) {
 		sprintf(extra_str, "(len %d)", size);
 		print_packet(tv, cred, '*', index, NULL, COLOR_ERROR,
@@ -9329,6 +9350,8 @@ void packet_hci_acldata(struct timeval *tv, struct ucred *cred, uint16_t index,
 	uint8_t flags = acl_flags(handle);
 	char handle_str[16], extra_str[32];
 
+	index_list[index].frame++;
+
 	if (size < HCI_ACL_HDR_SIZE) {
 		if (in)
 			print_packet(tv, cred, '*', index, NULL, COLOR_ERROR,
@@ -9371,6 +9394,8 @@ void packet_hci_scodata(struct timeval *tv, struct ucred *cred, uint16_t index,
 	uint8_t flags = acl_flags(handle);
 	char handle_str[16], extra_str[32];
 
+	index_list[index].frame++;
+
 	if (size < HCI_SCO_HDR_SIZE) {
 		if (in)
 			print_packet(tv, cred, '*', index, NULL, COLOR_ERROR,
-- 
2.9.3

