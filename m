Return-Path: <cyrus@holtmann.org>
Subject: RE: udev rule bluetooth.rules
From: Marcel Holtmann <marcel@holtmann.org>
To: John Frankish <j-frankish@slb.com>
Cc: "linux-bluetooth@vger.kernel.org" <linux-bluetooth@vger.kernel.org>
In-Reply-To: <6AC5A55546F64545AE996F8200E3AC4E06CCC77E@NL0105EXC01V01.eur.slb.com>
References: <6AC5A55546F64545AE996F8200E3AC4E06CCC1A4@NL0105EXC01V01.eur.slb.com>
	 <20090705133259.1bb7bad7@stoetzler>
	 <6AC5A55546F64545AE996F8200E3AC4E06CCC380@NL0105EXC01V01.eur.slb.com>
	 <6AC5A55546F64545AE996F8200E3AC4E06CCC77E@NL0105EXC01V01.eur.slb.com>
Content-Type: text/plain
Date: Mon, 06 Jul 2009 10:31:36 -0700
Message-Id: <1246901496.12994.232.camel@localhost.localdomain>
Mime-Version: 1.0
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi John,

> > Ref bluez-4.43 /etc/udev/bluetooth.rules:
> >
> > # Run helper every time a Bluetooth device appears
> > # On remove actions, bluetoothd should go away by itself
> > ACTION=="add", SUBSYSTEM=="bluetooth", RUN+="/usr/sbin/bluetoothd
> > --udev"
> >
> > Shouldn't this be of the format /etc/udev/rules.d/xx-bluetooth.rules
> > so that it starts in the correct order - i.e. after dbus?
> 
> That's taken care of - if dbus is not available, bluetoothd will exit
> with return code 1. udev will notice that and later start it again in
> the coldplug run.
> 
> > if dbus is not started, I need to do this:
> > # udevtrigger --subsystem-match=bluetooth
> > is this is what was meant by "coldplug run"?
> --
> Thanks - I'd been playing around with this as /etc/udev/rules.d/85-bluetooth.rules but hadn't got around to trying without dbus started - it works for me with dbus started.
> 
> It would be nice if "--prefix=/usr/local" were passed to bluetooth.rules to give:
> 
> ACTION=="add", SUBSYSTEM=="bluetooth", RUN+="/usr/local/sbin/bluetoothd

I fixed that now and we generate bluetooth.rules with the correct
prefix.

Regards

Marcel


