Return-Path: <bluez-devel-admin@lists.sourceforge.net>
Message-ID: <e1effdeb05061806001b5d8a3a@mail.gmail.com>
From: Claudio Takahasi <cktakahasi@gmail.com>
To: bluez-devel@lists.sourceforge.net
Subject: Re: [Bluez-devel] BlueZ GUI
In-Reply-To: <1119086759.24842.42.camel@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
References: <BAY104-F31990E531BA06F8AF71435C1090@phx.gbl>
	 <200505201554.12647.bluez-devel@schaettgen.de>
	 <1119086759.24842.42.camel@localhost.localdomain>
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
Date: Sat, 18 Jun 2005 06:00:23 -0700

I folks,

I am working with D-Bus services for BlueZ and I had an
approach to suggest. Using D-Bus it is possible start
an application and define message rules and handle
security issues.

An important comment, D-Bus can address concurrent
requests(connection, inquiry, service search), signals can be
sent to notify disconnection, new devices, ...
Currently, some patchs for PAN Daemon(pand) D-Bus service
were submited to the community. I don't know when it will be
available, probably in the next release.

Another approach is develop an library/functions to export
the daemons functionality: connect, disconnect, search, ...

Regards,
Claudio

On 6/18/05, David Woodhouse <dwmw2@infradead.org> wrote:
> On Fri, 2005-05-20 at 15:54 +0200, Fred Schaettgen wrote:
> > I guess he's talking about a GUI to edit hcid.conf. At least kdebluetoo=
th
> > doesn't include any tool to do that. It implements the client and serve=
r side
> > of a some Bluetooth profiles, but it doesn't deal with the configuratio=
n.
> > Except for the link key manager maybe. I don't really know the gnome
> > bluetooth tools, but I guess it's the same there.
>=20
> Only root can edit hcid.conf, and you shouldn't be using GUI
> point-and-drool tools as root.
>=20
> --
> dwmw2
>=20
>=20
>=20
> -------------------------------------------------------
> SF.Net email is sponsored by: Discover Easy Linux Migration Strategies
> from IBM. Find simple to follow Roadmaps, straightforward articles,
> informative Webcasts and more! Get everything you need to get up to
> speed, fast. http://ads.osdn.com/?ad_id=3D7477&alloc_id=3D16492&op=3Dclic=
k
> _______________________________________________
> Bluez-devel mailing list
> Bluez-devel@lists.sourceforge.net
> https://lists.sourceforge.net/lists/listinfo/bluez-devel
>


-------------------------------------------------------
SF.Net email is sponsored by: Discover Easy Linux Migration Strategies
from IBM. Find simple to follow Roadmaps, straightforward articles,
informative Webcasts and more! Get everything you need to get up to
speed, fast. http://ads.osdn.com/?ad_id=7477&alloc_id=16492&op=click
_______________________________________________
Bluez-devel mailing list
Bluez-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-devel
