Return-Path: <bluez-devel-admin@lists.sourceforge.net>
Message-ID: <425FD044.3040704@xmission.com>
From: Brad Midgley <bmidgley@xmission.com>
MIME-Version: 1.0
To: bluez-devel@lists.sourceforge.net
Subject: Re: [Bluez-devel] Re: btsco - headset profile activated but no sco
 packets transmitted ???
References: <20050404194542.GA7640@lsweb.de> <20050404195007.GA8373@lsweb.de> <20050415111207.GA4885@lsweb.de> <20050415121633.GA4265@lsweb.de>
In-Reply-To: <20050415121633.GA4265@lsweb.de>
Content-Type: text/plain; charset=us-ascii; format=flowed
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
Date: Fri, 15 Apr 2005 08:31:32 -0600

ok, clearly i'll have to document this.

i've noticed that if the usb bluetooth adapter is connected directly to 
the machine it gets ohci. if it's connected to a 2.0 hub going to the 
machine it gets ehci.

btw, it dilutes the value of having two lists when you crosspost. -devel 
is where btsco discussion fits best.

Lars Steinke wrote:
> Phew, got it finally,
> 
> it was the bloody ehci_hcd audio problem others have come across:
> http://sourceforge.net/mailarchive/message.php?msg_id=11431438
> 
> Using ohci_hcd, btsco works a treat in recording and playing, thanks for 
> the good work !!!
> 
> PS: Should others have trouble using the BT110, keep in mind it has very
> stringent power saving and thus will turn off very soon after the last
> audio packets have been transmitted (the confimation tone will notify you
> of that) - btsco will then quit with "RFCOMM channel lost"... 
> 
> Regards,
> Lars
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


-------------------------------------------------------
SF email is sponsored by - The IT Product Guide
Read honest & candid reviews on hundreds of IT Products from real users.
Discover which products truly live up to the hype. Start reading now.
http://ads.osdn.com/?ad_id=6595&alloc_id=14396&op=click
_______________________________________________
Bluez-devel mailing list
Bluez-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-devel
