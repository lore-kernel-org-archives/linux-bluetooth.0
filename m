Return-Path: <bluez-users-bounces@lists.sourceforge.net>
From: Marcel Holtmann <marcel@holtmann.org>
To: BlueZ users <bluez-users@lists.sourceforge.net>
In-Reply-To: <200710212313.40126.flyzone@technologist.com>
References: <200710212313.40126.flyzone@technologist.com>
Date: Mon, 22 Oct 2007 11:25:42 +0200
Message-Id: <1193045142.6184.162.camel@violet>
Mime-Version: 1.0
Subject: Re: [Bluez-users] DBT120 B4 not working
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

Hi,

> I have a bluetooth device D-link DBT120 revision B4 with a kernel 2.6.18
> with a debian etch stable (bluez-hcidump-1.32-1, bluez-utils-3.7.1, 
> bluez-firmware-1.2-1 and other package for kde).
> 
> on messages:
> kernel: usb 5-1.4: new full speed USB device using ehci_hcd and address 6
> kernel: usb 5-1.4: configuration #1 chosen from 1 choice
> kernel: Bluetooth: HCI USB driver ver 2.9
> kernel: usbcore: registered new driver hci_usb
> on syslog:
> kernel: hci_usb_intr_rx_submit: hci0 intr rx submit failed urb cdcb6654 
> err -28
> kernel: hci_usb_intr_rx_submit: hci0 intr rx submit failed urb f4b749d4 
> err -28
> 
> lsusb show:
> Bus 005 Device 010: ID 0a12:0001 Cambridge Silicon Radio, Ltd Bluetooth Dongle 
> (HCI mode)
> 
> hciconfig:
> hci0:   Type: USB
>         BD Address: 00:00:00:00:00:00 ACL MTU: 0:0 SCO MTU: 0:0
>         DOWN 
>         RX bytes:0 acl:0 sco:0 events:0 errors:0
>         TX bytes:0 acl:0 sco:0 commands:0 errors:0
> hciconfig hci0 up
> Can't init device hci0: Input/output error (5)
> 
> strace hciconfig hci0 up:
>  socket(PF_BLUETOOTH, SOCK_RAW, 1)       = 3
>  ioctl(3, 0x800448d3, 0x805d300)         = 0
>  ioctl(3, 0x400448c9, 0)                 = -1 EIO (Input/output error)
>  write(2, "Can\'t init device hci0: Input/ou"..., 47Can't init device hci0:
>  Input/output error (5)
> 
> I have a motherboard with VIA VT82 UHCI USB controller...in the past mail i 
> read about a user "Marcel Holtmann" having the same problem with kernel 2.6.5 
> but i cannot find the earlier post with the solution...

use a newer kernel. The 2.6.5 is ancient and most USB issues have been
fixed. However this is not really a Bluetooth issue. It is an USB
problem or hardware problem. And to make it clear. It is not the dongle.
I have a bunch of them, they work.

Regards

Marcel



-------------------------------------------------------------------------
This SF.net email is sponsored by: Splunk Inc.
Still grepping through log files to find problems?  Stop.
Now Search log events and configuration files using AJAX and a browser.
Download your FREE copy of Splunk now >> http://get.splunk.com/
_______________________________________________
Bluez-users mailing list
Bluez-users@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-users
