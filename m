Return-Path: <bluez-devel-admin@lists.sourceforge.net>
Subject: Re: [Bluez-devel] D-BUS fixes for hcid
From: Marcel Holtmann <marcel@holtmann.org>
To: Johan Hedberg <johan.hedberg@nokia.com>
Cc: Achim Bohnet <ach@mpe.mpg.de>,
   BlueZ Mailing List <bluez-devel@lists.sourceforge.net>
In-Reply-To: <20040616141845.GA8921@kone>
References: <20040616112702.GA898@kone> <20040616124541.GA8629@kone>
	 <1087391183.4309.13.camel@pegasus> <200406161558.56578.ach@mpe.mpg.de>
	 <20040616141845.GA8921@kone>
Content-Type: text/plain
Message-Id: <1087399222.4309.26.camel@pegasus>
Mime-Version: 1.0
Sender: bluez-devel-admin@lists.sourceforge.net
Errors-To: bluez-devel-admin@lists.sourceforge.net
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-devel>,
	<mailto:bluez-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Id: <bluez-devel.lists.sourceforge.net>
List-Post: <mailto:bluez-devel@lists.sourceforge.net>
List-Help: <mailto:bluez-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-devel>,
	<mailto:bluez-devel-request@lists.sourceforge.net?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=bluez-devel>
Date: Thu, 17 Jun 2004 01:06:08 +0200

Hi Johan,

> > On debian, dbus-1-utils installs a xsession startup script
> > that checks for use-session-dbus in /etc/X11/Xsession.options
> > Therefore dbus daemon knows the $DISPLAY.
> 
> However, hcid uses the system D-BUS which knows nothing about the
> session (system D-BUS and session D-BUS are run as two separate
> processes). This is an interesting problem, because from a lowlevel
> (BT-stack) standpoint we want to use the system bus, but from a higher
> level (pin-code dialog) standpoint the session bus would be apropriate.
> 
> It would be nice to know how the D-BUS designers have thought about
> this kinds of problems.

feel free to come up with a solution for this.

Regards

Marcel




-------------------------------------------------------
This SF.Net email is sponsored by The 2004 JavaOne(SM) Conference
Learn from the experts at JavaOne(SM), Sun's Worldwide Java Developer
Conference, June 28 - July 1 at the Moscone Center in San Francisco, CA
REGISTER AND SAVE! http://java.sun.com/javaone/sf Priority Code NWMGYKND
_______________________________________________
Bluez-devel mailing list
Bluez-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-devel
