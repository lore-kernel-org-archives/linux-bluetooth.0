Return-Path: <cyrus@holtmann.org>
Subject: Re: [PATCH] Add udev rules to start bluetooth on-demand
From: Bastien Nocera <hadess@hadess.net>
To: Marcel Holtmann <marcel@holtmann.org>
Cc: BlueZ development <linux-bluetooth@vger.kernel.org>
In-Reply-To: <1245861818.15367.145.camel@violet>
References: <1245591547.26486.7101.camel@localhost.localdomain>
	 <1245592251.15367.64.camel@violet>
	 <1245593152.26486.7156.camel@localhost.localdomain>
	 <1245593413.15367.65.camel@violet>
	 <1245843329.26486.16565.camel@localhost.localdomain>
	 <1245861818.15367.145.camel@violet>
Content-Type: text/plain
Date: Wed, 24 Jun 2009 17:44:59 +0100
Message-Id: <1245861900.26486.17200.camel@localhost.localdomain>
Mime-Version: 1.0
List-ID: <linux-bluetooth.vger.kernel.org>

On Wed, 2009-06-24 at 18:43 +0200, Marcel Holtmann wrote:
> On Wed, 2009-06-24 at 12:35 +0100, Bastien Nocera wrote:
> > On Sun, 2009-06-21 at 16:10 +0200, Marcel Holtmann wrote:
> > > Hi Bastien,
> > > 
> > > > > > As discussed in previous mails.
> > > > > 
> > > > > please name it bluetooth.rules. The daemon is also called bluetoothd and
> > > > > not bluezd.
> > > > > 
> > > > > Also you need to have the EXTRA_DIST part in it since _DATA doesn't get
> > > > > added to the distribution automatically. For all this changes, you have
> > > > > to check with make distcheck.
> > > > 
> > > > Fixed version attached
> > > 
> > > we might need to put this into ifndef INITSCRIPTS since it makes no
> > > sense to install the init script and the udev rule at the same time.
> > 
> > Revised patch attached
> 
> +
> +if INISCRIPTS
> +else
> +rules_DATA += bluetooth.rules
>  endif

ifndef isn't an automake construct.
