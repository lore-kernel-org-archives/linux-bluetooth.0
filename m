Return-Path: <cyrus@holtmann.org>
Subject: Re: Lack of configuration
From: Marcel Holtmann <marcel@holtmann.org>
To: manday@gmx.net
Cc: linux-bluetooth@vger.kernel.org
Date: Fri, 04 Nov 2011 22:04:13 +0100
In-Reply-To: <20111103194900.GD10400@slate>
References: <20111103194900.GD10400@slate>
Content-Type: text/plain; charset="UTF-8"
Message-ID: <1320440654.15441.298.camel@aeonflux>
Mime-Version: 1.0
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi,

> I've sought help for getting bluetooth to work on my Gentoo box on irc
> and was helped, thank you JHE at this point.
> 
> However, I've also realized that bluez has apparently stripped the user
> of any sort of useful configuration and documentation thereof.
> 
> Now, I wouldn't usually care if some random program does that, I'd
> simply stop using it and look for an alternative, but bluez surely is
> not just another random program and instead integral part of linux.
> 
> I was told it was after bluez 3.x that hcid.conf et al were removed in
> favor of an untransparent, undocumented and obscure configuration
> through dbus (latter I've not been told but claim by myself).

actually the D-Bus interfaces are fully documented and come with example
command line scripts in Python.

And also /etc/bluetooth/main.conf has all configuration option
documented.

So please start looking into it first before making any accusations
here. If you wanna keep using BlueZ 3.x, you still can. Nobody is
forcing anybody to upgrade.

> I can't help it but wonder what has driven such bizarre decision to
> allow a fundamental component of linux no longer to be configured
> through configuration files.
> 
> I take it certain people found it incredibly "elegant" and "progressive"
> to use dbus for everything they could possibly think of. Well, DBUS has
> its use and advantages which we are aware of, but using DBUS to write
> "Hello world" to the console or, in this case, making fundamental
> configuration, is no advantage and simply an unpractical obstacle.

If you wanna be stuck in the 90ties, be my guest, but BlueZ has moved
on.

> A user is looking forward to using the functionality of the linux
> bluetooth stack, bluez. So he install bluez and wants to configure it,
> like everything else on his system is configured.
> 
> But no, not BlueZ! BlueZ is "advanced". BlueZ won't allow that. First
> of all, user, you will have to install DBUS, because BlueZ cannot be
> configured without a Desktop-Bus.

Stop whining about BlueZ using D-Bus as IPC. It is the default for
almost every single Linux service these days. Even systemd relies on
D-Bus.

> Once you got DBUS, you still cannot configure BlueZ, because DBUS has no
> means for configuration, least of all has it ever been intended to
> maintain configuration.
> 
> So next you will have to install our special front-ends to DBUS, which
> use a dedicated protocol to communicate the configuration. By now, the
> user asks himself "Why can I not just write that bloody config file like
> I always do?". Well, BlueZ knows better than you, what's best for you.
> So please, install the frontends, dear user...
> 
> So the user installs two python scripts, but hold on, we need a python
> DBUS library for that. More installs ensue...
> 
> Eventually, after an hour of endless compiles, configuration of DBUS,
> getting to know the python scripts, etc. pp., the user is finally ready
> to start configuring DBUS.
> 
> "I could have written that config twice in that time, and would actually
> have had a clue what I configured", thinks the user.
> 
> But BlueZ doesn't think so. BlueZ knows convenience, and it will rub it
> into the user's face, whether he wants it or not.
> 
> Are we done? The user successfully configured BlueZ, paired his devices
> with the Python scripts. Although the user appreciates how bitterly
> elegant BlueZ' approach as configuration is, installing all of X.org
> just to get the GUI frontends working was a little too much for him to
> accept. Especially since he never wanted a frontend anyway. But BlueZ
> wanted it, so he did.

Good that you fully understand how Bluetooth pairing works and what
needs to be done to do it. If you do not trust bluetoothd, then please
don't use it. Feel free to implement your own one. And if you install a
UI frontend for pairing purposes where BlueZ ships with a simple C
example for doing this, then you clearly got lost again.

> Three months later, the user already forgot about the hassle he had
> with BlueZ' sadistic convenience and is happily using his bluetooth
> keyboard. Sadly, he has to re-setup his box.
> 
> LUCKILY, Linux is configured through configuration files. So he backs up
> his configuration files, but wait, BlueZ! No, BlueZ is better than that.
> BlueZ cannot be backed up, because BlueZ is ELEGANT. BlueZ is configured
> through DBUS, did you forget? Actually he had, just as he had forgotten
> about how to set it up. Here we go again, "how convenient" thinks the
> user.
> 
> And all so elegant.

Yes, it is super elegant, because it can be backed up. BlueZ
configuration is persistent. It is that smart.

As other pointed out all configuration is stored in really simple text
files under /var/lib/bluetooth where everybody would look first that
have a clue on a Linux filesystem hierarchy is build.

> This should be an appeal to you to perhaps re-evaluate that design
> choise, for that user is not alone. I am that user. So are others.
> BlueZ' obsession with DBUS and obscuring things from the user, allegedly
> for the user's sake, are actually a self-centered attempt at being
> advanced, disregarding practicability and conformity.

Feel free to improve it. Patches for D-Bus command line utilities
written in C are always welcome. You do not need Python or any kind of
UI to configure BlueZ. But do me favor and stop your non-sense of trying
to do pairing via configuration files. That is not how that whole
mechanism used to work or will ever work in the future.

Regards

Marcel


