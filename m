Return-Path: <bluez-devel-admin@lists.sourceforge.net>
Reply-To: <halam.rose@7layers-uk.com>
From: "Halam Rose" <halam.rose@7layers-uk.com>
To: "BlueZ Mailing List" <bluez-devel@lists.sourceforge.net>
Message-ID: <MGEGKHCLDAFHMAIHGKNCEEIMFIAA.halam.rose@7layers-uk.com>
MIME-Version: 1.0
Subject: [Bluez-devel] BlueZ Qualification FAQ.htm
Sender: bluez-devel-admin@lists.sourceforge.net
Errors-To: bluez-devel-admin@lists.sourceforge.net
List-Help: <mailto:bluez-devel-request@lists.sourceforge.net?subject=help>
List-Post: <mailto:bluez-devel@lists.sourceforge.net>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-devel>,
	<mailto:bluez-devel-request@lists.sourceforge.net?subject=subscribe>
List-Id: <bluez-devel.lists.sourceforge.net>
List-Unsubscribe: 
	<https://lists.sourceforge.net/lists/listinfo/bluez-devel>,
	<mailto:bluez-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: 
	<http://sourceforge.net/mailarchive/forum.php?forum=bluez-devel>
Date: Wed, 5 Mar 2003 18:31:22 -0000
Content-Type: multipart/mixed; boundary="=-wSA2P64LHy//ZmyqF5dR"


--=-wSA2P64LHy//ZmyqF5dR
Content-Type: multipart/alternative; boundary="=-dtSYvGD8dD6Q4FJHKhlB"


--=-dtSYvGD8dD6Q4FJHKhlB
Content-Transfer-Encoding: 8bit
Content-Type: text/plain; CHARSET=iso-8859-1


BlueZ Qualification FAQ

Authored          Halam Rose 7 layers UK
Contact            halam.rose@7layers-UK.com
<mailto:halam.rose@7layers-UK.com>
Version            5 March 2003 a

Introduction.
BlueZ is an open source project under the GNU GPL which provides a Bluetooth
stack for Linux.  BlueZ has been incorporated into the Linux kernel but at
this time it has no recognition from the Bluetooth SIG.  7 layers UK are a
Bluetooth test facility and have offered to help with the Qualification of
BlueZ. This document is intended to collect the questions we discuss about
BlueZ Qualification, some of the answers will develop into a project plan.

Please appreciate that this is living document which will evolve and future
versions may contain changes due to inaccuracies or changes in policy by the
contributors.  The answers have been reviewed by a BQB but since they are
fairly general they are expected to need adjustment as the issues become
clearer.

What does ‘Qualified’ mean?
What’s involved in Qualification?
What are the legal implications of not having BlueZ Qualified?
What are the benefits of Qualifying BlueZ?
            To the BlueZ Project?
            To BlueZ end users?
            To manufacturers incorporating BlueZ in their products?
            To manufacturers of Bluetooth modules?
            To 7 layers UK
What are the limitations of Qualifying BlueZ ?
            To the BlueZ Project?
            To BlueZ end users?
            To manufacturers incorporating BlueZ in their products?
            To manufacturers of Bluetooth modules?
What parts of BlueZ will be Qualified?
Which version of BlueZ will be Qualified?
What Platform will be used for Qualification? (Hardware, Distribution,
Kernel)
What costs are involved in Bluetooth Qualification?
Who will meet those costs for BlueZ?
Who owns BlueZ?
Where can I find out more about BlueZ?
Who will own the Qualified Product Listing?
Who will sign the conformance statements?
Who will control the Qualified Product Listing?
What does a Qualified Product Listing look like?
What other issues are there in taking a product to market?
Where can I find out about Bluetooth?
            As a user ?
            As a developer or manufacturer?
            Specifically Qualification?
How can I help?
What happens when BlueZ is updated?
How are different versions of Linux covered?

What does ‘Qualified’ mean?
Qualified means a product is listed on the Bluetooth Qualified Product List
(QPL)
http://qualweb.opengroup.org/Template2.cfm?LinkQualified=QualifiedProducts
which is the licensing mechanism for the patents that protect the Bluetooth
IP.


What’s involved in Qualification?

An individual called a Bluetooth Qualification Body (BQB) has to be
satisfied that the product meets the requirements laid out by the Bluetooth
SIG.  He examines a ‘Compliance Folder’ that contains test results referring
to the Bluetooth test spec
http://qualweb.opengroup.org/Template2.cfm?LinkID=1 along with declarations
and other documents.  More information can be found in the Programme
Reference Document (PRD)
http://qualweb.opengroup.org/Template2.cfm?LinkID=5.
A fee is collected by the BQB on behalf of the Bluetooth SIG which is
typically $7500.


What are the legal implications of not having BlueZ Qualified?

Without Qualification there is no licence to use the Bluetooth patents.


What are the benefits of Qualifying BlueZ?

            To the BlueZ Project?
Right now I don’t think any distributions claim or document Bluetooth
support.  It deserves proper recognition.  Presumably the Distros avoid
mention of Bluetooth because of the qualification issue.

            To BlueZ end users?
A Qualified BlueZ stack would enable manufactures to claim Linux support for
their Bluetooth adaptors.  That would give users confidence that they are
buying product that is proven to work and that they can get proper support
from the manufactures.

            To manufacturers incorporating BlueZ in their products?
BlueZ will be qualified as part of a  reference design so manufacturers will
still need to do some qualification work and have their own product listing.
They will however know that BlueZ is qualifiable and depending on their
implementation they may be able to refer to BlueZ as a ‘Qualified Subsystem’
and not have to repeat its testing.  Profile interop testing results can not
be referred to this way however except when combining products which are
listed on the ‘Complementary Subsystem List’ of the other (in which case no
testing may be necessary).

            To manufacturers of Bluetooth modules?
Manufacturers will be able to list BlueZ as a ‘Qualified Subsystem’ and be
listed as a Complementary Subsystem of BlueZ.  This will allow manufacturers
to claim Linux  support without breaching their Bluetooth SIG membership
agreement.  I would rather buy products from companies who make a public
commitment to Linux – wouldn’t you?  There will be a BQB who is familiar
with BlueZ and able to make good quality decisions on what of the existing
qualification can be re-used by you.

            To 7 layers UK
7 Layers UK want to establish themselves as the best Bluetooth Qualification
facility to handle Linux products, and in the process to make money by
providing Bluetooth Qualification services of value to manufacturers who
want to take advantage of BlueZ’s Qualified status.  The original BQB
remains responsible for adding to the Compatible Subsystems List, though
other BQBs will be able to list BlueZ as a Complementary Subsystem of
products they are handling.


What are the limitations of Qualifying BlueZ ?

            To the BlueZ Project?
Testing for the Bluetooth Qualification process may bring up some issues
that for a user are of no consequence but cause test case failure.  The
BlueZ developers must be committed to resolving these.  Users of the
Bluetooth IP have to accept conformity with the specification.

            To BlueZ end users?
Initially only part of the full BlueZ functionality will be included in the
listing, but this does not imply that anything in BlueZ is non-compliant.
Can you think of any other down sides?

            To manufacturers incorporating BlueZ in their products?
Initially only part of the full BlueZ functionality will be included in the
listing, but this does not imply that anything in BlueZ is non-compliant. If
you submit your own test results they may allow the BlueZ listing to be
extended for everyone’s benefit.  It will be a BQB decision about how much
retesting will have to be done for your application.  The best informed BQB
will be the 7 layers UK BQB who would make the first listing.

            To manufacturers of Bluetooth modules?
Initially only part of the full BlueZ functionality will be included in the
listing, but this does not imply that anything in BlueZ is non-compliant.
If you submit your own test results they may allow the BlueZ listing to be
extended for everyone’s benefit.  You will be able to qualify your products
with BlueZ as a Qualified Subsystem but must come through the 7 layers UK
BQB to be included on the BlueZ Complementary Subsystems List.


What parts of BlueZ will be Qualified?

It makes sense to make a basic listing first then extend it as more testing
is completed.  The minimum for qualification is GAP which would make BlueZ a
type 1 product under the definition in section 5.5.2.1 of the PRD.


Which version of BlueZ will be Qualified?

TBD

What Platform will be used for Qualification? (Hardware, Distribution,
Kernel)
TBD,
Kernel 2.4.21-pre5 includes all Bluetooth fixes and updates (except the SCO
support for USB). Intel platform with Redhat 7.3 is available as is a CSR
Casira which can be used as a serial or USB bluetooth adaptor.


What costs are involved in Bluetooth Qualification?

Testing, report writing, BQB time, Bluetooth SIG listing fee Usually $7500


Who will meet those costs for BlueZ?

Current thinking is that the initial work will be done by 7 layers UK
without charge but help with the listing fee will be requested.  The listing
fee is paid to the Bluetooth SIG, not retained by 7 layers UK.  The fees
fund the activities of the SIG, promoting Bluetooth technology.


Who owns BlueZ?

Copyright belongs to Qualcomm. – is this entirely correct?


Where can I find out more about BlueZ?


http://bluez.sourceforge.net/



Who will own the Qualified Product Listing?

Not yet clear, usually listings are made in the name of a manufacturer – is
there actually a BlueZ organisation??


Who will sign the conformance statements?

TBD one of the BlueZ developers.


Who will control the Qualified Product Listing?

The BQB from 7 layers UK,  It is normal for the same BQB to continue to
maintain and update a listing once it is established.


What does a Qualified Product Listing look like?

http://qualweb.opengroup.org/Template2.cfm?LinkQualified=QualifiedProducts&D
etails=Yes&ProductID=1086
<http://qualweb.opengroup.org/Template2.cfm?LinkQualified=QualifiedProducts&
Details=Yes&ProductID=1086>  shows Widcoms Bluetooth stack for Windows.


What other issues are there in taking a product to market?

Apart from Bluetooth Qualification governments regulate market access
through Regulatory Approvals mechanisms and  the use of standards like CE
marking in Europe, UL or equivalent safety standards in USA.  Testing to FCC
part 15, ETS 300328 and ETS 300489 are usually required before filing a
compliance folder with the various authorities around the world.  This kind
of stuff is non trivial and requires some expertise and local knowledge.
Here I can plug another service available from 7 layers UK.  It is important
to understand the different role of regulation (CE marking, approvals,
certifications to meet regulatory purposes) and Bluetooth Qualification
which allows a company to benefit from the work done to create the Bluetooth
Specification, controlled by patent, copyright and licensing..


Where can I find out about Bluetooth?

            As a user ?
            http://www.bluetooth.com/ <http://www.bluetooth.com/>

            As a developer or manufacturer?
            http://www.bluetooth.org <http://www.bluetooth.org/>
specifications etc

            Specifically Qualification?
            http://qualweb.opengroup.org/ <http://qualweb.opengroup.org/>
            test specifications, test case status, qualified product list


How can I help?

We are currently in a brainstorming phase so any input is useful:
Can you enhance these answers?
Can you ask any important questions?
What benefits to Qualification do you see?
What resources can you offer?
How would you like to help?


What Happens when BlueZ is updated?

The listing can be revised subject to appropriate evidence that the BQB will
specify when the changes are understood.   Minor changes, bug fixes and the
likes can be aggregated every few months.


How are different versions of Linux covered?

The Widcom listing
http://qualweb.opengroup.org/Template2.cfm?LinkQualified=QualifiedProducts&D
etails=Yes&ProductID=1086
<http://qualweb.opengroup.org/Template2.cfm?LinkQualified=QualifiedProducts&
Details=Yes&ProductID=1086>  is an example where the same stack is run on
different versions of Windows.  The same principle applies to the flavours
of Linux but the exact extent, the range of processors, distros and kernels
is still under discussion.




--=-dtSYvGD8dD6Q4FJHKhlB
Content-Transfer-Encoding: quoted-printable
Content-Type: text/html; CHARSET=iso-8859-1

<html xmlns:o=3D"urn:schemas-microsoft-com:office:office" xmlns:w=3D"urn:sc=
hemas-microsoft-com:office:word" xmlns=3D"http://www.w3.org/TR/REC-html40">

<head>
<meta http-equiv=3DContent-Type content=3D"text/html; charset=3Diso-8859-1"=
>
<meta name=3DProgId content=3DWord.Document>
<meta name=3DGenerator content=3D"Microsoft Word 9">
<meta name=3DOriginator content=3D"Microsoft Word 9">
<link rel=3DFile-List href=3D"cid:filelist.xml@01C2E345.6B6CB490">
<title>BlueZ Qualification FAQ</title>
<!--[if gte mso 9]><xml>
 <o:DocumentProperties>
  <o:Revision>4</o:Revision>
  <o:TotalTime>1802</o:TotalTime>
  <o:LastPrinted>2003-03-04T17:20:00Z</o:LastPrinted>
  <o:Created>2003-03-05T12:02:00Z</o:Created>
  <o:LastSaved>2003-03-05T18:30:00Z</o:LastSaved>
  <o:Pages>4</o:Pages>
  <o:Words>1717</o:Words>
  <o:Characters>9791</o:Characters>
  <o:Company>7 Layers UK Ltd</o:Company>
  <o:Lines>81</o:Lines>
  <o:Paragraphs>19</o:Paragraphs>
  <o:CharactersWithSpaces>12024</o:CharactersWithSpaces>
  <o:Version>9.3821</o:Version>
 </o:DocumentProperties>
 <o:OfficeDocumentSettings>
  <o:DoNotRelyOnCSS/>
 </o:OfficeDocumentSettings>
</xml><![endif]--><!--[if gte mso 9]><xml>
 <w:WordDocument>
  <w:EnvelopeVis/>
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
h1
	{mso-style-next:Normal;
	margin-top:12.0pt;
	margin-right:0cm;
	margin-bottom:3.0pt;
	margin-left:0cm;
	mso-pagination:widow-orphan;
	page-break-after:avoid;
	mso-outline-level:1;
	font-size:16.0pt;
	font-family:Arial;
	mso-font-kerning:16.0pt;}
h2
	{mso-style-next:Normal;
	margin:0cm;
	margin-bottom:.0001pt;
	mso-pagination:widow-orphan;
	page-break-after:avoid;
	mso-outline-level:2;
	font-size:12.0pt;
	font-family:"Times New Roman";}
p.MsoBodyText, li.MsoBodyText, div.MsoBodyText
	{margin:0cm;
	margin-bottom:.0001pt;
	mso-pagination:widow-orphan;
	mso-layout-grid-align:none;
	text-autospace:none;
	font-size:10.0pt;
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
@page Section1
	{size:595.3pt 841.9pt;
	margin:72.0pt 90.0pt 72.0pt 90.0pt;
	mso-header-margin:35.4pt;
	mso-footer-margin:35.4pt;
	mso-paper-source:0;}
div.Section1
	{page:Section1;}
-->
</style>
</head>

<body lang=3DEN-GB link=3Dblue vlink=3Dpurple style=3D'tab-interval:36.0pt'=
>

<div class=3DSection1>

<h1><b style=3D'mso-bidi-font-weight:normal'><font size=3D5 face=3DArial><s=
pan
style=3D'font-size:16.0pt'>BlueZ Qualification FAQ</span></font></b></h1>

<p class=3DMsoNormal><font size=3D3 face=3D"Times New Roman"><span style=3D=
'font-size:
12.0pt'>Authored <span style=3D'mso-tab-count:1'>&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp; </span>Halam
Rose 7 layers UK<span style=3D"mso-spacerun: yes">&nbsp; </span></span></fo=
nt></p>

<p class=3DMsoNormal><font size=3D3 face=3D"Times New Roman"><span style=3D=
'font-size:
12.0pt'>Contact <span style=3D'mso-tab-count:1'>&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; </span><a
href=3D"mailto:halam.rose@7layers-UK.com">halam.rose@7layers-UK.com</a></sp=
an></font></p>

<p class=3DMsoNormal><font size=3D3 face=3D"Times New Roman"><span style=3D=
'font-size:
12.0pt'>Version<span style=3D'mso-tab-count:1'>&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; </span>5
March 2003 a</span></font></p>

<p class=3DMsoNormal><font size=3D3 face=3D"Times New Roman"><span style=3D=
'font-size:
12.0pt'><![if !supportEmptyParas]>&nbsp;<![endif]><o:p></o:p></span></font>=
</p>

<p class=3DMsoNormal><b><font size=3D3 face=3D"Times New Roman"><span
style=3D'font-size:12.0pt;font-weight:bold'>Introduction.<o:p></o:p></span>=
</font></b></p>

<p class=3DMsoNormal><font size=3D3 face=3D"Times New Roman"><span style=3D=
'font-size:
12.0pt'>BlueZ is an open source project under the GNU GPL which provides a
Bluetooth stack for Linux.<span style=3D"mso-spacerun: yes">&nbsp; </span>B=
lueZ
has been incorporated into the Linux kernel but at this time it has no
recognition from the Bluetooth SIG.<span style=3D"mso-spacerun: yes">&nbsp;
</span>7 layers UK are a Bluetooth test facility and have offered to help w=
ith
the Qualification of BlueZ. This document is intended to collect the questi=
ons
we discuss about BlueZ Qualification, some of the answers will develop into=
 a
project plan.</span></font></p>

<p class=3DMsoNormal><font size=3D3 face=3D"Times New Roman"><span style=3D=
'font-size:
12.0pt'><![if !supportEmptyParas]>&nbsp;<![endif]><o:p></o:p></span></font>=
</p>

<p class=3DMsoNormal><font size=3D3 face=3D"Times New Roman"><span style=3D=
'font-size:
12.0pt'>Please appreciate that this is living document which will evolve an=
d
future versions may contain changes due to inaccuracies or changes in polic=
y by
the contributors.<span style=3D"mso-spacerun: yes">&nbsp; </span>The answer=
s have
been reviewed by a BQB but since they are fairly general they are expected =
to
need adjustment as the issues become clearer.</span></font></p>

<p class=3DMsoNormal><font size=3D3 face=3D"Times New Roman"><span style=3D=
'font-size:
12.0pt'><![if !supportEmptyParas]>&nbsp;<![endif]><o:p></o:p></span></font>=
</p>

<p class=3DMsoNormal><font size=3D3 face=3D"Times New Roman"><span style=3D=
'font-size:
12.0pt'><a href=3D"#OLE_LINK1">What does &#8216;Qualified&#8217; mean?</a><=
/span></font></p>

<p class=3DMsoNormal><font size=3D3 face=3D"Times New Roman"><span style=3D=
'font-size:
12.0pt'><a href=3D"#OLE_LINK2">What&#8217;s involved in Qualification?</a><=
/span></font></p>

<p class=3DMsoNormal><font size=3D3 face=3D"Times New Roman"><span style=3D=
'font-size:
12.0pt'><a href=3D"#OLE_LINK3">What are the legal implications of not havin=
g
BlueZ Qualified?</a></span></font></p>

<p class=3DMsoNormal><font size=3D3 face=3D"Times New Roman"><span style=3D=
'font-size:
12.0pt'><a href=3D"#OLE_LINK4">What are the benefits of Qualifying BlueZ?</=
a></span></font></p>

<p class=3DMsoNormal><font size=3D3 face=3D"Times New Roman"><span style=3D=
'font-size:
12.0pt'><span style=3D'mso-tab-count:1'>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; </span><a
href=3D"#OLE_LINK4">To the BlueZ Project?</a></span></font></p>

<p class=3DMsoNormal><font size=3D3 face=3D"Times New Roman"><span style=3D=
'font-size:
12.0pt'><span style=3D'mso-tab-count:1'>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; </span><a
href=3D"#OLE_LINK5">To BlueZ end users?</a></span></font></p>

<p class=3DMsoNormal><font size=3D3 face=3D"Times New Roman"><span style=3D=
'font-size:
12.0pt'><span style=3D'mso-tab-count:1'>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; </span><a
href=3D"#OLE_LINK6">To manufacturers incorporating BlueZ in their products?=
</a> </span></font></p>

<p class=3DMsoNormal><font size=3D3 face=3D"Times New Roman"><span style=3D=
'font-size:
12.0pt'><span style=3D'mso-tab-count:1'>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; </span><a
href=3D"#OLE_LINK7">To manufacturers of Bluetooth modules?</a></span></font=
></p>

<p class=3DMsoNormal><font size=3D3 face=3D"Times New Roman"><span style=3D=
'font-size:
12.0pt'><span style=3D'mso-tab-count:1'>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; </span><a
href=3D"#OLE_LINK8">To 7 layers UK</a></span></font></p>

<p class=3DMsoNormal><font size=3D3 face=3D"Times New Roman"><span style=3D=
'font-size:
12.0pt'><a href=3D"#OLE_LINK9">What are the limitations of Qualifying BlueZ=
 ?</a></span></font></p>

<p class=3DMsoNormal><font size=3D3 face=3D"Times New Roman"><span style=3D=
'font-size:
12.0pt'><span style=3D'mso-tab-count:1'>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; </span><a
href=3D"#OLE_LINK9">To the BlueZ Project?</a></span></font></p>

<p class=3DMsoNormal><font size=3D3 face=3D"Times New Roman"><span style=3D=
'font-size:
12.0pt'><span style=3D'mso-tab-count:1'>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; </span><a
href=3D"#OLE_LINK10">To BlueZ end users?</a></span></font></p>

<p class=3DMsoNormal><font size=3D3 face=3D"Times New Roman"><span style=3D=
'font-size:
12.0pt'><span style=3D'mso-tab-count:1'>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; </span><a
href=3D"#OLE_LINK11">To manufacturers incorporating BlueZ in their products=
?</a> </span></font></p>

<p class=3DMsoNormal><font size=3D3 face=3D"Times New Roman"><span style=3D=
'font-size:
12.0pt'><span style=3D'mso-tab-count:1'>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; </span><a
href=3D"#OLE_LINK12">To manufacturers of Bluetooth modules?</a></span></fon=
t></p>

<p class=3DMsoNormal><font size=3D3 face=3D"Times New Roman"><span style=3D=
'font-size:
12.0pt'><a href=3D"#OLE_LINK13">What parts of BlueZ will be Qualified</a>?<=
/span></font></p>

<p class=3DMsoNormal><font size=3D3 face=3D"Times New Roman"><span style=3D=
'font-size:
12.0pt'><a href=3D"#OLE_LINK14">Which version of BlueZ will be Qualified?</=
a></span></font></p>

<p class=3DMsoNormal><font size=3D3 face=3D"Times New Roman"><span style=3D=
'font-size:
12.0pt'><a href=3D"#OLE_LINK15">What Platform will be used for Qualificatio=
n?
(Hardware, Distribution, Kernel)</a></span></font></p>

<p class=3DMsoNormal><font size=3D3 face=3D"Times New Roman"><span style=3D=
'font-size:
12.0pt'><a href=3D"#OLE_LINK16">What costs are involved in Bluetooth
Qualification?</a></span></font></p>

<p class=3DMsoNormal><font size=3D3 face=3D"Times New Roman"><span style=3D=
'font-size:
12.0pt'><a href=3D"#OLE_LINK17">Who will meet those costs for BlueZ?</a></s=
pan></font></p>

<p class=3DMsoNormal><font size=3D3 face=3D"Times New Roman"><span style=3D=
'font-size:
12.0pt'><a href=3D"#OLE_LINK18">Who owns BlueZ?</a></span></font></p>

<p class=3DMsoNormal><font size=3D3 face=3D"Times New Roman"><span style=3D=
'font-size:
12.0pt'><a href=3D"#OLE_LINK19">Where can I find out more about BlueZ?</a><=
/span></font></p>

<p class=3DMsoNormal><font size=3D3 face=3D"Times New Roman"><span style=3D=
'font-size:
12.0pt'><a href=3D"#OLE_LINK20">Who will own the Qualified Product Listing?=
</a></span></font></p>

<p class=3DMsoNormal><font size=3D3 face=3D"Times New Roman"><span style=3D=
'font-size:
12.0pt'><a href=3D"#OLE_LINK21">Who will sign the conformance statements?</=
a></span></font></p>

<p class=3DMsoNormal><font size=3D3 face=3D"Times New Roman"><span style=3D=
'font-size:
12.0pt'><a href=3D"#OLE_LINK22">Who will control the Qualified Product List=
ing?</a></span></font></p>

<p class=3DMsoNormal><font size=3D3 face=3D"Times New Roman"><span style=3D=
'font-size:
12.0pt'><a href=3D"#OLE_LINK23">What does a Qualified Product Listing look =
like?</a></span></font></p>

<p class=3DMsoNormal><font size=3D3 face=3D"Times New Roman"><span style=3D=
'font-size:
12.0pt'><a href=3D"#OLE_LINK24">What other issues are there in taking a pro=
duct
to market?</a></span></font></p>

<p class=3DMsoNormal><font size=3D3 face=3D"Times New Roman"><span style=3D=
'font-size:
12.0pt'><a href=3D"#OLE_LINK25">Where can I find out about Bluetooth?</a></=
span></font></p>

<p class=3DMsoNormal><font size=3D3 face=3D"Times New Roman"><span style=3D=
'font-size:
12.0pt'><span style=3D'mso-tab-count:1'>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; </span><a
href=3D"#OLE_LINK25">As a user ?</a></span></font></p>

<p class=3DMsoNormal><font size=3D3 face=3D"Times New Roman"><span style=3D=
'font-size:
12.0pt'><span style=3D'mso-tab-count:1'>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; </span><a
href=3D"#OLE_LINK26">As a developer or manufacturer?</a></span></font></p>

<p class=3DMsoNormal><font size=3D3 face=3D"Times New Roman"><span style=3D=
'font-size:
12.0pt'><span style=3D'mso-tab-count:1'>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; </span><a
href=3D"#OLE_LINK27">Specifically Qualification?</a></span></font></p>

<p class=3DMsoNormal><font size=3D3 face=3D"Times New Roman"><span style=3D=
'font-size:
12.0pt'><a href=3D"#OLE_LINK28">How can I help?</a></span></font></p>

<p class=3DMsoNormal><font size=3D3 face=3D"Times New Roman"><span style=3D=
'font-size:
12.0pt'><a href=3D"#OLE_LINK29">What happens when BlueZ is updated?</a></sp=
an></font></p>

<p class=3DMsoNormal><font size=3D3 face=3D"Times New Roman"><span style=3D=
'font-size:
12.0pt'><a href=3D"#OLE_LINK30">How are different versions of Linux covered=
?</a></span></font></p>

<p class=3DMsoNormal><font size=3D3 face=3D"Times New Roman"><span style=3D=
'font-size:
12.0pt'><![if !supportEmptyParas]>&nbsp;<![endif]><o:p></o:p></span></font>=
</p>

<p class=3DMsoNormal><a name=3D"OLE_LINK1"></a><b><font size=3D3
face=3D"Times New Roman"><span style=3D'font-size:12.0pt;font-weight:bold'>=
What
does &#8216;Qualified&#8217; mean?<o:p></o:p></span></font></b></p>

<p class=3DMsoNormal><font size=3D3 face=3D"Times New Roman"><span style=3D=
'font-size:
12.0pt'>Qualified means a product is listed on the Bluetooth Qualified Prod=
uct
List (QPL)</span></font></p>

<p class=3DMsoNormal><font size=3D3 face=3D"Times New Roman"><span style=3D=
'font-size:
12.0pt'><a
href=3D"http://qualweb.opengroup.org/Template2.cfm?LinkQualified=3DQualifie=
dProducts">http://qualweb.opengroup.org/Template2.cfm?LinkQualified=3DQuali=
fiedProducts</a>
which is the licensing mechanism for the patents that protect the Bluetooth=
 IP.
</span></font></p>

<p class=3DMsoNormal><font size=3D3 face=3D"Times New Roman"><span style=3D=
'font-size:
12.0pt'><![if !supportEmptyParas]>&nbsp;<![endif]><o:p></o:p></span></font>=
</p>

<h2><a name=3D"OLE_LINK2"></a><b style=3D'mso-bidi-font-weight:normal'><fon=
t
size=3D3 face=3D"Times New Roman"><span style=3D'font-size:12.0pt'>What&#82=
17;s involved in
Qualification?</span></font></b></h2>

<p class=3DMsoNormal><font size=3D3 face=3D"Times New Roman"><span style=3D=
'font-size:
12.0pt'>An individual called a Bluetooth Qualification Body (BQB) has to be
satisfied that the product meets the requirements laid out by the Bluetooth
SIG.<span style=3D"mso-spacerun: yes">&nbsp; </span>He examines a &#8216;Co=
mpliance
Folder&#8217; that contains test results referring to the Bluetooth test sp=
ec </span></font></p>

<p class=3DMsoNormal><font size=3D3 face=3D"Times New Roman"><span style=3D=
'font-size:
12.0pt'><a href=3D"http://qualweb.opengroup.org/Template2.cfm?LinkID=3D1">h=
ttp://qualweb.opengroup.org/Template2.cfm?LinkID=3D1</a>
along with declarations and other documents.<span style=3D"mso-spacerun:
yes">&nbsp; </span>More information can be found in the Programme Reference
Document (PRD) <a href=3D"http://qualweb.opengroup.org/Template2.cfm?LinkID=
=3D5">http://qualweb.opengroup.org/Template2.cfm?LinkID=3D5</a>.</span></fo=
nt></p>

<p class=3DMsoNormal><font size=3D3 face=3D"Times New Roman"><span style=3D=
'font-size:
12.0pt'>A fee is collected by the BQB on behalf of the Bluetooth SIG which =
is
typically $7500.</span></font></p>

<p class=3DMsoNormal><font size=3D3 face=3D"Times New Roman"><span style=3D=
'font-size:
12.0pt'><![if !supportEmptyParas]>&nbsp;<![endif]><o:p></o:p></span></font>=
</p>

<h2><a name=3D"OLE_LINK3"></a><b style=3D'mso-bidi-font-weight:normal'><fon=
t
size=3D3 face=3D"Times New Roman"><span style=3D'font-size:12.0pt'>What are=
 the legal
implications of not having BlueZ Qualified?</span></font></b></h2>

<p class=3DMsoNormal><font size=3D3 face=3D"Times New Roman"><span style=3D=
'font-size:
12.0pt'>Without Qualification there is no licence to use the Bluetooth pate=
nts.</span></font></p>

<p class=3DMsoNormal><font size=3D3 face=3D"Times New Roman"><span style=3D=
'font-size:
12.0pt'><![if !supportEmptyParas]>&nbsp;<![endif]><o:p></o:p></span></font>=
</p>

<h2><a name=3D"OLE_LINK4"></a><b style=3D'mso-bidi-font-weight:normal'><fon=
t
size=3D3 face=3D"Times New Roman"><span style=3D'font-size:12.0pt'>What are=
 the
benefits of Qualifying BlueZ?</span></font></b></h2>

<p class=3DMsoNormal><font size=3D3 face=3D"Times New Roman"><span style=3D=
'font-size:
12.0pt'><span style=3D'mso-tab-count:1'>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; </span><b><span
style=3D'font-weight:bold'>To the BlueZ Project?<o:p></o:p></span></b></spa=
n></font></p>

<p class=3DMsoNormal><font size=3D3 face=3D"Times New Roman"><span style=3D=
'font-size:
12.0pt'>Right now I don&#8217;t think any distributions claim or document B=
luetooth
support.<span style=3D"mso-spacerun: yes">&nbsp; </span>It deserves proper
recognition.<span style=3D"mso-spacerun: yes">&nbsp; </span>Presumably the
Distros avoid mention of Bluetooth because of the qualification issue.</spa=
n></font></p>

<p class=3DMsoNormal><font size=3D3 face=3D"Times New Roman"><span style=3D=
'font-size:
12.0pt'><![if !supportEmptyParas]>&nbsp;<![endif]><o:p></o:p></span></font>=
</p>

<p class=3DMsoNormal><font size=3D3 face=3D"Times New Roman"><span style=3D=
'font-size:
12.0pt'><span style=3D'mso-tab-count:1'>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; </span><a
name=3D"OLE_LINK5"></a><b><span style=3D'font-weight:bold'>To BlueZ end use=
rs?<o:p></o:p></span></b></span></font></p>

<p class=3DMsoNormal><font size=3D3 face=3D"Times New Roman"><span style=3D=
'font-size:
12.0pt'>A Qualified BlueZ stack would enable manufactures to claim Linux
support for their Bluetooth adaptors.<span style=3D"mso-spacerun: yes">&nbs=
p;
</span>That would give users confidence that they are buying product that i=
s
proven to work and that they can get proper support from the manufactures. =
</span></font></p>

<p class=3DMsoNormal><font size=3D3 face=3D"Times New Roman"><span style=3D=
'font-size:
12.0pt'><![if !supportEmptyParas]>&nbsp;<![endif]><o:p></o:p></span></font>=
</p>

<p class=3DMsoNormal><font size=3D3 face=3D"Times New Roman"><span style=3D=
'font-size:
12.0pt'><span style=3D'mso-tab-count:1'>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; </span><a
name=3D"OLE_LINK6"></a><b><span style=3D'font-weight:bold'>To manufacturers
incorporating BlueZ in their products? <o:p></o:p></span></b></span></font>=
</p>

<p class=3DMsoNormal><font size=3D3 face=3D"Times New Roman"><span style=3D=
'font-size:
12.0pt'>BlueZ will be qualified as part of a <span style=3D"mso-spacerun:
yes">&nbsp;</span>reference design so manufacturers will still need to do s=
ome
qualification work and have their own product listing.<span
style=3D"mso-spacerun: yes">&nbsp; </span>They will however know that BlueZ=
 is
qualifiable and depending on their implementation they may be able to refer=
 to
BlueZ as a &#8216;Qualified Subsystem&#8217; and not have to repeat its tes=
ting.<span
style=3D"mso-spacerun: yes">&nbsp; </span>Profile interop testing results c=
an not
be referred to this way however except when combining products which are li=
sted
on the &#8216;Complementary Subsystem List&#8217; of the other (in which ca=
se no testing
may be necessary).</span></font></p>

<p class=3DMsoNormal><font size=3D3 face=3D"Times New Roman"><span style=3D=
'font-size:
12.0pt'><![if !supportEmptyParas]>&nbsp;<![endif]><o:p></o:p></span></font>=
</p>

<p class=3DMsoNormal><font size=3D3 face=3D"Times New Roman"><span style=3D=
'font-size:
12.0pt'><span style=3D'mso-tab-count:1'>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; </span><a
name=3D"OLE_LINK7"></a><b><span style=3D'font-weight:bold'>To manufacturers=
 of
Bluetooth modules?<o:p></o:p></span></b></span></font></p>

<p class=3DMsoNormal><font size=3D3 face=3D"Times New Roman"><span style=3D=
'font-size:
12.0pt'>Manufacturers will be able to list BlueZ as a &#8216;Qualified Subs=
ystem&#8217; and
be listed as a Complementary Subsystem of BlueZ.<span style=3D"mso-spacerun=
:
yes">&nbsp; </span>This will allow manufacturers to claim Linux<span
style=3D"mso-spacerun: yes">&nbsp; </span>support without breaching their
Bluetooth SIG membership agreement.<span style=3D"mso-spacerun: yes">&nbsp;
</span>I would rather buy products from companies who make a public commitm=
ent
to Linux &#8211; wouldn&#8217;t you?<span style=3D"mso-spacerun: yes">&nbsp=
; </span>There
will be a BQB who is familiar with BlueZ and able to make good quality
decisions on what of the existing qualification can be re-used by you.</spa=
n></font></p>

<p class=3DMsoNormal><font size=3D3 face=3D"Times New Roman"><span style=3D=
'font-size:
12.0pt'><![if !supportEmptyParas]>&nbsp;<![endif]><o:p></o:p></span></font>=
</p>

<p class=3DMsoNormal><font size=3D3 face=3D"Times New Roman"><span style=3D=
'font-size:
12.0pt'><span style=3D'mso-tab-count:1'>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; </span><a
name=3D"OLE_LINK8"></a><b><span style=3D'font-weight:bold'>To 7 layers UK<o=
:p></o:p></span></b></span></font></p>

<p class=3DMsoNormal><font size=3D3 face=3D"Times New Roman"><span style=3D=
'font-size:
12.0pt'>7 Layers UK want to establish themselves as the best Bluetooth
Qualification facility to handle Linux products, and in the process to make
money by providing Bluetooth Qualification services of value to manufacture=
rs
who want to take advantage of BlueZ&#8217;s Qualified status.<span
style=3D"mso-spacerun: yes">&nbsp; </span>The original BQB remains responsi=
ble
for adding to the Compatible Subsystems List, though other BQBs will be abl=
e to
list BlueZ as a Complementary Subsystem of products they are handling.</spa=
n></font></p>

<p class=3DMsoNormal><font size=3D3 face=3D"Times New Roman"><span style=3D=
'font-size:
12.0pt'><![if !supportEmptyParas]>&nbsp;<![endif]><o:p></o:p></span></font>=
</p>

<h2><a name=3D"OLE_LINK9"></a><b style=3D'mso-bidi-font-weight:normal'><fon=
t
size=3D3 face=3D"Times New Roman"><span style=3D'font-size:12.0pt'>What are=
 the
limitations of Qualifying BlueZ ?</span></font></b></h2>

<p class=3DMsoNormal><font size=3D3 face=3D"Times New Roman"><span style=3D=
'font-size:
12.0pt'><span style=3D'mso-tab-count:1'>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; </span><b><span
style=3D'font-weight:bold'>To the BlueZ Project?<o:p></o:p></span></b></spa=
n></font></p>

<p class=3DMsoNormal><font size=3D3 face=3D"Times New Roman"><span style=3D=
'font-size:
12.0pt'>Testing for the Bluetooth Qualification process may bring up some
issues that for a user are of no consequence but cause test case failure.<s=
pan
style=3D"mso-spacerun: yes">&nbsp; </span>The BlueZ developers must be comm=
itted
to resolving these.<span style=3D"mso-spacerun: yes">&nbsp; </span>Users of=
 the
Bluetooth IP have to accept conformity with the specification.</span></font=
></p>

<p class=3DMsoNormal><font size=3D3 face=3D"Times New Roman"><span style=3D=
'font-size:
12.0pt'><![if !supportEmptyParas]>&nbsp;<![endif]><o:p></o:p></span></font>=
</p>

<p class=3DMsoNormal><font size=3D3 face=3D"Times New Roman"><span style=3D=
'font-size:
12.0pt'><span style=3D'mso-tab-count:1'>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; </span><a
name=3D"OLE_LINK10"></a><b><span style=3D'font-weight:bold'>To BlueZ end us=
ers?<o:p></o:p></span></b></span></font></p>

<p class=3DMsoNormal><font size=3D3 face=3D"Times New Roman"><span style=3D=
'font-size:
12.0pt'>Initially only part of the full BlueZ functionality will be include=
d in
the listing, but this does not imply that anything in BlueZ is
non-compliant.<span style=3D"mso-spacerun: yes">&nbsp; </span>Can you think=
 of
any other down sides?</span></font></p>

<p class=3DMsoNormal><font size=3D3 face=3D"Times New Roman"><span style=3D=
'font-size:
12.0pt'><![if !supportEmptyParas]>&nbsp;<![endif]><o:p></o:p></span></font>=
</p>

<p class=3DMsoNormal><font size=3D3 face=3D"Times New Roman"><span style=3D=
'font-size:
12.0pt'><span style=3D'mso-tab-count:1'>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; </span><a
name=3D"OLE_LINK11"></a><b><span style=3D'font-weight:bold'>To manufacturer=
s
incorporating BlueZ in their products? <o:p></o:p></span></b></span></font>=
</p>

<p class=3DMsoNormal><font size=3D3 face=3D"Times New Roman"><span style=3D=
'font-size:
12.0pt'>Initially only part of the full BlueZ functionality will be include=
d in
the listing, but this does not imply that anything in BlueZ is non-complian=
t.
If you submit your own test results they may allow the BlueZ listing to be
extended for everyone&#8217;s benefit.<span style=3D"mso-spacerun: yes">&nb=
sp;
</span>It will be a BQB decision about how much retesting will have to be d=
one
for your application.<span style=3D"mso-spacerun: yes">&nbsp; </span>The be=
st
informed BQB will be the 7 layers UK BQB who would make the first listing.<=
/span></font></p>

<p class=3DMsoNormal><font size=3D3 face=3D"Times New Roman"><span style=3D=
'font-size:
12.0pt'><![if !supportEmptyParas]>&nbsp;<![endif]><o:p></o:p></span></font>=
</p>

<p class=3DMsoNormal><font size=3D3 face=3D"Times New Roman"><span style=3D=
'font-size:
12.0pt'><span style=3D'mso-tab-count:1'>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; </span><a
name=3D"OLE_LINK12"></a><b><span style=3D'font-weight:bold'>To manufacturer=
s of
Bluetooth modules?<o:p></o:p></span></b></span></font></p>

<p class=3DMsoNormal><font size=3D3 face=3D"Times New Roman"><span style=3D=
'font-size:
12.0pt'>Initially only part of the full BlueZ functionality will be include=
d in
the listing, but this does not imply that anything in BlueZ is
non-compliant.<span style=3D"mso-spacerun: yes">&nbsp; </span>If you submit=
 your
own test results they may allow the BlueZ listing to be extended for everyo=
ne&#8217;s
benefit.<span style=3D"mso-spacerun: yes">&nbsp; </span>You will be able to
qualify your products with BlueZ as a Qualified Subsystem but must come thr=
ough
the 7 layers UK BQB to be included on the BlueZ Complementary Subsystems Li=
st.<b><span
style=3D'font-weight:bold'><o:p></o:p></span></b></span></font></p>

<p class=3DMsoNormal><font size=3D3 face=3D"Times New Roman"><span style=3D=
'font-size:
12.0pt'><![if !supportEmptyParas]>&nbsp;<![endif]><o:p></o:p></span></font>=
</p>

<h2><a name=3D"OLE_LINK13"></a><b style=3D'mso-bidi-font-weight:normal'><fo=
nt
size=3D3 face=3D"Times New Roman"><span style=3D'font-size:12.0pt'>What par=
ts of
BlueZ will be Qualified?</span></font></b></h2>

<p class=3DMsoNormal><font size=3D3 face=3D"Times New Roman"><span style=3D=
'font-size:
12.0pt'>It makes sense to make a basic listing first then extend it as more
testing is completed.<span style=3D"mso-spacerun: yes">&nbsp; </span>The mi=
nimum
for qualification is GAP which would make BlueZ a type 1 product under the
definition in section 5.5.2.1 of the PRD.</span></font></p>

<p class=3DMsoNormal><font size=3D3 face=3D"Times New Roman"><span style=3D=
'font-size:
12.0pt'><![if !supportEmptyParas]>&nbsp;<![endif]><o:p></o:p></span></font>=
</p>

<h2><a name=3D"OLE_LINK14"></a><b style=3D'mso-bidi-font-weight:normal'><fo=
nt
size=3D3 face=3D"Times New Roman"><span style=3D'font-size:12.0pt'>Which ve=
rsion of
BlueZ will be Qualified?</span></font></b></h2>

<p class=3DMsoNormal><font size=3D3 face=3D"Times New Roman"><span style=3D=
'font-size:
12.0pt'>TBD</span></font></p>

<p class=3DMsoNormal><font size=3D3 face=3D"Times New Roman"><span style=3D=
'font-size:
12.0pt'><![if !supportEmptyParas]>&nbsp;<![endif]><o:p></o:p></span></font>=
</p>

<p class=3DMsoNormal><a name=3D"OLE_LINK15"></a><b><font size=3D3
face=3D"Times New Roman"><span style=3D'font-size:12.0pt;font-weight:bold'>=
What
Platform will be used for Qualification? (Hardware, Distribution, Kernel)<o=
:p></o:p></span></font></b></p>

<p class=3DMsoNormal><font size=3D3 face=3D"Times New Roman"><span style=3D=
'font-size:
12.0pt'>TBD, </span></font></p>

<p class=3DMsoBodyText><font size=3D3 face=3D"Times New Roman"><span
style=3D'font-size:12.0pt;mso-bidi-font-size:10.0pt'>Kernel 2.4.21-pre5 inc=
ludes
all Bluetooth fixes and updates (except the SCO support for USB). Intel
platform with Redhat 7.3 is available as is a CSR Casira which can be used =
as a
serial or USB bluetooth adaptor.</span></font></p>

<p class=3DMsoNormal><font size=3D3 face=3D"Times New Roman"><span style=3D=
'font-size:
12.0pt'><![if !supportEmptyParas]>&nbsp;<![endif]><o:p></o:p></span></font>=
</p>

<h2><a name=3D"OLE_LINK16"></a><b style=3D'mso-bidi-font-weight:normal'><fo=
nt
size=3D3 face=3D"Times New Roman"><span style=3D'font-size:12.0pt'>What cos=
ts are
involved in Bluetooth Qualification?</span></font></b></h2>

<p class=3DMsoNormal><font size=3D3 face=3D"Times New Roman"><span style=3D=
'font-size:
12.0pt'>Testing, report writing, BQB time, Bluetooth SIG listing fee Usuall=
y
$7500</span></font></p>

<p class=3DMsoNormal><font size=3D3 face=3D"Times New Roman"><span style=3D=
'font-size:
12.0pt'><![if !supportEmptyParas]>&nbsp;<![endif]><o:p></o:p></span></font>=
</p>

<h2><a name=3D"OLE_LINK17"></a><b style=3D'mso-bidi-font-weight:normal'><fo=
nt
size=3D3 face=3D"Times New Roman"><span style=3D'font-size:12.0pt'>Who will=
 meet
those costs for BlueZ?</span></font></b></h2>

<p class=3DMsoNormal><font size=3D3 face=3D"Times New Roman"><span style=3D=
'font-size:
12.0pt'>Current thinking is that the initial work will be done by 7 layers =
UK
without charge but help with the listing fee will be requested.<span
style=3D"mso-spacerun: yes">&nbsp; </span>The listing fee is paid to the
Bluetooth SIG, not retained by 7 layers UK.<span style=3D"mso-spacerun:
yes">&nbsp; </span>The fees fund the activities of the SIG, promoting Bluet=
ooth
technology.</span></font></p>

<p class=3DMsoNormal><font size=3D3 face=3D"Times New Roman"><span style=3D=
'font-size:
12.0pt'><![if !supportEmptyParas]>&nbsp;<![endif]><o:p></o:p></span></font>=
</p>

<h2><a name=3D"OLE_LINK18"></a><b style=3D'mso-bidi-font-weight:normal'><fo=
nt
size=3D3 face=3D"Times New Roman"><span style=3D'font-size:12.0pt'>Who owns=
 BlueZ?</span></font></b></h2>

<p class=3DMsoNormal><font size=3D3 face=3D"Times New Roman"><span style=3D=
'font-size:
12.0pt'>Copyright belongs to Qualcomm. &#8211; is this entirely correct? </=
span></font></p>

<p class=3DMsoNormal><font size=3D3 face=3D"Times New Roman"><span style=3D=
'font-size:
12.0pt'><![if !supportEmptyParas]>&nbsp;<![endif]><o:p></o:p></span></font>=
</p>

<h2><a name=3D"OLE_LINK19"></a><b style=3D'mso-bidi-font-weight:normal'><fo=
nt
size=3D3 face=3D"Times New Roman"><span style=3D'font-size:12.0pt'>Where ca=
n I find
out more about BlueZ?</span></font></b></h2>

<h2><b style=3D'mso-ansi-font-weight:normal'><font size=3D3 face=3D"Times N=
ew Roman"><span
style=3D'font-size:12.0pt;font-weight:normal'><a
href=3D"http://bluez.sourceforge.net/">http://bluez.sourceforge.net/</a></s=
pan></font></b><span
style=3D'font-weight:normal'><o:p></o:p></span></h2>

<p class=3DMsoNormal><font size=3D3 face=3D"Times New Roman"><span style=3D=
'font-size:
12.0pt'><![if !supportEmptyParas]>&nbsp;<![endif]><o:p></o:p></span></font>=
</p>

<h2><a name=3D"OLE_LINK20"></a><b style=3D'mso-bidi-font-weight:normal'><fo=
nt
size=3D3 face=3D"Times New Roman"><span style=3D'font-size:12.0pt'>Who will=
 own the
Qualified Product Listing?</span></font></b></h2>

<p class=3DMsoNormal><font size=3D3 face=3D"Times New Roman"><span style=3D=
'font-size:
12.0pt'>Not yet clear, usually listings are made in the name of a manufactu=
rer
&#8211; is there actually a BlueZ organisation??<span style=3D"mso-spacerun=
:
yes">&nbsp; </span></span></font></p>

<p class=3DMsoNormal><font size=3D3 face=3D"Times New Roman"><span style=3D=
'font-size:
12.0pt'><![if !supportEmptyParas]>&nbsp;<![endif]><o:p></o:p></span></font>=
</p>

<h2><a name=3D"OLE_LINK21"></a><b style=3D'mso-bidi-font-weight:normal'><fo=
nt
size=3D3 face=3D"Times New Roman"><span style=3D'font-size:12.0pt'>Who will=
 sign the
conformance statements?</span></font></b></h2>

<p class=3DMsoNormal><font size=3D3 face=3D"Times New Roman"><span style=3D=
'font-size:
12.0pt'>TBD one of the BlueZ developers.</span></font></p>

<p class=3DMsoNormal><font size=3D3 face=3D"Times New Roman"><span style=3D=
'font-size:
12.0pt'><![if !supportEmptyParas]>&nbsp;<![endif]><o:p></o:p></span></font>=
</p>

<h2><a name=3D"OLE_LINK22"></a><b style=3D'mso-bidi-font-weight:normal'><fo=
nt
size=3D3 face=3D"Times New Roman"><span style=3D'font-size:12.0pt'>Who will=
 control
the Qualified Product Listing?</span></font></b></h2>

<p class=3DMsoNormal><font size=3D3 face=3D"Times New Roman"><span style=3D=
'font-size:
12.0pt'>The BQB from 7 layers UK,<span style=3D"mso-spacerun: yes">&nbsp;
</span>It is normal for the same BQB to continue to maintain and update a
listing once it is established.</span></font></p>

<p class=3DMsoNormal><font size=3D3 face=3D"Times New Roman"><span style=3D=
'font-size:
12.0pt'><![if !supportEmptyParas]>&nbsp;<![endif]><o:p></o:p></span></font>=
</p>

<h2><a name=3D"OLE_LINK23"></a><b style=3D'mso-bidi-font-weight:normal'><fo=
nt
size=3D3 face=3D"Times New Roman"><span style=3D'font-size:12.0pt'>What doe=
s a
Qualified Product Listing look like?</span></font></b></h2>

<p class=3DMsoNormal><font size=3D3 face=3D"Times New Roman"><span style=3D=
'font-size:
12.0pt'><a
href=3D"http://qualweb.opengroup.org/Template2.cfm?LinkQualified=3DQualifie=
dProducts&amp;Details=3DYes&amp;ProductID=3D1086">http://qualweb.opengroup.=
org/Template2.cfm?LinkQualified=3DQualifiedProducts&amp;Details=3DYes&amp;P=
roductID=3D1086</a>
shows Widcoms Bluetooth stack for Windows.</span></font></p>

<p class=3DMsoNormal><font size=3D3 face=3D"Times New Roman"><span style=3D=
'font-size:
12.0pt'><![if !supportEmptyParas]>&nbsp;<![endif]><o:p></o:p></span></font>=
</p>

<h2><a name=3D"OLE_LINK24"></a><b style=3D'mso-bidi-font-weight:normal'><fo=
nt
size=3D3 face=3D"Times New Roman"><span style=3D'font-size:12.0pt'>What oth=
er issues
are there in taking a product to market?</span></font></b></h2>

<p class=3DMsoNormal><font size=3D3 face=3D"Times New Roman"><span style=3D=
'font-size:
12.0pt'>Apart from Bluetooth Qualification governments regulate market acce=
ss
through Regulatory Approvals mechanisms and<span style=3D"mso-spacerun:
yes">&nbsp; </span>the use of standards like CE marking in Europe, UL or
equivalent safety standards in USA.<span style=3D"mso-spacerun: yes">&nbsp;
</span>Testing to FCC part 15, ETS 300328 and ETS 300489 are usually requir=
ed
before filing a compliance folder with the various authorities around the
world.<span style=3D"mso-spacerun: yes">&nbsp; </span>This kind of stuff is=
 non
trivial and requires some expertise and local knowledge.<span
style=3D"mso-spacerun: yes">&nbsp; </span>Here I can plug another service
available from 7 layers UK.<span style=3D"mso-spacerun: yes">&nbsp; </span>=
It is
important to understand the different role of regulation (CE marking, appro=
vals,
certifications to meet regulatory purposes) and Bluetooth Qualification whi=
ch
allows a company to benefit from the work done to create the Bluetooth Spec=
ification,
controlled by patent, copyright and licensing..</span></font></p>

<p class=3DMsoNormal><font size=3D3 face=3D"Times New Roman"><span style=3D=
'font-size:
12.0pt'><![if !supportEmptyParas]>&nbsp;<![endif]><o:p></o:p></span></font>=
</p>

<h2><a name=3D"OLE_LINK25"></a><b style=3D'mso-bidi-font-weight:normal'><fo=
nt
size=3D3 face=3D"Times New Roman"><span style=3D'font-size:12.0pt'>Where ca=
n I find
out about Bluetooth?</span></font></b></h2>

<p class=3DMsoNormal><font size=3D3 face=3D"Times New Roman"><span style=3D=
'font-size:
12.0pt'><span style=3D'mso-tab-count:1'>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; </span><b><span
style=3D'font-weight:bold'>As a user ?<o:p></o:p></span></b></span></font><=
/p>

<p class=3DMsoNormal><b><font size=3D3 face=3D"Times New Roman"><span
style=3D'font-size:12.0pt;font-weight:bold'><span style=3D'mso-tab-count:1'=
>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; </span>=
<a
href=3D"http://www.bluetooth.com/"><span style=3D'font-weight:normal'>http:=
//www.bluetooth.com/</span></a></span></font></b></p>

<p class=3DMsoNormal><font size=3D3 face=3D"Times New Roman"><span style=3D=
'font-size:
12.0pt'><![if !supportEmptyParas]>&nbsp;<![endif]><o:p></o:p></span></font>=
</p>

<p class=3DMsoNormal><font size=3D3 face=3D"Times New Roman"><span style=3D=
'font-size:
12.0pt'><span style=3D'mso-tab-count:1'>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; </span><a
name=3D"OLE_LINK26"></a><b><span style=3D'font-weight:bold'>As a developer =
or
manufacturer?<o:p></o:p></span></b></span></font></p>

<p class=3DMsoNormal><b><font size=3D3 face=3D"Times New Roman"><span
style=3D'font-size:12.0pt;font-weight:bold'><span style=3D'mso-tab-count:1'=
>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; </span>=
</span></font></b><a
href=3D"http://www.bluetooth.org/">http://www.bluetooth.org</a></p>

<p class=3DMsoNormal style=3D'text-indent:36.0pt'><font size=3D3
face=3D"Times New Roman"><span style=3D'font-size:12.0pt'>specifications et=
c</span></font></p>

<p class=3DMsoNormal><font size=3D3 face=3D"Times New Roman"><span style=3D=
'font-size:
12.0pt'><![if !supportEmptyParas]>&nbsp;<![endif]><o:p></o:p></span></font>=
</p>

<p class=3DMsoNormal><font size=3D3 face=3D"Times New Roman"><span style=3D=
'font-size:
12.0pt'><span style=3D'mso-tab-count:1'>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; </span><a
name=3D"OLE_LINK27"></a><b><span style=3D'font-weight:bold'>Specifically
Qualification?<o:p></o:p></span></b></span></font></p>

<p class=3DMsoNormal><b><font size=3D3 face=3D"Times New Roman"><span
style=3D'font-size:12.0pt;font-weight:bold'><span style=3D'mso-tab-count:1'=
>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; </span>=
<a
href=3D"http://qualweb.opengroup.org/"><span style=3D'font-weight:normal'>h=
ttp://qualweb.opengroup.org/</span></a></span></font></b></p>

<p class=3DMsoNormal><font size=3D3 face=3D"Times New Roman"><span style=3D=
'font-size:
12.0pt'><span style=3D'mso-tab-count:1'>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; </span>test
specifications, test case status, qualified product list</span></font></p>

<p class=3DMsoNormal><font size=3D3 face=3D"Times New Roman"><span style=3D=
'font-size:
12.0pt'><![if !supportEmptyParas]>&nbsp;<![endif]><o:p></o:p></span></font>=
</p>

<h2><a name=3D"OLE_LINK28"></a><b style=3D'mso-bidi-font-weight:normal'><fo=
nt
size=3D3 face=3D"Times New Roman"><span style=3D'font-size:12.0pt'>How can =
I help?</span></font></b></h2>

<p class=3DMsoNormal><font size=3D3 face=3D"Times New Roman"><span style=3D=
'font-size:
12.0pt'>We are currently in a brainstorming phase so any input is useful:</=
span></font></p>

<p class=3DMsoNormal><font size=3D3 face=3D"Times New Roman"><span style=3D=
'font-size:
12.0pt'>Can you enhance these answers?</span></font></p>

<p class=3DMsoNormal><font size=3D3 face=3D"Times New Roman"><span style=3D=
'font-size:
12.0pt'>Can you ask any important questions?</span></font></p>

<p class=3DMsoNormal><font size=3D3 face=3D"Times New Roman"><span style=3D=
'font-size:
12.0pt'>What benefits to Qualification do you see?</span></font></p>

<p class=3DMsoNormal><font size=3D3 face=3D"Times New Roman"><span style=3D=
'font-size:
12.0pt'>What resources can you offer?</span></font></p>

<p class=3DMsoNormal><font size=3D3 face=3D"Times New Roman"><span style=3D=
'font-size:
12.0pt'>How would you like to help?</span></font></p>

<p class=3DMsoNormal><font size=3D3 face=3D"Times New Roman"><span style=3D=
'font-size:
12.0pt'><![if !supportEmptyParas]>&nbsp;<![endif]><o:p></o:p></span></font>=
</p>

<h2><a name=3D"OLE_LINK29"></a><b style=3D'mso-bidi-font-weight:normal'><fo=
nt
size=3D3 face=3D"Times New Roman"><span style=3D'font-size:12.0pt'>What Hap=
pens when
BlueZ is updated?</span></font></b></h2>

<p class=3DMsoNormal><font size=3D3 face=3D"Times New Roman"><span style=3D=
'font-size:
12.0pt'>The listing can be revised subject to appropriate evidence that the=
 BQB
will specify when the changes are understood.<span style=3D"mso-spacerun:
yes">&nbsp;&nbsp; </span>Minor changes, bug fixes and the likes can be
aggregated every few months.</span></font></p>

<p class=3DMsoNormal><font size=3D3 face=3D"Times New Roman"><span style=3D=
'font-size:
12.0pt'><![if !supportEmptyParas]>&nbsp;<![endif]><o:p></o:p></span></font>=
</p>

<h2><a name=3D"OLE_LINK30"></a><b style=3D'mso-bidi-font-weight:normal'><fo=
nt
size=3D3 face=3D"Times New Roman"><span style=3D'font-size:12.0pt'>How are =
different
versions of Linux covered?</span></font></b></h2>

<p class=3DMsoNormal><font size=3D3 face=3D"Times New Roman"><span style=3D=
'font-size:
12.0pt'>The Widcom listing <a
href=3D"http://qualweb.opengroup.org/Template2.cfm?LinkQualified=3DQualifie=
dProducts&amp;Details=3DYes&amp;ProductID=3D1086">http://qualweb.opengroup.=
org/Template2.cfm?LinkQualified=3DQualifiedProducts&amp;Details=3DYes&amp;P=
roductID=3D1086</a>
is an example where the same stack is run on different versions of
Windows.<span style=3D"mso-spacerun: yes">&nbsp; </span>The same principle
applies to the flavours of Linux but the exact extent, the range of process=
ors,
distros and kernels is still under discussion.</span></font></p>

<p class=3DMsoNormal><font size=3D3 face=3D"Times New Roman"><span style=3D=
'font-size:
12.0pt'><![if !supportEmptyParas]>&nbsp;<![endif]><o:p></o:p></span></font>=
</p>

<p class=3DMsoNormal><font size=3D3 face=3D"Times New Roman"><span style=3D=
'font-size:
12.0pt'><![if !supportEmptyParas]>&nbsp;<![endif]><o:p></o:p></span></font>=
</p>

<p class=3DMsoNormal><font size=3D3 face=3D"Times New Roman"><span style=3D=
'font-size:
12.0pt'><![if !supportEmptyParas]>&nbsp;<![endif]><o:p></o:p></span></font>=
</p>

</div>

</body>

</html>

--=-dtSYvGD8dD6Q4FJHKhlB--

--=-wSA2P64LHy//ZmyqF5dR--
