Return-Path: <cyrus@holtmann.org>
Subject: Re: "org.bluez.Adapter" doesn't exist
From: Bastien Nocera <hadess@hadess.net>
To: David Stockwell <dstockwell@frequency-one.com>
Cc: Doug Moeller <dmoeller@autonetmobile.com>,
	linux-bluetooth@vger.kernel.org
In-Reply-To: <630BE65F03C54798A34D8F9364A9C25D@freqonedev>
References: <1248254976-12090-1-git-send-email-gustavo@las.ic.unicamp.br>
	 <1248254976-12090-2-git-send-email-gustavo@las.ic.unicamp.br>
	 <1248256296.28545.124.camel@violet> <4A6A59F6.5000102@autonetmobile.com>
	 <630BE65F03C54798A34D8F9364A9C25D@freqonedev>
Content-Type: text/plain
Date: Sat, 25 Jul 2009 07:52:30 +0100
Message-Id: <1248504750.23466.6981.camel@localhost.localdomain>
Mime-Version: 1.0
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

On Fri, 2009-07-24 at 21:19 -0500, David Stockwell wrote:
> Hello, Doug
> 
> From: "Doug Moeller" <dmoeller@autonetmobile.com>
> > I've been beating my head against this for hours.  My end game is to 
> > get Bluetooth audio going,  but I'm stuck just trying to get the 
> > interface discoverable.  If anyone is willing to share any clues I'd 
> > really appreciate it.
> >
> > -Doug
> >
> >
> > # dbus-send --system --type=method_call --print-reply --dest=org.bluez 
> > /org/bluez/hci0 org.bluez.Adapter.GetMode
> > Error org.freedesktop.DBus.Error.UnknownMethod: Method "GetMode" with 
> > signature "" on interface "org.bluez.Adapter" doesn't exist
> >
> >
> > Bluetoothd output
> >
> >
> > # bluetoothd -dn
> > bluetoothd[18625]: Bluetooth daemon 4.38
> 
> First thing I would look at is catching up with the current version of 
> the BT daemon, which is now 4.46 (BlueZ is a work in progress).

BlueZ is as much a work in progress as any other piece of software. It's
supposed to be stable, and isn't the cause of the problems anyway.

The object path is wrong. Try using D-Feet to see the object paths.
(hint: it should read /org/bluez/$(pidof bluetoothd)/hci0)

