Return-Path: <bluez-users-admin@lists.sourceforge.net>
From: "Patrick Laplante" <plaplante@vanteon.com>
To: <bluez-users@lists.sourceforge.net>
MIME-Version: 1.0
Content-Type: multipart/alternative;
	boundary="----=_NextPart_000_0016_01C6502F.6AE7D0E0"
Message-ID: <E1FNH0j-0003Bs-QK@mail.sourceforge.net>
Subject: [Bluez-users] Question about licensing!
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
Date: Sat, 25 Mar 2006 17:13:14 -0500

This is a multi-part message in MIME format.

------=_NextPart_000_0016_01C6502F.6AE7D0E0
Content-Type: text/plain;
	charset="us-ascii"
Content-Transfer-Encoding: 7bit

Hi all,

 

I am currently working on a Linux based project that need Bluetooth support.
I need to basically receive images from Bluetooth devices and print them.

 

The code printing the images is proprietary and can't be GPL'd.

 

Since bluez is GPL, I can't just link against it without being forced to
make my code GPL which I can't, my customer won't allow me to release their
IP to the public.

 

I was thinking of doing this:

 

A small daemon that uses the bluez library that would, on image reception
from a device, push the image to another print daemon over a name pipe or
socket.  Does this break the GPL in any way?  If I understand the license
correctly, I would have to make my Bluetooth daemon GPL but my print daemon
wouldn't have to be GPL.

 

Can you please confirm?  Do you guys have any issue with that?

 

The last thing I want to do is upset anybody or put my customer in a
position where he could be sued.  Worst case, I'll have to buy a stack from
a company like StoneStreet or implement a custom stack for my customer
(which will bump the price by a lot :-)).

 

Regards,

 

Pat Laplante
Principal Engineer

Vanteon Corporation
2851 Clover Street
Pittsford, NY 14534-1711
Office: (585) 248-0510 x298
Fax: (585) 248-0537
www.vanteon.com  <http://www.vanteon.com> - Embedded for Your Future 

 


------=_NextPart_000_0016_01C6502F.6AE7D0E0
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
<meta name=3DGenerator content=3D"Microsoft Word 11 (filtered medium)">
<o:SmartTagType =
namespaceuri=3D"urn:schemas-microsoft-com:office:smarttags"
 name=3D"place"/>
<o:SmartTagType =
namespaceuri=3D"urn:schemas-microsoft-com:office:smarttags"
 name=3D"PostalCode"/>
<o:SmartTagType =
namespaceuri=3D"urn:schemas-microsoft-com:office:smarttags"
 name=3D"State"/>
<o:SmartTagType =
namespaceuri=3D"urn:schemas-microsoft-com:office:smarttags"
 name=3D"City"/>
<o:SmartTagType =
namespaceuri=3D"urn:schemas-microsoft-com:office:smarttags"
 name=3D"Street"/>
<o:SmartTagType =
namespaceuri=3D"urn:schemas-microsoft-com:office:smarttags"
 name=3D"address"/>
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
 /* Style Definitions */
 p.MsoNormal, li.MsoNormal, div.MsoNormal
	{margin:0in;
	margin-bottom:.0001pt;
	font-size:12.0pt;
	font-family:"Times New Roman";}
a:link, span.MsoHyperlink
	{color:blue;
	text-decoration:underline;}
a:visited, span.MsoHyperlinkFollowed
	{color:purple;
	text-decoration:underline;}
span.EmailStyle17
	{mso-style-type:personal-compose;
	font-family:Arial;
	color:windowtext;}
@page Section1
	{size:8.5in 11.0in;
	margin:1.0in 1.25in 1.0in 1.25in;}
div.Section1
	{page:Section1;}
-->
</style>

</head>

<body lang=3DEN-US link=3Dblue vlink=3Dpurple>

<div class=3DSection1>

<p class=3DMsoNormal><font size=3D2 face=3DArial><span =
style=3D'font-size:10.0pt;
font-family:Arial'>Hi all,<o:p></o:p></span></font></p>

<p class=3DMsoNormal><font size=3D2 face=3DArial><span =
style=3D'font-size:10.0pt;
font-family:Arial'><o:p>&nbsp;</o:p></span></font></p>

<p class=3DMsoNormal><font size=3D2 face=3DArial><span =
style=3D'font-size:10.0pt;
font-family:Arial'>I am currently working on a Linux based project that =
need Bluetooth
support.&nbsp; I need to basically receive images from Bluetooth devices =
and print
them.<o:p></o:p></span></font></p>

<p class=3DMsoNormal><font size=3D2 face=3DArial><span =
style=3D'font-size:10.0pt;
font-family:Arial'><o:p>&nbsp;</o:p></span></font></p>

<p class=3DMsoNormal><font size=3D2 face=3DArial><span =
style=3D'font-size:10.0pt;
font-family:Arial'>The code printing the images is proprietary and =
can&#8217;t
be GPL&#8217;d.<o:p></o:p></span></font></p>

<p class=3DMsoNormal><font size=3D2 face=3DArial><span =
style=3D'font-size:10.0pt;
font-family:Arial'><o:p>&nbsp;</o:p></span></font></p>

<p class=3DMsoNormal><font size=3D2 face=3DArial><span =
style=3D'font-size:10.0pt;
font-family:Arial'>Since bluez is GPL, I can&#8217;t just link against =
it
without being forced to make my code GPL which I can&#8217;t, my =
customer won&#8217;t
allow me to release their IP to the public.<o:p></o:p></span></font></p>

<p class=3DMsoNormal><font size=3D2 face=3DArial><span =
style=3D'font-size:10.0pt;
font-family:Arial'><o:p>&nbsp;</o:p></span></font></p>

<p class=3DMsoNormal><font size=3D2 face=3DArial><span =
style=3D'font-size:10.0pt;
font-family:Arial'>I was thinking of doing =
this:<o:p></o:p></span></font></p>

<p class=3DMsoNormal><font size=3D2 face=3DArial><span =
style=3D'font-size:10.0pt;
font-family:Arial'><o:p>&nbsp;</o:p></span></font></p>

<p class=3DMsoNormal><font size=3D2 face=3DArial><span =
style=3D'font-size:10.0pt;
font-family:Arial'>A small daemon that uses the bluez library that =
would, on
image reception from a device, push the image to another print daemon =
over a
name pipe or socket. &nbsp;Does this break the GPL in any way?&nbsp; If =
I understand the
license correctly, I would have to make my Bluetooth daemon GPL but my =
print
daemon wouldn&#8217;t have to be GPL.<o:p></o:p></span></font></p>

<p class=3DMsoNormal><font size=3D2 face=3DArial><span =
style=3D'font-size:10.0pt;
font-family:Arial'><o:p>&nbsp;</o:p></span></font></p>

<p class=3DMsoNormal><font size=3D2 face=3DArial><span =
style=3D'font-size:10.0pt;
font-family:Arial'>Can you please confirm?&nbsp; Do you guys have any =
issue with
that?<o:p></o:p></span></font></p>

<p class=3DMsoNormal><font size=3D2 face=3DArial><span =
style=3D'font-size:10.0pt;
font-family:Arial'><o:p>&nbsp;</o:p></span></font></p>

<p class=3DMsoNormal><font size=3D2 face=3DArial><span =
style=3D'font-size:10.0pt;
font-family:Arial'>The last thing I want to do is upset anybody or put =
my
customer in a position where he could be sued. &nbsp;Worst case, =
I&#8217;ll have to
buy a stack from a company like StoneStreet or implement a custom stack =
for my
customer (which will bump the price by a lot </span></font><font =
size=3D2
face=3DWingdings><span =
style=3D'font-size:10.0pt;font-family:Wingdings'>J</span></font><font
size=3D2 face=3DArial><span =
style=3D'font-size:10.0pt;font-family:Arial'>).<o:p></o:p></span></font><=
/p>

<p class=3DMsoNormal><font size=3D2 face=3DArial><span =
style=3D'font-size:10.0pt;
font-family:Arial'><o:p>&nbsp;</o:p></span></font></p>

<p class=3DMsoNormal><font size=3D2 face=3DArial><span =
style=3D'font-size:10.0pt;
font-family:Arial'>Regards,<o:p></o:p></span></font></p>

<p class=3DMsoNormal><font size=3D2 face=3DArial><span =
style=3D'font-size:10.0pt;
font-family:Arial'><o:p>&nbsp;</o:p></span></font></p>

<p class=3DMsoNormal><b><font size=3D3 face=3D"Times New Roman"><span
style=3D'font-size:12.0pt;font-weight:bold'>Pat =
Laplante</span></font></b><br>
Principal Engineer<o:p></o:p></p>

<p class=3DMsoNormal><font size=3D3 face=3D"Times New Roman"><span =
style=3D'font-size:
12.0pt'>Vanteon Corporation<br>
<st1:Street w:st=3D"on"><st1:address w:st=3D"on">2851 Clover =
Street</st1:address></st1:Street><br>
<st1:place w:st=3D"on"><st1:City w:st=3D"on">Pittsford</st1:City>, =
<st1:State
 w:st=3D"on">NY</st1:State> <st1:PostalCode =
w:st=3D"on">14534-1711</st1:PostalCode></st1:place><br>
Office: (585) 248-0510 x298<br>
Fax: (585) 248-0537<br>
<a href=3D"http://www.vanteon.com">www.vanteon.com </a>- <i><span
style=3D'font-style:italic'>Embedded for Your Future</span></i> =
</span><o:p></o:p></font></p>

<p class=3DMsoNormal><font size=3D3 face=3D"Times New Roman"><span =
style=3D'font-size:
12.0pt'><o:p>&nbsp;</o:p></span></font></p>

</div>

</body>

</html>

------=_NextPart_000_0016_01C6502F.6AE7D0E0--



-------------------------------------------------------
This SF.Net email is sponsored by xPML, a groundbreaking scripting language
that extends applications into web and mobile media. Attend the live webcast
and join the prime developer group breaking into this new coding territory!
http://sel.as-us.falkag.net/sel?cmd=lnk&kid=110944&bid=241720&dat=121642
_______________________________________________
Bluez-users mailing list
Bluez-users@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-users
