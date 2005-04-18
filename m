Return-Path: <bluez-devel-admin@lists.sourceforge.net>
Subject: Re: [Bluez-devel] hcitool scan while hidd connection..
From: Marcel Holtmann <marcel@holtmann.org>
To: bluez-devel@lists.sourceforge.net
In-Reply-To: <701b25d25042b2dbf9643b5322f8e8cb@pepper.com>
References: <805b11d45747c1dc166defb93f587cf1@pepper.com>
	 <1113607333.16433.46.camel@pegasus>
	 <a0b3fcf839d24cc684e86db701108bb6@pepper.com>
	 <1113836853.16233.97.camel@pegasus>
	 <701b25d25042b2dbf9643b5322f8e8cb@pepper.com>
Content-Type: text/plain
Message-Id: <1113838532.16233.101.camel@pegasus>
Mime-Version: 1.0
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
Date: Mon, 18 Apr 2005 17:35:32 +0200

Hi Michael,

> root@(none):~# hcitool scan
> Scanning ...
> < HCI Command: Inquiry (0x01|0x0001) plen 5
>      lap 0x9e8b33 len 8 num 100
>  > HCI Event: Command Status (0x0f) plen 4
>      Inquiry (0x01|0x0001) status 0x00 ncmd 7
>  > HCI Event: Inquiry Complete (0x01) plen 1
>      status 0x00
>  > HCI Event: Command Status (0x0f) plen 4
>      Unknown (0x00|0x0000) status 0x00 ncmd 8
> root@(none):~#

this is weird. What does "hciconfig -a" tells you about your dongle?

Regards

Marcel




-------------------------------------------------------
SF email is sponsored by - The IT Product Guide
Read honest & candid reviews on hundreds of IT Products from real users.
Discover which products truly live up to the hype. Start reading now.
http://ads.osdn.com/?ad_id=6595&alloc_id=14396&op=click
_______________________________________________
Bluez-devel mailing list
Bluez-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-devel
