Return-Path: <bluez-devel-admin@lists.sourceforge.net>
Subject: Re: [Bluez-devel] D-BUS fixes for hcid
From: Marcel Holtmann <marcel@holtmann.org>
To: Johan Hedberg <johan.hedberg@nokia.com>
Cc: Achim Bohnet <ach@mpe.mpg.de>,
   BlueZ Mailing List <bluez-devel@lists.sourceforge.net>
In-Reply-To: <20040617094802.GA4566@kone>
References: <20040616112702.GA898@kone> <20040616124541.GA8629@kone>
	 <1087391183.4309.13.camel@pegasus> <200406161558.56578.ach@mpe.mpg.de>
	 <20040616141845.GA8921@kone> <1087399222.4309.26.camel@pegasus>
	 <20040617094802.GA4566@kone>
Content-Type: text/plain
Message-Id: <1087473910.23809.14.camel@localhost>
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
Date: Thu, 17 Jun 2004 14:05:10 +0200

Hi Johan,

> > > It would be nice to know how the D-BUS designers have thought about
> > > this kinds of problems.
> > 
> > feel free to come up with a solution for this.
> 
> Unfortunately I don't have one. Would it still be possible to add the
> dbus_message_set_auto_activation function call to the code? This will
> not change the behaviour in any way if the service is already aquired
> (i.e. bluez-pin is running), but will allow more flexibility if someone
> decides that they want to use D-BUS activation (for example in an
> embeded system where you only have one display and don't want to have
> unecessary processes taking up memory all the time).

right now I don't see where this helps. If you work embedded, you don't
need the D-Bus support. Use the old PIN helper stuff and write a shell
script or program that handles the input of the PINs.

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
