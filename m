Return-Path: <cyrus@holtmann.org>
Subject: Re: False negative checking for SSP support
From: Bastien Nocera <hadess@hadess.net>
To: Johan Hedberg <johan.hedberg@gmail.com>
Cc: BlueZ development <linux-bluetooth@vger.kernel.org>
In-Reply-To: <20090613194310.GA27600@jh-x301>
References: <1244919968.11069.4360.camel@localhost.localdomain>
	 <20090613194310.GA27600@jh-x301>
Content-Type: text/plain
Date: Sun, 14 Jun 2009 00:21:55 +0100
Message-Id: <1244935315.11069.4629.camel@localhost.localdomain>
Mime-Version: 1.0
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

On Sat, 2009-06-13 at 22:43 +0300, Johan Hedberg wrote:
> Hi Bastien,
> 
> On Sat, Jun 13, 2009, Bastien Nocera wrote:
> > I'm slowly adding SSP 2.1 support to gnome-bluetooth. For that, I got a
> > laptop running Fedora 11, with a Bluetooth 2.1 dongle, in addition to
> > the one in the machine I'm trying to pair from.
> > 
> > Is there any reason why the other machine shows up as not supporting
> > SSP, when it actually does?
> 
> Do both of the machines support 2.1? The LegacyPairing property tells you
> whether SSP is likely to be triggered or not when you try to pair. It
> doesn't tell you whether other device supports SSP or not e.g. if your
> local adapter is pre-2.1 (but if your local adapter is 2.1 capable the
> property should be a good indicator of SSP support).
> 
> In theory it is possible to get a false positive for LegacyPairing if the
> other device is 2.1 but for some reason has extended inquiry response
> disabled (iirc the spec mandates EIR if SSP is enabled). However, if both
> sides have bluez and 2.1 HW then both EIR and SSP should automatically be
> get enabled by bluetoothd. If that's not happening we may have a bug
> somewhere (which I haven't seen with any of my 2.1 adapters).

Both machines were running F-11, with the same kernel and versions of
bluez, and the same Belkin BT 2.1 adapter that has SSP working with
another 2.1 device.

The problem seems to have been fixed by me upgrading to bluez 4.40.
Either that or my tests weren't properly done.

In any cases, I'll know for next time.

Cheers

