Return-Path: <cyrus@holtmann.org>
Message-ID: <1330711879.3392.128.camel@aeonflux>
Subject: Re: obexd 0.45 compilation problem
From: Marcel Holtmann <marcel@holtmann.org>
To: Bastien Nocera <hadess@hadess.net>
Cc: BlueZ development <linux-bluetooth@vger.kernel.org>
Date: Fri, 02 Mar 2012 10:11:19 -0800
In-Reply-To: <1330711749.20578.23.camel@novo.hadess.net>
References: <1330692190.20578.15.camel@novo.hadess.net>
	 <1330710799.3392.123.camel@aeonflux>
	 <1330711749.20578.23.camel@novo.hadess.net>
Content-Type: text/plain; charset="UTF-8"
Mime-Version: 1.0
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Bastien,

> > > Trying to compile obexd 0.45 with bluez-4.98, I get:
> > > btio/btio.c: In function 'get_key_size':
> > > btio/btio.c:522:14: error: 'struct bt_security' has no member named 'key_size'
> > > 
> > > Do you need to either up the bluez dependency, or is obexd lagging?
> > 
> > I screwed this one up. Hand me over the brown-paper-bag please.
> > 
> > Seems I ended up installing non-released headers on my build/test
> > system. That should not have happened, but it did.
> > 
> > Either we do an obexd 0.46 with this change reversed or BlueZ 4.99. I
> > going to check up on that and let everybody now.
> 
> Either is fine by me, and not in much of a hurry. It's just that I got
> the impression from Luiz that it was done on purpose.

nope, just a big screw up on my part :(

Regards

Marcel


