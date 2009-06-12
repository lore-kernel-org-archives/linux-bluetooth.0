Return-Path: <cyrus@holtmann.org>
Subject: Re: [PATCH] Draft of xdg-hostname support
From: Marcel Holtmann <marcel@holtmann.org>
To: Bastien Nocera <hadess@hadess.net>
Cc: "linux-bluetooth@vger.kernel.org" <linux-bluetooth@vger.kernel.org>
In-Reply-To: <1244818043.3280.392.camel@snoogens.fab.redhat.com>
References: <1244818043.3280.392.camel@snoogens.fab.redhat.com>
Content-Type: text/plain
Date: Fri, 12 Jun 2009 17:27:00 +0200
Message-Id: <1244820420.5536.6.camel@violet>
Mime-Version: 1.0
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Bastien,

> xdg-hostname[1] is a D-Bus service that offers notification on hostname
> changes, and provides an additional "Display hostname" (think MacOS X'
> and Windows' "computer name").
> 
> This would allow us to call adapters something like:
> Bastien's laptop
> rather than:
> dhcp-1-124-1
> 
> The code is a first pass at the problem, and won't even run, but will
> compile. I'm thinking about changing that code, and I'm looking for
> hints on the direction (rather than comments on the dependencies or the
> coding style).
> 
> I'm thinking:
> - Make expand_name UTF-8 aware
> - Factor the main_opts.hostname setting code, and make it pluggable
> (hints?)
> - Change the device name when the display name or hostname changes
> (would need to get added to the hciops plugin)

personally I never liked the Bluetooth name being derived from the bare
hostname and desktop systems. So feel free to do something similar that
we do for the class of device.

However keep in mind that systems like the N810 or similar wanna have a
specific default name and we have to respect that. So if integration
configures a default device name in main.conf then we should respect
that.

Problem area as usual are the cases with multiple devices attached to
the same system. Having them ending all up with the same name would be
kind stupid.

Don't change src/plugin.c since bootstrap-configure will turn PLUGINDIR
to the local repository anyway. And also you can have builtin plugins
that will solve the testing issue.

Of course when you consider this seriously for inclusion, I expect a
pure low-level D-Bus plugin here. Same as how we handle HAL.

Regards

Marcel


