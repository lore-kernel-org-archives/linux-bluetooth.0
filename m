Return-Path: <bluez-devel-admin@lists.sourceforge.net>
Message-ID: <00c901c4df6a$f8c11f70$6401000a@zool>
From: "Steffen Larsen" <zool@zool.dk>
To: "BlueZ Mailing List" <bluez-devel@lists.sourceforge.net>
MIME-Version: 1.0
Content-Type: multipart/alternative;
	boundary="----=_NextPart_000_00C6_01C4DF73.5A3A9BC0"
Subject: [Bluez-devel] piconet..
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
Date: Sat, 11 Dec 2004 11:20:00 +0100

This is a multi-part message in MIME format.

------=_NextPart_000_00C6_01C4DF73.5A3A9BC0
Content-Type: text/plain;
	charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable

Hi again!,

I am trying to form a piconet, consisting of one server and two clients. =
I have snaped the most of the code from l2test.c and also made an =
advertising service and all. My problem is just that one one client can =
connect and the other one fails (host is down, i belive) . I have =
implemented the server using fork(), so that the parent process is still =
listening for new connections and closing my sockets correct (as what I =
can see..).
I have browsed this newsgroup for answers, and can see something about =
setting the master/slave switch should help. I have also tried this, but =
it dosn't help. Anyone that have a clue about, what could be wrong??=20

PS. I belive that the PSM in the L2CAP layer can serve more than one =
client or am I totally wrong? otherwise I should update the PSM =
everytime a new client connect..

I anyone want the source code, I can send it. But I haven't attached it =
in this document, due to the size of it.. :-)


-Thanks in advance!

/Steffen Larsen
------=_NextPart_000_00C6_01C4DF73.5A3A9BC0
Content-Type: text/html;
	charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable

<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.0 Transitional//EN">
<HTML><HEAD>
<META http-equiv=3DContent-Type content=3D"text/html; =
charset=3Diso-8859-1">
<META content=3D"MSHTML 6.00.2800.1106" name=3DGENERATOR>
<STYLE></STYLE>
</HEAD>
<BODY bgColor=3D#ffffff>
<DIV><FONT face=3DArial size=3D2>Hi again!,</FONT></DIV>
<DIV><FONT face=3DArial size=3D2></FONT>&nbsp;</DIV>
<DIV><FONT face=3DArial size=3D2>I am trying to form a piconet, =
consisting of one=20
server and two clients. I have snaped the most of the code from l2test.c =
and=20
also made an advertising service and all. My problem is just that one =
one client=20
can connect and the other one fails (host is down, i belive) . I have=20
implemented the server using fork(), so that the parent process is still =

listening for new connections and closing my sockets correct (as what I =
can=20
see..).</FONT></DIV>
<DIV><FONT face=3DArial size=3D2>I have browsed this newsgroup for =
answers, and can=20
see something about setting the master/slave switch should help. I have =
also=20
tried this, but it dosn't help. Anyone that have a clue about, what =
could be=20
wrong?? </FONT></DIV>
<DIV><FONT face=3DArial size=3D2></FONT>&nbsp;</DIV>
<DIV><FONT face=3DArial size=3D2>PS. I belive that the PSM in the L2CAP =
layer can=20
serve more than one client or am I totally wrong? otherwise I should =
update the=20
PSM everytime a new client connect..</FONT></DIV>
<DIV><FONT face=3DArial size=3D2></FONT>&nbsp;</DIV>
<DIV><FONT face=3DArial size=3D2>I anyone want the source code, I can =
send it. But I=20
haven't attached it in this document, due to the size of it.. =
:-)</FONT></DIV>
<DIV><FONT face=3DArial size=3D2></FONT>&nbsp;</DIV>
<DIV>&nbsp;</DIV>
<DIV><FONT face=3DArial size=3D2>-Thanks in advance!</FONT></DIV>
<DIV><FONT face=3DArial size=3D2></FONT>&nbsp;</DIV>
<DIV><FONT face=3DArial size=3D2>/Steffen =
Larsen</FONT></DIV></BODY></HTML>

------=_NextPart_000_00C6_01C4DF73.5A3A9BC0--



-------------------------------------------------------
SF email is sponsored by - The IT Product Guide
Read honest & candid reviews on hundreds of IT Products from real users.
Discover which products truly live up to the hype. Start reading now. 
http://productguide.itmanagersjournal.com/
_______________________________________________
Bluez-devel mailing list
Bluez-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-devel
