Return-Path: <cyrus@holtmann.org>
Subject: Re: [PATCH] Add rfkill plugin
From: Bastien Nocera <hadess@hadess.net>
To: Marcel Holtmann <marcel@holtmann.org>
Cc: BlueZ development <linux-bluetooth@vger.kernel.org>
In-Reply-To: <1248899010.28545.241.camel@violet>
References: <1248798884.23466.12024.camel@localhost.localdomain>
	 <1248880408.28327.906.camel@localhost.localdomain>
	 <1248896967.28545.236.camel@violet>
	 <1248898544.28327.1539.camel@localhost.localdomain>
	 <1248899010.28545.241.camel@violet>
Content-Type: text/plain
Date: Wed, 29 Jul 2009 21:40:59 +0100
Message-Id: <1248900059.28327.1591.camel@localhost.localdomain>
Mime-Version: 1.0
List-ID: <linux-bluetooth.vger.kernel.org>

On Wed, 2009-07-29 at 22:23 +0200, Marcel Holtmann wrote:
> Hi Bastien,
> 
> > > > > The plugin allows us to restore the previous power state on
> > > > > adapters when the killswitch on them has been unblocked.
> > > > > 
> > > > > Otherwise we end up with the adapter disabled when coming back from a
> > > > > soft killswitch.
> > > > 
> > > > Just a note that __u32 causes failures with newer GCCs (not sure why),
> > > > using uint32_t instead fixes the problem.
> > > > 
> > > > I'll send another patch when this one gets committed.
> > > 
> > > I didn't commit this patch, because it should be part of bluetoothd and
> > > not a plugin 
> > 
> > You said you didn't mind:
> > http://thread.gmane.org/gmane.linux.bluez.kernel/2981/focus=2986
> > > Okay. Since we have built-in plugins, it makes no big difference.
> > 
> > > and as I mentioned before honor the RememberPowered setting
> > > for system where other entities control that.
> > 
> > That's what that does:
> > +       if (main_opts.remember_powered == FALSE)
> > +               return 0;
> >
> > > However I did push a RFKILL skeleton that that all the lifting except
> > > bringing the adapter up.
> > 
> > Which is pretty much the same as the code I sent, and the code in
> > connman. What's the point of putting this in the core when it does the
> > exact same as the plugin save for a level of indirection?
> 
> I changed my mind, because of the main_opts. We don't wanna export the
> options in the long term. So using src/rfkill.c seems more logical at
> this point of time.

We could have exported some of the settings through manager_get_*(), for
example manager_get_remember_powered(), for use by plugins.

The point is moot now anyway.
