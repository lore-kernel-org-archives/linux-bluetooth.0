Return-Path: <alexandre.ghisoli@ycom.ch>
Subject: Re: [Bluez-users] USB Died
From: Alexandre Ghisoli <alexandre.ghisoli@ycom.ch>
To: Marcel Holtmann <marcel@holtmann.org>
Cc: BlueZ Mailing List <bluez-users@lists.sourceforge.net>
In-Reply-To: <1089368028.4857.75.camel@pegasus>
References: <1089366625.6730.7.camel@pc-04.ycom.ch>
	 <1089368028.4857.75.camel@pegasus>
Content-Type: text/plain; charset=iso-8859-1
Message-Id: <1089373453.6725.14.camel@pc-04.ycom.ch>
Mime-Version: 1.0
Date: Fri, 09 Jul 2004 13:44:13 +0200
List-ID: <bluez-users.lists.sourceforge.net>

Hi Marcel, 


Le ven 09/07/2004 à 12:13, Marcel Holtmann a écrit :
> Hi Alexandre,
> 
> > I'm using diNovo keyb/mice, and I always have this problem, from
> > 2.6.2-mhx to 6.7.1-mh1 and the new hipd kernel module.
> > 
> > Let me list my hardware (only the USB port I'm using for BT hub) :
> > 0000:00:10.1 USB Controller: VIA Technologies, Inc. USB (rev 80)
> > 
> > The problem is that the USB bus (?) died after some time to work (couple
> > of days), not depend what I'm doing (use keyboard, mice, or nothing).
> > 
> > There is the dmesg related :
> > uhci_hcd 0000:00:10.1: host system error, PCI problems?
> > uhci_hcd 0000:00:10.1: host controller halted, very bad!
> 
> this VIA UHCI host controllers seem to be buggy in some cases. Try to
> compile your kernel without CONFIG_BT_HCIUSB_SCO.

Huh ?
I'll try it now !
And, again, thanks for your support/time :-)

-- 
	Alexandre
