Return-Path: <bluez-devel-admin@lists.sourceforge.net>
Message-ID: <001501c3fd1d$019840a0$6b821d97@userpc>
From: "Jers" <jers@inwind.it>
To: <bluez-devel@lists.sourceforge.net>
MIME-Version: 1.0
Content-Type: multipart/alternative;
	boundary="----=_NextPart_000_0012_01C3FD25.5F1FC240"
Subject: [Bluez-devel] Parameters of the Bluetooth standard in BlueZ...
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
Date: Fri, 27 Feb 2004 11:32:23 +0100

This is a multi-part message in MIME format.

------=_NextPart_000_0012_01C3FD25.5F1FC240
Content-Type: text/plain;
	charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable

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
------=_NextPart_000_0012_01C3FD25.5F1FC240
Content-Type: text/html;
	charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable

<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.0 Transitional//EN">
<HTML xmlns:o =3D "urn:schemas-microsoft-com:office:office"><HEAD>
<META http-equiv=3DContent-Type content=3D"text/html; =
charset=3Diso-8859-1">
<META content=3D"MSHTML 6.00.2800.1106" name=3DGENERATOR>
<STYLE></STYLE>
</HEAD>
<BODY bgColor=3D#ffffff>
<DIV>
<P class=3DMsoNormal style=3D"MARGIN: 0cm 0cm 0pt"><SPAN lang=3DEN-GB=20
style=3D"mso-ansi-language: EN-GB">Dear all,<o:p></o:p></SPAN></P>
<P class=3DMsoNormal style=3D"MARGIN: 0cm 0cm 0pt"><SPAN lang=3DEN-GB=20
style=3D"mso-ansi-language: EN-GB">&nbsp;<o:p></o:p></SPAN></P>
<P class=3DMsoNormal style=3D"MARGIN: 0cm 0cm 0pt"><SPAN lang=3DEN-GB=20
style=3D"mso-ansi-language: EN-GB">I=92m not a developer but I need your =

help!<o:p></o:p></SPAN></P>
<P class=3DMsoNormal style=3D"MARGIN: 0cm 0cm 0pt"><SPAN lang=3DEN-GB=20
style=3D"mso-ansi-language: EN-GB">At the moment I=92m carrying out a =
study about=20
Bluetooth standard. In this study I modified some parameters of Inquiry =
and=20
Inquiry Scan procedures. Now I want to test my analytical results by =
real=20
experiments. I=92d like to evaluate the discovery performances of two =
bluetooth=20
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
Inquiry Scan=20
procedure:<o:p></o:p></SPAN></P>
<P class=3DMsoNormal=20
style=3D"MARGIN: 0cm 0cm 0pt 54pt; TEXT-INDENT: -18pt; mso-list: l0 =
level2 lfo1; tab-stops: list 54.0pt"><SPAN=20
lang=3DEN-GB=20
style=3D"FONT-FAMILY: 'Courier New'; mso-ansi-language: EN-GB; =
mso-bidi-font-family: 'Times New Roman'">o<SPAN=20
style=3D"FONT: 7pt 'Times New =
Roman'">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=20
</SPAN></SPAN><SPAN lang=3DEN-GB style=3D"mso-ansi-language: EN-GB">Time =
spent in Rx=20
(&gt;=3D16*Tslot, according to the standard)<o:p></o:p></SPAN></P>
<P class=3DMsoNormal=20
style=3D"MARGIN: 0cm 0cm 0pt 54pt; TEXT-INDENT: -18pt; mso-list: l0 =
level2 lfo1; tab-stops: list 54.0pt"><SPAN=20
lang=3DEN-GB=20
style=3D"FONT-FAMILY: 'Courier New'; mso-ansi-language: EN-GB; =
mso-bidi-font-family: 'Times New Roman'">o<SPAN=20
style=3D"FONT: 7pt 'Times New =
Roman'">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=20
</SPAN></SPAN><SPAN lang=3DEN-GB style=3D"mso-ansi-language: EN-GB">The =
period=20
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
</SPAN></SPAN><SPAN lang=3DEN-GB style=3D"mso-ansi-language: EN-GB">The =
period=20
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
style=3D"mso-ansi-language: EN-GB">I suppose I can set these parameters =
by BlueZ,=20
so I looked for lines that manage them in all BlueZ files but I didn=92t =
find.=20
<o:p></o:p></SPAN></P>
<P class=3DMsoNormal style=3D"MARGIN: 0cm 0cm 0pt"><SPAN lang=3DEN-GB=20
style=3D"mso-ansi-language: EN-GB">&nbsp;<o:p></o:p></SPAN></P>
<P class=3DMsoNormal style=3D"MARGIN: 0cm 0cm 0pt"><SPAN lang=3DEN-GB=20
style=3D"mso-ansi-language: EN-GB">Can I change these parameters in=20
BlueZ?<o:p></o:p></SPAN></P>
<P class=3DMsoNormal style=3D"MARGIN: 0cm 0cm 0pt"><SPAN lang=3DEN-GB=20
style=3D"mso-ansi-language: EN-GB">If I can, which file(s) and functions =
do I have=20
to modify?</SPAN></P>
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
AR-SA">Jers</SPAN></DIV></BODY></HTML>

------=_NextPart_000_0012_01C3FD25.5F1FC240--



-------------------------------------------------------
SF.Net is sponsored by: Speed Start Your Linux Apps Now.
Build and deploy apps & Web services for Linux with
a free DVD software kit from IBM. Click Now!
http://ads.osdn.com/?ad_id=1356&alloc_id=3438&op=click
_______________________________________________
Bluez-devel mailing list
Bluez-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-devel
