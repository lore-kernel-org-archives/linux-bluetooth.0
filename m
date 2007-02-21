Return-Path: <bluez-users-bounces@lists.sourceforge.net>
Message-ID: <001001c755ae$d755e6b0$c301a8c0@Bahubali>
From: "vikram" <vikram.bidkar@adamya.com>
To: <bluez-users@lists.sourceforge.net>
Date: Wed, 21 Feb 2007 17:22:57 +0530
MIME-Version: 1.0
Subject: [Bluez-users] dbus-glib-1 was not found
Reply-To: BlueZ users <bluez-users@lists.sourceforge.net>
List-Id: BlueZ users <bluez-users.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-users>,
	<mailto:bluez-users-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=bluez-users>
List-Post: <mailto:bluez-users@lists.sourceforge.net>
List-Help: <mailto:bluez-users-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-users>,
	<mailto:bluez-users-request@lists.sourceforge.net?subject=subscribe>
Content-Type: multipart/mixed; boundary="===============0556605089=="
Sender: bluez-users-bounces@lists.sourceforge.net
Errors-To: bluez-users-bounces@lists.sourceforge.net

This is a multi-part message in MIME format.

--===============0556605089==
Content-Type: multipart/alternative;
	boundary="----=_NextPart_000_000D_01C755DC.EE10C130"

This is a multi-part message in MIME format.

------=_NextPart_000_000D_01C755DC.EE10C130
Content-Type: text/plain;
	charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable

Hi All,

I am trying to Build and run the test programs from utils. for that I =
carried out following steps.

1) Run ./configure --prefix=3D/usr
and make && make install from ..\BlueZ\libs\bluez-libs-3.9 and =
successfully installed BlueZ.

2)Successfully installed D-Bus 1.0.2 from www.freedesktop.com.

3) run ./configure --prefix=3D/usr --mandir=3D/usr/share/man \
  --sysconfdir=3D/etc --localstatedir=3D/var --libexecdir=3D/lib
from ..\BlueZ\utils\bluez-utils-3.9

but I am getting following errors.

> Package dbus-glib-1 was not found
> package openobex was not found
> Package opensync-1.0 was not found
> Package libusb not found

4) run make && make istall from ..\BlueZ\utils\bluez-utils-3.9. and got =
following error.
"undefined referance to XML_Stopparser"

Please suggest me solution.

Regards,
Vikram
------=_NextPart_000_000D_01C755DC.EE10C130
Content-Type: text/html;
	charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable

<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.0 Transitional//EN">
<HTML><HEAD>
<META http-equiv=3DContent-Type content=3D"text/html; =
charset=3Diso-8859-1">
<META content=3D"MSHTML 6.00.2800.1586" name=3DGENERATOR>
<STYLE></STYLE>
</HEAD>
<BODY bgColor=3D#ffffff>
<DIV><FONT face=3DArial size=3D2>Hi All,</FONT></DIV>
<DIV><FONT face=3DArial size=3D2></FONT>&nbsp;</DIV>
<DIV><FONT face=3DArial size=3D2>I am trying to Build and run the test =
programs from=20
utils. for that I carried out following steps.</FONT></DIV>
<DIV><FONT face=3DArial size=3D2></FONT>&nbsp;</DIV>
<DIV><FONT face=3DArial size=3D2>1) Run ./configure =
--prefix=3D/usr<BR>and make=20
&amp;&amp; make install from ..\BlueZ\libs\bluez-libs-3.9 and =
successfully=20
installed BlueZ.</FONT></DIV>
<DIV><FONT face=3DArial size=3D2></FONT>&nbsp;</DIV>
<DIV><FONT face=3DArial size=3D2>2)Successfully installed D-Bus 1.0.2 =
from <A=20
href=3D"http://www.freedesktop.com">www.freedesktop.com</A>.</FONT></DIV>=

<DIV>&nbsp;</DIV>
<DIV><FONT face=3DArial size=3D2>3) run ./configure --prefix=3D/usr=20
--mandir=3D/usr/share/man \<BR>&nbsp;&nbsp;--sysconfdir=3D/etc =
--localstatedir=3D/var=20
--libexecdir=3D/lib<BR>from ..\BlueZ\utils\bluez-utils-3.9</FONT></DIV>
<DIV>&nbsp;</DIV>
<DIV><FONT face=3DArial size=3D2>but I am getting following =
errors.</FONT></DIV>
<DIV>&nbsp;</DIV>
<DIV><FONT face=3DArial color=3D#ff0000 size=3D2>&gt; Package =
dbus-glib-1 was not=20
found<BR>&gt; package openobex was not found<BR>&gt; Package =
opensync-1.0 was=20
not found<BR>&gt; Package libusb not found</FONT></DIV>
<DIV><FONT face=3DArial size=3D2></FONT>&nbsp;</DIV>
<DIV><FONT face=3DArial size=3D2>4) run make &amp;&amp; make istall from =

..\BlueZ\utils\bluez-utils-3.9. and got following error.<BR><FONT=20
color=3D#ff0000>"undefined referance to =
XML_Stopparser"</FONT></FONT></DIV>
<DIV><FONT face=3DArial size=3D2></FONT>&nbsp;</DIV>
<DIV><FONT face=3DArial size=3D2>Please suggest me =
solution.</FONT></DIV>
<DIV><FONT face=3DArial size=3D2></FONT>&nbsp;</DIV>
<DIV><FONT face=3DArial size=3D2>Regards,</FONT></DIV>
<DIV><FONT face=3DArial size=3D2>Vikram</FONT></DIV></BODY></HTML>

------=_NextPart_000_000D_01C755DC.EE10C130--



--===============0556605089==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

-------------------------------------------------------------------------
Take Surveys. Earn Cash. Influence the Future of IT
Join SourceForge.net's Techsay panel and you'll get the chance to share your
opinions on IT & business topics through brief surveys-and earn cash
http://www.techsay.com/default.php?page=join.php&p=sourceforge&CID=DEVDEV
--===============0556605089==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Bluez-users mailing list
Bluez-users@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-users

--===============0556605089==--
