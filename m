Return-Path: <cyrus@holtmann.org>
Date: Tue, 17 Nov 2009 13:59:09 -0800
From: "Luis R. Rodriguez" <lrodriguez@atheros.com>
To: David Sainty <david.sainty@dtsp.co.nz>
CC: Marcel Holtmann <marcel@holtmann.org>, Luis Rodriguez
	<Luis.Rodriguez@Atheros.com>, Vikram Kandukuri
	<Vikram.Kandukuri@Atheros.com>, "linux-bluetooth@vger.kernel.org"
	<linux-bluetooth@vger.kernel.org>
Subject: Re: [PATCH] DFU Driver and firmware for Atheros bluetooth chipset
	AR3011
Message-ID: <20091117215909.GE11382@tux>
References: <20091117143613.GA29705@atheros-laptop> <1258469940.2003.25.camel@violet> <20091117191112.GD11382@tux> <1258489653.2003.30.camel@violet> <4B0319E1.5030000@dtsp.co.nz>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
In-Reply-To: <4B0319E1.5030000@dtsp.co.nz>
List-ID: <linux-bluetooth.vger.kernel.org>

On Tue, Nov 17, 2009 at 01:47:13PM -0800, David Sainty wrote:
> Marcel Holtmann wrote:
> >> Also Vikram -- why not just ISC license the files as we do with ath9k ? Then also
> >> use:
> >>
> >> MODULE_LICENSE("Dual BSD/GPL");
> >>
> >> This would be more consistant with what we do with our other upstream Atheros
> >> modules.
> >>
> >
> > Since this is just a firmware loading driver, I prefer if you just keep
> > it GPL only. It is not worth going into too much details. Especially
> > since it looks inspired (nicely phrased) from bcm203x.c driver.
> >
> 
> In the interests of supporting the device from *BSD operating systems
> it'd be nice if it was clear that the firmware itself could be included
> under a BSD licence.

Did you read the license? It allow free redistribution.

  Luis
