Return-Path: <bluez-devel-admin@lists.sourceforge.net>
Subject: Re: [Bluez-devel] TPL (transmit power level)
From: Marcel Holtmann <marcel@holtmann.org>
To: BlueZ Mailing List <bluez-devel@lists.sourceforge.net>
In-Reply-To: <de33c8be0502160425215158ad@mail.gmail.com>
References: <de33c8be0502160425215158ad@mail.gmail.com>
Content-Type: text/plain; charset=ISO-8859-1
Message-Id: <1109028291.7626.45.camel@pegasus>
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
Date: Tue, 22 Feb 2005 00:24:51 +0100

Hi Flavio,

> I=B4m working with power control and i saw one thing that could be wron=
g:
>=20
> Transmit power level (tpl) : _1octet (signed integer);
>                                  _range: -30<=3D N<=3D20;
>                                  _units: dBm.
>=20
> In BlueZ the value of tpl is defined like unsigned int ( uint8_t level
> ) but i think that should be an int ( int8_t level ) like is defined
> in core of bluetooth.
>=20
> There is any particular reason for the level to be an unsigned int??

no, because this is bug. Thanks for spotting it. If you see more of
them, then simply send in a patch for it.

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
