Return-Path: <cyrus@holtmann.org>
Subject: Re: [PATCH] PS3Remote unpairing and power-saving
From: Bastien Nocera <hadess@hadess.net>
To: "Ruslan N. Marchenko" <rufferson@gmail.com>
Cc: linux-bluetooth@vger.kernel.org
In-Reply-To: <a70b8cd30909180631r4546ffc0q66edc6cc8bd010f2@mail.gmail.com>
References: <a70b8cd30908280742k6cdcaa2l3a267661fe1da17d@mail.gmail.com>
	 <1253272222.18963.4109.camel@localhost.localdomain>
	 <a70b8cd30909180631r4546ffc0q66edc6cc8bd010f2@mail.gmail.com>
Content-Type: text/plain
Date: Fri, 18 Sep 2009 14:49:26 +0100
Message-Id: <1253281766.18963.4279.camel@localhost.localdomain>
Mime-Version: 1.0
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

On Fri, 2009-09-18 at 15:31 +0200, Ruslan N. Marchenko wrote:
> Hi Bastien,
> 
> Thanks for finding your time for review.
> 
> 2009/9/18, Bastien Nocera <hadess@hadess.net>:
> > Don't use statics, add those to a ps3 specific struct.
> 
> This function is ps3remote_event which supposed to be use for ps3remote only,
> also the driver assumes only single ps3remote device per bluez instance.
> I just copied semantic from ps3remote_decode function, where also 2
> statics are used. Though I can move them all to input structure.
> Should I?

Please. And if you manage to make it handle more than one remote in the
process, then all the better.

> > > +     g_timer_start(((struct fake_hid *)fake->priv)->timer);
> >
> >
> > Why do you start the timer unconditionally, instead of just when using
> >  the HOME key?
> >
> 
> Because this statement is to reset event timer, which causes remote to
> be disconnected on idle. Each key-press resets the timer
> unconditionally. g_timer_start is recommended to use instead of
> g_timer_reset since they do the same thing and reset will be
> deprecated (I guess).

Looks fine.

Cheers

