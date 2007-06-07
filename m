Return-Path: <bluez-users-bounces@lists.sourceforge.net>
From: Marcel Holtmann <marcel@holtmann.org>
To: BlueZ users <bluez-users@lists.sourceforge.net>
In-Reply-To: <1831337479@web.de>
References: <1831337479@web.de>
Date: Thu, 07 Jun 2007 12:22:46 +0200
Message-Id: <1181211767.13429.170.camel@violet>
Mime-Version: 1.0
Subject: Re: [Bluez-users] bluez-utils on old kernel
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

Hi Philipp,

> I'm still tring to get my bluetooth working.
> Then I plugin the stick it is correct show when I run lsusb.
> 
> Bus 001 Device 002: ID 0a5c:2101 Broadcom Corp.

include the content of /proc/bus/usb/devices.

> Next I start to load the modules:
> 
> insmod
>   bluetooth
>   sco
>   l2cap
>   rfcomm
>   hci_uart
>   hci_vhci
>   firmware_class
>   hidp
>   bcm203x
>   hci_usb
> 
> but when the last module is loaded I get a segmentation fault

>>From what? Include information about it.

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
