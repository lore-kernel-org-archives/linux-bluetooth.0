Return-Path: <cyrus@holtmann.org>
From: Anderson Lizardo <anderson.lizardo@openbossa.org>
To: linux-bluetooth@vger.kernel.org
Cc: Anderson Lizardo <anderson.lizardo@openbossa.org>
Subject: [PATCH BlueZ] monitor: Validate HCI event/command parameter length when parsing
Date: Sat,  1 Mar 2014 15:23:28 -0400
Message-Id: <1393701808-27186-1-git-send-email-anderson.lizardo@openbossa.org>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Print an error message if the parameter length for HCI commands/events
does not match the actual remaining packet size.

This mainly avoids using garbage bytes when parsing corrupted packets.
The check was inspired on those used when parsing SCO/ACL packets.
---
 monitor/packet.c | 14 ++++++++++++++
 1 file changed, 14 insertions(+)

diff --git a/monitor/packet.c b/monitor/packet.c
index 78ecfd7..58a75db 100644
--- a/monitor/packet.c
+++ b/monitor/packet.c
@@ -7533,6 +7533,13 @@ void packet_hci_command(struct timeval *tv, uint16_t index,
 		return;
 	}
 
+	if (size != hdr->plen) {
+		print_text(COLOR_ERROR, "invalid packet size (%d != %d)", size,
+								hdr->plen);
+		packet_hexdump(data, size);
+		return;
+	}
+
 	if (opcode_data->cmd_fixed) {
 		if (hdr->plen != opcode_data->cmd_size) {
 			print_text(COLOR_ERROR, "invalid packet size");
@@ -7598,6 +7605,13 @@ void packet_hci_event(struct timeval *tv, uint16_t index,
 		return;
 	}
 
+	if (size != hdr->plen) {
+		print_text(COLOR_ERROR, "invalid packet size (%d != %d)", size,
+								hdr->plen);
+		packet_hexdump(data, size);
+		return;
+	}
+
 	if (event_data->fixed) {
 		if (hdr->plen != event_data->size) {
 			print_text(COLOR_ERROR, "invalid packet size");
-- 
1.8.3.2

