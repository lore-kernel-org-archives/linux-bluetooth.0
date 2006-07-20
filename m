Return-Path: <bluez-users-bounces@lists.sourceforge.net>
MIME-Version: 1.0
Date: Thu, 20 Jul 2006 12:00:36 +0200
Message-ID: <78338BC4EB35DC488A56F870C94161F1331D92@si-cmn1.coind.dom>
From: "Baschieri Francesco" <fbaschieri@sirea.it>
To: <bluez-users@lists.sourceforge.net>
Subject: [Bluez-users] ARM-linux and multiple USB dongles
Reply-To: BlueZ users <bluez-users@lists.sourceforge.net>
List-Id: BlueZ users <bluez-users.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-users>,
	<mailto:bluez-users-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=bluez-users>
List-Post: <mailto:bluez-users@lists.sourceforge.net>
List-Help: <mailto:bluez-users-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-users>,
	<mailto:bluez-users-request@lists.sourceforge.net?subject=subscribe>
Content-Type: multipart/mixed; boundary="===============1442415493=="
Sender: bluez-users-bounces@lists.sourceforge.net
Errors-To: bluez-users-bounces@lists.sourceforge.net

This is a multi-part message in MIME format.

--===============1442415493==
Content-class: urn:content-classes:message
Content-Type: multipart/alternative;
	boundary="----_=_NextPart_001_01C6ABE3.58AD4C3F"

This is a multi-part message in MIME format.

------_=_NextPart_001_01C6ABE3.58AD4C3F
Content-Type: text/plain;
	charset="us-ascii"
Content-Transfer-Encoding: quoted-printable

Hello all,
=20
I'm facing this problem on ARM-linux (2.4.26) and 2 USB dongles on a
TS-7200 SBC by technologic systems.
=20
When I plug the 1st dongle, it is correctly initialized and it works
okay.
When I plug the 2nd one, it is regognized but I can't get it working:
hciconfig hc1 up returns timeout(110).
=20
If I unplug hci0 (the first dongle) then hci1 starts working.
=20
I have been trying this with different dongles & different chipsets but
I still get the same results.
On the development machine (i86 with same Kernel version) everything
works ok.
=20
At the beginning I thought this might be some problem with USB support
on the board. But I have been able to operate up to 7 simultaneous USB
devices on the board (not bluetooth) and they work ok.
=20
Are there any known issues about multiple devices and ARM?=20
=20
Thanks in advance,
Francesco
=20

------_=_NextPart_001_01C6ABE3.58AD4C3F
Content-Type: text/html;
	charset="us-ascii"
Content-Transfer-Encoding: quoted-printable

<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.0 Transitional//EN">
<HTML><HEAD><TITLE>Messaggio</TITLE>
<META http-equiv=3DContent-Type content=3D"text/html; =
charset=3Dus-ascii">
<META content=3D"MSHTML 6.00.2900.2668" name=3DGENERATOR></HEAD>
<BODY>
<DIV><SPAN class=3D847135409-20072006><FONT face=3DArial size=3D2>Hello=20
all,</FONT></SPAN></DIV>
<DIV><SPAN class=3D847135409-20072006><FONT face=3DArial=20
size=3D2></FONT></SPAN>&nbsp;</DIV>
<DIV><SPAN class=3D847135409-20072006><FONT face=3DArial size=3D2>I'm =
facing this=20
problem on ARM-linux (2.4.26) and 2 USB dongles on a TS-7200 SBC by =
technologic=20
systems.</FONT></SPAN></DIV>
<DIV><SPAN class=3D847135409-20072006><FONT face=3DArial=20
size=3D2></FONT></SPAN>&nbsp;</DIV>
<DIV><SPAN class=3D847135409-20072006><FONT face=3DArial size=3D2>When I =
plug the 1st=20
dongle, it is correctly initialized and it works =
okay.</FONT></SPAN></DIV>
<DIV><SPAN class=3D847135409-20072006><FONT face=3DArial size=3D2>When I =
plug the 2nd=20
one, it is regognized but I can't get it working: hciconfig hc1 up =
returns=20
timeout(110).</FONT></SPAN></DIV>
<DIV><SPAN class=3D847135409-20072006><FONT face=3DArial=20
size=3D2></FONT></SPAN>&nbsp;</DIV>
<DIV><SPAN class=3D847135409-20072006><FONT face=3DArial size=3D2>If I =
unplug hci0=20
(the first dongle) then hci1 starts working.</FONT></SPAN></DIV>
<DIV><SPAN class=3D847135409-20072006><FONT face=3DArial=20
size=3D2></FONT></SPAN>&nbsp;</DIV>
<DIV><SPAN class=3D847135409-20072006><FONT face=3DArial size=3D2>I have =
been trying=20
this with different dongles &amp; different chipsets but I still get the =
same=20
results.</FONT></SPAN></DIV>
<DIV><SPAN class=3D847135409-20072006><FONT face=3DArial size=3D2>On the =
development=20
machine (i86 with same Kernel version) everything works =
ok.</FONT></SPAN></DIV>
<DIV><SPAN class=3D847135409-20072006><FONT face=3DArial=20
size=3D2></FONT></SPAN>&nbsp;</DIV>
<DIV><SPAN class=3D847135409-20072006><FONT face=3DArial size=3D2>At the =
beginning I=20
thought this might be some problem with USB support on the board. But I =
have=20
been able to operate up to 7 simultaneous USB devices on the board (not=20
bluetooth) and they work ok.</FONT></SPAN></DIV>
<DIV><SPAN class=3D847135409-20072006><FONT face=3DArial=20
size=3D2></FONT></SPAN>&nbsp;</DIV>
<DIV><SPAN class=3D847135409-20072006><FONT face=3DArial size=3D2>Are =
there any known=20
issues about multiple devices and ARM? </FONT></SPAN></DIV>
<DIV><SPAN class=3D847135409-20072006><FONT face=3DArial=20
size=3D2></FONT></SPAN>&nbsp;</DIV>
<DIV><SPAN class=3D847135409-20072006><FONT face=3DArial size=3D2>Thanks =
in=20
advance,</FONT></SPAN></DIV>
<DIV><SPAN class=3D847135409-20072006><FONT face=3DArial=20
size=3D2>Francesco</FONT></SPAN></DIV>
<DIV><SPAN class=3D847135409-20072006></SPAN>&nbsp;</DIV></BODY></HTML>

------_=_NextPart_001_01C6ABE3.58AD4C3F--


--===============1442415493==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

-------------------------------------------------------------------------
Take Surveys. Earn Cash. Influence the Future of IT
Join SourceForge.net's Techsay panel and you'll get the chance to share your
opinions on IT & business topics through brief surveys -- and earn cash
http://www.techsay.com/default.php?page=join.php&p=sourceforge&CID=DEVDEV
--===============1442415493==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Bluez-users mailing list
Bluez-users@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-users

--===============1442415493==--
