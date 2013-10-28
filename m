Return-Path: <cyrus@holtmann.org>
Message-id: <526E5C98.8020407@samsung.com>
Date: Mon, 28 Oct 2013 21:46:16 +0900
From: Seung-Woo Kim <sw0312.kim@samsung.com>
Reply-to: sw0312.kim@samsung.com
MIME-version: 1.0
To: linux-bluetooth@vger.kernel.org
Cc: Seung-Woo Kim <sw0312.kim@samsung.com>, s.syam@samsung.com
Subject: [BUG] Crash during disconnecting and removing bond from remote device
Content-type: text/plain; charset=EUC-KR
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Dear list,

I used 3.10.14 with RFCOMM tty patches in 3.12-rc, and I tested
disconnecting and removing a bond from remote device. and I got
following crash.

[   42.706670] Unable to handle kernel NULL pointer dereference at
virtual address 00000010
[   42.709197] pgd = c0004000
[   42.714500] [00000010] *pgd=00000000
[   42.715484] Internal error: Oops: 17 [#1] PREEMPT SMP ARM
[   42.720820] Modules linked in:
[   42.723879] CPU: 1 PID: 828 Comm: krfcommd Not tainted
3.10.14-gdca4b73 #340
[   42.730892] task: df03ac00 ti: df178000 task.ti: df178000
[   42.736328] PC is at l2cap_create_basic_pdu+0x30/0x1ac
[   42.741406] LR is at l2cap_chan_send+0x100/0x1d8
[   42.745997] pc : [<c05163b8>]    lr : [<c051addc>]    psr: 400f0013
[   42.745997] sp : df179d40  ip : c082daa0  fp : 00000008
[   42.757443] r10: 00000004  r9 : 0000065a  r8 : 000003f5
[   42.762652] r7 : 00000000  r6 : 00000000  r5 : df179e84  r4 : d782bc00
[   42.769162] r3 : 00000000  r2 : 00000004  r1 : df179e84  r0 : 00000000
[   42.775680] Flags: nZcv  IRQs on  FIQs on  Mode SVC_32  ISA ARM
Segment kernel
[   42.782964] Control: 10c53c7d  Table: 5f3f804a  DAC: 00000015
[   42.788693] Process krfcommd (pid: 828, stack limit = 0xdf178238)
[   42.794770] Stack: (0xdf179d40 to 0xdf17a000)
[   42.799127] 9d40: 00000000 d782bc00 00000004 df179e84 00000004
000003f5 0000065a c082f6a8
[   42.807285] 9d60: 00000008 c051addc df179e84 d782bc00 00000004
d782bdfc de6c9600 df179e84
[   42.815440] 9d80: d782bc00 00000004 d782bdfc c051fb30 00000004
dd728c00 df179e84 00000004
[   42.823600] 9da0: df179db0 df03ac00 c082f6a8 c044fffc 00000001
00000000 00000000 00000000
[   42.831735] 9dc0: 00000000 df03ac00 00000000 00000000 00000000
00000000 df179e10 00000000
[   42.839895] 9de0: 00000000 00000000 00000000 00000000 00000000
00000000 00000000 00000000
[   42.848053] 9e00: 00000000 00000000 00000000 00000000 002e4d55
00000000 00000000 00000004
[   42.856213] 9e20: dd728c00 df18ee00 00000000 df179e84 df178000
df03ac00 df18f0e4 00000000
[   42.864372] 9e40: df178000 c0012030 c07e7ff8 c005c7b0 df178000
00000000 df179e84 db45b010
[   42.872533] 9e60: 00000043 c04505cc 00000001 00000004 dfb53200
c0528f6c 00000004 dfb5320c
[   42.880690] 9e80: ffff388b 00000000 00000000 df179ea0 00000001
00000000 00000000 00000000
[   42.888850] 9ea0: df179ebc 00000004 dfb53200 c05d6854 00000000
c05291e4 c07c58c0 d7017303
[   42.897010] 9ec0: f0e3fe36 00000000 dfb53200 c052a4d8 c07e7fe0
c07e8018 db779000 dfb53200
[   42.905169] 9ee0: 00000000 c052beb0 dfb53200 dfb53500 dfb53200
de6c9600 db779000 00000000
[   42.913328] 9f00: de6c964c c052c044 dfb16880 dfb53200 dfb53200
dfb16880 dfb53200 c081eca8
[   42.921488] 9f20: c052c22c c052c124 a0000113 df178000 00000001
c082f6a8 00000000 c052c22c
[   42.929646] 9f40: 00000000 00000000 00000000 c052c294 00000000
df9d0000 df9d5ee4 df179f6c
[   42.937805] 9f60: df178000 c0049d54 00000000 00000000 c07e7ff8
00000000 00000000 00000000
[   42.945964] 9f80: df179f80 df179f80 00000000 00000000 df179f90
df179f90 df9d5ee4 c0049c9c
[   42.954123] 9fa0: 00000000 00000000 00000000 c000f168 00000000
00000000 00000000 00000000
[   42.962283] 9fc0: 00000000 00000000 00000000 00000000 00000000
00000000 00000000 00000000
[   42.970442] 9fe0: 00000000 00000000 00000000 00000000 00000013
00000000 00000000 00000000
[   42.978647] [<c05163b8>] (l2cap_create_basic_pdu+0x30/0x1ac) from
[<c051addc>] (l2cap_chan_send+0x100/0x1d8)
[   42.988428] [<c051addc>] (l2cap_chan_send+0x100/0x1d8) from
[<c051fb30>] (l2cap_sock_sendmsg+0x7c/0xd8)
[   42.997807] [<c051fb30>] (l2cap_sock_sendmsg+0x7c/0xd8) from
[<c044fffc>] (sock_sendmsg+0xac/0xcc)
[   43.006736] [<c044fffc>] (sock_sendmsg+0xac/0xcc) from [<c04505cc>]
(kernel_sendmsg+0x2c/0x34)
[   43.015345] [<c04505cc>] (kernel_sendmsg+0x2c/0x34) from [<c0528f6c>]
(rfcomm_send_frame+0x58/0x7c)
[   43.024352] [<c0528f6c>] (rfcomm_send_frame+0x58/0x7c) from
[<c05291e4>] (rfcomm_send_ua+0x98/0xbc)
[   43.033382] [<c05291e4>] (rfcomm_send_ua+0x98/0xbc) from [<c052a4d8>]
(rfcomm_recv_disc+0xac/0x100)
[   43.042405] [<c052a4d8>] (rfcomm_recv_disc+0xac/0x100) from
[<c052beb0>] (rfcomm_recv_frame+0x144/0x264)
[   43.051866] [<c052beb0>] (rfcomm_recv_frame+0x144/0x264) from
[<c052c044>] (rfcomm_process_rx+0x74/0xfc)
[   43.061327] [<c052c044>] (rfcomm_process_rx+0x74/0xfc) from
[<c052c124>] (rfcomm_process_sessions+0x58/0x160)
[   43.071221] [<c052c124>] (rfcomm_process_sessions+0x58/0x160) from
[<c052c294>] (rfcomm_run+0x68/0x110)
[   43.080614] [<c052c294>] (rfcomm_run+0x68/0x110) from [<c0049d54>]
(kthread+0xb8/0xbc)
[   43.088528] [<c0049d54>] (kthread+0xb8/0xbc) from [<c000f168>]
(ret_from_fork+0x14/0x2c)
[   43.096574] Code: e3100004 e1a07003 e5946004 1a000057 (e5969010)
[   43.110479] ---[ end trace b2b00f82e7216259 ]---

This happens because l2cap_chan_send() is called after l2cap_chan_del()
and I can easily fix this with following patch.

diff --git a/net/bluetooth/l2cap_core.c b/net/bluetooth/l2cap_core.c
index 63fa111..11b5d09 100644
--- a/net/bluetooth/l2cap_core.c
+++ b/net/bluetooth/l2cap_core.c
@@ -2452,6 +2452,9 @@ int l2cap_chan_send(struct l2cap_chan *chan,
struct msghdr *msg, size_t len,
 	int err;
 	struct sk_buff_head seg_queue;

+	if (!chan->conn)
+		return -ENOTCONN;
+
 	/* Connectionless channel */
 	if (chan->chan_type == L2CAP_CHAN_CONN_LESS) {
 		skb = l2cap_create_connless_pdu(chan, msg, len, priority);


Here is also hcidump log for operation for this issue.

$ hcidump -X
HCI sniffer - Bluetooth packet analyzer ver 2.4
device: hci0 snap_len: 1500 filter: 0xffffffff
> ACL data: handle 12 flags 0x02 dlen 8
    L2CAP(d): cid 0x0041 len 4 [psm 0]
      0000: 3b 53 01 e7                                       ;S..
< ACL data: handle 12 flags 0x00 dlen 8
    L2CAP(d): cid 0x0041 len 4 [psm 0]
      0000: 3b 73 01 cd                                       ;s..
> ACL data: handle 12 flags 0x02 dlen 8
    L2CAP(d): cid 0x0041 len 4 [psm 0]
      0000: 03 53 01 fd                                       .S..
< ACL data: handle 12 flags 0x00 dlen 8
    L2CAP(d): cid 0x0041 len 4 [psm 0]
      0000: 03 73 01 d7                                       .s..
< ACL data: handle 12 flags 0x00 dlen 12
    L2CAP(s): Disconn req: dcid 0x0041 scid 0x0041
> ACL data: handle 12 flags 0x02 dlen 12
    L2CAP(s): Disconn req: dcid 0x0041 scid 0x0041
< ACL data: handle 12 flags 0x00 dlen 12
    L2CAP(s): Disconn rsp: dcid 0x0041 scid 0x0041
> HCI Event: Number of Completed Packets (0x13) plen 5
    handle 12 packets 2
> ACL data: handle 12 flags 0x02 dlen 12
    L2CAP(s): Disconn rsp: dcid 0x0041 scid 0x0041
> HCI Event: Number of Completed Packets (0x13) plen 5
    handle 12 packets 2
> HCI Event: Disconn Complete (0x05) plen 4
    status 0x00 handle 12 reason 0x13
    Reason: Remote User Terminated Connection

Best Regards,
- Seung-Woo Kim <sw0312.kim@samsung.com>

-- 
Seung-Woo Kim
Samsung Software R&D Center
--

