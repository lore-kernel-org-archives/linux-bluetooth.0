Return-Path: <bluez-devel-admin@lists.sourceforge.net>
Message-ID: <20b987f505071610264207988@mail.gmail.com>
From: Dirk Vanden Boer <dirk.vdb@gmail.com>
To: bluez-devel@lists.sourceforge.net
Subject: Re: [Bluez-devel] At commands not available
Cc: Fred Schaettgen <bluez-devel@schaettgen.de>
In-Reply-To: <200507161917.44341.bluez-devel@schaettgen.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
References: <20b987f50507160932183ef50f@mail.gmail.com>
	 <200507161917.44341.bluez-devel@schaettgen.de>
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
Date: Sat, 16 Jul 2005 19:26:06 +0200

On 7/16/05, Fred Schaettgen <bluez-devel@schaettgen.de> wrote:
> On Saturday, 16. July 2005 18:32, Dirk Vanden Boer wrote:
> > Hi,
> > I'm trying to send AT commands to my mobile phone using an rfcomm
> > connection. The connection seems to work because I can exectute some
> > commands (like manufacturer name). But a whole bunch of commands are
> > not available (eg. battery charge: "AT+CBC\r" returns ERROR). I can
> > run the AT* command which lists the available commands but a lot of
> > common commands are not in the list. Could it be that there is
> > something wrong with my connection?
>=20
> Are you sure that this command should be supported at all? If you are
> connecting to the handsfree service, then the phone probably does not hav=
e to
> support it. At least I can't find +CBC in the handsfree spec. Phones are =
free
> to support additional commands though, or at least they do support more i=
n
> practice. It works with a Nokia 6230 for instance, without any special
> initialization.
>=20
> Fred

The CBC command is listed in the developers guidelines document of the
ericsson t68 phone, so I guess it should be available.

Dirk


-------------------------------------------------------
SF.Net email is sponsored by: Discover Easy Linux Migration Strategies
from IBM. Find simple to follow Roadmaps, straightforward articles,
informative Webcasts and more! Get everything you need to get up to
speed, fast. http://ads.osdn.com/?ad_id=7477&alloc_id=16492&op=click
_______________________________________________
Bluez-devel mailing list
Bluez-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-devel
