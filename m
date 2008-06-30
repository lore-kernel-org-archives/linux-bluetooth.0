Return-Path: <cyrus@holtmann.org>
Date: Mon, 30 Jun 2008 15:08:54 +0900
From: Chan-Yeol Park <chanyeol.park@samsung.com>
To: bluez-devel@lists.sourceforge.net
Message-id: <004b01c8da77$c65e95b0$531bc110$%park@samsung.com>
MIME-version: 1.0
Content-type: multipart/mixed; boundary="Boundary_(ID_YTe6OKr+OQXIJomNBFbb0Q)"
Subject: [Bluez-devel] bccmd(csr_bcsp.c) bug Report
Reply-To: BlueZ development <bluez-devel@lists.sourceforge.net>
List-Id: BlueZ development <bluez-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-devel>,
	<mailto:bluez-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=bluez-devel>
List-Post: <mailto:bluez-devel@lists.sourceforge.net>
List-Help: <mailto:bluez-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-devel>,
	<mailto:bluez-devel-request@lists.sourceforge.net?subject=subscribe>
Sender: bluez-devel-bounces@lists.sourceforge.net
Errors-To: bluez-devel-bounces@lists.sourceforge.net

여러 부분으로 구성된 MIME 형식의 메시지입니다.

--Boundary_(ID_YTe6OKr+OQXIJomNBFbb0Q)
Content-type: multipart/alternative;
	boundary="Boundary_(ID_8r+R5ybTWrCmmxtWvfFnrw)"


--Boundary_(ID_8r+R5ybTWrCmmxtWvfFnrw)
Content-type: text/plain; charset=ks_c_5601-1987
Content-transfer-encoding: quoted-printable

Dear all

=20

Recently I found the bccmd bug.

=20

I think that do_command function (csr_bcsp.c) could have a problem=20

if we receive both UBCSP_PACKET_SENT and UBCSP_PACKET_RECEIVED
simultaneously from ubcsp_poll function.

=20

An expected scenario is that UBCSP_PACKET_SENT comes earlier than
UBCSP_PACKET_RECEIVED.

But if we get them at the same time this could be a problem because
=A1=B0sent=3D1=A1=B1 is located after checking =A1=B0sent=3D=3D1=A1=B1.

=20

It means that this program doesn=A1=AFt know UBCSP_PACKET_SENT even if =
we
already receive it.

=20

I there anyone who know this bug?

=20

If you let me know how to check-in code,

I would like to do it!

=20

Regards.

	=09

Chan-Yeol Park (=B9=DA =C2=F9 =BF=AD)

Engineer

=20

Mobile S/W Platform Lab.=20

Telecommunication R&D Center

SAMSUNG ELECTRONICS CO., LTD.


--Boundary_(ID_8r+R5ybTWrCmmxtWvfFnrw)
Content-type: text/html; charset=ks_c_5601-1987
Content-transfer-encoding: quoted-printable

<html xmlns:v=3D"urn:schemas-microsoft-com:vml" =
xmlns:o=3D"urn:schemas-microsoft-com:office:office" =
xmlns:w=3D"urn:schemas-microsoft-com:office:word" =
xmlns:m=3D"http://schemas.microsoft.com/office/2004/12/omml" =
xmlns=3D"http://www.w3.org/TR/REC-html40">

<head>
<meta http-equiv=3DContent-Type content=3D"text/html; =
charset=3Dks_c_5601-1987">
<meta name=3DGenerator content=3D"Microsoft Word 12 (filtered medium)">
<style>
<!--
 /* Font Definitions */
 @font-face
	{font-family:=B1=BC=B8=B2;
	panose-1:2 11 6 0 0 1 1 1 1 1;}
@font-face
	{font-family:"Cambria Math";
	panose-1:2 4 5 3 5 4 6 3 2 4;}
@font-face
	{font-family:"=B8=BC=C0=BA =B0=ED=B5=F1";
	panose-1:2 11 5 3 2 0 0 2 0 4;}
@font-face
	{font-family:=B1=BC=B8=B2=C3=BC;
	panose-1:2 11 6 9 0 1 1 1 1 1;}
@font-face
	{font-family:"\@=B1=BC=B8=B2";
	panose-1:2 11 6 0 0 1 1 1 1 1;}
@font-face
	{font-family:"\@=B8=BC=C0=BA =B0=ED=B5=F1";
	panose-1:2 11 5 3 2 0 0 2 0 4;}
@font-face
	{font-family:Verdana;
	panose-1:2 11 6 4 3 5 4 4 2 4;}
@font-face
	{font-family:"\@=B1=BC=B8=B2=C3=BC";
	panose-1:2 11 6 9 0 1 1 1 1 1;}
 /* Style Definitions */
 p.MsoNormal, li.MsoNormal, div.MsoNormal
	{margin:0cm;
	margin-bottom:.0001pt;
	text-align:justify;
	text-justify:inter-ideograph;
	text-autospace:none;
	word-break:break-hangul;
	font-size:10.0pt;
	font-family:"=B8=BC=C0=BA =B0=ED=B5=F1";}
a:link, span.MsoHyperlink
	{mso-style-priority:99;
	color:blue;
	text-decoration:underline;}
a:visited, span.MsoHyperlinkFollowed
	{mso-style-priority:99;
	color:purple;
	text-decoration:underline;}
span.EmailStyle17
	{mso-style-type:personal;
	font-family:"=B8=BC=C0=BA =B0=ED=B5=F1";
	color:windowtext;}
span.EmailStyle18
	{mso-style-type:personal;
	font-family:"=B8=BC=C0=BA =B0=ED=B5=F1";
	color:#1F497D;}
span.EmailStyle19
	{mso-style-type:personal;
	font-family:"=B8=BC=C0=BA =B0=ED=B5=F1";
	color:#1F497D;}
span.EmailStyle20
	{mso-style-type:personal-reply;
	font-family:"=B8=BC=C0=BA =B0=ED=B5=F1";
	color:#1F497D;}
.MsoChpDefault
	{mso-style-type:export-only;}
@page Section1
	{size:612.0pt 792.0pt;
	margin:3.0cm 72.0pt 72.0pt 72.0pt;}
div.Section1
	{page:Section1;}
-->
</style>
<!--[if gte mso 9]><xml>
 <o:shapedefaults v:ext=3D"edit" spidmax=3D"1026" />
</xml><![endif]--><!--[if gte mso 9]><xml>
 <o:shapelayout v:ext=3D"edit">
  <o:idmap v:ext=3D"edit" data=3D"1" />
 </o:shapelayout></xml><![endif]-->
</head>

<body lang=3DKO link=3Dblue vlink=3Dpurple>

<div class=3DSection1>

<p class=3DMsoNormal><span lang=3DEN-US>Dear all<o:p></o:p></span></p>

<p class=3DMsoNormal><span lang=3DEN-US><o:p>&nbsp;</o:p></span></p>

<p class=3DMsoNormal><span lang=3DEN-US>Recently I found the bccmd =
bug.<o:p></o:p></span></p>

<p class=3DMsoNormal><span lang=3DEN-US><o:p>&nbsp;</o:p></span></p>

<p class=3DMsoNormal><span lang=3DEN-US>I think that do_command function
(csr_bcsp.c) could have a problem <o:p></o:p></span></p>

<p class=3DMsoNormal><span lang=3DEN-US>if we receive both =
UBCSP_PACKET_SENT and
UBCSP_PACKET_RECEIVED simultaneously from ubcsp_poll =
function.<o:p></o:p></span></p>

<p class=3DMsoNormal><span lang=3DEN-US><o:p>&nbsp;</o:p></span></p>

<p class=3DMsoNormal><span lang=3DEN-US>An expected scenario is that
UBCSP_PACKET_SENT comes earlier than =
UBCSP_PACKET_RECEIVED.<o:p></o:p></span></p>

<p class=3DMsoNormal><span lang=3DEN-US>But if we get them at the same =
time this
could be a problem because </span>=A1=B0<span =
lang=3DEN-US>sent=3D1</span>=A1=B1<span
lang=3DEN-US> is located after checking </span>=A1=B0<span =
lang=3DEN-US>sent=3D=3D1</span>=A1=B1<span
lang=3DEN-US>.<o:p></o:p></span></p>

<p class=3DMsoNormal><span lang=3DEN-US><o:p>&nbsp;</o:p></span></p>

<p class=3DMsoNormal><span lang=3DEN-US>It means that this program =
doesn</span>=A1=AF<span
lang=3DEN-US>t know UBCSP_PACKET_SENT even if we already receive =
it.<o:p></o:p></span></p>

<p class=3DMsoNormal><span lang=3DEN-US>&nbsp;<o:p></o:p></span></p>

<p class=3DMsoNormal><span lang=3DEN-US>I there anyone who know this =
bug?<o:p></o:p></span></p>

<p class=3DMsoNormal><span lang=3DEN-US><o:p>&nbsp;</o:p></span></p>

<p class=3DMsoNormal><span lang=3DEN-US>If you let me know how to =
check-in code,<o:p></o:p></span></p>

<p class=3DMsoNormal><span lang=3DEN-US>I would like to do =
it!<o:p></o:p></span></p>

<p class=3DMsoNormal><span lang=3DEN-US><o:p>&nbsp;</o:p></span></p>

<p class=3DMsoNormal><span lang=3DEN-US>Regards.<o:p></o:p></span></p>

<table class=3DMsoNormalTable border=3D0 cellspacing=3D0 cellpadding=3D0 =
width=3D355
 style=3D'width:266.25pt;border-collapse:collapse'>
 <tr>
  <td width=3D39 style=3D'width:29.6pt;padding:0cm 0cm 0cm 0cm'></td>
  <td width=3D316 style=3D'width:236.65pt;padding:0cm 0cm 0cm 0cm'></td>
 </tr>
</table>

<p class=3DMsoNormal align=3Dleft =
style=3D'mso-margin-top-alt:3.75pt;margin-right:
0cm;margin-bottom:3.75pt;margin-left:0cm;text-align:left;text-autospace:i=
deograph-other;
word-break:keep-all'><b><span lang=3DEN-US =
style=3D'font-size:9.0pt;font-family:
=B1=BC=B8=B2=C3=BC'>Chan-Yeol Park </span></b><b><span lang=3DEN-US =
style=3D'font-family:=B1=BC=B8=B2=C3=BC;
color:gray'>(</span></b><b><span =
style=3D'font-family:=B1=BC=B8=B2=C3=BC;color:gray'>=B9=DA =C2=F9 =
=BF=AD<span
lang=3DEN-US>)</span></span></b><span lang=3DEN-US =
style=3D'font-size:9.0pt;
font-family:=B1=BC=B8=B2=C3=BC'><o:p></o:p></span></p>

<p class=3DMsoNormal align=3Dleft =
style=3D'mso-margin-top-alt:3.75pt;margin-right:
0cm;margin-bottom:3.75pt;margin-left:0cm;text-align:left;text-autospace:i=
deograph-other;
word-break:keep-all'><span lang=3DEN-US =
style=3D'font-size:9.0pt;font-family:=B1=BC=B8=B2=C3=BC;
color:gray'>Engineer</span><span lang=3DEN-US =
style=3D'font-size:9.0pt;font-family:
=B1=BC=B8=B2=C3=BC'><o:p></o:p></span></p>

<p class=3DMsoNormal align=3Dleft =
style=3D'text-align:left;text-autospace:ideograph-other;
word-break:keep-all'><span lang=3DEN-US =
style=3D'font-size:9.0pt;font-family:=B1=BC=B8=B2=C3=BC'><o:p>&nbsp;</o:p=
></span></p>

<p class=3DMsoNormal align=3Dleft =
style=3D'mso-margin-top-alt:3.75pt;margin-right:
0cm;margin-bottom:3.75pt;margin-left:0cm;text-align:left;text-autospace:i=
deograph-other;
word-break:keep-all'><span lang=3DEN-US =
style=3D'font-size:9.0pt;font-family:"Verdana","sans-serif";
color:#336699'>Mobile S/W Platform Lab.</span><span lang=3DEN-US
style=3D'font-size:9.0pt;font-family:=B1=BC=B8=B2=C3=BC'> =
<o:p></o:p></span></p>

<p class=3DMsoNormal align=3Dleft =
style=3D'mso-margin-top-alt:3.75pt;margin-right:
0cm;margin-bottom:3.75pt;margin-left:0cm;text-align:left;text-autospace:i=
deograph-other;
word-break:keep-all'><span lang=3DEN-US =
style=3D'font-size:9.0pt;font-family:=B1=BC=B8=B2=C3=BC;
color:gray'>Telecommunication R&amp;D Center</span><span lang=3DEN-US
style=3D'font-size:9.0pt;font-family:=B1=BC=B8=B2=C3=BC'><o:p></o:p></spa=
n></p>

<p class=3DMsoNormal align=3Dleft =
style=3D'mso-margin-top-alt:3.75pt;margin-right:
0cm;margin-bottom:3.75pt;margin-left:0cm;text-align:left;text-autospace:i=
deograph-other;
word-break:keep-all'><span lang=3DEN-US =
style=3D'font-size:9.0pt;font-family:=B1=BC=B8=B2=C3=BC;
color:gray'>SAMSUNG ELECTRONICS CO., LTD.</span><span =
lang=3DEN-US><o:p></o:p></span></p>

</div>

</body>

</html>

--Boundary_(ID_8r+R5ybTWrCmmxtWvfFnrw)--

--Boundary_(ID_YTe6OKr+OQXIJomNBFbb0Q)
Content-type: application/octet-stream; name=csr_bcsp_modified.c
Content-transfer-encoding: quoted-printable
Content-disposition: attachment; filename=csr_bcsp_modified.c

static int do_command(uint16_t command, uint16_t seqnum, uint16_t varid, =
uint8_t *value, uint16_t length)=0A=
{=0A=
	unsigned char cp[254], rp[254];=0A=
	uint8_t cmd[10];=0A=
	uint16_t size;=0A=
	uint8_t delay, activity =3D 0x00;=0A=
	int timeout =3D 0, sent =3D 0;=0A=
=0A=
	size =3D (length < 8) ? 9 : ((length + 1) / 2) + 5;=0A=
=0A=
	cmd[0] =3D command & 0xff;=0A=
	cmd[1] =3D command >> 8;=0A=
	cmd[2] =3D size & 0xff;=0A=
	cmd[3] =3D size >> 8;=0A=
	cmd[4] =3D seqnum & 0xff;=0A=
	cmd[5] =3D seqnum >> 8;=0A=
	cmd[6] =3D varid & 0xff;=0A=
	cmd[7] =3D varid >> 8;=0A=
	cmd[8] =3D 0x00;=0A=
	cmd[9] =3D 0x00;=0A=
=0A=
	memset(cp, 0, sizeof(cp));=0A=
	cp[0] =3D 0x00;=0A=
	cp[1] =3D 0xfc;=0A=
	cp[2] =3D (size * 2) + 1;=0A=
	cp[3] =3D 0xc2;=0A=
	memcpy(cp + 4, cmd, sizeof(cmd));=0A=
	memcpy(cp + 14, value, length);=0A=
=0A=
	receive_packet.length =3D 512;=0A=
	ubcsp_receive_packet(&receive_packet);=0A=
=0A=
	send_packet.channel  =3D 5;=0A=
	send_packet.reliable =3D 1;=0A=
	send_packet.length   =3D (size * 2) + 4;=0A=
	memcpy(send_packet.payload, cp, (size * 2) + 4);=0A=
=0A=
	ubcsp_send_packet(&send_packet);=0A=
=0A=
	while (1) {=0A=
		delay =3D ubcsp_poll(&activity);=0A=
=0A=
		if (activity & UBCSP_PACKET_SENT) {=0A=
			switch (varid) {=0A=
			case CSR_VARID_COLD_RESET:=0A=
			case CSR_VARID_WARM_RESET:=0A=
			case CSR_VARID_COLD_HALT:=0A=
			case CSR_VARID_WARM_HALT:=0A=
				return 0;=0A=
			}=0A=
=0A=
			sent =3D 1;=0A=
			timeout =3D 0;=0A=
		}=0A=
=0A=
		if (activity & UBCSP_PACKET_RECEIVED) {=0A=
			if (sent && receive_packet.channel =3D=3D 5 &&=0A=
					receive_packet.payload[0] =3D=3D 0xff) {=0A=
				memcpy(rp, receive_packet.payload,=0A=
							receive_packet.length);=0A=
				break;=0A=
			}=0A=
=0A=
			receive_packet.length =3D 512;=0A=
			ubcsp_receive_packet(&receive_packet);=0A=
			timeout =3D 0;=0A=
		}=0A=
=0A=
		if (delay) {=0A=
			usleep(delay * 100);=0A=
=0A=
			if (timeout++ > 100) {=0A=
				fprintf(stderr, "Operation timed out\n");=0A=
				return -1;=0A=
			}=0A=
		}=0A=
	}=0A=
=0A=
	if (rp[0] !=3D 0xff || rp[2] !=3D 0xc2) {=0A=
		errno =3D EIO;=0A=
		return -1;=0A=
	}=0A=
=0A=
	if ((rp[11] + (rp[12] << 8)) !=3D 0) {=0A=
		errno =3D ENXIO;=0A=
		return -1;=0A=
	}=0A=
=0A=
	memcpy(value, rp + 13, length);=0A=
=0A=
	return 0;=0A=
}=0A=

--Boundary_(ID_YTe6OKr+OQXIJomNBFbb0Q)
Content-type: application/octet-stream; name=csr_bcsp_original.c
Content-transfer-encoding: quoted-printable
Content-disposition: attachment; filename=csr_bcsp_original.c

=0A=
static int do_command(uint16_t command, uint16_t seqnum, uint16_t varid, =
uint8_t *value, uint16_t length)=0A=
{=0A=
	unsigned char cp[254], rp[254];=0A=
	uint8_t cmd[10];=0A=
	uint16_t size;=0A=
	uint8_t delay, activity =3D 0x00;=0A=
	int timeout =3D 0, sent =3D 0;=0A=
=0A=
	size =3D (length < 8) ? 9 : ((length + 1) / 2) + 5;=0A=
=0A=
	cmd[0] =3D command & 0xff;=0A=
	cmd[1] =3D command >> 8;=0A=
	cmd[2] =3D size & 0xff;=0A=
	cmd[3] =3D size >> 8;=0A=
	cmd[4] =3D seqnum & 0xff;=0A=
	cmd[5] =3D seqnum >> 8;=0A=
	cmd[6] =3D varid & 0xff;=0A=
	cmd[7] =3D varid >> 8;=0A=
	cmd[8] =3D 0x00;=0A=
	cmd[9] =3D 0x00;=0A=
=0A=
	memset(cp, 0, sizeof(cp));=0A=
	cp[0] =3D 0x00;=0A=
	cp[1] =3D 0xfc;=0A=
	cp[2] =3D (size * 2) + 1;=0A=
	cp[3] =3D 0xc2;=0A=
	memcpy(cp + 4, cmd, sizeof(cmd));=0A=
	memcpy(cp + 14, value, length);=0A=
=0A=
	receive_packet.length =3D 512;=0A=
	ubcsp_receive_packet(&receive_packet);=0A=
=0A=
	send_packet.channel  =3D 5;=0A=
	send_packet.reliable =3D 1;=0A=
	send_packet.length   =3D (size * 2) + 4;=0A=
	memcpy(send_packet.payload, cp, (size * 2) + 4);=0A=
=0A=
	ubcsp_send_packet(&send_packet);=0A=
=0A=
	while (1) {=0A=
		delay =3D ubcsp_poll(&activity);=0A=
=0A=
		if (activity & UBCSP_PACKET_RECEIVED) {=0A=
			if (sent && receive_packet.channel =3D=3D 5 &&=0A=
					receive_packet.payload[0] =3D=3D 0xff) {=0A=
				memcpy(rp, receive_packet.payload,=0A=
							receive_packet.length);=0A=
				break;=0A=
			}=0A=
=0A=
			receive_packet.length =3D 512;=0A=
			ubcsp_receive_packet(&receive_packet);=0A=
			timeout =3D 0;=0A=
		}=0A=
=0A=
		if (activity & UBCSP_PACKET_SENT) {=0A=
			switch (varid) {=0A=
			case CSR_VARID_COLD_RESET:=0A=
			case CSR_VARID_WARM_RESET:=0A=
			case CSR_VARID_COLD_HALT:=0A=
			case CSR_VARID_WARM_HALT:=0A=
				return 0;=0A=
			}=0A=
=0A=
			sent =3D 1;=0A=
			timeout =3D 0;=0A=
		}=0A=
=0A=
		if (delay) {=0A=
			usleep(delay * 100);=0A=
=0A=
			if (timeout++ > 100) {=0A=
				fprintf(stderr, "Operation timed out\n");=0A=
				return -1;=0A=
			}=0A=
		}=0A=
	}=0A=
=0A=
	if (rp[0] !=3D 0xff || rp[2] !=3D 0xc2) {=0A=
		errno =3D EIO;=0A=
		return -1;=0A=
	}=0A=
=0A=
	if ((rp[11] + (rp[12] << 8)) !=3D 0) {=0A=
		errno =3D ENXIO;=0A=
		return -1;=0A=
	}=0A=
=0A=
	memcpy(value, rp + 13, length);=0A=
=0A=
	return 0;=0A=
}=0A=

--Boundary_(ID_YTe6OKr+OQXIJomNBFbb0Q)
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

-------------------------------------------------------------------------
Check out the new SourceForge.net Marketplace.
It's the best place to buy or sell services for
just about anything Open Source.
http://sourceforge.net/services/buy/index.php
--Boundary_(ID_YTe6OKr+OQXIJomNBFbb0Q)
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Bluez-devel mailing list
Bluez-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-devel

--Boundary_(ID_YTe6OKr+OQXIJomNBFbb0Q)--
