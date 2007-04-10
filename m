Return-Path: <bluez-devel-bounces@lists.sourceforge.net>
MIME-Version: 1.0
Date: Tue, 10 Apr 2007 10:41:42 -0400
Message-ID: <2EB6297382462046A9427D7324788A4801C72749@MCLNEXVS06.resource.ds.bah.com>
In-reply-to: <935275.31792.qm@web50211.mail.re2.yahoo.com>
References: <935275.31792.qm@web50211.mail.re2.yahoo.com>
From: "Williams, Richard" <williams_richard_b@bah.com>
To: "BlueZ development" <bluez-devel@lists.sourceforge.net>
Subject: Re: [Bluez-devel] Mutliple Dongles with Bluez
Reply-To: BlueZ development <bluez-devel@lists.sourceforge.net>
List-Id: BlueZ development <bluez-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-devel>,
	<mailto:bluez-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=bluez-devel>
List-Post: <mailto:bluez-devel@lists.sourceforge.net>
List-Help: <mailto:bluez-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-devel>,
	<mailto:bluez-devel-request@lists.sourceforge.net?subject=subscribe>
Content-Type: multipart/mixed; boundary="===============0121948808=="
Sender: bluez-devel-bounces@lists.sourceforge.net
Errors-To: bluez-devel-bounces@lists.sourceforge.net

This is a multi-part message in MIME format.

--===============0121948808==
Content-class: urn:content-classes:message
Content-Type: multipart/alternative;
	boundary="----_=_NextPart_001_01C77B7E.5B6F024B"

This is a multi-part message in MIME format.

------_=_NextPart_001_01C77B7E.5B6F024B
Content-Type: text/plain;
	charset="us-ascii"
Content-Transfer-Encoding: quoted-printable

 Shaun,=20
 > Anybody knows if its possible to interface multiple bluetooth dongles
with Bluez? =20
> I would like to get pass the maximum 7 connections per dongle
limitation of Bluetooth =20
> by installing more than one bluetooth dongle to a computer and thus
increasing the =20
> number of connections available.
 >=20
 > Anybody have experience developing such applications?
 >=20
=20
This works fine, but make sure you have the latest Bluez libs. And make
sure you have a=20
kernel at least 2.6.20 vintage. If not, then when you're running two
simultaneous commands to=20
two different Bluetooth devices, you may get a kernel oops.
=20
Otherwise, its easy enough to write a multi-threaded application that
addresses multiple dongles.
And it works very well.
=20
-Rich

________________________________

We won't tell. Get more on shows you hate to love
<http://us.rd.yahoo.com/evt=3D49980/*http://tv.yahoo.com/collections/265>=
=20
(and love to hate): Yahoo! TV's Guilty Pleasures list.
<http://us.rd.yahoo.com/evt=3D49980/*http://tv.yahoo.com/collections/265>=
=20

------_=_NextPart_001_01C77B7E.5B6F024B
Content-Type: text/html;
	charset="us-ascii"
Content-Transfer-Encoding: quoted-printable

<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.0 Transitional//EN">
<HTML><HEAD>
<META http-equiv=3DContent-Type content=3D"text/html; =
charset=3Dus-ascii">
<META content=3D"MSHTML 6.00.2900.3059" name=3DGENERATOR></HEAD>
<BODY><FONT face=3DArial color=3D#0000ff size=3D2></FONT>
<DIV><SPAN class=3D774122414-10042007><FONT face=3DArial color=3D#0000ff =

size=3D2>&nbsp;Shaun,&nbsp;</FONT></SPAN><BR><SPAN =
class=3D774122414-10042007><FONT=20
face=3DArial color=3D#0000ff =
size=3D2>&nbsp;&gt;&nbsp;</FONT></SPAN>Anybody knows if=20
its possible to interface multiple bluetooth dongles with =
Bluez?&nbsp;<SPAN=20
class=3D774122414-10042007><FONT face=3DArial color=3D#0000ff=20
size=3D2>&nbsp;</FONT></SPAN></DIV>
<DIV><SPAN class=3D774122414-10042007><FONT face=3DArial color=3D#0000ff =

size=3D2>&gt;</FONT>&nbsp;</SPAN>I would like to get pass the maximum 7=20
connections per dongle limitation of Bluetooth&nbsp;<SPAN=20
class=3D774122414-10042007><FONT face=3DArial color=3D#0000ff=20
size=3D2>&nbsp;</FONT></SPAN></DIV>
<DIV><SPAN class=3D774122414-10042007><FONT face=3DArial color=3D#0000ff =

size=3D2>&gt;</FONT>&nbsp;</SPAN>by installing more than one bluetooth =
dongle to a=20
computer and thus increasing the&nbsp;<SPAN =
class=3D774122414-10042007><FONT=20
face=3DArial color=3D#0000ff size=3D2>&nbsp;</FONT></SPAN></DIV>
<DIV><SPAN class=3D774122414-10042007><FONT face=3DArial color=3D#0000ff =

size=3D2>&gt;</FONT>&nbsp;</SPAN>number of connections =
available.<BR><SPAN=20
class=3D774122414-10042007><FONT face=3DArial color=3D#0000ff=20
size=3D2>&nbsp;&gt;&nbsp;</FONT></SPAN><BR><SPAN =
class=3D774122414-10042007><FONT=20
face=3DArial color=3D#0000ff =
size=3D2>&nbsp;&gt;&nbsp;</FONT></SPAN>Anybody have=20
experience developing such applications?<BR><SPAN =
class=3D774122414-10042007><FONT=20
face=3DArial color=3D#0000ff =
size=3D2>&nbsp;&gt;&nbsp;</FONT></SPAN><BR><SPAN=20
class=3D774122414-10042007><FONT face=3DArial color=3D#0000ff=20
size=3D2>&nbsp;</FONT></SPAN></DIV>
<DIV><SPAN class=3D774122414-10042007><FONT face=3DArial color=3D#0000ff =
size=3D2>This=20
works fine, but make sure you have the latest Bluez&nbsp;libs. And make =
sure you=20
have a </FONT></SPAN></DIV>
<DIV><SPAN class=3D774122414-10042007><FONT face=3DArial color=3D#0000ff =
size=3D2>kernel=20
at least 2.6.20 vintage.</FONT>&nbsp;<FONT face=3DArial color=3D#0000ff =
size=3D2>If=20
not, then when you're running two simultaneous commands to =
</FONT></SPAN></DIV>
<DIV><SPAN class=3D774122414-10042007><FONT face=3DArial color=3D#0000ff =
size=3D2>two=20
different Bluetooth devices, you may get a kernel =
oops.</FONT></SPAN></DIV>
<DIV><SPAN class=3D774122414-10042007><FONT face=3DArial color=3D#0000ff =

size=3D2></FONT></SPAN>&nbsp;</DIV>
<DIV><SPAN class=3D774122414-10042007><FONT face=3DArial color=3D#0000ff =

size=3D2>Otherwise, its easy enough to write a multi-threaded =
application that=20
addresses multiple dongles.</FONT></SPAN></DIV>
<DIV><SPAN class=3D774122414-10042007><FONT face=3DArial color=3D#0000ff =
size=3D2>And it=20
works very well.</FONT></SPAN></DIV>
<DIV><SPAN class=3D774122414-10042007><FONT face=3DArial color=3D#0000ff =

size=3D2></FONT></SPAN>&nbsp;</DIV>
<DIV><SPAN class=3D774122414-10042007><FONT face=3DArial color=3D#0000ff =

size=3D2>-Rich</FONT></SPAN></DIV>
<P>
<HR SIZE=3D1>
We won't tell. Get more on <A=20
href=3D"http://us.rd.yahoo.com/evt=3D49980/*http://tv.yahoo.com/collectio=
ns/265">shows=20
you hate to love</A><BR>(and love to hate): <A=20
href=3D"http://us.rd.yahoo.com/evt=3D49980/*http://tv.yahoo.com/collectio=
ns/265">Yahoo!=20
TV's Guilty Pleasures list.</A></BODY></HTML>

------_=_NextPart_001_01C77B7E.5B6F024B--


--===============0121948808==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

-------------------------------------------------------------------------
Take Surveys. Earn Cash. Influence the Future of IT
Join SourceForge.net's Techsay panel and you'll get the chance to share your
opinions on IT & business topics through brief surveys-and earn cash
http://www.techsay.com/default.php?page=join.php&p=sourceforge&CID=DEVDEV
--===============0121948808==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Bluez-devel mailing list
Bluez-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-devel

--===============0121948808==--
