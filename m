Return-Path: <cyrus@holtmann.org>
From: Toralf =?iso-8859-15?q?F=F6rster?= <toralf.foerster@gmx.de>
To: linux-bluetooth@vger.kernel.org
Subject: new kmemleak in kernel 2.6.35.4
Date: Sun, 29 Aug 2010 13:20:18 +0200
MIME-Version: 1.0
Content-Type: Text/Plain;
  charset="iso-8859-15"
Message-Id: <201008291320.19762.toralf.foerster@gmx.de>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hello

with this version I observed this kmemleak which seems to be new since 2.6.34 
at my ThinkPad T400 at an almost stable Gentoo Linux (which however might be 
rather related to suspend2ram) :

unreferenced object 0xf5333e00 (size 192):
  comm "async/29", pid 2911, jiffies 43041559 (age 24568.685s)
  hex dump (first 32 bytes):
    00 00 00 00 00 00 00 00 02 c7 34 65 e4 26 ce 11  ..........4e.&..
    00 00 00 00 00 58 f0 f5 01 00 00 00 00 00 00 00  .....X..........
  backtrace:
    [<c122f8d7>] kmemleak_alloc+0x27/0x50
    [<c109c34f>] kmem_cache_alloc+0x9f/0xe0
    [<c11d393f>] __alloc_skb+0x2f/0x100
    [<f9b4ab0c>] hci_send_cmd+0x2c/0xf0 [bluetooth]
    [<f9b4abe9>] hci_reset_req+0x19/0x20 [bluetooth]
    [<f9b4b170>] __hci_request+0x70/0xe0 [bluetooth]
    [<f9b4b338>] hci_dev_do_close+0x158/0x1b0 [bluetooth]
    [<f9b4b3cb>] hci_unregister_dev+0x3b/0xa0 [bluetooth]
    [<f9cc1a8c>] btusb_disconnect+0x4c/0xa0 [btusb]
    [<f863839b>] usb_unbind_interface+0x3b/0x160 [usbcore]
    [<c118902c>] __device_release_driver+0x4c/0xa0
    [<c1189130>] device_release_driver+0x20/0x30
    [<f86386ef>] usb_driver_release_interface+0x6f/0x80 [usbcore]
    [<f8638722>] usb_rebind_intf+0x22/0x80 [usbcore]
    [<f86387fd>] do_unbind_rebind+0x5d/0x90 [usbcore]
    [<f86388e3>] usb_resume+0xb3/0xc0 [usbcore]

-- 
MfG/Kind regards
Toralf Förster

pgp finger print: 7B1A 07F4 EC82 0F90 D4C2 8936 872A E508 7DB6 9DA3

