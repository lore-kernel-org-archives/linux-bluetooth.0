Return-Path: <bluez-devel-admin@lists.sourceforge.net>
Subject: Re: [Bluez-devel] D-BUS fixes for hcid
From: Marcel Holtmann <marcel@holtmann.org>
To: Johan Hedberg <johan.hedberg@nokia.com>
Cc: BlueZ Mailing List <bluez-devel@lists.sourceforge.net>
In-Reply-To: <20040616134631.GA8789@kone>
References: <20040616112702.GA898@kone> <1087385828.4309.3.camel@pegasus>
	 <20040616115718.GA8420@kone> <1087388298.4309.10.camel@pegasus>
	 <20040616124541.GA8629@kone> <1087391183.4309.13.camel@pegasus>
	 <20040616134631.GA8789@kone>
Content-Type: text/plain
Message-Id: <1087394020.4309.21.camel@pegasus>
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
Date: Wed, 16 Jun 2004 15:53:40 +0200

Hi Johan,

> > if we change it this way, then how do the D-Bus PIN Helper get its
> > information about the running X server?
> 
> Good question ;-). One option is to hardcode DISPLAY=:0 to the
> pin-helper. Another one (probably better) is to start the D-BUS daemon
> with some default DISPLAY environment variable (which its child
> processes will inherit). How is this done with the old pin-helper
> design where hcid execs the pin-helper?

this was exactly the problem with old PIN helper and this is why the
D-Bus version should be started from .xession user script.

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
