Return-Path: <cyrus@holtmann.org>
Subject: Re: Wacom Graphire Bluetooth HID driver - help needed
From: =?UTF-8?Q?Przemys=C5=82aw?= Firszt <przemo@firszt.eu>
To: Bastien Nocera <hadess@hadess.net>
Cc: linux-bluetooth@vger.kernel.org
In-Reply-To: <1243549749.21144.816.camel@cookie.hadess.net>
References: <1243543413.21667.23.camel@pldmachine>
	 <1243549749.21144.816.camel@cookie.hadess.net>
Content-Type: text/plain; charset="UTF-8"
Date: Fri, 29 May 2009 10:13:48 +0100
Message-Id: <1243588429.4951.22.camel@pldmachine>
Mime-Version: 1.0
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Dnia 2009-05-28, czw o godzinie 23:29 +0100, Bastien Nocera pisze:
> On Thu, 2009-05-28 at 21:43 +0100, Przemysław Firszt wrote:
> > Hi,
> > I'm working on Wacom Graphire bluetooth tablet driver.
> 
> I already posted patches to linux-input and linux-bluetooth with support
> for that, and it's merged into Fedora 11.
> 
> Check that code, and let me know whether you have any comments on the
> code.

I'm trying completly different way (redefining the device report and
mapping), but the problems (mode 2 and turning tablet twice to get it
working) are similar. Did you get any reply that this patch is going to
be included in mainstream?

Do you know what was the reason of that error -14 ? (see here for the
details: http://marc.info/?l=linux-bluetooth&m=123724912027050&w=2 )
I still have that problem...

I've to check your bluetoothd patch - do you know if it's going to be
included or the developers are waiting for required changes in kernel? 
I hope that it could sort out the ugly hack in hidp.

--
Przemo






