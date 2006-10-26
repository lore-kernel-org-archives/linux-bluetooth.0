Return-Path: <bluez-users-bounces@lists.sourceforge.net>
From: Sumeet VERMA <sumeet.verma@st.com>
To: "'BlueZ users'" <bluez-users@lists.sourceforge.net>
Date: Thu, 26 Oct 2006 12:30:20 +0530
Message-ID: <007a01c6f8cc$66ffba10$8935c70a@dlh.st.com>
MIME-Version: 1.0
In-Reply-To: <1161845689.8837.8.camel@amarnath-desktop>
Subject: Re: [Bluez-users] Problem while compiling bluez-utils 3.7
Reply-To: BlueZ users <bluez-users@lists.sourceforge.net>
List-Id: BlueZ users <bluez-users.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-users>,
	<mailto:bluez-users-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=bluez-users>
List-Post: <mailto:bluez-users@lists.sourceforge.net>
List-Help: <mailto:bluez-users-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-users>,
	<mailto:bluez-users-request@lists.sourceforge.net?subject=subscribe>
Content-Type: multipart/mixed; boundary="===============1021564600=="
Sender: bluez-users-bounces@lists.sourceforge.net
Errors-To: bluez-users-bounces@lists.sourceforge.net

This is a multi-part message in MIME format.

--===============1021564600==
Content-Type: multipart/alternative;
	boundary="----=_NextPart_000_007B_01C6F8FA.80B7F610"

This is a multi-part message in MIME format.

------=_NextPart_000_007B_01C6F8FA.80B7F610
Content-Type: text/plain;
	charset="utf-8"
Content-Transfer-Encoding: quoted-printable

export the path of pkgconfig in the variable PKG_CONFIG_PATH e.g.
# export PKG_CONFIG_PATH=3D/usr/local/lib/pkgconfig/
=20
Try to configure again. It will work.
=20
Regards
=20

Sumeet Verma


=20

  _____ =20

From: bluez-users-bounces@lists.sourceforge.net =
[mailto:bluez-users-bounces@lists.sourceforge.net] On Behalf Of Amarnath
Sent: Thursday, October 26, 2006 12:25 PM
To: bluez-users@lists.sourceforge.net
Subject: [Bluez-users] Problem while compiling bluez-utils 3.7


hi,

I am getting problem when i try to compile Bluez-Utils3.7 :

$./configure --prefix=3D/usr --mandir=3D/usr/share/man =
--sysconfdir=3D/etc --localstatedir=3D/var --libexecdir=3D/lib

the error was :
checking for DBUS... configure: error: dbus > 0.35 is required

but Dbus 0.6 is loaded on my system(ubuntu) . Can anybody have solution =
, how should i solve the problem. Any comments are appreciated.=20

thanx in advance
Amarnath.=20


This message contains confidential information and is intended only =20

for the individual named. If you are not the named addressee you =20

should not disseminate, distribute or copy this e-mail. Please =20

notify the sender immediately by e-mail if you have received this =20

e-mail by mistake and delete this e-mail from your system. E-mail =20

transmission cannot be guaranteed to be secured or error-free as =20

information could be intercepted, corrupted, lost, destroyed, arrive =20

late or incomplete, or contain viruses. The sender therefore does =20

not accept liability for any errors or omissions in the contents =20

of this message, which arise as a result of e-mail transmission.=20

=20

For further query please contact info@fortuna.com

------=_NextPart_000_007B_01C6F8FA.80B7F610
Content-Type: text/html;
	charset="utf-8"
Content-Transfer-Encoding: quoted-printable

=EF=BB=BF<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.0 Transitional//EN">
<HTML><HEAD>
<META http-equiv=3DContent-Type content=3D"text/html; CHARSET=3DUTF-8">
<META content=3D"MSHTML 6.00.2800.1561" name=3DGENERATOR></HEAD>
<BODY>
<DIV dir=3Dltr align=3Dleft><SPAN class=3D544175706-26102006><FONT =
face=3D"Courier New"=20
size=3D2>export the path of pkgconfig in the variable PKG_CONFIG_PATH=20
e.g.</FONT></SPAN></DIV>
<DIV dir=3Dltr align=3Dleft><SPAN class=3D544175706-26102006><FONT =
face=3D"Courier New"=20
size=3D2># export =
PKG_CONFIG_PATH=3D/usr/local/lib/pkgconfig/</FONT></SPAN></DIV>
<DIV dir=3Dltr align=3Dleft><SPAN class=3D544175706-26102006><FONT =
face=3D"Courier New"=20
size=3D2></FONT></SPAN>&nbsp;</DIV>
<DIV dir=3Dltr align=3Dleft><SPAN class=3D544175706-26102006><FONT =
face=3D"Courier New"=20
size=3D2>Try to configure again. It will work.</FONT></SPAN></DIV>
<DIV dir=3Dltr align=3Dleft><SPAN class=3D544175706-26102006><FONT =
face=3D"Courier New"=20
size=3D2></FONT></SPAN>&nbsp;</DIV>
<DIV dir=3Dltr align=3Dleft><SPAN class=3D544175706-26102006><FONT =
face=3D"Courier New"=20
size=3D2>Regards</FONT></SPAN></DIV>
<DIV><FONT face=3D"Courier New" size=3D2></FONT>&nbsp;</DIV><!-- =
Converted from text/plain format -->
<P><FONT size=3D2>Sumeet Verma<BR></FONT></P>
<DIV>&nbsp;</DIV><BR>
<DIV class=3DOutlookMessageHeader lang=3Den-us dir=3Dltr align=3Dleft>
<HR tabIndex=3D-1>
<FONT face=3DTahoma size=3D2><B>From:</B> =
bluez-users-bounces@lists.sourceforge.net=20
[mailto:bluez-users-bounces@lists.sourceforge.net] <B>On Behalf Of=20
</B>Amarnath<BR><B>Sent:</B> Thursday, October 26, 2006 12:25 =
PM<BR><B>To:</B>=20
bluez-users@lists.sourceforge.net<BR><B>Subject:</B> [Bluez-users] =
Problem while=20
compiling bluez-utils 3.7<BR></FONT><BR></DIV>
<DIV></DIV>hi,<BR><BR>I am getting problem when i try to compile =
Bluez-Utils3.7=20
:<BR><BR>$./configure --prefix=3D/usr --mandir=3D/usr/share/man =
--sysconfdir=3D/etc=20
--localstatedir=3D/var --libexecdir=3D/lib<BR><BR>the error was =
:<BR><B>checking for=20
DBUS... configure: error: dbus &gt; 0.35 is required</B><BR><BR>but Dbus =
0.6 is=20
loaded on my system(ubuntu) . Can anybody have solution , how should i =
solve the=20
problem. Any comments are appreciated. <BR><BR>thanx in =
advance<BR>Amarnath. <PRE>
This message contains confidential information and is intended only =20
for the individual named. If you are not the named addressee you =20
should not disseminate, distribute or copy this e-mail. Please =20
notify the sender immediately by e-mail if you have received this =20
e-mail by mistake and delete this e-mail from your system. E-mail =20
transmission cannot be guaranteed to be secured or error-free as =20
information could be intercepted, corrupted, lost, destroyed, arrive =20
late or incomplete, or contain viruses. The sender therefore does =20
not accept liability for any errors or omissions in the contents =20
of this message, which arise as a result of e-mail transmission.=20
=20
For further query please contact info@fortuna.com</PRE></BODY></HTML>

------=_NextPart_000_007B_01C6F8FA.80B7F610--



--===============1021564600==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

-------------------------------------------------------------------------
Using Tomcat but need to do more? Need to support web services, security?
Get stuff done quickly with pre-integrated technology to make your job easier
Download IBM WebSphere Application Server v.1.0.1 based on Apache Geronimo
http://sel.as-us.falkag.net/sel?cmd=lnk&kid=120709&bid=263057&dat=121642
--===============1021564600==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Bluez-users mailing list
Bluez-users@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-users

--===============1021564600==--
