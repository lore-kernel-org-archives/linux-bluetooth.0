Return-Path: <bluez-users-admin@lists.sourceforge.net>
Subject: Re: [Bluez-users] USB Died
From: Marcel Holtmann <marcel@holtmann.org>
To: Alexandre Ghisoli <alexandre.ghisoli@ycom.ch>
Cc: BlueZ Mailing List <bluez-users@lists.sourceforge.net>
In-Reply-To: <1090229630.8193.5.camel@pc-04.ycom.ch>
References: <1089366625.6730.7.camel@pc-04.ycom.ch>
	 <1089368028.4857.75.camel@pegasus>  <1090229630.8193.5.camel@pc-04.ycom.ch>
Content-Type: text/plain
Message-Id: <1090229969.4400.62.camel@pegasus>
Mime-Version: 1.0
Sender: bluez-users-admin@lists.sourceforge.net
Errors-To: bluez-users-admin@lists.sourceforge.net
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-users>,
	<mailto:bluez-users-request@lists.sourceforge.net?subject=unsubscribe>
List-Id: <bluez-users.lists.sourceforge.net>
List-Post: <mailto:bluez-users@lists.sourceforge.net>
List-Help: <mailto:bluez-users-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-users>,
	<mailto:bluez-users-request@lists.sourceforge.net?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=bluez-users>
Date: Mon, 19 Jul 2004 11:39:29 +0200

Hi Alexandre,

> > > There is the dmesg related :
> > > uhci_hcd 0000:00:10.1: host system error, PCI problems?
> > > uhci_hcd 0000:00:10.1: host controller halted, very bad!
> > 
> > this VIA UHCI host controllers seem to be buggy in some cases. Try to
> > compile your kernel without CONFIG_BT_HCIUSB_SCO.
> 
> Tested, now with -mh2, same thing. Is this related to USB stack ? If so,
> I'm on the wrong list :-(

it is maybe a Linux USB problem. Try the 2.6.8-rc2 kernel and if it
still occurs ask them.

Or this is a hardware problem. Try a BIOS update. Buy yourself a new USB
PCI card without a VIA chip or better a OHCI controller on it.

Regards

Marcel




-------------------------------------------------------
This SF.Net email is sponsored by BEA Weblogic Workshop
FREE Java Enterprise J2EE developer tools!
Get your free copy of BEA WebLogic Workshop 8.1 today.
http://ads.osdn.com/?ad_id=4721&alloc_id=10040&op=click
_______________________________________________
Bluez-users mailing list
Bluez-users@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-users
