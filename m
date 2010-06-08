Return-Path: <cyrus@holtmann.org>
Subject: Re: [PATCH] Get IEEE1284 for a single printer
From: Bastien Nocera <hadess@hadess.net>
To: Johan Hedberg <johan.hedberg@gmail.com>
Cc: linux-bluetooth@vger.kernel.org
In-Reply-To: <20100608070935.GA22068@jh-x301>
References: <1275849744.7994.38.camel@localhost.localdomain>
	 <20100608070935.GA22068@jh-x301>
Content-Type: text/plain; charset="ISO-8859-1"
Date: Tue, 08 Jun 2010 10:21:21 +0100
Message-ID: <1275988881.2458.12112.camel@localhost.localdomain>
Mime-Version: 1.0
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

On Tue, 2010-06-08 at 15:09 +0800, Johan Hedberg wrote:
> Hi Bastien,
> 
> On Sun, Jun 06, 2010, Bastien Nocera wrote:
> > Let me know what you think.
> 
> Sounds ok'ish to me, but how exactly would udev-configure-printer be
> called? If it's directly executed (as opposed to e.g. using D-Bus) then
> privilege and environment inheritance needs to be considered (i.e. is it
> fine that it gets run with the same privileges and environment as
> bluetoothd itself).
> 
> > The patch below could still be useful for debugging (in the worst
> > case).
> 
> I have nothing against pushing the patch upstream as long as its coding
> style issues are fixed:
<snip>
> Mixed tabs and spaces.

You do realise that all those are cut'n'paste from another function in
the same source file?

> > +			fprintf(stderr, "Invalid Bluetooth address '%s'\n", argv[2]);
> 
> Too long line.

Right, I'll fix that.

