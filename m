Return-Path: <ach@mpe.mpg.de>
From: Achim Bohnet <ach@mpe.mpg.de>
To: sjoerd@spring.luon.net (Sjoerd Simons)
Subject: Re: [Bluez-devel] D-BUS fixes for hcid
Date: Fri, 18 Jun 2004 09:30:32 +0200
Cc: bluez-devel@lists.sourceforge.net, Marcel Holtmann <marcel@holtmann.org>
References: <20040616112702.GA898@kone> <20040616141845.GA8921@kone> <20040617072748.GA3775@spring.luon.net>
In-Reply-To: <20040617072748.GA3775@spring.luon.net>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Message-Id: <200406180930.32342.ach@mpe.mpg.de>
List-ID: <bluez-devel.lists.sourceforge.net>

On Thursday 17 June 2004 09:27, Sjoerd Simons wrote:
> On Wed, Jun 16, 2004 at 05:18:45PM +0300, Johan Hedberg wrote:
> > On Wed, Jun 16, 2004, Achim Bohnet wrote:
> > > On debian, dbus-1-utils installs a xsession startup script
> > > that checks for use-session-dbus in /etc/X11/Xsession.options
> > > Therefore dbus daemon knows the $DISPLAY.
> 
> $DISPLAY is indeed in the enviroment when started by the debian x-session. But
> dbus doesn't (and shouldn't) care about it. There is nothing that says
> that a dbus session bus is connected to an X session (could be console
> only session just as well)..

As long is dbus does not delete DISPLAY it's okay ;)  Child processes
inherit DISPLAY (if available) and that's the important point.  In
hotplug scripts you have to hardcode :0 (almost always wrong when
someone works in a second session on :1) or implement hack to find
out the right display.
> 
> > However, hcid uses the system D-BUS which knows nothing about the
> > session (system D-BUS and session D-BUS are run as two separate
> > processes). This is an interesting problem, because from a lowlevel
> > (BT-stack) standpoint we want to use the system bus, but from a higher
> > level (pin-code dialog) standpoint the session bus would be apropriate.
> 
>  From both standpoints you'll want to use the system bus. A bluetooth pin query
>  is not linked to a specific users session, but to complete system.
> 
>  The current sollution is correct imho, when a users wants to answer pin
>  queries he/she should have something running that monitors the system bus for
>  them.  That something could be a gnome applet/notification icon, a kde
>  thingie or a simple command line program that doesn't really matter.

That does not scale well.  Why does inetd exist? Just to not waste
resources.  Something similar for the desktop should exist!  We
have hotplug, on the one side and the desktop session on the other
side.  Maybe the design of dbus is too limited (or simply not designed
for it).  But AFAIK dbus can start apps on demand.   So

   hotplug -> system dbus -> session dbus -> desktop tool/applet

was (one of) my expectation of dbus.  Makes no sense that every
app needs to know about dbus protocol, when all that's needed is
just a 'desktop inetd' that start or notifies, e.g. via DCOP, an
application off a certain hotplug event.

But this get's off really topic, I'll check the dbus mailing
lists ...

Achim
> 
>  The activation stuff could be nice for non-interactive pin handlers, but you
>  can already use the ``old'' pin_helper option of hcid for that.
> 
>   Sjoerd
> -- 
> Men love to wonder, and that is the seed of science.
-- 
  To me vi is Zen.  To use vi is to practice zen. Every command is
  a koan. Profound to the user, unintelligible to the uninitiated.
  You discover truth everytime you use it.
                                      -- reddy@lion.austin.ibm.com
