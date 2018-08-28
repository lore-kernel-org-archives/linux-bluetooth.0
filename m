Return-Path: <fugang.duan@nxp.com>
From: Andy Duan <fugang.duan@nxp.com>
To: "rtatiya@codeaurora.org" <rtatiya@codeaurora.org>,
	"luiz.von.dentz@intel.com" <luiz.von.dentz@intel.com>, "marcel@holtmann.org"
	<marcel@holtmann.org>, "johan.hedberg@intel.com" <johan.hedberg@intel.com>,
	Asim Zaidi <asim.zaidi@nxp.com>
CC: "linux-bluetooth@vger.kernel.org" <linux-bluetooth@vger.kernel.org>
Subject: BlueZ: How to avoid fixed Coordinate Invalid Curve Attack
Date: Tue, 28 Aug 2018 09:42:22 +0000
Message-ID: 
 <VI1PR0402MB3600BAF04C81783B3A119AB6FF0A0@VI1PR0402MB3600.eurprd04.prod.outlook.com>
Content-Type: multipart/alternative;
	boundary="_000_VI1PR0402MB3600BAF04C81783B3A119AB6FF0A0VI1PR0402MB3600_"
MIME-Version: 1.0
List-ID: <linux-bluetooth.vger.kernel.org>

--_000_VI1PR0402MB3600BAF04C81783B3A119AB6FF0A0VI1PR0402MB3600_
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable

Hi all,

Do you have patches for BlueZ to avoid Bluetooth curve attack ?

As I know, Many vendors supply Android Flueride host fixes & Firmware fixes=
 to avoid the curve attack, but BlueZ community doesn't have the topic. Doe=
s there have plan to fix the hole ?



Summary

Bluetooth firmware or operating system software drivers may not sufficientl=
y validate elliptic curve parameters used to generate public keys during a =
Diffie-Hellman key exchange, which may allow a remote attacker to obtain th=
e encryption key used by the device.
Impact

  *   An unauthenticated, remote attacker within range may be able to utili=
ze a man-in-the-middle network position to determine the cryptographic keys=
 used by the device.
  *   The attacker can then intercept and decrypt and/or forge and inject d=
evice messages.
  *   The attack exploits the vulnerability on both participating devices s=
imultaneously. If any one of them is patched, the attack does not work
  *   Every Bluetooth chip manufactured by Intel, Broadcom or Qualcomm is l=
ikely affected.
 NXP Potential Impact

  *   Potentially all products listed in this link  below will be susceptib=
le
     *   https://www.nxp.com/products/wireless-connectivity/bluetooth-low-e=
nergy-ble:BLUETOOTH-LOW-ENERGY-BLE<https://emea01.safelinks.protection.outl=
ook.com/?url=3Dhttps%3A%2F%2Fwww.nxp.com%2Fproducts%2Fwireless-connectivity=
%2Fbluetooth-low-energy-ble%3ABLUETOOTH-LOW-ENERGY-BLE&data=3D02%7C01%7Cfug=
ang.duan%40nxp.com%7C7e9ffc5ca0a74d3c79a808d5f7572b4d%7C686ea1d3bc2b4c6fa92=
cd99c5c301635%7C0%7C0%7C636686876125441293&sdata=3Diqe9ggsKa%2FQzioW3Wy6KYr=
o%2FQw8zMAVR%2F6MmjgDsAGU%3D&reserved=3D0>
  *   All i.MX BSP Android and Linux BSP releases that support Bluetooth ch=
ipsets will probably impacted and require patching


  *   NXP has currently not been listed as an impacted vendor in the CERT C=
C website<https://emea01.safelinks.protection.outlook.com/?url=3Dhttps%3A%2=
F%2Fwww.kb.cert.org%2Fvuls%2Fid%2F304725&data=3D02%7C01%7Cfugang.duan%40nxp=
.com%7C7e9ffc5ca0a74d3c79a808d5f7572b4d%7C686ea1d3bc2b4c6fa92cd99c5c301635%=
7C0%7C0%7C636686876125451302&sdata=3D4JCI27G1t3tf8qd5W01s5d8Oxh4UOD8DXFASfs=
lRiaI%3D&reserved=3D0>
 Mitigation

  *   Both software and firmware updates will be required

  *   Looks like Android included this in their June Release for Broadcom, =
Qualcomm a BT chipsets.
     *   https://source.android.com/security/bulletin/2018-06-01<https://em=
ea01.safelinks.protection.outlook.com/?url=3Dhttps%3A%2F%2Fsource.android.c=
om%2Fsecurity%2Fbulletin%2F2018-06-01&data=3D02%7C01%7Cfugang.duan%40nxp.co=
m%7C7e9ffc5ca0a74d3c79a808d5f7572b4d%7C686ea1d3bc2b4c6fa92cd99c5c301635%7C0=
%7C0%7C636686876125461314&sdata=3Dga8hK0rQvzVmttAWh1EgJay04BrivKezVqLvZgjwf=
R8%3D&reserved=3D0>
  *   Linux BT driver updates will also be required
     *   Apparently Linux versions prior to 3.19 don't support Bluetooth LE=
 Secure Connections and are therefore not vulnerable



Regards,
Andy Duan

--_000_VI1PR0402MB3600BAF04C81783B3A119AB6FF0A0VI1PR0402MB3600_
Content-Type: text/html; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable

<html xmlns:v=3D"urn:schemas-microsoft-com:vml" xmlns:o=3D"urn:schemas-micr=
osoft-com:office:office" xmlns:w=3D"urn:schemas-microsoft-com:office:word" =
xmlns:m=3D"http://schemas.microsoft.com/office/2004/12/omml" xmlns=3D"http:=
//www.w3.org/TR/REC-html40">
<head>
<meta http-equiv=3D"Content-Type" content=3D"text/html; charset=3Dus-ascii"=
>
<meta name=3D"Generator" content=3D"Microsoft Word 15 (filtered medium)">
<style><!--
/* Font Definitions */
@font-face
	{font-family:SimSun;
	panose-1:2 1 6 0 3 1 1 1 1 1;}
@font-face
	{font-family:"Cambria Math";
	panose-1:2 4 5 3 5 4 6 3 2 4;}
@font-face
	{font-family:Calibri;
	panose-1:2 15 5 2 2 2 4 3 2 4;}
@font-face
	{font-family:"Microsoft YaHei";
	panose-1:2 11 5 3 2 2 4 2 2 4;}
@font-face
	{font-family:"Microsoft YaHei";}
@font-face
	{font-family:SimSun;
	panose-1:2 1 6 0 3 1 1 1 1 1;}
@font-face
	{font-family:HelveticaNeue;}
/* Style Definitions */
p.MsoNormal, li.MsoNormal, div.MsoNormal
	{margin:0cm;
	margin-bottom:.0001pt;
	font-size:11.0pt;
	font-family:"Calibri",sans-serif;}
a:link, span.MsoHyperlink
	{mso-style-priority:99;
	color:#0563C1;
	text-decoration:underline;}
a:visited, span.MsoHyperlinkFollowed
	{mso-style-priority:99;
	color:#954F72;
	text-decoration:underline;}
span.EmailStyle17
	{mso-style-type:personal-compose;
	font-family:"Calibri",sans-serif;
	color:#0070C0;
	font-weight:normal;
	font-style:normal;}
.MsoChpDefault
	{mso-style-type:export-only;
	font-family:DengXian;}
/* Page Definitions */
@page WordSection1
	{size:612.0pt 792.0pt;
	margin:72.0pt 90.0pt 72.0pt 90.0pt;}
div.WordSection1
	{page:WordSection1;}
/* List Definitions */
@list l0
	{mso-list-id:427820030;
	mso-list-template-ids:-1686339952;}
@list l0:level1
	{mso-level-number-format:bullet;
	mso-level-text:\F0B7;
	mso-level-tab-stop:36.0pt;
	mso-level-number-position:left;
	text-indent:-18.0pt;
	mso-ansi-font-size:10.0pt;
	font-family:Symbol;}
@list l0:level2
	{mso-level-number-format:bullet;
	mso-level-text:\F0B7;
	mso-level-tab-stop:72.0pt;
	mso-level-number-position:left;
	text-indent:-18.0pt;
	mso-ansi-font-size:10.0pt;
	font-family:Symbol;}
@list l0:level3
	{mso-level-number-format:bullet;
	mso-level-text:\F0B7;
	mso-level-tab-stop:108.0pt;
	mso-level-number-position:left;
	text-indent:-18.0pt;
	mso-ansi-font-size:10.0pt;
	font-family:Symbol;}
@list l0:level4
	{mso-level-number-format:bullet;
	mso-level-text:\F0B7;
	mso-level-tab-stop:144.0pt;
	mso-level-number-position:left;
	text-indent:-18.0pt;
	mso-ansi-font-size:10.0pt;
	font-family:Symbol;}
@list l0:level5
	{mso-level-number-format:bullet;
	mso-level-text:\F0B7;
	mso-level-tab-stop:180.0pt;
	mso-level-number-position:left;
	text-indent:-18.0pt;
	mso-ansi-font-size:10.0pt;
	font-family:Symbol;}
@list l0:level6
	{mso-level-number-format:bullet;
	mso-level-text:\F0B7;
	mso-level-tab-stop:216.0pt;
	mso-level-number-position:left;
	text-indent:-18.0pt;
	mso-ansi-font-size:10.0pt;
	font-family:Symbol;}
@list l0:level7
	{mso-level-number-format:bullet;
	mso-level-text:\F0B7;
	mso-level-tab-stop:252.0pt;
	mso-level-number-position:left;
	text-indent:-18.0pt;
	mso-ansi-font-size:10.0pt;
	font-family:Symbol;}
@list l0:level8
	{mso-level-number-format:bullet;
	mso-level-text:\F0B7;
	mso-level-tab-stop:288.0pt;
	mso-level-number-position:left;
	text-indent:-18.0pt;
	mso-ansi-font-size:10.0pt;
	font-family:Symbol;}
@list l0:level9
	{mso-level-number-format:bullet;
	mso-level-text:\F0B7;
	mso-level-tab-stop:324.0pt;
	mso-level-number-position:left;
	text-indent:-18.0pt;
	mso-ansi-font-size:10.0pt;
	font-family:Symbol;}
@list l1
	{mso-list-id:697968114;
	mso-list-template-ids:-1187977464;}
@list l1:level1
	{mso-level-number-format:bullet;
	mso-level-text:\F0B7;
	mso-level-tab-stop:36.0pt;
	mso-level-number-position:left;
	text-indent:-18.0pt;
	mso-ansi-font-size:10.0pt;
	font-family:Symbol;}
@list l1:level2
	{mso-level-number-format:bullet;
	mso-level-text:o;
	mso-level-tab-stop:72.0pt;
	mso-level-number-position:left;
	text-indent:-18.0pt;
	mso-ansi-font-size:10.0pt;
	font-family:"Courier New";
	mso-bidi-font-family:"Times New Roman";}
@list l1:level3
	{mso-level-number-format:bullet;
	mso-level-text:\F0B7;
	mso-level-tab-stop:108.0pt;
	mso-level-number-position:left;
	text-indent:-18.0pt;
	mso-ansi-font-size:10.0pt;
	font-family:Symbol;}
@list l1:level4
	{mso-level-number-format:bullet;
	mso-level-text:\F0B7;
	mso-level-tab-stop:144.0pt;
	mso-level-number-position:left;
	text-indent:-18.0pt;
	mso-ansi-font-size:10.0pt;
	font-family:Symbol;}
@list l1:level5
	{mso-level-number-format:bullet;
	mso-level-text:\F0B7;
	mso-level-tab-stop:180.0pt;
	mso-level-number-position:left;
	text-indent:-18.0pt;
	mso-ansi-font-size:10.0pt;
	font-family:Symbol;}
@list l1:level6
	{mso-level-number-format:bullet;
	mso-level-text:\F0B7;
	mso-level-tab-stop:216.0pt;
	mso-level-number-position:left;
	text-indent:-18.0pt;
	mso-ansi-font-size:10.0pt;
	font-family:Symbol;}
@list l1:level7
	{mso-level-number-format:bullet;
	mso-level-text:\F0B7;
	mso-level-tab-stop:252.0pt;
	mso-level-number-position:left;
	text-indent:-18.0pt;
	mso-ansi-font-size:10.0pt;
	font-family:Symbol;}
@list l1:level8
	{mso-level-number-format:bullet;
	mso-level-text:\F0B7;
	mso-level-tab-stop:288.0pt;
	mso-level-number-position:left;
	text-indent:-18.0pt;
	mso-ansi-font-size:10.0pt;
	font-family:Symbol;}
@list l1:level9
	{mso-level-number-format:bullet;
	mso-level-text:\F0B7;
	mso-level-tab-stop:324.0pt;
	mso-level-number-position:left;
	text-indent:-18.0pt;
	mso-ansi-font-size:10.0pt;
	font-family:Symbol;}
@list l2
	{mso-list-id:1505974751;
	mso-list-template-ids:-132378630;}
@list l2:level1
	{mso-level-number-format:bullet;
	mso-level-text:\F0B7;
	mso-level-tab-stop:36.0pt;
	mso-level-number-position:left;
	text-indent:-18.0pt;
	mso-ansi-font-size:10.0pt;
	font-family:Symbol;}
@list l2:level2
	{mso-level-number-format:bullet;
	mso-level-text:o;
	mso-level-tab-stop:72.0pt;
	mso-level-number-position:left;
	text-indent:-18.0pt;
	mso-ansi-font-size:10.0pt;
	font-family:"Courier New";
	mso-bidi-font-family:"Times New Roman";}
@list l2:level3
	{mso-level-number-format:bullet;
	mso-level-text:\F0B7;
	mso-level-tab-stop:108.0pt;
	mso-level-number-position:left;
	text-indent:-18.0pt;
	mso-ansi-font-size:10.0pt;
	font-family:Symbol;}
@list l2:level4
	{mso-level-number-format:bullet;
	mso-level-text:\F0B7;
	mso-level-tab-stop:144.0pt;
	mso-level-number-position:left;
	text-indent:-18.0pt;
	mso-ansi-font-size:10.0pt;
	font-family:Symbol;}
@list l2:level5
	{mso-level-number-format:bullet;
	mso-level-text:\F0B7;
	mso-level-tab-stop:180.0pt;
	mso-level-number-position:left;
	text-indent:-18.0pt;
	mso-ansi-font-size:10.0pt;
	font-family:Symbol;}
@list l2:level6
	{mso-level-number-format:bullet;
	mso-level-text:\F0B7;
	mso-level-tab-stop:216.0pt;
	mso-level-number-position:left;
	text-indent:-18.0pt;
	mso-ansi-font-size:10.0pt;
	font-family:Symbol;}
@list l2:level7
	{mso-level-number-format:bullet;
	mso-level-text:\F0B7;
	mso-level-tab-stop:252.0pt;
	mso-level-number-position:left;
	text-indent:-18.0pt;
	mso-ansi-font-size:10.0pt;
	font-family:Symbol;}
@list l2:level8
	{mso-level-number-format:bullet;
	mso-level-text:\F0B7;
	mso-level-tab-stop:288.0pt;
	mso-level-number-position:left;
	text-indent:-18.0pt;
	mso-ansi-font-size:10.0pt;
	font-family:Symbol;}
@list l2:level9
	{mso-level-number-format:bullet;
	mso-level-text:\F0B7;
	mso-level-tab-stop:324.0pt;
	mso-level-number-position:left;
	text-indent:-18.0pt;
	mso-ansi-font-size:10.0pt;
	font-family:Symbol;}
@list l3
	{mso-list-id:1584148848;
	mso-list-template-ids:-1489622020;}
@list l3:level1
	{mso-level-number-format:bullet;
	mso-level-text:\F0B7;
	mso-level-tab-stop:36.0pt;
	mso-level-number-position:left;
	text-indent:-18.0pt;
	mso-ansi-font-size:10.0pt;
	font-family:Symbol;}
@list l3:level2
	{mso-level-number-format:bullet;
	mso-level-text:\F0B7;
	mso-level-tab-stop:72.0pt;
	mso-level-number-position:left;
	text-indent:-18.0pt;
	mso-ansi-font-size:10.0pt;
	font-family:Symbol;}
@list l3:level3
	{mso-level-number-format:bullet;
	mso-level-text:\F0B7;
	mso-level-tab-stop:108.0pt;
	mso-level-number-position:left;
	text-indent:-18.0pt;
	mso-ansi-font-size:10.0pt;
	font-family:Symbol;}
@list l3:level4
	{mso-level-number-format:bullet;
	mso-level-text:\F0B7;
	mso-level-tab-stop:144.0pt;
	mso-level-number-position:left;
	text-indent:-18.0pt;
	mso-ansi-font-size:10.0pt;
	font-family:Symbol;}
@list l3:level5
	{mso-level-number-format:bullet;
	mso-level-text:\F0B7;
	mso-level-tab-stop:180.0pt;
	mso-level-number-position:left;
	text-indent:-18.0pt;
	mso-ansi-font-size:10.0pt;
	font-family:Symbol;}
@list l3:level6
	{mso-level-number-format:bullet;
	mso-level-text:\F0B7;
	mso-level-tab-stop:216.0pt;
	mso-level-number-position:left;
	text-indent:-18.0pt;
	mso-ansi-font-size:10.0pt;
	font-family:Symbol;}
@list l3:level7
	{mso-level-number-format:bullet;
	mso-level-text:\F0B7;
	mso-level-tab-stop:252.0pt;
	mso-level-number-position:left;
	text-indent:-18.0pt;
	mso-ansi-font-size:10.0pt;
	font-family:Symbol;}
@list l3:level8
	{mso-level-number-format:bullet;
	mso-level-text:\F0B7;
	mso-level-tab-stop:288.0pt;
	mso-level-number-position:left;
	text-indent:-18.0pt;
	mso-ansi-font-size:10.0pt;
	font-family:Symbol;}
@list l3:level9
	{mso-level-number-format:bullet;
	mso-level-text:\F0B7;
	mso-level-tab-stop:324.0pt;
	mso-level-number-position:left;
	text-indent:-18.0pt;
	mso-ansi-font-size:10.0pt;
	font-family:Symbol;}
@list l4
	{mso-list-id:2028410657;
	mso-list-template-ids:416993982;}
@list l4:level1
	{mso-level-number-format:bullet;
	mso-level-text:\F0B7;
	mso-level-tab-stop:36.0pt;
	mso-level-number-position:left;
	text-indent:-18.0pt;
	mso-ansi-font-size:10.0pt;
	font-family:Symbol;}
@list l4:level2
	{mso-level-number-format:bullet;
	mso-level-text:\F0B7;
	mso-level-tab-stop:72.0pt;
	mso-level-number-position:left;
	text-indent:-18.0pt;
	mso-ansi-font-size:10.0pt;
	font-family:Symbol;}
@list l4:level3
	{mso-level-number-format:bullet;
	mso-level-text:\F0B7;
	mso-level-tab-stop:108.0pt;
	mso-level-number-position:left;
	text-indent:-18.0pt;
	mso-ansi-font-size:10.0pt;
	font-family:Symbol;}
@list l4:level4
	{mso-level-number-format:bullet;
	mso-level-text:\F0B7;
	mso-level-tab-stop:144.0pt;
	mso-level-number-position:left;
	text-indent:-18.0pt;
	mso-ansi-font-size:10.0pt;
	font-family:Symbol;}
@list l4:level5
	{mso-level-number-format:bullet;
	mso-level-text:\F0B7;
	mso-level-tab-stop:180.0pt;
	mso-level-number-position:left;
	text-indent:-18.0pt;
	mso-ansi-font-size:10.0pt;
	font-family:Symbol;}
@list l4:level6
	{mso-level-number-format:bullet;
	mso-level-text:\F0B7;
	mso-level-tab-stop:216.0pt;
	mso-level-number-position:left;
	text-indent:-18.0pt;
	mso-ansi-font-size:10.0pt;
	font-family:Symbol;}
@list l4:level7
	{mso-level-number-format:bullet;
	mso-level-text:\F0B7;
	mso-level-tab-stop:252.0pt;
	mso-level-number-position:left;
	text-indent:-18.0pt;
	mso-ansi-font-size:10.0pt;
	font-family:Symbol;}
@list l4:level8
	{mso-level-number-format:bullet;
	mso-level-text:\F0B7;
	mso-level-tab-stop:288.0pt;
	mso-level-number-position:left;
	text-indent:-18.0pt;
	mso-ansi-font-size:10.0pt;
	font-family:Symbol;}
@list l4:level9
	{mso-level-number-format:bullet;
	mso-level-text:\F0B7;
	mso-level-tab-stop:324.0pt;
	mso-level-number-position:left;
	text-indent:-18.0pt;
	mso-ansi-font-size:10.0pt;
	font-family:Symbol;}
ol
	{margin-bottom:0cm;}
ul
	{margin-bottom:0cm;}
--></style><!--[if gte mso 9]><xml>
<o:shapedefaults v:ext=3D"edit" spidmax=3D"1026" />
</xml><![endif]--><!--[if gte mso 9]><xml>
<o:shapelayout v:ext=3D"edit">
<o:idmap v:ext=3D"edit" data=3D"1" />
</o:shapelayout></xml><![endif]-->
</head>
<body lang=3D"ZH-CN" link=3D"#0563C1" vlink=3D"#954F72" style=3D"text-justi=
fy-trim:punctuation">
<div class=3D"WordSection1">
<p style=3D"line-height:150%"><span lang=3D"EN-US" style=3D"font-family:Hel=
veticaNeue;color:black">Hi all,<o:p></o:p></span></p>
<p style=3D"line-height:150%"><b><span lang=3D"EN-US" style=3D"font-family:=
HelveticaNeue;color:black">Do you have patches for BlueZ to avoid Bluetooth=
 curve attack ?
<o:p></o:p></span></b></p>
<p style=3D"line-height:150%"><b><span lang=3D"EN-US" style=3D"font-family:=
HelveticaNeue;color:black">As I know, Many vendors supply Android Flueride =
host fixes &amp; Firmware fixes to avoid the curve attack, but BlueZ commun=
ity doesn&#8217;t have the topic. Does there have
 plan to fix the hole ? <o:p></o:p></span></b></p>
<p style=3D"line-height:150%"><span lang=3D"EN-US" style=3D"font-size:13.0p=
t;line-height:150%;font-family:HelveticaNeue;color:#333333"><o:p>&nbsp;</o:=
p></span></p>
<p style=3D"line-height:150%"><b><span lang=3D"EN-US" style=3D"font-family:=
HelveticaNeue;color:black">Summary</span></b><span lang=3D"EN-US" style=3D"=
font-family:HelveticaNeue;color:#333333"><o:p></o:p></span></p>
<p style=3D"line-height:150%"><span lang=3D"EN-US" style=3D"font-size:10.5p=
t;line-height:150%;font-family:HelveticaNeue;color:black">Bluetooth firmwar=
e or operating system software drivers may not sufficiently validate ellipt=
ic curve parameters used to generate public
 keys during a Diffie-Hellman key exchange, which may allow a remote attack=
er to obtain the encryption key used by the device.</span><span lang=3D"EN-=
US" style=3D"font-size:10.5pt;line-height:150%;font-family:HelveticaNeue;co=
lor:#333333"><o:p></o:p></span></p>
<table class=3D"MsoNormalTable" border=3D"0" cellspacing=3D"0" cellpadding=
=3D"0" style=3D"background:white;border-collapse:collapse">
<tbody>
<tr>
<td valign=3D"bottom" style=3D"background:transparent;padding:0cm 0cm 0cm 0=
cm">
<p class=3D"MsoNormal" style=3D"line-height:150%"><b><span lang=3D"EN-US" s=
tyle=3D"color:#333333">Impact</span></b><span lang=3D"EN-US" style=3D"color=
:#333333"><o:p></o:p></span></p>
<ul style=3D"margin-top:0cm" type=3D"disc">
<li class=3D"MsoNormal" style=3D"color:#333333;line-height:150%;mso-list:l3=
 level1 lfo1">
<span lang=3D"EN-US">An unauthenticated, remote attacker within range may b=
e able to utilize a man-in-the-middle network position to determine the cry=
ptographic keys used by the device.<o:p></o:p></span></li><li class=3D"MsoN=
ormal" style=3D"color:#333333;line-height:150%;mso-list:l3 level1 lfo1">
<span lang=3D"EN-US">The attacker can then intercept and decrypt and/or for=
ge and inject device messages.<o:p></o:p></span></li><li class=3D"MsoNormal=
" style=3D"color:#333333;line-height:150%;mso-list:l3 level1 lfo1">
<span lang=3D"EN-US">The attack exploits the vulnerability on both particip=
ating devices simultaneously. If any one of them is patched, the attack doe=
s not work
<o:p></o:p></span></li><li class=3D"MsoNormal" style=3D"color:#333333;line-=
height:150%;mso-list:l3 level1 lfo1">
<span lang=3D"EN-US">Every Bluetooth chip manufactured by Intel, Broadcom o=
r Qualcomm is likely affected.
<o:p></o:p></span></li></ul>
<p class=3D"MsoNormal" style=3D"line-height:150%"><span lang=3D"EN-US" styl=
e=3D"color:#333333">&nbsp;<b>NXP Potential Impact</b><o:p></o:p></span></p>
<ul style=3D"margin-top:0cm" type=3D"disc">
<li class=3D"MsoNormal" style=3D"color:#333333;line-height:150%;mso-list:l2=
 level1 lfo2">
<span lang=3D"EN-US">Potentially all products listed in this link &nbsp;bel=
ow will be susceptible
<o:p></o:p></span>
<ul style=3D"margin-top:0cm" type=3D"circle">
<li class=3D"MsoNormal" style=3D"color:#333333;line-height:150%;mso-list:l2=
 level2 lfo2">
<span lang=3D"EN-US"><a href=3D"https://emea01.safelinks.protection.outlook=
.com/?url=3Dhttps%3A%2F%2Fwww.nxp.com%2Fproducts%2Fwireless-connectivity%2F=
bluetooth-low-energy-ble%3ABLUETOOTH-LOW-ENERGY-BLE&amp;data=3D02%7C01%7Cfu=
gang.duan%40nxp.com%7C7e9ffc5ca0a74d3c79a808d5f7572b4d%7C686ea1d3bc2b4c6fa9=
2cd99c5c301635%7C0%7C0%7C636686876125441293&amp;sdata=3Diqe9ggsKa%2FQzioW3W=
y6KYro%2FQw8zMAVR%2F6MmjgDsAGU%3D&amp;reserved=3D0">https://www.nxp.com/pro=
ducts/wireless-connectivity/bluetooth-low-energy-ble:BLUETOOTH-LOW-ENERGY-B=
LE</a><o:p></o:p></span></li></ul>
</li><li class=3D"MsoNormal" style=3D"color:#333333;line-height:150%;mso-li=
st:l2 level1 lfo2">
<span lang=3D"EN-US">All i.MX BSP Android and Linux BSP releases that suppo=
rt Bluetooth chipsets will probably impacted and require patching<o:p></o:p=
></span></li></ul>
</td>
</tr>
<tr>
<td valign=3D"bottom" style=3D"background:transparent;padding:0cm 0cm 0cm 0=
cm">
<ul style=3D"margin-top:0cm" type=3D"disc">
<li class=3D"MsoNormal" style=3D"color:#333333;line-height:150%;mso-list:l0=
 level1 lfo3">
<a name=3D"solution"></a><span lang=3D"EN-US">NXP has currently not been li=
sted as an impacted vendor in the
<a href=3D"https://emea01.safelinks.protection.outlook.com/?url=3Dhttps%3A%=
2F%2Fwww.kb.cert.org%2Fvuls%2Fid%2F304725&amp;data=3D02%7C01%7Cfugang.duan%=
40nxp.com%7C7e9ffc5ca0a74d3c79a808d5f7572b4d%7C686ea1d3bc2b4c6fa92cd99c5c30=
1635%7C0%7C0%7C636686876125451302&amp;sdata=3D4JCI27G1t3tf8qd5W01s5d8Oxh4UO=
D8DXFASfslRiaI%3D&amp;reserved=3D0">
CERT CC website</a><o:p></o:p></span></li></ul>
<p class=3D"MsoNormal" style=3D"line-height:150%"><b><span lang=3D"EN-US" s=
tyle=3D"color:#333333">&nbsp;Mitigation</span></b><span lang=3D"EN-US" styl=
e=3D"color:#333333"><o:p></o:p></span></p>
<ul style=3D"margin-top:0cm" type=3D"disc">
<li class=3D"MsoNormal" style=3D"color:#333333;line-height:150%;mso-list:l4=
 level1 lfo4">
<span lang=3D"EN-US">Both software and firmware updates will be required<o:=
p></o:p></span></li></ul>
<ul style=3D"margin-top:0cm" type=3D"disc">
<li class=3D"MsoNormal" style=3D"color:#333333;line-height:150%;mso-list:l1=
 level1 lfo5">
<span lang=3D"EN-US">Looks like Android included this in their June Release=
 for Broadcom, Qualcomm a BT chipsets.
<o:p></o:p></span>
<ul style=3D"margin-top:0cm" type=3D"circle">
<li class=3D"MsoNormal" style=3D"color:#333333;line-height:150%;mso-list:l1=
 level2 lfo5">
<span lang=3D"EN-US"><a href=3D"https://emea01.safelinks.protection.outlook=
.com/?url=3Dhttps%3A%2F%2Fsource.android.com%2Fsecurity%2Fbulletin%2F2018-0=
6-01&amp;data=3D02%7C01%7Cfugang.duan%40nxp.com%7C7e9ffc5ca0a74d3c79a808d5f=
7572b4d%7C686ea1d3bc2b4c6fa92cd99c5c301635%7C0%7C0%7C636686876125461314&amp=
;sdata=3Dga8hK0rQvzVmttAWh1EgJay04BrivKezVqLvZgjwfR8%3D&amp;reserved=3D0">h=
ttps://source.android.com/security/bulletin/2018-06-01</a><o:p></o:p></span=
></li></ul>
</li><li class=3D"MsoNormal" style=3D"color:#333333;line-height:150%;mso-li=
st:l1 level1 lfo5">
<span lang=3D"EN-US">Linux BT driver updates will also be required <o:p></o=
:p></span>
<ul style=3D"margin-top:0cm" type=3D"circle">
<li class=3D"MsoNormal" style=3D"color:#333333;line-height:150%;mso-list:l1=
 level2 lfo5">
<span lang=3D"EN-US">Apparently Linux versions prior to 3.19 don't support =
Bluetooth LE Secure Connections and are therefore not vulnerable<o:p></o:p>=
</span></li></ul>
</li></ul>
</td>
</tr>
</tbody>
</table>
<p class=3D"MsoNormal"><span lang=3D"EN-US" style=3D"font-size:10.5pt;color=
:#0070C0"><o:p>&nbsp;</o:p></span></p>
<p class=3D"MsoNormal"><span lang=3D"EN-US" style=3D"font-size:10.5pt;color=
:#0070C0"><o:p>&nbsp;</o:p></span></p>
<p class=3D"MsoNormal"><span lang=3D"EN-US" style=3D"font-size:10.5pt;color=
:#0070C0">Regards,<o:p></o:p></span></p>
<p class=3D"MsoNormal"><span lang=3D"EN-US" style=3D"font-size:10.5pt;color=
:#0070C0">Andy Duan<o:p></o:p></span></p>
</div>
</body>
</html>

--_000_VI1PR0402MB3600BAF04C81783B3A119AB6FF0A0VI1PR0402MB3600_--
