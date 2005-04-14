Return-Path: <bluez-devel-admin@lists.sourceforge.net>
From: Peter Wippich <pewi@gw-instruments.de>
To: <bluez-devel@lists.sourceforge.net>
Subject: Re: [Bluez-devel] first(?) bc4 module
In-Reply-To: <1113494581.8989.23.camel@pegasus>
Message-ID: <Pine.LNX.4.33.0504141815580.29800-100000@redbean.intranet.gw-instruments.de>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
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
Date: Thu, 14 Apr 2005 18:26:37 +0200 (CEST)


Hi Brad, Hi Marcel,

well, at least the 2 MBit mode should be usable over the UART interface.
The BC04 UART supports 1.5 MBit, but this is "Full Duplex". So if you have
bi-directioal data transfer that is 3 MBit total. For mostly
uni-directional traffic even 1.5 MBit is a very good transfer rate over a
2 MBit air link because at best you can get around 1.5 MBit user data
transferred. There is still some HCI overhead on the UART, but I think
this is only around 1..2% and can be neglected for a first estimate.

However, for a 3 MBit connection with mostly uni-directional traffic the
UART interface is not sufficient anymore.

Things again look very different if you use a BC04 with internal SCO
routing (e.g. for a A2DP headset). But this is a diffrent story.

Ciao,

Peter


On Thu, 14 Apr 2005, Marcel Holtmann wrote:

> Hi Brad,
>
> > It complicates things a lot for everyone if bc4 hardware has to be wired
> > in some way other than a uart to make good use of EDR.
>
> at the moment the only options are USB and the SDIO interfaces. Maybe
> they will also come up with a SPI, but actually I doubt it.
>
> Regards
>
> Marcel
>
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

|	Peter Wippich 			Voice: +49 30 46776411		|
|	G&W Instruments GmbH		fax:   +49 30 46776419		|
|	Gustav-Meyer-Allee 25, Geb. 12	Email: pewi@gw-instruments.de	|
|	D-13355 Berlin  / Germany					|




-------------------------------------------------------
SF email is sponsored by - The IT Product Guide
Read honest & candid reviews on hundreds of IT Products from real users.
Discover which products truly live up to the hype. Start reading now.
http://ads.osdn.com/?ad_id=6595&alloc_id=14396&op=click
_______________________________________________
Bluez-devel mailing list
Bluez-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-devel
