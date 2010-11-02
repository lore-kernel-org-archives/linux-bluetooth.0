Return-Path: <cyrus@holtmann.org>
Subject: Re: >net-wireless/bluez-4.63 unable to connect audio streams due
 commit
From: Peter Hurley <phurley@charter.net>
To: pacho@condmat1.ciencias.uniovi.es
Cc: Uwe =?ISO-8859-1?Q?Kleine-K=F6nig?=
	<u.kleine-koenig@pengutronix.de>,
	Luiz Augusto von Dentz <luiz.dentz@gmail.com>,
	Johan Hedberg <johan.hedberg@gmail.com>,
	linux-bluetooth@vger.kernel.org
In-Reply-To: <1288524358.2654.4.camel@localhost.localdomain>
References: <1287426290.6820.1.camel@localhost.localdomain>
	 <1288524358.2654.4.camel@localhost.localdomain>
Content-Type: text/plain; charset="ISO-8859-1"
Date: Tue, 02 Nov 2010 13:25:32 -0400
Message-ID: <1288718732.6420.84.camel@thor>
Mime-Version: 1.0
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Pacho,

On Sun, 2010-10-31 at 12:25 +0100, Pacho Ramos wrote:
> El lun, 18-10-2010 a las 20:24 +0200, Pacho Ramos escribió:
> > El lun, 04-10-2010 a las 14:35 +0200, Uwe Kleine-König escribió:
> > > Hello Pacho,
> > > 
> > > On Mon, Oct 04, 2010 at 12:25:46PM +0200, Pacho Ramos wrote:
> > > > > I would say this was because of double authentication request, but it
> > > > > seems it is not the case, actually ssp doesn't seems to be used at all
> > > > > here so this must be something else, maybe you should try this:
> > > > > 
> > > > > http://thread.gmane.org/gmane.linux.bluez.kernel/7256
> > > > > 
> > > > 
> > > > Thanks but, how should I try to apply that patch? Looks like
> > > > net/bluetooth/rfcomm/core.c is not present on bluez-4.72 sources
> > > I guess this is a patch to apply to your kernel, not bluez.
> > > 
> > > Best regards
> > > Uwe
> > > 
> > 
> > Downstream affected reported told me it's still failing even with the
> > patch:
> > 
> > http://bugs.gentoo.org/show_bug.cgi?id=327705#c19
> > 
> > Attached is the new hcidump output
> > 
> > Thanks a lot for your help :-)
> > 
> 
> There is no possible solution to this? :-(
> 
> Thanks

The hcidump output reported is unfortunately insufficient to determine
the actual cause of failure. The indicated cause of failure appears to
be an error return from the Set Connection Encryption cmd (as indicated
by the absence of an Encryption Change evt). The actual error code is
not indicated in the hcidump output -- really, 'hcidump -tVx' is more
helpful for troubleshooting remotely.

The "Function not implemented (38)" message (which is in the bluetoothd
output capture in the downstream report) is the kernel bt stack's
translation to errno for bluetooth error codes primarily associated with
piconet errors (like Reserved Slot Violation(s), LMP Response Timeout,
etc. Actually, it's a catchall for errors the kernel bt stack thinks it
can't really do anything about).

Although I'd be happy to take a look at a more complete hcidump, the
reality is that there are bluetooth device incompatibilities/bugs that
are often unfixable - even when the hardware's available. My own bt
dongle reports that it's eSCO capable but hangs the LM when actually
attempting to negotiate an eSCO connection.

Hope that helps,
Peter Hurley

