Return-Path: <bluez-devel-admin@lists.sourceforge.net>
From: "Jan J. Jessen" <jjjessen@control.auc.dk>
To: bluez-devel@lists.sourceforge.net
Message-ID: <Pine.GSO.4.40.0308150819560.15387-100000@prosit.control.auc.dk>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Subject: [Bluez-devel] Digianswer USB driver
Sender: bluez-devel-admin@lists.sourceforge.net
Errors-To: bluez-devel-admin@lists.sourceforge.net
List-Help: <mailto:bluez-devel-request@lists.sourceforge.net?subject=help>
List-Post: <mailto:bluez-devel@lists.sourceforge.net>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-devel>,
	<mailto:bluez-devel-request@lists.sourceforge.net?subject=subscribe>
List-Id: <bluez-devel.lists.sourceforge.net>
List-Unsubscribe: 
	<https://lists.sourceforge.net/lists/listinfo/bluez-devel>,
	<mailto:bluez-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: 
	<http://sourceforge.net/mailarchive/forum.php?forum=bluez-devel>
Date: Fri, 15 Aug 2003 08:25:35 +0200 (MEST)

Hi
During my master thesis, I wrote a custom Linux USB Bluetooth driver to
comply with my specific needs. I did this because I couldn't get bluez
working. The hardware that was available to me, was some development
boards from Digianswer a subsidiary of Motorola. They couldn't provide
much help, since their official driver is for Microsoft products, and they
have outsourced the development of their driver to another company in
Denmark.

So I just wrote my own driver according to the Bluetooth USB specification
and the spec for USB 1.1, and basically found that my driver didn't
work:-(

A sniff program on a Windows computer then revealed that Digianswer for
some strange reason uses a different value for their control requests,
than what is expected. I changed my #define to the correct value, and my
driver worked perfectly.

Later I tried to change the value, just to see if I could get bluez
working, and I succeeded:-)

in hci_usb.h
change
#define HCI_CTRL_REQ         0x20
to
#define HCI_CTRL_REQ         0x40

And everything works just fine. Though it was a development board that I
used, this change can possibly make bluez work with other Digianswer USB
hardware stated as "not working" with Bluez

Maybe there could be a note on the webpage to potential users of
Digianswer hardware, that this small hack could work?


Best regards, Jan Jakob
------------------------------------
Jan Jakob Jessen
Ph.D. Student, M.Sc.E.E.
Center for Embedded Software Systems
Aalborg University
Fredrik Bajers Vej 7C, B2-212
DK-9220 Aalborg East



-------------------------------------------------------
This SF.Net email sponsored by: Free pre-built ASP.NET sites including
Data Reports, E-commerce, Portals, and Forums are available now.
Download today and enter to win an XBOX or Visual Studio .NET.
http://aspnet.click-url.com/go/psa00100003ave/direct;at.aspnet_072303_01/01
_______________________________________________
Bluez-devel mailing list
Bluez-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-devel
