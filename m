Return-Path: <bluez-users-admin@lists.sourceforge.net>
Subject: Re: [Bluez-users] Driver version problems..hci_usb & bluetooth
	parser
From: Marcel Holtmann <marcel@holtmann.org>
To: BlueZ Mailing List <bluez-users@lists.sourceforge.net>
In-Reply-To: <20050222164005.71253.qmail@web26409.mail.ukl.yahoo.com>
References: <20050222164005.71253.qmail@web26409.mail.ukl.yahoo.com>
Content-Type: text/plain
Message-Id: <1109092547.8506.26.camel@pegasus>
Mime-Version: 1.0
Sender: bluez-users-admin@lists.sourceforge.net
Errors-To: bluez-users-admin@lists.sourceforge.net
Reply-To: bluez-users@lists.sourceforge.net
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-users>,
	<mailto:bluez-users-request@lists.sourceforge.net?subject=unsubscribe>
List-Id: BlueZ users <bluez-users.lists.sourceforge.net>
List-Post: <mailto:bluez-users@lists.sourceforge.net>
List-Help: <mailto:bluez-users-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-users>,
	<mailto:bluez-users-request@lists.sourceforge.net?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=bluez-users>
Date: Tue, 22 Feb 2005 18:15:47 +0100

Hi,

> I work with 2.6.10-1.766_FC3 kernel. 
> I rebuilt bluetooth.ko and hci_usb.ko using using
> those makefile:
> ---------------------------------
> #
> # Makefile for bluetooth.ko
> #
> 
> obj-m	+= bluetooth.o
> bluetooth-objs := af_bluetooth.o hci_core.o hci_conn.o
> hci_event.o hci_sock.o hci_sysfs.o lib.o
> 
> KDIR	:= /lib/modules/$(shell uname -r)/build
> PWD	:= $(shell pwd)
> default:
> 	$(MAKE) -C $(KDIR) SUBDIRS=$(PWD) modules
> ----------------------------------
> #
> # Makefile for the Linux Bluetooth HCI device drivers.
> #
> 
> obj-m	:= hci_usb.o
> 
> KDIR	:= /lib/modules/$(shell uname -r)/build
> PWD	:= $(shell pwd)
> 
> default:
> 	$(MAKE) -C $(KDIR) SUBDIRS=$(PWD) modules
> ------------------------------------- 
> 
> 
> but with this I used bluetooth files of 2.6.8 kernel.
> and before building modules I changed in
> /lib/modules/2.6.10-1.766_FC3/build/include/net
> the bluetooth directory by the 2.6.8 kernel one.
> 
> until know everyting is okay and is not blutooth
> specific.
> 
> The copilation is okay, and I put my too modules in
> the specific directories in
> /lib/modules/2.6.10-1.766_FC3/kernel
> 
> Any bluez module at this time is loaded.
> and when I run
> #modprobe bluetooth.ko
> i can see my module with lsmod.
> but when I run
> #modprobe hci_usb.ko
> I had:
> 
> FATAL: Error inserting hci_usb
> (/lib/modules/2.6.10-1.766_FC3/kernel/drivers/bluetooth/hci_usb.ko):
> Unknown symbol in module, or unknown parameter (see
> dmesg)
> 
> and I see with dmesg:
> Bluetooth: Core ver 2.6
> NET: Registered protocol family 31
> Bluetooth: HCI device and connection manager
> initialized
> Bluetooth: HCI socket layer initialized
> hci_usb: disagrees about version of symbol
> hci_free_dev
> hci_usb: Unknown symbol hci_free_dev
> hci_usb: disagrees about version of symbol
> hci_alloc_dev
> hci_usb: Unknown symbol hci_alloc_dev
> hci_usb: disagrees about version of symbol
> hci_unregister_dev
> hci_usb: Unknown symbol hci_unregister_dev
> hci_usb: disagrees about version of symbol
> hci_register_dev
> hci_usb: Unknown symbol hci_register_dev
> 
> hci_free_dev,...etc are defined in hci_core.h
> 
> bluetooth.ko use hci_core.c and hci_usb.c includes
> hci_core.h
> and If review what I deed I use thes same version of
> Hci_core for my too modulues. 
> so I don't undersand why there is a misunderstanding
> between the too modules?

use either the Fedora Core kernel or the vanilla one. Don't try to play
tricks and then complain that it does not work.

Regards

Marcel




-------------------------------------------------------
SF email is sponsored by - The IT Product Guide
Read honest & candid reviews on hundreds of IT Products from real users.
Discover which products truly live up to the hype. Start reading now.
http://ads.osdn.com/?ad_id=6595&alloc_id=14396&op=click
_______________________________________________
Bluez-users mailing list
Bluez-users@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-users
