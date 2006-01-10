Return-Path: <bluez-users-admin@lists.sourceforge.net>
From: "Ehab El Maraghy" <e_elmaraghy@emajor.net>
To: <bluez-users@lists.sourceforge.net>
Message-ID: <000301c61629$2e3fc840$0200000a@EHABLAPTOP>
MIME-Version: 1.0
Content-Type: multipart/alternative;
	boundary="----=_NextPart_000_0004_01C61639.F1C89840"
Subject: [Bluez-users] ISSC  USB dongle Bluetooth problem
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
Date: Tue, 10 Jan 2006 23:02:31 +0200

This is a multi-part message in MIME format.

------=_NextPart_000_0004_01C61639.F1C89840
Content-Type: text/plain;
	charset="us-ascii"
Content-Transfer-Encoding: 7bit

Hi all
I have a new Bluetooth USB dongle
I want to use it to connect to my phone
I connect it to USB and type usbview I see it (hci_usb ) in red color
does that mean it need a driver ?
when i type hcitool dev (display local device ) 
it answers back with the 12 digits code of the dongle
but when i type hcitoolscan to discover my phone it scans and discovers
nothing and time out
any suggestions ? blueZ are opobex tool are installed.
 
Hciconfig -a gives  :
 
hci0:   Type: USB
        BD Address: 00:11:67:0C:4C:1F ACL MTU: 678:8  SCO MTU: 48:10
        UP RUNNING PSCAN ISCAN INQUIRY
        RX bytes:382 acl:0 sco:0 events:17 errors:0
        TX bytes:317 acl:0 sco:0 commands:17 errors:0
        Features: 0xff 0xff 0x8d 0x78 0x08 0x18 0x00 0x00
        Packet type: DM1 DM3 DM5 DH1 DH3 DH5 HV1 HV2 HV3
        Link policy: RSWITCH HOLD SNIFF PARK
        Link mode: SLAVE ACCEPT
        Name: 'BlueZ (0)'
        Class: 0x000100
        Service Classes: Unspecified
        Device Class: Computer, Uncategorized
        HCI Ver: 1.2 (0x2) HCI Rev: 0x1ae LMP Ver: 1.2 (0x2) LMP Subver:
0x1ae
        Manufacturer: Integrated System Solution Corp. (57)



------=_NextPart_000_0004_01C61639.F1C89840
Content-Type: text/html;
	charset="us-ascii"
Content-Transfer-Encoding: quoted-printable

<html xmlns:o=3D"urn:schemas-microsoft-com:office:office" =
xmlns:w=3D"urn:schemas-microsoft-com:office:word" =
xmlns:st1=3D"urn:schemas-microsoft-com:office:smarttags" =
xmlns=3D"http://www.w3.org/TR/REC-html40">

<head>
<META HTTP-EQUIV=3D"Content-Type" CONTENT=3D"text/html; =
charset=3Dus-ascii">


<meta name=3DProgId content=3DWord.Document>
<meta name=3DGenerator content=3D"Microsoft Word 10">
<meta name=3DOriginator content=3D"Microsoft Word 10">
<link rel=3DFile-List href=3D"cid:filelist.xml@01C61639.EF378D20">
<o:SmartTagType =
namespaceuri=3D"urn:schemas-microsoft-com:office:smarttags"
 name=3D"PlaceType"/>
<o:SmartTagType =
namespaceuri=3D"urn:schemas-microsoft-com:office:smarttags"
 name=3D"PlaceName"/>
<o:SmartTagType =
namespaceuri=3D"urn:schemas-microsoft-com:office:smarttags"
 name=3D"place"/>
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
  <w:PunctuationKerning/>
  <w:Compatibility>
   <w:BreakWrappedTables/>
   <w:SnapToGridInCell/>
   <w:ApplyBreakingRules/>
   <w:WrapTextWithPunct/>
   <w:UseAsianBreakRules/>
  </w:Compatibility>
  <w:BrowserLevel>MicrosoftInternetExplorer4</w:BrowserLevel>
 </w:WordDocument>
</xml><![endif]--><!--[if !mso]>
<style>
st1\:*{behavior:url(#default#ieooui) }
</style>
<![endif]-->
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
	mso-header-margin:36.0pt;
	mso-footer-margin:36.0pt;
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

<p class=3DMsoNormal><font size=3D3 face=3D"Times New Roman"><span =
style=3D'font-size:
12.0pt'>Hi all<br>
I have a new Bluetooth USB dongle<br>
I want to use it to connect to my phone<br>
I connect it to USB and type <span class=3DSpellE>usbview</span> I see =
it (<span
class=3DSpellE>hci_<span class=3DGramE>usb</span></span><span =
class=3DGramE> )</span>
in red color<br>
<span class=3DGramE>does</span> that mean it need a driver ?<br>
<span class=3DGramE>when</span> <span class=3DSpellE>i</span> type <span
class=3DSpellE>hcitool</span> dev (display local device ) <br>
it answers back with the 12 digits code of the dongle<br>
<span class=3DGramE>but</span> when <span class=3DSpellE>i</span> type =
<span
class=3DSpellE>hcitoolscan</span> to discover my phone it scans and =
discovers
nothing and time out<br>
<span class=3DGramE>any</span> suggestions ? <span class=3DSpellE><span
class=3DGramE>blueZ</span></span> are <span class=3DSpellE>opobex</span> =
tool are
installed.<o:p></o:p></span></font></p>

<p class=3DMsoNormal><font size=3D3 face=3D"Times New Roman"><span =
style=3D'font-size:
12.0pt'><o:p>&nbsp;</o:p></span></font></p>

<p class=3DMsoNormal><span class=3DSpellE><font size=3D3 face=3D"Times =
New Roman"><span
style=3D'font-size:12.0pt'>Hciconfig</span></font></span> &#8211;a <span
class=3DGramE>gives<span style=3D'mso-spacerun:yes'>&nbsp; =
</span>:</span><o:p></o:p></p>

<p class=3DMsoNormal><font size=3D1 color=3Dblack face=3D"Courier =
New"><span
style=3D'font-size:8.0pt;font-family:"Courier =
New";color:black'><o:p>&nbsp;</o:p></span></font></p>

<p class=3DMsoNormal><font size=3D1 color=3Dblack face=3D"Courier =
New"><span
style=3D'font-size:8.0pt;font-family:"Courier =
New";color:black'>hci0:<span
style=3D'mso-spacerun:yes'>&nbsp;&nbsp; </span>Type: USB<br>
<span =
style=3D'mso-spacerun:yes'>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
</span>BD Address: 00:11:67:0C:4C:1F ACL MTU: <span =
class=3DGramE>678:8<span
style=3D'mso-spacerun:yes'>&nbsp; </span>SCO</span> MTU: 48:10<br>
<span =
style=3D'mso-spacerun:yes'>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
</span>UP RUNNING PSCAN ISCAN INQUIRY<br>
<span =
style=3D'mso-spacerun:yes'>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
</span>RX bytes<span class=3DGramE>:382</span> acl:0 sco:0 events:17 =
errors:0<br>
<span =
style=3D'mso-spacerun:yes'>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
</span>TX bytes<span class=3DGramE>:317</span> acl:0 sco:0 commands:17 =
errors:0<br>
<span =
style=3D'mso-spacerun:yes'>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
</span>Features: 0xff <span class=3DSpellE>0xff</span> 0x8d 0x78 0x08 =
0x18 0x00 <span
class=3DSpellE>0x00</span><br>
<span =
style=3D'mso-spacerun:yes'>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
</span>Packet type: DM1 DM3 DM5 DH1 DH3 DH5 HV1 HV2 HV3<br>
<span =
style=3D'mso-spacerun:yes'>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
</span>Link policy: </span></font><st1:place><st1:PlaceName><font =
size=3D1
  color=3Dblack face=3D"Courier New"><span =
style=3D'font-size:8.0pt;font-family:"Courier New";
  color:black'>RSWITCH</span></font></st1:PlaceName><font size=3D1 =
color=3Dblack
 face=3D"Courier New"><span =
style=3D'font-size:8.0pt;font-family:"Courier New";
 color:black'> </span></font><st1:PlaceName><font size=3D1 color=3Dblack
  face=3D"Courier New"><span =
style=3D'font-size:8.0pt;font-family:"Courier New";
  color:black'>HOLD</span></font></st1:PlaceName><font size=3D1 =
color=3Dblack
 face=3D"Courier New"><span =
style=3D'font-size:8.0pt;font-family:"Courier New";
 color:black'> </span></font><st1:PlaceName><font size=3D1 color=3Dblack
  face=3D"Courier New"><span =
style=3D'font-size:8.0pt;font-family:"Courier New";
  color:black'>SNIFF</span></font></st1:PlaceName><font size=3D1 =
color=3Dblack
 face=3D"Courier New"><span =
style=3D'font-size:8.0pt;font-family:"Courier New";
 color:black'> </span></font><st1:PlaceType><font size=3D1 color=3Dblack
  face=3D"Courier New"><span =
style=3D'font-size:8.0pt;font-family:"Courier New";
  color:black'>PARK</span></font></st1:PlaceType></st1:place><font =
size=3D1
color=3Dblack face=3D"Courier New"><span =
style=3D'font-size:8.0pt;font-family:"Courier New";
color:black'><br>
<span =
style=3D'mso-spacerun:yes'>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
</span>Link mode: SLAVE ACCEPT<br>
<span =
style=3D'mso-spacerun:yes'>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
</span>Name: '<span class=3DSpellE>BlueZ</span> (0)'<br>
<span =
style=3D'mso-spacerun:yes'>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
</span>Class: 0x000100<br>
<span =
style=3D'mso-spacerun:yes'>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
</span>Service Classes: Unspecified<br>
<span =
style=3D'mso-spacerun:yes'>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
</span>Device Class: Computer, Uncategorized<br>
<span =
style=3D'mso-spacerun:yes'>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
</span>HCI <span class=3DSpellE>Ver</span>: 1.2 (0x2) HCI Rev: 0x1ae LMP =
<span
class=3DSpellE>Ver</span>: 1.2 (0x2) LMP <span =
class=3DSpellE>Subver</span>: 0x1ae<br>
<span =
style=3D'mso-spacerun:yes'>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
</span>Manufacturer: Integrated System Solution Corp. (57)<br =
style=3D'mso-special-character:
line-break'>
<![if !supportLineBreakNewLine]><br =
style=3D'mso-special-character:line-break'>
<![endif]></span></font><font size=3D2 face=3DArial><span =
style=3D'font-size:10.0pt;
font-family:Arial'><o:p></o:p></span></font></p>

</div>

</body>

</html>

------=_NextPart_000_0004_01C61639.F1C89840--



-------------------------------------------------------
This SF.net email is sponsored by: Splunk Inc. Do you grep through log files
for problems?  Stop!  Download the new AJAX search engine that makes
searching your log files as easy as surfing the  web.  DOWNLOAD SPLUNK!
http://ads.osdn.com/?ad_id=7637&alloc_id=16865&op=click
_______________________________________________
Bluez-users mailing list
Bluez-users@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-users
