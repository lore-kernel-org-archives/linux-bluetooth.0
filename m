Return-Path: <cyrus@holtmann.org>
Subject: RE: udev rule bluetooth.rules
From: Bastien Nocera <hadess@hadess.net>
To: Marcel Holtmann <marcel@holtmann.org>
Cc: John Frankish <j-frankish@slb.com>,
        "linux-bluetooth@vger.kernel.org" <linux-bluetooth@vger.kernel.org>
In-Reply-To: <1246901496.12994.232.camel@localhost.localdomain>
References: 
	 <6AC5A55546F64545AE996F8200E3AC4E06CCC1A4@NL0105EXC01V01.eur.slb.com>
	 <20090705133259.1bb7bad7@stoetzler>
	 <6AC5A55546F64545AE996F8200E3AC4E06CCC380@NL0105EXC01V01.eur.slb.com>
	 <6AC5A55546F64545AE996F8200E3AC4E06CCC77E@NL0105EXC01V01.eur.slb.com>
	 <1246901496.12994.232.camel@localhost.localdomain>
Content-Type: text/plain
Date: Tue, 07 Jul 2009 13:36:29 +0100
Message-Id: <1246970189.2035.2.camel@snoogens.fab.redhat.com>
Mime-Version: 1.0
List-ID: <linux-bluetooth.vger.kernel.org>

On Mon, 2009-07-06 at 10:31 -0700, Marcel Holtmann wrote:
> Hi John,
> 
> > > Ref bluez-4.43 /etc/udev/bluetooth.rules:
> > >
> > > # Run helper every time a Bluetooth device appears
> > > # On remove actions, bluetoothd should go away by itself
> > > ACTION=="add", SUBSYSTEM=="bluetooth", RUN+="/usr/sbin/bluetoothd
> > > --udev"
> > >
> > > Shouldn't this be of the format /etc/udev/rules.d/xx-bluetooth.rules
> > > so that it starts in the correct order - i.e. after dbus?
> > 
> > That's taken care of - if dbus is not available, bluetoothd will exit
> > with return code 1. udev will notice that and later start it again in
> > the coldplug run.
> > 
> > > if dbus is not started, I need to do this:
> > > # udevtrigger --subsystem-match=bluetooth
> > > is this is what was meant by "coldplug run"?
> > --
> > Thanks - I'd been playing around with this as /etc/udev/rules.d/85-bluetooth.rules but hadn't got around to trying without dbus started - it works for me with dbus started.
> > 
> > It would be nice if "--prefix=/usr/local" were passed to bluetooth.rules to give:
> > 
> > ACTION=="add", SUBSYSTEM=="bluetooth", RUN+="/usr/local/sbin/bluetoothd
> 
> I fixed that now and we generate bluetooth.rules with the correct
> prefix.

The UDEV_DATADIR code is broken:


114         UDEV_DATADIR="`$PKG_CONFIG --variable=udevdir udev`/rules.d"
115         if (test -z "${UDEV_DATADIR}"); then
116                 UDEV_DATADIR="${sysconfdir}/udev/rules.d"
117         fi

UDEV_DATADIR will never be empty, because it will contain at least
"/rules.d".

Cheers
