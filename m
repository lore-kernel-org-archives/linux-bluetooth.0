Return-Path: <bluez-devel-bounces@lists.sourceforge.net>
Message-ID: <002701c6fa09$92116120$0100a8c0@kayleigh>
From: "Olivier Le Pogam" <olepogam@free.fr>
To: <bluez-devel@lists.sourceforge.net>
Date: Fri, 27 Oct 2006 22:50:35 +0200
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="=======AVGMAIL-4542712308C1======="
Subject: [Bluez-devel] Concurrency / Multi processing questions
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

--=======AVGMAIL-4542712308C1=======
Content-Type: multipart/alternative;
	boundary="----=_NextPart_000_0024_01C6FA1A.50D57D20"

------=_NextPart_000_0024_01C6FA1A.50D57D20
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: quoted-printable

Hi,

I think having understood the main concepts of RFCOMM
connections (DLC, DLCI ...) however I really wonder about
multi processing (globally and in BlueZ specifically)

- If I want to write a service (published in the SDP) for example
on channel 9, can I write a forking server (forking at each accept
so it can accept a new incoming connection from another
remote device while the first connection is being managed ?)
We assume we have only one bdaddr (bluetooth adaptor) in local

I suppose it could lead to 2 concurrent connection tuples like these =
ones :
( (local_bdaddr, channel 9) - (remote1_addr, channel9) )
( (local_bdaddr, channel 9) - (remote2_addr, channel9) )

Is it possible ? Without any conflicts ? I know on the local service
we would have the same DLCI for both sockets. In TCP it would be
possible with REUSEADDR, would it be the same here ?

- Now taking a reverse problem, let's assume I have a client
application that will "push" content to mobile phones, on channel 9.
Can I run concurrent pushers on my computer ?
Concurrent tuples would look like the same as formerly, except
that the server / client roles are reversed here.

Thanks a lot for helping me, believe I have searched a lot before
asking !

Oli
------=_NextPart_000_0024_01C6FA1A.50D57D20
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
<DIV><FONT face=3DArial size=3D2>I think having understood the main =
concepts of=20
RFCOMM</FONT></DIV>
<DIV><FONT face=3DArial size=3D2>connections (DLC, DLCI ...) however I =
really wonder=20
about</FONT></DIV>
<DIV><FONT face=3DArial size=3D2>multi processing (globally and in BlueZ =

specifically)</FONT></DIV>
<DIV><FONT face=3DArial size=3D2></FONT>&nbsp;</DIV>
<DIV><FONT face=3DArial size=3D2>- If I want to write&nbsp;a service =
(published in=20
the SDP) for example</FONT></DIV>
<DIV><FONT face=3DArial size=3D2>on channel 9, can I write a forking =
server (forking=20
at each accept</FONT></DIV>
<DIV><FONT face=3DArial size=3D2>so it can accept a new incoming =
connection from=20
another</FONT></DIV>
<DIV><FONT face=3DArial size=3D2>remote device while the first =
connection is being=20
managed ?)</FONT></DIV>
<DIV><FONT face=3DArial size=3D2>We assume we have only one bdaddr =
(bluetooth=20
adaptor) in local</FONT></DIV>
<DIV><FONT face=3DArial size=3D2></FONT>&nbsp;</DIV>
<DIV><FONT face=3DArial size=3D2>I suppose it could lead to 2 concurrent =
connection=20
tuples like these ones :</FONT></DIV>
<DIV><FONT face=3DArial size=3D2>( (local_bdaddr, channel 9) - =
(remote1_addr,=20
channel9) )</FONT></DIV>
<DIV>
<DIV><FONT face=3DArial size=3D2>( (local_bdaddr, channel 9) - =
(remote2_addr,=20
channel9) )</FONT></DIV>
<DIV><FONT face=3DArial size=3D2></FONT>&nbsp;</DIV>
<DIV><FONT face=3DArial size=3D2>Is it possible ? Without any conflicts =
? I know on=20
the local service</FONT></DIV>
<DIV><FONT face=3DArial size=3D2>we would have the same DLCI for both =
sockets. In=20
TCP it would be</FONT></DIV>
<DIV><FONT face=3DArial size=3D2>possible with REUSEADDR, would it be =
the same here=20
?</FONT></DIV>
<DIV><FONT face=3DArial size=3D2></FONT>&nbsp;</DIV>
<DIV><FONT face=3DArial size=3D2>- Now taking a reverse problem, let's =
assume I have=20
a client</FONT></DIV>
<DIV><FONT face=3DArial size=3D2>application that will "push" content to =
mobile=20
phones, on channel 9.</FONT></DIV>
<DIV><FONT face=3DArial size=3D2>Can I run concurrent pushers on my =
computer=20
?</FONT></DIV>
<DIV><FONT face=3DArial size=3D2>Concurrent tuples would look like the =
same as=20
formerly, except</FONT></DIV>
<DIV><FONT face=3DArial size=3D2>that the server / client roles are =
reversed=20
here.</FONT></DIV>
<DIV><FONT face=3DArial size=3D2></FONT>&nbsp;</DIV>
<DIV><FONT face=3DArial size=3D2>Thanks a lot for helping me, believe I =
have=20
searched a lot before</FONT></DIV>
<DIV><FONT face=3DArial size=3D2>asking !</FONT></DIV>
<DIV><FONT face=3DArial size=3D2></FONT>&nbsp;</DIV>
<DIV><FONT face=3DArial size=3D2>Oli</FONT></DIV></DIV></BODY></HTML>

------=_NextPart_000_0024_01C6FA1A.50D57D20--

--=======AVGMAIL-4542712308C1=======
Content-Type: text/plain; x-avg=cert; charset=us-ascii
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline
Content-Description: "AVG certification"

No virus found in this outgoing message.
Checked by AVG Free Edition.
Version: 7.1.408 / Virus Database: 268.13.11/497 - Release Date: 25/10/2006
=


--=======AVGMAIL-4542712308C1=======
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

-------------------------------------------------------------------------
Using Tomcat but need to do more? Need to support web services, security?
Get stuff done quickly with pre-integrated technology to make your job easier
Download IBM WebSphere Application Server v.1.0.1 based on Apache Geronimo
http://sel.as-us.falkag.net/sel?cmd=lnk&kid=120709&bid=263057&dat=121642
--=======AVGMAIL-4542712308C1=======
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Bluez-devel mailing list
Bluez-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-devel

--=======AVGMAIL-4542712308C1=======--
