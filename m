Return-Path: <bluez-devel-admin@lists.sourceforge.net>
Subject: Re: [Bluez-devel] Parameters of the Bluetooth standard in BlueZ...
From: Marcel Holtmann <marcel@holtmann.org>
To: Jers <jers@inwind.it>
Cc: BlueZ Mailing List <bluez-devel@lists.sourceforge.net>
In-Reply-To: <001501c3fd1d$019840a0$6b821d97@userpc>
References: <001501c3fd1d$019840a0$6b821d97@userpc>
Content-Type: text/plain; charset=iso-8859-7
Message-Id: <1077882359.2843.25.camel@pegasus>
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
Date: Fri, 27 Feb 2004 12:45:59 +0100

Hi Jers,

> At the moment I=A2m carrying out a study about Bluetooth standard. In
> this study I modified some parameters of Inquiry and Inquiry Scan
> procedures. Now I want to test my analytical results by real
> experiments. I=A2d like to evaluate the discovery performances of two
> bluetooth devices, changing:
>=20
> =20
>=20
> -         in Inquiry Scan procedure:
>=20
> o       Time spent in Rx (>=3D16*Tslot, according to the standard)
>=20
> o       The period between two consecutive inquiry scan (<2.56 sec,
> according to the standard)
>=20
> -         in Inquiry procedure:
>=20
> o       The period between the transmission of two consecutive packets
> (According the standard: 244.5 msec, after odd packets; 869.5 msec,
> after even packets)
>=20
> o       Number of repetitions of frequencies trains.
>=20
> -         in both procedures:
>=20
> o       number of employed hops
>=20
> =20
>=20
> I suppose I can set these parameters by BlueZ, so I looked for lines
> that manage them in all BlueZ files but I didn=A2t find.=20
>=20
> =20
>=20
> Can I change these parameters in BlueZ?

you can change everything for that you find a HCI command in the
Bluetooth specification.

Regards

Marcel




-------------------------------------------------------
SF.Net is sponsored by: Speed Start Your Linux Apps Now.
Build and deploy apps & Web services for Linux with
a free DVD software kit from IBM. Click Now!
http://ads.osdn.com/?ad_id=1356&alloc_id=3438&op=click
_______________________________________________
Bluez-devel mailing list
Bluez-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-devel
