Return-Path: <bluez-users-bounces@lists.sourceforge.net>
Message-ID: <00b401c75a7c$6f0a77b0$c301a8c0@Bahubali>
From: "vikram" <vikram.bidkar@adamya.com>
To: <bluez-users@lists.sourceforge.net>
Date: Tue, 27 Feb 2007 20:04:06 +0530
MIME-Version: 1.0
Subject: [Bluez-users] undefined reference to `XML_StopParser'
Reply-To: BlueZ users <bluez-users@lists.sourceforge.net>
List-Id: BlueZ users <bluez-users.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-users>,
	<mailto:bluez-users-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=bluez-users>
List-Post: <mailto:bluez-users@lists.sourceforge.net>
List-Help: <mailto:bluez-users-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-users>,
	<mailto:bluez-users-request@lists.sourceforge.net?subject=subscribe>
Content-Type: multipart/mixed; boundary="===============0944778290=="
Sender: bluez-users-bounces@lists.sourceforge.net
Errors-To: bluez-users-bounces@lists.sourceforge.net

This is a multi-part message in MIME format.

--===============0944778290==
Content-Type: multipart/alternative;
	boundary="----=_NextPart_000_00AF_01C75AAA.6F5833A0"

This is a multi-part message in MIME format.

------=_NextPart_000_00AF_01C75AAA.6F5833A0
Content-Type: text/plain;
	charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable

Hi Marcel,

If I run make && make istall from ..\BlueZ\utils\bluez-utils-3.9.=20
got following error.


./common/libhelper.a(sdp-expat.o)(.text+0x227): In function =
`convert_xml_to_sdp_start':
: undefined reference to `XML_StopParser'
collect2: ld returned 1 exit status
make[3]: *** [hcid] Error 1
make[3]: Leaving directory `/root/vikram/bluez-utils-3.9/hcid'
make[2]: *** [all] Error 2
make[2]: Leaving directory `/root/vikram/bluez-utils-3.9/hcid'
make[1]: *** [all-recursive] Error 1
make[1]: Leaving directory `/root/vikram/bluez-utils-3.9'
make: *** [all] Error 2

if I call configure with --enable-glib

I am getting following error

dbus-service.c:765: error: `GKeyFile' undeclared (first use in this =
function)
dbus-service.c:765: error: (Each undeclared identifier is reported only =
once
dbus-service.c:765: error: for each function it appears in.)
dbus-service.c:765: error: `keyfile' undeclared (first use in this =
function)
dbus-service.c:771: warning: implicit declaration of function =
`g_try_new0'
dbus-service.c:771: error: syntax error before "struct"
dbus-service.c:779: warning: implicit declaration of function =
`g_key_file_new'
dbus-service.c:781: warning: implicit declaration of function =
`g_key_file_load_from_file'
dbus-service.c:787: warning: implicit declaration of function =
`g_key_file_get_string'
dbus-service.c:788: warning: assignment makes pointer from integer =
without a cast
dbus-service.c:796: warning: assignment makes pointer from integer =
without a cast
dbus-service.c:812: warning: assignment makes pointer from integer =
without a cast
dbus-service.c:819: warning: implicit declaration of function =
`g_key_file_get_boolean'
dbus-service.c:828: warning: implicit declaration of function =
`g_key_file_free'
dbus-service.c: In function `create_external_service':
dbus-service.c:948: error: syntax error before "struct"
make[3]: *** [dbus-service.o] Error 1
make[3]: Leaving directory `/root/vikram/bluez-utils-3.9/hcid'
make[2]: *** [all] Error 2
make[2]: Leaving directory `/root/vikram/bluez-utils-3.9/hcid'
make[1]: *** [all-recursive] Error 1
make[1]: Leaving directory `/root/vikram/bluez-utils-3.9'
make: *** [all] Error 2


Regards,
Vikram
------=_NextPart_000_00AF_01C75AAA.6F5833A0
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
<DIV><FONT face=3DArial size=3D2>Hi Marcel,</FONT></DIV>
<DIV><FONT face=3DArial size=3D2></FONT>&nbsp;</DIV>
<DIV><FONT face=3DArial size=3D2><FONT face=3D"Times New Roman" =
size=3D3>If I run make=20
&amp;&amp; make istall from ..\BlueZ\utils\bluez-utils-3.9. <BR>got =
following=20
error.</FONT><BR></FONT></DIV>
<DIV><FONT face=3DArial size=3D2></FONT>&nbsp;</DIV>
<DIV><FONT face=3DArial color=3D#ff0000=20
size=3D2>./common/libhelper.a(sdp-expat.o)(.text+0x227): In function=20
`convert_xml_to_sdp_start':<BR>: undefined reference to=20
`XML_StopParser'<BR>collect2: ld returned 1 exit status<BR>make[3]: *** =
[hcid]=20
Error 1<BR>make[3]: Leaving directory=20
`/root/vikram/bluez-utils-3.9/hcid'<BR>make[2]: *** [all] Error =
2<BR>make[2]:=20
Leaving directory `/root/vikram/bluez-utils-3.9/hcid'<BR>make[1]: ***=20
[all-recursive] Error 1<BR>make[1]: Leaving directory=20
`/root/vikram/bluez-utils-3.9'<BR>make: *** [all] Error 2</FONT></DIV>
<DIV><FONT face=3DArial color=3D#ff0000 size=3D2></FONT>&nbsp;</DIV>
<DIV>if&nbsp;I call configure with --enable-glib</DIV>
<DIV>&nbsp;</DIV>
<DIV><FONT face=3DArial size=3D2>I am getting following =
error</FONT></DIV>
<DIV><FONT face=3DArial size=3D2></FONT>&nbsp;</DIV>
<DIV><FONT face=3DArial color=3D#ff0000 size=3D2>dbus-service.c:765: =
error: `GKeyFile'=20
undeclared (first use in this function)<BR>dbus-service.c:765: error: =
(Each=20
undeclared identifier is reported only once<BR>dbus-service.c:765: =
error: for=20
each function it appears in.)<BR>dbus-service.c:765: error: `keyfile' =
undeclared=20
(first use in this function)<BR>dbus-service.c:771: warning: implicit=20
declaration of function `g_try_new0'<BR>dbus-service.c:771: error: =
syntax error=20
before "struct"<BR>dbus-service.c:779: warning: implicit declaration of =
function=20
`g_key_file_new'<BR>dbus-service.c:781: warning: implicit declaration of =

function `g_key_file_load_from_file'<BR>dbus-service.c:787: warning: =
implicit=20
declaration of function `g_key_file_get_string'<BR>dbus-service.c:788: =
warning:=20
assignment makes pointer from integer without a =
cast<BR>dbus-service.c:796:=20
warning: assignment makes pointer from integer without a=20
cast<BR>dbus-service.c:812: warning: assignment makes pointer from =
integer=20
without a cast<BR>dbus-service.c:819: warning: implicit declaration of =
function=20
`g_key_file_get_boolean'<BR>dbus-service.c:828: warning: implicit =
declaration of=20
function `g_key_file_free'<BR>dbus-service.c: In function=20
`create_external_service':<BR>dbus-service.c:948: error: syntax error =
before=20
"struct"<BR>make[3]: *** [dbus-service.o] Error 1<BR>make[3]: Leaving =
directory=20
`/root/vikram/bluez-utils-3.9/hcid'<BR>make[2]: *** [all] Error =
2<BR>make[2]:=20
Leaving directory `/root/vikram/bluez-utils-3.9/hcid'<BR>make[1]: ***=20
[all-recursive] Error 1<BR>make[1]: Leaving directory=20
`/root/vikram/bluez-utils-3.9'<BR>make: *** [all] Error 2</FONT></DIV>
<DIV><FONT face=3DArial color=3D#ff0000 size=3D2></FONT>&nbsp;</DIV>
<DIV><FONT face=3DArial color=3D#ff0000 size=3D2></FONT>&nbsp;</DIV>
<DIV><FONT face=3DArial size=3D2>Regards,</FONT></DIV>
<DIV><FONT face=3DArial size=3D2>Vikram</FONT></DIV></BODY></HTML>

------=_NextPart_000_00AF_01C75AAA.6F5833A0--



--===============0944778290==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

-------------------------------------------------------------------------
Take Surveys. Earn Cash. Influence the Future of IT
Join SourceForge.net's Techsay panel and you'll get the chance to share your
opinions on IT & business topics through brief surveys-and earn cash
http://www.techsay.com/default.php?page=join.php&p=sourceforge&CID=DEVDEV
--===============0944778290==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Bluez-users mailing list
Bluez-users@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-users

--===============0944778290==--
