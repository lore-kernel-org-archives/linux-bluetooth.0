Return-Path: <bluez-users-admin@lists.sourceforge.net>
In-Reply-To: <12800.102184-5119-1899698199-1091734133@email.seznam.cz>
To: Dave Dev <alwaysgone@seznam.cz>
Cc: bluez-users@lists.sourceforge.net, bluez-users-admin@lists.sourceforge.net
Subject: Re: [Bluez-users] Multi-Thread Problem with BlueZ
MIME-Version: 1.0
Message-ID: <OF9C487124.F33ABD74-ON85256EE7.0070DA57-85256EE7.007101FB@alps.com>
From: scott.meesseman@alpsautomotive.com
Date: Thu, 5 Aug 2004 16:34:09 -0400
Content-Type: multipart/alternative; boundary="=_alternative 007101F785256EE7_="
Sender: bluez-users-owner@lists.sourceforge.net
Errors-To: bluez-users-owner@lists.sourceforge.net
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-users>,
	<mailto:bluez-users-request@lists.sourceforge.net?subject=unsubscribe>
List-Id: <bluez-users.lists.sourceforge.net>
List-Post: <mailto:bluez-users@lists.sourceforge.net>
List-Help: <mailto:bluez-users-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-users>,
	<mailto:bluez-users-request@lists.sourceforge.net?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=bluez-users>

This is a multipart message in MIME format.
--=_alternative 007101F785256EE7_=
Content-Type: text/plain; charset="ISO-8859-1"
Content-Transfer-Encoding: quoted-printable

Hello all,

Haven't quite followed this conversation and I dont have any suggestion=20
per say, but I do have a multi-threaded application that uses BlueZ stack=20
and I connect up to 3 sockets at the same time, so it definitely is=20
possible...






Dave Dev <alwaysgone@seznam.cz>=20
Sent by: bluez-users-admin@lists.sourceforge.net
08/05/2004 03:28 PM
Please respond to
Dave Dev <alwaysgone@seznam.cz>


To
bluez-users@lists.sourceforge.net
cc

Subject
[Bluez-users] Multi-Thread Problem with BlueZ






Marcel:

Just dropping a line to say that BlueZ (seemingly) has the same problem we =

had before -- we cannot connect two devices at once to the stack -- when=20
BT is sending information (say, 10 - 100kb), we can't even discover the=20
device it's sending over .... Have you tested it with mutliple socket=20
connections?

If you think it should work, have any ideas why it might not be working?=20
Don't think it's the Rococo stack ...

Best,

D.
=5F=5F=5F=5F=5F=5F=5F=5F=5F=5F=5F=5F=5F=5F=5F=5F=5F=5F=5F=5F=5F=5F=5F=5F=5F=
=5F=5F=5F=5F=5F=5F=5F=5F=5F=5F=5F=5F=5F=5F=5F=5F=5F=5F=5F=5F=5F=5F=5F=5F=5F=
=5F=5F=5F=5F=5F=5F=5F=5F=5F=5F
Letn=ED akce na televizory Panasonic! 150.000 prvni tyden
www.VIDEOEXPERT.cz
Vychutnejte si Olympi=E1du ve velk=E9m stylu!
http://ad.seznam.cz/clickthru?spotId=3D76186


-------------------------------------------------------
This SF.Net email is sponsored by OSTG. Have you noticed the changes on
Linux.com, ITManagersJournal and NewsForge in the past few weeks? Now,
one more big change to announce. We are now OSTG- Open Source Technology
Group. Come see the changes on the new OSTG site. www.ostg.com
=5F=5F=5F=5F=5F=5F=5F=5F=5F=5F=5F=5F=5F=5F=5F=5F=5F=5F=5F=5F=5F=5F=5F=5F=5F=
=5F=5F=5F=5F=5F=5F=5F=5F=5F=5F=5F=5F=5F=5F=5F=5F=5F=5F=5F=5F=5F=5F
Bluez-users mailing list
Bluez-users@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-users


--=_alternative 007101F785256EE7_=
Content-Type: text/html; charset="ISO-8859-1"
Content-Transfer-Encoding: quoted-printable


<br><font size=3D2 face=3D"sans-serif">Hello all,</font>
<br>
<br><font size=3D2 face=3D"sans-serif">Haven't quite followed this conversa=
tion
and I dont have any suggestion per say, but I do have a multi-threaded
application that uses BlueZ stack and I connect up to 3 sockets at the
same time, so it definitely is possible...</font>
<br>
<br><font size=3D2 face=3D"sans-serif"><br>
</font>
<br>
<br>
<br>
<table width=3D100%>
<tr valign=3Dtop>
<td width=3D40%><font size=3D1 face=3D"sans-serif"><b>Dave Dev &lt;alwaysgo=
ne@seznam.cz&gt;</b>
</font>
<br><font size=3D1 face=3D"sans-serif">Sent by: bluez-users-admin@lists.sou=
rceforge.net</font>
<p><font size=3D1 face=3D"sans-serif">08/05/2004 03:28 PM</font>
<table border>
<tr valign=3Dtop>
<td bgcolor=3Dwhite>
<div align=3Dcenter><font size=3D1 face=3D"sans-serif">Please respond to<br>
Dave Dev &lt;alwaysgone@seznam.cz&gt;</font></div></table>
<br>
<td width=3D59%>
<table width=3D100%>
<tr>
<td>
<div align=3Dright><font size=3D1 face=3D"sans-serif">To</font></div>
<td valign=3Dtop><font size=3D1 face=3D"sans-serif">bluez-users@lists.sourc=
eforge.net</font>
<tr>
<td>
<div align=3Dright><font size=3D1 face=3D"sans-serif">cc</font></div>
<td valign=3Dtop>
<tr>
<td>
<div align=3Dright><font size=3D1 face=3D"sans-serif">Subject</font></div>
<td valign=3Dtop><font size=3D1 face=3D"sans-serif">[Bluez-users] Multi-Thr=
ead
Problem with BlueZ</font></table>
<br>
<table>
<tr valign=3Dtop>
<td>
<td></table>
<br></table>
<br>
<br>
<br><font size=3D2><tt>Marcel:<br>
<br>
Just dropping a line to say that BlueZ (seemingly) has the same problem
we had before -- we cannot connect two devices at once to the stack --
when BT is sending information (say, 10 - 100kb), we can't even discover
the device it's sending over .... Have you tested it with mutliple socket
connections?<br>
<br>
If you think it should work, have any ideas why it might not be working?
&nbsp;Don't think it's the Rococo stack ...<br>
<br>
Best,<br>
<br>
D.<br>
=5F=5F=5F=5F=5F=5F=5F=5F=5F=5F=5F=5F=5F=5F=5F=5F=5F=5F=5F=5F=5F=5F=5F=5F=5F=
=5F=5F=5F=5F=5F=5F=5F=5F=5F=5F=5F=5F=5F=5F=5F=5F=5F=5F=5F=5F=5F=5F=5F=5F=5F=
=5F=5F=5F=5F=5F=5F=5F=5F=5F=5F<br>
Letn=ED akce na televizory Panasonic! 150.000 prvni tyden<br>
www.VIDEOEXPERT.cz<br>
Vychutnejte si Olympi=E1du ve velk=E9m stylu!<br>
http://ad.seznam.cz/clickthru?spotId=3D76186<br>
<br>
<br>
-------------------------------------------------------<br>
This SF.Net email is sponsored by OSTG. Have you noticed the changes on<br>
Linux.com, ITManagersJournal and NewsForge in the past few weeks? Now,<br>
one more big change to announce. We are now OSTG- Open Source Technology<br>
Group. Come see the changes on the new OSTG site. www.ostg.com<br>
=5F=5F=5F=5F=5F=5F=5F=5F=5F=5F=5F=5F=5F=5F=5F=5F=5F=5F=5F=5F=5F=5F=5F=5F=5F=
=5F=5F=5F=5F=5F=5F=5F=5F=5F=5F=5F=5F=5F=5F=5F=5F=5F=5F=5F=5F=5F=5F<br>
Bluez-users mailing list<br>
Bluez-users@lists.sourceforge.net<br>
https://lists.sourceforge.net/lists/listinfo/bluez-users<br>
</tt></font>
<br>
--=_alternative 007101F785256EE7_=--
