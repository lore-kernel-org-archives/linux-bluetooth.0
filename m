Return-Path: <bluez-devel-admin@lists.sourceforge.net>
MIME-Version: 1.0
Content-Type: multipart/alternative;
	boundary="----_=_NextPart_001_01C53A05.E4133F74"
Message-ID: <11D888B5FA88D9409851B71E8D3206D1016624@doar.commil.com>
From: "Tzahi Efrati" <tzah@commil.com>
To: <bluez-devel@lists.sourceforge.net>
Subject: [Bluez-devel] rejecting or accepting connection request
Sender: bluez-devel-admin@lists.sourceforge.net
Errors-To: bluez-devel-admin@lists.sourceforge.net
Reply-To: bluez-devel@lists.sourceforge.net
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-devel>,
	<mailto:bluez-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Id: BlueZ development <bluez-devel.lists.sourceforge.net>
List-Post: <mailto:bluez-devel@lists.sourceforge.net>
List-Help: <mailto:bluez-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-devel>,
	<mailto:bluez-devel-request@lists.sourceforge.net?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=bluez-devel>
Date: Tue, 5 Apr 2005 19:35:42 +0200

This is a multi-part message in MIME format.

------_=_NextPart_001_01C53A05.E4133F74
Content-Type: text/plain;
	charset="us-ascii"
Content-Transfer-Encoding: quoted-printable

Hi,
=20
I'm trying to build an application which accepts or rejects incoming
connections according to the requesting device's bd_Addr. My application
compares the requesting device's bd_Addr to a list and if  the address
is in the list, the application accepts the request. Otherwise, it
rejects it.
I have set the event filter to EVT_CONN_REQEUST (and  EVT_CONN_COMPLETE
and EVT_DISCONN_COMPLETE) and I'm using select() followed by read() to
get the events. My problem is that for every EVT_CONN_REQ I receive, the
hci interface automatically accepts it. I've tried to set the link_mode
with different values using the hciconfigure but it didn't help.
=20
It seems that the only way I can make this bd_addr filtering is by
disconnecting the connections with un-listed bd_addreses. Am I right?
any ideas?
=20
regards,
=20
Tzahi Efrati
=20
=20

------_=_NextPart_001_01C53A05.E4133F74
Content-Type: text/html;
	charset="us-ascii"
Content-Transfer-Encoding: quoted-printable

<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.0 Transitional//EN">
<HTML><HEAD>
<META http-equiv=3DContent-Type content=3D"text/html; =
charset=3Dus-ascii">
<META content=3D"MSHTML 6.00.2600.0" name=3DGENERATOR></HEAD>
<BODY>
<DIV><SPAN class=3D032110717-05042005><FONT face=3DArial=20
size=3D2>Hi,</FONT></SPAN></DIV>
<DIV><SPAN class=3D032110717-05042005><FONT face=3DArial=20
size=3D2></FONT></SPAN>&nbsp;</DIV>
<DIV><SPAN class=3D032110717-05042005><FONT face=3DArial size=3D2>I'm =
trying to build=20
an application which accepts or rejects incoming connections according =
to the=20
requesting device's bd_Addr. My application compares the requesting =
device's=20
bd_Addr to a list and if&nbsp; the address is in the list, the =
application=20
accepts the request. Otherwise, it rejects it.</FONT></SPAN></DIV>
<DIV><SPAN class=3D032110717-05042005><FONT face=3DArial size=3D2>I have =
set the event=20
filter to EVT_CONN_REQEUST&nbsp;(and &nbsp;EVT_CONN_COMPLETE and=20
EVT_DISCONN_COMPLETE) and I'm using select() followed by read() to get =
the=20
events. My problem is that for every EVT_CONN_REQ I receive, the hci =
interface=20
automatically&nbsp;accepts it. I've tried to set the link_mode with =
different=20
values using the hciconfigure but it didn't help.</FONT></SPAN></DIV>
<DIV><SPAN class=3D032110717-05042005><FONT face=3DArial=20
size=3D2></FONT></SPAN>&nbsp;</DIV>
<DIV><SPAN class=3D032110717-05042005><FONT face=3DArial size=3D2>It =
seems that the=20
only way I can make this bd_addr filtering is by disconnecting the =
connections=20
with un-listed bd_addreses. Am I right? any ideas?</FONT></SPAN></DIV>
<DIV><SPAN class=3D032110717-05042005><FONT face=3DArial=20
size=3D2></FONT></SPAN>&nbsp;</DIV>
<DIV><SPAN class=3D032110717-05042005><FONT face=3DArial=20
size=3D2>regards,</FONT></SPAN></DIV>
<DIV><SPAN class=3D032110717-05042005><FONT face=3DArial=20
size=3D2></FONT></SPAN>&nbsp;</DIV>
<DIV><SPAN class=3D032110717-05042005><FONT face=3DArial size=3D2>Tzahi=20
Efrati</FONT></SPAN></DIV>
<DIV dir=3Dltr align=3Dleft><FONT face=3D"Times New Roman" =
color=3D#0000ff=20
size=3D6><STRONG></STRONG></FONT>&nbsp;</DIV>
<DIV>&nbsp;</DIV></BODY></HTML>

------_=_NextPart_001_01C53A05.E4133F74--


-------------------------------------------------------
SF email is sponsored by - The IT Product Guide
Read honest & candid reviews on hundreds of IT Products from real users.
Discover which products truly live up to the hype. Start reading now.
http://ads.osdn.com/?ad_id=6595&alloc_id=14396&op=click
_______________________________________________
Bluez-devel mailing list
Bluez-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-devel
