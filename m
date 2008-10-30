Return-Path: <cyrus@holtmann.org>
From: "Christian Hoene" <hoene@uni-tuebingen.de>
To: "'Frans de Bont'" <frans.de.bont@philips.com>
Date: Thu, 30 Oct 2008 15:54:38 +0100
Message-ID: <001d01c93a9f$6f2c8710$4d859530$@de>
MIME-Version: 1.0
Content-Type: multipart/mixed;
	boundary="----=_NextPart_000_001E_01C93AA7.D0F11620"
Cc: 'BlueZ development' <bluez-devel@lists.sourceforge.net>
Subject: [Bluez-devel] FW: REALLY Bad encoding performance of Linux SBC
	audio codec
Reply-To: BlueZ development <bluez-devel@lists.sourceforge.net>
List-Id: BlueZ development <bluez-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-devel>,
	<mailto:bluez-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=bluez-devel>
List-Post: <mailto:bluez-devel@lists.sourceforge.net>
List-Help: <mailto:bluez-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-devel>,
	<mailto:bluez-devel-request@lists.sourceforge.net?subject=subscribe>
Errors-To: bluez-devel-bounces@lists.sourceforge.net

Dies ist eine mehrteilige Nachricht im MIME-Format.

------=_NextPart_000_001E_01C93AA7.D0F11620
Content-Type: multipart/alternative;
	boundary="----=_NextPart_001_001F_01C93AA7.D0F11620"


------=_NextPart_001_001F_01C93AA7.D0F11620
Content-Type: text/plain;
	charset="us-ascii"
Content-Transfer-Encoding: 7bit

Hello Frans,

 

thank you for the patch!!

 

Christian

 

 

From: Frans de Bont [mailto:frans.de.bont@philips.com] 
Sent: Thursday, October 30, 2008 2:34 PM
To: Christian Hoene
Subject: RE: [Bluez-devel] REALLY Bad encoding performance of Linux SBC
audio codec

 


Hello Christian, 

I had a quick look into the bluez sbc decoder test application. 
I discovered that the buffering was not correct. 
Attached a modified version. 

Please note that the output level of the decoder is still 6 dB too low. 
This wouldn't be too difficult to fix for the bluez developers. 

Best regards, 
Frans 










"Christian Hoene" <hoene@uni-tuebingen.de> 

2008-10-29 04:30 PM 


To

"'BlueZ development'" <bluez-devel@lists.sourceforge.net> 


cc

Frans de Bont/EHV/APPTECH/PHILIPS@PHILIPS 


Subject

RE: [Bluez-devel] REALLY Bad encoding performance of Linux SBC         audio
codec 


Classification

	

 

		




Hello,

Sorry Bad news. 
the encoding and decodng performance of bluez's SBC is really bad. 
I just used the latest sbcenc program from bluez-4.17 and compared it to the
reference

Attached you will find wav-files encoded with the Bluetooth reference
implementation and bluez

Filelist
========
compare.sh                         is the scrip that I use to compare both
codec
versions
refsop01.wav        the original sample
tmp.ref.sbc         with reference encoded
tmp.bluez.sbc       with bluez encoded
tmp.ref.sw.wav      with reference encoded and decoded (has good quality)
tmp.bluez.sw.wav    with bluez encoded and decoded (has bad quality ODG=)
tmp.refbluez.sw.wav with reference encoded and with bluez decoded (has bad
quality)
tmp.bluezref.sw.wav with bluez encoded and with reference decoded (has
medium quality)

Both the bluez encoder and decoder do not work as good as the reference
implementation.

I also conducted some perceptual audio tests with ITU BS.1387 (PEAQ), which
confirm these results.

With best regards,

Christian

PS:
Attached also an enhanced version for sbc/sbcenc.c, which considers more
command line options.



> -----Original Message-----
> From: Marcel Holtmann [mailto:marcel@holtmann.org]
> Sent: Monday, October 27, 2008 8:42 PM
> To: BlueZ development
> Subject: Re: [Bluez-devel] Bad encoding performance of Linux SBC audio
> codec
> 
> Hi Brad,
> 
> > > I am sorry to say that the audio quality of the open source version
> of SBC
> > > is far worse than the reference implementation.
> >
> > If you are using the standalone "sbc" project at sourceforge, then
> you
> > should try the version inside bluez. The standalone used to simply be
> > slower, but we identified & fixed some quality issues too that should
> > be backported.
> 
> the standalone version should not be used at all at the moment. All
> efforts should go into the version included in bluez-4.x.tar.gz.
> 
> Regards
> 
> Marcel
> 
> 
> 
> -----------------------------------------------------------------------
> --
> This SF.Net email is sponsored by the Moblin Your Move Developer's
> challenge
> Build the coolest Linux based applications with Moblin SDK & win great
> prizes
> Grand prize is a trip for two to an Open Source event anywhere in the
> world
> http://moblin-contest.org/redirect.php?banner_id=100&url=/
> _______________________________________________
> Bluez-devel mailing list
> Bluez-devel@lists.sourceforge.net
> https://lists.sourceforge.net/lists/listinfo/bluez-devel
[attachment "sbcenc.c" deleted by Frans de Bont/EHV/APPTECH/PHILIPS]
[attachment "compare.tar.gz" deleted by Frans de Bont/EHV/APPTECH/PHILIPS] 


------=_NextPart_001_001F_01C93AA7.D0F11620
Content-Type: text/html;
	charset="us-ascii"
Content-Transfer-Encoding: quoted-printable

<html xmlns:v=3D"urn:schemas-microsoft-com:vml" =
xmlns:o=3D"urn:schemas-microsoft-com:office:office" =
xmlns:w=3D"urn:schemas-microsoft-com:office:word" =
xmlns:m=3D"http://schemas.microsoft.com/office/2004/12/omml" =
xmlns=3D"http://www.w3.org/TR/REC-html40">

<head>
<meta http-equiv=3DContent-Type content=3D"text/html; =
charset=3Dus-ascii">
<meta name=3DGenerator content=3D"Microsoft Word 12 (filtered medium)">
<style>
<!--
 /* Font Definitions */
 @font-face
	{font-family:"Cambria Math";
	panose-1:2 4 5 3 5 4 6 3 2 4;}
@font-face
	{font-family:Calibri;
	panose-1:2 15 5 2 2 2 4 3 2 4;}
@font-face
	{font-family:Tahoma;
	panose-1:2 11 6 4 3 5 4 4 2 4;}
 /* Style Definitions */
 p.MsoNormal, li.MsoNormal, div.MsoNormal
	{margin:0cm;
	margin-bottom:.0001pt;
	font-size:12.0pt;
	font-family:"Times New Roman","serif";}
a:link, span.MsoHyperlink
	{mso-style-priority:99;
	color:blue;
	text-decoration:underline;}
a:visited, span.MsoHyperlinkFollowed
	{mso-style-priority:99;
	color:purple;
	text-decoration:underline;}
p
	{mso-style-priority:99;
	mso-margin-top-alt:auto;
	margin-right:0cm;
	mso-margin-bottom-alt:auto;
	margin-left:0cm;
	font-size:12.0pt;
	font-family:"Times New Roman","serif";}
tt
	{mso-style-priority:99;
	font-family:"Courier New";}
span.E-MailFormatvorlage19
	{mso-style-type:personal-reply;
	font-family:"Calibri","sans-serif";
	color:#1F497D;}
.MsoChpDefault
	{mso-style-type:export-only;}
@page Section1
	{size:612.0pt 792.0pt;
	margin:70.85pt 70.85pt 2.0cm 70.85pt;}
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

<body lang=3DDE link=3Dblue vlink=3Dpurple>

<div class=3DSection1>

<p class=3DMsoNormal><span =
style=3D'font-size:11.0pt;font-family:"Calibri","sans-serif";
color:#1F497D'>Hello Frans,<o:p></o:p></span></p>

<p class=3DMsoNormal><span =
style=3D'font-size:11.0pt;font-family:"Calibri","sans-serif";
color:#1F497D'><o:p>&nbsp;</o:p></span></p>

<p class=3DMsoNormal><span lang=3DEN-US =
style=3D'font-size:11.0pt;font-family:"Calibri","sans-serif";
color:#1F497D'>thank you for the patch!!<o:p></o:p></span></p>

<p class=3DMsoNormal><span lang=3DEN-US =
style=3D'font-size:11.0pt;font-family:"Calibri","sans-serif";
color:#1F497D'><o:p>&nbsp;</o:p></span></p>

<p class=3DMsoNormal><span lang=3DEN-US =
style=3D'font-size:11.0pt;font-family:"Calibri","sans-serif";
color:#1F497D'>Christian<o:p></o:p></span></p>

<p class=3DMsoNormal><span lang=3DEN-US =
style=3D'font-size:11.0pt;font-family:"Calibri","sans-serif";
color:#1F497D'><o:p>&nbsp;</o:p></span></p>

<p class=3DMsoNormal><span =
style=3D'font-size:11.0pt;font-family:"Calibri","sans-serif";
color:#1F497D'><o:p>&nbsp;</o:p></span></p>

<div style=3D'border:none;border-top:solid #B5C4DF 1.0pt;padding:3.0pt =
0cm 0cm 0cm'>

<p class=3DMsoNormal><b><span =
style=3D'font-size:10.0pt;font-family:"Tahoma","sans-serif"'>From:</span>=
</b><span
style=3D'font-size:10.0pt;font-family:"Tahoma","sans-serif"'> Frans de =
Bont
[mailto:frans.de.bont@philips.com] <br>
<b>Sent:</b> Thursday, October 30, 2008 2:34 PM<br>
<b>To:</b> Christian Hoene<br>
<b>Subject:</b> RE: [Bluez-devel] REALLY Bad encoding performance of =
Linux SBC
audio codec<o:p></o:p></span></p>

</div>

<p class=3DMsoNormal><o:p>&nbsp;</o:p></p>

<p class=3DMsoNormal style=3D'margin-bottom:12.0pt'><br>
<span style=3D'font-size:10.0pt;font-family:"Arial","sans-serif"'>Hello
Christian,</span> <br>
<br>
<span style=3D'font-size:10.0pt;font-family:"Arial","sans-serif"'>I had =
a quick
look into the bluez sbc decoder test application.</span> <br>
<span style=3D'font-size:10.0pt;font-family:"Arial","sans-serif"'>I =
discovered
that the buffering was not correct.</span> <br>
<span =
style=3D'font-size:10.0pt;font-family:"Arial","sans-serif"'>Attached a
modified version.</span> <br>
<br>
<span style=3D'font-size:10.0pt;font-family:"Arial","sans-serif"'>Please =
note
that the output level of the decoder is still 6 dB too low.</span> <br>
<span style=3D'font-size:10.0pt;font-family:"Arial","sans-serif"'>This =
wouldn't
be too difficult to fix for the bluez developers.</span> <br>
<br>
<span style=3D'font-size:10.0pt;font-family:"Arial","sans-serif"'>Best =
regards,</span>
<br>
<span =
style=3D'font-size:10.0pt;font-family:"Arial","sans-serif"'>Frans</span> =
<br>
<br>
<br>
<o:p></o:p></p>

<table class=3DMsoNormalTable border=3D0 cellpadding=3D0 width=3D"100%"
 style=3D'width:100.0%'>
 <tr>
  <td width=3D"33%" valign=3Dtop style=3D'width:33.0%;padding:.75pt =
.75pt .75pt .75pt'>
  <p class=3DMsoNormal><br>
  <br>
  <br>
  <br>
  <br>
  <b><span =
style=3D'font-size:7.5pt;font-family:"Arial","sans-serif"'>&quot;Christia=
n
  Hoene&quot; &lt;hoene@uni-tuebingen.de&gt;</span></b><span =
style=3D'font-size:
  7.5pt;font-family:"Arial","sans-serif"'> </span><o:p></o:p></p>
  <p><span =
style=3D'font-size:7.5pt;font-family:"Arial","sans-serif"'>2008-10-29
  04:30 PM</span> <o:p></o:p></p>
  </td>
  <td width=3D"66%" valign=3Dtop style=3D'width:66.0%;padding:.75pt =
.75pt .75pt .75pt'>
  <table class=3DMsoNormalTable border=3D0 cellpadding=3D0 =
width=3D"100%"
   style=3D'width:100.0%'>
   <tr>
    <td valign=3Dtop style=3D'padding:.75pt .75pt .75pt .75pt'>
    <p class=3DMsoNormal align=3Dright style=3D'text-align:right'><span
    =
style=3D'font-size:7.5pt;font-family:"Arial","sans-serif"'>To</span><o:p>=
</o:p></p>
    </td>
    <td valign=3Dtop style=3D'padding:.75pt .75pt .75pt .75pt'>
    <p class=3DMsoNormal><span =
style=3D'font-size:7.5pt;font-family:"Arial","sans-serif"'>&quot;'BlueZ
    development'&quot; &lt;bluez-devel@lists.sourceforge.net&gt;</span> =
<o:p></o:p></p>
    </td>
   </tr>
   <tr>
    <td valign=3Dtop style=3D'padding:.75pt .75pt .75pt .75pt'>
    <p class=3DMsoNormal align=3Dright style=3D'text-align:right'><span
    =
style=3D'font-size:7.5pt;font-family:"Arial","sans-serif"'>cc</span><o:p>=
</o:p></p>
    </td>
    <td valign=3Dtop style=3D'padding:.75pt .75pt .75pt .75pt'>
    <p class=3DMsoNormal><span =
style=3D'font-size:7.5pt;font-family:"Arial","sans-serif"'>Frans
    de Bont/EHV/APPTECH/PHILIPS@PHILIPS</span> <o:p></o:p></p>
    </td>
   </tr>
   <tr>
    <td valign=3Dtop style=3D'padding:.75pt .75pt .75pt .75pt'>
    <p class=3DMsoNormal align=3Dright style=3D'text-align:right'><span
    =
style=3D'font-size:7.5pt;font-family:"Arial","sans-serif"'>Subject</span>=
<o:p></o:p></p>
    </td>
    <td valign=3Dtop style=3D'padding:.75pt .75pt .75pt .75pt'>
    <p class=3DMsoNormal><span =
style=3D'font-size:7.5pt;font-family:"Arial","sans-serif"'>RE:
    [Bluez-devel] REALLY Bad encoding performance of Linux SBC &nbsp; =
&nbsp;
    &nbsp; &nbsp; audio codec</span> <o:p></o:p></p>
    </td>
   </tr>
   <tr>
    <td style=3D'padding:.75pt .75pt .75pt .75pt'>
    <p class=3DMsoNormal align=3Dright style=3D'text-align:right'><span
    =
style=3D'font-size:7.5pt;font-family:"Arial","sans-serif"'>Classification=
</span><o:p></o:p></p>
    </td>
    <td style=3D'padding:.75pt .75pt .75pt .75pt'></td>
   </tr>
  </table>
  <p class=3DMsoNormal><o:p>&nbsp;</o:p></p>
  <table class=3DMsoNormalTable border=3D0 cellpadding=3D0>
   <tr>
    <td valign=3Dtop style=3D'padding:.75pt .75pt .75pt .75pt'></td>
    <td valign=3Dtop style=3D'padding:.75pt .75pt .75pt .75pt'></td>
   </tr>
  </table>
  </td>
 </tr>
</table>

<p class=3DMsoNormal><br>
<br>
<br>
<tt><span style=3D'font-size:10.0pt'>Hello,</span></tt><span =
style=3D'font-size:
10.0pt;font-family:"Courier New"'><br>
<br>
<tt>Sorry Bad news. </tt><br>
<tt>the encoding and decodng performance of bluez's SBC is really bad. =
</tt><br>
<tt>I just used the latest sbcenc program from bluez-4.17 and compared =
it to
the</tt><br>
<tt>reference</tt><br>
<br>
<tt>Attached you will find wav-files encoded with the Bluetooth =
reference</tt><br>
<tt>implementation and bluez</tt><br>
<br>
<tt>Filelist</tt><br>
<tt>=3D=3D=3D=3D=3D=3D=3D=3D</tt><br>
<tt>compare.sh &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; =
&nbsp;
&nbsp; &nbsp; &nbsp; is the scrip that I use to compare both =
codec</tt><br>
<tt>versions</tt><br>
<tt>refsop01.wav &nbsp; &nbsp; &nbsp; &nbsp;the original sample</tt><br>
<tt>tmp.ref.sbc &nbsp; &nbsp; &nbsp; &nbsp; with reference =
encoded</tt><br>
<tt>tmp.bluez.sbc &nbsp; &nbsp; &nbsp; with bluez encoded</tt><br>
<tt>tmp.ref.sw.wav &nbsp; &nbsp; &nbsp;with reference encoded and =
decoded (has
good quality)</tt><br>
<tt>tmp.bluez.sw.wav &nbsp; &nbsp;with bluez encoded and decoded (has =
bad
quality ODG=3D)</tt><br>
<tt>tmp.refbluez.sw.wav with reference encoded and with bluez decoded =
(has bad</tt><br>
<tt>quality)</tt><br>
<tt>tmp.bluezref.sw.wav with bluez encoded and with reference decoded =
(has</tt><br>
<tt>medium quality)</tt><br>
<br>
<tt>Both the bluez encoder and decoder do not work as good as the =
reference</tt><br>
<tt>implementation.</tt><br>
<br>
<tt>I also conducted some perceptual audio tests with ITU BS.1387 =
(PEAQ), which</tt><br>
<tt>confirm these results.</tt><br>
<br>
<tt>With best regards,</tt><br>
<br>
<tt>Christian</tt><br>
<br>
<tt>PS:</tt><br>
<tt>Attached also an enhanced version for sbc/sbcenc.c, which considers =
more</tt><br>
<tt>command line options.</tt><br>
<br>
<br>
<br>
<tt>&gt; -----Original Message-----</tt><br>
<tt>&gt; From: Marcel Holtmann [mailto:marcel@holtmann.org]</tt><br>
<tt>&gt; Sent: Monday, October 27, 2008 8:42 PM</tt><br>
<tt>&gt; To: BlueZ development</tt><br>
<tt>&gt; Subject: Re: [Bluez-devel] Bad encoding performance of Linux =
SBC audio</tt><br>
<tt>&gt; codec</tt><br>
<tt>&gt; </tt><br>
<tt>&gt; Hi Brad,</tt><br>
<tt>&gt; </tt><br>
<tt>&gt; &gt; &gt; I am sorry to say that the audio quality of the open =
source
version</tt><br>
<tt>&gt; of SBC</tt><br>
<tt>&gt; &gt; &gt; is far worse than the reference =
implementation.</tt><br>
<tt>&gt; &gt;</tt><br>
<tt>&gt; &gt; If you are using the standalone &quot;sbc&quot; project at
sourceforge, then</tt><br>
<tt>&gt; you</tt><br>
<tt>&gt; &gt; should try the version inside bluez. The standalone used =
to
simply be</tt><br>
<tt>&gt; &gt; slower, but we identified &amp; fixed some quality issues =
too
that should</tt><br>
<tt>&gt; &gt; be backported.</tt><br>
<tt>&gt; </tt><br>
<tt>&gt; the standalone version should not be used at all at the moment. =
All</tt><br>
<tt>&gt; efforts should go into the version included in =
bluez-4.x.tar.gz.</tt><br>
<tt>&gt; </tt><br>
<tt>&gt; Regards</tt><br>
<tt>&gt; </tt><br>
<tt>&gt; Marcel</tt><br>
<tt>&gt; </tt><br>
<tt>&gt; </tt><br>
<tt>&gt; </tt><br>
<tt>&gt;
-----------------------------------------------------------------------</=
tt><br>
<tt>&gt; --</tt><br>
<tt>&gt; This SF.Net email is sponsored by the Moblin Your Move =
Developer's</tt><br>
<tt>&gt; challenge</tt><br>
<tt>&gt; Build the coolest Linux based applications with Moblin SDK =
&amp; win
great</tt><br>
<tt>&gt; prizes</tt><br>
<tt>&gt; Grand prize is a trip for two to an Open Source event anywhere =
in the</tt><br>
<tt>&gt; world</tt><br>
<tt>&gt; =
http://moblin-contest.org/redirect.php?banner_id=3D100&amp;url=3D/</tt><b=
r>
<tt>&gt; _______________________________________________</tt><br>
<tt>&gt; Bluez-devel mailing list</tt><br>
<tt>&gt; Bluez-devel@lists.sourceforge.net</tt><br>
<tt>&gt; =
https://lists.sourceforge.net/lists/listinfo/bluez-devel</tt><br>
<tt>[attachment &quot;sbcenc.c&quot; deleted by Frans de
Bont/EHV/APPTECH/PHILIPS] [attachment &quot;compare.tar.gz&quot; deleted =
by
Frans de Bont/EHV/APPTECH/PHILIPS] </tt></span><o:p></o:p></p>

</div>

</body>

</html>

------=_NextPart_001_001F_01C93AA7.D0F11620--

------=_NextPart_000_001E_01C93AA7.D0F11620
Content-Type: application/octet-stream;
	name="sbcdec.c"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: attachment;
	filename="sbcdec.c"

/*=0A=
 *=0A=
 *  Bluetooth low-complexity, subband codec (SBC) decoder=0A=
 *=0A=
 *  Copyright (C) 2004-2008  Marcel Holtmann <marcel@holtmann.org>=0A=
 *=0A=
 *=0A=
 *  This program is free software; you can redistribute it and/or modify=0A=
 *  it under the terms of the GNU General Public License as published by=0A=
 *  the Free Software Foundation; either version 2 of the License, or=0A=
 *  (at your option) any later version.=0A=
 *=0A=
 *  This program is distributed in the hope that it will be useful,=0A=
 *  but WITHOUT ANY WARRANTY; without even the implied warranty of=0A=
 *  MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the=0A=
 *  GNU General Public License for more details.=0A=
 *=0A=
 *  You should have received a copy of the GNU General Public License=0A=
 *  along with this program; if not, write to the Free Software=0A=
 *  Foundation, Inc., 51 Franklin St, Fifth Floor, Boston, MA  =
02110-1301  USA=0A=
 *=0A=
 */=0A=
=0A=
#ifdef HAVE_CONFIG_H=0A=
#include <config.h>=0A=
#endif=0A=
=0A=
#include <stdio.h>=0A=
#include <errno.h>=0A=
#include <fcntl.h>=0A=
#include <unistd.h>=0A=
#include <stdlib.h>=0A=
#include <string.h>=0A=
#include <getopt.h>=0A=
#include <sys/stat.h>=0A=
#include <sys/ioctl.h>=0A=
#include <sys/soundcard.h>=0A=
=0A=
#include "sbc.h"=0A=
#include "formats.h"=0A=
=0A=
#define BUF_SIZE 8192=0A=
=0A=
static void decode(char *filename, char *output, int tofile)=0A=
{=0A=
	unsigned char buf[BUF_SIZE], *stream;=0A=
	struct stat st;=0A=
	off_t filesize;=0A=
	sbc_t sbc;=0A=
	int fd, ad, pos, streamlen, framelen, count, written, len;=0A=
	int format =3D AFMT_S16_BE, frequency, channels;=0A=
=0A=
	if (stat(filename, &st) < 0) {=0A=
		fprintf(stderr, "Can't get size of file %s: %s\n",=0A=
						filename, strerror(errno));=0A=
		return;=0A=
	}=0A=
=0A=
	filesize =3D st.st_size;=0A=
	stream =3D malloc(st.st_size);=0A=
=0A=
	if (!stream) {=0A=
		fprintf(stderr, "Can't allocate memory for %s: %s\n",=0A=
						filename, strerror(errno));=0A=
		return;=0A=
	}=0A=
=0A=
	fd =3D open(filename, O_RDONLY);=0A=
	if (fd < 0) {=0A=
		fprintf(stderr, "Can't open file %s: %s\n",=0A=
						filename, strerror(errno));=0A=
		goto free;=0A=
	}=0A=
=0A=
	if (read(fd, stream, st.st_size) !=3D st.st_size) {=0A=
		fprintf(stderr, "Can't read content of %s: %s\n",=0A=
						filename, strerror(errno));=0A=
		close(fd);=0A=
		goto free;=0A=
	}=0A=
=0A=
	close(fd);=0A=
=0A=
	pos =3D 0;=0A=
	streamlen =3D st.st_size;=0A=
=0A=
	if (tofile)=0A=
		ad =3D open(output, O_WRONLY | O_CREAT | O_TRUNC, 0644);=0A=
	else=0A=
		ad =3D open(output, O_WRONLY, 0);=0A=
=0A=
	if (ad < 0) {=0A=
		fprintf(stderr, "Can't open output %s: %s\n",=0A=
						output, strerror(errno));=0A=
		goto free;=0A=
	}=0A=
=0A=
	sbc_init(&sbc, 0L);=0A=
	sbc.endian =3D SBC_BE;=0A=
=0A=
	framelen =3D sbc_decode(&sbc, stream, streamlen, buf, sizeof(buf), =
&len);=0A=
	channels =3D sbc.mode =3D=3D SBC_MODE_MONO ? 1 : 2;=0A=
	switch (sbc.frequency) {=0A=
	case SBC_FREQ_16000:=0A=
		frequency =3D 16000;=0A=
		break;=0A=
=0A=
	case SBC_FREQ_32000:=0A=
		frequency =3D 32000;=0A=
		break;=0A=
=0A=
	case SBC_FREQ_44100:=0A=
		frequency =3D 44100;=0A=
		break;=0A=
=0A=
	case SBC_FREQ_48000:=0A=
		frequency =3D 48000;=0A=
		break;=0A=
	default:=0A=
		frequency =3D 0;=0A=
	}=0A=
=0A=
	printf("%d Hz, %d channels\n", frequency, channels);=0A=
	if (tofile) {=0A=
		struct au_header au_hdr;=0A=
=0A=
		au_hdr.magic       =3D AU_MAGIC;=0A=
		au_hdr.hdr_size    =3D BE_INT(24);=0A=
		au_hdr.data_size   =3D BE_INT(0);=0A=
		au_hdr.encoding    =3D BE_INT(AU_FMT_LIN16);=0A=
		au_hdr.sample_rate =3D BE_INT(frequency);=0A=
		au_hdr.channels    =3D BE_INT(channels);=0A=
=0A=
		written =3D write(ad, &au_hdr, sizeof(au_hdr));=0A=
		if (written < sizeof(au_hdr)) {=0A=
			fprintf(stderr, "Failed to write header\n");=0A=
			goto close;=0A=
		}=0A=
	} else {=0A=
		if (ioctl(ad, SNDCTL_DSP_SETFMT, &format) < 0) {=0A=
			fprintf(stderr, "Can't set audio format on %s: %s\n",=0A=
					output, strerror(errno));=0A=
			goto close;=0A=
		}=0A=
=0A=
		if (ioctl(ad, SNDCTL_DSP_CHANNELS, &channels) < 0) {=0A=
			fprintf(stderr,=0A=
				"Can't set number of channels on %s: %s\n",=0A=
				output, strerror(errno));=0A=
			goto close;=0A=
		}=0A=
=0A=
		if (ioctl(ad, SNDCTL_DSP_SPEED, &frequency) < 0) {=0A=
			fprintf(stderr, "Can't set audio rate on %s: %s\n",=0A=
					output, strerror(errno));=0A=
			goto close;=0A=
		}=0A=
	}=0A=
=0A=
	count =3D len;=0A=
	while (framelen > 0) {=0A=
		/* we have completed an sbc_decode at this point sbc.len is the=0A=
		 * length of the frame we just decoded count is the number of=0A=
		 * decoded bytes yet to be written */=0A=
=0A=
		if (count + len >=3D BUF_SIZE) {=0A=
			/* buffer is too full to stuff decoded audio in so it=0A=
			 * must be written to the device */=0A=
			written =3D write(ad, buf, count);=0A=
			if (written > 0)=0A=
				count -=3D written;=0A=
		}=0A=
=0A=
		/* sanity check */=0A=
		if (count + len >=3D BUF_SIZE) {=0A=
			fprintf(stderr,=0A=
				"buffer size of %d is too small for decoded"=0A=
				" data (%d)\n", BUF_SIZE, len + count);=0A=
			exit(1);=0A=
		}=0A=
=0A=
		/* push the pointer in the file forward to the next bit to be=0A=
		 * decoded tell the decoder to decode up to the remaining=0A=
		 * length of the file (!) */=0A=
		pos +=3D framelen;=0A=
		framelen =3D sbc_decode(&sbc, stream + pos, streamlen - pos,=0A=
					buf + count, sizeof(buf) - count, &len);=0A=
=0A=
		/* increase the count */=0A=
		count +=3D len;=0A=
	}=0A=
=0A=
	if (count > 0) {=0A=
		written =3D write(ad, buf, count);=0A=
		if (written > 0)=0A=
			count -=3D written;=0A=
	}=0A=
=0A=
close:=0A=
	sbc_finish(&sbc);=0A=
=0A=
	close(ad);=0A=
=0A=
free:=0A=
	free(stream);=0A=
}=0A=
=0A=
static void usage(void)=0A=
{=0A=
	printf("SBC decoder utility ver %s\n", VERSION);=0A=
	printf("Copyright (c) 2004-2008  Marcel Holtmann\n\n");=0A=
=0A=
	printf("Usage:\n"=0A=
		"\tsbcdec [options] file(s)\n"=0A=
		"\n");=0A=
=0A=
	printf("Options:\n"=0A=
		"\t-h, --help           Display help\n"=0A=
		"\t-v, --verbose        Verbose mode\n"=0A=
		"\t-d, --device <dsp>   Sound device\n"=0A=
		"\t-f, --file <file>    Decode to a file\n"=0A=
		"\n");=0A=
}=0A=
=0A=
static struct option main_options[] =3D {=0A=
	{ "help",	0, 0, 'h' },=0A=
	{ "device",	1, 0, 'd' },=0A=
	{ "verbose",	0, 0, 'v' },=0A=
	{ "file",	1, 0, 'f' },=0A=
	{ 0, 0, 0, 0 }=0A=
};=0A=
=0A=
int main(int argc, char *argv[])=0A=
{=0A=
	char *output =3D NULL;=0A=
	int i, opt, verbose =3D 0, tofile =3D 0;=0A=
=0A=
	while ((opt =3D getopt_long(argc, argv, "+hvd:f:", main_options, NULL)) =
!=3D -1) {=0A=
		switch(opt) {=0A=
		case 'h':=0A=
			usage();=0A=
			exit(0);=0A=
=0A=
		case 'v':=0A=
			verbose =3D 1;=0A=
			break;=0A=
=0A=
		case 'd':=0A=
			if (output)=0A=
				free(output);=0A=
			output =3D strdup(optarg);=0A=
			tofile =3D 0;=0A=
			break;=0A=
=0A=
		case 'f' :=0A=
			if (output)=0A=
				free(output);=0A=
			output =3D strdup(optarg);=0A=
			tofile =3D 1;=0A=
			break;=0A=
=0A=
		default:=0A=
			exit(1);=0A=
		}=0A=
	}=0A=
=0A=
	argc -=3D optind;=0A=
	argv +=3D optind;=0A=
	optind =3D 0;=0A=
=0A=
	if (argc < 1) {=0A=
		usage();=0A=
		exit(1);=0A=
	}=0A=
=0A=
	for (i =3D 0; i < argc; i++)=0A=
		decode(argv[i], output ? output : "/dev/dsp", tofile);=0A=
=0A=
	if (output)=0A=
		free(output);=0A=
=0A=
	return 0;=0A=
}=0A=

------=_NextPart_000_001E_01C93AA7.D0F11620
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

-------------------------------------------------------------------------
This SF.Net email is sponsored by the Moblin Your Move Developer's challenge
Build the coolest Linux based applications with Moblin SDK & win great prizes
Grand prize is a trip for two to an Open Source event anywhere in the world
http://moblin-contest.org/redirect.php?banner_id=100&url=/
------=_NextPart_000_001E_01C93AA7.D0F11620
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Bluez-devel mailing list
Bluez-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-devel

------=_NextPart_000_001E_01C93AA7.D0F11620--
