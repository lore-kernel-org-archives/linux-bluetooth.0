Return-Path: <bluez-devel-admin@lists.sourceforge.net>
Subject: Re: [Bluez-devel] Digianswer USB driver
From: Marcel Holtmann <marcel@rvs.uni-bielefeld.de>
To: "Jan J. Jessen" <jjjessen@control.auc.dk>
Cc: BlueZ Mailing List <bluez-devel@lists.sourceforge.net>
In-Reply-To: 
	<Pine.GSO.4.40.0308150819560.15387-100000@prosit.control.auc.dk>
References: <Pine.GSO.4.40.0308150819560.15387-100000@prosit.control.auc.dk>
Message-Id: <1060951166.952.57.camel@pegasus>
Mime-Version: 1.0
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
Date: 15 Aug 2003 14:39:20 +0200
Content-Type: text/plain

Hi Jan,

> During my master thesis, I wrote a custom Linux USB Bluetooth driver to
> comply with my specific needs. I did this because I couldn't get bluez
> working. The hardware that was available to me, was some development
> boards from Digianswer a subsidiary of Motorola. They couldn't provide
> much help, since their official driver is for Microsoft products, and they
> have outsourced the development of their driver to another company in
> Denmark.
> 
> So I just wrote my own driver according to the Bluetooth USB specification
> and the spec for USB 1.1, and basically found that my driver didn't
> work:-(
> 
> A sniff program on a Windows computer then revealed that Digianswer for
> some strange reason uses a different value for their control requests,
> than what is expected. I changed my #define to the correct value, and my
> driver worked perfectly.
> 
> Later I tried to change the value, just to see if I could get bluez
> working, and I succeeded:-)
> 
> in hci_usb.h
> change
> #define HCI_CTRL_REQ         0x20
> to
> #define HCI_CTRL_REQ         0x40
> 
> And everything works just fine. Though it was a development board that I
> used, this change can possibly make bluez work with other Digianswer USB
> hardware stated as "not working" with Bluez
> 
> Maybe there could be a note on the webpage to potential users of
> Digianswer hardware, that this small hack could work?

thanks for this information. I always tried to get my hands on the
Digianswer Bluetooth devices, but I never got one. Do you have a spare
one for me?

Changing the bRequestType is such an ugly hack, but on the other side it
is a very simple change to get these devices supported by hci_usb. I
will write a patch for supporting Digianswer devices and H:2 Bluetooth
devices at the same time, but I need some more information about the
your device. Please send me the output of "cat /proc/bus/usb/devices"
and "hciconfig -a".

Regards

Marcel




-------------------------------------------------------
This SF.Net email sponsored by: Free pre-built ASP.NET sites including
Data Reports, E-commerce, Portals, and Forums are available now.
Download today and enter to win an XBOX or Visual Studio .NET.
http://aspnet.click-url.com/go/psa00100003ave/direct;at.aspnet_072303_01/01
_______________________________________________
Bluez-devel mailing list
Bluez-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-devel
