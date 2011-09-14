Return-Path: <cyrus@holtmann.org>
Subject: Re: [PATCH] btusb.c: add support for 2011 mac mini
From: Marcel Holtmann <marcel@holtmann.org>
To: Jurgen Kramer <gtmkramer@xs4all.nl>
Cc: Gustavo Padovan <padovan@profusion.mobi>,
	linux-bluetooth@vger.kernel.org
Date: Wed, 14 Sep 2011 16:35:44 +0200
In-Reply-To: <1316009157.1992.5.camel@paragon.slim>
References: <1315152103.2441.6.camel@paragon.slim>
	 <20110913235205.GI16856@joana> <1316009157.1992.5.camel@paragon.slim>
Content-Type: text/plain; charset="UTF-8"
Message-ID: <1316010945.1937.40.camel@aeonflux>
Mime-Version: 1.0
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Jurgen,

> > * Jurgen Kramer <gtmkramer@xs4all.nl> [2011-09-04 18:01:42 +0200]:
> > 
> > > Today I noticed that the usb bluetooth adapter (BCM2046B1) on my 2011
> > > mac mini was not working. I've created a patch to get it going.
> > 
> > I need your Signed-off-by: line to apply the patch.
> > 
> > 	Gustavo
> > --
> OK, thanks. Here it goes:
> 
> Patch for btusb.c to enable the usb bluetooth adapter (BCM2046B1) on the
> 2011 mac mini (MacMini5,1).

can you please follow the kernel guidelines for submitting patches aka
Documentation/SubmittingPatches.

It is really not the maintainers job to fix this up. My rule is that a
patch (including commit message and signed-off-by) has to apply cleanly
with "git am". If it does not, it gets rejected.

So please create a proper new patch with signed-off-by line and submit
it as [PATCH v2] so that Gustavo has no extra work in applying your
patch.

Regards

Marcel


