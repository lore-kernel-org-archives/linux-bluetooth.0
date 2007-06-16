Return-Path: <bluez-users-bounces@lists.sourceforge.net>
From: Marcel Holtmann <marcel@holtmann.org>
To: BlueZ users <bluez-users@lists.sourceforge.net>
In-Reply-To: <loom.20070613T200722-459@post.gmane.org>
References: <loom.20070613T200722-459@post.gmane.org>
Date: Sat, 16 Jun 2007 09:39:45 +0200
Message-Id: <1181979586.6846.62.camel@aeonflux.inter-touch.com>
Mime-Version: 1.0
Subject: Re: [Bluez-users] input service trouble
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

Hi Dick,

> I'm testing the new input service but I have some trouble with reconnects. If I
> don't use my dinovo keyboard or mx laser for a while the connection is closed
> and  they aren't automatically reconnected.
> 
> Sometimes a power cycle (on the HID device) helps, sometimes I need to send a
> Connect() through DBUS and sometimes I need a hciconfig hci0 reset and I also
> have some success with reloading hci_usb.
> 
> I also have error messages in dmesg:
> hci_usb_isoc_rx_submit: hci0 isoc rx submit failed urb df9a7c14 err -38
> hci_usb_isoc_rx_submit: hci0 isoc rx submit failed urb df9a7c14 err -38
> hci_usb_isoc_rx_submit: hci0 isoc rx submit failed urb f3272814 err -38
> hci_usb_isoc_rx_submit: hci0 isoc rx submit failed urb f3272814 err -38
> hci_usb_isoc_rx_submit: hci0 isoc rx submit failed urb f2d36814 err -38
> hci_usb_isoc_rx_submit: hci0 isoc rx submit failed urb f2d36814 err -38
> hci_usb_isoc_rx_submit: hci0 isoc rx submit failed urb f3272414 err -38
> hci_usb_isoc_rx_submit: hci0 isoc rx submit failed urb f3272414 err -38
> hci_usb_isoc_rx_submit: hci0 isoc rx submit failed urb f7d01014 err -38
> hci_usb_isoc_rx_submit: hci0 isoc rx submit failed urb f7d01014 err -38
> hci_usb_isoc_rx_submit: hci0 isoc rx submit failed urb df9a7a14 err -38
> hci_usb_isoc_rx_submit: hci0 isoc rx submit failed urb df9a7a14 err -38

load the hci_usb driver with isoc=0. It seems that you USB host
controller doesn't really like ISOC URBs.

> And the module usage count on hidp is high:
> $ lsmod
> Module                  Size  Used by
> hidp                   10816  26 
> hci_usb                13596  4 
> rfcomm                 28376  1 
> l2cap                  17216  18 hidp,rfcomm
> bluetooth              39588  8 hidp,hci_usb,rfcomm,l2cap

Check hcitool con and /sys/class/bluetooth/l2cap for open sockets.

> ListDevices() only gives the two devices (keyboard0 and pointing1).

How many devices do you have. I count only two. So that looks fine to
me.

> I'm using 2.6.20-gentoo-r8 (without mh patches)

We are at 2.6.22-rc4 and that is the official one with all patches.
Worth trying that one.

Regards

Marcel



-------------------------------------------------------------------------
This SF.net email is sponsored by DB2 Express
Download DB2 Express C - the FREE version of DB2 express and take
control of your XML. No limits. Just data. Click to get it now.
http://sourceforge.net/powerbar/db2/
_______________________________________________
Bluez-users mailing list
Bluez-users@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-users
