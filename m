Return-Path: <bluez-devel-admin@lists.sourceforge.net>
Subject: Re: [Bluez-devel] Fighting with SCO
From: Marcel Holtmann <marcel@holtmann.org>
To: Till Harbaum <till@harbaum.org>
Cc: Till Harbaum <harbaum@beecon.de>,
   BlueZ Mailing List <bluez-devel@lists.sourceforge.net>
In-Reply-To: <200408262000.07077.till@harbaum.org>
References: <200408261852.56641.harbaum@beecon.de>
	 <1093541231.2581.40.camel@pegasus>  <200408262000.07077.till@harbaum.org>
Content-Type: text/plain
Message-Id: <1093548184.2581.48.camel@pegasus>
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
Date: Thu, 26 Aug 2004 21:23:05 +0200

Hi Till,

> guess what ... my Acer Dongle at home just works fine. I'll try to figure out, 
> what the reason is.

do you played with the PS key settings, because the default for the Acer
was sending SCO traffic over the PCM interface. Use the revision command
to check where the SCO traffic is routed through.

> So you may add the BlueTrek G2 to the list of supported devices.

Send me the output of "hcitool info ...".

> At least my broadcom dongle says it has 0 sco slots of 16 bytes each. I think 
> this is a clear indication, that the dongle does not support sco.

It is Broadcom. Their support to the community is very bad.

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
