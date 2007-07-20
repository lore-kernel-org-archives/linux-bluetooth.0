Return-Path: <bluez-users-bounces@lists.sourceforge.net>
From: Sumeet VERMA <sumeet.verma@st.com>
To: "'BlueZ users'" <bluez-users@lists.sourceforge.net>
Date: Fri, 20 Jul 2007 13:46:15 +0530
Message-ID: <004d01c7caa6$3e0d4f30$832fc70a@dlh.st.com>
MIME-Version: 1.0
In-Reply-To: <EJENLMBEOLKAMCJFBFMDOEDDCAAA.leiyu@kcoe.cn>
Subject: Re: [Bluez-users] Fail in cross-compile bluez-utils-3.9
Reply-To: BlueZ users <bluez-users@lists.sourceforge.net>
List-Id: BlueZ users <bluez-users.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-users>,
	<mailto:bluez-users-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=bluez-users>
List-Post: <mailto:bluez-users@lists.sourceforge.net>
List-Help: <mailto:bluez-users-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-users>,
	<mailto:bluez-users-request@lists.sourceforge.net?subject=subscribe>
Content-Type: multipart/mixed; boundary="===============1446465702=="
Sender: bluez-users-bounces@lists.sourceforge.net
Errors-To: bluez-users-bounces@lists.sourceforge.net

--===============1446465702==
Content-Type: text/plain;
	charset="gb2312"
Content-Transfer-Encoding: quoted-printable

Hi Leiyu
You can add the path of your toolchain to the PATH variable
PATH=3D$PATH:/usr/local/arm/3.4.1/bin
That way you don=A1=AFt have to specify options for CC, CPP, AR, =
STRIP..etc.
Just providing --host option is enough. The configure script will search =
the
PATH for installed toolchain.=20

When you installed the bluez-libs, the bluez.pc file should be created =
in
the libs directory that you gave with the --prefix option. Add that path =
to
the PKG_CONFIG_PATH variable
e.g  export PKG_CONFIG_PATH=3D/bluez/bluezlibs/pkgconfig

Doing this change should fix your problem.


Regards,
Sumeet=20
-----Original Message-----
From: bluez-users-bounces@lists.sourceforge.net
[mailto:bluez-users-bounces@lists.sourceforge.net] On Behalf Of leiyu
Sent: Friday, July 20, 2007 1:26 PM
To: Bluez-Users
Subject: [Bluez-users] Fail in cross-compile bluez-utils-3.9

Dear All,

I use arm-linux-gcc-3.4.1 to cross-compile bluez-libs-3.9 and =
bluez-utils-3.
9 I success in cross-compile bluez-libs-3.9 ,but fail in bluez-utils-3.9 =
,

/usr/bluez/bluezlibs is the directory I install bluez-libs-3.9   =20
/usr/local/arm/linux-2.6.14.1 is the kernel diretory

[root@localhost bluez-utils-3.9]# ./configure =
--prefix=3D/bluez/bluezutils
--includedir=3D/bluez/bluezlibs/include --libdir=3D/bluez/bluezlibs/lib
--host=3Darm-linux CC=3D/usr/local/arm/3.4.1/bin/arm-linux-gcc
CPP=3D/usr/local/arm/3.4.1/bin/arm-linux-cpp
AR=3D/usr/local/arm/3.4.1/bin/arm-linux-ar
STRIP=3D/usr/local/arm/3.4.1/bin/arm-linux-strip
RANLIB=3D/usr/local/arm/3.4.1/bin/arm-linux-ranlib
LD=3D/usr/local/arm/3.4.1/bin/arm-linux-ld =
--with-bluez-libs=3D/bluez/bluezlibs
--with-kernel=3D/usr/local/arm/linux-2.6.14.1
.......
checking if libtool supports shared libraries... yes checking whether to
build shared libraries... yes checking whether to build static =
libraries...
no
configure: creating libtool
checking for ppoll... no
checking for arm-linux-pkg-config... no
checking for pkg-config... /usr/bin/pkg-config checking pkg-config is at
least version 0.9.0... yes checking for BLUEZ... no
configure: error: Bluetooth library is required

Is my gcc version  not suit for it ? or Is my configure parameter not =
right
? I appreciate for your comment, thanks=20
=20
Best regards,
Leiyu




--===============1446465702==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

-------------------------------------------------------------------------
This SF.net email is sponsored by: Microsoft
Defy all challenges. Microsoft(R) Visual Studio 2005.
http://clk.atdmt.com/MRT/go/vse0120000070mrt/direct/01/
--===============1446465702==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Bluez-users mailing list
Bluez-users@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-users

--===============1446465702==--
