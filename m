Return-Path: <cyrus@holtmann.org>
Message-ID: <1360917653.2283.39.camel@novo>
Subject: Re: [PATCH BlueZ 0/2] Add device_set_trusted()
From: Bastien Nocera <hadess@hadess.net>
To: Johan Hedberg <johan.hedberg@gmail.com>
Cc: Antonio Ospite <ospite@studenti.unina.it>,
	linux-bluetooth@vger.kernel.org
Date: Fri, 15 Feb 2013 09:40:53 +0100
In-Reply-To: <20130215083611.GA5750@x220>
References: <1359908071-15024-1-git-send-email-ospite@studenti.unina.it>
	 <20130215083611.GA5750@x220>
Content-Type: text/plain; charset="ISO-8859-1"
Mime-Version: 1.0
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

On Fri, 2013-02-15 at 10:36 +0200, Johan Hedberg wrote:
> Hi Antonio,
> 
> On Sun, Feb 03, 2013, Antonio Ospite wrote:
> > In patch 1 a device_set_trusted() function is proposed, which I plan to
> > use for the playstation-peripheral plugin; I am in the process of
> > rebasing the plugin on top of BlueZ 5.2.
> > 
> > In patch 2 the newly introduced function is used in order to avoid some
> > duplication.
> > 
> > device_set_trusted() looks a lot like device_set_temporary() and
> > device_set_legacy(), I hope it makes sense to you too.
> > 
> > Thanks,
> >    Antonio
> > 
> > Antonio Ospite (2):
> >   device: add a device_set_trusted() function
> >   device: use device_set_trusted() in set_trust()
> > 
> >  src/device.c |   30 +++++++++++++++++++-----------
> >  src/device.h |    1 +
> >  2 files changed, 20 insertions(+), 11 deletions(-)
> 
> This patch set makes me a bit uneasy since setting a device as trusted
> is a security sensitive operation. My initial reaction is that this
> should only be done through explicit user interaction, i.e. through the
> D-Bus interface.

How is using D-Bus interface "user interaction"? It's not any more user
interaction than doing it this way, which avoid going out through the
public interface for something we are setting up ourselves.

>  I'm also worried that plugins will start misusing this
> API once it's available.

I think that it's completely fair for plugins that *do* set up devices
to call this function. That's what the plugin is all about. Seeing as
devices should be marked as trusted to be usable, I see no reason that
this shouldn't be done automatically.

If the problem is other plugins abusing the function, then they could
just as well poke the files directly, as they already have all the
rights they need for that.

> Feel free to try to convince me otherwise though.

I don't see what using the D-Bus API would gain us, apart from more work
and indirection on the plugin side.

