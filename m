Return-Path: <bluez-devel-admin@lists.sourceforge.net>
Subject: Re: [Bluez-devel] hidd weirdness under 2.4.20
From: Marcel Holtmann <marcel@holtmann.org>
To: BlueZ Mailing List <bluez-devel@lists.sourceforge.net>
In-Reply-To: <BD226CAD-43D6-11D9-9BD7-00039390D626@pepper.com>
References: <D041B252-43B9-11D9-9BD7-00039390D626@pepper.com>
	 <1101929973.15615.32.camel@pegasus>
	 <888FEE62-43D1-11D9-9BD7-00039390D626@pepper.com>
	 <1101930622.15615.34.camel@pegasus>
	 <F6F2876E-43D2-11D9-9BD7-00039390D626@pepper.com>
	 <1101932186.15615.37.camel@pegasus>
	 <BD226CAD-43D6-11D9-9BD7-00039390D626@pepper.com>
Content-Type: text/plain
Message-Id: <1101933300.15615.57.camel@pegasus>
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
Date: Wed, 01 Dec 2004 21:35:00 +0100

Hi Michael,

> here is the dump:
> 
> root@(none):~# hcidump -X
> HCIDump - HCI packet analyzer ver 1.12
> device: hci0 snap_len: 1028 filter: 0xffffffff
>  > ACL data: handle 0x0001 flags 0x02 dlen 10keyboard.c: can't emulate 
> rawmode for keycode 272
> 
>      L2CAP(d): cid 0x0041 len 6 [psm 0]
>        0000: a1 02 01 00 00 00                                 ......
> 
> Yes -- I am running the latest mh patch.

this is a mouse report (id 2) and this should not produce a keyboard
input. Is this reproduceable with a plain 2.6.9 or the latest 2.4 with
my -mh patch?

Regards

Marcel




-------------------------------------------------------
SF email is sponsored by - The IT Product Guide
Read honest & candid reviews on hundreds of IT Products from real users.
Discover which products truly live up to the hype. Start reading now. 
http://productguide.itmanagersjournal.com/
_______________________________________________
Bluez-devel mailing list
Bluez-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-devel
