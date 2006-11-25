Return-Path: <bluez-devel-bounces@lists.sourceforge.net>
Message-ID: <002901c710a8$0eab3580$0100a8c0@kayleigh>
From: "Olivier Le Pogam" <olepogam@free.fr>
To: <bluez-devel@lists.sourceforge.net>
Date: Sat, 25 Nov 2006 16:40:34 +0100
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="=======AVGMAIL-456863F74937======="
Subject: [Bluez-devel] Master / Slave question
Reply-To: Olivier Le Pogam <olepogam@free.fr>,
        BlueZ development <bluez-devel@lists.sourceforge.net>
List-Id: BlueZ development <bluez-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-devel>,
	<mailto:bluez-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=bluez-devel>
List-Post: <mailto:bluez-devel@lists.sourceforge.net>
List-Help: <mailto:bluez-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-devel>,
	<mailto:bluez-devel-request@lists.sourceforge.net?subject=subscribe>
Sender: bluez-devel-bounces@lists.sourceforge.net
Errors-To: bluez-devel-bounces@lists.sourceforge.net

--=======AVGMAIL-456863F74937=======
Content-Type: multipart/alternative;
	boundary="----=_NextPart_000_0026_01C710B0.6DCF2910"

------=_NextPart_000_0026_01C710B0.6DCF2910
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: quoted-printable

Hi,

I am trying to make 2 mobile phones connected concurrently
to a RFCOMM server. Please note that they don't support
role switching, so as they initiate the communication, they
are always "master".

My RFCOMM server is a forking one so it can virtually
deal with concurrent clients like on TCP.

I have put lm=3Daccept in hcid.conf

If I open a RFCOMM server on channel 14 and try to make
the 2 mobile connect to channel 14, the first is ok, the
second can't connect. I suppose that's normal, because
channel 14 "slave" is busy linux-side with the first
connection and a "slave" can deal with one connection only.

Then I've launched a second server on channel 15 (server
on channel 14 running concurrently), and i try to make
the first mobile connect to channel 14 and the second
to channel 15 : it's the same, only the first can connect.

I think I have a misunderstanding here, as i thought the
"master/slave" was per channel. Does it mean the "slave" status=20
is for the whole adaptor, and once a "slave" connection is
open on one channel, it can't receive other connections at all ?

Thanks a lot for your help,
Oli
------=_NextPart_000_0026_01C710B0.6DCF2910
Content-Type: text/html; charset=iso-8859-1
Content-Transfer-Encoding: quoted-printable

<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.0 Transitional//EN">
<HTML><HEAD>
<META http-equiv=3DContent-Type content=3D"text/html; =
charset=3Diso-8859-1">
<META content=3D"MSHTML 6.00.2900.2873" name=3DGENERATOR>
<STYLE></STYLE>
</HEAD>
<BODY bgColor=3D#ffffff>
<DIV><FONT face=3DArial size=3D2>Hi,</FONT></DIV>
<DIV><FONT face=3DArial size=3D2></FONT>&nbsp;</DIV>
<DIV><FONT face=3DArial size=3D2>I am trying to make 2 mobile =
phones&nbsp;connected=20
concurrently</FONT></DIV>
<DIV><FONT face=3DArial size=3D2>to a RFCOMM server. Please note that =
they don't=20
support</FONT></DIV>
<DIV><FONT face=3DArial size=3D2>role switching, so as they initiate the =

communication, they</FONT></DIV>
<DIV><FONT face=3DArial size=3D2>are always "master".</FONT></DIV>
<DIV><FONT face=3DArial size=3D2></FONT>&nbsp;</DIV>
<DIV><FONT face=3DArial size=3D2>My RFCOMM server is a forking one so it =
can=20
virtually</FONT></DIV>
<DIV><FONT face=3DArial size=3D2>deal with concurrent clients like on=20
TCP.</FONT></DIV>
<DIV><FONT face=3DArial size=3D2></FONT>&nbsp;</DIV>
<DIV><FONT face=3DArial size=3D2>I have put lm=3Daccept in =
hcid.conf</FONT></DIV>
<DIV><FONT face=3DArial size=3D2></FONT>&nbsp;</DIV>
<DIV><FONT face=3DArial size=3D2>If I open a RFCOMM server on channel 14 =
and try to=20
make</FONT></DIV>
<DIV><FONT face=3DArial size=3D2>the 2 mobile connect to channel 14, the =
first is=20
ok, the</FONT></DIV>
<DIV><FONT face=3DArial size=3D2>second can't connect. I suppose that's =
normal,=20
because</FONT></DIV>
<DIV><FONT face=3DArial size=3D2>channel 14 "slave" is busy linux-side =
with the=20
first</FONT></DIV>
<DIV><FONT face=3DArial size=3D2>connection and a "slave" can deal with =
one=20
connection only.</FONT></DIV>
<DIV><FONT face=3DArial size=3D2></FONT>&nbsp;</DIV>
<DIV><FONT face=3DArial size=3D2>Then I've launched a second server on =
channel 15=20
(server</FONT></DIV>
<DIV><FONT face=3DArial size=3D2>on channel 14 running concurrently), =
and i try to=20
make</FONT></DIV>
<DIV><FONT face=3DArial size=3D2>the first mobile connect to channel 14 =
and the=20
second</FONT></DIV>
<DIV><FONT face=3DArial size=3D2>to channel 15 : it's the same, only the =
first can=20
connect.</FONT></DIV>
<DIV><FONT face=3DArial size=3D2></FONT>&nbsp;</DIV>
<DIV><FONT face=3DArial size=3D2>I think I have a misunderstanding here, =
as i=20
thought the</FONT></DIV>
<DIV><FONT face=3DArial size=3D2>"master/slave" was per channel. Does it =
mean the=20
"slave" status </FONT></DIV>
<DIV><FONT face=3DArial size=3D2>is for the whole adaptor, and once a =
"slave"=20
connection is</FONT></DIV>
<DIV><FONT face=3DArial size=3D2>open on one channel, it can't receive =
other=20
connections at all ?</FONT></DIV>
<DIV><FONT face=3DArial size=3D2></FONT>&nbsp;</DIV>
<DIV><FONT face=3DArial size=3D2>Thanks a lot for your =
help,</FONT></DIV>
<DIV><FONT face=3DArial size=3D2>Oli</FONT></DIV></BODY></HTML>

------=_NextPart_000_0026_01C710B0.6DCF2910--

--=======AVGMAIL-456863F74937=======
Content-Type: text/plain; x-avg=cert; charset=us-ascii
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline
Content-Description: "AVG certification"

No virus found in this outgoing message.
Checked by AVG Free Edition.
Version: 7.1.409 / Virus Database: 268.14.15/550 - Release Date: 24/11/2006
=


--=======AVGMAIL-456863F74937=======
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

-------------------------------------------------------------------------
Take Surveys. Earn Cash. Influence the Future of IT
Join SourceForge.net's Techsay panel and you'll get the chance to share your
opinions on IT & business topics through brief surveys - and earn cash
http://www.techsay.com/default.php?page=join.php&p=sourceforge&CID=DEVDEV
--=======AVGMAIL-456863F74937=======
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Bluez-devel mailing list
Bluez-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-devel

--=======AVGMAIL-456863F74937=======--
