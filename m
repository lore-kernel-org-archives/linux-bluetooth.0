Return-Path: <bluez-users-admin@lists.sourceforge.net>
Message-ID: <002901c4c1da$b4d3fec0$0300a8c0@supercomputer>
From: "D.W." <sword@gmx.de>
To: <bluez-users@lists.sourceforge.net>
MIME-Version: 1.0
Content-Type: multipart/alternative;
	boundary="----=_NextPart_000_0026_01C4C1E3.151F0D30"
Subject: [Bluez-users] Network Access Point - pairing problem
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
Date: Wed, 3 Nov 2004 20:24:12 +0100

This is a multi-part message in MIME format.

------=_NextPart_000_0026_01C4C1E3.151F0D30
Content-Type: text/plain;
	charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable

Hi Marcel,
Thank you for your reply.
I use kernel 2.4.22 on an axis devboard82. The bluez stack is not the =
latest(PAN, SDP, utils, libs are still seperate packages), because I had =
problems porting later versions to the devboard.
But except the pairing problem at first contact it works perfectly.
Except the PIN (it's a static one at server side) there is no further =
authentification necessary.
Security mode 2 or 3? What do you mean? Can I check it?
When I try to connect to the server at first contact, I have to enter =
the PIN(client side) and after entering the right pin I get the message =
:"Authentification failed."=20
Regards Daniel


=20
> Hi Daniel,
>=20
> > I want to use bluez for a standalone network access point. All works
> > fine(pand or dund), the thing is that the pairing doesn't work at
> > first contact (client is a windows-pc).=20
> >=20
> > So I have to establish a rfcomm-connection manually(from the server
> > side rfcomm connect 0 btad) first. This pairing works,  I disconnect
> > and then I am able to connect the client to the NAT.
> >=20
> > Does anybody know what's wrong and what I can do to make the pairing
> > work without this manually initiated rfcomm-connnection ?
>=20
> are we talking about security mode 2 or security mode 3? What kernel =
do
> you use?
>=20
> Regards
>=20
> Marcel
>=20
>=20

------=_NextPart_000_0026_01C4C1E3.151F0D30
Content-Type: text/html;
	charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable

<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.0 Transitional//EN">
<HTML><HEAD>
<META http-equiv=3DContent-Type content=3D"text/html; =
charset=3Diso-8859-1">
<META content=3D"MSHTML 6.00.2600.0" name=3DGENERATOR>
<STYLE></STYLE>
</HEAD>
<BODY bgColor=3D#ffffff>
<DIV><FONT face=3DArial size=3D2>Hi Marcel,</FONT></DIV>
<DIV><FONT face=3DArial size=3D2>Thank you for your reply.</FONT></DIV>
<DIV><FONT face=3DArial size=3D2>I use kernel 2.4.22 on an axis =
devboard82.&nbsp;The=20
bluez stack&nbsp;is not the latest(PAN, SDP, utils, libs&nbsp;are still =
seperate=20
packages), because I had problems porting later versions to the=20
devboard.</FONT></DIV>
<DIV><FONT face=3DArial size=3D2>But except the pairing problem at first =
contact it=20
works perfectly.</FONT></DIV>
<DIV><FONT face=3DArial size=3D2>Except the PIN (it's a static one at =
server side)=20
there&nbsp;is no further authentification necessary.</FONT></DIV>
<DIV><FONT face=3DArial size=3D2>Security mode 2 or 3? What do you mean? =
Can I check=20
it?</FONT></DIV>
<DIV><FONT face=3DArial size=3D2>When I try to connect to the server at =
first=20
contact, I have to enter the PIN(client side)&nbsp;and after entering =
the right=20
pin I&nbsp;get the message :"Authentification failed." </FONT></DIV>
<DIV><FONT face=3DArial size=3D2>Regards Daniel</FONT></DIV>
<DIV><FONT face=3DArial size=3D2></FONT>&nbsp;</DIV>
<DIV><FONT face=3DArial size=3D2></FONT>&nbsp;</DIV>
<DIV>&nbsp;</DIV>
<DIV><FONT face=3DArial size=3D2><FONT face=3D"Times New Roman" =
size=3D3>&gt; Hi=20
Daniel,<BR>&gt; <BR>&gt; &gt; I want to use bluez for a standalone =
network=20
access point. All works<BR>&gt; &gt; fine(pand or dund), the thing is =
that the=20
pairing doesn't work at<BR>&gt; &gt; first contact (client is a =
windows-pc).=20
<BR>&gt; &gt; <BR>&gt; &gt; So I have to establish a rfcomm-connection=20
manually(from the server<BR>&gt; &gt; side rfcomm connect 0 btad) first. =
This=20
pairing works,&nbsp; I disconnect<BR>&gt; &gt; and then I am able to =
connect the=20
client to the NAT.<BR>&gt; &gt; <BR>&gt; &gt; Does anybody know what's =
wrong and=20
what I can do to make the pairing<BR>&gt; &gt; work without this =
manually=20
initiated rfcomm-connnection ?<BR>&gt; <BR>&gt; are we talking about =
security=20
mode 2 or security mode 3? What kernel do<BR>&gt; you use?<BR>&gt; =
<BR>&gt;=20
Regards<BR>&gt; <BR>&gt; Marcel<BR>&gt; <BR>&gt;=20
</FONT></FONT></DIV></BODY></HTML>

------=_NextPart_000_0026_01C4C1E3.151F0D30--



-------------------------------------------------------
This SF.Net email is sponsored by:
Sybase ASE Linux Express Edition - download now for FREE
LinuxWorld Reader's Choice Award Winner for best database on Linux.
http://ads.osdn.com/?ad_id=5588&alloc_id=12065&op=click
_______________________________________________
Bluez-users mailing list
Bluez-users@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-users
