Return-Path: <cyrus@holtmann.org>
Date: Mon, 21 Oct 2013 23:58:10 +0200
From: Pavel Machek <pavel@ucw.cz>
To: "alexandre@maloteaux.net" <alexandre@maloteaux.net>,
	marcel@holtmann.org, gustavo@padovan.org,
	linux-bluetooth@vger.kernel.org
Subject: Re: Issue with the kernel  bluetooth  HCI_Delete_Stored_Link_Key
 command patch
Message-ID: <20131021215809.GA25421@amd.pavel.ucw.cz>
References: <413864804.130358.1382295198929.open-xchange@oxwebmail.registrar-servers.com>
 <20131021184839.GA10592@amd.pavel.ucw.cz>
 <20131021192021.GA19575@x220.p-661hnu-f1>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20131021192021.GA19575@x220.p-661hnu-f1>
List-ID: <linux-bluetooth.vger.kernel.org>

Hi!

> > > old 2.0 as it was written "Vista Compatible" on the box : Bus 004
> > > Device 004: ID 0a12:0001 Cambridge Silicon Radio, Ltd Bluetooth
> > > Dongle (HCI mode)
> <snip>
> > > < HCI Command: Read Local Version Information (0x04|0x0001) plen 0
> > > > HCI Event: Command Complete (0x0e) plen 12
> > >     Read Local Version Information (0x04|0x0001) ncmd 1
> > >     status 0x00
> > >     HCI Version: 2.0 (0x3) HCI Revision: 0x3000
> > >     LMP Version: 2.0 (0x3) LMP Subversion: 0x420b
> > >     Manufacturer: Broadcom Corporation (15)
> > > < HCI Command: Read BD ADDR (0x04|0x0009) plen 0
> > > > HCI Event: Command Complete (0x0e) plen 10
> > >     Read BD ADDR (0x04|0x0009) ncmd 1
> > >     status 0x00 bdaddr 00:19:86:00:19:C2
> > > < HCI Command: Read Buffer Size (0x04|0x0005) plen 0
> > > > HCI Event: Command Complete (0x0e) plen 11
> > >     Read Buffer Size (0x04|0x0005) ncmd 1
> > >     status 0x00
> > >     ACL MTU 1017:8 SCO MTU 64:0
> > > < HCI Command: Read Class of Device (0x03|0x0023) plen 0
> > > > HCI Event: Command Complete (0x0e) plen 7
> > >     Read Class of Device (0x03|0x0023) ncmd 1
> > >     status 0x00 class 0x000000
> > > < HCI Command: Read Local Name (0x03|0x0014) plen 0
> > > > HCI Event: Command Complete (0x0e) plen 252
> > >     Read Local Name (0x03|0x0014) ncmd 1
> > >     status 0x00 name 'BCM2045B'
> 
> There is something very strange in this hardware if it's reporting
> Broadcom on HCI but CSR over USB. Considering that these two companies
> are competitors I'd be inclined to think this HW is by neither one, i.e.
> possibly counterfeit. This, combined with the fact that it's not
> compliant with the Bluetooth specification, is not very likely to
> inspire efforts to get it fixed.

Actually, could you verify that it worked ok in some older kernel? If
so, it definitely _needs_ to be fixed.
									Pavel
-- 
(english) http://www.livejournal.com/~pavelmachek
(cesky, pictures) http://atrey.karlin.mff.cuni.cz/~pavel/picture/horses/blog.html
