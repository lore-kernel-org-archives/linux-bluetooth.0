Return-Path: <cyrus@holtmann.org>
Message-ID: <1224633899.48fe6e2b1e94e@webmail.vt.edu>
Date: Tue, 21 Oct 2008 20:04:59 -0400
From: Matt Witherspoon <spoon@vt.edu>
To: linux-bluetooth@vger.kernel.org
Subject: Problems & crash with Bluecore6 and SDIO driver
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hello all,

 I am trying to use an CSR Bluecore6 with the Bluetooth SDIO driver in 2.6.26
and
I'm not having much success. I can hciconfig hci0 up just fine. But any
commands after that have a low chance of succeeding and sometimes crashes the
kernel. Below is a log where I bring the interface up and run hciconfig hci0
features about once a second. As you can see, there is some weird stuff coming
back like a bogus Inquiry Complete.

 Has anyone used the Bluecore6 successfully with this driver? A Toshiba SDIO
Bluetooth card I have works fine, so SDIO appears to be working alright on my
kernel and device. I'm using a CSR BC6 dev kit so my hardware should be
okay. The BC6 is running build ID 4841 and I'm using the PXA270's
SDIO controller.

 Considering the Toshiba card works great, I'm wondering if some sort of quirk
needs to be in the driver to handle the Bluecore6? I was orginally concerned
that maybe its deep sleep feature was causing a problem because if I do
something like:
hciconfig hci0 up ; bccmd -t hci psread -s psrom
the PSkey dump works great for the first 5-6 keys then the BC6 seems to ignore
any addtional commands from bccmd or otherwise. (I thought maybe it was going
to sleep)
 I attempted to sdio_f0_writeb(func, 0x01, 0xf0, NULL) as the post from David
Vrabel suggests (http://lkml.org/lkml/2007/8/10/150) to disable deep sleep, but
it didn't help any.

 Does anyone have any experience with the Bluecore6 and the SDIO driver or any
suggestions? Thanks!

-Matt

[root@ace root]$hcidump -X -V &
[1] 906
HCI sniffer - Bluetooth packet analyzer ver 1.30
device: hci0 snap_len: 1028 filter: 0xffffffff
[root@ace root]$hciconfig hci0 up
< HCI Command: Read Local Supported Features (0x04|0x0003) plen 0
> HCI Event: Command Status (0x0f) plen 4
    Unknown (0x00|0x0000) status 0x00 ncmd 1
< HCI Command: Read Local Version Information (0x04|0x0001) plen 0
> HCI Event: Command Complete (0x0e) plen 12
    Read Local Supported Features (0x04|0x0003) ncmd 1
    status 0x00
    Features: 0xff 0xff 0x8f 0xfe 0x9b 0xff 0x59 0x83
< HCI Command: Read Buffer Size (0x04|0x0005) plen 0
> HCI Event: Command Complete (0x0e) plen 12
    Read Local Version Information (0x04|0x0001) ncmd 1
    status 0x00
    HCI Version:  (0x4) HCI Revision: 0x12e9
    LMP Version:  (0x4) LMP Subversion: 0x12e9
    Manufacturer: Cambridge Silicon Radio (10)
< HCI Command: Read BD ADDR (0x04|0x0009) plen 0
> HCI Event: Command Complete (0x0e) plen 11
    Read Buffer Size (0x04|0x0005) ncmd 1
    status 0x00
    ACL MTU 310:10 SCO MTU 64:8
< HCI Command: Read Class of Device (0x03|0x0023) plen 0
> HCI Event: Command Complete (0x0e) plen 10
    Read BD ADDR (0x04|0x0009) ncmd 1
    status 0x00 bdaddr 00:02:5B:00:A5:A5
< HCI Command: Read Local Name (0x03|0x0014) plen 0
> HCI Event: Command Complete (0x0e) plen 7
    Read Class of Device (0x03|0x0023) ncmd 1
    status 0x00 class 0x000000
< HCI Command: Read Voice Setting (0x03|0x0025) plen 0
> HCI Event: Command Complete (0x0e) plen 252
    Read Local Name (0x03|0x0014) ncmd 1
    status 0x00 name 'CSR - bc6'
< HCI Command: Set Event Filter (0x03|0x0005) plen 1
    type 0 condition 0
    Clear all filters
> HCI Event: Command Complete (0x0e) plen 6
    Read Voice Setting (0x03|0x0025) ncmd 1
    status 0x00 voice setting 0x0060
< HCI Command: Write Page Timeout (0x03|0x0018) plen 2
    timeout 32768
> HCI Event: Command Complete (0x0e) plen 4
    Set Event Filter (0x03|0x0005) ncmd 1
    status 0x00
< HCI Command: Write Connection Accept Timeout (0x03|0x0016) plen 2
    timeout 32000
> HCI Event: Command Complete (0x0e) plen 4
    Write Page Timeout (0x03|0x0018) ncmd 1
    status 0x00
< HCI Command: Write Scan Enable (0x03|0x001a) plen 1
    enable 3
> HCI Event: Command Complete (0x0e) plen 4
    Write Connection Accept Timeout (0x03|0x0016) ncmd 1
    status 0x00
> HCI Event: Command Complete (0x0e) plen 4
    Write Scan Enable (0x03|0x001a) ncmd 1
    status 0x00
[root@ace root]$hciconfig hci0 features
< HCI Command: Read Local Extended Features (0x04|0x0004) plen 1
    page 0
Can't read extended features hci0: Connection timed out (110)
[root@ace root]$hciconfig hci0 features
< HCI Command: Read Local Extended Features (0x04|0x0004) plen 1
    page 0
> HCI Event: Command Complete (0x0e) plen 14
    Read Local Extended Features (0x04|0x0004) ncmd 1
    status 0x00 page 96 max 0
    Features: 0x52 0x20 0x2d 0x20 0x62 0x63 0x36 0x00
> HCI Event: Unknown (0x00) plen 0
  0000: ff ff 8f fe 9b ff 59 83  00 00 00 00 00 00        ......Y.......
hci0:   Type: SDIO
        BD Address: 00:02:5B:00:A5:A5 ACL MTU: 310:10 SCO MTU: 64:8
        Features page 0: 0x40 0xb8 0x7c 0x9f 0xbe 0x4c 0x7c 0x9f
                <3-slot packets> <5-slot packets> <encryption> <slot offset>
                <timing accuracy> <role switch> <hold mode> <sniff mode>
                <park state> <RSSI> <channel quality> <SCO link> <HV2 packets>
                <HV3 packets> <u-law log> <A-law log> <CVSD> <paging scheme>
                <power control> <transparent SCO> <broadcast encrypt>
                <EDR ACL 2 Mbps> <EDR ACL 3 Mbps> <enhanced iscan>
                <interlaced iscan> <interlaced pscan> <inquiry with RSSI>
                <extended SCO> <EV4 packets> <EV5 packets> <AFH cap. slave>
                <AFH class. slave> <3-slot EDR ACL> <5-slot EDR ACL>
                <sniff subrating> <no. 42> <AFH cap. master>
                <AFH class. master> <EDR eSCO 2 Mbps> <EDR eSCO 3 Mbps>
                <3-slot EDR eSCO> <extended inquiry> <extended features>
< HCI Command: Read Local Extended Features (0x04|0x0004) plen 1
    page 1
> HCI Event: Inquiry Complete (0x01) plen 0
    status 0x00
    0000: 00 00 00 00 00 00 00 00  00 00 00 00 00           .............
[root@ace root]$hciconfig hci0 features
< HCI Command: Read Local Extended Features (0x04|0x0004) plen 1
    page 0
Can't read extended features hci0: Connection timed out (110)
[root@ace root]$hciconfig hci0 features
< HCI Command: Read Local Extended Features (0x04|0x0004) plen 1
    page 0
Can't read extended features hci0: Connection timed out (110)
[root@ace root]$hciconfig hci0 features
< HCI Command: Read Local Extended Features (0x04|0x0004) plen 1skb_under_panic:
 text:bf000624 len:16 put:4 head:c3f2e800 data:c3f2e7fd tail:0xc3f2e80d end:0xc3
f2e820 dev:$¦8+$¦8+

    page 0
Internal error: Oops: 817 [#1]
Modules linked in: btsdio
CPU: 0    Not tainted  (2.6.26.5 #23)
PC is at __bug+0x20/0x2c
LR is at release_console_sem+0x1bc/0x210
pc : [<c0027cfc>]    lr : [<c003d944>]    psr: 60000013
sp : c3c23ee8  ip : c3c23e18  fp : c3c23ef4
r10: 00000000  r9 : 00000000  r8 : c3c23f54
r7 : c3f2e820  r6 : c3f2e80d  r5 : c3f2e7fd  r4 : c3f2e800
r3 : 00000000  r2 : 60000013  r1 : 00000001  r0 : 00000028
Flags: nZCv  IRQs on  FIQs on  Mode SVC_32  ISA ARM  Segment kernel
Control: 0000397f  Table: a3f14000  DAC: 00000017
Process events/0 (pid: 4, stack limit = 0xc3c22270)
Stack: (0xc3c23ee8 to 0xc3c24000)
3ee0:                   c3c23f2c c3c23ef8 c01d5f08 c0027ce8 c3f2e800 c3f2e7fd
3f00: c3f2e80d c3f2e820 c3ec8c00 c3ed6520 c3f2e800 c3ed6520 c3f2e7fd c3f30178
3f20: c3c23f4c c3c23f30 c01d7070 c01d5eb8 c3c23f7c c3f30168 c3f30160 c3ed6520
3f40: c3c23f7c c3c23f50 bf000624 c01d7030 00000000 00000000 c3c23f9c c3c019e0
3f60: bf0005b0 c3c22000 00000000 00000000 c3c23f9c c3c23f80 c004dce0 bf0005bc
3f80: c3c22000 c3c019e8 c3c019e0 c3c23fa4 c3c23fd4 c3c23fa0 c004e2cc c004dc00
3fa0: 00000000 00000000 c3c14340 c0051fb8 c3c23fb0 c3c23fb0 c3c22000 c3c019e0
3fc0: c004e214 c0394570 c3c23ff4 c3c23fd8 c0051af4 c004e220 00000000 00000000
3fe0: 00000000 00000000 00000000 c3c23ff8 c00407f0 c0051aa8 ffffffff ffffffff
Backtrace:
[<c0027cdc>] (__bug+0x0/0x2c) from [<c01d5f08>] (skb_under_panic+0x5c/0x68)
[<c01d5eac>] (skb_under_panic+0x0/0x68) from [<c01d7070>] (skb_push+0x4c/0x54)
 r7:c3f30178 r6:c3f2e7fd r5:c3ed6520 r4:c3f2e800
[<c01d7024>] (skb_push+0x0/0x54) from [<bf000624>] (btsdio_work+0x74/0x118 [btsd
io])
 r6:c3ed6520 r5:c3f30160 r4:c3f30168
[<bf0005b0>] (btsdio_work+0x0/0x118 [btsdio]) from [<c004dce0>] (run_workqueue+0
xec/0x19c)
 r8:00000000 r7:00000000 r6:c3c22000 r5:bf0005b0 r4:c3c019e0
[<c004dbf4>] (run_workqueue+0x0/0x19c) from [<c004e2cc>] (worker_thread+0xb8/0x1
3c)
 r7:c3c23fa4 r6:c3c019e0 r5:c3c019e8 r4:c3c22000
[<c004e214>] (worker_thread+0x0/0x13c) from [<c0051af4>] (kthread+0x58/0x94)
 r7:c0394570 r6:c004e214 r5:c3c019e0 r4:c3c22000
[<c0051a9c>] (kthread+0x0/0x94) from [<c00407f0>] (do_exit+0x0/0x6ec)
 r7:00000000 r6:00000000 r5:00000000 r4:00000000
Code: e1a01000 e59f000c eb0a14db e3a03000 (e5833000)
---[ end trace 40aa302498565605 ]---
Can't read extended features hci0: Connection timed out (110)
[root@ace root]$
