Return-Path: <bluez-devel-admin@lists.sourceforge.net>
Subject: Re: [Bluez-devel] HCI USB driver and SCO support
From: Marcel Holtmann <marcel@rvs.uni-bielefeld.de>
To: James Courtier-Dutton <James@superbug.demon.co.uk>
Cc: BlueZ Mailing List <bluez-devel@lists.sourceforge.net>
In-Reply-To: <3F2B8207.1040200@superbug.demon.co.uk>
References: <1059787251.22190.17.camel@pegasus>
	<3F2B8207.1040200@superbug.demon.co.uk>
Content-Type: text/plain
Message-Id: <1059989717.921.35.camel@pegasus>
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
Date: 04 Aug 2003 11:35:11 +0200

Hi James,

> If we are going to use the SCO channels for sound output from 
> applications, it would be very useful if we could provide some sort of 
> ring buffer support, with hardware pointer updates.
> Currently, there are no callbacks from sco to the application layer, 
> telling it how many sound samples have actually left the PC for the 
> Bluetooth device. This is a requirement if we are to support any sound 
> card simulation layer above the SCO layer.
> Until this is resolved, we will not be able to implement alsa or oss 
> support.

I don't care about this at the moment, because the current problem is
the hci_usb driver. We need to adjust the alternate setting for the ISOC
interface on demand. And this setting depends on the voice setting (8 or
16 bit) and the number of SCO connections. If the used alternate setting
is not correct, you don't get any correct audio data over the SCO link.

> The current method for allocation of the URB is incompatible with kernel 
> 2.6.
> bluez currently allocates it's own urb as a structure inside _urb.
> In 2.6, the requirement is to get the usb subsystem to allocate the urb, 
>   and then set the urb->context pointer to point to any bluez specific 
> state information.
> If the urb allocation is adjusted, it will then work on both 2.4 and 2.6

There was a discussion between Max and Greg about this topic on the
Linux USB mailing list. You should read this first.

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
