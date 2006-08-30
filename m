Return-Path: <bluez-devel-bounces@lists.sourceforge.net>
MIME-Version: 1.0
Date: Wed, 30 Aug 2006 10:27:07 +0800
Message-ID: <554C5F4C5BA7384EB2B412FD46A3BAD1012AEFDA@pdsmsx411.ccr.corp.intel.com>
From: "Li, Lea" <lea.li@intel.com>
To: "BlueZ development" <bluez-devel@lists.sourceforge.net>
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
Content-Type: multipart/mixed; boundary="===============0720262089=="
Sender: bluez-devel-bounces@lists.sourceforge.net
Errors-To: bluez-devel-bounces@lists.sourceforge.net

--===============0720262089==
Content-class: urn:content-classes:message
Content-Type: text/plain;
	charset="gb2312"
Content-Transfer-Encoding: quoted-printable

To cross compile D-Bus, I have to manually modify the "./configure" file =
to skip testing of some functions, such as getpwnam_r. :(

=20
Thanks,
Lea
=20

-----Original Message-----
From: bluez-devel-bounces@lists.sourceforge.net =
[mailto:bluez-devel-bounces@lists.sourceforge.net] On Behalf Of Marco =
Pracucci
Sent: 2006=C4=EA8=D4=C230=C8=D5 4:18
To: BlueZ development
Subject: Re: [Bluez-devel] problem with bluez-utils 3.4 and dbus

Hi Alex,

> /usr/local/arm-linux/lib/gcc-lib/arm-linux/3.3.2/../../../../arm-
> linux/bin/ld:
> cannot find -ldbus-glib-1
> collect2: ld returned 1 exit=20
> status

Have you cross compiled dbus?
If you have cross compiled dbus you should add -L<dbus library path> to
LDFLAG, where <dbus library path> is the path to the cross compiled dbus
library.

Moreover, if you have cross compiled dbus, can you tell us how you have
successfully run the configure script?

Regards,
Marco Pracucci


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


--===============0720262089==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

-------------------------------------------------------------------------
Using Tomcat but need to do more? Need to support web services, security?
Get stuff done quickly with pre-integrated technology to make your job easier
Download IBM WebSphere Application Server v.1.0.1 based on Apache Geronimo
http://sel.as-us.falkag.net/sel?cmd=lnk&kid=120709&bid=263057&dat=121642
--===============0720262089==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Bluez-devel mailing list
Bluez-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-devel

--===============0720262089==--
