Return-Path: <cyrus@holtmann.org>
Subject: Re: "org.bluez.Adapter" doesn't exist
From: Marcel Holtmann <marcel@holtmann.org>
To: Bastien Nocera <hadess@hadess.net>
Cc: David Stockwell <dstockwell@frequency-one.com>,
	Doug Moeller <dmoeller@autonetmobile.com>,
	linux-bluetooth@vger.kernel.org
In-Reply-To: <1248504750.23466.6981.camel@localhost.localdomain>
References: <1248254976-12090-1-git-send-email-gustavo@las.ic.unicamp.br>
	 <1248254976-12090-2-git-send-email-gustavo@las.ic.unicamp.br>
	 <1248256296.28545.124.camel@violet> <4A6A59F6.5000102@autonetmobile.com>
	 <630BE65F03C54798A34D8F9364A9C25D@freqonedev>
	 <1248504750.23466.6981.camel@localhost.localdomain>
Content-Type: text/plain
Date: Sat, 25 Jul 2009 13:05:40 +0200
Message-Id: <1248519940.28545.155.camel@violet>
Mime-Version: 1.0
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Bastien,

> > > # dbus-send --system --type=method_call --print-reply --dest=org.bluez 
> > > /org/bluez/hci0 org.bluez.Adapter.GetMode
> > > Error org.freedesktop.DBus.Error.UnknownMethod: Method "GetMode" with 
> > > signature "" on interface "org.bluez.Adapter" doesn't exist
> > >
> > >
> > > Bluetoothd output
> > >
> > >
> > > # bluetoothd -dn
> > > bluetoothd[18625]: Bluetooth daemon 4.38
> > 
> > First thing I would look at is catching up with the current version of 
> > the BT daemon, which is now 4.46 (BlueZ is a work in progress).
> 
> BlueZ is as much a work in progress as any other piece of software. It's
> supposed to be stable, and isn't the cause of the problems anyway.
> 
> The object path is wrong. Try using D-Feet to see the object paths.
> (hint: it should read /org/bluez/$(pidof bluetoothd)/hci0)

and if people start hard coding it, I will put a random number in it and
obfuscate it completely ;)

Regards

Marcel


