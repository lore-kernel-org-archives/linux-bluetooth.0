Return-Path: <bluez-devel-admin@lists.sourceforge.net>
Subject: Re: [Bluez-devel] Pairing fails with RFCOMM
From: Marcel Holtmann <marcel@holtmann.org>
To: Nils Faerber <nils.faerber@kernelconcepts.de>
Cc: bluez-devel@lists.sf.net
In-Reply-To: <1076342698.1167.90.camel@localhost>
References: <1076087010.964.75.camel@localhost>
	 <1076097441.14418.40.camel@pegasus>  <1076337219.2892.57.camel@localhost>
	 <1076338869.6869.174.camel@pegasus>  <1076339124.1169.67.camel@localhost>
	 <1076339281.6869.176.camel@pegasus>  <1076340484.1167.79.camel@localhost>
	 <1076342193.6869.205.camel@pegasus>  <1076342698.1167.90.camel@localhost>
Content-Type: text/plain
Message-Id: <1076343254.6869.214.camel@pegasus>
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
Date: Mon, 09 Feb 2004 17:14:14 +0100

Hi Nils,

> This has already been solved, sorry for bothering.
> My problem was that bthid is not very verbose unless you look into the
> daemon-log - I did not :(
> So I did not see that it already had connected upon first try! All other
> tries after that failed of course.
> BTW: "bthid -l" did not show this connection so there is still some
> glitch...

I know, there is much more work to do ;)

> BTW: The dongle in use is the EPOX USB dongle from the
> keyboard-mouse-dongle package. Switching from HID to HCI also worked
> like a charm - well done!

Thanks. And even the Logitech dongle can be switched. Some Apple iBooks
should also work like this.

> Now I only have to figure out how to force the pairing on the keyboard.
> >From what I know it should work in a way that you can input the pin on
> the keyboard. But I can simply connect to it without authentication...

That is one of the problems that must be solved. If you read the HID
specification then you will see that the host stack is responsible for
doing the authentication. But you can't enable auth per se, because the
connection to a mouse must be done (the Apple mouse is the exception)
without authentication and encryption. So you must first identify the
type of the HID device. This can be done through the class of device
value on incoming connection, but we don't make this value accessable
from userspace in BlueZ. Or you use the HID descriptor and then issue a
HCI_Authenticate command if it is a keyboard.

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
