Return-Path: <cyrus@holtmann.org>
Subject: Re: [PATCH] Add sixaxis cable-pairing plugin
From: Bastien Nocera <hadess@hadess.net>
To: Marcel Holtmann <marcel@holtmann.org>
Cc: BlueZ development <linux-bluetooth@vger.kernel.org>
In-Reply-To: <1244211333.23850.46.camel@localhost.localdomain>
References: <1244107722.30768.837.camel@cookie.hadess.net>
	 <1244139239.23850.1.camel@localhost.localdomain>
	 <1244198560.30768.2403.camel@cookie.hadess.net>
	 <1244207191.23850.12.camel@localhost.localdomain>
	 <1244209974.30768.2600.camel@cookie.hadess.net>
	 <1244211333.23850.46.camel@localhost.localdomain>
Content-Type: text/plain
Date: Fri, 05 Jun 2009 15:48:20 +0100
Message-Id: <1244213300.30768.2668.camel@cookie.hadess.net>
Mime-Version: 1.0
List-ID: <linux-bluetooth.vger.kernel.org>

On Fri, 2009-06-05 at 16:15 +0200, Marcel Holtmann wrote:
> 
> > You can keep personal attacks out of that. I think I've shown enough
> > patience trying to get this functionality into bluez proper.
> 
> This is not personal. I am keeping a watch on the dependencies of
> BlueZ
> and I don't see any need for adding GObject to the mix for the SixAxis
> support. Feel free to convince me that GObject based gudev is really
> necessary for this. Until then I declare this bloat.

No, it's not absolutely necessary, but somebody has to reinvent the
wheel, and I'm not happy spending time doing that.

> Please remember that BlueZ will run on embedded devices with limited
> memory and space requirements. You might argue that these devices
> don't
> need SixAxis support, but I prefer to keep that option.

Yes. And if such uses exist, I'm sure they'd be happy putting some
effort into bluez and do the port from gudev to libudev themselves.

> > I won't be updating this patch, but Luiz showed interested. My patch
> > will show up in the Fedora packages shortly.
> 
> That is your choice. Personally I really dislike if distros just go
> against upstream and start merging stuff, because it takes more effort
> to get it into upstream first.

All my patches are sent upstream before they go into the packages, and I
think I put quite a bit of work into this. But at the end of the day, I
only have so much time, and rewriting bits of code because the upstream
doesn't like GObject isn't what I call a good use of my time. So I'm
leaving it to somebody else to go the last mile because I can't be
bothered.

> On that point, you haven't merged the Socket fix upstream

It's not upstreamable, see the RH bugzilla. It depends on a kernel patch
that can't go upstream.

>  and also the
> Wacom and UTF-8 fix could be send upstream.

They already have, and you commented on them. I still believe the UTF-8
one could be merged as-is, but I don't have a good answer for the Wacom
one, which would need more investigation.

>  I know you send some version
> of these at least once or twice, but besides me also Johan could merge
> these patches.

Cheers
