Return-Path: <cyrus@holtmann.org>
Subject: Re: udev rule bluetooth.rules
From: Bastien Nocera <hadess@hadess.net>
To: Marcel Holtmann <marcel@holtmann.org>
Cc: John Frankish <j-frankish@slb.com>,
        "linux-bluetooth@vger.kernel.org" <linux-bluetooth@vger.kernel.org>
In-Reply-To: <1246811096.12994.213.camel@localhost.localdomain>
References: 
	 <6AC5A55546F64545AE996F8200E3AC4E06CCC1A4@NL0105EXC01V01.eur.slb.com>
	 <1246811096.12994.213.camel@localhost.localdomain>
Content-Type: text/plain
Date: Sun, 05 Jul 2009 18:11:22 +0100
Message-Id: <1246813882.2156.0.camel@snoogens.fab.redhat.com>
Mime-Version: 1.0
List-ID: <linux-bluetooth.vger.kernel.org>

On Sun, 2009-07-05 at 09:24 -0700, Marcel Holtmann wrote:
> Hi John,
> 
> > Ref bluez-4.43 /etc/udev/bluetooth.rules:
> > 
> > # Run helper every time a Bluetooth device appears
> > # On remove actions, bluetoothd should go away by itself
> > ACTION=="add", SUBSYSTEM=="bluetooth", RUN+="/usr/sbin/bluetoothd --udev"
> > 
> > Shouldn't this be of the format /etc/udev/rules.d/xx-bluetooth.rules so that it starts in the correct order - i.e. after dbus?
> > 
> > Is it possible to have a udev rule check that dbus is running before executing?
> 
> you are right. I should have fixed this. Just forgot about it. What
> number prefix do we want for Bluetooth.

You don't need the prefix. D-Bus isn't started through udev...
