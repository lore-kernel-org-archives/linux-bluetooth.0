Return-Path: <bluez-devel-admin@lists.sourceforge.net>
Subject: Re: [Bluez-devel] TPL (transmit power level)
From: Marcel Holtmann <marcel@holtmann.org>
To: BlueZ Mailing List <bluez-devel@lists.sourceforge.net>
In-Reply-To: <de33c8be05022119091917b7ff@mail.gmail.com>
References: <de33c8be0502160425215158ad@mail.gmail.com>
	 <1109028291.7626.45.camel@pegasus>
	 <de33c8be050221181635c1a751@mail.gmail.com>
	 <1109039332.7626.102.camel@pegasus>
	 <de33c8be05022119091917b7ff@mail.gmail.com>
Content-Type: text/plain; charset=ISO-8859-1
Message-Id: <1109042195.7626.105.camel@pegasus>
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
Date: Tue, 22 Feb 2005 04:16:34 +0100

Hi Flavio,

> My dongle is an conceptronic CBT100U class1 (100m) and here it=B4s the
> information :
>=20
> chip version : BlueCore2 ;
> HCI 17,11 ;
>=20
> SCO mapping : HCI ;
> HCI ver:1,1 ;
> HCI rev: 0X460;
> LMP ver:1,1 ;
> LMP subver:0X460
> Should i update the firmware? Resolves my problem?In the chip specific
> don=B4t say about the class 1 :(

the class stuff is also not chip specific. The antenna matters in this
case.

> Note: My dongle is 1,1 version but can i update for the 1,2 version
> with the firmware?

Maybe yes, maybe no. What does /proc/bus/usb/devices contain?

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
