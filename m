Return-Path: <dwmw2@infradead.org>
Subject: Re: [Bluez-devel] DB aliases (wishlist)
From: David Woodhouse <dwmw2@infradead.org>
To: Marcel Holtmann <marcel@rvs.uni-bielefeld.de>
Cc: Paul Hedderly <bulkpaul@mjr.org>, BlueZ Mailing List <bluez-users@lists.sourceforge.net>, BlueZ Mailing List <bluez-devel@lists.sourceforge.net>
In-Reply-To: <1049751844.11258.31.camel@pegasus.local>
References: <20030404072437.GD8317@wacka.mjr.org>
	<1049751844.11258.31.camel@pegasus.local>
Content-Type: text/plain
Message-Id: <1049874960.31462.20.camel@passion.cambridge.redhat.com>
Mime-Version: 1.0
Date: Wed, 09 Apr 2003 08:56:00 +0100
List-ID: <bluez-devel.lists.sourceforge.net>

On Mon, 2003-04-07 at 22:43, Marcel Holtmann wrote:
> So this is a basic request to all of you. What do you want to see in the
> next version of the BlueZ utils?

Link key management.

hcitool lk list [<dev>|<bdaddr>] [<bdaddr>]
hcitool lk remove [<dev>|<bdaddr>] <bdaddr>...
hcitool lk add [<dev>|<bdaddr>] <bdaddr> <key>
hcitool lk merge <filename>

See xauth :)

I'm tired of manually copying link keys from /etc/bluetooth/link_key
from one machine to another when I move the CF Bluetooth card. I want to
be able to 'hcitool lk list | ssh ipaq hcitool lk merge -' ;)

OK, so buying another card would also help, but even so we do need at
least the 'hcitool lk remove' functionality and 'lk list' would be very
useful too.

As previously discussed, it would be nice if non-root users could see
the results of 'lk list' without the actual keys -- basically just a
list of devices with which we're paired.

/etc/bluetooth/paired_devices and /etc/bluetooth/paired_devices.shadow,
anyone? :)

-- 
dwmw2
