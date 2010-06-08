Return-Path: <cyrus@holtmann.org>
Date: Tue, 8 Jun 2010 17:26:21 +0800
From: Johan Hedberg <johan.hedberg@gmail.com>
To: Bastien Nocera <hadess@hadess.net>
Cc: linux-bluetooth@vger.kernel.org
Subject: Re: [PATCH] Get IEEE1284 for a single printer
Message-ID: <20100608092621.GA8254@jh-x301>
References: <1275849744.7994.38.camel@localhost.localdomain>
 <20100608070935.GA22068@jh-x301>
 <1275988881.2458.12112.camel@localhost.localdomain>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1275988881.2458.12112.camel@localhost.localdomain>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Bastien,

On Tue, Jun 08, 2010, Bastien Nocera wrote:
> > I have nothing against pushing the patch upstream as long as its coding
> > style issues are fixed:
> <snip>
> > Mixed tabs and spaces.
> 
> You do realise that all those are cut'n'paste from another function in
> the same source file?

Nope, didn't realize that. So the whole file needs coding style cleanups
then.

> > > +			fprintf(stderr, "Invalid Bluetooth address '%s'\n", argv[2]);
> > 
> > Too long line.
> 
> Right, I'll fix that.

Thanks.

Johan
