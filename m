Return-Path: <ach@mpe.mpg.de>
From: Achim Bohnet <ach@mpe.mpg.de>
To: bluez-devel@lists.sourceforge.net
Subject: Re: [Bluez-devel] D-BUS fixes for hcid
Date: Wed, 16 Jun 2004 15:58:56 +0200
Cc: Marcel Holtmann <marcel@holtmann.org>,
   Johan Hedberg <johan.hedberg@nokia.com>
References: <20040616112702.GA898@kone> <20040616124541.GA8629@kone> <1087391183.4309.13.camel@pegasus>
In-Reply-To: <1087391183.4309.13.camel@pegasus>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="utf-8"
Message-Id: <200406161558.56578.ach@mpe.mpg.de>
List-ID: <bluez-devel.lists.sourceforge.net>

On Wednesday 16 June 2004 15:06, Marcel Holtmann wrote:
> Hi Johan,
> 
> > I must admit that I hadn't looked into how the bluez-pin program works
> > in D-BUS mode. It seems it should be running all the time to be able to
> > receive any D-BUS requests, correct?
> > 
> > The service activation feature of D-BUS which I have talked about is
> > designed to solve the problem where some D-BUS service should be
> > launched on-demand. I think the pin-helper falls exactly into this
> > category, and would be IMHO more elegant if it wouldn't have to be
> > running all the time but would be automatically launched by D-BUS daemon
> > when needed.

Agreed.

> if we change it this way, then how do the D-Bus PIN Helper get its
> information about the running X server?

On debian, dbus-1-utils installs a xsession startup script
that checks for use-session-dbus in /etc/X11/Xsession.options
Therefore dbus daemon knows the $DISPLAY.

Johan:  When  2 xservers are running on vt7 as :0 and vt8 as :1
respectively.   Do the 2 dbus daemons know which one is active?
(i.e. crt or lcd currently displays :0 or :1)  Would be nice to
get the pin helper window on :1 if one is working there instead
of on :0 ;)

Achim
> 
> Regards
> 
> Marcel
> 
> 
> 
> 
> -------------------------------------------------------
> This SF.Net email is sponsored by The 2004 JavaOne(SM) Conference
> Learn from the experts at JavaOne(SM), Sun's Worldwide Java Developer
> Conference, June 28 - July 1 at the Moscone Center in San Francisco, CA
> REGISTER AND SAVE! http://java.sun.com/javaone/sf Priority Code NWMGYKND
> _______________________________________________
> Bluez-devel mailing list
> Bluez-devel@lists.sourceforge.net
> https://lists.sourceforge.net/lists/listinfo/bluez-devel
> 
> 
> 

-- 
  To me vi is Zen.  To use vi is to practice zen. Every command is
  a koan. Profound to the user, unintelligible to the uninitiated.
  You discover truth everytime you use it.
                                      -- reddy@lion.austin.ibm.com
