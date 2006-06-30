Return-Path: <bluez-devel-bounces@lists.sourceforge.net>
Message-ID: <BAY116-DAV15082F73CFA8D4005D654DC77D0@phx.gbl>
From: "ichane" <ichane@hotmail.com>
To: "BlueZ development" <bluez-devel@lists.sourceforge.net>
References: <BAY116-DAV738BD697D0EDB18FB509AC77F0@phx.gbl><6297d67c0606272049g55cc14cby52254c90863e727f@mail.gmail.com><BAY116-DAV22C2B995073A52F8216D6C77F0@phx.gbl><6297d67c0606282023y52f26393i97ce102bde16776@mail.gmail.com>
	<6297d67c0606290020x51468e0ap97c3afee4bbad94a@mail.gmail.com>
Date: Fri, 30 Jun 2006 11:30:33 +0800
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
Content-Type: multipart/mixed; boundary="===============1332284560=="
Sender: bluez-devel-bounces@lists.sourceforge.net
Errors-To: bluez-devel-bounces@lists.sourceforge.net

This is a multi-part message in MIME format.

--===============1332284560==
Content-Type: multipart/alternative;
	boundary="----=_NextPart_000_00F6_01C69C38.997F5B80"

This is a multi-part message in MIME format.

------=_NextPart_000_00F6_01C69C38.997F5B80
Content-Type: text/plain;
	charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable

Hi, Mayank & Brad:

    Thanks for your replies.

     I try fixed point sbc. The distorted sound can be heard using =
a2recv.

    I've not tried the sbc optimizations Brad mentioned since I'm not
familiar with sbc lib. I need some more time to study how to do it.

Thanks a lot for the helps,

Chane

  ----- Original Message -----=20
  From: Mayank Batra=20
  To: BlueZ development=20
  Sent: Thursday, June 29, 2006 3:20 PM
  Subject: Re: [Bluez-devel] A2DP a2play and a2recv


  Hi Chane,


  On 6/29/06, Mayank Batra <mayankbatra@gmail.com> wrote:=20
    Hi Chane,


    On 6/28/06, I-Chung Chane <ichane@hotmail.com > wrote:=20
      Is CPU (ARM7 @80MHz) powerful enough  to run a2recv ?

    On second thoughts, I think it is not fast enough. So please use =
fixed point calculations in libsbc.a
    In fact I tried the floating point library with a2play on my ARM9 =
platform (~100MHz) yesterday. And it was probably too much for it. The =
CPU load was too high.

  Just to confirm, I ran a2play on my ARM9 platform just now.
  It works fine when I use fixed point libsbc.
  But if I use floating point, it is terrible.

  Hope that helps.

  Regards,
  Mayank


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

------=_NextPart_000_00F6_01C69C38.997F5B80
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
<DIV><FONT face=3D&#26032;&#32048;&#26126;&#39636; size=3D2>Hi, Mayank =
&amp; Brad:</FONT></DIV>
<DIV><FONT face=3D&#26032;&#32048;&#26126;&#39636; =
size=3D2></FONT>&nbsp;</DIV>
<DIV><FONT face=3D&#26032;&#32048;&#26126;&#39636; =
size=3D2>&nbsp;&nbsp;&nbsp; Thanks for your=20
replies.</FONT></DIV>
<DIV><FONT face=3D&#26032;&#32048;&#26126;&#39636; =
size=3D2></FONT>&nbsp;</DIV>
<DIV><FONT face=3D&#26032;&#32048;&#26126;&#39636; =
size=3D2>&nbsp;&nbsp;&nbsp;&nbsp; I try fixed point sbc. The=20
distorted sound can be heard using a2recv.</FONT></DIV>
<DIV><FONT face=3D&#26032;&#32048;&#26126;&#39636; =
size=3D2></FONT>&nbsp;</DIV>
<DIV><FONT face=3D&#26032;&#32048;&#26126;&#39636; =
size=3D2>&nbsp;&nbsp;&nbsp; I've not&nbsp;tried the sbc=20
optimizations Brad mentioned since I'm not</FONT></DIV>
<DIV><FONT face=3D&#26032;&#32048;&#26126;&#39636; size=3D2>familiar =
with sbc lib. I need some more time to=20
study how to do it.</FONT></DIV>
<DIV><FONT face=3D&#26032;&#32048;&#26126;&#39636; =
size=3D2></FONT>&nbsp;</DIV>
<DIV><FONT face=3D&#26032;&#32048;&#26126;&#39636; size=3D2>Thanks a lot =
for the helps,</FONT></DIV>
<DIV><FONT face=3D&#26032;&#32048;&#26126;&#39636; =
size=3D2></FONT>&nbsp;</DIV>
<DIV><FONT face=3D&#26032;&#32048;&#26126;&#39636; =
size=3D2>Chane</FONT></DIV>
<DIV><FONT face=3D&#26032;&#32048;&#26126;&#39636; size=3D2><FONT =
size=3D3></FONT></FONT>&nbsp;</DIV>
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
&#26032;&#32048;&#26126;&#39636;"><B>Sent:</B> Thursday, June 29, 2006 =
3:20=20
PM</DIV>
  <DIV style=3D"FONT: 10pt =
&#26032;&#32048;&#26126;&#39636;"><B>Subject:</B> Re: [Bluez-devel] A2DP =
a2play and=20
  a2recv</DIV>
  <DIV><BR></DIV>Hi Chane,<BR><BR>
  <DIV><SPAN class=3Dgmail_quote>On 6/29/06, <B =
class=3Dgmail_sendername>Mayank=20
  Batra</B> &lt;<A=20
  href=3D"mailto:mayankbatra@gmail.com">mayankbatra@gmail.com</A>&gt;=20
  wrote:</SPAN>=20
  <BLOCKQUOTE class=3Dgmail_quote=20
  style=3D"PADDING-LEFT: 1ex; MARGIN: 0px 0px 0px 0.8ex; BORDER-LEFT: =
#ccc 1px solid">
    <DIV>Hi Chane,<BR><BR>
    <DIV></DIV>
    <DIV><SPAN class=3Dq><SPAN class=3Dgmail_quote>On 6/28/06, <B=20
    class=3Dgmail_sendername>I-Chung Chane</B> &lt;<A=20
    onclick=3D"return top.js.OpenExtLink(window,event,this)"=20
    href=3D"mailto:ichane@hotmail.com " =
target=3D_blank>ichane@hotmail.com </A>&gt;=20
    wrote:</SPAN> </SPAN></DIV>
    <DIV><SPAN class=3Dq>
    <BLOCKQUOTE class=3Dgmail_quote=20
    style=3D"PADDING-LEFT: 1ex; MARGIN: 0px 0px 0px 0.8ex; BORDER-LEFT: =
#ccc 1px solid">
      <DIV>
      <DIV bgcolor=3D"#ffffff">
      <DIV><FONT face=3D"&#27;$B?7:YL@qs&#27;(B" size=3D2>Is&nbsp;CPU =
(ARM7 @80MHz)=20
      powerful enough &nbsp;to run a2recv =
?</FONT></DIV></DIV></DIV></BLOCKQUOTE>
    <DIV>&nbsp;</DIV></SPAN></DIV>
    <DIV>
    <DIV>On second thoughts, I think it is not fast enough. So please =
use fixed=20
    point calculations in libsbc.a</DIV>
    <DIV>In fact I tried the floating point library with a2play on my =
ARM9=20
    platform (~100MHz)&nbsp;yesterday. And it was probably too much for =
it. The=20
    CPU load was too high.</DIV></DIV></DIV></BLOCKQUOTE>
  <DIV>&nbsp;</DIV>
  <DIV>Just to confirm, I ran a2play on my ARM9 platform just now.</DIV>
  <DIV>It works fine when I use fixed point libsbc.</DIV>
  <DIV>But if I use floating point, it is terrible.</DIV>
  <DIV>&nbsp;</DIV>
  <DIV>Hope that helps.</DIV>
  <DIV>&nbsp;</DIV>
  <DIV>Regards,</DIV>
  <DIV>Mayank</DIV></DIV>
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

------=_NextPart_000_00F6_01C69C38.997F5B80--


--===============1332284560==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

Using Tomcat but need to do more? Need to support web services, security?
Get stuff done quickly with pre-integrated technology to make your job easier
Download IBM WebSphere Application Server v.1.0.1 based on Apache Geronimo
http://sel.as-us.falkag.net/sel?cmd=lnk&kid=120709&bid=263057&dat=121642
--===============1332284560==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Bluez-devel mailing list
Bluez-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-devel

--===============1332284560==--
