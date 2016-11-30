Return-Path: <linux-bluetooth-owner@vger.kernel.org>
MIME-Version: 1.0
From: mohammed rilwan <rilwan03@gmail.com>
Date: Wed, 30 Nov 2016 23:09:12 +0530
Message-ID: <CAMaUp9YThwzj4SxyYUd-cHej1JvHR8_pm+z6Wf6jeEP06wakyg@mail.gmail.com>
Subject: [ bluez + ofono+ pulseaudio] [Error when STARTING sco] WARN Event TRB
 for slot 3 ep 5 with no TDs qued?
To: linux-bluetooth@vger.kernel.org
Content-Type: text/plain; charset=UTF-8
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi,

I am on ubuntu 16.04.
playing audio over sco link from android device to ubuntu. PC as
headset. Everything works as expected.I can hear the audio through PC
speakers.  Unfortunately i get below error sometimes and not able to
hear the audio. Not sure why and when i get this error. couldnot
confirm the reproduction path. Anyone ahs seen this issue and solved
this ? Any help much appreciated.

I am using inbuilt bluetooth device. A realtek one.

Device Info-
root@coex:# hciconfig -a
hci0: Type: BR or EDR  Bus: USB
BD Address: DC:85:DE:FF:D9:D4  ACL MTU: 820:8  SCO MTU: 255:16
UP RUNNING PSCAN ISCAN
RX bytes:12668 acl:61 sco:152 events:147 errors:0
TX bytes:7558 acl:48 sco:154 commands:85 errors:0
Features: 0xff 0xff 0xff 0xfe 0xdb 0xff 0x7b 0x87
Packet type: DM1 DM3 DM5 DH1 DH3 DH5 HV1 HV2 HV3
Link policy: RSWITCH HOLD SNIFF PARK
Link mode: SLAVE ACCEPT
Name: 'coex_brix'
Class: 0x2c010c
Service Classes: Rendering, Capturing, Audio
Device Class: Computer, Laptop
HCI Version: 4.0 (0x6)  Revision: 0xe2f
LMP Version: 4.0 (0x6)  Subversion: 0xa041
Manufacturer: Realtek Semiconductor Corporation (93)


error logs-
...
good logs until  ofono creates AG, and successful connection
started audio play in android device , some sco connection whitenoise
started, just before the real audio i get this error
...
Nov 28 18:51:56 coex kernel: [10831.352267] xhci_hcd 0000:00:14.0:
WARN Event TRB for slot 3 ep 5 with no TDs queued?
Nov 28 18:51:56 coex kernel: [10831.353261] xhci_hcd 0000:00:14.0:
WARN Event TRB for slot 3 ep 5 with no TDs queued?
Nov 28 18:51:56 coex kernel: [10831.354269] xhci_hcd 0000:00:14.0:
WARN Event TRB for slot 3 ep 5 with no TDs queued?
Nov 28 18:51:56 coex kernel: [10831.355270] xhci_hcd 0000:00:14.0:
ERROR Transfer event TRB DMA ptr not part of current TD ep_index 5
comp_code 1
Nov 28 18:51:56 coex kernel: [10831.355273] xhci_hcd 0000:00:14.0:
Looking for event-dma 000000002acfd0e0 trb-start 000000002acfd060
trb-end 000000002acfd060 seg-start 000000002acfd000 seg-end
000000002acfdff0
Nov 28 18:51:56 coex kernel: [10831.356269] xhci_hcd 0000:00:14.0:
ERROR Transfer event TRB DMA

Thanks
Rilwan
