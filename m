Return-Path: <cyrus@holtmann.org>
Subject: Re: False negative checking for SSP support
From: Bastien Nocera <hadess@hadess.net>
To: Marcel Holtmann <marcel@holtmann.org>
Cc: BlueZ development <linux-bluetooth@vger.kernel.org>
In-Reply-To: <1244921813.1852.2.camel@violet>
References: <1244919968.11069.4360.camel@localhost.localdomain>
	 <1244921813.1852.2.camel@violet>
Content-Type: text/plain
Date: Sat, 13 Jun 2009 20:45:55 +0100
Message-Id: <1244922355.11069.4410.camel@localhost.localdomain>
Mime-Version: 1.0
List-ID: <linux-bluetooth.vger.kernel.org>

On Sat, 2009-06-13 at 21:36 +0200, Marcel Holtmann wrote:
> Hi Bastien,
> 
> > I'm slowly adding SSP 2.1 support to gnome-bluetooth. For that, I got a
> > laptop running Fedora 11, with a Bluetooth 2.1 dongle, in addition to
> > the one in the machine I'm trying to pair from.
> > 
> > Is there any reason why the other machine shows up as not supporting
> > SSP, when it actually does?
> > 
> > We already handle that case in the wizard, but it would be nicer if it
> > did detect it.
> 
> it could be an older kernel or some other detail. Did you check with
> hciconfig hci0 sspmode that it is enabled on both sides? You can
> manually disable it (actually bluetoothd has to manually enable it).

SSP pairing works, between both machines, so I don't think that's the
problem (though the device creation never seems to finish).

> We might also have a bug in LegacyPairing property. Could be that it is
> not working correctly. Can you post dumps and further details.

It correctly detects a headset as being SSP. What kind of dumps do you
want? Just a dump on the computer that's initiating the pairing, from
the discovery process?

I'll update my bluez first on both machines, and test again.

Cheers
