Return-Path: <cyrus@holtmann.org>
From: Marcel Holtmann <marcel@holtmann.org>
To: BlueZ users <bluez-users@lists.sourceforge.net>
In-Reply-To: <BLU141-W22D2691CD07EA18D07469AD9A20@phx.gbl>
References: <BLU141-W22D2691CD07EA18D07469AD9A20@phx.gbl>
Date: Sat, 28 Jun 2008 00:27:05 +0200
Message-Id: <1214605625.11537.7.camel@violet.holtmann.net>
Mime-Version: 1.0
Subject: Re: [Bluez-users] FW: hid2hci for the new iMAC
Reply-To: BlueZ users <bluez-users@lists.sourceforge.net>
List-Id: BlueZ users <bluez-users.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-users>,
	<mailto:bluez-users-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=bluez-users>
List-Post: <mailto:bluez-users@lists.sourceforge.net>
List-Help: <mailto:bluez-users-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-users>,
	<mailto:bluez-users-request@lists.sourceforge.net?subject=subscribe>
Content-Type: text/plain; charset="us-ascii"
Sender: bluez-users-bounces@lists.sourceforge.net
Errors-To: bluez-users-bounces@lists.sourceforge.net

Hi Axel,

> I've looked around but it seems there is no one having faced this problem: I have a new 24" iMac (Core 2 Duo) with integrated bluetooth (Broadcom 2045).
> Starting with Linux (2.6.24, bluez ver. 3.30) I am unable to switch the bluetooth HID device to HCI.
> 
> This is my lsusb:
> 
> root@uranus:~# lsusb -t
> Bus#  7
> `-Dev#   1 Vendor 0x1d6b Product 0x0002
>   `-Dev#   2 Vendor 0x05ac Product 0x8502
> Bus#  6
> `-Dev#   1 Vendor 0x1d6b Product 0x0002
> Bus#  5
> `-Dev#   1 Vendor 0x1d6b Product 0x0001
>   `-Dev#   2 Vendor 0x05ac Product 0x8242
> Bus#  4
> `-Dev#   1 Vendor 0x1d6b Product 0x0001
> Bus#  3
> `-Dev#   1 Vendor 0x1d6b Product 0x0001
> Bus#  2
> `-Dev#   1 Vendor 0x1d6b Product 0x0001
> Bus#  1
> `-Dev#   1 Vendor 0x1d6b Product 0x0001
>   `-Dev#   3 Vendor 0x0a5c Product 0x4500
>     |-Dev#   4 Vendor 0x05ac Product 0x820f
>     |-Dev#   5 Vendor 0x05ac Product 0x820a
>     `-Dev#   6 Vendor 0x05ac Product 0x820b
> 
> Where the 820f is the Apple Bluetooth device and the 820a is the HID keyobard and the 820b is the HID mouse (both bluetooth).
> 
> I have tried to add 820f id to the hid2hci.c with switch_hidproxy but it didn't go through.
> 
> If I reset the hci device the lsusb output does not change (as was in the previous mac case). That's why I guess something has been changed in BT implementation and the previous method does not apply.
>  
> Now how can I find the way to switch the device in HCI? in other word how can I write (in case is necessary) the switch_imac procedure?

try "modprobe hci_usb reset=1". And please send us the content
of /proc/bus/usb/devices and what lsusb tells you.

Regards

Marcel



-------------------------------------------------------------------------
Check out the new SourceForge.net Marketplace.
It's the best place to buy or sell services for
just about anything Open Source.
http://sourceforge.net/services/buy/index.php
_______________________________________________
Bluez-users mailing list
Bluez-users@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-users
