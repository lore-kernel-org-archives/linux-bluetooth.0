Return-Path: <bluez-devel-admin@lists.sourceforge.net>
From: Peter Wippich <pewi@gw-instruments.de>
To: <bluez-devel@lists.sourceforge.net>
Subject: Re: [Bluez-devel] At commands not available
In-Reply-To: <20b987f505071610264207988@mail.gmail.com>
Message-ID: <Pine.LNX.4.33.0507161932240.4834-100000@redbean.intranet.gw-instruments.de>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=iso-8859-1
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
Date: Sat, 16 Jul 2005 19:35:59 +0200 (CEST)


Hi Dirk,

which service you are connecting to ??? If you connect to the wrong
service (channel) the phone may (shall !) only make available the AT
commands belonging to this service.

Ciao,

Peter


On Sat, 16 Jul 2005, Dirk Vanden Boer wrote:

> On 7/16/05, Fred Schaettgen <bluez-devel@schaettgen.de> wrote:
> > On Saturday, 16. July 2005 18:32, Dirk Vanden Boer wrote:
> > > Hi,
> > > I'm trying to send AT commands to my mobile phone using an rfcomm
> > > connection. The connection seems to work because I can exectute som=
e
> > > commands (like manufacturer name). But a whole bunch of commands ar=
e
> > > not available (eg. battery charge: "AT+CBC\r" returns ERROR). I can
> > > run the AT* command which lists the available commands but a lot of
> > > common commands are not in the list. Could it be that there is
> > > something wrong with my connection?
> >
> > Are you sure that this command should be supported at all? If you are
> > connecting to the handsfree service, then the phone probably does not=
 have to
> > support it. At least I can't find +CBC in the handsfree spec. Phones =
are free
> > to support additional commands though, or at least they do support mo=
re in
> > practice. It works with a Nokia 6230 for instance, without any specia=
l
> > initialization.
> >
> > Fred
>
> The CBC command is listed in the developers guidelines document of the
> ericsson t68 phone, so I guess it should be available.
>
> Dirk
>
>
> -------------------------------------------------------
> SF.Net email is sponsored by: Discover Easy Linux Migration Strategies
> from IBM. Find simple to follow Roadmaps, straightforward articles,
> informative Webcasts and more! Get everything you need to get up to
> speed, fast. http://ads.osdn.com/?ad_idt77&alloc_id=16492&op=CCk
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
SF.Net email is sponsored by: Discover Easy Linux Migration Strategies
from IBM. Find simple to follow Roadmaps, straightforward articles,
informative Webcasts and more! Get everything you need to get up to
speed, fast. http://ads.osdn.com/?ad_id=7477&alloc_id=16492&op=click
_______________________________________________
Bluez-devel mailing list
Bluez-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-devel
