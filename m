Return-Path: <alexandre.ghisoli@ycom.ch>
Subject: Re: [Bluez-users] USB Died
From: Alexandre Ghisoli <alexandre.ghisoli@ycom.ch>
To: Marcel Holtmann <marcel@holtmann.org>
Cc: BlueZ Mailing List <bluez-users@lists.sourceforge.net>
In-Reply-To: <1089368028.4857.75.camel@pegasus>
References: <1089366625.6730.7.camel@pc-04.ycom.ch>
	 <1089368028.4857.75.camel@pegasus>
Content-Type: text/plain; charset=iso-8859-1
Message-Id: <1090229630.8193.5.camel@pc-04.ycom.ch>
Mime-Version: 1.0
Date: Mon, 19 Jul 2004 11:33:50 +0200
List-ID: <bluez-users.lists.sourceforge.net>

Le ven 09/07/2004 à 12:13, Marcel Holtmann a écrit :

Marcel, 

Again, and again, thanks for your time.


> > There is the dmesg related :
> > uhci_hcd 0000:00:10.1: host system error, PCI problems?
> > uhci_hcd 0000:00:10.1: host controller halted, very bad!
> 
> this VIA UHCI host controllers seem to be buggy in some cases. Try to
> compile your kernel without CONFIG_BT_HCIUSB_SCO.

Tested, now with -mh2, same thing. Is this related to USB stack ? If so,
I'm on the wrong list :-(

Best Regards
-- 
	Alexandre
