Return-Path: <bluez-devel-admin@lists.sourceforge.net>
Message-ID: <e1effdeb05061714599d1b85d@mail.gmail.com>
From: Claudio Takahasi <cktakahasi@gmail.com>
To: bluez-devel@lists.sourceforge.net
Subject: Re: [Bluez-devel] DBUS service support - poll patch
In-Reply-To: <e1effdeb0506140437647fe446@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
References: <1115901694.18499.32.camel@pegasus>
	 <1117098491.12036.23.camel@pegasus>
	 <e1effdeb05052614222118e70c@mail.gmail.com>
	 <1117143615.12036.74.camel@pegasus>
	 <e1effdeb050530154229f338a2@mail.gmail.com>
	 <1117494345.7072.235.camel@pegasus>
	 <e1effdeb05060313345fb564a3@mail.gmail.com>
	 <1117836644.3656.100.camel@pegasus>
	 <e1effdeb050606061850ac0134@mail.gmail.com>
	 <e1effdeb0506140437647fe446@mail.gmail.com>
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
Date: Fri, 17 Jun 2005 18:59:55 -0300

Hi Marcel,

There is a new patch available.

http://www.indt.org.br/maemo/zeroconf/bluez/bluez-dbus-poll-v00.03.diff

Changes from last release:
 - comments fixed
 - message handle optimized
 - created a library for clients development

Now, the test client is based on a library.
http://www.indt.org.br/maemo/zeroconf/bluez/libbluezdbus-0.1.tar.gz
The sample directory contains the test application:
"client" can be used to request services
"sig_listener" is used to listen to signals: new connections,=20
disconnection, role changed, ..

Currently, the listener is not integrated with the requester because
Glib main loop integration is required. I will develop a better client
for demonstration purpose as son as possible.

Bugs:
- start service is not working

TODO:
-organize the interfaces names/services better.=20
sdptool, pand, dund features should be provided
using D-Bus. Align with Maemo gwconnect???
-Develop a new version supporting the new D-Bus version

QUESTIONS:
-Where put library creation?
1. put in the pand daemon under optional feature
  advantages: can be shared between dbus and no-dbus.
              The control is easier.
  disadvantages: libbridge dependency
2. put it in a library(commented previously)
  advantages: This feature can be added with another
              features/functions, like D-Bus message
              functions, Zeroconf integration (UDHCP) or HOWL.
              UDHCP and HOWL D-BUS services are being developed.
  disadvantages: no-dbus pand daemon will not be able to
              control bridges and all clients will be allowed
              to control bridges.


The library is not complete. I am sending to see the
community feedback.

Regards,
Claudio.

On 6/14/05, Claudio Takahasi <cktakahasi@gmail.com> wrote:
> Hi Marcel,
>=20
> There is a new patch available.
>=20
> http://www.indt.org.br/maemo/bluez/bluez-dbus-poll-v00.02.diff
>=20
> I read the Greg K.H. paper, I tryed adjust the code following his
> suggestion. Probably there are points that remain incorrect.
> Send me suggestions and comments that I will fix it.
>=20
> I am working on library for hidding D-BUS details. I don' t
> know how provide it to the developers. Basically, this library
> will hide the code inside the pand_dbus_client.tar.gz
>=20
> Another subject that I want introduce is bridge creation. I think
> we discuss this subject before. Two approachs can be applied:
> 1. put in the pand daemon under optional feature
>    advantages: can be shared between dbus and no-dbus
>    disadvantages: libbridge dependency
> 2. put it in a library(commented previously)
>    advantages: This feature can be added with another
>                features/functions, like D-Bus message
>                functions, Zeroconf integration (UDHCP) or HOWL.
>                UDHCP and HOWL D-BUS services are being developed.
>    disadvantages: no-dbus pand daemon will not be able to
>                control bridges
>=20
>=20
>=20
> Regards,
> Claudio.
>=20
>=20
> On 6/6/05, Claudio Takahasi <cktakahasi@gmail.com> wrote:
> > Hi Marcel,
> >
> > Probably you are not satisfied with D-Bus watches.  I tryed remove
> > it, but it is not possible.
> > According with D-Bus documentation is not allowed read/write directly
> > in the file descriptor. DBusWatch must be used for main loop integratio=
n.
> >
> > Another important approach is develop a library for D-Bus function
> > hidding. The sample client is just a usage sample and a better idea
> > is use a common library for all applications: gamming, UPnP, messenger,=
 ...
> >
> > Regarding the coding style I will review it.
> >
> > Regards,
> > Claudio.
> >
> > On 6/3/05, Marcel Holtmann <marcel@holtmann.org> wrote:
> > > Hi Claudio,
> > >
> > > > A new patch is available using a main loop and poll to wait for som=
e event
> > > > on a file descriptor list (D-Bus and Bluetooth).
> > > >
> > > > All Glib and pthread dependencies were remove.
> > >
> > > I just had some some time for a quick review. It is not fully what I =
had
> > > in mind, but it is something from what we can work onwards. I think i=
t
> > > is a good idea to include it into release 2.18 and then start on
> > > improving it.
> > >
> > > Since I am away the next week you might wanna address the coding styl=
e
> > > issues in that time. Read the paper from Greg KH from the OLS 2002. I
> > > think it gives a very good understanding on it.
> > >
> > > Regards
> > >
> > > Marcel
> > >
> > >
> > >
> > >
> > > -------------------------------------------------------
> > > This SF.Net email is sponsored by: NEC IT Guy Games.  How far can you=
 shotput
> > > a projector? How fast can you ride your desk chair down the office lu=
ge track?
> > > If you want to score the big prize, get to know the little guy.
> > > Play to win an NEC 61" plasma display: http://www.necitguy.com/?r=3D2=
0
> > > _______________________________________________
> > > Bluez-devel mailing list
> > > Bluez-devel@lists.sourceforge.net
> > > https://lists.sourceforge.net/lists/listinfo/bluez-devel
> > >
> >
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
