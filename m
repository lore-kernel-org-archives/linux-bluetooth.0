Return-Path: <bluez-devel-admin@lists.sourceforge.net>
Subject: Re: [Bluez-devel] hci_usb bug on 2.6 kernels?
From: Marcel Holtmann <marcel@holtmann.org>
To: Andronikos Nedos <nedosa@cs.tcd.ie>
Cc: BlueZ Mailing List <bluez-devel@lists.sourceforge.net>
In-Reply-To: <412EF0FF.4070200@cs.tcd.ie>
References: <412EF0FF.4070200@cs.tcd.ie>
Content-Type: text/plain
Message-Id: <1093605294.2581.88.camel@pegasus>
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
Date: Fri, 27 Aug 2004 13:14:54 +0200

Hi Andronikos,

> When I recently migrated to a 2.6 kernel, my TDK USB bluetooth adapter
> stopped working. I could load all the modules fine, but as soon as I
> start hcid I got the following error:
> 
> Aug 12 10:23:33 mulligans hci_usb_intr_rx_submit: hci0 intr rx submit
> failed urb f744f5ec err -28
> 
> I've tried a few of the latest kernels, mainly 2.6.7 and the 2.6.8-rc
> series and the problem remained.
> 
> Yesterday though, I switched my TDK from the USB2 controller to a USB1.1
> ~ controller and it worked.

this is weird, because error code 28 means ENOSPC (No space left on
device) and this is because of a bandwidth problem. May you wanna try to
disable CONFIG_USB_BANDWIDTH and see if it works then. Please report
this problem to the USB mailing list (no cross post), because I can't
really help here.

Regards

Marcel




-------------------------------------------------------
SF.Net email is sponsored by Shop4tech.com-Lowest price on Blank Media
100pk Sonic DVD-R 4x for only $29 -100pk Sonic DVD+R for only $33
Save 50% off Retail on Ink & Toner - Free Shipping and Free Gift.
http://www.shop4tech.com/z/Inkjet_Cartridges/9_108_r285
_______________________________________________
Bluez-devel mailing list
Bluez-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-devel
