Return-Path: <cyrus@holtmann.org>
Subject: Re: [PATCH] Draft of xdg-hostname support
From: Bastien Nocera <hadess@hadess.net>
To: Marcel Holtmann <marcel@holtmann.org>
Cc: "linux-bluetooth@vger.kernel.org" <linux-bluetooth@vger.kernel.org>
In-Reply-To: <1244820420.5536.6.camel@violet>
References: <1244818043.3280.392.camel@snoogens.fab.redhat.com>
	 <1244820420.5536.6.camel@violet>
Content-Type: text/plain
Date: Fri, 12 Jun 2009 17:33:29 +0100
Message-Id: <1244824409.3280.562.camel@snoogens.fab.redhat.com>
Mime-Version: 1.0
List-ID: <linux-bluetooth.vger.kernel.org>

On Fri, 2009-06-12 at 17:27 +0200, Marcel Holtmann wrote:
> Hi Bastien,
> 
> > xdg-hostname[1] is a D-Bus service that offers notification on hostname
> > changes, and provides an additional "Display hostname" (think MacOS X'
> > and Windows' "computer name").
> > 
> > This would allow us to call adapters something like:
> > Bastien's laptop
> > rather than:
> > dhcp-1-124-1
> > 
> > The code is a first pass at the problem, and won't even run, but will
> > compile. I'm thinking about changing that code, and I'm looking for
> > hints on the direction (rather than comments on the dependencies or the
> > coding style).
> > 
> > I'm thinking:
> > - Make expand_name UTF-8 aware
> > - Factor the main_opts.hostname setting code, and make it pluggable
> > (hints?)
> > - Change the device name when the display name or hostname changes
> > (would need to get added to the hciops plugin)
> 
> personally I never liked the Bluetooth name being derived from the bare
> hostname and desktop systems. So feel free to do something similar that
> we do for the class of device.
> 
> However keep in mind that systems like the N810 or similar wanna have a
> specific default name and we have to respect that. So if integration
> configures a default device name in main.conf then we should respect
> that.

Sure. We'd adjust the default configuration slightly, and fix
expand_name and leave it at that.

> Problem area as usual are the cases with multiple devices attached to
> the same system. Having them ending all up with the same name would be
> kind stupid.

Yes. Although there's no real way to work around that.

> Don't change src/plugin.c since bootstrap-configure will turn PLUGINDIR
> to the local repository anyway. And also you can have builtin plugins
> that will solve the testing issue.

Missed that bit. And the patch got into the commit by mistake.

> Of course when you consider this seriously for inclusion, I expect a
> pure low-level D-Bus plugin here. Same as how we handle HAL.

Did you _actually_ read the mail:
> > and I'm looking for
> > hints on the direction (rather than comments on the dependencies or the
> > coding style).

I'm still wondering how we can handle the hostname changing, and having
the hostname overridden by a plugin.
