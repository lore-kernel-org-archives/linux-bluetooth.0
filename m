Return-Path: <bluez-users-bounces@lists.sourceforge.net>
MIME-Version: 1.0
Date: Fri, 15 Dec 2006 12:21:26 +0100
Message-ID: <86538205C715094CB44B7EB1119B886B31D302@nts028.kuka.de>
From: "Goroll, Torsten" <Torsten.Goroll@kuka.de>
To: <bluez-users@lists.sourceforge.net>
Subject: [Bluez-users] pand connection debug
Reply-To: BlueZ users <bluez-users@lists.sourceforge.net>
List-Id: BlueZ users <bluez-users.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-users>,
	<mailto:bluez-users-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=bluez-users>
List-Post: <mailto:bluez-users@lists.sourceforge.net>
List-Help: <mailto:bluez-users-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-users>,
	<mailto:bluez-users-request@lists.sourceforge.net?subject=subscribe>
Content-Type: multipart/mixed; boundary="===============0260891281=="
Sender: bluez-users-bounces@lists.sourceforge.net
Errors-To: bluez-users-bounces@lists.sourceforge.net

This is a multi-part message in MIME format.

--===============0260891281==
content-class: urn:content-classes:message
Content-Type: multipart/alternative;
	boundary="----_=_NextPart_001_01C7203B.2904371E"

This is a multi-part message in MIME format.

------_=_NextPart_001_01C7203B.2904371E
Content-Type: text/plain;
	charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable

Hi,

i have successfully set up a pan connection between my laptop and my =
hand phone using this command:

pand -r NAP -d PANU -c xxx -n

If I try to access the connection from the phone (e.g. by browser) it =
says network connection error. Im not suprised, because there is nothing =
configured. The problem is: how to get information about the bnep =
interface. Ive read the PAN-HowTo. But it seems outdatet, because:
- their is no interface shown calling ifconfig=20
- their is no  /etc/sysconfig (at least at my distri, which is ubuntu =
6.10)
- their is no /etc/bluetooth/pan folder or dev-up script

Does someone know of some more current information or how to configure =
this connection?


Torsten


------_=_NextPart_001_01C7203B.2904371E
Content-Type: text/html;
	charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable

<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 3.2//EN">
<HTML>
<HEAD>
<META HTTP-EQUIV=3D"Content-Type" CONTENT=3D"text/html; =
charset=3Diso-8859-1">
<META NAME=3D"Generator" CONTENT=3D"MS Exchange Server version =
6.0.6603.0">
<TITLE>pand connection debug</TITLE>
</HEAD>
<BODY>
<!-- Converted from text/rtf format -->

<P><FONT SIZE=3D2 FACE=3D"Arial">Hi,</FONT>
</P>

<P><FONT SIZE=3D2 FACE=3D"Arial">i have successfully set up a pan =
connection between my laptop and my hand phone using this =
command:</FONT>
</P>

<P><FONT SIZE=3D2 FACE=3D"Arial">pand -r NAP -d PANU -c xxx -n</FONT>
</P>

<P><FONT SIZE=3D2 FACE=3D"Arial">If I try to access the connection from =
the phone (e.g. by browser) it says network connection error. Im not =
suprised, because there is nothing configured. The problem is: how to =
get information about the bnep interface. Ive read the PAN-HowTo. But it =
seems outdatet, because:</FONT></P>

<P><FONT SIZE=3D2 FACE=3D"Arial">- their is no interface shown calling =
ifconfig </FONT>

<BR><FONT SIZE=3D2 FACE=3D"Arial">- their is no&nbsp; /etc/sysconfig (at =
least at my distri, which is ubuntu 6.10)</FONT>

<BR><FONT SIZE=3D2 FACE=3D"Arial">- their is no /etc/bluetooth/pan =
folder or dev-up script</FONT>
</P>

<P><FONT SIZE=3D2 FACE=3D"Arial">Does someone know of some more current =
information or how to configure this connection?</FONT>
</P>
<BR>

<P><FONT SIZE=3D2 FACE=3D"Arial">Torsten</FONT>
</P>

</BODY>
</HTML>
------_=_NextPart_001_01C7203B.2904371E--


--===============0260891281==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

-------------------------------------------------------------------------
Take Surveys. Earn Cash. Influence the Future of IT
Join SourceForge.net's Techsay panel and you'll get the chance to share your
opinions on IT & business topics through brief surveys - and earn cash
http://www.techsay.com/default.php?page=join.php&p=sourceforge&CID=DEVDEV
--===============0260891281==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Bluez-users mailing list
Bluez-users@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-users

--===============0260891281==--
