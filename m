Return-Path: <cyrus@holtmann.org>
From: Marcel Holtmann <marcel@holtmann.org>
To: BlueZ users <bluez-users@lists.sourceforge.net>
In-Reply-To: <BLU141-W9DECA08385BE097483FADD99E0@phx.gbl>
References: <BLU141-W9DECA08385BE097483FADD99E0@phx.gbl>
Date: Tue, 01 Jul 2008 07:14:42 +0200
Message-Id: <1214889282.11537.115.camel@violet.holtmann.net>
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

> > try "modprobe hci_usb reset=1". And please send us the content
> > of /proc/bus/usb/devices and what lsusb tells you.
> 
> inserting the reset on the module option works, meaning that I am able to perform hci scan
> and associate keyboard and mouse.
> 
> Here is:
> $ hcitool con
> Connections:
> > ACL 00:XX:XX:XX:XX:99 handle 12 state 1 lm MASTER
> > ACL 00:XX:XX:XX:XX:2D handle 11 state 1 lm MASTER
> 
> I wonder if a switch from hid to hci is just less "aggressive" than an adapter reset.
> Furthermore I noticed that if I just restart the computer in Linux the adapter does not switch
> back in HID mode at the next reboot, I have to perform a complete shut down and this way works.
> Is it normal?

this is how HID Proxy from Broadcom works. The CSR stuff works
different, but that's about it. I have to modify the hci_usb driver to
include a quirk for this device and then we are good.

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
