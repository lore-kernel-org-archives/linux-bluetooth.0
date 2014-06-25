Return-Path: <cyrus@holtmann.org>
MIME-Version: 1.0
Date: Tue, 24 Jun 2014 19:27:01 -0700
Message-ID: <CABx3TkUE_qFJggDNw8wUCcQzrdo6L5p3Ag3djpiUewwk_uJu5Q@mail.gmail.com>
Subject: LE mouse reconnect problem
From: Ryan Press <ryan@presslab.us>
To: linux-bluetooth@vger.kernel.org
Content-Type: text/plain; charset=UTF-8
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

I have a Microsoft Arc mouse, Surface edition.  This uses Bluetooth
Low Energy.  Under dual boot Windows 8.1 I can connect this mouse, and
it will reconnect just fine if I turn the mouse off/on or Bluetooth
off/on.

In Fedora rawhide I have Bluez 5.18-2.  I can pair this mouse just
fine, and it will continue to work until I turn the mouse off/on or
turn the computer off/on.  Then it won't reconnect automatically.  If
I go into bluetoothctl I can connect it again and it will then work.

I looked at bluetoothd and it seems to be doing the LE scan with:
bluetoothd[2356]: src/adapter.c:trigger_passive_scanning()
bluetoothd[2356]: src/adapter.c:passive_scanning_complete() status 0x00
bluetoothd[2356]: src/adapter.c:discovering_callback() hci0 type 6 discovering 1

I look also at hcidump and I see:
< HCI Command: LE Set Random Address (0x08|0x0005) plen 6
    bdaddr 39:6D:E2:EC:17:37
> HCI Event: Command Complete (0x0e) plen 4
    LE Set Random Address (0x08|0x0005) ncmd 1
    status 0x00
< HCI Command: LE Set Scan Parameters (0x08|0x000b) plen 7
    type 0x01 (active)
    interval 11.250ms window 11.250ms
    own address: 0x01 (Random) policy: All
> HCI Event: Command Complete (0x0e) plen 4
    LE Set Scan Parameters (0x08|0x000b) ncmd 1
    status 0x00
< HCI Command: LE Set Scan Enable (0x08|0x000c) plen 2
    value 0x01 (scanning enabled)
    filter duplicates 0x01 (enabled)
> HCI Event: Command Complete (0x0e) plen 4
    LE Set Scan Enable (0x08|0x000c) ncmd 2
    status 0x00
< HCI Command: LE Set Scan Enable (0x08|0x000c) plen 2
    value 0x00 (scanning disabled)
    filter duplicates 0x00 (disabled)


It doesn't seem to be finding anything?  Is there something else I should try?

Thanks,
Ryan
