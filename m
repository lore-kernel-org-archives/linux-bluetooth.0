Return-Path: <cyrus@holtmann.org>
Date: Fri, 15 Feb 2013 11:24:13 +0200
From: Johan Hedberg <johan.hedberg@gmail.com>
To: Bastien Nocera <hadess@hadess.net>
Cc: Antonio Ospite <ospite@studenti.unina.it>,
	linux-bluetooth@vger.kernel.org
Subject: Re: [PATCH BlueZ 0/2] Add device_set_trusted()
Message-ID: <20130215092413.GA11352@x220>
References: <1359908071-15024-1-git-send-email-ospite@studenti.unina.it>
 <20130215083611.GA5750@x220>
 <1360917653.2283.39.camel@novo>
 <20130215085726.GA10022@x220>
 <1360919831.2283.43.camel@novo>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1360919831.2283.43.camel@novo>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Bastien,

On Fri, Feb 15, 2013, Bastien Nocera wrote:
> On Fri, 2013-02-15 at 10:57 +0200, Johan Hedberg wrote:
> > > > This patch set makes me a bit uneasy since setting a device as trusted
> > > > is a security sensitive operation. My initial reaction is that this
> > > > should only be done through explicit user interaction, i.e. through the
> > > > D-Bus interface.
> > > 
> > > How is using D-Bus interface "user interaction"? It's not any more user
> > > interaction than doing it this way, which avoid going out through the
> > > public interface for something we are setting up ourselves.
> > 
> > Typically you'd get a pop-up dialog on the next connect attempt from
> > this device "accept connection from foo?" with a check-box or similar to
> > elect setting it as trusted. Alternatively the stuff that this plugin
> > does upon initial device setup could cause a similar pop-up dialog to be
> > presented to the user.
> 
> That's possible, technically, but it's not how the device gets set up
> when used in its original environment (eg. when plugged into a PS3).
> 
> > > >  I'm also worried that plugins will start misusing this
> > > > API once it's available.
> > > 
> > > I think that it's completely fair for plugins that *do* set up devices
> > > to call this function. That's what the plugin is all about. Seeing as
> > > devices should be marked as trusted to be usable, I see no reason that
> > > this shouldn't be done automatically.
> > 
> > How does the plugin that this API is primarily targeted for setup the
> > device? Does it do it through some physical connection like USB?
> 
> Yes. When you plug the device in, we tell it which adapter to connect to
> when used without a cable, and set ourselves up locally so that we can
> accept its connection without any more interaction.
> 
> >  In such
> > a case it's probably fine to skip the user interaction part since if
> > you've got physical access to the device there are much severe security
> > issues to consider.
> 
> Yes, the user would already have had the joypad plugged into the
> computer before any setup would have been made.

Fair enough. This does seem like a valid reason for setting the trusted
setting internally.

Johan
