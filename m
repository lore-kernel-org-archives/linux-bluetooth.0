Return-Path: <pkg-bluetooth-maintainers-bounces+marcel=holtmann.org@lists.alioth.debian.org>
Date: Mon, 25 Dec 2006 19:12:17 +0100
From: Filippo Giunchedi <filippo@esaurito.net>
To: BlueZ development <bluez-devel@lists.sourceforge.net>
Message-ID: <20061225181217.GB970@esaurito.net>
References: <1167052771.5265.7.camel@suske> <20061225165542.GA970@esaurito.net>
	<1167066856.11510.22.camel@violet>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1167066856.11510.22.camel@violet>
Subject: Re: [Bluez-devel] [Pkg-bluetooth-maintainers] dbus dependency
	introduces unwanted X11 dependency
Cc: pkg-bluetooth-maintainers@lists.alioth.debian.org,
        Bram Stolk <bram@sara.nl>
List-Unsubscribe: <http://lists.alioth.debian.org/mailman/listinfo/pkg-bluetooth-maintainers>,
	<mailto:pkg-bluetooth-maintainers-request@lists.alioth.debian.org?subject=unsubscribe>
List-Archive: <http://lists.alioth.debian.org/pipermail/pkg-bluetooth-maintainers>
List-Post: <mailto:pkg-bluetooth-maintainers@lists.alioth.debian.org>
List-Help: <mailto:pkg-bluetooth-maintainers-request@lists.alioth.debian.org?subject=help>
List-Subscribe: <http://lists.alioth.debian.org/mailman/listinfo/pkg-bluetooth-maintainers>,
	<mailto:pkg-bluetooth-maintainers-request@lists.alioth.debian.org?subject=subscribe>
Sender: pkg-bluetooth-maintainers-bounces+marcel=holtmann.org@lists.alioth.debian.org
Errors-To: pkg-bluetooth-maintainers-bounces+marcel=holtmann.org@lists.alioth.debian.org
List-ID: <bluez-devel.lists.sourceforge.net>

Hello Marcel,

On Mon, Dec 25, 2006 at 06:14:16PM +0100, Marcel Holtmann wrote:
> > > With the new version, dbus gets pulled in. Why?
> > > Isn't libdbus enough?
> >=20
> > starting with bluez 3.x most of the functionality has been moved to dbu=
s, which
> > is used among other things for pinhelper functionalities.
> > and no, libdbus isn't enough unless I'm missing something, bluez (hcid)=
 needs to
> > register to the local dbus.
>=20
> the bluez-utils depends on a working D-Bus system bus. It has no
> dependency on X or anything else (besides the Bluetooth library). So if
> it pulls in X related stuff then this is a fault of D-Bus or its package
> and not a problem within the bluez-utils package.

indeed, my point was that bluez-utils needs the dbus daemon running not just
libdbus (which in turn Recommends the daemon, btw)

>=20
> > > This is so ugly...
> > >=20
> > > It should be possible to run pand without the X11 burden.
> > > It used to be possible in the past, but not anymore.
> >=20
> > I'm not sure if it makes any sense to have bluetooth daemons splitted i=
n its own
> > package.=20
>=20
> No. All of them will be extended with D-Bus functionality anyway. D-Bus
> is the way to go and people fighting it are on a dead end.

agreed

best wishes,
filippo

_______________________________________________
Pkg-bluetooth-maintainers mailing list
Pkg-bluetooth-maintainers@lists.alioth.debian.org
http://lists.alioth.debian.org/mailman/listinfo/pkg-bluetooth-maintainers
