Return-Path: <bluez-devel-admin@lists.sourceforge.net>
Message-ID: <41A7074C00357A08@resmta03.ono.com> (added by postmaster@resmta03.ono.com)
From: "radeX" <radex@ono.com>
To: <bluez-devel@lists.sourceforge.net>
MIME-Version: 1.0
Content-Type: multipart/alternative;
	boundary="----=_NextPart_000_0000_01C4F08C.061B5A00"
Subject: [Bluez-devel] HCI forwarding
Sender: bluez-devel-admin@lists.sourceforge.net
Errors-To: bluez-devel-admin@lists.sourceforge.net
Reply-To: bluez-devel@lists.sourceforge.net
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-devel>,
	<mailto:bluez-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Id: BlueZ development <bluez-devel.lists.sourceforge.net>
List-Post: <mailto:bluez-devel@lists.sourceforge.net>
List-Help: <mailto:bluez-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-devel>,
	<mailto:bluez-devel-request@lists.sourceforge.net?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=bluez-devel>
Date: Sun, 2 Jan 2005 05:29:25 +0100

This is a multi-part message in MIME format.

------=_NextPart_000_0000_01C4F08C.061B5A00
Content-Type: text/plain;
	charset="us-ascii"
Content-Transfer-Encoding: 7bit

Hi everybody:

 

I've been months reading the bluez source and learning about the bluetooth
specification, plus other documents (the correct coding style, Wireless
Technologies Congress 2003 and other documents by Marcel holtmann)

 

I'm developing an application to connect two Bluetooth-enabled phones via
internet using two Bluetooth-enabled PCs both connected to internet. I mean
that I can transmit files and play Bluetooth multiplayer games to my friend
that is 25 miles away like if it were in my device's Bluetooth radio range.
(I know that ping times would be very ugly!).

I use a raw socket as hcidump does, then I send the data trough TCP to the
other peer, when received is sent over Bluetooth hoping that the other
device receives it, this is more complex than it seems since bluez handles
and answers all HCI requests, i.e (when a device performs a SDP request to
find a service UUID bluez handles and answers the request) but this is not
correct for my application, hci responses and data acks may be received via
TCP from the other peer, in other words: no bluez support, only HCI frames
sniffing, sending, receiving and transmitting. Now my questions are:

 

-          Can I send HCI frames with a raw socket ?

-          How can I tell the bluez stack not to answer HCI requests
(receiving only, leave the sends to me).

 

-     Is there a better way to make this application?

 

Any help would be greatly appreciated.

 

Thanks in advance and happy new year.


------=_NextPart_000_0000_01C4F08C.061B5A00
Content-Type: text/html;
	charset="us-ascii"
Content-Transfer-Encoding: quoted-printable

<html xmlns:o=3D"urn:schemas-microsoft-com:office:office" =
xmlns:w=3D"urn:schemas-microsoft-com:office:word" =
xmlns:st1=3D"urn:schemas-microsoft-com:office:smarttags" =
xmlns=3D"http://www.w3.org/TR/REC-html40">

<head>
<meta http-equiv=3DContent-Type content=3D"text/html; =
charset=3Dus-ascii">
<meta name=3DGenerator content=3D"Microsoft Word 11 (filtered medium)">
<o:SmartTagType =
namespaceuri=3D"urn:schemas-microsoft-com:office:smarttags"
 name=3D"metricconverter"/>
<!--[if !mso]>
<style>
st1\:*{behavior:url(#default#ieooui) }
</style>
<![endif]-->
<style>
<!--
 /* Font Definitions */
 @font-face
	{font-family:Wingdings;
	panose-1:5 0 0 0 0 0 0 0 0 0;}
@font-face
	{font-family:Thorndale;
	panose-1:0 0 0 0 0 0 0 0 0 0;}
 /* Style Definitions */
 p.MsoNormal, li.MsoNormal, div.MsoNormal
	{margin:0cm;
	margin-bottom:.0001pt;
	font-size:12.0pt;
	font-family:"Times New Roman";}
a:link, span.MsoHyperlink
	{color:blue;
	text-decoration:underline;}
a:visited, span.MsoHyperlinkFollowed
	{color:purple;
	text-decoration:underline;}
span.EstiloCorreo17
	{mso-style-type:personal-compose;
	font-family:Arial;
	color:windowtext;}
@page Section1
	{size:595.3pt 841.9pt;
	margin:70.85pt 3.0cm 70.85pt 3.0cm;}
div.Section1
	{page:Section1;}
 /* List Definitions */
 @list l0
	{mso-list-id:193813871;
	mso-list-type:hybrid;
	mso-list-template-ids:1337357728 -1367337772 201981955 201981957 =
201981953 201981955 201981957 201981953 201981955 201981957;}
@list l0:level1
	{mso-level-start-at:0;
	mso-level-number-format:bullet;
	mso-level-text:-;
	mso-level-tab-stop:36.0pt;
	mso-level-number-position:left;
	text-indent:-18.0pt;
	font-family:Arial;
	mso-fareast-font-family:"Times New Roman";}
ol
	{margin-bottom:0cm;}
ul
	{margin-bottom:0cm;}
-->
</style>

</head>

<body lang=3DES link=3Dblue vlink=3Dpurple>

<div class=3DSection1>

<p class=3DMsoNormal><font size=3D2 face=3DArial><span =
style=3D'font-size:10.0pt;
font-family:Arial'>Hi everybody:<o:p></o:p></span></font></p>

<p class=3DMsoNormal><font size=3D2 face=3DArial><span =
style=3D'font-size:10.0pt;
font-family:Arial'><o:p>&nbsp;</o:p></span></font></p>

<p class=3DMsoNormal style=3D'text-autospace:none'><font size=3D2 =
face=3DArial><span
lang=3DEN-GB style=3D'font-size:10.0pt;font-family:Arial'>I&#8217;ve =
been months
reading the bluez source and learning about the bluetooth specification, =
plus other
documents (the correct coding style, </span></font><font size=3D2 =
face=3DThorndale><span
lang=3DEN-GB style=3D'font-size:10.0pt;font-family:Thorndale'>Wireless =
Technologies
Congress 2003 and other documents by Marcel =
holtmann)<o:p></o:p></span></font></p>

<p class=3DMsoNormal><font size=3D2 face=3DArial><span lang=3DEN-GB =
style=3D'font-size:
10.0pt;font-family:Arial'><o:p>&nbsp;</o:p></span></font></p>

<p class=3DMsoNormal><font size=3D2 face=3DArial><span lang=3DEN-GB =
style=3D'font-size:
10.0pt;font-family:Arial'>I&#8217;m developing an application to connect =
two Bluetooth-enabled
phones via internet using two Bluetooth-enabled PCs both connected to =
internet.
I mean that I can transmit files and play Bluetooth multiplayer games to =
my
friend that is <st1:metricconverter ProductID=3D"25 miles" =
w:st=3D"on">25 miles</st1:metricconverter>
away like if it were in my device&#8217;s Bluetooth radio range. (I know =
that
ping times would be very ugly!).<o:p></o:p></span></font></p>

<p class=3DMsoNormal><font size=3D2 face=3DArial><span lang=3DEN-GB =
style=3D'font-size:
10.0pt;font-family:Arial'>I use a raw socket as hcidump does, then I =
send the
data trough TCP to the other peer, when received is sent over Bluetooth =
hoping
that the other device receives it, this is more complex than it seems =
since
bluez handles and answers all HCI requests, i.e (when a device performs =
a SDP
request to find a service UUID bluez handles and answers the request) =
but this
is not correct for my application, hci responses and data acks may be =
received
via TCP from the other peer, in other words: no bluez support, only HCI =
frames
sniffing, sending, receiving and transmitting. Now my questions =
are:<o:p></o:p></span></font></p>

<p class=3DMsoNormal><font size=3D2 face=3DArial><span lang=3DEN-GB =
style=3D'font-size:
10.0pt;font-family:Arial'><o:p>&nbsp;</o:p></span></font></p>

<p class=3DMsoNormal =
style=3D'margin-left:36.0pt;text-indent:-18.0pt;mso-list:l0 level1 =
lfo1'><![if !supportLists]><font
size=3D2 face=3DArial><span lang=3DEN-GB =
style=3D'font-size:10.0pt;font-family:Arial'><span
style=3D'mso-list:Ignore'>-<font size=3D1 face=3D"Times New Roman"><span
style=3D'font:7.0pt "Times New =
Roman"'>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
</span></font></span></span></font><![endif]><font size=3D2 =
face=3DArial><span
lang=3DEN-GB style=3D'font-size:10.0pt;font-family:Arial'>Can I send HCI =
frames
with a raw socket ?<o:p></o:p></span></font></p>

<p class=3DMsoNormal =
style=3D'margin-left:36.0pt;text-indent:-18.0pt;mso-list:l0 level1 =
lfo1'><![if !supportLists]><font
size=3D2 face=3DArial><span lang=3DEN-GB =
style=3D'font-size:10.0pt;font-family:Arial'><span
style=3D'mso-list:Ignore'>-<font size=3D1 face=3D"Times New Roman"><span
style=3D'font:7.0pt "Times New =
Roman"'>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
</span></font></span></span></font><![endif]><font size=3D2 =
face=3DArial><span
lang=3DEN-GB style=3D'font-size:10.0pt;font-family:Arial'>How can I tell =
the bluez
stack not to answer HCI requests (receiving only, leave the sends to =
me).<o:p></o:p></span></font></p>

<p class=3DMsoNormal><font size=3D2 face=3DArial><span lang=3DEN-GB =
style=3D'font-size:
10.0pt;font-family:Arial'><o:p>&nbsp;</o:p></span></font></p>

<p class=3DMsoNormal style=3D'margin-left:18.0pt'><font size=3D2 =
face=3DArial><span
lang=3DEN-GB style=3D'font-size:10.0pt;font-family:Arial'>- =
&nbsp;&nbsp;&nbsp; Is
there a better way to make this =
application?<o:p></o:p></span></font></p>

<p class=3DMsoNormal><font size=3D2 face=3DArial><span lang=3DEN-GB =
style=3D'font-size:
10.0pt;font-family:Arial'><o:p>&nbsp;</o:p></span></font></p>

<p class=3DMsoNormal><font size=3D2 face=3DArial><span lang=3DEN-GB =
style=3D'font-size:
10.0pt;font-family:Arial'>Any help would be greatly =
appreciated.<o:p></o:p></span></font></p>

<p class=3DMsoNormal><font size=3D2 face=3DArial><span lang=3DEN-GB =
style=3D'font-size:
10.0pt;font-family:Arial'><o:p>&nbsp;</o:p></span></font></p>

<p class=3DMsoNormal><font size=3D2 face=3DArial><span lang=3DEN-GB =
style=3D'font-size:
10.0pt;font-family:Arial'>Thanks in advance and happy new =
year.<o:p></o:p></span></font></p>

</div>

</body>

</html>

------=_NextPart_000_0000_01C4F08C.061B5A00--




-------------------------------------------------------
The SF.Net email is sponsored by: Beat the post-holiday blues
Get a FREE limited edition SourceForge.net t-shirt from ThinkGeek.
It's fun and FREE -- well, almost....http://www.thinkgeek.com/sfshirt
_______________________________________________
Bluez-devel mailing list
Bluez-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-devel
