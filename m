Return-Path: <Johan.Hedberg@nokia.com>
Date: Thu, 17 Jun 2004 12:48:02 +0300
From: Johan Hedberg <johan.hedberg@nokia.com>
To: Marcel Holtmann <marcel@holtmann.org>
Cc: Achim Bohnet <ach@mpe.mpg.de>,
   BlueZ Mailing List <bluez-devel@lists.sourceforge.net>
Subject: Re: [Bluez-devel] D-BUS fixes for hcid
Message-ID: <20040617094802.GA4566@kone>
References: <20040616112702.GA898@kone> <20040616124541.GA8629@kone> <1087391183.4309.13.camel@pegasus> <200406161558.56578.ach@mpe.mpg.de> <20040616141845.GA8921@kone> <1087399222.4309.26.camel@pegasus>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1087399222.4309.26.camel@pegasus>
List-ID: <bluez-devel.lists.sourceforge.net>

Hi Marcel,

On Thu, Jun 17, 2004, Marcel Holtmann wrote:
> > It would be nice to know how the D-BUS designers have thought about
> > this kinds of problems.
> 
> feel free to come up with a solution for this.

Unfortunately I don't have one. Would it still be possible to add the
dbus_message_set_auto_activation function call to the code? This will
not change the behaviour in any way if the service is already aquired
(i.e. bluez-pin is running), but will allow more flexibility if someone
decides that they want to use D-BUS activation (for example in an
embeded system where you only have one display and don't want to have
unecessary processes taking up memory all the time).

Johan
