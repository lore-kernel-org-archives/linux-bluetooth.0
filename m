Return-Path: <cyrus@holtmann.org>
Subject: Re: Wacom Graphire Bluetooth HID driver - help needed
From: Marcel Holtmann <marcel@holtmann.org>
To: Bastien Nocera <hadess@hadess.net>
Cc: =?UTF-8?Q?Przemys=C5=82aw?= Firszt <przemo@firszt.eu>,
	linux-bluetooth@vger.kernel.org
In-Reply-To: <1244377549.30768.5467.camel@cookie.hadess.net>
References: <1243543413.21667.23.camel@pldmachine>
	 <1243549749.21144.816.camel@cookie.hadess.net>
	 <1243588429.4951.22.camel@pldmachine>
	 <1244377549.30768.5467.camel@cookie.hadess.net>
Content-Type: text/plain
Date: Sun, 07 Jun 2009 17:53:22 +0200
Message-Id: <1244390002.23850.105.camel@localhost.localdomain>
Mime-Version: 1.0
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Bastien,

> > > > I'm working on Wacom Graphire bluetooth tablet driver.
> > > 
> > > I already posted patches to linux-input and linux-bluetooth with support
> > > for that, and it's merged into Fedora 11.
> > > 
> > > Check that code, and let me know whether you have any comments on the
> > > code.
> > 
> > I'm trying completly different way (redefining the device report and
> > mapping), but the problems (mode 2 and turning tablet twice to get it
> > working) are similar.
> 
> The second problem seems to be fixed by recent kernels for me.
> 
> >  Did you get any reply that this patch is going to
> > be included in mainstream?
> 
> I believe it was supposed to be merged by now. Jiri?
> 
> > Do you know what was the reason of that error -14 ? (see here for the
> > details: http://marc.info/?l=linux-bluetooth&m=123724912027050&w=2 )
> > I still have that problem...
> 
> Don't know. I guess having the device mode 2 setup in the kernel would
> avoid this sort of problems.
> 
> > I've to check your bluetoothd patch - do you know if it's going to be
> > included or the developers are waiting for required changes in kernel? 
> > I hope that it could sort out the ugly hack in hidp.
> 
> The bluetoothd patch works around the missing hid write support in the
> Bluetooth hid stack. It could be moved to the kernel if the HID
> Bluetooth support grew that ability.

the HID raw support is global now and should work. However I have never
tested it. I am happy to push a patch for it if you have one.

Regards

Marcel


