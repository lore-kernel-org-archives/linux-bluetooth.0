Return-Path: <linux-bluetooth-owner@vger.kernel.org>
Date: Wed, 15 Feb 2017 17:05:14 +0300
From: Andrew Kanner <kanner@mail.ru>
To: linux-bluetooth@vger.kernel.org
Subject: Elektex bluetooth keyboard incorrect device class
Message-ID: <20170215140513.GA19149@localhost>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

I'm trying to get Elektex (G-Tech) Bluetooth Smart Fabric keyboard
work on Linux (latest kernel).

This keyboard have been supported by Android devices via some
unofficial apk (I only found footprints of using some Bluez functions
and native Android keyboard + device key mapping in sources). But when
I tried to connect it to Linux, I saw that it's device class is
0x500204 (like a cell phone) in btmon output and it's naturally not
determined as a HID device.

Could someone direct me how to get this keyboard work like HID device?
Where should I start from?

Here is some minimal info about the device:

# hcitool scan
Scanning ...
        00:16:C1:00:6A:C8       keyboard
# sudo hcitool info 00:16:C1:00:6A:C8
Requesting information ...
        BD Address:  00:16:C1:00:6A:C8
        OUI Company: Eleksen Ltd (00-16-C1)
        Device Name: keyboard
        LMP Version: 1.1 (0x1) LMP Subversion: 0x5e1
        Manufacturer: Cambridge Silicon Radio (10)
        Features: 0xff 0xff 0x00 0x00 0x00 0x00 0x00 0x00
                <3-slot packets> <5-slot packets> <encryption> <slot offset>
                <timing accuracy> <role switch> <hold mode> <sniff mode>
                <park state> <RSSI> <channel quality> <SCO link> <HV2 packets>
                <HV3 packets> <u-law log> <A-law log>
# sudo hcitool cc --role=m 00:16:C1:00:6A:C8
Connections:
        < ACL 00:16:C1:00:6A:C8 handle 21 state 1 lm MASTER
# sudo hcitool con

(latest command return active connections, but after several seconds
the device is disconnected by host)

--
With best regards,
Andrew Kanner
