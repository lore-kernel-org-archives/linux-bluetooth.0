Return-Path: <cyrus@holtmann.org>
From: Szymon Janc <szymon.janc@tieto.com>
To: linux-bluetooth@vger.kernel.org
Cc: Szymon Janc <szymon.janc@tieto.com>
Subject: [PATCH] monitor: Fix crash when parsing SDP
Date: Mon,  2 Jun 2014 16:33:11 +0200
Message-Id: <1401719591-5503-1-git-send-email-szymon.janc@tieto.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

get_tid() may return NULL if bogus tid is passed.
This fix following crash:

Invalid write of size 1
   at 0x4A0A643: memcpy@@GLIBC_2.14 (in /usr/lib64/valgrind/
     vgpreload_memcheck-amd64-linux.so)
   by 0x4218E4: search_attr_req (sdp.c:413)
   by 0x42214D: sdp_packet (sdp.c:748)
   by 0x41ED09: l2cap_frame (l2cap.c:2632)
   by 0x414D51: packet_hci_acldata (packet.c:7713)
   by 0x415133: packet_monitor (packet.c:3332)
   by 0x404AEC: control_reader (control.c:911)
   by 0x40231A: main (main.c:197)
 Address 0x6 is not stack'd, malloc'd or (recently) free'd

Process terminating with default action of signal 11 (SIGSEGV)
 Access not within mapped region at address 0x6
   at 0x4A0A643: memcpy@@GLIBC_2.14 (in /usr/lib64/valgrind/
     vgpreload_memcheck-amd64-linux.so)
   by 0x4218E4: search_attr_req (sdp.c:413)
   by 0x42214D: sdp_packet (sdp.c:748)
   by 0x41ED09: l2cap_frame (l2cap.c:2632)
   by 0x414D51: packet_hci_acldata (packet.c:7713)
   by 0x415133: packet_monitor (packet.c:3332)
   by 0x404AEC: control_reader (control.c:911)
   by 0x40231A: main (main.c:197)
---
 monitor/sdp.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)


TBH I'm not sure if this isn't just hiding real issue somewhere else in
monitor code...


diff --git a/monitor/sdp.c b/monitor/sdp.c
index a0ab314..8acc8bd 100644
--- a/monitor/sdp.c
+++ b/monitor/sdp.c
@@ -737,13 +737,13 @@ void sdp_packet(const struct l2cap_frame *frame, uint16_t channel)
 	print_indent(6, pdu_color, "SDP: ", pdu_str, COLOR_OFF,
 				" (0x%2.2x) tid %d len %d", pdu, tid, plen);
 
-	if (!sdp_data || !sdp_data->func) {
+	tid_info = get_tid(tid, channel);
+
+	if (!sdp_data || !sdp_data->func || !tid_info) {
 		packet_hexdump(frame->data + 5, frame->size - 5);
 		return;
 	}
 
-	tid_info = get_tid(tid, channel);
-
 	l2cap_frame_pull(&sdp_frame, frame, 5);
 	sdp_data->func(&sdp_frame, tid_info);
 }
-- 
1.9.3

