Return-Path: <nils.faerber@kernelconcepts.de>
Subject: Re: [Bluez-devel] sco link help needed
From: Nils Faerber <nils.faerber@kernelconcepts.de>
To: Marcel Holtmann <marcel@holtmann.org>
Cc: BlueZ Mailing List <bluez-devel@lists.sourceforge.net>
In-Reply-To: <1077729384.2919.120.camel@pegasus>
References: <4034CA08.50500@soft.uni-linz.ac.at>
	 <200402251359.00791.mtortonesi@ing.unife.it>
	 <1077715546.2919.77.camel@pegasus>
	 <200402251504.47809.mtortonesi@ing.unife.it>
	 <1077719012.2919.94.camel@pegasus>  <1077728432.6021.522.camel@localhost>
	 <1077729384.2919.120.camel@pegasus>
Content-Type: text/plain
Message-Id: <1077730057.8977.526.camel@localhost>
Mime-Version: 1.0
Date: Wed, 25 Feb 2004 18:27:37 +0100
List-ID: <bluez-devel.lists.sourceforge.net>

Am Mi, den 25.02.2004 schrieb Marcel Holtmann um 18:16:
> Hi Nils,
Hi!

> > > Is the PCM mapping of both dongles set to HCI? What kernel version do
> > > you use?
> > And if it isn't?
> > I searched the archive but could not find a way to change it.
> > Or is this fixed in the firmware? This would be a pity...
> > I have just got a Fujitsu-Siemens Lifebook with builtin Blueooth (CSR
> > chipset BlueCore01b, HCI 12.3) which reports SCOmapping to PCM...
> the SCO mapping is a PSKEY like everything else. It is the same as for
> the host transport or the UART setttings. You can change it if you know
> how. Actually I don't provide any source code that is capable of
> changing PSKEY's.

Oh well ;)
Many thanks for the info anyway...

> Regards
> Marcel
CU
  nils faerber

-- 
kernel concepts          Tel: +49-271-771091-12
Dreisbachstr. 24         Fax: +49-271-771091-19
D-57250 Netphen          D1 : +49-170-2729106
--
