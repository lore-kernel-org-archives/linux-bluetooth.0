Return-Path: <bluez-devel-bounces@lists.sourceforge.net>
MIME-Version: 1.0
Date: Wed, 30 Aug 2006 10:03:45 +0800
Message-ID: <554C5F4C5BA7384EB2B412FD46A3BAD1012AEF87@pdsmsx411.ccr.corp.intel.com>
From: "Li, Lea" <lea.li@intel.com>
To: "BlueZ development" <bluez-devel@lists.sourceforge.net>,
        "Alex B" <squonimo@virgilio.it>
Subject: Re: [Bluez-devel] problem with bluez-utils 3.4 and dbus
Reply-To: BlueZ development <bluez-devel@lists.sourceforge.net>
List-Id: BlueZ development <bluez-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-devel>,
	<mailto:bluez-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=bluez-devel>
List-Post: <mailto:bluez-devel@lists.sourceforge.net>
List-Help: <mailto:bluez-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-devel>,
	<mailto:bluez-devel-request@lists.sourceforge.net?subject=subscribe>
Content-Type: multipart/mixed; boundary="===============0563505105=="
Sender: bluez-devel-bounces@lists.sourceforge.net
Errors-To: bluez-devel-bounces@lists.sourceforge.net

--===============0563505105==
Content-class: urn:content-classes:message
Content-Type: text/plain;
	charset="gb2312"
Content-Transfer-Encoding: quoted-printable

Hi Alex,=20

You should add "DBUS_CFLAGS" & "DBUS_LIBS" options when you executing =
"./configure" from bluez-utils DIR. Of course, D-Bus should be =
cross-compiled successfully before bluez.=20


Thanks,
Lea
=20
-----Original Message-----
From: bluez-devel-bounces@lists.sourceforge.net =
[mailto:bluez-devel-bounces@lists.sourceforge.net] On Behalf Of Marcel =
Holtmann
Sent: 2006=C4=EA8=D4=C230=C8=D5 1:53
To: Alex B; BlueZ development
Subject: Re: [Bluez-devel] problem with bluez-utils 3.4 and dbus

Hi Alex,

> I'm trying to croos compile bluez-utils for XScale.
>=20
> when I write make=20
> Install the error is:
> /usr/local/arm-linux/lib/gcc-lib/arm-linux/3.3.2
> /../../../../arm-linux/bin/ld:
> skipping incompatible=20
> /opt/gnome/lib/libdbus-glib-1.so when searching
> for -ldbus-glib-1
> /usr/local/arm-linux/lib/gcc-lib/arm-linux/3.3.2/../../../../arm-
> linux/bin/ld:
> cannot find -ldbus-glib-1
> collect2: ld returned 1 exit=20
> status
>=20
>=20
> /opt/gnome/lib/libdbus-glib-1.so it's a simlink to=20
> /usr/lib/libdbus-glib-1.so
>=20
> I read all old topics about this problem,=20
> but I never found a solution.
>=20
> the configure string is:
> ./configure --
> host=3Darm-linux --prefix=3D/mydir --whit-bluez=3D/mydir

I don't have a solution for this, because I don't do that much cross
compiling by myself. However since we use pkg-config, it should be
really easy to tell it which libraries to use.

Regards

Marcel



-------------------------------------------------------------------------=

Using Tomcat but need to do more? Need to support web services, =
security?
Get stuff done quickly with pre-integrated technology to make your job =
easier
Download IBM WebSphere Application Server v.1.0.1 based on Apache =
Geronimo
http://sel.as-us.falkag.net/sel?cmd=3Dlnk&kid=3D120709&bid=3D263057&dat=3D=
121642
_______________________________________________
Bluez-devel mailing list
Bluez-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-devel


--===============0563505105==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

-------------------------------------------------------------------------
Using Tomcat but need to do more? Need to support web services, security?
Get stuff done quickly with pre-integrated technology to make your job easier
Download IBM WebSphere Application Server v.1.0.1 based on Apache Geronimo
http://sel.as-us.falkag.net/sel?cmd=lnk&kid=120709&bid=263057&dat=121642
--===============0563505105==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Bluez-devel mailing list
Bluez-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-devel

--===============0563505105==--
