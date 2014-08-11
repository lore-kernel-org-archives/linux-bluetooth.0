Return-Path: <cyrus@holtmann.org>
From: Vikrampal Yadav <vikram.pal@samsung.com>
To: linux-bluetooth@vger.kernel.org
Cc: luiz.dentz@gmail.com, d.kasatkin@samsung.com,
	vikram.pal@samsung.com
Subject: [PATCH 1/6] monitor: Add AVRCP specific AV/C commands support
Date: Mon, 11 Aug 2014 19:56:37 +0530
Message-id: <1407767202-7693-1-git-send-email-vikram.pal@samsung.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Support for decoding AVRCP specific AV/C commands added in
Bluetooth monitor.
---
 monitor/avctp.c | 101 +++++++++++++++++++++++++++++++++++++++++++++++++++++++-
 1 file changed, 100 insertions(+), 1 deletion(-)

diff --git a/monitor/avctp.c b/monitor/avctp.c
index d0594d7..c0ec6a2 100644
--- a/monitor/avctp.c
+++ b/monitor/avctp.c
@@ -43,10 +43,101 @@
 #include "sdp.h"
 #include "avctp.h"
 
+static const char *ctype2str(uint8_t ctype)
+{
+	return "Unknown";
+}
+
+static const char *subunit2str(uint8_t subunit)
+{
+	return "Reserved";
+}
+
+static const char *opcode2str(uint8_t opcode)
+{
+	return "Unknown";
+}
+
+static void avrcp_passthrough_packet(const struct l2cap_frame *frame)
+{
+}
+
+static void avrcp_pdu_packet(const struct l2cap_frame *frame, uint8_t ctype,
+                                uint8_t indent)
+{
+}
+
+static void avrcp_control_packet(const struct l2cap_frame *frame)
+{
+        uint8_t ctype, address, subunit, opcode, indent = 2;
+        struct l2cap_frame avrcp_frame;
+
+        ctype = *((uint8_t *) frame->data);
+        address = *((uint8_t *) (frame->data + 1));
+        opcode = *((uint8_t *) (frame->data + 2));
+
+        print_field("AV/C: %s: address 0x%02x opcode 0x%02x", ctype2str(ctype),
+                        address, opcode);
+
+        subunit = address >> 3;
+
+        print_field("%*cSubunit: %s", indent, ' ', subunit2str(subunit));
+
+        print_field("%*cOpcode: %s", indent, ' ', opcode2str(opcode));
+
+        /* Skip non-panel subunit packets */
+        if (subunit != 0x09) {
+                packet_hexdump(frame->data, frame->size);
+                return;
+        }
+
+        /* Not implemented should not contain any operand */
+        if (ctype == 0x8) {
+                packet_hexdump(frame->data, frame->size);
+                return;
+        }
+
+	switch (opcode) {
+        case 0x7c:
+                avrcp_passthrough_packet(frame);
+                break;
+        case 0x00:
+                print_field("%*cCompany ID: 0x%02x%02x%02x", indent, ' ',
+                                *((uint8_t *) (frame->data + 3)),
+                                *((uint8_t *) (frame->data + 4)),
+                                *((uint8_t *) (frame->data + 5)));
+
+                l2cap_frame_pull(&avrcp_frame, frame, 6);
+                avrcp_pdu_packet(&avrcp_frame, ctype, 10);
+                break;
+        default:
+                packet_hexdump(frame->data, frame->size);
+        }
+}
+
+static void avrcp_browsing_packet(const struct l2cap_frame *frame, uint8_t hdr)
+{
+}
+
+static void avrcp_packet(const struct l2cap_frame *frame, uint8_t hdr)
+{
+        switch (frame->psm) {
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
 void avctp_packet(const struct l2cap_frame *frame)
 {
         uint8_t hdr;
         uint16_t pid;
+	struct l2cap_frame avctp_frame;
         const char *pdu_color;
 
         if (frame->size < 3) {
@@ -70,5 +161,13 @@ void avctp_packet(const struct l2cap_frame *frame)
                         hdr & 0x02 ? "Response" : "Command",
                         hdr & 0x0c, hdr >> 4, pid);
 
-	packet_hexdump(frame->data + 3, frame->size - 3);
+	l2cap_frame_pull(&avctp_frame, frame, 3);
+
+        /* Copy psm as other protocols may need it later */
+        avctp_frame.psm = frame->psm;
+
+        if (pid == 0x110e || pid == 0x110c)
+                avrcp_packet(&avctp_frame, hdr);
+        else
+                packet_hexdump(frame->data + 3, frame->size - 3);
 }
-- 
1.9.1

