Return-Path: <bluez-users-admin@lists.sourceforge.net>
Subject: Re: [Bluez-users] Bluez USB Driver
From: Marcel Holtmann <marcel@holtmann.org>
To: taylor <taylor@ms.usi.com.tw>
Cc: BlueZ Mailing List <bluez-users@lists.sourceforge.net>
In-Reply-To: <00cb01c488ba$82fc6490$df0618ac@USI08844>
References: <00cb01c488ba$82fc6490$df0618ac@USI08844>
Content-Type: text/plain
Message-Id: <1093334466.26717.55.camel@pegasus>
Mime-Version: 1.0
Sender: bluez-users-admin@lists.sourceforge.net
Errors-To: bluez-users-admin@lists.sourceforge.net
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-users>,
	<mailto:bluez-users-request@lists.sourceforge.net?subject=unsubscribe>
List-Id: <bluez-users.lists.sourceforge.net>
List-Post: <mailto:bluez-users@lists.sourceforge.net>
List-Help: <mailto:bluez-users-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-users>,
	<mailto:bluez-users-request@lists.sourceforge.net?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=bluez-users>
Date: Tue, 24 Aug 2004 10:01:06 +0200

Hi Taylor,

>   Recently, I spend a little time to study the Bluez Driver. Attached
> file is my notes. Hope this is useful for others.

I can't do anything useful with a file from a Microsoft Office
application ;)
 
>   But I have one question about the Bluez USB driver for Kernle 2.4.26
> and 2.6.5.
>  
> Kernel 2.4.26:
> /linux/src/driver/usb/bluetooth.c
> /linux/src/driver/bluetooth/hci_usb.c
>  
> Kernel 2.6.5:
> /linux/src/driver/bluetooth/hci_usb.c
>  Why are there two USB drivers for 2.4.26?
> Because, the /linux/src/driver/bluetooth/hci_usb.c have registered
> with USB core and get the hci dev. I couldn't know the purpose
> of /linux/src/driver/usb/blueotooth.c ? Do someone know the reason?

the bluetooth.o from 2.4 and the bluetty.ko driver from 2.6 are for
transforming the H:2 transport protocol into a H:4 transport protocol.
Both of them are part of the kernel for allowing the use of a Bluetooth
stack that support only H:4. An example for such a stack is the OpenBT
from Axis. It is impossible to select both drivers at the same time and
if you activate the Bluetooth subsystem you will use hci_usb.ko which is
the default configuration that is shipped by every distribtuion at the
moment. For more information take a look at the mailing list archives of
the BlueZ and USB mailing lists.

Regards

Marcel




-------------------------------------------------------
SF.Net email is sponsored by Shop4tech.com-Lowest price on Blank Media
100pk Sonic DVD-R 4x for only $29 -100pk Sonic DVD+R for only $33
Save 50% off Retail on Ink & Toner - Free Shipping and Free Gift.
http://www.shop4tech.com/z/Inkjet_Cartridges/9_108_r285
_______________________________________________
Bluez-users mailing list
Bluez-users@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-users
