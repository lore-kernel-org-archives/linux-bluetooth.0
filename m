Return-Path: <bluez-devel-admin@lists.sourceforge.net>
Message-ID: <421AF5C0.2060609@cmc.ca>
From: Nathanael Morrison <nathanael@cmc.ca>
MIME-Version: 1.0
To: bluez-devel@lists.sourceforge.net
Subject: Re: [Bluez-devel] Re: Can't init device hci0, Input/output error(5)
References: <4215D3EF.9010003@cmc.ca> <cv895o$2k1$1@sea.gmane.org>
In-Reply-To: <cv895o$2k1$1@sea.gmane.org>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Sender: bluez-devel-admin@lists.sourceforge.net
Errors-To: bluez-devel-admin@lists.sourceforge.net
Reply-To: bluez-devel@lists.sourceforge.net
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-devel>,
	<mailto:bluez-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Id: BlueZ development <bluez-devel.lists.sourceforge.net>
List-Post: <mailto:bluez-devel@lists.sourceforge.net>
List-Help: <mailto:bluez-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-devel>,
	<mailto:bluez-devel-request@lists.sourceforge.net?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=bluez-devel>
Date: Tue, 22 Feb 2005 09:05:04 +0000

Thanks Sebastian. I would have to agree with Marcel and say it's 
probably a usb problem. I thought it might be worth while letting people 
know what I found out.  When I plug the device into the monitors usb hub 
and the ehci_hcd kernel module is loaded the Bluetooth dongle is 
recognized as a USB2.0 device, which, it is not and fails to function. 
But when I remove the ehci_hcd module and plug in the device into the 
monitors hub it's recongized correctly as a USB1.1 device and works like 
a charm.  Sooo I got it too work, but it means that I don't have USB2 
support while using the dongle. :)

Cheers,

Nathanael


Sebastian Roth wrote:

> Hi Nathanael,
>
> this is known as Marcel pointed out in the thread:
> http://thread.gmane.org/gmane.linux.bluez.user/6170
>
> Maybe this is one good point for the bluez FAQ?
>
> Best regards,
> Sebastian
>
>
>
> -------------------------------------------------------
> SF email is sponsored by - The IT Product Guide
> Read honest & candid reviews on hundreds of IT Products from real users.
> Discover which products truly live up to the hype. Start reading now.
> http://ads.osdn.com/?ad_id=6595&alloc_id=14396&op=click
> _______________________________________________
> Bluez-devel mailing list
> Bluez-devel@lists.sourceforge.net
> https://lists.sourceforge.net/lists/listinfo/bluez-devel
>



-------------------------------------------------------
SF email is sponsored by - The IT Product Guide
Read honest & candid reviews on hundreds of IT Products from real users.
Discover which products truly live up to the hype. Start reading now.
http://ads.osdn.com/?ad_id=6595&alloc_id=14396&op=click
_______________________________________________
Bluez-devel mailing list
Bluez-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-devel
