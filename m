Return-Path: <bluez-devel-admin@lists.sourceforge.net>
Subject: RE: [Bluez-devel] Parameters of the Bluetooth standard in BlueZ...
MIME-Version: 1.0
Content-Type: multipart/alternative;
	boundary="----_=_NextPart_001_01C3FD1D.D32F2BCE"
Message-ID: <C1B29E01A9B748458D51DBBE04E4B9EA273752@7layers.7layers-uk.com>
From: "Halam Rose" <Halam.Rose@7layers-uk.com>
To: "Jers" <jers@inwind.it>, <bluez-devel@lists.sourceforge.net>
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
Date: Fri, 27 Feb 2004 10:38:23 -0000

This is a multi-part message in MIME format.

------_=_NextPart_001_01C3FD1D.D32F2BCE
Content-Type: text/plain;
	charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable

It may be an idea to look at the Bluetooth 1.2 procedures as they speed =
up connections.
=20
Halam

-----Original Message-----
From: Jers [mailto:jers@inwind.it]
Sent: 27 February 2004 10:32
To: bluez-devel@lists.sourceforge.net
Subject: [Bluez-devel] Parameters of the Bluetooth standard in BlueZ...



Dear all,

=20

I'm not a developer but I need your help!

At the moment I'm carrying out a study about Bluetooth standard. In this =
study I modified some parameters of Inquiry and Inquiry Scan procedures. =
Now I want to test my analytical results by real experiments. I'd like =
to evaluate the discovery performances of two bluetooth devices, =
changing:

=20

-         in Inquiry Scan procedure:

o       Time spent in Rx (>=3D16*Tslot, according to the standard)

o       The period between two consecutive inquiry scan (<2.56 sec, =
according to the standard)

-         in Inquiry procedure:

o       The period between the transmission of two consecutive packets =
(According the standard: 244.5 msec, after odd packets; 869.5 msec, =
after even packets)

o       Number of repetitions of frequencies trains.

-         in both procedures:

o       number of employed hops

=20

I suppose I can set these parameters by BlueZ, so I looked for lines =
that manage them in all BlueZ files but I didn't find.=20

=20

Can I change these parameters in BlueZ?

If I can, which file(s) and functions do I have to modify?

Thanks in advance.

=20

Best regards.

Jers



Halam Rose
Bluetooth Specialist
Tel: +44 (0)1763 262524
Fax: +44 (0)1763 261177=20

Halam.Rose@7layers-uk.com
http://www.7layers-uk.com

Meet 7 layers=20
3GSM World Congress=20
23-27 February 2004=20
Cannes, France.=20
Booth B 28 Hall 1.

-------------------------------------------------------------------------=
-------------------------------------------------------------------------=

This communication is from 7 Layers UK Ltd., Melbourn Science Park, =
Cambridge Road, Melbourn, Hertfordshire SG8 6HB, England.
This email (including any attachments) is intended only for Jers, =
bluez-devel@lists.sourceforge.net. It may contain confidential or =
privileged
information. If you are not the intended recipient, please do not read, =
distribute, copy or otherwise use this communication or
the information in it. Any views or opinions expressed in this email may =
be solely those of the author and are not necessarily
those of 7 Layers UK Ltd. WARNING: Although 7 Layers UK Ltd have taken =
all reasonable precautions to ensure that viruses
are not present in this email, the company can accept no responsibility =
for any loss of data arising from the use of this email
or its attachments. If you have received this communication in error, =
please notify us by email (postmaster@7layers-UK.com)
or by telephone +44 (0) 1763 262524 and then delete the email and any =
copies of it.
-------------------------------------------------------------------------=
-------------------------------------------------------------------------=



------_=_NextPart_001_01C3FD1D.D32F2BCE
Content-Type: text/html;
	charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable

<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.0 Transitional//EN">
<HTML xmlns:o =3D "urn:schemas-microsoft-com:office:office"><HEAD>
<META HTTP-EQUIV=3D"Content-Type" CONTENT=3D"text/html; =
charset=3Diso-8859-1">


<META content=3D"MSHTML 6.00.2800.1276" name=3DGENERATOR>
<STYLE></STYLE>
</HEAD>
<BODY bgColor=3D#ffffff><FONT COLOR=3DBLACK>
<DIV><SPAN class=3D678143610-27022004><FONT face=3DArial color=3D#0000ff =
size=3D2>It may=20
be an idea to look at the Bluetooth 1.2 procedures as they speed up=20
connections.</FONT></SPAN></DIV>
<DIV><SPAN class=3D678143610-27022004><FONT face=3DArial color=3D#0000ff =

size=3D2></FONT></SPAN>&nbsp;</DIV>
<DIV><SPAN class=3D678143610-27022004><FONT face=3DArial color=3D#0000ff =

size=3D2>Halam</FONT></SPAN></DIV>
<BLOCKQUOTE dir=3Dltr style=3D"MARGIN-RIGHT: 0px">
  <DIV class=3DOutlookMessageHeader dir=3Dltr align=3Dleft><FONT =
face=3DTahoma=20
  size=3D2>-----Original Message-----<BR><B>From:</B> Jers=20
  [mailto:jers@inwind.it]<BR><B>Sent:</B> 27 February 2004 =
10:32<BR><B>To:</B>=20
  bluez-devel@lists.sourceforge.net<BR><B>Subject:</B> [Bluez-devel] =
Parameters=20
  of the Bluetooth standard in BlueZ...<BR><BR></FONT></DIV>
  <DIV>
  <P class=3DMsoNormal style=3D"MARGIN: 0cm 0cm 0pt"><SPAN lang=3DEN-GB=20
  style=3D"mso-ansi-language: EN-GB">Dear all,<o:p></o:p></SPAN></P>
  <P class=3DMsoNormal style=3D"MARGIN: 0cm 0cm 0pt"><SPAN lang=3DEN-GB=20
  style=3D"mso-ansi-language: EN-GB">&nbsp;<o:p></o:p></SPAN></P>
  <P class=3DMsoNormal style=3D"MARGIN: 0cm 0cm 0pt"><SPAN lang=3DEN-GB=20
  style=3D"mso-ansi-language: EN-GB">I&#8217;m not a developer but I =
need your=20
  help!<o:p></o:p></SPAN></P>
  <P class=3DMsoNormal style=3D"MARGIN: 0cm 0cm 0pt"><SPAN lang=3DEN-GB=20
  style=3D"mso-ansi-language: EN-GB">At the moment I&#8217;m carrying =
out a study about=20
  Bluetooth standard. In this study I modified some parameters of =
Inquiry and=20
  Inquiry Scan procedures. Now I want to test my analytical results by =
real=20
  experiments. I&#8217;d like to evaluate the discovery performances of =
two bluetooth=20
  devices, changing:<o:p></o:p></SPAN></P>
  <P class=3DMsoNormal style=3D"MARGIN: 0cm 0cm 0pt"><SPAN lang=3DEN-GB=20
  style=3D"mso-ansi-language: EN-GB">&nbsp;<o:p></o:p></SPAN></P>
  <P class=3DMsoNormal=20
  style=3D"MARGIN: 0cm 0cm 0pt 18pt; TEXT-INDENT: -18pt; mso-list: l0 =
level1 lfo1; tab-stops: list 18.0pt"><SPAN=20
  lang=3DEN-GB style=3D"mso-ansi-language: EN-GB">-<SPAN=20
  style=3D"FONT: 7pt 'Times New =
Roman'">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=20
  </SPAN></SPAN><SPAN lang=3DEN-GB style=3D"mso-ansi-language: EN-GB">in =
Inquiry=20
  Scan procedure:<o:p></o:p></SPAN></P>
  <P class=3DMsoNormal=20
  style=3D"MARGIN: 0cm 0cm 0pt 54pt; TEXT-INDENT: -18pt; mso-list: l0 =
level2 lfo1; tab-stops: list 54.0pt"><SPAN=20
  lang=3DEN-GB=20
  style=3D"FONT-FAMILY: 'Courier New'; mso-ansi-language: EN-GB; =
mso-bidi-font-family: 'Times New Roman'">o<SPAN=20
  style=3D"FONT: 7pt 'Times New =
Roman'">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=20
  </SPAN></SPAN><SPAN lang=3DEN-GB style=3D"mso-ansi-language: =
EN-GB">Time spent in=20
  Rx (&gt;=3D16*Tslot, according to the standard)<o:p></o:p></SPAN></P>
  <P class=3DMsoNormal=20
  style=3D"MARGIN: 0cm 0cm 0pt 54pt; TEXT-INDENT: -18pt; mso-list: l0 =
level2 lfo1; tab-stops: list 54.0pt"><SPAN=20
  lang=3DEN-GB=20
  style=3D"FONT-FAMILY: 'Courier New'; mso-ansi-language: EN-GB; =
mso-bidi-font-family: 'Times New Roman'">o<SPAN=20
  style=3D"FONT: 7pt 'Times New =
Roman'">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=20
  </SPAN></SPAN><SPAN lang=3DEN-GB style=3D"mso-ansi-language: =
EN-GB">The period=20
  between two consecutive inquiry scan (&lt;2.56 sec, according to the=20
  standard)<o:p></o:p></SPAN></P>
  <P class=3DMsoNormal=20
  style=3D"MARGIN: 0cm 0cm 0pt 18pt; TEXT-INDENT: -18pt; mso-list: l0 =
level1 lfo1; tab-stops: list 18.0pt"><SPAN=20
  lang=3DEN-GB style=3D"mso-ansi-language: EN-GB">-<SPAN=20
  style=3D"FONT: 7pt 'Times New =
Roman'">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=20
  </SPAN></SPAN><SPAN lang=3DEN-GB style=3D"mso-ansi-language: EN-GB">in =
Inquiry=20
  procedure:<o:p></o:p></SPAN></P>
  <P class=3DMsoNormal=20
  style=3D"MARGIN: 0cm 0cm 0pt 54pt; TEXT-INDENT: -18pt; mso-list: l0 =
level2 lfo1; tab-stops: list 54.0pt"><SPAN=20
  lang=3DEN-GB=20
  style=3D"FONT-FAMILY: 'Courier New'; mso-ansi-language: EN-GB; =
mso-bidi-font-family: 'Times New Roman'">o<SPAN=20
  style=3D"FONT: 7pt 'Times New =
Roman'">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=20
  </SPAN></SPAN><SPAN lang=3DEN-GB style=3D"mso-ansi-language: =
EN-GB">The period=20
  between the transmission of two consecutive packets (According the =
standard:=20
  244.5 </SPAN><SPAN lang=3DEN-GB=20
  style=3D"FONT-FAMILY: Symbol; mso-ansi-language: EN-GB">m</SPAN><SPAN =
lang=3DEN-GB=20
  style=3D"mso-ansi-language: EN-GB">sec, after odd packets; 869.5 =
</SPAN><SPAN=20
  lang=3DEN-GB style=3D"FONT-FAMILY: Symbol; mso-ansi-language: =
EN-GB">m</SPAN><SPAN=20
  lang=3DEN-GB style=3D"mso-ansi-language: EN-GB">sec, after even=20
  packets)<o:p></o:p></SPAN></P>
  <P class=3DMsoNormal=20
  style=3D"MARGIN: 0cm 0cm 0pt 54pt; TEXT-INDENT: -18pt; mso-list: l0 =
level2 lfo1; tab-stops: list 54.0pt"><SPAN=20
  lang=3DEN-GB=20
  style=3D"FONT-FAMILY: 'Courier New'; mso-ansi-language: EN-GB; =
mso-bidi-font-family: 'Times New Roman'">o<SPAN=20
  style=3D"FONT: 7pt 'Times New =
Roman'">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=20
  </SPAN></SPAN><SPAN lang=3DEN-GB style=3D"mso-ansi-language: =
EN-GB">Number of=20
  repetitions of frequencies trains.<o:p></o:p></SPAN></P>
  <P class=3DMsoNormal=20
  style=3D"MARGIN: 0cm 0cm 0pt 18pt; TEXT-INDENT: -18pt; mso-list: l0 =
level1 lfo1; tab-stops: list 18.0pt"><SPAN=20
  lang=3DEN-GB style=3D"mso-ansi-language: EN-GB">-<SPAN=20
  style=3D"FONT: 7pt 'Times New =
Roman'">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=20
  </SPAN></SPAN><SPAN lang=3DEN-GB style=3D"mso-ansi-language: EN-GB">in =
both=20
  procedures:<o:p></o:p></SPAN></P>
  <P class=3DMsoNormal=20
  style=3D"MARGIN: 0cm 0cm 0pt 54pt; TEXT-INDENT: -18pt; mso-list: l0 =
level2 lfo1; tab-stops: list 54.0pt"><SPAN=20
  lang=3DEN-GB=20
  style=3D"FONT-FAMILY: 'Courier New'; mso-ansi-language: EN-GB; =
mso-bidi-font-family: 'Times New Roman'">o<SPAN=20
  style=3D"FONT: 7pt 'Times New =
Roman'">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=20
  </SPAN></SPAN><SPAN lang=3DEN-GB style=3D"mso-ansi-language: =
EN-GB">number of=20
  employed hops<o:p></o:p></SPAN></P>
  <P class=3DMsoNormal style=3D"MARGIN: 0cm 0cm 0pt"><SPAN lang=3DEN-GB=20
  style=3D"mso-ansi-language: EN-GB">&nbsp;<o:p></o:p></SPAN></P>
  <P class=3DMsoNormal style=3D"MARGIN: 0cm 0cm 0pt"><SPAN lang=3DEN-GB=20
  style=3D"mso-ansi-language: EN-GB">I suppose I can set these =
parameters by=20
  BlueZ, so I looked for lines that manage them in all BlueZ files but I =
didn&#8217;t=20
  find. <o:p></o:p></SPAN></P>
  <P class=3DMsoNormal style=3D"MARGIN: 0cm 0cm 0pt"><SPAN lang=3DEN-GB=20
  style=3D"mso-ansi-language: EN-GB">&nbsp;<o:p></o:p></SPAN></P>
  <P class=3DMsoNormal style=3D"MARGIN: 0cm 0cm 0pt"><SPAN lang=3DEN-GB=20
  style=3D"mso-ansi-language: EN-GB">Can I change these parameters in=20
  BlueZ?<o:p></o:p></SPAN></P>
  <P class=3DMsoNormal style=3D"MARGIN: 0cm 0cm 0pt"><SPAN lang=3DEN-GB=20
  style=3D"mso-ansi-language: EN-GB">If I can, which file(s) and =
functions do I=20
  have to modify?</SPAN></P>
  <P class=3DMsoNormal style=3D"MARGIN: 0cm 0cm 0pt"><SPAN lang=3DEN-GB=20
  style=3D"mso-ansi-language: EN-GB">Thanks in =
advance.<o:p></o:p></SPAN></P>
  <P class=3DMsoNormal style=3D"MARGIN: 0cm 0cm 0pt"><SPAN lang=3DEN-GB=20
  style=3D"mso-ansi-language: EN-GB">&nbsp;<o:p></o:p></SPAN></P>
  <P class=3DMsoNormal style=3D"MARGIN: 0cm 0cm 0pt"><SPAN lang=3DEN-GB=20
  style=3D"mso-ansi-language: EN-GB">Best =
regards.<o:p></o:p></SPAN></P><SPAN=20
  lang=3DEN-GB=20
  style=3D"FONT-SIZE: 12pt; FONT-FAMILY: 'Times New Roman'; =
mso-ansi-language: EN-GB; mso-fareast-font-family: 'Times New Roman'; =
mso-fareast-language: IT; mso-bidi-language: =
AR-SA">Jers</SPAN></DIV></BLOCKQUOTE><BR><DIV style=3D"HEIGHT: 50px; =
WIDTH: 240px"><MARQUEE behavior=3Dslide direction=3Ddown id=3DMarquee1 =
loop=3D1 scrollAmount=3D1 scrollDelay=3D20 style=3D"HEIGHT: 57px; WIDTH: =
300px" trueSpeed border=3D"2"><FONT =
size=3D1>____________________________________________</FONT></MARQUEE><BR=
><FONT color=3D#000066 face=3D"Verdana, Arial, Helvetica, sans-serif" =
size=3D2><B>Halam Rose</B></FONT><I><B><FONT color=3D#000066 =
face=3DArial size=3D2><BR></FONT></B></I><MARQUEE behavior=3Dslide =
id=3DMarquee3 loop=3D1 scrollAmount=3D1 scrollDelay=3D3 =
style=3D"FONT-SIZE: 10pt; HEIGHT: 17px; WIDTH: 220px" trueSpeed =
border=3D"0"><FONT color=3Dblack face=3DVerdana size=3D2>Bluetooth =
Specialist</FONT></MARQUEE><BR><MARQUEE behavior=3Dslide =
direction=3Dright id=3DMarquee3 loop=3D1 scrollAmount=3D1 =
scrollDelay=3D3 style=3D"FONT-SIZE: 10pt; HEIGHT: 17px; WIDTH: 220px" =
trueSpeed border=3D"0"><FONT color=3Dblack face=3DVerdana size=3D1>Tel: =
+44 (0)1763 262524 </FONT></MARQUEE><BR><MARQUEE behavior=3Dslide =
direction=3Dright id=3DMarquee3 loop=3D1 scrollAmount=3D2 =
scrollDelay=3D5 style=3D"FONT-SIZE: 10pt; HEIGHT: 17px; WIDTH: 220px" =
trueSpeed border=3D"0"><FONT color=3Dblack face=3DVerdana size=3D1>Fax: =
+44 (0)1763 261177 <BR></FONT></MARQUEE><MARQUEE behavior=3Dslide =
direction=3Dright id=3DMarquee3 loop=3D1 scrollAmount=3D3 =
scrollDelay=3D5 style=3D"FONT-SIZE: 10pt; HEIGHT: 17px; WIDTH: 220px" =
trueSpeed border=3D"0"><FONT color=3Dblack =
size=3D1><BR></FONT></MARQUEE><MARQUEE behavior=3Dslide =
direction=3Dright id=3DMarquee3 loop=3D1 scrollAmount=3D4 =
scrollDelay=3D5 style=3D"FONT-SIZE: 10pt; HEIGHT: 17px; WIDTH: 220px" =
trueSpeed border=3D"0"><FONT color=3Dblack face=3DVerdana size=3D1><A =
href=3D"mailto:Halam.Rose@7layers-uk.com">Halam.Rose@7layers-uk.com</A></=
FONT></MARQUEE><BR><MARQUEE behavior=3Dslide direction=3Dright =
id=3DMarquee3 loop=3D1 scrollAmount=3D4 scrollDelay=3D5 =
style=3D"FONT-SIZE: 10pt; HEIGHT: 17px; WIDTH: 220px" trueSpeed =
border=3D"0"><FONT color=3Dblack face=3DVerdana size=3D1><A =
href=3D"http://www.7layers-uk.com/">www.7layers-UK.com =
</A></FONT></MARQUEE><BR><BR></FONT><TABLE bgColor=3D#000066 =
cellPadding=3D0 cellSpacing=3D1 width=3D228><TBODY><TR><TD =
align=3Dmiddle bgColor=3D#000096 vAlign=3Dcenter width=3D222><B><FONT =
color=3D#ffffff face=3D"Verdana, Arial, Helvetica, sans-serif" =
size=3D3>&nbsp;7 layers UK</FONT></B></TD></TR><TR bgColor=3D#efefea><TD =
align=3Dmiddle vAlign=3Dcenter width=3D222><FONT color=3D#000096 =
face=3D"Verdana, Arial, Helvetica, sans-serif" size=3D1><B>Melbourn =
Science Park<BR></B></FONT><FONT color=3D#666666 face=3D"Verdana, Arial, =
Helvetica, sans-serif" size=3D1>Cambridge =
Road<BR>Melbourn<BR>Hertfordshire SG8 =
6HB</FONT></TD></TR></TBODY></TABLE></DIV><DIV><FONT face=3DVerdana =
size=3D1><STRONG>7 layers looks forward to seeing you: <BR>CTIA Wireless =
2004 <BR>22 - 24 March 2004 <BR>Atlanta, GA, USA <BR>7 layers Booth 763, =
Hall B1 </STRONG></FONT></DIV><DIV><STRONG><FONT face=3DVerdana =
size=3D2></FONT></STRONG>&nbsp;</DIV><DIV><FONT face=3D"Verdana, Arial, =
Helvetica, sans-serif" =
size=3D1>----------------------------------------------------------------=
-------------------------------------------------------------------------=
---------<BR><FONT color=3Dgray face=3DVerdana size=3D1><SPAN =
style=3D"COLOR: gray; FONT-FAMILY: Verdana; FONT-SIZE: 7.5pt">Disclaimer =
- 27/02/2004</SPAN></FONT></FONT></DIV><DIV><FONT face=3D"Verdana, =
Arial, Helvetica, sans-serif" size=3D1><FONT color=3Dgray face=3DVerdana =
size=3D1><SPAN style=3D"COLOR: gray; FONT-FAMILY: Verdana; FONT-SIZE: =
7.5pt"></SPAN></FONT></FONT>&nbsp;</DIV><DIV><FONT face=3D"Verdana, =
Arial, Helvetica, sans-serif" size=3D1>This communication is from <B>7 =
Layers UK Ltd</B>., Melbourn Science Park, Cambridge Road, Melbourn, =
Hertfordshire SG8 6HB, England.<BR>This email (including any =
attachments) is intended only for <B>Jers, =
bluez-devel@lists.sourceforge.net</B>. It may contain confidential or =
privileged<BR>information. If you are not the intended recipient, please =
do not read, distribute, copy or otherwise use this communication =
or<BR>the information in it. Any views or opinions expressed in this =
email may be solely those of the author and are not necessarily<BR>those =
of 7 Layers UK Ltd. WARNING: Although 7 Layers UK Ltd have taken all =
reasonable precautions to ensure that viruses<BR>are not present in this =
email, the company can accept no responsibility for any loss of data =
arising from the use of this email<BR>or its attachments. If you have =
received this communication in error, please notify us by email =
(postmaster@7layers-UK.com)<BR>or by telephone +44 (0) 1763 262524 and =
then delete the email and any copies of =
it.<BR>------------------------------------------------------------------=
-------------------------------------------------------------------------=
-------</FONT></DIV><FONT face=3D"Verdana, Arial, Helvetica, sans-serif" =
size=3D1><DIV></DIV></FONT><DIV>&nbsp;</DIV></BODY></HTML>

------_=_NextPart_001_01C3FD1D.D32F2BCE--


-------------------------------------------------------
SF.Net is sponsored by: Speed Start Your Linux Apps Now.
Build and deploy apps & Web services for Linux with
a free DVD software kit from IBM. Click Now!
http://ads.osdn.com/?ad_id=1356&alloc_id=3438&op=click
_______________________________________________
Bluez-devel mailing list
Bluez-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-devel
