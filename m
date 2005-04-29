Return-Path: <bluez-users-admin@lists.sourceforge.net>
Subject: Re: [Bluez-users] hciconfig problems
From: Marcel Holtmann <marcel@holtmann.org>
To: bluez-users@lists.sourceforge.net
In-Reply-To: <1670369538@web.de>
References: <1670369538@web.de>
Content-Type: text/plain
Message-Id: <1114768646.8836.59.camel@pegasus>
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
Date: Fri, 29 Apr 2005 11:57:26 +0200

Hi Mariusz,

> I'm using Redhat with kernel 2.4.20-18.9. I use an Acer USB Bluetooth Dongle (ID 0b7a:07d0). I habe installed the latest bluez-libs followed by bluez-utils with no problem.
> 
> In my /etc/modules.conf i added:
> alias net-pf-31 bluez
> alias bt-proto-0 l2cap
> alias bt-proto-2 sco
> alias bt-proto-3 rfcomm
> alias bt-proto-4 bnep
> alias bt-proto-5 cmtp
> alias tty-ldisc-15 hci_uart
> 
> After a restart of my linux i load the hci_usb:
> >modprobe hci_usb
> 
> Start of the Host Controller:
> >hcid
> 
> hciconfig returns:
> hci0:   Type: USB
>         BD Address: 00:00:00:00:00:00 ACL MTU: 0:0 SCO MTU: 0:0
>         DOWN RUNNING
>         RX bytes:0 acl:0 sco:0 events:0 errors:0
>         TX bytes:0 acl:0 sco:0 commands:0 errors:0
> 
> lsmod returns:
> Module                  Size  Used by    Tainted: PF
> hci_usb                 9752   1
> bluez                  40260   9  [hci_usb]
> ...
> ..
> .
> 
> When i try to start hci0, then hciconfig hangsup or i get an "Speicherzugriffsfehler" (segmentation fault):
> >hciconfig hci0 up

is this a AMD64 system running a 64-bit operating system? If yes, then
you should update your kernel and the library/utilities to the latest
version.

Regards

Marcel




-------------------------------------------------------
SF.Net email is sponsored by: Tell us your software development plans!
Take this survey and enter to win a one-year sub to SourceForge.net
Plus IDC's 2005 look-ahead and a copy of this survey
Click here to start!  http://www.idcswdc.com/cgi-bin/survey?id=105hix
_______________________________________________
Bluez-users mailing list
Bluez-users@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-users
