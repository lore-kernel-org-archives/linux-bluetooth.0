Return-Path: <bluez-devel-admin@lists.sourceforge.net>
Subject: Re: [Bluez-devel] [PATCH] Bluetooth address specific device
	configuration
From: Fredrik Noring <noring@nocrew.org>
To: Achim Bohnet <ach@mpe.mpg.de>
Cc: BlueZ Mailing List <bluez-devel@lists.sourceforge.net>
In-Reply-To: <200401290016.05166.ach@mpe.mpg.de>
References: <1075316178.553.18.camel@akka.yeti.nocrew.org>
	 <1075317841.553.22.camel@akka.yeti.nocrew.org>
	 <200401290016.05166.ach@mpe.mpg.de>
Content-Type: text/plain
Message-Id: <1075400957.22564.42.camel@akka.yeti.nocrew.org>
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
Date: Thu, 29 Jan 2004 19:29:17 +0100

Hi Achim,

tor 2004-01-29 klockan 00.16 skrev Achim Bohnet:
> I've a laptop with buildin bt and an external bt stick.  It depends on the
> order I switch internal one on or connect the stick what interface is
> assigned to the same hardware.  If there is a need (no idea yet I'm
> a bt newbie) for this feature selection by bdaddr is therefore useful
> to support.  Selection by interface would be useless for me.

I think combining all three possibilities is the best:

	device <bdaddr>
	{
		# This is the configuration for all
		# devices that have matching bdaddr:s.
	}

	device <hci interface>
	{
		# This is the configuration for all devices 
		# that have matching interfaces but no matching 
		# bdaddr.
	}

	device
	{
		# This is the configuration for all devices 
		# that don't match anything else: the default.
	}

This way one can mix and move devices around and hcid will do its
best to configure things properly.

Having a utility (e.g. config-bluetooth) managing all these
configurations simpifies things, of course.

> On the other hand if I ever take the another identical stick with me
> by accident, bdaddr would be different  and the settings would not
> apply without a notice.  Maybe a 
> 
> 	device default
> 	{
> 	    complain loudly
> 	}
> 
> is useful ;)

Well, simply having

	device
	{
		# Default configuration.
	}

already works today. :)

Fredrik




-------------------------------------------------------
The SF.Net email is sponsored by EclipseCon 2004
Premiere Conference on Open Tools Development and Integration
See the breadth of Eclipse activity. February 3-5 in Anaheim, CA.
http://www.eclipsecon.org/osdn
_______________________________________________
Bluez-devel mailing list
Bluez-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-devel
