Return-Path: <bluez-devel-admin@lists.sourceforge.net>
From: Peter Wippich <pewi@gw-instruments.de>
To: BlueZ Mailing List <bluez-devel@lists.sourceforge.net>
Subject: Re: [Bluez-devel] [PATCH] Add sdptool option for browsing with
 L2CAP_UUID
In-Reply-To: <20050405082054.GA18117@kone>
Message-ID: <Pine.LNX.4.33.0504051033510.28723-100000@redbean.intranet.gw-instruments.de>
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
Date: Tue, 5 Apr 2005 10:40:21 +0200 (CEST)


Hi,

I'm aware of many devices which do not have a public browse group tag in
their SDP records. Searching for all services with L2CAP is one solution.
Another is to do a search for a range of well known service UUIDs. And
another solution (as imlemented by Widcom) is to do a search for the whole
range of service UUIDs (0..0xffff).
However, the last method wil crash some embedded devices with a dump
local data base search implementation. Actually they will not realy crash
but you may get a connection timeout.....

Ciao,

Peter

On Tue, 5 Apr 2005, Johan Hedberg wrote:

> On Mon, Apr 04, 2005, Dimitry Andric wrote:
> > Some phones (e.g. Samsung D500, Motorola MPx220, and possibly some
> > other Windows Mobile models) don't return any services if you ask them
> > for the public browse group.  You notice this, when "sdptool browse
> > xx:xx:xx:xx:xx:xx" returns immediately, without any output.
> >
> > It turns out that the Windows XP Bluetooth browser asks for
> > L2CAP_UUID, which *does* work for all the phones I've tested.
>
> I can confirm this behaviour also on a Motorola A760. However, it is
> also the only phone I have encountered this.
>
> Johan
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
