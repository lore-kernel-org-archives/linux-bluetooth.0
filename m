Return-Path: <bluez-users-admin@lists.sourceforge.net>
Message-ID: <007e01c4384a$64f7e700$80c8fea9@Perigee.Perigeellc.com>
From: "Rob Taft" <rtaft@sensis.com>
To: "Mykel" <Mykel@mWare.ca>
Cc: <bluez-users@lists.sourceforge.net>
References: <004501c4383b$36b36950$80c8fea9@Perigee.Perigeellc.com> <40A25476.7080609@mWare.ca>
Subject: Re: [Bluez-users] DHCPD and Bluetooth
MIME-Version: 1.0
Content-Type: multipart/alternative;
	boundary="----=_NextPart_000_007B_01C43828.DA5F4320"
Sender: bluez-users-admin@lists.sourceforge.net
Errors-To: bluez-users-admin@lists.sourceforge.net
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-users>,
	<mailto:bluez-users-request@lists.sourceforge.net?subject=unsubscribe>
List-Id: <bluez-users.lists.sourceforge.net>
List-Post: <mailto:bluez-users@lists.sourceforge.net>
List-Help: <mailto:bluez-users-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-users>,
	<mailto:bluez-users-request@lists.sourceforge.net?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=bluez-users>
Date: Wed, 12 May 2004 13:55:58 -0400

This is a multi-part message in MIME format.

------=_NextPart_000_007B_01C43828.DA5F4320
Content-Type: text/plain;
	charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable

Changing my OS isn't exactly an option at this point.
  ----- Original Message -----=20
  From: Mykel=20
  To: Rob Taft=20
  Cc: bluez-users@lists.sourceforge.net=20
  Sent: Wednesday, May 12, 2004 12:44 PM
  Subject: Re: [Bluez-users] DHCPD and Bluetooth


  I know Slackware has hotplug scripts. You might want to look there.=20

  Myke


  Rob Taft wrote:=20
    I currently have a setup where I have a Bluetooth adapter on a Linux =
box, and one on Windows.  Everything is configured properly.  I connect =
from the Windows Bluetooth adapter to the Linux one via "Local Area =
Connection 2" in XP over TCP/IP.  I manually type "ifconfig bnep0 =
192.168.3.1" to assign the adapter an IP, then I have to restart DHCPD =
to acquire an IP address over Bluetooth.  This all works great.

    My first question is:  Is there a way to recognize when a connection =
is made, so I can create a script or some code to automatically set =
bnep0 to 192.168.3.1 and restart the dhcp server?

    I only have 2 Bluetooth adapters.  What if I used a 3rd from windows =
to connect to Linux at the same time another one is connected.  Will it =
allow multiple connections?  Will it show up as bnep1 or still use =
bnep0?



    Rob Taft, Software Engineer
    Perigee, A Division of Sensis Corporation
    rtaft@sensis.com
    315-453-7842, Ext. 25


------=_NextPart_000_007B_01C43828.DA5F4320
Content-Type: text/html;
	charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable

<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.0 Transitional//EN">
<HTML><HEAD><TITLE></TITLE>
<META http-equiv=3DContent-Type =
content=3Dtext/html;charset=3DISO-8859-1>
<META content=3D"MSHTML 6.00.2800.1400" name=3DGENERATOR></HEAD>
<BODY text=3D#000000 bgColor=3D#ffffff>
<DIV><FONT face=3DArial size=3D2>Changing my OS isn't exactly an option =
at this=20
point.</FONT></DIV>
<BLOCKQUOTE=20
style=3D"PADDING-RIGHT: 0px; PADDING-LEFT: 5px; MARGIN-LEFT: 5px; =
BORDER-LEFT: #000000 2px solid; MARGIN-RIGHT: 0px">
  <DIV style=3D"FONT: 10pt arial">----- Original Message ----- </DIV>
  <DIV=20
  style=3D"BACKGROUND: #e4e4e4; FONT: 10pt arial; font-color: =
black"><B>From:</B>=20
  <A title=3DMykel@mWare.ca href=3D"mailto:Mykel@mWare.ca">Mykel</A> =
</DIV>
  <DIV style=3D"FONT: 10pt arial"><B>To:</B> <A title=3Drtaft@sensis.com =

  href=3D"mailto:rtaft@sensis.com">Rob Taft</A> </DIV>
  <DIV style=3D"FONT: 10pt arial"><B>Cc:</B> <A=20
  title=3Dbluez-users@lists.sourceforge.net=20
  =
href=3D"mailto:bluez-users@lists.sourceforge.net">bluez-users@lists.sourc=
eforge.net</A>=20
  </DIV>
  <DIV style=3D"FONT: 10pt arial"><B>Sent:</B> Wednesday, May 12, 2004 =
12:44=20
  PM</DIV>
  <DIV style=3D"FONT: 10pt arial"><B>Subject:</B> Re: [Bluez-users] =
DHCPD and=20
  Bluetooth</DIV>
  <DIV><BR></DIV>I know Slackware has hotplug scripts. You might want to =
look=20
  there. <BR><BR>Myke<BR><BR><BR>Rob Taft wrote:=20
  <BLOCKQUOTE =
cite=3Dmid004501c4383b$36b36950$80c8fea9@Perigee.Perigeellc.com=20
  type=3D"cite">
    <META content=3D"MSHTML 6.00.2800.1400" name=3DGENERATOR>
    <STYLE></STYLE>

    <DIV><FONT face=3DArial size=3D2>I currently have a setup where I =
have a=20
    Bluetooth adapter on a Linux box, and one on Windows.&nbsp; =
Everything is=20
    configured properly.&nbsp; I connect from the Windows Bluetooth =
adapter to=20
    the Linux one via "Local Area Connection 2" in XP over TCP/IP.&nbsp; =
I=20
    manually type "ifconfig bnep0 192.168.3.1" to assign the adapter an =
IP, then=20
    I have to restart DHCPD to acquire an IP address over =
Bluetooth.&nbsp; This=20
    all works great.</FONT></DIV>
    <DIV>&nbsp;</DIV>
    <DIV><FONT face=3DArial size=3D2>My first question is:&nbsp; Is =
there a way to=20
    recognize when a connection is made, so I can create a script or =
some code=20
    to automatically set bnep0 to 192.168.3.1 and restart the dhcp=20
    server?</FONT></DIV>
    <DIV>&nbsp;</DIV>
    <DIV><FONT face=3DArial size=3D2>I only have 2 Bluetooth =
adapters.&nbsp; What if=20
    I used a 3rd from windows to connect to Linux at the same time =
another one=20
    is connected.&nbsp; Will it allow multiple connections?&nbsp; Will =
it show=20
    up as bnep1 or still use bnep0?</FONT></DIV>
    <DIV>&nbsp;</DIV>
    <DIV>&nbsp;</DIV>
    <DIV>&nbsp;</DIV>
    <DIV><FONT face=3DArial size=3D2>Rob Taft, Software =
Engineer<BR>Perigee, A=20
    Division of Sensis Corporation<BR><A=20
    =
href=3D"mailto:rtaft@sensis.com">rtaft@sensis.com</A><BR>315-453-7842, =
Ext.=20
    25</FONT></DIV></BLOCKQUOTE><BR></BLOCKQUOTE></BODY></HTML>

------=_NextPart_000_007B_01C43828.DA5F4320--



-------------------------------------------------------
This SF.Net email is sponsored by Sleepycat Software
Learn developer strategies Cisco, Motorola, Ericsson & Lucent use to deliver
higher performing products faster, at low TCO.
http://www.sleepycat.com/telcomwpreg.php?From=osdnemail3
_______________________________________________
Bluez-users mailing list
Bluez-users@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-users
