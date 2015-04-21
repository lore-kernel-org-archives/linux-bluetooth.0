Return-Path: <cyrus@holtmann.org>
From: Gowtham Anandha Babu <gowtham.ab@samsung.com>
To: linux-bluetooth@vger.kernel.org
Cc: bharat.panda@samsung.com, cpgs@samsung.com,
	Gowtham Anandha Babu <gowtham.ab@samsung.com>
Subject: [PATCH  1/5] monitor: Add support for decoding bnep General pkt
Date: Tue, 21 Apr 2015 14:44:25 +0530
Message-id: <1429607669-30669-2-git-send-email-gowtham.ab@samsung.com>
In-reply-to: <1429607669-30669-1-git-send-email-gowtham.ab@samsung.com>
References: <1429607669-30669-1-git-send-email-gowtham.ab@samsung.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

      BNEP: General Ethernet (0x00|0)
         dst 00:00:00:00:00:00 src 00:00:00:00:00:00 [proto 0x0300]
        3c 3b 3a 39 38 37 36 35 34 33 32 31 30 2f 2e 2d
        2c 2b 2a 29 28 27 26 25 24 23 22 21 20 1f 1e 1d
---
 monitor/bnep.c | 76 ++++++++++++++++++++++++++++++++++++++++++++++++++--------
 1 file changed, 66 insertions(+), 10 deletions(-)

diff --git a/monitor/bnep.c b/monitor/bnep.c
index 1450f85..61b5d71 100644
--- a/monitor/bnep.c
+++ b/monitor/bnep.c
@@ -47,29 +47,72 @@
 #define GET_PKT_TYPE(type) (type & 0x7f)
 #define GET_EXTENSION(type) (type & 0x80)
 
+uint16_t proto = 0x0000;
+
 struct bnep_frame {
 	uint8_t type;
 	int extension;
 	struct l2cap_frame l2cap_frame;
 };
 
+static bool get_macaddr(struct bnep_frame *bnep_frame, char *str)
+{
+	uint8_t addr[6];
+	struct l2cap_frame *frame = &bnep_frame->l2cap_frame;
+	int i;
+
+	for (i = 0; i < 6; i++)
+		if (!l2cap_frame_get_u8(frame, &addr[i]))
+			return false;
+
+	sprintf(str, "%02x:%02x:%02x:%02x:%02x:%02x",
+		addr[0], addr[1], addr[2], addr[3], addr[4], addr[5]);
+
+	return true;
+}
+
+static bool bnep_general(struct bnep_frame *bnep_frame,
+					uint8_t indent,	int hdr_len)
+{
+	struct l2cap_frame *frame;
+	char src_addr[20], dest_addr[20];
+
+	if (!get_macaddr(bnep_frame, dest_addr))
+		return false;
+
+	if (!get_macaddr(bnep_frame, src_addr))
+		return false;
+
+	frame = &bnep_frame->l2cap_frame;
+
+	if (!l2cap_frame_get_be16(frame, &proto))
+		return false;
+
+	print_field("%*cdst %s src %s [proto 0x%04x] ", indent,
+					' ', dest_addr, src_addr, proto);
+
+	return true;
+
+}
+
 struct bnep_data {
 	uint8_t type;
 	const char *str;
+	bool (*func) (struct bnep_frame *frame, uint8_t indent, int hdr_len);
 };
 
 static const struct bnep_data bnep_table[] = {
-	{ 0x00, "General Ethernet"},
-	{ 0x01, "Control"},
-	{ 0x02, "Compressed Ethernet"},
-	{ 0x03, "Compressed Ethernet Src Only"},
-	{ 0x04, "Compressed Ethernet Dest Only"},
+	{ 0x00, "General Ethernet",		bnep_general	},
+	{ 0x01, "Control",					},
+	{ 0x02, "Compressed Ethernet",				},
+	{ 0x03, "Compressed Ethernet SrcOnly",			},
+	{ 0x04, "Compressed Ethernet DestOnly",			},
 	{ }
 };
 
 void bnep_packet(const struct l2cap_frame *frame)
 {
-	uint8_t type;
+	uint8_t type, indent = 1;
 	struct bnep_frame bnep_frame;
 	struct l2cap_frame *l2cap_frame;
 	const struct bnep_data *bnep_data = NULL;
@@ -93,10 +136,13 @@ void bnep_packet(const struct l2cap_frame *frame)
 	}
 
 	if (bnep_data) {
-		if (frame->in)
-			pdu_color = COLOR_MAGENTA;
-		else
-			pdu_color = COLOR_BLUE;
+		if (bnep_data->func) {
+			if (frame->in)
+				pdu_color = COLOR_MAGENTA;
+			else
+				pdu_color = COLOR_BLUE;
+		} else
+			pdu_color = COLOR_WHITE_BG;
 		pdu_str = bnep_data->str;
 	} else {
 		pdu_color = COLOR_WHITE_BG;
@@ -107,7 +153,17 @@ void bnep_packet(const struct l2cap_frame *frame)
 				" (0x%02x|%s)", bnep_frame.type,
 				bnep_frame.extension ? "1" : "0");
 
+	if (!bnep_data || !bnep_data->func) {
+		packet_hexdump(l2cap_frame->data, l2cap_frame->size);
+		return;
+	}
+
+	if (!bnep_data->func(&bnep_frame, indent, -1))
+		goto fail;
+
+	/* TODO: Handle BNEP packet with Extension Header */
 	packet_hexdump(l2cap_frame->data, l2cap_frame->size);
+
 	return;
 
 fail:
-- 
1.9.1

