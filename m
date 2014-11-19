Return-Path: <cyrus@holtmann.org>
From: "Wu, JiangboX" <jiangbox.wu@intel.com>
To: "marcel@holtmann.org" <marcel@holtmann.org>, "luiz.dentz@gmail.com"
	<luiz.dentz@gmail.com>, "linux-bluetooth@vger.kernel.org"
	<linux-bluetooth@vger.kernel.org>
Subject: Does obexd support Multi-User
Date: Wed, 19 Nov 2014 13:17:49 +0000
Message-ID: <ACB402E679F3454EAE433BF5E93F4EAA01663F45@shsmsx102.ccr.corp.intel.com>
Content-Type: multipart/alternative;
	boundary="_000_ACB402E679F3454EAE433BF5E93F4EAA01663F45shsmsx102ccrcor_"
MIME-Version: 1.0
List-ID: <linux-bluetooth.vger.kernel.org>

--_000_ACB402E679F3454EAE433BF5E93F4EAA01663F45shsmsx102ccrcor_
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable

Hi Marcel,
         As I know the bluetoothd is running on root privilege level, obexd=
 is running on app privilege level. The obexd is running on app privilege l=
evel to support user can only transfer the user's own file. Maybe it has ot=
her reasons.
And if the OS has many users can run at the same time. For example. User A =
named 'blob', User B named 'Alice', and the root. The three user run on OS =
at the time. As mentioned before, can I say that 'blob' and 'Alice' will ha=
ve its owner obexd daemon? That I mean multi-user. And does it be able to u=
se independent?
         For example, 'blob' use BlueZ to pair device A, and 'Alice' use Bl=
ueZ to pair device B. Dose 'blob' can send/receive file from device A? and =
'Alice' can send/receive file form device B? I test the usage case, and the=
 result is that, 'blob' and 'Alice' can send file to device A and Device B =
simultaneously. But it's have difference behavior in turn. Only one obexd c=
an receive the OPP request, another will never get the OPP request.
         Do you have any idea to support multi-user case by running differe=
nt obexd daemon in the different users? If obexd don't support multi-user, =
can you give me some sugguestions? Thanks. :)

Best regards
Jiangbo


--_000_ACB402E679F3454EAE433BF5E93F4EAA01663F45shsmsx102ccrcor_
Content-Type: text/html; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable

<html xmlns:v=3D"urn:schemas-microsoft-com:vml" xmlns:o=3D"urn:schemas-micr=
osoft-com:office:office" xmlns:w=3D"urn:schemas-microsoft-com:office:word" =
xmlns:m=3D"http://schemas.microsoft.com/office/2004/12/omml" xmlns=3D"http:=
//www.w3.org/TR/REC-html40">
<head>
<meta http-equiv=3D"Content-Type" content=3D"text/html; charset=3Dus-ascii"=
>
<meta name=3D"Generator" content=3D"Microsoft Word 14 (filtered medium)">
<style><!--
/* Font Definitions */
@font-face
	{font-family:Wingdings;
	panose-1:5 0 0 0 0 0 0 0 0 0;}
@font-face
	{font-family:SimSun;
	panose-1:2 1 6 0 3 1 1 1 1 1;}
@font-face
	{font-family:SimSun;
	panose-1:2 1 6 0 3 1 1 1 1 1;}
@font-face
	{font-family:Calibri;
	panose-1:2 15 5 2 2 2 4 3 2 4;}
@font-face
	{font-family:SimSun;
	panose-1:2 1 6 0 3 1 1 1 1 1;}
/* Style Definitions */
p.MsoNormal, li.MsoNormal, div.MsoNormal
	{margin:0cm;
	margin-bottom:.0001pt;
	text-align:justify;
	text-justify:inter-ideograph;
	font-size:10.5pt;
	font-family:"Calibri","sans-serif";}
a:link, span.MsoHyperlink
	{mso-style-priority:99;
	color:blue;
	text-decoration:underline;}
a:visited, span.MsoHyperlinkFollowed
	{mso-style-priority:99;
	color:purple;
	text-decoration:underline;}
span.EmailStyle17
	{mso-style-type:personal-compose;
	font-family:"Calibri","sans-serif";
	color:windowtext;}
.MsoChpDefault
	{mso-style-type:export-only;}
/* Page Definitions */
@page WordSection1
	{size:612.0pt 792.0pt;
	margin:72.0pt 90.0pt 72.0pt 90.0pt;}
div.WordSection1
	{page:WordSection1;}
--></style><!--[if gte mso 9]><xml>
<o:shapedefaults v:ext=3D"edit" spidmax=3D"1026" />
</xml><![endif]--><!--[if gte mso 9]><xml>
<o:shapelayout v:ext=3D"edit">
<o:idmap v:ext=3D"edit" data=3D"1" />
</o:shapelayout></xml><![endif]-->
</head>
<body lang=3D"ZH-CN" link=3D"blue" vlink=3D"purple" style=3D"text-justify-t=
rim:punctuation">
<div class=3D"WordSection1">
<p class=3D"MsoNormal"><span lang=3D"EN-US">Hi Marcel,<o:p></o:p></span></p=
>
<p class=3D"MsoNormal"><span lang=3D"EN-US">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp; As I know the bluetoothd is running on root privilege lev=
el, obexd is running on app privilege level. The obexd is running on app pr=
ivilege level to support user can only transfer the user&#8217;s own file. =
Maybe it
 has other reasons.<o:p></o:p></span></p>
<p class=3D"MsoNormal" style=3D"text-indent:21.0pt"><span lang=3D"EN-US">An=
d if the OS has many users can run at the same time. For example. User A na=
med &#8216;blob&#8217;, User B named &#8216;Alice&#8217;, and the root. The=
 three user run on OS at the time. As mentioned before, can I
 say that &#8216;blob&#8217; and &#8216;Alice&#8217; will have its owner ob=
exd daemon? That I mean multi-user. And does it be able to use independent?=
<o:p></o:p></span></p>
<p class=3D"MsoNormal"><span lang=3D"EN-US">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp; For example, &#8216;blob&#8217; use BlueZ to pair device =
A, and &#8216;Alice&#8217; use BlueZ to pair device B. Dose &#8216;blob&#82=
17; can send/receive file from device A? and &#8216;Alice&#8217; can send/r=
eceive file form device B? I test the usage case,
 and the result is that, &#8216;blob&#8217; and &#8216;Alice&#8217; can sen=
d file to device A and Device B simultaneously. But it&#8217;s have differe=
nce behavior in turn. Only one obexd can receive the OPP request, another w=
ill never get the OPP request.<o:p></o:p></span></p>
<p class=3D"MsoNormal"><span lang=3D"EN-US">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp; Do you have any idea to support multi-user case by runnin=
g different obexd daemon in the different users? If obexd don&#8217;t suppo=
rt multi-user, can you give me some sugguestions? Thanks.
</span><span lang=3D"EN-US" style=3D"font-family:Wingdings">J</span><span l=
ang=3D"EN-US"><o:p></o:p></span></p>
<p class=3D"MsoNormal"><span lang=3D"EN-US"><o:p>&nbsp;</o:p></span></p>
<p class=3D"MsoNormal"><span lang=3D"EN-US">Best regards<o:p></o:p></span><=
/p>
<p class=3D"MsoNormal"><span lang=3D"EN-US">Jiangbo<o:p></o:p></span></p>
<p class=3D"MsoNormal"><span lang=3D"EN-US"><o:p>&nbsp;</o:p></span></p>
</div>
</body>
</html>

--_000_ACB402E679F3454EAE433BF5E93F4EAA01663F45shsmsx102ccrcor_--
