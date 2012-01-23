Return-Path: <cyrus@holtmann.org>
Message-ID: <1327335872.32646.103.camel@novo.hadess.net>
Subject: Re: [RFC PATCH 0/3] Generate PIN for keyboards inside bluetoothd
From: Bastien Nocera <hadess@hadess.net>
To: Scott James Remnant <keybuk@chromium.org>
Cc: Scott James Remnant <scott@netsplit.com>,
	linux-bluetooth@vger.kernel.org
Date: Mon, 23 Jan 2012 16:24:32 +0000
In-Reply-To: <CAHZ1yCk3twweh031ff1UyLJtr3kkgQDAXiT56M0ANyiNe3uqhw@mail.gmail.com>
References: <1327100744-28782-1-git-send-email-scott@netsplit.com>
	 <1327320873.32646.77.camel@novo.hadess.net>
	 <CA+bD78h+vp5EY+HSvArRSfySr3EWSi3f0qvK+PiKX6OH8Q7w-A@mail.gmail.com>
	 <1327334612.32646.97.camel@novo.hadess.net>
	 <CAHZ1yCk3twweh031ff1UyLJtr3kkgQDAXiT56M0ANyiNe3uqhw@mail.gmail.com>
Content-Type: text/plain; charset="ISO-8859-1"
Mime-Version: 1.0
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

On Mon, 2012-01-23 at 08:10 -0800, Scott James Remnant wrote:
> On Mon, Jan 23, 2012 at 8:03 AM, Bastien Nocera <hadess@hadess.net> wrote:
> 
> > And it's not relevant to the discussion. Any chance you could send me
> > the details about your devices for me to add them to the database? :)
> >
> 
> Not yet ;-)
> 
> (but they're not relevant to this patch, because this patch isn't
> intended to cover them)

I know they're not relevant, but the completionist in me will need those
(or at least the ones you can share).

> > We already know when we have a keyboard, we already know when we have a
> > non-SSP device. Why can't we use RequestPincode in the UI? We already
> > generate the random PIN for devices.
> >
> 
> See Marcel's mails for why he doesn't want this done in the UI.
> 
> From my point of view, because then we have give different UIs which
> are all different. Implementing this in bluetoothd means GNOME, KDE,
> Maemo/Moblin/MeeGo/Tizen, Android, Chrome OS, etc. can all share a
> single behavior.

OK.

> >> > From what I can see, the whole operation can be implemented from
> >> > user-space without a problem.
> >> >
> >> > Care to explain what benefits this has for user-space?
> >> >
> >>
> >> Marcel asked me to implement this in bluetoothd, so everyone can
> >> benefit equally rather than four different bluetooth agents all
> >> handling auto-pairing slightly differently.
> >
> > In which case it needs not to regress from the existing solutions. We
> > have a database of devices with their specific pairing information, we
> > also have ways to show the PIN in special ways depending on the remote
> > device:
> >
> 
> I don't disagree -  the "database of devices" is only relevant to the
> other patch set I submitted for comments though, not this one.
> 
> You'll note that this keyboard PIN generation patch is deliberately
> after any plugins, so that they (including the autopair plugin in the
> previous patch) can handle the fixed PIN cases.

Are you going to add a mention in the documentation for the new function
that it can only be called for 2.0 Bluetooth keyboards, or are there
other devices it will handle?

