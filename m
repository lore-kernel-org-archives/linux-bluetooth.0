Return-Path: <bluez-users-admin@lists.sourceforge.net>
MIME-Version: 1.0
Content-Type: multipart/alternative;
	boundary="----_=_NextPart_001_01C4F803.A1078683"
Message-ID: <0AAF93247C75E3408638B965DEE11A70026375D1@i2km41-ukdy.domain1.systemhost.net>
From: <graeme.n.brown@bt.com>
To: <bluez-users@lists.sourceforge.net>
Subject: [Bluez-users] Question re .bind() call on an RFCOMM socket
Sender: bluez-users-admin@lists.sourceforge.net
Errors-To: bluez-users-admin@lists.sourceforge.net
Reply-To: bluez-users@lists.sourceforge.net
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-users>,
	<mailto:bluez-users-request@lists.sourceforge.net?subject=unsubscribe>
List-Id: BlueZ users <bluez-users.lists.sourceforge.net>
List-Post: <mailto:bluez-users@lists.sourceforge.net>
List-Help: <mailto:bluez-users-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-users>,
	<mailto:bluez-users-request@lists.sourceforge.net?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=bluez-users>
Date: Tue, 11 Jan 2005 17:33:14 -0000

This is a multi-part message in MIME format.

------_=_NextPart_001_01C4F803.A1078683
Content-Type: text/plain;
	charset="us-ascii"
Content-Transfer-Encoding: quoted-printable

Hi
=20
=20
I am trying to understand how bind() call to  BlueZ RFCOMM socket
behaves .
Code ...
=20
SNIP...
#include <bluetooth/bluetooth.h>
#include <bluetooth/rfcomm.h>
=20
int main ()
{
=20
int sock ;
bdaddr_t    bdaddr ;
struct sockaddr_rc  loc_addr;
=20
SNIP ...
=20
/** Assume we have BT address of a local BT interface in bdaddr  **/
=20
 If ((sock =3D socket(PF_BLUETOOTH, SOCK_STREAM, BTPROTO_RFCOMM)) < 0) {
     printf("Cannot create socket: %s (errno: %d)\n", strerror(errno));
}
=20
=20
loc_addr.rc_family =3D AF_BLUETOOTH;
bacpy( &(loc_addr.rc_baddr), bdaddr);
=20
/* Channel allocation */=20
loc_addr.rc_channel =3D 1;
=20
/*** OR loc_addr.rc_channel =3D 0;  ???   <=3D What effect would this =
have
??? ***/
=20
if ( bind(sock, (struct sockaddr *) &loc_addr, sizeof(loc_addr)) < 0 ) {
   printf("Cannot bind to  socket: %s (errno: %d)\n", strerror(errno));
   close(sock);
   exit -1 ;
}
=20
snip ...
}=20
=20
=20
If the loc_addr.rc_channel were set to 0, does the bind() call
automatically allocate an unused RFCOMM server channel ?
=20
=20
Thanks
=20
Graeme Brown
=20
=20
=20

------_=_NextPart_001_01C4F803.A1078683
Content-Type: text/html;
	charset="us-ascii"
Content-Transfer-Encoding: quoted-printable

<html xmlns:o=3D"urn:schemas-microsoft-com:office:office" =
xmlns:w=3D"urn:schemas-microsoft-com:office:word" =
xmlns=3D"http://www.w3.org/TR/REC-html40">

<head>
<meta http-equiv=3DContent-Type content=3D"text/html; =
charset=3Dus-ascii">
<meta name=3DProgId content=3DWord.Document>
<meta name=3DGenerator content=3D"Microsoft Word 10">
<meta name=3DOriginator content=3D"Microsoft Word 10">
<link rel=3DFile-List href=3D"cid:filelist.xml@01C4F803.0C55B3B0">
<!--[if gte mso 9]><xml>
 <o:OfficeDocumentSettings>
  <o:DoNotRelyOnCSS/>
 </o:OfficeDocumentSettings>
</xml><![endif]--><!--[if gte mso 9]><xml>
 <w:WordDocument>
  <w:SpellingState>Clean</w:SpellingState>
  <w:GrammarState>Clean</w:GrammarState>
  <w:DocumentKind>DocumentEmail</w:DocumentKind>
  <w:EnvelopeVis/>
  <w:Compatibility>
   <w:BreakWrappedTables/>
   <w:SnapToGridInCell/>
   <w:WrapTextWithPunct/>
   <w:UseAsianBreakRules/>
  </w:Compatibility>
  <w:BrowserLevel>MicrosoftInternetExplorer4</w:BrowserLevel>
 </w:WordDocument>
</xml><![endif]-->
<style>
<!--
 /* Style Definitions */
 p.MsoNormal, li.MsoNormal, div.MsoNormal
	{mso-style-parent:"";
	margin:0cm;
	margin-bottom:.0001pt;
	mso-pagination:widow-orphan;
	font-size:12.0pt;
	font-family:"Times New Roman";
	mso-fareast-font-family:"Times New Roman";}
a:link, span.MsoHyperlink
	{color:blue;
	text-decoration:underline;
	text-underline:single;}
a:visited, span.MsoHyperlinkFollowed
	{color:purple;
	text-decoration:underline;
	text-underline:single;}
span.EmailStyle17
	{mso-style-type:personal-compose;
	mso-style-noshow:yes;
	mso-ansi-font-size:10.0pt;
	mso-bidi-font-size:10.0pt;
	font-family:Arial;
	mso-ascii-font-family:Arial;
	mso-hansi-font-family:Arial;
	mso-bidi-font-family:Arial;
	color:windowtext;}
span.SpellE
	{mso-style-name:"";
	mso-spl-e:yes;}
span.GramE
	{mso-style-name:"";
	mso-gram-e:yes;}
@page Section1
	{size:612.0pt 792.0pt;
	margin:72.0pt 90.0pt 72.0pt 90.0pt;
	mso-header-margin:35.4pt;
	mso-footer-margin:35.4pt;
	mso-paper-source:0;}
div.Section1
	{page:Section1;}
-->
</style>
<!--[if gte mso 10]>
<style>
 /* Style Definitions */=20
 table.MsoNormalTable
	{mso-style-name:"Table Normal";
	mso-tstyle-rowband-size:0;
	mso-tstyle-colband-size:0;
	mso-style-noshow:yes;
	mso-style-parent:"";
	mso-padding-alt:0cm 5.4pt 0cm 5.4pt;
	mso-para-margin:0cm;
	mso-para-margin-bottom:.0001pt;
	mso-pagination:widow-orphan;
	font-size:10.0pt;
	font-family:"Times New Roman";}
</style>
<![endif]-->
</head>

<body lang=3DEN-US link=3Dblue vlink=3Dpurple =
style=3D'tab-interval:36.0pt'>

<div class=3DSection1>

<p class=3DMsoNormal><font size=3D2 face=3DArial><span lang=3DEN-GB =
style=3D'font-size:
10.0pt;font-family:Arial;mso-ansi-language:EN-GB'>Hi<o:p></o:p></span></f=
ont></p>

<p class=3DMsoNormal><font size=3D2 face=3DArial><span lang=3DEN-GB =
style=3D'font-size:
10.0pt;font-family:Arial;mso-ansi-language:EN-GB'><o:p>&nbsp;</o:p></span=
></font></p>

<p class=3DMsoNormal><font size=3D2 face=3DArial><span lang=3DEN-GB =
style=3D'font-size:
10.0pt;font-family:Arial;mso-ansi-language:EN-GB'><o:p>&nbsp;</o:p></span=
></font></p>

<p class=3DMsoNormal><font size=3D2 face=3DArial><span lang=3DEN-GB =
style=3D'font-size:
10.0pt;font-family:Arial;mso-ansi-language:EN-GB'>I am trying to =
understand how
<span class=3DGramE>bind(</span>) call to <span
style=3D'mso-spacerun:yes'>&nbsp;</span><span =
class=3DSpellE>BlueZ</span> RFCOMM
socket behaves .<o:p></o:p></span></font></p>

<p class=3DMsoNormal><font size=3D2 face=3DArial><span lang=3DEN-GB =
style=3D'font-size:
10.0pt;font-family:Arial;mso-ansi-language:EN-GB'>Code =
&#8230;<o:p></o:p></span></font></p>

<p class=3DMsoNormal><font size=3D2 face=3DArial><span lang=3DEN-GB =
style=3D'font-size:
10.0pt;font-family:Arial;mso-ansi-language:EN-GB'><o:p>&nbsp;</o:p></span=
></font></p>

<p class=3DMsoNormal><font size=3D2 face=3DArial><span lang=3DEN-GB =
style=3D'font-size:
10.0pt;font-family:Arial;mso-ansi-language:EN-GB'>SNIP&#8230;<o:p></o:p><=
/span></font></p>

<p class=3DMsoNormal><font size=3D2 face=3DArial><span lang=3DEN-GB =
style=3D'font-size:
10.0pt;font-family:Arial;mso-ansi-language:EN-GB'>#include &lt;<span
class=3DSpellE>bluetooth/bluetooth.h</span>&gt;<o:p></o:p></span></font><=
/p>

<p class=3DMsoNormal><font size=3D2 face=3DArial><span lang=3DEN-GB =
style=3D'font-size:
10.0pt;font-family:Arial;mso-ansi-language:EN-GB'>#include &lt;<span
class=3DSpellE>bluetooth/rfcomm.h</span>&gt;<o:p></o:p></span></font></p>=


<p class=3DMsoNormal><font size=3D2 face=3DArial><span lang=3DEN-GB =
style=3D'font-size:
10.0pt;font-family:Arial;mso-ansi-language:EN-GB'><o:p>&nbsp;</o:p></span=
></font></p>

<p class=3DMsoNormal><span class=3DSpellE><span class=3DGramE><font =
size=3D2
face=3DArial><span lang=3DEN-GB =
style=3D'font-size:10.0pt;font-family:Arial;
mso-ansi-language:EN-GB'>int</span></font></span></span><font size=3D2
face=3DArial><span lang=3DEN-GB =
style=3D'font-size:10.0pt;font-family:Arial;
mso-ansi-language:EN-GB'> main ()<o:p></o:p></span></font></p>

<p class=3DMsoNormal><font size=3D2 face=3DArial><span lang=3DEN-GB =
style=3D'font-size:
10.0pt;font-family:Arial;mso-ansi-language:EN-GB'>{<o:p></o:p></span></fo=
nt></p>

<p class=3DMsoNormal><font size=3D2 face=3DArial><span lang=3DEN-GB =
style=3D'font-size:
10.0pt;font-family:Arial;mso-ansi-language:EN-GB'><span
style=3D'mso-spacerun:yes'>&nbsp;</span><o:p></o:p></span></font></p>

<p class=3DMsoNormal><span class=3DSpellE><span class=3DGramE><font =
size=3D2
face=3DArial><span lang=3DEN-GB =
style=3D'font-size:10.0pt;font-family:Arial;
mso-ansi-language:EN-GB'>int</span></font></span></span><font size=3D2
face=3DArial><span lang=3DEN-GB =
style=3D'font-size:10.0pt;font-family:Arial;
mso-ansi-language:EN-GB'> sock ;<o:p></o:p></span></font></p>

<p class=3DMsoNormal><span class=3DSpellE><span class=3DGramE><font =
size=3D2
face=3DArial><span lang=3DEN-GB =
style=3D'font-size:10.0pt;font-family:Arial;
mso-ansi-language:EN-GB'>bdaddr_t</span></font></span></span><font =
size=3D2
face=3DArial><span lang=3DEN-GB =
style=3D'font-size:10.0pt;font-family:Arial;
mso-ansi-language:EN-GB'><span =
style=3D'mso-spacerun:yes'>&nbsp;&nbsp;&nbsp;
</span><span class=3DSpellE>bdaddr</span> ;<o:p></o:p></span></font></p>

<p class=3DMsoNormal><span class=3DSpellE><span class=3DGramE><font =
size=3D2
face=3DArial><span lang=3DEN-GB =
style=3D'font-size:10.0pt;font-family:Arial;
mso-ansi-language:EN-GB'>struct</span></font></span></span><font =
size=3D2
face=3DArial><span lang=3DEN-GB =
style=3D'font-size:10.0pt;font-family:Arial;
mso-ansi-language:EN-GB'> <span class=3DSpellE>sockaddr_rc</span><span
style=3D'mso-spacerun:yes'>&nbsp; </span><span =
class=3DSpellE>loc_addr</span>;<o:p></o:p></span></font></p>

<p class=3DMsoNormal><font size=3D2 face=3DArial><span lang=3DEN-GB =
style=3D'font-size:
10.0pt;font-family:Arial;mso-ansi-language:EN-GB'><o:p>&nbsp;</o:p></span=
></font></p>

<p class=3DMsoNormal><font size=3D2 face=3DArial><span lang=3DEN-GB =
style=3D'font-size:
10.0pt;font-family:Arial;mso-ansi-language:EN-GB'>SNIP =
&#8230;<o:p></o:p></span></font></p>

<p class=3DMsoNormal><font size=3D2 face=3DArial><span lang=3DEN-GB =
style=3D'font-size:
10.0pt;font-family:Arial;mso-ansi-language:EN-GB'><o:p>&nbsp;</o:p></span=
></font></p>

<p class=3DMsoNormal><font size=3D2 face=3DArial><span lang=3DEN-GB =
style=3D'font-size:
10.0pt;font-family:Arial;mso-ansi-language:EN-GB'>/** Assume we have BT =
address
of a local BT interface in <span class=3DSpellE><span =
class=3DGramE>bdaddr</span></span><span
class=3DGramE><span style=3D'mso-spacerun:yes'>&nbsp; =
</span>*</span>*/<o:p></o:p></span></font></p>

<p class=3DMsoNormal><font size=3D2 face=3DArial><span lang=3DEN-GB =
style=3D'font-size:
10.0pt;font-family:Arial;mso-ansi-language:EN-GB'><o:p>&nbsp;</o:p></span=
></font></p>

<p class=3DMsoNormal><font size=3D2 face=3DArial><span lang=3DEN-GB =
style=3D'font-size:
10.0pt;font-family:Arial;mso-ansi-language:EN-GB'><span
style=3D'mso-spacerun:yes'>&nbsp;</span>If ((sock =3D <span =
class=3DGramE>socket(</span>PF_BLUETOOTH,
SOCK_STREAM, BTPROTO_RFCOMM)) &lt; 0) {<o:p></o:p></span></font></p>

<p class=3DMsoNormal><font size=3D2 face=3DArial><span lang=3DEN-GB =
style=3D'font-size:
10.0pt;font-family:Arial;mso-ansi-language:EN-GB'><span
style=3D'mso-spacerun:yes'>&nbsp;&nbsp;&nbsp;&nbsp; </span><span =
class=3DSpellE><span
class=3DGramE>printf</span></span><span =
class=3DGramE>(</span>&#8220;Cannot create
socket: %s (<span class=3DSpellE>errno</span>: %d)\n&#8221;, <span =
class=3DSpellE>strerror</span>(<span
class=3DSpellE>errno</span>));<o:p></o:p></span></font></p>

<p class=3DMsoNormal><font size=3D2 face=3DArial><span lang=3DEN-GB =
style=3D'font-size:
10.0pt;font-family:Arial;mso-ansi-language:EN-GB'>}<o:p></o:p></span></fo=
nt></p>

<p class=3DMsoNormal><font size=3D2 face=3DArial><span lang=3DEN-GB =
style=3D'font-size:
10.0pt;font-family:Arial;mso-ansi-language:EN-GB'><o:p>&nbsp;</o:p></span=
></font></p>

<p class=3DMsoNormal><font size=3D2 face=3DArial><span lang=3DEN-GB =
style=3D'font-size:
10.0pt;font-family:Arial;mso-ansi-language:EN-GB'><o:p>&nbsp;</o:p></span=
></font></p>

<p class=3DMsoNormal><span class=3DSpellE><font size=3D2 =
face=3DArial><span lang=3DEN-GB
style=3D'font-size:10.0pt;font-family:Arial;mso-ansi-language:EN-GB'>loc_=
addr.rc_family</span></font></span><font
size=3D2 face=3DArial><span lang=3DEN-GB =
style=3D'font-size:10.0pt;font-family:Arial;
mso-ansi-language:EN-GB'> =3D AF_BLUETOOTH;<o:p></o:p></span></font></p>

<p class=3DMsoNormal><span class=3DSpellE><span class=3DGramE><font =
size=3D2
face=3DArial><span lang=3DEN-GB =
style=3D'font-size:10.0pt;font-family:Arial;
mso-ansi-language:EN-GB'>bacpy</span></font></span></span><span =
class=3DGramE><font
size=3D2 face=3DArial><span lang=3DEN-GB =
style=3D'font-size:10.0pt;font-family:Arial;
mso-ansi-language:EN-GB'>(</span></font></span><font size=3D2 =
face=3DArial><span
lang=3DEN-GB =
style=3D'font-size:10.0pt;font-family:Arial;mso-ansi-language:EN-GB'>
&amp;(<span class=3DSpellE>loc_addr.rc_baddr</span>), <span =
class=3DSpellE>bdaddr</span>);<o:p></o:p></span></font></p>

<p class=3DMsoNormal><font size=3D2 face=3DArial><span lang=3DEN-GB =
style=3D'font-size:
10.0pt;font-family:Arial;mso-ansi-language:EN-GB'><o:p>&nbsp;</o:p></span=
></font></p>

<p class=3DMsoNormal><font size=3D2 face=3DArial><span lang=3DEN-GB =
style=3D'font-size:
10.0pt;font-family:Arial;mso-ansi-language:EN-GB'>/* Channel allocation =
*/ <o:p></o:p></span></font></p>

<p class=3DMsoNormal><span class=3DSpellE><font size=3D2 =
face=3DArial><span lang=3DEN-GB
style=3D'font-size:10.0pt;font-family:Arial;mso-ansi-language:EN-GB'>loc_=
addr.rc_channel</span></font></span><font
size=3D2 face=3DArial><span lang=3DEN-GB =
style=3D'font-size:10.0pt;font-family:Arial;
mso-ansi-language:EN-GB'> =3D 1;<o:p></o:p></span></font></p>

<p class=3DMsoNormal><font size=3D2 face=3DArial><span lang=3DEN-GB =
style=3D'font-size:
10.0pt;font-family:Arial;mso-ansi-language:EN-GB'><o:p>&nbsp;</o:p></span=
></font></p>

<p class=3DMsoNormal><font size=3D2 face=3DArial><span lang=3DEN-GB =
style=3D'font-size:
10.0pt;font-family:Arial;mso-ansi-language:EN-GB'>/*** OR <span =
class=3DSpellE>loc_addr.rc_channel</span>
=3D 0<span class=3DGramE>;<span style=3D'mso-spacerun:yes'>&nbsp; =
</span>???</span><span
style=3D'mso-spacerun:yes'>&nbsp;&nbsp; </span>&lt;=3D What effect would =
this <span
class=3DGramE>have ???</span> ***/<o:p></o:p></span></font></p>

<p class=3DMsoNormal><font size=3D2 face=3DArial><span lang=3DEN-GB =
style=3D'font-size:
10.0pt;font-family:Arial;mso-ansi-language:EN-GB'><o:p>&nbsp;</o:p></span=
></font></p>

<p class=3DMsoNormal><span class=3DGramE><font size=3D2 =
face=3DArial><span lang=3DEN-GB
style=3D'font-size:10.0pt;font-family:Arial;mso-ansi-language:EN-GB'>if</=
span></font></span><font
size=3D2 face=3DArial><span lang=3DEN-GB =
style=3D'font-size:10.0pt;font-family:Arial;
mso-ansi-language:EN-GB'> ( bind(sock, (<span =
class=3DSpellE>struct</span> <span
class=3DSpellE>sockaddr</span> *) &amp;<span =
class=3DSpellE>loc_addr</span>, <span
class=3DSpellE>sizeof</span>(<span class=3DSpellE>loc_addr</span>)) &lt; =
0 ) {<o:p></o:p></span></font></p>

<p class=3DMsoNormal><font size=3D2 face=3DArial><span lang=3DEN-GB =
style=3D'font-size:
10.0pt;font-family:Arial;mso-ansi-language:EN-GB'><span
style=3D'mso-spacerun:yes'>&nbsp;&nbsp; </span><span =
class=3DSpellE><span
class=3DGramE>printf</span></span><span =
class=3DGramE>(</span>&#8220;Cannot bind to
<span style=3D'mso-spacerun:yes'>&nbsp;</span>socket: %s (<span =
class=3DSpellE>errno</span>:
%d)\n&#8221;, <span class=3DSpellE>strerror</span>(<span =
class=3DSpellE>errno</span>));<o:p></o:p></span></font></p>

<p class=3DMsoNormal><font size=3D2 face=3DArial><span lang=3DEN-GB =
style=3D'font-size:
10.0pt;font-family:Arial;mso-ansi-language:EN-GB'><span
style=3D'mso-spacerun:yes'>&nbsp;&nbsp; </span><span =
class=3DGramE>close(</span>sock);<o:p></o:p></span></font></p>

<p class=3DMsoNormal><font size=3D2 face=3DArial><span lang=3DEN-GB =
style=3D'font-size:
10.0pt;font-family:Arial;mso-ansi-language:EN-GB'><span
style=3D'mso-spacerun:yes'>&nbsp;&nbsp; </span><span =
class=3DGramE>exit</span> -1 ;<o:p></o:p></span></font></p>

<p class=3DMsoNormal><font size=3D2 face=3DArial><span lang=3DEN-GB =
style=3D'font-size:
10.0pt;font-family:Arial;mso-ansi-language:EN-GB'>}<o:p></o:p></span></fo=
nt></p>

<p class=3DMsoNormal><font size=3D2 face=3DArial><span lang=3DEN-GB =
style=3D'font-size:
10.0pt;font-family:Arial;mso-ansi-language:EN-GB'><o:p>&nbsp;</o:p></span=
></font></p>

<p class=3DMsoNormal><span class=3DGramE><font size=3D2 =
face=3DArial><span lang=3DEN-GB
style=3D'font-size:10.0pt;font-family:Arial;mso-ansi-language:EN-GB'>snip=
</span></font></span><font
size=3D2 face=3DArial><span lang=3DEN-GB =
style=3D'font-size:10.0pt;font-family:Arial;
mso-ansi-language:EN-GB'> &#8230;<o:p></o:p></span></font></p>

<p class=3DMsoNormal><font size=3D2 face=3DArial><span lang=3DEN-GB =
style=3D'font-size:
10.0pt;font-family:Arial;mso-ansi-language:EN-GB'>} =
<o:p></o:p></span></font></p>

<p class=3DMsoNormal><font size=3D2 face=3DArial><span lang=3DEN-GB =
style=3D'font-size:
10.0pt;font-family:Arial;mso-ansi-language:EN-GB'><o:p>&nbsp;</o:p></span=
></font></p>

<p class=3DMsoNormal><font size=3D2 face=3DArial><span lang=3DEN-GB =
style=3D'font-size:
10.0pt;font-family:Arial;mso-ansi-language:EN-GB'><o:p>&nbsp;</o:p></span=
></font></p>

<p class=3DMsoNormal><font size=3D2 face=3DArial><span lang=3DEN-GB =
style=3D'font-size:
10.0pt;font-family:Arial;mso-ansi-language:EN-GB'>If the <span =
class=3DSpellE>loc_addr.rc_channel</span>
were set to 0, does the <span class=3DGramE>bind(</span>) call =
automatically
allocate an unused RFCOMM server channel ?<o:p></o:p></span></font></p>

<p class=3DMsoNormal><font size=3D2 face=3DArial><span lang=3DEN-GB =
style=3D'font-size:
10.0pt;font-family:Arial;mso-ansi-language:EN-GB'><o:p>&nbsp;</o:p></span=
></font></p>

<p class=3DMsoNormal><font size=3D2 face=3DArial><span lang=3DEN-GB =
style=3D'font-size:
10.0pt;font-family:Arial;mso-ansi-language:EN-GB'><o:p>&nbsp;</o:p></span=
></font></p>

<p class=3DMsoNormal><font size=3D2 face=3DArial><span lang=3DEN-GB =
style=3D'font-size:
10.0pt;font-family:Arial;mso-ansi-language:EN-GB'>Thanks<o:p></o:p></span=
></font></p>

<p class=3DMsoNormal><font size=3D2 face=3DArial><span lang=3DEN-GB =
style=3D'font-size:
10.0pt;font-family:Arial;mso-ansi-language:EN-GB'><o:p>&nbsp;</o:p></span=
></font></p>

<p class=3DMsoNormal><font size=3D2 face=3DArial><span lang=3DEN-GB =
style=3D'font-size:
10.0pt;font-family:Arial;mso-ansi-language:EN-GB'>Graeme =
Brown<o:p></o:p></span></font></p>

<p class=3DMsoNormal><font size=3D2 face=3DArial><span lang=3DEN-GB =
style=3D'font-size:
10.0pt;font-family:Arial;mso-ansi-language:EN-GB'><o:p>&nbsp;</o:p></span=
></font></p>

<p class=3DMsoNormal><font size=3D2 face=3DArial><span lang=3DEN-GB =
style=3D'font-size:
10.0pt;font-family:Arial;mso-ansi-language:EN-GB'><o:p>&nbsp;</o:p></span=
></font></p>

<p class=3DMsoNormal><font size=3D2 face=3DArial><span lang=3DEN-GB =
style=3D'font-size:
10.0pt;font-family:Arial;mso-ansi-language:EN-GB'><o:p>&nbsp;</o:p></span=
></font></p>

</div>

</body>

</html>
=00
------_=_NextPart_001_01C4F803.A1078683--


-------------------------------------------------------
The SF.Net email is sponsored by: Beat the post-holiday blues
Get a FREE limited edition SourceForge.net t-shirt from ThinkGeek.
It's fun and FREE -- well, almost....http://www.thinkgeek.com/sfshirt
_______________________________________________
Bluez-users mailing list
Bluez-users@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-users
