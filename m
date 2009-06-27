Return-Path: <cyrus@holtmann.org>
Subject: Re: [PATCH] Add udev rules to start bluetooth on-demand
From: Marcel Holtmann <marcel@holtmann.org>
To: Bastien Nocera <hadess@hadess.net>
Cc: BlueZ development <linux-bluetooth@vger.kernel.org>
In-Reply-To: <1245862376.26486.17217.camel@localhost.localdomain>
References: <1245591547.26486.7101.camel@localhost.localdomain>
	 <1245592251.15367.64.camel@violet>
	 <1245593152.26486.7156.camel@localhost.localdomain>
	 <1245593413.15367.65.camel@violet>
	 <1245843329.26486.16565.camel@localhost.localdomain>
	 <1245861818.15367.145.camel@violet>
	 <1245861900.26486.17200.camel@localhost.localdomain>
	 <1245862000.15367.146.camel@violet>
	 <1245862376.26486.17217.camel@localhost.localdomain>
Content-Type: text/plain
Date: Sat, 27 Jun 2009 12:27:40 +0200
Message-Id: <1246098460.12994.128.camel@localhost.localdomain>
Mime-Version: 1.0
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Bastien,

> > > > > > > > > As discussed in previous mails.
> > > > > > > > 
> > > > > > > > please name it bluetooth.rules. The daemon is also called bluetoothd and
> > > > > > > > not bluezd.
> > > > > > > > 
> > > > > > > > Also you need to have the EXTRA_DIST part in it since _DATA doesn't get
> > > > > > > > added to the distribution automatically. For all this changes, you have
> > > > > > > > to check with make distcheck.
> > > > > > > 
> > > > > > > Fixed version attached
> > > > > > 
> > > > > > we might need to put this into ifndef INITSCRIPTS since it makes no
> > > > > > sense to install the init script and the udev rule at the same time.
> > > > > 
> > > > > Revised patch attached
> > > > 
> > > > +
> > > > +if INISCRIPTS
> > > > +else
> > > > +rules_DATA += bluetooth.rules
> > > >  endif
> > > 
> > > ifndef isn't an automake construct.
> > > 
> > 
> > then if !INITSCRIPTS should do it. However I was more asking about the
> > spelling mistake. You forgot a T ;)
> 
> Well, that's embarrassing...

are you sending a new patch :)

Regards

Marcel


