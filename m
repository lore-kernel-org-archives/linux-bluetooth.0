Return-Path: <cyrus@holtmann.org>
Subject: RE: udev rule bluetooth.rules
From: Marcel Holtmann <marcel@holtmann.org>
To: Bastien Nocera <hadess@hadess.net>
Cc: John Frankish <j-frankish@slb.com>,
	"linux-bluetooth@vger.kernel.org" <linux-bluetooth@vger.kernel.org>
In-Reply-To: <1246970189.2035.2.camel@snoogens.fab.redhat.com>
References: <6AC5A55546F64545AE996F8200E3AC4E06CCC1A4@NL0105EXC01V01.eur.slb.com>
	 <20090705133259.1bb7bad7@stoetzler>
	 <6AC5A55546F64545AE996F8200E3AC4E06CCC380@NL0105EXC01V01.eur.slb.com>
	 <6AC5A55546F64545AE996F8200E3AC4E06CCC77E@NL0105EXC01V01.eur.slb.com>
	 <1246901496.12994.232.camel@localhost.localdomain>
	 <1246970189.2035.2.camel@snoogens.fab.redhat.com>
Content-Type: text/plain
Date: Wed, 08 Jul 2009 11:26:10 -0700
Message-Id: <1247077570.9709.0.camel@localhost.localdomain>
Mime-Version: 1.0
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Bastien,

> > > > Ref bluez-4.43 /etc/udev/bluetooth.rules:
> > > >
> > > > # Run helper every time a Bluetooth device appears
> > > > # On remove actions, bluetoothd should go away by itself
> > > > ACTION=="add", SUBSYSTEM=="bluetooth", RUN+="/usr/sbin/bluetoothd
> > > > --udev"
> > > >
> > > > Shouldn't this be of the format /etc/udev/rules.d/xx-bluetooth.rules
> > > > so that it starts in the correct order - i.e. after dbus?
> > > 
> > > That's taken care of - if dbus is not available, bluetoothd will exit
> > > with return code 1. udev will notice that and later start it again in
> > > the coldplug run.
> > > 
> > > > if dbus is not started, I need to do this:
> > > > # udevtrigger --subsystem-match=bluetooth
> > > > is this is what was meant by "coldplug run"?
> > > --
> > > Thanks - I'd been playing around with this as /etc/udev/rules.d/85-bluetooth.rules but hadn't got around to trying without dbus started - it works for me with dbus started.
> > > 
> > > It would be nice if "--prefix=/usr/local" were passed to bluetooth.rules to give:
> > > 
> > > ACTION=="add", SUBSYSTEM=="bluetooth", RUN+="/usr/local/sbin/bluetoothd
> > 
> > I fixed that now and we generate bluetooth.rules with the correct
> > prefix.
> 
> The UDEV_DATADIR code is broken:
> 
> 
> 114         UDEV_DATADIR="`$PKG_CONFIG --variable=udevdir udev`/rules.d"
> 115         if (test -z "${UDEV_DATADIR}"); then
> 116                 UDEV_DATADIR="${sysconfdir}/udev/rules.d"
> 117         fi
> 
> UDEV_DATADIR will never be empty, because it will contain at least
> "/rules.d".

fixed with bluez-4.45 release. Thanks for reminding me about a
brown-paper-bag ;)

Regards

Marcel


