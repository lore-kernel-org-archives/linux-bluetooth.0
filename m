Return-Path: <cyrus@holtmann.org>
MIME-Version: 1.0
In-Reply-To: <5d223510906150524v6603fb2axfaf0331eddb2e52a@mail.gmail.com>
References: <5d223510906150524v6603fb2axfaf0331eddb2e52a@mail.gmail.com>
Date: Wed, 17 Jun 2009 09:27:57 -0300
Message-ID: <5d223510906170527y65e3cec7p86fd2c8663239221@mail.gmail.com>
Subject: Re: Bluez issue on an ARM based processor
From: Rafael Seste <rseste@gmail.com>
To: linux-bluetooth@vger.kernel.org
Content-Type: text/plain; charset=ISO-8859-1
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi all,

On Mon, Jun 15, 2009 at 9:24 AM, Rafael Seste<rseste@gmail.com> wrote:
> Hi all,
>
> Has anybody tried to use Bluez on an __ARM__ based computer?
>
> I'm trying to use HSP and HFP on a SheevaPlug developed by Marvell,
> but the audio is very choppy.
>
> I installed the new kernel 2.6.30-rc8 and bluez 4.41
> #uname -a
> Linux debian 2.6.30-rc8 #3 PREEMPT Thu Jun 4 16:36:21 BRT 2009
> armv5tel GNU/Linux
>
> I tested with a Motorola MotoROKR U9 bluetooth headset. I played a wav
> file using aplay and then recorded my voice using arecord. On both
> cases I got a choppy audio.
>
> I tested with 3 different dongles two from Cambridge Silicon Radio and
> one from Integrated System Solution Corp, in all cases I had the same
> result. (choppy audio)
> I tested the same setup on a x86 and it works perfectly.
>
> here is the description of one of then,
>
> ~# lsusb
> Bus 001 Device 004: ID 0a12:0001 Cambridge Silicon Radio, Ltd
> Bluetooth Dongle (HCI mode)
>
> ~# hciconfig -a
> hci0: а Type: USB
> а а а BD Address: 00:10:60:30:1A:2D ACL MTU: 384:8 SCO MTU: 64:8
> а а а UP RUNNING PSCAN
> а а а RX bytes:241992 acl:145 sco:3608 events:486 errors:148
> а а а TX bytes:170455 acl:157 sco:3291 commands:235 errors:31
> а а а Features: 0xff 0xff 0x8f 0xfe 0x9b 0xf9 0x00 0x80
> а а а Packet type: DM1 DM3 DM5 DH1 DH3 DH5 HV1 HV2 HV3
> а а а Link policy: RSWITCH HOLD SNIFF PARK
> а а а Link mode: SLAVE ACCEPT
> а а а Name: 'Sheeva01'
> а а а Class: 0x4a0204
> а а а Service Classes: Networking, Capturing, Telephony
> а а а Device Class: Phone, Cellular
> а а а HCI Ver: 2.0 (0x3) HCI Rev: 0x7a6 LMP Ver: 2.0 (0x3) LMP Subver: 0x7a6
> а а а Manufacturer: Cambridge Silicon Radio (10)
>
> One thing that I noticed is that the class is different from the one
> configured in main.conf
>
> # Default device class. Only the major and minor device class bits are
> # considered.
> Class = 0x100204
>
> ~# hciconfig hci0 revision
> hci0: а Type: USB
> а а а BD Address: 00:10:60:30:1A:2D ACL MTU: 384:8 SCO MTU: 64:8
> а а а HCI 19.2
> а а а Chip version: BlueCore4-ROM
> а а а Max key size: 128 bit
> а а а SCO mapping: аHCI
>
> when I plugged the dongle I got the the following error on syslog
> usb 1-1: device descriptor read/64, error -71
>
> I attached a dump file made with hcidump when I was playing a .wav
> The output shows a lot of malformed packets and packets with wrong
> length (different from 48 bytes).
>
> when I tried to record my voice, I had similar problems, except that
> the syslog was flood by the messages below.
>
> Jun а9 12:37:54 debian kernel: hci_scodata_packet: hci0 SCO packet for
> unknown connection handle 45309
> Jun а9 12:37:54 debian kernel: hci_scodata_packet: hci0 SCO packet for
> unknown connection handle 65360
> Jun а9 12:37:54 debian kernel: btusb_isoc_complete: hci0 corrupted SCO packet
> Jun а9 12:37:54 debian kernel: hci_scodata_packet: hci0 SCO packet for
> unknown connection handle 119
> Jun а9 12:37:54 debian kernel: hci_scodata_packet: hci0 SCO packet for
> unknown connection handle 56834
> Jun а9 12:37:54 debian kernel: hci_scodata_packet: hci0 SCO packet for
> unknown connection handle 282
> Jun а9 12:37:54 debian kernel: btusb_isoc_complete: hci0 corrupted SCO packet
> Jun а9 12:37:54 debian kernel: hci_scodata_packet: hci0 SCO packet for
> unknown connection handle 65133
> Jun а9 12:37:54 debian kernel: hci_scodata_packet: hci0 SCO packet for
> unknown connection handle 3072
> Jun а9 12:37:54 debian kernel: hci_scodata_packet: hci0 SCO packet for
> unknown connection handle 42241
> Jun а9 12:37:54 debian kernel: hci_scodata_packet: hci0 SCO packet for
> unknown connection handle 65236
> Jun а9 12:37:54 debian kernel: hci_scodata_packet: hci0 SCO packet for
> unknown connection handle 65528
> Jun а9 12:37:55 debian kernel: hci_scodata_packet: hci0 SCO packet for
> unknown connection handle 65294
> Jun а9 12:37:55 debian kernel: hci_scodata_packet: hci0 SCO packet for
> unknown connection handle 49665
> Jun а9 12:37:55 debian kernel: hci_scodata_packet: hci0 SCO packet for
> unknown connection handle 43521
> Jun а9 12:37:55 debian kernel: hci_scodata_packet: hci0 SCO packet for
> unknown connection handle 56577
> Jun а9 12:37:55 debian kernel: hci_scodata_packet: hci0 SCO packet for
> unknown connection handle 61
> Jun а9 12:37:55 debian kernel: hci_scodata_packet: hci0 SCO packet for
> unknown connection handle 41215
>
>
> Has anybody similar problems? or somebody knows why this is happening
> and how to solve?
>
> Where can I start to find why this is happening??
>
> tks
>
> --
> Rafael S. Seste
>

Did anybody try to install bluez on an ARM?

Could anybody help me to solve this issue?

tks

-- 
Rafael S. Seste
Eng Computaчуo - Unicamp
