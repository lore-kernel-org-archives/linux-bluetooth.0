Return-Path: <bluez-devel-admin@lists.sourceforge.net>
Subject: Re: [Bluez-devel] Problems switching usb dongles...
From: Marcel Holtmann <marcel@holtmann.org>
To: Anthony Yulo <strikewing16th@hotmail.com>
Cc: bluez devel <bluez-devel@lists.sourceforge.net>
In-Reply-To: <LAW11-OE40QXgo3DUHB0002de10@hotmail.com>
References: <Law11-OE54SB2qgrZCT0000dbb9@hotmail.com>
	 <1074452313.6070.7.camel@pegasus> <Law11-OE684BEBqjIpl0000d1e9@hotmail.com>
	 <1074528420.6070.122.camel@pegasus>
	 <LAW11-OE40QXgo3DUHB0002de10@hotmail.com>
Content-Type: text/plain
Message-Id: <1074606630.7088.19.camel@pegasus>
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
Date: Tue, 20 Jan 2004 14:50:30 +0100

Hi Anthony,

> i did what u said .....
> anton@maverick rfcomm]# rmmod uhci && modprobe uhci
> 
> rmmod: module uhci is not loaded

maybe you are using the usb-uhci host driver. Try to unload and reload
this one.

Regards

Marcel




-------------------------------------------------------
The SF.Net email is sponsored by EclipseCon 2004
Premiere Conference on Open Tools Development and Integration
See the breadth of Eclipse activity. February 3-5 in Anaheim, CA.
http://www.eclipsecon.org/osdn
_______________________________________________
Bluez-devel mailing list
Bluez-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-devel
