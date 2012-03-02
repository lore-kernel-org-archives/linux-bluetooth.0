Return-Path: <cyrus@holtmann.org>
Message-ID: <1330711749.20578.23.camel@novo.hadess.net>
Subject: Re: obexd 0.45 compilation problem
From: Bastien Nocera <hadess@hadess.net>
To: Marcel Holtmann <marcel@holtmann.org>
Cc: BlueZ development <linux-bluetooth@vger.kernel.org>
Date: Fri, 02 Mar 2012 18:09:09 +0000
In-Reply-To: <1330710799.3392.123.camel@aeonflux>
References: <1330692190.20578.15.camel@novo.hadess.net>
	 <1330710799.3392.123.camel@aeonflux>
Content-Type: text/plain; charset="ISO-8859-1"
Mime-Version: 1.0
List-ID: <linux-bluetooth.vger.kernel.org>

On Fri, 2012-03-02 at 09:53 -0800, Marcel Holtmann wrote:
> Hi Bastien,
> 
> > Trying to compile obexd 0.45 with bluez-4.98, I get:
> > btio/btio.c: In function 'get_key_size':
> > btio/btio.c:522:14: error: 'struct bt_security' has no member named 'key_size'
> > 
> > Do you need to either up the bluez dependency, or is obexd lagging?
> 
> I screwed this one up. Hand me over the brown-paper-bag please.
> 
> Seems I ended up installing non-released headers on my build/test
> system. That should not have happened, but it did.
> 
> Either we do an obexd 0.46 with this change reversed or BlueZ 4.99. I
> going to check up on that and let everybody now.

Either is fine by me, and not in much of a hurry. It's just that I got
the impression from Luiz that it was done on purpose.
