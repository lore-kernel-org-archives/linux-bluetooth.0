Return-Path: <bluez-devel-admin@lists.sourceforge.net>
Message-ID: <000d01c46b72$fb6af0f0$8425b9ac@oemcomputer>
From: "Daniel Stoddart" <d.stoddart@cs.ucl.ac.uk>
To: <bluez-devel@lists.sourceforge.net>
MIME-Version: 1.0
Content-Type: multipart/alternative;
	boundary="----=_NextPart_000_0008_01C46B7B.5BEFFB20"
Subject: [Bluez-devel] Service registering but not visible
Sender: bluez-devel-admin@lists.sourceforge.net
Errors-To: bluez-devel-admin@lists.sourceforge.net
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-devel>,
	<mailto:bluez-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Id: <bluez-devel.lists.sourceforge.net>
List-Post: <mailto:bluez-devel@lists.sourceforge.net>
List-Help: <mailto:bluez-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-devel>,
	<mailto:bluez-devel-request@lists.sourceforge.net?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=bluez-devel>
Date: Fri, 16 Jul 2004 21:25:04 +0100

This is a multi-part message in MIME format.

------=_NextPart_000_0008_01C46B7B.5BEFFB20
Content-Type: text/plain;
	charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable

Hi,

When i add a service using the command

root@darkstar:~# sdptool add --channel=3D13 OPUSH
OBEX Object Push service registered

And then using my Nokia 6600, search for available services no services =
are shown.

This is the setup i'm using

Linux distr: Slackware 9.0
Kernel: 2.4.22
Packages installed:=20
bluez-libs-2.7-1.i386.rpm
bluez-sdp-1.5-1.i386.rpm
bluez-utils-2.7-1.i386.rpm

Am i missing something or doing something wrong?

Thanks

Dan






I start the daemons hcid and /usr/sbin/sdpd and can discover services on =
my nokia 6600 using
sdptool browse.

Using rococo's java api's i have created a server(linux) and a =
client(nokia 6600) but my nokia
 does not find the service i have registered via the server.

I have checked my code against other working java bt servers that =
register their services and everything is fine.

So then i used the command=20

"sdptool add--channel =3D13 OPUSH" to add a service (presumably register =
as well) and this was successful.
"Service OPUSH added" was the message I think. But still I could not see =
this service through my phone.
(I am using benhui's BTBrowser that happily discovers bluetooth services =
when i'm using windows).

Do you have any idea what i might be missing or where i might be going =
wrong? I've spent so many hours trawling=20
through the internet reading anything on bluetooth and can't see where =
i'm going wrong.

Thanks for your time

Dan
------=_NextPart_000_0008_01C46B7B.5BEFFB20
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
<DIV><FONT face=3DArial size=3D2>Hi,</FONT></DIV>
<DIV><FONT face=3DArial size=3D2></FONT>&nbsp;</DIV>
<DIV><FONT face=3DArial size=3D2>When i add a service using the =
command</FONT></DIV>
<DIV><FONT face=3DArial size=3D2></FONT>&nbsp;</DIV>
<DIV><FONT face=3DArial size=3D2><FONT size=3D2><FONT size=3D2><A=20
href=3D"mailto:root@darkstar">root@darkstar</A>:~# sdptool add =
--channel=3D13=20
OPUSH</DIV>
<DIV><FONT size=3D2>
<P>OBEX Object Push service registered</P>
<P>And then using my Nokia 6600, search for available services no =
services are=20
shown.</P>
<P></FONT></FONT></FONT></FONT><FONT face=3DArial size=3D2>This is the =
setup i'm=20
using</FONT></P></DIV>
<DIV>
<DIV><FONT face=3DArial size=3D2>Linux distr: Slackware 9.0</FONT></DIV>
<DIV><FONT face=3DArial size=3D2>Kernel: 2.4.22</FONT></DIV>
<DIV><FONT face=3DArial size=3D2>Packages installed: </FONT></DIV>
<DIV><FONT face=3DArial size=3D2><A=20
href=3D"http://bluez.sourceforge.net/download/redhat/bluez-libs-2.7-1.i38=
6.rpm">bluez-libs-2.7-1.i386.rpm</A></FONT></DIV>
<DIV><FONT face=3DArial size=3D2><A=20
href=3D"http://bluez.sourceforge.net/download/redhat/bluez-sdp-1.5-1.i386=
.rpm">bluez-sdp-1.5-1.i386.rpm</A></FONT></DIV>
<DIV><FONT face=3DArial size=3D2><A=20
href=3D"http://bluez.sourceforge.net/download/redhat/bluez-utils-2.7-1.i3=
86.rpm">bluez-utils-2.7-1.i386.rpm</A></FONT></DIV>
<DIV><FONT face=3DArial size=3D2></FONT>&nbsp;</DIV>
<DIV><FONT face=3DArial size=3D2>Am i missing something or doing =
something=20
wrong?</FONT></DIV>
<DIV><FONT face=3DArial size=3D2></FONT>&nbsp;</DIV>
<DIV><FONT face=3DArial size=3D2>Thanks</FONT></DIV>
<DIV><FONT face=3DArial size=3D2></FONT>&nbsp;</DIV>
<DIV><FONT face=3DArial size=3D2>Dan</FONT></DIV>
<DIV><FONT face=3DArial size=3D2></FONT>&nbsp;</DIV>
<DIV>&nbsp;</DIV>
<DIV><FONT face=3DArial size=3D2></FONT>&nbsp;</DIV>
<DIV><FONT face=3DArial size=3D2></FONT>&nbsp;</DIV>
<DIV><FONT face=3DArial size=3D2></FONT>&nbsp;</DIV>
<DIV><FONT face=3DArial size=3D2></FONT>&nbsp;</DIV>
<DIV><FONT face=3DArial size=3D2>I start the daemons hcid and =
/usr/sbin/sdpd and can=20
discover services on my nokia 6600 using</FONT></DIV>
<DIV><FONT face=3DArial size=3D2>sdptool browse.</FONT></DIV>
<DIV><FONT face=3DArial size=3D2></FONT>&nbsp;</DIV>
<DIV><FONT face=3DArial size=3D2>Using rococo's java api's i have =
created a=20
server(linux) and a client(nokia 6600) but my nokia</FONT></DIV>
<DIV><FONT face=3DArial size=3D2>&nbsp;does not find&nbsp;the service i =
have=20
registered via the server.</FONT></DIV>
<DIV><FONT face=3DArial size=3D2></FONT>&nbsp;</DIV>
<DIV><FONT face=3DArial size=3D2>I have checked my code against other =
working java=20
bt servers that register their services and everything is =
fine.</FONT></DIV>
<DIV><FONT face=3DArial size=3D2></FONT>&nbsp;</DIV>
<DIV><FONT face=3DArial size=3D2>So then i used the command =
</FONT></DIV>
<DIV><FONT face=3DArial size=3D2></FONT>&nbsp;</DIV>
<DIV><FONT face=3DArial size=3D2>"sdptool add--channel =3D13 OPUSH" to =
add a service=20
(presumably register as well) and this was successful.</FONT></DIV>
<DIV><FONT face=3DArial size=3D2>"Service OPUSH added" was the message I =
think. But=20
still I could not see this service through my phone.</FONT></DIV>
<DIV><FONT face=3DArial size=3D2>(I am using benhui's BTBrowser that =
happily=20
discovers bluetooth services when i'm using windows).</FONT></DIV>
<DIV><FONT face=3DArial size=3D2></FONT>&nbsp;</DIV>
<DIV><FONT face=3DArial size=3D2>Do you have any idea what i might be =
missing or=20
where i might be going wrong? I've spent so many hours trawling =
</FONT></DIV>
<DIV><FONT face=3DArial size=3D2>through the internet reading anything =
on bluetooth=20
and can't see where i'm going wrong.</FONT></DIV>
<DIV><FONT face=3DArial size=3D2></FONT>&nbsp;</DIV>
<DIV><FONT face=3DArial size=3D2>Thanks for your time</FONT></DIV>
<DIV><FONT face=3DArial size=3D2></FONT>&nbsp;</DIV>
<DIV><FONT face=3DArial size=3D2>Dan</FONT></DIV></DIV></BODY></HTML>

------=_NextPart_000_0008_01C46B7B.5BEFFB20--



-------------------------------------------------------
This SF.Net email is sponsored by BEA Weblogic Workshop
FREE Java Enterprise J2EE developer tools!
Get your free copy of BEA WebLogic Workshop 8.1 today.
http://ads.osdn.com/?ad_id=4721&alloc_id=10040&op=click
_______________________________________________
Bluez-devel mailing list
Bluez-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-devel
