Return-Path: <cyrus@holtmann.org>
From: =?UTF-8?q?Fr=C3=A9d=C3=A9ric=20Danis?=
	<frederic.danis@linux.intel.com>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH] monitor: Fix crash in btmon
Date: Wed, 19 Dec 2012 14:20:01 +0100
Message-Id: <1355923202-16648-1-git-send-email-frederic.danis@linux.intel.com>
Content-Type: text/plain; charset="utf-8"
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

When retrieving SDP records from keyboard btmon crashes (see below).

The tid_list in sdp.c is filled up by SDP Service search request,
as Service Search responses are treated as invalid and do not free
tid_list entries.

This is due to passing last fragment instead of complete frame to
l2cap_frame().



< ACL Data TX: Handle 11 flags 0x00 dlen 26                                                                                                                                                       [hci0] 24.082133
      Channel: 511 len 22 [PSM 1 mode 0] {chan 0}
      SDP: Service Search Attribute Request (0x06) tid 14 len 17
        Search pattern: [len 5]
          Sequence (6) with 3 bytes [8 extra bits] len 5
            UUID (3) with 2 bytes [0 extra bits] len 3
              L2CAP (0x0100)
        Max record count: 65535
        Attribute list: [len 7]
          Sequence (6) with 5 bytes [8 extra bits] len 7
            Unsigned Integer (1) with 4 bytes [0 extra bits] len 5
              0x0000ffff
        Continuation state: 2
        00 1d                                            ..
> HCI Event: Number of Completed Packets (0x13) plen 5                                                                                                                                            [hci0] 24.085458
        Num handles: 1
        Handle: 11
        Count: 2
> ACL Data RX: Handle 11 flags 0x02 dlen 27                                                                                                                                                       [hci0] 24.102205
> ACL Data RX: Handle 11 flags 0x01 dlen 14                                                                                                                                                       [hci0] 24.103339
      Channel: 64 len 37 [PSM 1 mode 0] {chan 0}
        invalid frame size
        23 03 09 02 04 28 01 09 02 05 09 00 02 00 09 04  #....(..........
        6d 09 02 02 09 b3 01 09 02 03 09 64 00 00 00 00  m..........d....
        00 00 00 00 00                                   .....
< ACL Data TX: Handle 11 flags 0x00 dlen 24                                                                                                                                                       [hci0] 24.170595
      Channel: 511 len 20 [PSM 1 mode 0] {chan 0}
      SDP: Service Search Attribute Request (0x06) tid 15 len 15
        Search pattern: [len 5]
          Sequence (6) with 3 bytes [8 extra bits] len 5
            UUID (3) with 2 bytes [0 extra bits] len 3
              PnP Information (0x1200)
        Max record count: 65535
        Attribute list: [len 7]
          Sequence (6) with 5 bytes [8 extra bits] len 7
            Unsigned Integer (1) with 4 bytes [0 extra bits] len 5
              0x0000ffff
        Continuation state: 0
> ACL Data RX: Handle 11 flags 0x02 dlen 27                                                                                                                                                       [hci0] 24.192217
> ACL Data RX: Handle 11 flags 0x01 dlen 25                                                                                                                                                       [hci0] 24.193327
      Channel: 64 len 48 [PSM 1 mode 0] {chan 0}
        invalid frame size
        01 35 03 19 12 00 09 00 04 35 0d 35 06 19 01 00  .5.......5.5....
        09 00 01 35 03 19 02 00 32 09 00 64 00 00 00 00  ...5....2..d....
        00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00  ................
< ACL Data TX: Handle 11 flags 0x00 dlen 26                                                                                                                                                       [hci0] 24.205765
      Channel: 511 len 22 [PSM 1 mode 0] {chan 0}
      SDP: Service Search Attribute Request (0x06) tid 16 len 17
        Search pattern: [len 5]
          Sequence (6) with 3 bytes [8 extra bits] len 5
            UUID (3) with 2 bytes [0 extra bits] len 3
              PnP Information (0x1200)
        Max record count: 65535
        Attribute list: [len 7]
          Sequence (6) with 5 bytes [8 extra bits] len 7
            Unsigned Integer (1) with 4 bytes [0 extra bits] len 5
              0x0000ffff

Program received signal SIGSEGV, Segmentation fault.
__memcpy_ssse3_back () at ../sysdeps/x86_64/multiarch/memcpy-ssse3-back.S:2184
2184	../sysdeps/x86_64/multiarch/memcpy-ssse3-back.S: No such file or directory.
(gdb) bt
#0  __memcpy_ssse3_back () at ../sysdeps/x86_64/multiarch/memcpy-ssse3-back.S:2184
#1  0x0000000000418607 in search_attr_req (frame=0x7fffffffdff0, tid=0x0) at /usr/include/x86_64-linux-gnu/bits/string3.h:52
#2  0x0000000000418ebb in sdp_packet (frame=0x7fffffffe0e0, channel=0) at monitor/sdp.c:743
#3  0x000000000041547e in l2cap_frame (index=<optimised out>, in=<optimised out>, handle=<optimised out>, cid=<optimised out>, data=0x6370d0, size=22) at monitor/l2cap.c:2161
#4  0x000000000040f8c4 in packet_hci_acldata (tv=0x7fffffffe330, index=0, in=false, data=0x6370cc, size=26) at monitor/packet.c:4812
#5  0x000000000040fd35 in packet_monitor (tv=0x7fffffffe330, index=0, opcode=<optimised out>, data=0x6370c8, size=<optimised out>) at monitor/packet.c:1839
#6  0x0000000000403da2 in data_callback (user_data=0x6370c0, fd=<optimised out>, events=<optimised out>) at monitor/control.c:599
#7  data_callback (fd=<optimised out>, events=<optimised out>, user_data=0x6370c0) at monitor/control.c:541
#8  0x00000000004021c4 in mainloop_run () at monitor/mainloop.c:142
#9  0x0000000000401c7c in main (argc=1, argv=0x7fffffffe5f8) at monitor/main.c:154
---
 monitor/l2cap.c |    3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/monitor/l2cap.c b/monitor/l2cap.c
index e982bdd..dc4d8ea 100644
--- a/monitor/l2cap.c
+++ b/monitor/l2cap.c
@@ -2250,7 +2250,8 @@ void l2cap_packet(uint16_t index, bool in, uint16_t handle, uint8_t flags,
 			/* complete frame */
 			l2cap_frame(index, in, handle,
 					index_list[index].frag_cid,
-					data, index_list[index].frag_pos);
+					index_list[index].frag_buf,
+					index_list[index].frag_pos);
 			clear_fragment_buffer(index);
 			return;
 		}
-- 
1.7.9.5

