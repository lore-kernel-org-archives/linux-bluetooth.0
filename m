Return-Path: <cyrus@holtmann.org>
Subject: Re: bluetoothd not starting at boot with udev
From: Bastien Nocera <hadess@hadess.net>
To: Mario Limonciello <mario_limonciello@dell.com>
Cc: artem@makhutov.org, linux-bluetooth@vger.kernel.org
In-Reply-To: <4A5BBE4D.1010406@dell.com>
References: <20090711161051.GM10684@titan.makhutov-it.de>
	 <1247337640.9709.96.camel@localhost.localdomain>
	 <6BE8CE7840AC9F459EF5A0693CA2744D6BAFB1@ausx3mpc138.aus.amer.dell.com>
	 <1247418647.5460.3.camel@snoogens.fab.redhat.com>
	 <4A5B5D89.8020205@dell.com>  <4A5BBE4D.1010406@dell.com>
Content-Type: text/plain
Date: Tue, 14 Jul 2009 05:30:01 +0100
Message-Id: <1247545801.5460.19.camel@snoogens.fab.redhat.com>
Mime-Version: 1.0
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

On Mon, 2009-07-13 at 18:07 -0500, Mario Limonciello wrote:
> Hi Bastien:
> 
> Mario Limonciello wrote:
> > Hi Bastien:
> >
> > Bastien Nocera wrote:
> >   
> > Currently in the Ubuntu udev init script there is a call to 'udevadm
> > trigger' (without any arguments).  Without any arguments it appears the
> > default is "--type=devices".  When I add --type=failed (--retry-failed
> > is deprecated), the system fails to boot up to X.  If I return it back
> > to it's old state and add a second call right afterward of
> > "--type=failed", there is no difference in behavior.  bluetoothd still
> > fails to spawn by the udev rule.
> >   
> I'm actually suspecting that this is caused by dbus daemon not being
> spawned early enough for bluetoothd to have access to.

Which is why you need to retry the failed rules later on.

>   I've come to
> this conclusion by putting a shell wrapper around bluetoothd and
> capturing exit code status to see that it does get spawned at startup
> but immediately exits.  I put a pgrep at the same time to check for
> dbus, and didn't see it running.
> 
> How are you ensuring that dbus is running by the time that udev starts
> processing rules in Fedora then?
> 
> For now the only solution I can come up with is to maintain an init
> script that runs "udevadm trigger --subsystem-match=bluetooth".  Since
> multiple invocations of bluetoothd --udev won't harm the system, it's
> not that horrible of a workaround, but still ideally would like to lose
> the init script altogether.

You need to call with the --retry-failed, after the basics of the system
have been brought up. This means starting up D-Bus, mounting network
filesystems, etc.

