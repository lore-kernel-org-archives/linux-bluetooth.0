Return-Path: <nils.faerber@kernelconcepts.de>
Subject: Re: [Bluez-devel] Problem with hci_usb
From: Nils Faerber <nils.faerber@kernelconcepts.de>
To: Marcel Holtmann <marcel@holtmann.org>
Cc: BlueZ Mailing List <bluez-devel@lists.sourceforge.net>
In-Reply-To: <1078248609.1942.183.camel@pegasus>
References: <1078247120.9057.85.camel@localhost>
	 <1078248609.1942.183.camel@pegasus>
Content-Type: text/plain
Message-Id: <1078252920.15993.117.camel@localhost>
Mime-Version: 1.0
Date: Tue, 02 Mar 2004 19:42:00 +0100
List-ID: <bluez-devel.lists.sourceforge.net>

Am Di, den 02.03.2004 schrieb Marcel Holtmann um 18:30:
> Hi Nils,
Hi!

> > The hci_usb in 2.6.3 must be somewhat different.
> > It reports unsupported isochronous URBs (sorry, might be wrong, this is
> > from my memory since I do not have 2.6.3 logs anymore) and disbled it at
> > device startup. No more unnecessary interrupts and especially no ERR
> > interrupts here.
> This should be fixed in 2.6.4-rc1 and 2.6.3-mh3.
> > So, are those changes also available as patch to fix the 2.4.25 driver?
> > The current 2.4.25-mh1 patch at least does not seem to include a fix for
> > this problem...
> Currently there is no real fix for it and once we have one, I have no
> plans to backport it to 2.4.

Why that?
2.4 is still the stable kernel and used by many users, so I think it
would be worth the effort.
Would you accept a patch given that someone else does the backport?

> > Apart from that, works like a charm! (Oh, I had to increase the USB
> > hub.c DEBOUNCE_TIMEOUT from 400 to 1500 to make the device detect
> > work...)
> This should be send to the USB guys.

Sure ... just mentioned it for completeness...

> Regards
> Marcel
CU
  nils faerber

-- 
kernel concepts          Tel: +49-271-771091-12
Dreisbachstr. 24         Fax: +49-271-771091-19
D-57250 Netphen          D1 : +49-170-2729106
--
