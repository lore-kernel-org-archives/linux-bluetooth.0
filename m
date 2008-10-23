Return-Path: <cyrus@holtmann.org>
Subject: Re: [PATCHes] Better buttons in adapter properties
From: Bastien Nocera <hadess@hadess.net>
To: Marcel Holtmann <marcel@holtmann.org>
Cc: BlueZ development <linux-bluetooth@vger.kernel.org>
In-Reply-To: <1224737838.9386.182.camel@californication>
References: <1224003756.5268.371.camel@cookie.hadess.net>
	 <48F523EC.9010007@dtsp.co.nz>
	 <1224025489.5268.1049.camel@cookie.hadess.net>
	 <48F52A51.6010506@dtsp.co.nz>
	 <1224108411.5268.3681.camel@cookie.hadess.net>
	 <1224737838.9386.182.camel@californication>
Content-Type: text/plain
Date: Thu, 23 Oct 2008 10:12:12 +0100
Message-Id: <1224753132.18251.529.camel@cookie.hadess.net>
Mime-Version: 1.0
List-ID: <linux-bluetooth.vger.kernel.org>

On Thu, 2008-10-23 at 06:57 +0200, Marcel Holtmann wrote:
> Hi Bastien,
> 
> > > 800x480 full screen.  But the standard window manager decorations on the 
> > > EeePC make anything taller than 422 pixels start to not fit.
> > 
> > I think we can easily reduce the space taken by the visibility and
> > friendly name sections. I'll try to get a patch ready tomorrow.
> 
> any updates here that I might have missed?

Not since my rant about the discoverable preferences. The patched
version doesn't take any more space than the current layout, and fixes
discovery problems with the labels, so I would urge you to merge it.

I'll try to have a patch ready for squeezing the rest of the UI when
I've had more of a think about it.

Cheers
