Return-Path: <Johan.Hedberg@nokia.com>
Date: Wed, 16 Jun 2004 17:18:45 +0300
From: Johan Hedberg <johan.hedberg@nokia.com>
To: Achim Bohnet <ach@mpe.mpg.de>
Cc: bluez-devel@lists.sourceforge.net, Marcel Holtmann <marcel@holtmann.org>
Subject: Re: [Bluez-devel] D-BUS fixes for hcid
Message-ID: <20040616141845.GA8921@kone>
References: <20040616112702.GA898@kone> <20040616124541.GA8629@kone> <1087391183.4309.13.camel@pegasus> <200406161558.56578.ach@mpe.mpg.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <200406161558.56578.ach@mpe.mpg.de>
List-ID: <bluez-devel.lists.sourceforge.net>

On Wed, Jun 16, 2004, Achim Bohnet wrote:
> On debian, dbus-1-utils installs a xsession startup script
> that checks for use-session-dbus in /etc/X11/Xsession.options
> Therefore dbus daemon knows the $DISPLAY.

However, hcid uses the system D-BUS which knows nothing about the
session (system D-BUS and session D-BUS are run as two separate
processes). This is an interesting problem, because from a lowlevel
(BT-stack) standpoint we want to use the system bus, but from a higher
level (pin-code dialog) standpoint the session bus would be apropriate.

It would be nice to know how the D-BUS designers have thought about
this kinds of problems.

> Johan:  When  2 xservers are running on vt7 as :0 and vt8 as :1
> respectively.   Do the 2 dbus daemons know which one is active?

No idea. But probably not.

Johan
