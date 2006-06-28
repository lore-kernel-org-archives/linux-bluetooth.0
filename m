Return-Path: <bluez-devel-bounces@lists.sourceforge.net>
Message-ID: <BAY116-DAV22C2B995073A52F8216D6C77F0@phx.gbl>
From: "I-Chung Chane" <ichane@hotmail.com>
To: "BlueZ development" <bluez-devel@lists.sourceforge.net>
References: <BAY116-DAV738BD697D0EDB18FB509AC77F0@phx.gbl>
	<6297d67c0606272049g55cc14cby52254c90863e727f@mail.gmail.com>
Date: Wed, 28 Jun 2006 17:34:07 +0800
MIME-Version: 1.0
Subject: Re: [Bluez-devel] A2DP a2play and a2recv
Reply-To: BlueZ development <bluez-devel@lists.sourceforge.net>
List-Id: BlueZ development <bluez-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-devel>,
	<mailto:bluez-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=bluez-devel>
List-Post: <mailto:bluez-devel@lists.sourceforge.net>
List-Help: <mailto:bluez-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-devel>,
	<mailto:bluez-devel-request@lists.sourceforge.net?subject=subscribe>
Content-Type: multipart/mixed; boundary="===============1233020248=="
Sender: bluez-devel-bounces@lists.sourceforge.net
Errors-To: bluez-devel-bounces@lists.sourceforge.net

This is a multi-part message in MIME format.

--===============1233020248==
Content-Type: multipart/alternative;
	boundary="----=_NextPart_000_0088_01C69AD9.0F36ACE0"

This is a multi-part message in MIME format.

------=_NextPart_000_0088_01C69AD9.0F36ACE0
Content-Type: text/plain;
	charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable

Hi, Mayank:

     Thanks for reply. can a2play run on OSS too?

     I ported BlueZ on an embeded ARM7 running at 80 MHz.=20
I also try a2recv on embeded board with sound chip using OSS
driver. Printout looks ok, but can't hear anything:

---------------------------------------------------------------------
> ./a2recv

Connected [imtu 672, omtu 672, flush_to 65535]
Connected
Sent Stream End Point Discovery Response

Sent the get capabilities responseChannels=3D2, =
speed=3D44100channel_mode =3D 2 alloca tion_method =3D 2 subbands =3D 1 =
block_length =3D 1 min_bitpool =3D 2 max_bitpool =3D 250

Sent a Set configurations response

Received an open stream command

Sent open stream confirm

Connected [imtu 672, omtu 672, flush_to 65535]
ConnectedGot stream fd

Sent start stream confirm
-------------------------------------------------------------------------=
-----

Is CPU (ARM7 @80MHz) powerful enough  to run a2recv ?

Thanks a lot for help,

Chane
  ----- Original Message -----=20
  From: Mayank Batra=20
  To: BlueZ development=20
  Sent: Wednesday, June 28, 2006 11:49 AM
  Subject: Re: [Bluez-devel] A2DP a2play and a2recv


  Hi Chane,


  On 6/28/06, I-Chung Chane <ichane@hotmail.com> wrote:

    I'm trying Bluetooth-ALSA Project (A2DP part). I wonder does a2play =
and a2recv need
    ALSA to make it work? Can they work with sound card using OSS =
driver?

  a2recv will work with OSS driver. It will accept an incoming A2DP =
connection and then bind to your /dev/dsp.

  Regards,
  Mayank





  =20


-------------------------------------------------------------------------=
-----


  Using Tomcat but need to do more? Need to support web services, =
security?
  Get stuff done quickly with pre-integrated technology to make your job =
easier
  Download IBM WebSphere Application Server v.1.0.1 based on Apache =
Geronimo
  =
http://sel.as-us.falkag.net/sel?cmd=3Dlnk&kid=3D120709&bid=3D263057&dat=3D=
121642


-------------------------------------------------------------------------=
-----


  _______________________________________________
  Bluez-devel mailing list
  Bluez-devel@lists.sourceforge.net
  https://lists.sourceforge.net/lists/listinfo/bluez-devel

------=_NextPart_000_0088_01C69AD9.0F36ACE0
Content-Type: text/html;
	charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable

<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.0 Transitional//EN">
<HTML><HEAD>
<META http-equiv=3DContent-Type content=3D"text/html; =
charset=3Diso-8859-1">
<META content=3D"MSHTML 6.00.2900.2912" name=3DGENERATOR>
<STYLE></STYLE>
</HEAD>
<BODY bgColor=3D#ffffff>
<DIV><FONT face=3D&#26032;&#32048;&#26126;&#39636; size=3D2>Hi, =
Mayank:</FONT></DIV>
<DIV><FONT face=3D&#26032;&#32048;&#26126;&#39636; =
size=3D2></FONT>&nbsp;</DIV>
<DIV><FONT face=3D&#26032;&#32048;&#26126;&#39636; =
size=3D2>&nbsp;&nbsp;&nbsp;&nbsp; Thanks for reply. can=20
a2play run on OSS too?</FONT></DIV>
<DIV><FONT face=3D&#26032;&#32048;&#26126;&#39636; =
size=3D2></FONT>&nbsp;</DIV>
<DIV><FONT face=3D&#26032;&#32048;&#26126;&#39636; =
size=3D2>&nbsp;&nbsp;&nbsp;&nbsp; I ported BlueZ on an=20
embeded ARM7 running at 80 MHz. </FONT></DIV>
<DIV><FONT face=3D&#26032;&#32048;&#26126;&#39636; size=3D2>I also try =
a2recv on embeded board with sound chip=20
using OSS</FONT></DIV>
<DIV><FONT face=3D&#26032;&#32048;&#26126;&#39636; size=3D2>driver. =
Printout looks ok, but can't hear=20
anything:</FONT></DIV>
<DIV><FONT face=3D&#26032;&#32048;&#26126;&#39636; =
size=3D2></FONT>&nbsp;</DIV>
<DIV><FONT face=3D&#26032;&#32048;&#26126;&#39636;=20
size=3D2>----------------------------------------------------------------=
-----</FONT></DIV>
<DIV><FONT size=3D2>&gt;&nbsp;./a2recv<BR><BR>Connected [imtu 672, omtu =
672,=20
flush_to 65535]<BR>Connected<BR>Sent Stream End Point Discovery=20
Response<BR><BR>Sent the get capabilities responseChannels=3D2,=20
speed=3D44100channel_mode =3D 2 alloca tion_method =3D 2 subbands =3D 1 =
block_length =3D 1=20
min_bitpool =3D 2 max_bitpool =3D 250<BR><BR>Sent a Set configurations=20
response<BR><BR>Received an open stream command<BR><BR>Sent open stream=20
confirm<BR><BR>Connected [imtu 672, omtu 672, flush_to =
65535]<BR>ConnectedGot=20
stream fd<BR><BR>Sent start stream confirm</FONT><BR><FONT =
face=3D&#26032;&#32048;&#26126;&#39636;=20
size=3D2>----------------------------------------------------------------=
--------------</FONT></DIV>
<DIV><FONT face=3D&#26032;&#32048;&#26126;&#39636; =
size=3D2></FONT>&nbsp;</DIV>
<DIV><FONT face=3D&#26032;&#32048;&#26126;&#39636; size=3D2>Is&nbsp;CPU =
(ARM7 @80MHz) powerful enough &nbsp;to=20
run a2recv ?</FONT></DIV>
<DIV><FONT face=3D&#26032;&#32048;&#26126;&#39636; =
size=3D2></FONT>&nbsp;</DIV>
<DIV><FONT face=3D&#26032;&#32048;&#26126;&#39636; size=3D2>Thanks a lot =
for help,</FONT></DIV>
<DIV><FONT face=3D&#26032;&#32048;&#26126;&#39636; =
size=3D2></FONT>&nbsp;</DIV>
<DIV><FONT face=3D&#26032;&#32048;&#26126;&#39636; =
size=3D2>Chane</FONT></DIV>
<BLOCKQUOTE=20
style=3D"PADDING-RIGHT: 0px; PADDING-LEFT: 5px; MARGIN-LEFT: 5px; =
BORDER-LEFT: #000000 2px solid; MARGIN-RIGHT: 0px">
  <DIV style=3D"FONT: 10pt &#26032;&#32048;&#26126;&#39636;">----- =
Original Message ----- </DIV>
  <DIV=20
  style=3D"BACKGROUND: #e4e4e4; FONT: 10pt =
&#26032;&#32048;&#26126;&#39636;; font-color: black"><B>From:</B>=20
  <A title=3Dmayankbatra@gmail.com =
href=3D"mailto:mayankbatra@gmail.com">Mayank=20
  Batra</A> </DIV>
  <DIV style=3D"FONT: 10pt &#26032;&#32048;&#26126;&#39636;"><B>To:</B> =
<A=20
  title=3Dbluez-devel@lists.sourceforge.net=20
  href=3D"mailto:bluez-devel@lists.sourceforge.net">BlueZ =
development</A> </DIV>
  <DIV style=3D"FONT: 10pt =
&#26032;&#32048;&#26126;&#39636;"><B>Sent:</B> Wednesday, June 28, 2006 =
11:49=20
  AM</DIV>
  <DIV style=3D"FONT: 10pt =
&#26032;&#32048;&#26126;&#39636;"><B>Subject:</B> Re: [Bluez-devel] A2DP =
a2play and=20
  a2recv</DIV>
  <DIV><BR></DIV>Hi Chane,<BR><BR>
  <DIV><SPAN class=3Dgmail_quote>On 6/28/06, <B =
class=3Dgmail_sendername>I-Chung=20
  Chane</B> &lt;<A =
href=3D"mailto:ichane@hotmail.com">ichane@hotmail.com</A>&gt;=20
  wrote:</SPAN><BR>
  <BLOCKQUOTE class=3Dgmail_quote=20
  style=3D"PADDING-LEFT: 1ex; MARGIN: 0px 0px 0px 0.8ex; BORDER-LEFT: =
#ccc 1px solid">
    <DIV>
    <DIV bgcolor=3D"#ffffff">
    <DIV><FONT size=3D2>I'm trying Bluetooth-ALSA Project (A2DP part). I =
wonder=20
    does a2play and a2recv need</FONT></DIV>
    <DIV><FONT size=3D2>ALSA&nbsp;to make it work? Can they work with =
sound card=20
    using OSS driver?</FONT></DIV></DIV></DIV></BLOCKQUOTE>
  <DIV>&nbsp;</DIV>
  <DIV>a2recv will work with OSS driver. It will accept an incoming A2DP =

  connection and then bind to your /dev/dsp.</DIV>
  <DIV>&nbsp;</DIV>
  <DIV>Regards,</DIV>
  <DIV>Mayank</DIV><BR>
  <DIV>&nbsp;</DIV>
  <DIV>&nbsp;</DIV><BR>&nbsp;</DIV>
  <P>
  <HR>

  <P></P>Using Tomcat but need to do more? Need to support web services, =

  security?<BR>Get stuff done quickly with pre-integrated technology to =
make=20
  your job easier<BR>Download IBM WebSphere Application Server v.1.0.1 =
based on=20
  Apache=20
  =
Geronimo<BR>http://sel.as-us.falkag.net/sel?cmd=3Dlnk&amp;kid=3D120709&am=
p;bid=3D263057&amp;dat=3D121642
  <P>
  <HR>

  <P></P>_______________________________________________<BR>Bluez-devel =
mailing=20
  =
list<BR>Bluez-devel@lists.sourceforge.net<BR>https://lists.sourceforge.ne=
t/lists/listinfo/bluez-devel<BR></BLOCKQUOTE></BODY></HTML>

------=_NextPart_000_0088_01C69AD9.0F36ACE0--


--===============1233020248==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

Using Tomcat but need to do more? Need to support web services, security?
Get stuff done quickly with pre-integrated technology to make your job easier
Download IBM WebSphere Application Server v.1.0.1 based on Apache Geronimo
http://sel.as-us.falkag.net/sel?cmd=lnk&kid=120709&bid=263057&dat=121642
--===============1233020248==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Bluez-devel mailing list
Bluez-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-devel

--===============1233020248==--
