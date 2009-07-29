Return-Path: <cyrus@holtmann.org>
Subject: Re: [PATCH] Add rfkill plugin
From: Bastien Nocera <hadess@hadess.net>
To: Johan Hedberg <johan.hedberg@gmail.com>
Cc: Marcel Holtmann <marcel@holtmann.org>,
        BlueZ development <linux-bluetooth@vger.kernel.org>
In-Reply-To: <20090729214412.GA24031@jh-x301>
References: <1248798884.23466.12024.camel@localhost.localdomain>
	 <1248880408.28327.906.camel@localhost.localdomain>
	 <1248896967.28545.236.camel@violet>
	 <1248898544.28327.1539.camel@localhost.localdomain>
	 <1248899010.28545.241.camel@violet>  <20090729214412.GA24031@jh-x301>
Content-Type: text/plain
Date: Wed, 29 Jul 2009 22:45:36 +0100
Message-Id: <1248903936.28327.1725.camel@localhost.localdomain>
Mime-Version: 1.0
List-ID: <linux-bluetooth.vger.kernel.org>

On Thu, 2009-07-30 at 00:44 +0300, Johan Hedberg wrote:
> Hi Marcel,
> 
> On Wed, Jul 29, 2009, Marcel Holtmann wrote:
> > > >  Hijacking the set_powered D-Bus command is the
> > > > wrong approach. We need a properly exported adapter_up() function for
> > > > this.
> > > 
> > > I believe I tried exporting adapter_up() but it didn't work.
> > 
> > Johan, Luiz, any reason why this would not work. What needs to be done
> > to bring up the adapter. Besides calling the ioctl() directly which we
> > don't wanna do anymore.
> 
> adapter_up() is more of a callback that's responsible for doing the
> necessary initializations *after* adapter has just gone up, so it's not
> the right function to call when you want to bring it up (i.e. call the
> ioctl). I believe all code paths for bringing the adapter up call set_mode
> in src/adapter.c which in turn calls adapter_ops->set_powered (which calls
> the ioctl in the case of hciops).
> 
> So having a btd_adapter_set_powered exported to plugins (which is what
> Bastien's patch seems to do) makes sense to me in this case. I might
> actually need something similar for maemo in order to handle our offline
> mode better (maemo specific plugin to catch the MCE offline mode signal
> and then call btd_adapter_set_powered).

Hence why it would probably be a good thing to have as a plugin :)
