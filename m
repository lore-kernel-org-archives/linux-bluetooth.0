Return-Path: <Johan.Hedberg@nokia.com>
Date: Wed, 16 Jun 2004 16:46:31 +0300
From: Johan Hedberg <johan.hedberg@nokia.com>
To: Marcel Holtmann <marcel@holtmann.org>
Cc: BlueZ Mailing List <bluez-devel@lists.sourceforge.net>
Subject: Re: [Bluez-devel] D-BUS fixes for hcid
Message-ID: <20040616134631.GA8789@kone>
References: <20040616112702.GA898@kone> <1087385828.4309.3.camel@pegasus> <20040616115718.GA8420@kone> <1087388298.4309.10.camel@pegasus> <20040616124541.GA8629@kone> <1087391183.4309.13.camel@pegasus>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1087391183.4309.13.camel@pegasus>
List-ID: <bluez-devel.lists.sourceforge.net>

On Wed, Jun 16, 2004, ext Marcel Holtmann wrote:
> if we change it this way, then how do the D-Bus PIN Helper get its
> information about the running X server?

Good question ;-). One option is to hardcode DISPLAY=:0 to the
pin-helper. Another one (probably better) is to start the D-BUS daemon
with some default DISPLAY environment variable (which its child
processes will inherit). How is this done with the old pin-helper
design where hcid execs the pin-helper?

Johan
