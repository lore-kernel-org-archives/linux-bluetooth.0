Return-Path: <cyrus@holtmann.org>
From: John Frankish <j-frankish@slb.com>
To: "linux-bluetooth@vger.kernel.org" <linux-bluetooth@vger.kernel.org>
Date: Mon, 6 Jul 2009 08:52:07 +0200
Subject: RE: udev rule bluetooth.rules
Message-ID: <6AC5A55546F64545AE996F8200E3AC4E06CCC77F@NL0105EXC01V01.eur.slb.com>
References: <6AC5A55546F64545AE996F8200E3AC4E06CCC1A4@NL0105EXC01V01.eur.slb.com>
	 <1246811096.12994.213.camel@localhost.localdomain>
	 <1246813882.2156.0.camel@snoogens.fab.redhat.com>
 <1246813979.12994.220.camel@localhost.localdomain>
In-Reply-To: <1246813979.12994.220.camel@localhost.localdomain>
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>


> > > Ref bluez-4.43 /etc/udev/bluetooth.rules:
> > >
> > > # Run helper every time a Bluetooth device appears
> > > # On remove actions, bluetoothd should go away by itself
> > > ACTION=="add", SUBSYSTEM=="bluetooth", RUN+="/usr/sbin/bluetoothd --udev"
> > >
> > > Shouldn't this be of the format /etc/udev/rules.d/xx-bluetooth.rules so that it starts in the correct order - i.e. after dbus?
> > >
> > > Is it possible to have a udev rule check that dbus is running before executing?
> >
> > you are right. I should have fixed this. Just forgot about it. What
> > number prefix do we want for Bluetooth.
>
> You don't need the prefix. D-Bus isn't started through udev...

we don't need it, but we should be nice and add it anyway. I pushed a
fix for that. BlueZ being the only project not following conventions
here is a bad idea.

> Using /etc/udev/rules.d/97-bluetooth with bluez-4.43 does indeed load all required
> modules and start bluetoothd as soon as I use the hardware switch to enable Bluetooth
>
> Thanks, John


