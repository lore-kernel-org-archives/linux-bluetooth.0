Return-Path: <bluez-devel-admin@lists.sourceforge.net>
Subject: Re: [Bluez-devel] D-BUS fixes for hcid
From: Marcel Holtmann <marcel@holtmann.org>
To: Johan Hedberg <johan.hedberg@nokia.com>
Cc: BlueZ Mailing List <bluez-devel@lists.sourceforge.net>
In-Reply-To: <20040616112702.GA898@kone>
References: <20040616112702.GA898@kone>
Content-Type: text/plain
Message-Id: <1087385828.4309.3.camel@pegasus>
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
Date: Wed, 16 Jun 2004 13:37:08 +0200

Hi Johan,

> There are some problems with the current D-BUS pin-request handling in
> hcid. The attached patch tries to address those.

since I don't know very much about D-Bus, please explain your changes to
me. Why are they needed?

> Also, the bluez-pin package will need to provide a D-BUS service file
> (bluez.service) so that the D-BUS daemon can activate it when needed.
> This file goes usually in /usr/lib/dbus-1.0/services and it's contents
> should be something like the following:
> 
> [D-BUS Service]
> Name=org.bluez.PinAgent
> Exec=/usr/bin/bluez-pin
> 
> You'll also need the following line in /etc/dbus-1/system.conf (at least
> the debian package of D-BUS doesn't have it):
> <servicedir>/usr/lib/dbus-1.0/services</servicedir>

Don't get your point here, because it works perfect on my Debian Sid.

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
