Return-Path: <bluez-devel-bounces@lists.sourceforge.net>
From: "Scott Meesseman" <scottpm@ameritech.net>
To: <bluez-devel@lists.sourceforge.net>
Date: Sat, 16 Sep 2006 15:21:34 -0400
Message-ID: <000001c6d9c5$53bbd040$6713a8c0@alai.alpsautomotive.com>
MIME-Version: 1.0
Subject: [Bluez-devel] IrMC Sync Profile - OBEX GET is UNAUTHORIZED
Reply-To: BlueZ development <bluez-devel@lists.sourceforge.net>
List-Id: BlueZ development <bluez-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-devel>,
	<mailto:bluez-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=bluez-devel>
List-Post: <mailto:bluez-devel@lists.sourceforge.net>
List-Help: <mailto:bluez-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-devel>,
	<mailto:bluez-devel-request@lists.sourceforge.net?subject=subscribe>
Content-Type: multipart/mixed; boundary="===============0259630156=="
Sender: bluez-devel-bounces@lists.sourceforge.net
Errors-To: bluez-devel-bounces@lists.sourceforge.net

This is a multi-part message in MIME format.

--===============0259630156==
Content-Type: multipart/alternative;
	boundary="----=_NextPart_000_0001_01C6D9A3.CCAA3040"

This is a multi-part message in MIME format.

------=_NextPart_000_0001_01C6D9A3.CCAA3040
Content-Type: text/plain;
	charset="us-ascii"
Content-Transfer-Encoding: 7bit

 
Hello,
 
I am currently developing Level4 IrMC Sync for use with Sony Ericsson
phones.  Using rfcomm socket, I can start the sync using "IRMC-SYNC"
OBEX TARGET header in the CONNECT request.  The server replies with
SUCCESS response code, plus the WHO header ("IRMC-SYNC") and a 4 byte
connection ID.  Problem I am having is after connect success when I go
to retrieve a Level4 object, in this instance the changelog
telecom/pb/luid/0.log, the server always reply with 0xC1 (UNAUTHORIZED)
immediately followed by ENDOFBODY header with 21 bytes of non-ascii
data.  I am sending the following GET request for this :
 
BYTE0       0x83  // GET OPCODE w/ final bit set
BYTE1       0x00  // Packet Len MSB
BYTE2       0x36 // Packet Len LSB
BYTE3       0xCB  // Connection ID Header Opcode
BYTE4       0x00 // Connection ID MSB
BYTE5       0x00 // Connection ID ...
BYTE6       0x00  // Connection ID ...
BYTE7       0x55  // Connection ID LSB
BYTE8       0x01 // NAME Header Opcode
BYTE9       0x00 // NAME Length MSB
BYTE10      0x2C // NAME Length LSB
BYTE11 - n  ....  // NULL terminated Unicode string
"telecom/pb/luid/0.log"
 
 
If anyone has experience with OBEX GET in this case do you notice
anything wrong with my scenario?
 
Thanks for any help in advance, it is highly appreciated,
Scott Meesseman
 
 

------=_NextPart_000_0001_01C6D9A3.CCAA3040
Content-Type: text/html;
	charset="us-ascii"
Content-Transfer-Encoding: quoted-printable

<html xmlns:o=3D"urn:schemas-microsoft-com:office:office" =
xmlns:w=3D"urn:schemas-microsoft-com:office:word" =
xmlns=3D"http://www.w3.org/TR/REC-html40">

<head>
<META HTTP-EQUIV=3D"Content-Type" CONTENT=3D"text/html; =
charset=3Dus-ascii">


<meta name=3DProgId content=3DWord.Document>
<meta name=3DGenerator content=3D"Microsoft Word 10">
<meta name=3DOriginator content=3D"Microsoft Word 10">
<link rel=3DFile-List href=3D"cid:filelist.xml@01C6D9A3.CB53C800">
<!--[if gte mso 9]><xml>
 <o:OfficeDocumentSettings>
  <o:DoNotRelyOnCSS/>
 </o:OfficeDocumentSettings>
</xml><![endif]--><!--[if gte mso 9]><xml>
 <w:WordDocument>
  <w:GrammarState>Clean</w:GrammarState>
  <w:DocumentKind>DocumentEmail</w:DocumentKind>
  <w:EnvelopeVis/>
  <w:Compatibility>
   <w:BreakWrappedTables/>
   <w:SnapToGridInCell/>
   <w:WrapTextWithPunct/>
   <w:UseAsianBreakRules/>
   <w:UseFELayout/>
  </w:Compatibility>
  <w:BrowserLevel>MicrosoftInternetExplorer4</w:BrowserLevel>
 </w:WordDocument>
</xml><![endif]-->
<style>
<!--
 /* Font Definitions */
 @font-face
	{font-family:"Tms Rmn";
	panose-1:2 2 6 3 4 5 5 2 3 4;
	mso-font-alt:"Times New Roman";
	mso-font-charset:0;
	mso-generic-font-family:roman;
	mso-font-format:other;
	mso-font-pitch:variable;
	mso-font-signature:3 0 0 0 1 0;}
@font-face
	{font-family:Helv;
	panose-1:2 11 6 4 2 2 2 3 2 4;
	mso-font-alt:Arial;
	mso-font-charset:0;
	mso-generic-font-family:swiss;
	mso-font-format:other;
	mso-font-pitch:variable;
	mso-font-signature:3 0 0 0 1 0;}
@font-face
	{font-family:"MS Mincho";
	panose-1:2 2 6 9 4 2 5 8 3 4;
	mso-font-alt:"\FF2D\FF33 \660E\671D";
	mso-font-charset:128;
	mso-generic-font-family:modern;
	mso-font-pitch:fixed;
	mso-font-signature:-1610612033 1757936891 16 0 131231 0;}
@font-face
	{font-family:"\@MS Mincho";
	panose-1:2 2 6 9 4 2 5 8 3 4;
	mso-font-charset:128;
	mso-generic-font-family:modern;
	mso-font-pitch:fixed;
	mso-font-signature:-1610612033 1757936891 16 0 131231 0;}
 /* Style Definitions */
 p.MsoNormal, li.MsoNormal, div.MsoNormal
	{mso-style-parent:"";
	margin:0in;
	margin-bottom:.0001pt;
	mso-pagination:widow-orphan;
	font-size:12.0pt;
	font-family:"Times New Roman";
	mso-fareast-font-family:"MS Mincho";}
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
span.GramE
	{mso-style-name:"";
	mso-gram-e:yes;}
@page Section1
	{size:8.5in 11.0in;
	margin:1.0in 1.0in 1.0in 1.0in;
	mso-header-margin:.5in;
	mso-footer-margin:.5in;
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
	mso-padding-alt:0in 5.4pt 0in 5.4pt;
	mso-para-margin:0in;
	mso-para-margin-bottom:.0001pt;
	mso-pagination:widow-orphan;
	font-size:10.0pt;
	font-family:"Times New Roman";}
</style>
<![endif]-->
</head>

<body lang=3DEN-US link=3Dblue vlink=3Dpurple =
style=3D'tab-interval:.5in'>

<div class=3DSection1>

<p class=3DMsoNormal =
style=3D'line-height:12.0pt;mso-layout-grid-align:none;
text-autospace:none'><font size=3D3 face=3D"Tms Rmn"><span =
style=3D'font-size:12.0pt;
font-family:"Tms Rmn"'><o:p>&nbsp;</o:p></span></font></p>

<p class=3DMsoNormal =
style=3D'line-height:12.0pt;mso-layout-grid-align:none;
text-autospace:none'><font size=3D2 color=3Dblack face=3D"Courier =
New"><span
style=3D'font-size:10.0pt;font-family:"Courier =
New";color:black'>Hello,<o:p></o:p></span></font></p>

<p class=3DMsoNormal =
style=3D'line-height:12.0pt;mso-layout-grid-align:none;
text-autospace:none'><font size=3D2 color=3Dblack face=3D"Courier =
New"><span
style=3D'font-size:10.0pt;font-family:"Courier =
New";color:black'><o:p>&nbsp;</o:p></span></font></p>

<p class=3DMsoNormal =
style=3D'line-height:12.0pt;mso-layout-grid-align:none;
text-autospace:none'><font size=3D2 color=3Dblack face=3D"Courier =
New"><span
style=3D'font-size:10.0pt;font-family:"Courier New";color:black'>I am =
currently
developing Level4 IrMC Sync for use with Sony Ericsson phones.<span
style=3D'mso-spacerun:yes'>&nbsp; </span>Using rfcomm socket, I can =
start the sync
using &quot;IRMC-SYNC&quot; OBEX TARGET header in the CONNECT =
request.<span
style=3D'mso-spacerun:yes'>&nbsp; </span>The server replies with SUCCESS =
response
code, plus the WHO header (&quot;IRMC-SYNC&quot;) and a 4 byte =
connection
ID.<span style=3D'mso-spacerun:yes'>&nbsp; </span>Problem I am having is =
after connect
success when I go to retrieve a Level4 object, in this instance the =
changelog
telecom/pb/luid/0.log, the server always reply with 0xC1 (UNAUTHORIZED)
immediately followed by ENDOFBODY header with 21 bytes of non-ascii =
data.<span
style=3D'mso-spacerun:yes'>&nbsp; </span>I am sending the following GET =
request for <span
class=3DGramE>this :</span><o:p></o:p></span></font></p>

<p class=3DMsoNormal =
style=3D'line-height:12.0pt;mso-layout-grid-align:none;
text-autospace:none'><font size=3D2 color=3Dblack face=3D"Courier =
New"><span
style=3D'font-size:10.0pt;font-family:"Courier =
New";color:black'><o:p>&nbsp;</o:p></span></font></p>

<p class=3DMsoNormal =
style=3D'line-height:12.0pt;mso-layout-grid-align:none;
text-autospace:none'><font size=3D2 color=3Dblack face=3D"Courier =
New"><span
style=3D'font-size:10.0pt;font-family:"Courier New";color:black'>BYTE0 =
<span
style=3D'mso-tab-count:1'>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; </span><span =
class=3DGramE>0x83<span
style=3D'mso-spacerun:yes'>&nbsp; </span>/</span>/ GET OPCODE w/ final =
bit set<o:p></o:p></span></font></p>

<p class=3DMsoNormal =
style=3D'line-height:12.0pt;mso-layout-grid-align:none;
text-autospace:none'><font size=3D2 color=3Dblack face=3D"Courier =
New"><span
style=3D'font-size:10.0pt;font-family:"Courier =
New";color:black'>BYTE1<span
style=3D'mso-tab-count:2'>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =
</span><span class=3DGramE>0x00<span
style=3D'mso-spacerun:yes'>&nbsp; </span>/</span>/ Packet Len =
MSB<o:p></o:p></span></font></p>

<p class=3DMsoNormal =
style=3D'line-height:12.0pt;mso-layout-grid-align:none;
text-autospace:none'><font size=3D2 color=3Dblack face=3D"Courier =
New"><span
style=3D'font-size:10.0pt;font-family:"Courier =
New";color:black'>BYTE2<span
style=3D'mso-tab-count:2'>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =
</span>0x36 <span style=3D'mso-tab-count:1'> </span>//
Packet Len LSB<o:p></o:p></span></font></p>

<p class=3DMsoNormal =
style=3D'line-height:12.0pt;mso-layout-grid-align:none;
text-autospace:none'><font size=3D2 color=3Dblack face=3D"Courier =
New"><span
style=3D'font-size:10.0pt;font-family:"Courier =
New";color:black'>BYTE3<span
style=3D'mso-tab-count:2'>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =
</span><span class=3DGramE>0xCB<span
style=3D'mso-spacerun:yes'>&nbsp; </span>/</span>/ Connection ID Header =
Opcode<o:p></o:p></span></font></p>

<p class=3DMsoNormal =
style=3D'line-height:12.0pt;mso-layout-grid-align:none;
text-autospace:none'><font size=3D2 color=3Dblack face=3D"Courier =
New"><span
style=3D'font-size:10.0pt;font-family:"Courier =
New";color:black'>BYTE4<span
style=3D'mso-tab-count:2'>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =
</span>0x00 <span style=3D'mso-tab-count:1'> </span>//
Connection ID MSB<o:p></o:p></span></font></p>

<p class=3DMsoNormal =
style=3D'line-height:12.0pt;mso-layout-grid-align:none;
text-autospace:none'><font size=3D2 color=3Dblack face=3D"Courier =
New"><span
style=3D'font-size:10.0pt;font-family:"Courier =
New";color:black'>BYTE5<span
style=3D'mso-tab-count:2'>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =
</span>0x00 <span style=3D'mso-tab-count:1'> </span>//
Connection <span class=3DGramE>ID =
...</span><o:p></o:p></span></font></p>

<p class=3DMsoNormal =
style=3D'line-height:12.0pt;mso-layout-grid-align:none;
text-autospace:none'><font size=3D2 color=3Dblack face=3D"Courier =
New"><span
style=3D'font-size:10.0pt;font-family:"Courier =
New";color:black'>BYTE6<span
style=3D'mso-tab-count:2'>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =
</span><span class=3DGramE>0x00<span
style=3D'mso-spacerun:yes'>&nbsp; </span>/</span>/ Connection ID =
...<o:p></o:p></span></font></p>

<p class=3DMsoNormal =
style=3D'line-height:12.0pt;mso-layout-grid-align:none;
text-autospace:none'><font size=3D2 color=3Dblack face=3D"Courier =
New"><span
style=3D'font-size:10.0pt;font-family:"Courier =
New";color:black'>BYTE7<span
style=3D'mso-tab-count:2'>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =
</span><span class=3DGramE>0x55<span
style=3D'mso-spacerun:yes'>&nbsp; </span>/</span>/ Connection ID =
LSB<o:p></o:p></span></font></p>

<p class=3DMsoNormal =
style=3D'line-height:12.0pt;mso-layout-grid-align:none;
text-autospace:none'><font size=3D2 color=3Dblack face=3D"Courier =
New"><span
style=3D'font-size:10.0pt;font-family:"Courier =
New";color:black'>BYTE8<span
style=3D'mso-tab-count:2'>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =
</span>0x01 <span style=3D'mso-tab-count:1'> </span>//
NAME Header Opcode<o:p></o:p></span></font></p>

<p class=3DMsoNormal =
style=3D'line-height:12.0pt;mso-layout-grid-align:none;
text-autospace:none'><font size=3D2 color=3Dblack face=3D"Courier =
New"><span
style=3D'font-size:10.0pt;font-family:"Courier =
New";color:black'>BYTE9<span
style=3D'mso-tab-count:2'>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =
</span>0x00 <span style=3D'mso-tab-count:1'> </span>//
NAME Length MSB<o:p></o:p></span></font></p>

<p class=3DMsoNormal =
style=3D'line-height:12.0pt;mso-layout-grid-align:none;
text-autospace:none'><font size=3D2 color=3Dblack face=3D"Courier =
New"><span
style=3D'font-size:10.0pt;font-family:"Courier =
New";color:black'>BYTE10<span
style=3D'mso-tab-count:1'>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; </span>0x2C =
<span style=3D'mso-tab-count:1'> </span>//
NAME Length LSB<o:p></o:p></span></font></p>

<p class=3DMsoNormal =
style=3D'line-height:12.0pt;mso-layout-grid-align:none;
text-autospace:none'><font size=3D2 color=3Dblack face=3D"Courier =
New"><span
style=3D'font-size:10.0pt;font-family:"Courier New";color:black'>BYTE11 =
- n<span
style=3D'mso-tab-count:1'>&nbsp; </span>....<span =
style=3D'mso-spacerun:yes'>&nbsp; </span>//
NULL terminated Unicode string =
&quot;telecom/pb/luid/0.log&quot;<o:p></o:p></span></font></p>

<p class=3DMsoNormal =
style=3D'line-height:12.0pt;mso-layout-grid-align:none;
text-autospace:none'><font size=3D2 color=3Dblack face=3D"Courier =
New"><span
style=3D'font-size:10.0pt;font-family:"Courier =
New";color:black'><o:p>&nbsp;</o:p></span></font></p>

<p class=3DMsoNormal =
style=3D'line-height:12.0pt;mso-layout-grid-align:none;
text-autospace:none'><font size=3D2 color=3Dblack face=3D"Courier =
New"><span
style=3D'font-size:10.0pt;font-family:"Courier =
New";color:black'><o:p>&nbsp;</o:p></span></font></p>

<p class=3DMsoNormal =
style=3D'line-height:12.0pt;mso-layout-grid-align:none;
text-autospace:none'><font size=3D2 color=3Dblack face=3D"Courier =
New"><span
style=3D'font-size:10.0pt;font-family:"Courier New";color:black'>If =
anyone has
experience with OBEX GET in this case do you notice anything wrong with =
my
scenario?<o:p></o:p></span></font></p>

<p class=3DMsoNormal =
style=3D'line-height:12.0pt;mso-layout-grid-align:none;
text-autospace:none'><font size=3D2 color=3Dblack face=3D"Courier =
New"><span
style=3D'font-size:10.0pt;font-family:"Courier =
New";color:black'><o:p>&nbsp;</o:p></span></font></p>

<p class=3DMsoNormal =
style=3D'line-height:12.0pt;mso-layout-grid-align:none;
text-autospace:none'><font size=3D2 color=3Dblack face=3D"Courier =
New"><span
style=3D'font-size:10.0pt;font-family:"Courier New";color:black'>Thanks =
for any
help in advance, it is highly appreciated,<o:p></o:p></span></font></p>

<p class=3DMsoNormal =
style=3D'line-height:12.0pt;mso-layout-grid-align:none;
text-autospace:none'><font size=3D2 color=3Dblack face=3D"Courier =
New"><span
style=3D'font-size:10.0pt;font-family:"Courier New";color:black'>Scott =
Meesseman<o:p></o:p></span></font></p>

<p class=3DMsoNormal =
style=3D'line-height:12.0pt;mso-layout-grid-align:none;
text-autospace:none'><font size=3D2 color=3Dblack face=3DHelv><span =
style=3D'font-size:
10.0pt;font-family:Helv;mso-bidi-font-family:Helv;color:black'><o:p>&nbsp=
;</o:p></span></font></p>

<p class=3DMsoNormal><font size=3D2 face=3DArial><span =
style=3D'font-size:10.0pt;
font-family:Arial'><o:p>&nbsp;</o:p></span></font></p>

</div>

</body>

</html>

------=_NextPart_000_0001_01C6D9A3.CCAA3040--



--===============0259630156==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

-------------------------------------------------------------------------
Using Tomcat but need to do more? Need to support web services, security?
Get stuff done quickly with pre-integrated technology to make your job easier
Download IBM WebSphere Application Server v.1.0.1 based on Apache Geronimo
http://sel.as-us.falkag.net/sel?cmd=lnk&kid=120709&bid=263057&dat=121642
--===============0259630156==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Bluez-devel mailing list
Bluez-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-devel

--===============0259630156==--
