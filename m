Return-Path: <sjoerd@spring.luon.net>
Date: Thu, 17 Jun 2004 09:27:49 +0200
To: bluez-devel@lists.sourceforge.net
Cc: Achim Bohnet <ach@mpe.mpg.de>, Marcel Holtmann <marcel@holtmann.org>
Subject: Re: [Bluez-devel] D-BUS fixes for hcid
Message-ID: <20040617072748.GA3775@spring.luon.net>
References: <20040616112702.GA898@kone> <20040616124541.GA8629@kone> <1087391183.4309.13.camel@pegasus> <200406161558.56578.ach@mpe.mpg.de> <20040616141845.GA8921@kone>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20040616141845.GA8921@kone>
From: sjoerd@spring.luon.net (Sjoerd Simons)
List-ID: <bluez-devel.lists.sourceforge.net>

On Wed, Jun 16, 2004 at 05:18:45PM +0300, Johan Hedberg wrote:
> On Wed, Jun 16, 2004, Achim Bohnet wrote:
> > On debian, dbus-1-utils installs a xsession startup script
> > that checks for use-session-dbus in /etc/X11/Xsession.options
> > Therefore dbus daemon knows the $DISPLAY.

$DISPLAY is indeed in the enviroment when started by the debian x-session. But
dbus doesn't (and shouldn't) care about it. There is nothing that says
that a dbus session bus is connected to an X session (could be console
only session just as well)..

> However, hcid uses the system D-BUS which knows nothing about the
> session (system D-BUS and session D-BUS are run as two separate
> processes). This is an interesting problem, because from a lowlevel
> (BT-stack) standpoint we want to use the system bus, but from a higher
> level (pin-code dialog) standpoint the session bus would be apropriate.

 From both standpoints you'll want to use the system bus. A bluetooth pin query
 is not linked to a specific users session, but to complete system.

 The current sollution is correct imho, when a users wants to answer pin
 queries he/she should have something running that monitors the system bus for
 them.  That something could be a gnome applet/notification icon, a kde
 thingie or a simple command line program that doesn't really matter.

 The activation stuff could be nice for non-interactive pin handlers, but you
 can already use the ``old'' pin_helper option of hcid for that.

  Sjoerd
-- 
Men love to wonder, and that is the seed of science.
