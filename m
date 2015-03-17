Return-Path: <cyrus@holtmann.org>
From: paras kumar <paras.kumar@samsung.com>
To: marcel@holtmann.org, johan.hedberg@gmail.com
Cc: linux-bluetooth@vger.kernel.org, bharat.panda@samsung.com
Subject: Questions related to LE Privacy 1.2 (BLE 4.2 feature)
Date: Tue, 17 Mar 2015 10:44:32 +0530
Message-id: <023801d06071$49ce4450$dd6accf0$@samsung.com>
MIME-version: 1.0
Content-type: multipart/alternative;
 boundary="----=_NextPart_000_0239_01D0609F.638BD780"
List-ID: <linux-bluetooth.vger.kernel.org>

This is a multipart message in MIME format.

------=_NextPart_000_0239_01D0609F.638BD780
Content-Type: text/plain;
	charset="us-ascii"
Content-Transfer-Encoding: 7bit

Hi Marcel/ Hi Johan,

 

I have some questions related to LE Privacy 1.2 feature. Could you please
answer my below queries.

 

Currently set_privacy() MGMT method is used to set the HCI_PRIVACY (LE
controller) flag to enable host based privacy feature locally in kernel,

when adapter is powered off. To enable controller based privacy, first we
need to check whether LL supports the LL privacy feature and bit is set or
not, if so

.    how and when controller based privacy to be set when adapter is powered
off ?

.    Can set_privacy() MGMT method and HCI_PRIVACY flag be reused for
controller based privacy also ?

.    OR should we introduce new flag like HCI_CTLR_PRIVACY and new MGMT
method to set and differentiate controller and host based privacy code in
kernel ?

 

Thanks in advance & 

Best Regards,

Paras Kumar

	

 


------=_NextPart_000_0239_01D0609F.638BD780
Content-Type: text/html;
	charset="us-ascii"
Content-Transfer-Encoding: quoted-printable

<html xmlns:v=3D"urn:schemas-microsoft-com:vml" =
xmlns:o=3D"urn:schemas-microsoft-com:office:office" =
xmlns:w=3D"urn:schemas-microsoft-com:office:word" =
xmlns:m=3D"http://schemas.microsoft.com/office/2004/12/omml" =
xmlns=3D"http://www.w3.org/TR/REC-html40"><head><meta =
http-equiv=3DContent-Type content=3D"text/html; =
charset=3Dus-ascii"><meta name=3DGenerator content=3D"Microsoft Word 14 =
(filtered medium)"><style><!--
/* Font Definitions */
@font-face
	{font-family:Wingdings;
	panose-1:5 0 0 0 0 0 0 0 0 0;}
@font-face
	{font-family:Wingdings;
	panose-1:5 0 0 0 0 0 0 0 0 0;}
@font-face
	{font-family:Calibri;
	panose-1:2 15 5 2 2 2 4 3 2 4;}
@font-face
	{font-family:Tahoma;
	panose-1:2 11 6 4 3 5 4 4 2 4;}
/* Style Definitions */
p.MsoNormal, li.MsoNormal, div.MsoNormal
	{margin:0in;
	margin-bottom:.0001pt;
	font-size:11.0pt;
	font-family:"Calibri","sans-serif";}
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
	margin-top:3.75pt;
	margin-right:0in;
	margin-bottom:3.75pt;
	margin-left:0in;
	font-size:9.0pt;
	font-family:"Arial","sans-serif";}
p.MsoAcetate, li.MsoAcetate, div.MsoAcetate
	{mso-style-priority:99;
	mso-style-link:"Balloon Text Char";
	margin:0in;
	margin-bottom:.0001pt;
	font-size:8.0pt;
	font-family:"Tahoma","sans-serif";}
span.EmailStyle17
	{mso-style-type:personal-compose;
	font-family:"Calibri","sans-serif";
	color:windowtext;}
span.BalloonTextChar
	{mso-style-name:"Balloon Text Char";
	mso-style-priority:99;
	mso-style-link:"Balloon Text";
	font-family:"Tahoma","sans-serif";}
.MsoChpDefault
	{mso-style-type:export-only;
	font-family:"Calibri","sans-serif";}
@page WordSection1
	{size:8.5in 11.0in;
	margin:1.0in 1.0in 1.0in 1.0in;}
div.WordSection1
	{page:WordSection1;}
/* List Definitions */
@list l0
	{mso-list-id:1320034107;
	mso-list-template-ids:-936194338;}
@list l0:level1
	{mso-level-number-format:bullet;
	mso-level-text:\F0B7;
	mso-level-tab-stop:.5in;
	mso-level-number-position:left;
	text-indent:-.25in;
	mso-ansi-font-size:10.0pt;
	font-family:Symbol;}
@list l0:level2
	{mso-level-number-format:bullet;
	mso-level-text:o;
	mso-level-tab-stop:1.0in;
	mso-level-number-position:left;
	text-indent:-.25in;
	mso-ansi-font-size:10.0pt;
	font-family:"Courier New";
	mso-bidi-font-family:"Times New Roman";}
@list l0:level3
	{mso-level-number-format:bullet;
	mso-level-text:\F0A7;
	mso-level-tab-stop:1.5in;
	mso-level-number-position:left;
	text-indent:-.25in;
	mso-ansi-font-size:10.0pt;
	font-family:Wingdings;}
@list l0:level4
	{mso-level-number-format:bullet;
	mso-level-text:\F0A7;
	mso-level-tab-stop:2.0in;
	mso-level-number-position:left;
	text-indent:-.25in;
	mso-ansi-font-size:10.0pt;
	font-family:Wingdings;}
@list l0:level5
	{mso-level-number-format:bullet;
	mso-level-text:\F0A7;
	mso-level-tab-stop:2.5in;
	mso-level-number-position:left;
	text-indent:-.25in;
	mso-ansi-font-size:10.0pt;
	font-family:Wingdings;}
@list l0:level6
	{mso-level-number-format:bullet;
	mso-level-text:\F0A7;
	mso-level-tab-stop:3.0in;
	mso-level-number-position:left;
	text-indent:-.25in;
	mso-ansi-font-size:10.0pt;
	font-family:Wingdings;}
@list l0:level7
	{mso-level-number-format:bullet;
	mso-level-text:\F0A7;
	mso-level-tab-stop:3.5in;
	mso-level-number-position:left;
	text-indent:-.25in;
	mso-ansi-font-size:10.0pt;
	font-family:Wingdings;}
@list l0:level8
	{mso-level-number-format:bullet;
	mso-level-text:\F0A7;
	mso-level-tab-stop:4.0in;
	mso-level-number-position:left;
	text-indent:-.25in;
	mso-ansi-font-size:10.0pt;
	font-family:Wingdings;}
@list l0:level9
	{mso-level-number-format:bullet;
	mso-level-text:\F0A7;
	mso-level-tab-stop:4.5in;
	mso-level-number-position:left;
	text-indent:-.25in;
	mso-ansi-font-size:10.0pt;
	font-family:Wingdings;}
ol
	{margin-bottom:0in;}
ul
	{margin-bottom:0in;}
--></style><!--[if gte mso 9]><xml>
<o:shapedefaults v:ext=3D"edit" spidmax=3D"1026" />
</xml><![endif]--><!--[if gte mso 9]><xml>
<o:shapelayout v:ext=3D"edit">
<o:idmap v:ext=3D"edit" data=3D"1" />
</o:shapelayout></xml><![endif]--></head><body lang=3DEN-US link=3Dblue =
vlink=3Dpurple><div class=3DWordSection1><p class=3DMsoNormal =
style=3D'margin-bottom:3.75pt'><span =
style=3D'font-size:9.0pt;font-family:"Arial","sans-serif"'>Hi Marcel/ Hi =
Johan,<o:p></o:p></span></p><p class=3DMsoNormal =
style=3D'mso-margin-top-alt:3.75pt;margin-right:0in;margin-bottom:3.75pt;=
margin-left:0in'><span =
style=3D'font-size:9.0pt;font-family:"Arial","sans-serif"'>&nbsp;<o:p></o=
:p></span></p><p class=3DMsoNormal =
style=3D'mso-margin-top-alt:3.75pt;margin-right:0in;margin-bottom:3.75pt;=
margin-left:0in'><span =
style=3D'font-size:9.0pt;font-family:"Arial","sans-serif"'>I have some =
questions related to LE Privacy 1.2 feature. Could you please answer my =
below queries.<o:p></o:p></span></p><p class=3DMsoNormal =
style=3D'mso-margin-top-alt:3.75pt;margin-right:0in;margin-bottom:3.75pt;=
margin-left:0in'><span =
style=3D'font-size:9.0pt;font-family:"Arial","sans-serif"'>&nbsp;<o:p></o=
:p></span></p><p class=3DMsoNormal =
style=3D'mso-margin-top-alt:3.75pt;margin-right:0in;margin-bottom:3.75pt;=
margin-left:0in'><span =
style=3D'font-size:9.0pt;font-family:"Arial","sans-serif"'>Currently =
<b>set_privacy</b>() MGMT method is used to set the <b>HCI_PRIVACY =
(</b>LE controller<b>)</b> flag to enable host based privacy feature =
locally in kernel,<o:p></o:p></span></p><p class=3DMsoNormal =
style=3D'mso-margin-top-alt:3.75pt;margin-right:0in;margin-bottom:3.75pt;=
margin-left:0in'><span =
style=3D'font-size:9.0pt;font-family:"Arial","sans-serif"'>when adapter =
is powered off. To enable controller based privacy, first we need to =
check whether LL supports the <b>LL privacy </b>feature and bit is set =
or not, if so<o:p></o:p></span></p><p class=3DMsoNormal =
style=3D'mso-margin-top-alt:3.75pt;margin-right:0in;margin-bottom:3.75pt;=
margin-left:43.5pt;text-indent:-.25in;mso-list:l0 level1 lfo1'><![if =
!supportLists]><span style=3D'font-size:10.0pt;font-family:Symbol'><span =
style=3D'mso-list:Ignore'>&middot;<span style=3D'font:7.0pt "Times New =
Roman"'>&nbsp;&nbsp;&nbsp; </span></span></span><![endif]><span =
style=3D'font-size:9.0pt;font-family:"Arial","sans-serif"'>how and when =
controller based privacy to be set&nbsp;when adapter is powered off =
?<o:p></o:p></span></p><p class=3DMsoNormal =
style=3D'mso-margin-top-alt:3.75pt;margin-right:0in;margin-bottom:3.75pt;=
margin-left:43.5pt;text-indent:-.25in;mso-list:l0 level1 lfo1'><![if =
!supportLists]><span style=3D'font-size:10.0pt;font-family:Symbol'><span =
style=3D'mso-list:Ignore'>&middot;<span style=3D'font:7.0pt "Times New =
Roman"'>&nbsp;&nbsp;&nbsp; </span></span></span><![endif]><span =
style=3D'font-size:9.0pt;font-family:"Arial","sans-serif"'>Can&nbsp;<b>se=
t_privacy</b>() MGMT method and <b>HCI_PRIVACY&nbsp;</b>flag&nbsp;be =
reused&nbsp;for&nbsp;controller based privacy also =
?<o:p></o:p></span></p><p class=3DMsoNormal =
style=3D'mso-margin-top-alt:3.75pt;margin-right:0in;margin-bottom:3.75pt;=
margin-left:43.5pt;text-indent:-.25in;mso-list:l0 level1 lfo1'><![if =
!supportLists]><span style=3D'font-size:10.0pt;font-family:Symbol'><span =
style=3D'mso-list:Ignore'>&middot;<span style=3D'font:7.0pt "Times New =
Roman"'>&nbsp;&nbsp;&nbsp; </span></span></span><![endif]><span =
style=3D'font-size:9.0pt;font-family:"Arial","sans-serif"'>OR should we =
introduce new flag like<b> HCI_CTLR_PRIVACY </b>and<b> </b>new<b> MGMT =
method </b>to set and differentiate controller and host based privacy =
code in kernel ?<o:p></o:p></span></p><p class=3DMsoNormal =
style=3D'mso-margin-top-alt:3.75pt;margin-right:0in;margin-bottom:3.75pt;=
margin-left:25.5pt'><span =
style=3D'font-size:9.0pt;font-family:"Arial","sans-serif"'><o:p>&nbsp;</o=
:p></span></p><p class=3DMsoNormal =
style=3D'mso-margin-top-alt:3.75pt;margin-right:0in;margin-bottom:3.75pt;=
margin-left:0in'><span =
style=3D'font-size:9.0pt;font-family:"Arial","sans-serif"'>Thanks in =
advance &amp;&nbsp;<o:p></o:p></span></p><p class=3DMsoNormal =
style=3D'mso-margin-top-alt:3.75pt;margin-right:0in;margin-bottom:3.75pt;=
margin-left:0in'><span =
style=3D'font-size:9.0pt;font-family:"Arial","sans-serif"'>Best =
Regards,<o:p></o:p></span></p><p class=3DMsoNormal =
style=3D'margin-top:3.75pt'><span =
style=3D'font-size:9.0pt;font-family:"Arial","sans-serif"'>Paras =
Kumar<o:p></o:p></span></p><table class=3DMsoNormalTable border=3D0 =
cellpadding=3D0><tr><td style=3D'padding:.75pt .75pt .75pt =
.75pt'></td></tr></table><p =
class=3DMsoNormal><o:p>&nbsp;</o:p></p></div></body></html>
------=_NextPart_000_0239_01D0609F.638BD780--
