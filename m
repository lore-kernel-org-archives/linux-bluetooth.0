Return-Path: <t.schorpp@gmx.de>
Message-ID: <3FFAB0C5.4050407@gmx.de>
Date: Tue, 06 Jan 2004 13:57:41 +0100
From: "thomas.schorpp" <t.schorpp@gmx.de>
MIME-Version: 1.0
To: Marcel Holtmann <marcel@holtmann.org>
CC: BlueZ Mailing List <bluez-devel@lists.sourceforge.net>
Subject: Re: [Bluez-devel] hci_acl_tx_to: hci0 ACL tx timeout, VIA USB HUBS
References: <3FF9E3F2.4040506@gmx.de> <1073393043.2508.50.camel@pegasus>
In-Reply-To: <1073393043.2508.50.camel@pegasus>
Content-Type: text/plain; charset=us-ascii; format=flowed
List-ID: <bluez-devel.lists.sourceforge.net>

Marcel Holtmann wrote:
> Hi Thomas,
> 
> 
>>hi, yes i read the previous threads, this could be the well known 
>>problems with the via usb chips ;), it does not occur with my older p2 
>>machine. linux, pda and window$ clients kill my server after minutes:
>>
>>
>>^[[AJan  5 21:09:46 TOM1 kernel: hci_acl_tx_to: hci0 ACL tx timeout
>>Jan  5 21:09:46 TOM1 kernel: hci_acl_tx_to: hci0 killing stalled ACL 
>>connection DC:0F:A5:60:10:00
>>Jan  5 21:22:47 TOM1 pand[5823]: Accept failed. Interrupted system call(4)
>>Jan  5 21:53:36 TOM1 kernel: hci_acl_tx_to: hci0 ACL tx timeout
>>Jan  5 21:53:36 TOM1 kernel: hci_acl_tx_to: hci0 killing stalled ACL 
>>connection DC:0F:A5:60:10:00
>>
>>same with the nokia affix stack.
>>
>>cuurently i run a script detecting this error, resetting the bluetooth 
>>and restarting the daemons automatically.
>>
>>no nice way.
>>
>>there should be a way to recover that fault better, but where to start?
> 
> 
> why do you think that this is a BlueZ problem? What kernel do you use?
> What do "hciconfig -a" say about your dongle?
> 
> Regards
> 
> Marcel
> 
> 
> 
> 
> -------------------------------------------------------
> This SF.net email is sponsored by: IBM Linux Tutorials.
> Become an expert in LINUX or just sharpen your skills.  Sign up for IBM's
> Free Linux Tutorials.  Learn everything from the bash shell to sys admin.
> Click now! http://ads.osdn.com/?ad_id=1278&alloc_id=3371&op=click
> _______________________________________________
> Bluez-devel mailing list
> Bluez-devel@lists.sourceforge.net
> https://lists.sourceforge.net/lists/listinfo/bluez-devel
> 
> 

hi marcel, thx for your fast acknowledge, heres some extended 
information, i could provide a hcidump -tsw in afew hours too:

root@TOM1:~# hcid
root@TOM1:~# hciconfig -a
hci0:   Type: USB
         BD Address: 00:10:60:A5:0F:EA ACL MTU: 192:8  SCO MTU: 64:8
         UP RUNNING PSCAN ISCAN
         RX bytes:99 acl:0 sco:0 events:13 errors:0
         TX bytes:296 acl:0 sco:0 commands:12 errors:0
         Features: 0xff 0xff 0x0f 0x00
         Packet type: DM1 DM3 DM5 DH1 DH3 DH5 HV1 HV2 HV3
         Link policy: HOLD SNIFF PARK
         Link mode: ACCEPT MASTER
         Name: 'TOM1'
         Class: 0x000100
         Service Classes: Unspecified
         Device Class: Computer, Uncategorized
         HCI Ver: 1.1 (0x1) HCI Rev: 0x20d LMP Ver: 1.1 (0x1) LMP 
Subver: 0x20d
         Manufacturer: Cambridge Silicon Radio (10)

root@TOM1:~# uname -r
2.4.23
root@TOM1:~#
root@TOM1:~# lspci -v
00:00.0 Host bridge: VIA Technologies, Inc. VT8366/A/7 [Apollo KT266/A/333]
         Flags: bus master, medium devsel, latency 0
         Memory at e0000000 (32-bit, prefetchable) [size=64M]
         Capabilities: [a0] AGP version 2.0
         Capabilities: [c0] Power Management version 2

00:01.0 PCI bridge: VIA Technologies, Inc. VT8366/A/7 [Apollo 
KT266/A/333 AGP] (prog-if 00 [Normal decode])
         Flags: bus master, 66Mhz, medium devsel, latency 0
         Bus: primary=00, secondary=01, subordinate=01, sec-latency=0
         I/O behind bridge: 0000c000-0000cfff
         Memory behind bridge: ec000000-edffffff
         Prefetchable memory behind bridge: e4000000-ebffffff
         Capabilities: [80] Power Management version 2

00:09.0 Multimedia controller: Philips Semiconductors SAA7146 (rev 01)
         Subsystem: Technotrend Systemtechnik GmbH: Unknown device 0000
         Flags: bus master, medium devsel, latency 32, IRQ 7
         Memory at ee000000 (32-bit, non-prefetchable) [size=512]

00:0a.0 Ethernet controller: Realtek Semiconductor Co., Ltd. 
RTL-8139/8139C/8139C+ (rev 10)
         Subsystem: Realtek Semiconductor Co., Ltd. RT8139
         Flags: bus master, medium devsel, latency 32, IRQ 10
         I/O ports at d000 [size=256]
         Memory at ee001000 (32-bit, non-prefetchable) [size=256]
         Capabilities: [50] Power Management version 2

00:0b.0 Multimedia video controller: Brooktree Corporation Bt878 Video 
Capture (rev 02)
         Subsystem: Hauppauge computer works Inc. WinTV Series
         Flags: bus master, medium devsel, latency 32, IRQ 5
         Memory at ee002000 (32-bit, prefetchable) [size=4K]

00:0b.1 Multimedia controller: Brooktree Corporation Bt878 Audio Capture 
(rev 02)
         Subsystem: Hauppauge computer works Inc. WinTV Series
         Flags: bus master, medium devsel, latency 32, IRQ 5
         Memory at ee003000 (32-bit, prefetchable) [size=4K]

00:11.0 ISA bridge: VIA Technologies, Inc. VT8233 PCI to ISA Bridge
         Subsystem: VIA Technologies, Inc. VT8233 PCI to ISA Bridge
         Flags: bus master, stepping, medium devsel, latency 0
         Capabilities: [c0] Power Management version 2

00:11.1 IDE interface: VIA Technologies, Inc. VT82C586/B/686A/B PIPC Bus 
Master IDE (rev 06) (prog-if 8a [Master SecP PriP])
         Subsystem: VIA Technologies, Inc. VT8235 Bus Master 
ATA133/100/66/33 IDE
         Flags: bus master, medium devsel, latency 32, IRQ 11
         I/O ports at d400 [size=16]
         Capabilities: [c0] Power Management version 2

00:11.2 USB Controller: VIA Technologies, Inc. USB (rev 1b) (prog-if 00 
[UHCI])
         Subsystem: VIA Technologies, Inc. (Wrong ID) USB Controller
         Flags: bus master, medium devsel, latency 32, IRQ 5
         I/O ports at d800 [size=32]
         Capabilities: [80] Power Management version 2

00:11.3 USB Controller: VIA Technologies, Inc. USB (rev 1b) (prog-if 00 
[UHCI])
         Subsystem: VIA Technologies, Inc. (Wrong ID) USB Controller
         Flags: bus master, medium devsel, latency 32, IRQ 5
         I/O ports at dc00 [size=32]
         Capabilities: [80] Power Management version 2

00:11.4 USB Controller: VIA Technologies, Inc. USB (rev 1b) (prog-if 00 
[UHCI])
         Subsystem: VIA Technologies, Inc. (Wrong ID) USB Controller
         Flags: bus master, medium devsel, latency 32, IRQ 5
         I/O ports at e000 [size=32]
         Capabilities: [80] Power Management version 2

00:11.5 Multimedia audio controller: VIA Technologies, Inc. VT8233 AC97 
Audio Controller (rev 30)
         Subsystem: Unknown device 1695:3004
         Flags: medium devsel, IRQ 10
         I/O ports at e400 [size=256]
         Capabilities: [c0] Power Management version 2

01:00.0 VGA compatible controller: ATI Technologies Inc Radeon R250 If 
[Radeon 9000] (rev 01) (prog-if 00 [VGA])
         Subsystem: Unknown device 17c0:000f
         Flags: bus master, stepping, 66Mhz, medium devsel, latency 32, 
IRQ 11
         Memory at e4000000 (32-bit, prefetchable) [size=64M]
         I/O ports at c000 [size=256]
         Memory at ed000000 (32-bit, non-prefetchable) [size=64K]
         Expansion ROM at <unassigned> [disabled] [size=128K]
         Capabilities: [58] AGP version 2.0
         Capabilities: [50] Power Management version 2

01:00.1 Display controller: ATI Technologies Inc Radeon R250 [Radeon 
9000] (Secondary) (rev 01)
         Subsystem: Unknown device 17c0:000e
         Flags: bus master, stepping, 66Mhz, medium devsel, latency 32
         Memory at e8000000 (32-bit, prefetchable) [disabled] [size=64M]
         Memory at ed010000 (32-bit, non-prefetchable) [disabled] [size=64K]
         Capabilities: [50] Power Management version 2

root@TOM1:~#


y
tom

P.S. what linux devenv and kernel debugging env do you use? i wasted 
years with visual c++ ;)
