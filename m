Return-Path: <bluez-devel-bounces@lists.sourceforge.net>
Message-ID: <4644C396.2090709@gentoo.org>
Date: Fri, 11 May 2007 22:27:18 +0300
From: =?UTF-8?B?UGV0dGVyaSBSw6R0eQ==?= <betelgeuse@gentoo.org>
MIME-Version: 1.0
To: bluez-devel@lists.sourceforge.net
Subject: [Bluez-devel] Fix linking order so that -Wl,--as-needed works
Reply-To: BlueZ development <bluez-devel@lists.sourceforge.net>
List-Id: BlueZ development <bluez-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-devel>,
	<mailto:bluez-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=bluez-devel>
List-Post: <mailto:bluez-devel@lists.sourceforge.net>
List-Help: <mailto:bluez-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-devel>,
	<mailto:bluez-devel-request@lists.sourceforge.net?subject=subscribe>
Content-Type: multipart/mixed; boundary="===============0647248164=="
Sender: bluez-devel-bounces@lists.sourceforge.net
Errors-To: bluez-devel-bounces@lists.sourceforge.net

This is an OpenPGP/MIME signed message (RFC 2440 and 3156)
--===============0647248164==
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature";
	boundary="------------enig0C1C402963D0DD03B3FC1777"

This is an OpenPGP/MIME signed message (RFC 2440 and 3156)
--------------enig0C1C402963D0DD03B3FC1777
Content-Type: multipart/mixed; boundary="------------030604050602040706010301"

This is a multi-part message in MIME format.
--------------030604050602040706010301
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

gcc -I/usr/include/dbus-1.0 -I/usr/lib/dbus-1.0/include
-I/usr/include/glib-2.0 -I/usr/lib/glib-2.0/include
-I/usr/include/gtk-2.0 -I/usr/lib/gtk-2.0/include -I/usr/include/atk-1.0
-I/usr/include/cairo -I/usr/include/pango-1.0 -I/usr/include/glib-2.0
-I/usr/lib/glib-2.0/include -I/usr/include/freetype2
-I/usr/include/libpng12   -Wall -O2 -D_FORTIFY_SOURCE=3D2  -Wl,--as-neede=
d
-o bluetooth-sendto main.o -lgtk-x11-2.0 -lgdk-x11-2.0 -latk-1.0
-lgdk_pixbuf-2.0 -lm -lpangocairo-1.0 -lpango-1.0 -lcairo -lgobject-2.0
-lgmodule-2.0 -ldl -lglib-2.0   -ldbus-glib-1 -ldbus-1 -lgobject-2.0
-lglib-2.0   ../common/libcommon.a
=2E./common/libcommon.a(client.o): In function
`bluetooth_client_cancel_discovery':
client.c:(.text+0x566): undefined reference to `dbus_g_proxy_call'
=2E./common/libcommon.a(client.o): In function
`bluetooth_client_discover_devices':
client.c:(.text+0x666): undefined reference to `dbus_g_proxy_call'
=2E./common/libcommon.a(client.o): In function
`bluetooth_client_create_bonding':
client.c:(.text+0x79f): undefined reference to `dbus_g_proxy_begin_call'
=2E./common/libcommon.a(client.o): In function
`adapter_create_bonding_async_callback':
client.c:(.text+0x7f1): undefined reference to `dbus_g_proxy_end_call'
=2E./common/libcommon.a(client.o): In function
`bluetooth_client_register_passkey_agent':
client.c:(.text+0x8de): undefined reference to
`dbus_g_object_type_install_info'
client.c:(.text+0x904): undefined reference to
`dbus_g_connection_register_g_object'
client.c:(.text+0x937): undefined reference to `dbus_g_proxy_new_for_name=
'
client.c:(.text+0x974): undefined reference to `dbus_g_proxy_call'
=2E./common/libcommon.a(client.o): In function `insert_device':
client.c:(.text+0xb80): undefined reference to `dbus_g_proxy_call'
client.c:(.text+0xbbd): undefined reference to `dbus_g_proxy_call'
client.c:(.text+0xbfd): undefined reference to `dbus_g_proxy_call'
client.c:(.text+0xc3b): undefined reference to `dbus_g_proxy_call'
=2E./common/libcommon.a(client.o):client.c:(.text+0xf8c): more undefined
references to `dbus_g_proxy_call' follow
=2E./common/libcommon.a(client.o): In function `add_adapter':
client.c:(.text+0x12b1): undefined reference to `dbus_g_proxy_new_for_nam=
e'
client.c:(.text+0x1328): undefined reference to `dbus_g_proxy_add_signal'=

client.c:(.text+0x134f): undefined reference to
`dbus_g_proxy_connect_signal'


This is fixed with the attached patch. See
http://www.gentoo.org/proj/en/qa/asneeded.xml for background.

Regards,
Petteri R=C3=A4ty
--
Gentoo developer

--------------030604050602040706010301
Content-Type: text/x-patch;
 name="bluez-gnome-linking-order.patch"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline;
 filename="bluez-gnome-linking-order.patch"

Index: sendto/Makefile.am
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
RCS file: /cvsroot/bluez/gnome/sendto/Makefile.am,v
retrieving revision 1.3
diff -u -r1.3 Makefile.am
--- sendto/Makefile.am	22 Oct 2006 18:22:25 -0000	1.3
+++ sendto/Makefile.am	11 May 2007 19:02:01 -0000
@@ -3,7 +3,7 @@
=20
 bluetooth_sendto_SOURCES =3D main.c
=20
-bluetooth_sendto_LDADD =3D @GTK_LIBS@ @DBUS_LIBS@ $(top_builddir)/common=
/libcommon.a
+bluetooth_sendto_LDADD =3D $(top_builddir)/common/libcommon.a @GTK_LIBS@=
 @DBUS_LIBS@=20
=20
 AM_CFLAGS =3D @DBUS_CFLAGS@ @GTK_CFLAGS@
=20

--------------030604050602040706010301--

--------------enig0C1C402963D0DD03B3FC1777
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.3 (GNU/Linux)
Comment: Using GnuPG with Mozilla - http://enigmail.mozdev.org

iD8DBQFGRMOWcxLzpIGCsLQRAoUTAJ9xnxIJKchQHSL7rOclqqHMr1DglQCgiQue
PMxW2BAqwJyQsYM9Zq1jotc=
=AgDX
-----END PGP SIGNATURE-----

--------------enig0C1C402963D0DD03B3FC1777--


--===============0647248164==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

-------------------------------------------------------------------------
This SF.net email is sponsored by DB2 Express
Download DB2 Express C - the FREE version of DB2 express and take
control of your XML. No limits. Just data. Click to get it now.
http://sourceforge.net/powerbar/db2/
--===============0647248164==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Bluez-devel mailing list
Bluez-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-devel

--===============0647248164==--
