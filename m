Return-Path: <cyrus@holtmann.org>
From: "Heston James - Cold Beans" <heston.james@coldbeans.co.uk>
To: "'BlueZ development'" <bluez-devel@lists.sourceforge.net>
Date: Sun, 27 Jul 2008 10:51:35 +0100
Message-ID: <003a01c8efce$6103a770$230af650$@james@coldbeans.co.uk>
MIME-Version: 1.0
Subject: [Bluez-devel] BlueZ not responding to dbus
Reply-To: BlueZ development <bluez-devel@lists.sourceforge.net>
List-Id: BlueZ development <bluez-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-devel>,
	<mailto:bluez-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=bluez-devel>
List-Post: <mailto:bluez-devel@lists.sourceforge.net>
List-Help: <mailto:bluez-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-devel>,
	<mailto:bluez-devel-request@lists.sourceforge.net?subject=subscribe>
Content-Type: multipart/mixed; boundary="===============1240843233=="
Sender: bluez-devel-bounces@lists.sourceforge.net
Errors-To: bluez-devel-bounces@lists.sourceforge.net

This is a multipart message in MIME format.

--===============1240843233==
Content-Type: multipart/alternative;
	boundary="----=_NextPart_000_003B_01C8EFD6.C2C80F70"
Content-Language: en-gb

This is a multipart message in MIME format.

------=_NextPart_000_003B_01C8EFD6.C2C80F70
Content-Type: text/plain;
	charset="us-ascii"
Content-Transfer-Encoding: 7bit

Good morning guys,

 

I've tried discussing this on IRC over the past couple of days,
unfortunately my  net connection here is a little sketchy and I seem to drop
off the channel before I get chance to discuss it properly with anyone.

 

At the moment I can only describe the symptoms I've been seeing and with any
luck you'll be able to help me debug and diagnose the root cause of the
problem.

 

The problem seems to occur when performing an inquiry (periodic) when there
are many devices present, when performing the same operations during quieter
times in the office we don't seem to see this issue, however, when staff
here and in the neighbouring office turn up we start having problems.

 

Essentially it would seem that all other calls to the bluez dbus interfaces
results in the following error:

 

"DBusException: org.freedesktop.DBus.Error.NoReply: Did not receive a reply.
Possible causes include: the remote application did not send a reply, the
message bus security policy blocked the reply, the reply timeout expired, or
the network connection was broken."

 

This is true for seemingly any calls I try to make, whether it be
GetAddress(), DefaultAdapter(),GetRemoteServiceHandles() or seemingly even
any of the operations invoked by obex-data-server.

 

Once I start to receive these errors, I kill my application and then try to
relaunch it and I receive:

 

"ERROR:dbus.proxies:Introspect error on :1.0:/org/bluez:
dbus.exceptions.DBusException: org.freedesktop.DBus.Error.NoReply: Did not
receive a reply. Possible causes include: the remote application did not
send a reply, the message bus security policy blocked the reply, the reply
timeout expired, or the network connection was broken."

 

Can anyone give me any idea as to whether this is normal behaviour? Or is
this due to me doing something wrong with the Bluetooth stack? I've been
testing this with BlueZ 3.36 on Kernel 2.6.25 and dbus 1.2 and I'm using the
BlueZ 3.x API.

 

I'd really appreciate any and all suggestions on this guys, I'm open to any
ideas J

 

Cheers.

 

Heston


------=_NextPart_000_003B_01C8EFD6.C2C80F70
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
	{font-family:Wingdings;
	panose-1:5 0 0 0 0 0 0 0 0 0;}
@font-face
	{font-family:"Cambria Math";
	panose-1:2 4 5 3 5 4 6 3 2 4;}
@font-face
	{font-family:Calibri;
	panose-1:2 15 5 2 2 2 4 3 2 4;}
 /* Style Definitions */
 p.MsoNormal, li.MsoNormal, div.MsoNormal
	{margin:0cm;
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
span.EmailStyle17
	{mso-style-type:personal-compose;
	font-family:"Calibri","sans-serif";
	color:windowtext;}
.MsoChpDefault
	{mso-style-type:export-only;}
@page Section1
	{size:612.0pt 792.0pt;
	margin:72.0pt 72.0pt 72.0pt 72.0pt;}
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

<body lang=3DEN-GB link=3Dblue vlink=3Dpurple>

<div class=3DSection1>

<p class=3DMsoNormal>Good morning guys,<o:p></o:p></p>

<p class=3DMsoNormal><o:p>&nbsp;</o:p></p>

<p class=3DMsoNormal>I&#8217;ve tried discussing this on IRC over the =
past couple
of days, unfortunately my &nbsp;net connection here is a little sketchy =
and I
seem to drop off the channel before I get chance to discuss it properly =
with
anyone.<o:p></o:p></p>

<p class=3DMsoNormal><o:p>&nbsp;</o:p></p>

<p class=3DMsoNormal>At the moment I can only describe the symptoms =
I&#8217;ve
been seeing and with any luck you&#8217;ll be able to help me debug and =
diagnose
the root cause of the problem.<o:p></o:p></p>

<p class=3DMsoNormal><o:p>&nbsp;</o:p></p>

<p class=3DMsoNormal>The problem seems to occur when performing an =
inquiry (periodic)
when there are many devices present, when performing the same operations =
during
quieter times in the office we don&#8217;t seem to see this issue, =
however,
when staff here and in the neighbouring office turn up we start having
problems.<o:p></o:p></p>

<p class=3DMsoNormal><o:p>&nbsp;</o:p></p>

<p class=3DMsoNormal>Essentially it would seem that all other calls to =
the bluez
dbus interfaces results in the following error:<o:p></o:p></p>

<p class=3DMsoNormal><o:p>&nbsp;</o:p></p>

<p class=3DMsoNormal><span style=3D'color:#C00000'>&#8220;DBusException:
org.freedesktop.DBus.Error.NoReply: Did not receive a reply. Possible =
causes
include: the remote application did not send a reply, the message bus =
security
policy blocked the reply, the reply timeout expired, or the network =
connection
was broken.&#8221;<o:p></o:p></span></p>

<p class=3DMsoNormal><o:p>&nbsp;</o:p></p>

<p class=3DMsoNormal>This is true for seemingly any calls I try to make, =
whether
it be GetAddress(), DefaultAdapter(),<span lang=3DEN =
style=3D'color:black'>GetRemoteServiceHandles()
or seemingly even any of the operations invoked by =
obex-data-server.<o:p></o:p></span></p>

<p class=3DMsoNormal><span lang=3DEN =
style=3D'color:black'><o:p>&nbsp;</o:p></span></p>

<p class=3DMsoNormal><span lang=3DEN style=3D'color:black'>Once I start =
to receive
these errors, I kill my application and then try to relaunch it and I =
receive:<o:p></o:p></span></p>

<p class=3DMsoNormal><span lang=3DEN =
style=3D'color:black'><o:p>&nbsp;</o:p></span></p>

<p class=3DMsoNormal><span =
style=3D'color:#C00000'>&#8220;ERROR:dbus.proxies:Introspect
error on :1.0:/org/bluez: dbus.exceptions.DBusException:
org.freedesktop.DBus.Error.NoReply: Did not receive a reply. Possible =
causes
include: the remote application did not send a reply, the message bus =
security
policy blocked the reply, the reply timeout expired, or the network =
connection
was broken.&#8221;<o:p></o:p></span></p>

<p class=3DMsoNormal><span =
style=3D'color:#C00000'><o:p>&nbsp;</o:p></span></p>

<p class=3DMsoNormal>Can anyone give me any idea as to whether this is =
normal
behaviour? Or is this due to me doing something wrong with the Bluetooth =
stack?
I&#8217;ve been testing this with BlueZ 3.36 on Kernel 2.6.25 and dbus =
1.2 and
I&#8217;m using the BlueZ 3.x API.<o:p></o:p></p>

<p class=3DMsoNormal><o:p>&nbsp;</o:p></p>

<p class=3DMsoNormal>I&#8217;d really appreciate any and all suggestions =
on this
guys, I&#8217;m open to any ideas <span =
style=3D'font-family:Wingdings'>J</span><o:p></o:p></p>

<p class=3DMsoNormal><o:p>&nbsp;</o:p></p>

<p class=3DMsoNormal>Cheers.<o:p></o:p></p>

<p class=3DMsoNormal><o:p>&nbsp;</o:p></p>

<p class=3DMsoNormal>Heston<o:p></o:p></p>

</div>

</body>

</html>

------=_NextPart_000_003B_01C8EFD6.C2C80F70--



--===============1240843233==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

-------------------------------------------------------------------------
This SF.Net email is sponsored by the Moblin Your Move Developer's challenge
Build the coolest Linux based applications with Moblin SDK & win great prizes
Grand prize is a trip for two to an Open Source event anywhere in the world
http://moblin-contest.org/redirect.php?banner_id=100&url=/
--===============1240843233==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Bluez-devel mailing list
Bluez-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-devel

--===============1240843233==--
