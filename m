Return-Path: <SRS0+3aa8887a9142f6484bfd+262+infradead.org+dwmw2@pentafluge-184039.srs.infradead.org>
Subject: Re: [Bluez-devel] BT3C ceased working in kernel 2.6.6
From: David Woodhouse <dwmw2@infradead.org>
To: Marcel Holtmann <marcel@holtmann.org>
Cc: Antti =?ISO-8859-1?Q?M=E4kel=E4?= <zarhan@cs.tut.fi>,
   BlueZ Mailing List <bluez-devel@lists.sourceforge.net>
In-Reply-To: <1084382223.25099.72.camel@pegasus>
References: <Pine.GSO.4.58.0405111227090.9721@viherkiuru.cs.tut.fi>
	 <1084371696.4426.160.camel@hades.cambridge.redhat.com>
	 <1084382223.25099.72.camel@pegasus>
Content-Type: text/plain
Message-Id: <1084383638.4426.391.camel@hades.cambridge.redhat.com>
Mime-Version: 1.0
Date: Wed, 12 May 2004 18:40:38 +0100
List-ID: <bluez-devel.lists.sourceforge.net>

On Wed, 2004-05-12 at 19:17 +0200, Marcel Holtmann wrote:
> Hi David,
> 
> > >   The firmware is placed in /usr/lib/hotplug/firmware as it should be,
> > 
> > That's not a bad idea....
> 
> right now I am not going to keep up with a new version of bluefw,
> because the bt3c_cs driver didn't use it anymore and for 2.6 the bcm203x
> kernel firmware loader works much better. However I am going to apply
> patches if they look correct. So this one is in CVS.

I know it's obsolete for the PC card; is it no longer needed for USB
either with a 2.6 kernel?

-- 
dwmw2
