Return-Path: <pavouk@pavouk.org>
From: Pavel Ruzicka <pavouk@pavouk.org>
To: bluez-users@lists.sourceforge.net
Subject: Re: [Bluez-users] DBT-120 firmware upgrade
Date: Sat, 27 Nov 2004 21:30:44 +0100
Cc: Marcel Holtmann <marcel@holtmann.org>
References: <200411261152.29925.pavouk@pavouk.org> <200411271655.27322.pavouk@pavouk.org> <1101579731.27074.8.camel@pegasus>
In-Reply-To: <1101579731.27074.8.camel@pegasus>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-2"
Message-Id: <200411272130.44783.pavouk@pavouk.org>
List-ID: <bluez-users.lists.sourceforge.net>

Hello,

thanks for perfect explaining.

I have good news. I flashed my dongle, and she is not dead ;-)

Dongle now starts in HID mode. I must switch her to HCI with hid2hci.
hid2hci says something, that it fails, but it works. I have probably old 
version of this utility.
Dongle in HID mode lights with power LED, but in HCI is power LED off.
Second LED blinks in both modes.

There are informations from hciconfig:
---------------------------------
# hciconfig hci0 version
hci0:   Type: USB
        BD Address: 00:0D:88:XX:XX:XX ACL MTU: 192:8  SCO MTU: 64:8
        HCI Ver: 1.2 (0x2) HCI Rev: 0x632 LMP Ver: 1.2 (0x2) LMP Subver: 0x632
        Manufacturer: Cambridge Silicon Radio (10)
# hciconfig hci0 revision
hci0:   Type: USB
        BD Address: 00:0D:88:XX:XX:XX ACL MTU: 192:8  SCO MTU: 64:8
        Build 1586
        Chip version: BlueCore02
        Max key size: 128 bit
        SCO mapping:  HCI
[root@home network-scripts]# hciconfig hci0 features
hci0:   Type: USB
        BD Address: 00:0D:88:XX:XX:XX ACL MTU: 192:8  SCO MTU: 64:8
        Features: 0xff 0xff 0x8f 0x78 0x18 0x18 0x00 0x80
                <3-slot packets> <5-slot packets> <encryption> <slot offset>
                <timing accuracy> <role switch> <hold mode> <sniff mode>
                <park state> <RSSI> <channel quality> <SCO link> <HV2 packets>
                <HV3 packets> <u-law log> <A-law log> <CVSD> <paging scheme>
                <power control> <transparent SCO> <broadcast encrypt>
                <enhanced iscan> <interlaced iscan> <interlaced pscan>
                <inquiry with RSSI> <AFH cap. slave> <AFH class. slave>
                <AFH cap. master> <AFH class. master> <extended features>
-------------------------------

Thank you very much one more time for everything ;-)

Best regards,

Pavel Ruzicka

> > Can somebody explain me, what does it means and if it is not problem
> > for flashing?
>
> but if you upload a firmware you will get the latest type and this is 2.
>
> > Downloaded firmware is much longer than backuped. Is it OK?
>
> The GenericCSR.dfu contains two firmware files. One HCI 18.x for chips
> with 8 Mbit flash and a HCI 16.x for chips with 4 Mbit flash.
>
> Marcel
