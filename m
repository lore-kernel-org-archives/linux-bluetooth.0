Return-Path: <bluez-devel-admin@lists.sourceforge.net>
Subject: Re: [Bluez-devel] Pairing fails with RFCOMM
From: Marcel Holtmann <marcel@holtmann.org>
To: Nils Faerber <nils.faerber@kernelconcepts.de>
Cc: bluez-devel@lists.sf.net
In-Reply-To: <1076340484.1167.79.camel@localhost>
References: <1076087010.964.75.camel@localhost>
	 <1076097441.14418.40.camel@pegasus>  <1076337219.2892.57.camel@localhost>
	 <1076338869.6869.174.camel@pegasus>  <1076339124.1169.67.camel@localhost>
	 <1076339281.6869.176.camel@pegasus>  <1076340484.1167.79.camel@localhost>
Content-Type: text/plain
Message-Id: <1076342193.6869.205.camel@pegasus>
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
Date: Mon, 09 Feb 2004 16:56:33 +0100

Hi Nils,

> OK, maybe like this:
> ----->
> xx. RFCOMM connection using minicom or other tool fails, why?
> Problem: In case you have created the RFCOMM link using the "rfcomm
> bind" function this can be caused by application timeouts. This is not a
> problem of BlueZ or the RFCOMM implementation but rather a problem with
> the different nature of a RFCOMM virtual tty and a physical serial tty
> device which is normally used by those applications. Some applications
> implement a timeout protection function while opening the port. If
> opening the port takes longer than a certain amount of time then the
> application fails. A serial tty will usually only take several
> microseconds to open while the RFCOMM virtual tty can take several
> seconds. Additionally opening requires to create a connection to the
> remote Bluetooth device, closing the port closes the connection again.
> Application which open and close the port frequently may thus also fail!
> Solution: Try to create the connection before starting you application.
> This can be done by the "rfcomm connect" function. The Bluetooth
> connection will then remain until the rfcomm utility is stopped.
> <-----
> 
> A bit lengthy maybe ;)

thank you. I stripped a little bit and put it only ;)

> How does BT-HID mouse work?

The best is you follow this HOWTO

	http://www.bueche.ch/comp/mx900/mx900.html

And don't use the bthid from Peter Klausler until you patch it up.

> I have a BT mouse here but the bthid daemon does not connect to it nor
> can I connect another service like rfcomm to it...

RFCOMM will never work, because HID is only based on L2CAP.

> The accompanied keyboard works like a charm!

If the keyboard works, the mouse should work also.

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
