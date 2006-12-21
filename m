Return-Path: <bluez-devel-bounces@lists.sourceforge.net>
Date: Fri, 22 Dec 2006 00:55:30 +0500
From: Andrey Rahmatullin <wrar@altlinux.ru>
To: bluez-devel@lists.sourceforge.net
Message-ID: <20061221195530.GD18112@wrars-comp.wrarsdomain>
References: <20061221191520.GC18112@wrars-comp.wrarsdomain>
	<1166729874.372.3.camel@violet>
Mime-Version: 1.0
In-Reply-To: <1166729874.372.3.camel@violet>
Subject: Re: [Bluez-devel] [PATCH] bluez-gnome link fix
Reply-To: BlueZ development <bluez-devel@lists.sourceforge.net>
List-Id: BlueZ development <bluez-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-devel>,
	<mailto:bluez-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=bluez-devel>
List-Post: <mailto:bluez-devel@lists.sourceforge.net>
List-Help: <mailto:bluez-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-devel>,
	<mailto:bluez-devel-request@lists.sourceforge.net?subject=subscribe>
Content-Type: multipart/mixed; boundary="===============1064979752=="
Sender: bluez-devel-bounces@lists.sourceforge.net
Errors-To: bluez-devel-bounces@lists.sourceforge.net


--===============1064979752==
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="XStn23h1fwudRqtG"
Content-Disposition: inline


--XStn23h1fwudRqtG
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Dec 21, 2006 at 08:37:54PM +0100, Marcel Holtmann wrote:
> I need a more detailed explanation on why your fix is correct, because I
> simply don't see it.
gcc -I/usr/include/dbus-1.0 -I/usr/lib/dbus-1.0/include -I/usr/include/glib=
-2.0
-I/usr/lib/glib-2.0/include   -DDBUS_API_SUBJECT_TO_CHANGE
-I/usr/include/gtk-2.0 -I/usr/lib/gtk-2.0/include -I/usr/include/atk-1.0
-I/usr/include/cairo -I/usr/include/pango-1.0 -I/usr/include/glib-2.0
-I/usr/lib/glib-2.0/include   -pipe -Wall -O2 -march=3Dathlon -mtune=3Dathl=
on-xp
-D_FORTIFY_SOURCE=3D2   -o bluetooth-sendto  main.o -lgtk-x11-2.0 -lgdk-x11=
-2.0
-latk-1.0 -lgdk_pixbuf-2.0 -lm -lpangocairo-1.0 -lpango-1.0 -lcairo
-lgobject-2.0 -lgmodule-2.0 -ldl -lglib-2.0   -ldbus-glib-1 -ldbus-1 -lglib=
-2.0
=2E./common/libcommon.a

=2E./common/libcommon.a(manager.o): In function `update_adapter_list':
manager.c:(.text+0x26a): undefined reference to `dbus_g_proxy_call'
=2E./common/libcommon.a(manager.o): In function `bluetooth_manager_init':
manager.c:(.text+0x306): undefined reference to `dbus_g_proxy_new_for_name'
manager.c:(.text+0x332): undefined reference to `dbus_g_proxy_add_signal'
manager.c:(.text+0x356): undefined reference to `dbus_g_proxy_connect_signa=
l'
manager.c:(.text+0x376): undefined reference to `dbus_g_proxy_add_signal'
manager.c:(.text+0x39a): undefined reference to `dbus_g_proxy_connect_signa=
l'
=2E./common/libcommon.a(private.o): In function `bluetooth_get_connection':
private.c:(.text+0x2c): undefined reference to `dbus_g_bus_get'
collect2: ld returned 1 exit status
make[2]: *** [bluetooth-sendto] Error 1


If you use ld --as-needed (which is by default in some distributions), you
should write all -l options after, not before .o files (and .a file is
just a collection of .o) which use symbols from that -l libs, or they will
be ignored.=20

Note also that if -lfoo resolves to static lib, this behavior will be
always the same even without --as-needed.

Normally if you use autotools, all that you need to do is writing your
-lfoo to LDADD/LIBADD, not LDFLAGS. But if you link internal static libs
to your binaries, you still need to check the order of -l and .a .

--=20
WBR, wRAR (ALT Linux Team)

--XStn23h1fwudRqtG
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.5 (GNU/Linux)

iD8DBQFFiuayB4Vf7hFmt5URAuYwAJ443p/retlVrcNAYnwGxAs6sDmPTACg37IV
18actFE9YJTXTk11LDWBDOA=
=gOws
-----END PGP SIGNATURE-----

--XStn23h1fwudRqtG--


--===============1064979752==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

-------------------------------------------------------------------------
Take Surveys. Earn Cash. Influence the Future of IT
Join SourceForge.net's Techsay panel and you'll get the chance to share your
opinions on IT & business topics through brief surveys - and earn cash
http://www.techsay.com/default.php?page=join.php&p=sourceforge&CID=DEVDEV
--===============1064979752==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Bluez-devel mailing list
Bluez-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-devel

--===============1064979752==--
