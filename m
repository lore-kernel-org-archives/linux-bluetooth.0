Return-Path: <cyrus@holtmann.org>
From: Vikrampal Yadav <vikram.pal@samsung.com>
To: linux-bluetooth@vger.kernel.org
Cc: d.kasatkin@samsung.com, p.sinha@samsung.com, sanjay.nm@samsung.com,
	bharat.panda@samsung.com, vikram.pal@samsung.com, cpgs@samsung.com
Subject: [PATCH ] monitor: Add AVCTP support to btmon
Date: Tue, 22 Jul 2014 16:27:52 +0530
Message-id: <1406026672-3127-1-git-send-email-vikram.pal@samsung.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Support for decoding AVCTP packets added in Bluetooth monitor.
---
 monitor/l2cap.c | 64 +++++++++++++++++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 64 insertions(+)

diff --git a/monitor/l2cap.c b/monitor/l2cap.c
index 993aa8b..3475263 100644
--- a/monitor/l2cap.c
+++ b/monitor/l2cap.c
@@ -2220,6 +2220,66 @@ static void att_packet(uint16_t index, bool in, uint16_t handle,
 	opcode_data->func(&frame);
 }
 
+static void avrcp_control_packet(const struct l2cap_frame *frame)
+{
+}
+
+static void avrcp_browsing_packet(const struct l2cap_frame *frame, uint8_t hdr)
+{
+}
+
+static void avrcp_packet(const struct l2cap_frame *frame, uint8_t hdr,
+				uint16_t psm)
+{
+        switch (psm) {
+                case 0x17:
+                        avrcp_control_packet(frame);
+                        break;
+                case 0x1B:
+                        avrcp_browsing_packet(frame, hdr);
+                        break;
+                default:
+                        packet_hexdump(frame->data, frame->size);
+        }
+}
+
+static void avctp_packet(const struct l2cap_frame *frame, uint16_t psm)
+{
+        uint8_t hdr;
+        uint16_t pid;
+        struct l2cap_frame avctp_frame;
+        const char *pdu_color;
+
+        if (frame->size < 3) {
+                print_text(COLOR_ERROR, "frame too short");
+                packet_hexdump(frame->data, frame->size);
+                return;
+        }
+
+        hdr = *((uint8_t *) frame->data);
+
+        pid = get_be16(frame->data + 1);
+
+        if (frame->in)
+                pdu_color = COLOR_MAGENTA;
+        else
+                pdu_color = COLOR_BLUE;
+
+        print_indent(6, pdu_color, "AVCTP", "", COLOR_OFF,
+                        " %s: %s: Packet_type 0x%02x Transaction label %d "
+                        "PID 0x%04x",
+                        psm == 23 ? "Control" : "Browsing",
+                        hdr & 0x02 ? "Response" : "Command",
+                        hdr & 0x0c, hdr >> 4, pid);
+
+        l2cap_frame_pull(&avctp_frame, frame, 3);
+
+        if (pid == 0x110e || pid == 0x110c)
+                avrcp_packet(&avctp_frame, hdr, psm);
+        else
+                packet_hexdump(frame->data + 3, frame->size - 3);
+}
+
 static void print_addr(const uint8_t *addr, uint8_t addr_type)
 {
 	const char *str;
@@ -2634,6 +2694,10 @@ static void l2cap_frame(uint16_t index, bool in, uint16_t handle,
 		case 0x001f:
 			att_packet(index, in, handle, cid, data, size);
 			break;
+		case 0x0017:
+		case 0x001B:
+			avctp_packet(&frame, psm);
+			break;
 		default:
 			packet_hexdump(data, size);
 			break;
-- 
1.9.1

