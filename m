Return-Path: <cyrus@holtmann.org>
Date: Tue, 4 Aug 2009 18:32:08 +0200
From: Andreas Volz <lists@brachttal.net>
To: linux-bluetooth@vger.kernel.org
Subject: Re: Adressbook with bluez?
Message-ID: <20090804183208.31a857c4@frodo.mittelerde>
In-Reply-To: <20090804054928.GC26953@titan.makhutov-it.de>
References: <20090803202404.5d62b6a4@frodo.mittelerde>
	<20090804054928.GC26953@titan.makhutov-it.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Am Tue, 4 Aug 2009 07:49:28 +0200 schrieb Artem Makhutov:

> Hello,
> 
> n Mon, Aug 03, 2009 at 08:24:04PM +0200, Andreas Volz wrote:
> > Hello,
> > 
> > I like to read out the address book of my bluetooth phone with
> > bluez. I didn't find any info about this.
> > 
> > Is this possible?
> > 
> > If not, what is missing in the implementation to get it working?
> 
> You need to send special AT-Commands over the rfcomm like to the
> phone.

Thanks for your fast answer?

How should I do this practically? Could I use minicom? Could I simply
open /dev/rfcomm0 and read and write on it?

What commands should I send?

Are there some more docs/examples about this or could you give me more
information?

regards
Andreas
