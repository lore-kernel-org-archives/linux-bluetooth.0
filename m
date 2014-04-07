Return-Path: <cyrus@holtmann.org>
Date: Mon, 7 Apr 2014 10:45:35 +0300
From: Johan Hedberg <johan.hedberg@gmail.com>
To: Tobias Jakobi <liquid.acid@gmx.net>
Cc: Anderson Lizardo <anderson.lizardo@openbossa.org>,
	BlueZ development <linux-bluetooth@vger.kernel.org>
Subject: Re: [bluez-5.14] connect fails with 'org.bluez.Error.NotAvailable'
Message-ID: <20140407074535.GA8112@t440s.lan>
References: <530FBB6B.8080300@gmx.net>
 <CAJdJm_P9FD+NwSAfG=1bWg0Ep2Ku7eTqwpLN2aX6p5-+rc=3sA@mail.gmail.com>
 <5310BFEF.8010405@gmx.net>
 <CAJdJm_PVX=97RPVUJ5qx9k-OFNt=xidLrwgL6qK9QTTRBJHd+Q@mail.gmail.com>
 <53137E6E.7080305@gmx.net>
 <534179D4.4040607@gmx.net>
 <5341D403.8050001@gmx.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <5341D403.8050001@gmx.net>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Tobias,

On Mon, Apr 07, 2014, Tobias Jakobi wrote:
> I think I isolated the issue. The problem is that the profiles that are
> associated to the NAP, PANU and GN services haven't got the auto_connect
> flag set.
> 
> So during connect_profiles() they're never considered, and there is no
> way to change this via the cmdline tools. Which effectively disables
> this functionality.
> 
> Maybe the DBus interface can change these setting for built-in profiles,
> but you honestly can't expect the enduser to fiddle around with that.

There is actually another D-Bus method that can be used to connect any
profile, regardless of the auto_connect value: Device1.ConnectProfile().

The test-device script already supports it by doing something like
"test-device connect <addr> nap" instead of "test-device connect <addr>".
I think it might be a good idea to extend bluetoothctl to support the
same.

Johan
