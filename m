Return-Path: <cyrus@holtmann.org>
From: "Ilia, Kolominsky" <iliak@ti.com>
To: Gustavo Padovan <padovan@profusion.mobi>
CC: "linux-bluetooth@vger.kernel.org" <linux-bluetooth@vger.kernel.org>
Date: Thu, 14 Jul 2011 11:01:23 +0200
Subject: RE: [PATCH bluetooth-next] Fixes kernel panic in incomming l2cap
 connections with defer_setup
Message-ID: <AC090B9732AB2B4DB7FF476E907FE66001318A5DDC@dnce02.ent.ti.com>
References: <1310554946-765-1-git-send-email-iliak@ti.com>
 <20110713183142.GA23921@joana>
In-Reply-To: <20110713183142.GA23921@joana>
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

> -----Original Message-----
> From: Gustavo F. Padovan [mailto:pao@profusion.mobi] On Behalf Of
> Gustavo Padovan
> Sent: Wednesday, July 13, 2011 9:32 PM
> To: ilia.kolominsky@gmail.com
> Cc: linux-bluetooth@vger.kernel.org; Ilia, Kolominsky
> Subject: Re: [PATCH bluetooth-next] Fixes kernel panic in incomming
> l2cap connections with defer_setup
> 
> Hi Ilia,
> 
> * ilia.kolominsky@gmail.com <ilia.kolominsky@gmail.com> [2011-07-13
> 14:02:26 +0300]:
> 
> > From: Ilia Kolomisnky <iliak@ti.com>
> >
> > Another fix considering incomming l2cap connections with
> > defer_setup enabled. In situations when incomming connection is
> > extracted with l2cap_sock_accept, it's bt_sock info will have
> > 'parent' member zerroed, but 'parent' may be used unconditionally
> > in l2cap_conn_start() and l2cap_security_cfm() when defer_setup
> > is enabled.
> 
> I want to see a hcidump and kernel log with dynamic debug enabled
> first.
> The fix might be somewhere else and not here.
> 
> 	Gustavo

There can be a situation that seems wrong - double signaling
( call to parent->sk_data_ready() ) when defer_setup is enabled
Due to the following path in l2cap_conn_req():

if (conn->info_state & L2CAP_INFO_FEAT_MASK_REQ_DONE) {
	if (l2cap_check_security(chan)) {
		if (bt_sk(sk)->defer_setup) {
			l2cap_state_change(chan, BT_CONNECT2);
			result = L2CAP_CR_PEND;
			status = L2CAP_CS_AUTHOR_PEND;
			parent->sk_data_ready(parent, 0);

And so, the connection can be extracted and parent nulled,
Which latter will lead to kernel panic
in l2cap_security_cfm(). 

Do I get it right that the no double signaling should
happen?

Hcidump ( on target device ):
> HCI Event: Connect Request (0x04) plen 10
    bdaddr 00:16:94:09:D5:D1 class 0x240404 type ACL
< HCI Command: Accept Connection Request (0x01|0x0009) plen 7
    bdaddr 00:16:94:09:D5:D1 role 0x00
    Role: Master
> HCI Event: Command Status (0x0f) plen 4
    Accept Connection Request (0x01|0x0009) status 0x00 ncmd 1
> HCI Event: Role Change (0x12) plen 8
    status 0x00 bdaddr 00:16:94:09:D5:D1 role 0x00
    Role: Master
> HCI Event: Connect Complete (0x03) plen 11
    status 0x00 handle 1 bdaddr 00:16:94:09:D5:D1 type ACL encrypt 0x00
> HCI Event: Page Scan Repetition Mode Change (0x20) plen 7
    bdaddr 00:16:94:09:D5:D1 mode 1
< HCI Command: Read Remote Supported Features (0x01|0x001b) plen 2
    handle 1
> HCI Event: Command Status (0x0f) plen 4
    Read Remote Supported Features (0x01|0x001b) status 0x00 ncmd 1
> HCI Event: Max Slots Change (0x1b) plen 3
    handle 1 slots 5
> HCI Event: Read Remote Supported Features (0x0b) plen 11
    status 0x00 handle 1
    Features: 0xff 0xfe 0x0f 0xc6 0x9b 0xbf 0x59 0x83
< HCI Command: Read Remote Extended Features (0x01|0x001c) plen 3
    handle 1 page 1
> HCI Event: Command Status (0x0f) plen 4
    Read Remote Extended Features (0x01|0x001c) status 0x00 ncmd 1
> HCI Event: Read Remote Extended Features (0x23) plen 13
    status 0x00 handle 1 page 1 max 1
    Features: 0x01 0x00 0x00 0x00 0x00 0x00 0x00 0x00
< HCI Command: Remote Name Request (0x01|0x0019) plen 10
    bdaddr 00:16:94:09:D5:D1 mode 2 clkoffset 0x0000
> HCI Event: Command Status (0x0f) plen 4
    Remote Name Request (0x01|0x0019) status 0x00 ncmd 1
> HCI Event: Remote Name Req Complete (0x07) plen 255
    status 0x00 bdaddr 00:16:94:09:D5:D1 name 'Sennheiser MM450'
> HCI Event: Link Key Request (0x17) plen 6
    bdaddr 00:16:94:09:D5:D1
< HCI Command: Link Key Request Reply (0x01|0x000b) plen 22
    bdaddr 00:16:94:09:D5:D1 key 2076411316B32F655BD4D52C555CBEEA
> HCI Event: Command Complete (0x0e) plen 10
    Link Key Request Reply (0x01|0x000b) ncmd 1
    status 0x00 bdaddr 00:16:94:09:D5:D1
> HCI Event: Encrypt Change (0x08) plen 4
    status 0x00 handle 1 encrypt 0x01
> ACL data: handle 1 flags 0x02 dlen 12
    L2CAP(s): Connect req: psm 25 scid 0x0045
< ACL data: handle 1 flags 0x00 dlen 16
    L2CAP(s): Connect rsp: dcid 0x0040 scid 0x0045 result 1 status 0
      Connection pending - No futher information available
< ACL data: handle 1 flags 0x00 dlen 10
    L2CAP(s): Info req: type 2
> HCI Event: Number of Completed Packets (0x13) plen 5
    handle 1 packets 2
> ACL data: handle 1 flags 0x02 dlen 16
    L2CAP(s): Info rsp: type 2 result 0
      Extended feature mask 0x0000
< HCI Command: Authentication Requested (0x01|0x0011) plen 2
    handle 1
< ACL data: handle 1 flags 0x00 dlen 16
    L2CAP(s): Connect rsp: dcid 0x0040 scid 0x0045 result 1 status 1
      Connection pending - Authentication pending
> HCI Event: Command Status (0x0f) plen 4
    Authentication Requested (0x01|0x0011) status 0x00 ncmd 1
> HCI Event: Link Key Request (0x17) plen 6
    bdaddr 00:16:94:09:D5:D1
> HCI Event: Number of Completed Packets (0x13) plen 5
    handle 1 packets 1
< ACL data: handle 1 flags 0x00 dlen 16
    L2CAP(s): Connect rsp: dcid 0x0040 scid 0x0045 result 0 status 0
      Connection successful
< ACL data: handle 1 flags 0x00 dlen 12
    L2CAP(s): Config req: dcid 0x0045 flags 0x00 clen 0
> HCI Event: Number of Completed Packets (0x13) plen 5
    handle 1 packets 2
< HCI Command: Link Key Request Reply (0x01|0x000b) plen 22
    bdaddr 00:16:94:09:D5:D1 key 2076411316B32F655BD4D52C555CBEEA
> HCI Event: Command Complete (0x0e) plen 10
    Link Key Request Reply (0x01|0x000b) ncmd 1
    status 0x00 bdaddr 00:16:94:09:D5:D1

--> Here comes  HCI Event: Auth Complete
Which triggers l2cap_seciruty_cfm which panics:

Unable to handle kernel NULL pointer dereference at virtual address 0000016c
pgd = c0004000
[0000016c] *pgd=00000000
Internal error: Oops: 17 [#1] PREEMPT SMP
last sysfs file: /sys/devices/system/cpu/cpu0/cpufreq/stats/time_in_state
Modules linked in: btwilink hidp rfcomm bluetooth gps_drv(C) fm_drv(C) st_drv
CPU: 0    Tainted: G         C   (2.6.35.7-00182-ga8b0d4f #1)
PC is at l2cap_security_cfm+0x1f0/0x2ac [bluetooth]
LR is at _raw_spin_lock+0x10/0x14
pc : [<bf02d79c>]    lr : [<c04ab96c>]    psr: 20000013
sp : efc47d90  ip : efc47d80  fp : efc47de4
r10: 00000001  r9 : ee95c400  r8 : eebc5824
r7 : ee95c430  r6 : 00000000  r5 : eebc5780  r4 : ee95c800
r3 : 0000001e  r2 : 00000040  r1 : 00000000  r0 : 00000000
Flags: nzCv  IRQs on  FIQs on  Mode SVC_32  ISA ARM  Segment kernel
Control: 10c53c7d  Table: aec0804a  DAC: 00000015

Backtrace:
[<bf02d5ac>] (l2cap_security_cfm+0x0/0x2ac [bluetooth]) from [<bf01f01c>] (hci_event_packet+0xc2c/0x4aa4 [bluetooth])
[<bf01e3f0>] (hci_event_packet+0x0/0x4aa4 [bluetooth]) from [<bf01a844>] (hci_rx_task+0xcc/0x27c [bluetooth])
[<bf01a778>] (hci_rx_task+0x0/0x27c [bluetooth]) from [<c008eee4>] (tasklet_action+0xa0/0x15c)
[<c008ee44>] (tasklet_action+0x0/0x15c) from [<c008f38c>] (__do_softirq+0x98/0x130)
 r7:00000101 r6:00000018 r5:00000001 r4:efc46000
[<c008f2f4>] (__do_softirq+0x0/0x130) from [<c008f524>] (do_softirq+0x4c/0x58)
[<c008f4d8>] (do_softirq+0x0/0x58) from [<c008f5e0>] (run_ksoftirqd+0xb0/0x1b4)
 r4:efc46000 r3:00000001
[<c008f530>] (run_ksoftirqd+0x0/0x1b4) from [<c009f2a8>] (kthread+0x84/0x8c)
 r7:00000000 r6:c008f530 r5:efc47fc4 r4:efc41f08
[<c009f224>] (kthread+0x0/0x8c) from [<c008cc84>] (do_exit+0x0/0x5f0)
 r7:00000013 r6:c008cc84 r5:c009f224 r4:efc41f08
Code: e3530000 0a000006 e5990194 e1a01006 (e590316c)
---[ end trace ddf7b97fcde50022 ]---
Kernel panic - not syncing: Fatal exception in interrupt


Regarding the dynamic debugging - that info do you need?
Is it BT_DBG() outputs?

Regards,
Ilia Kolominsky
