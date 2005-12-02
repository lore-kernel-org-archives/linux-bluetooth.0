Return-Path: <bluez-devel-admin@lists.sourceforge.net>
MIME-Version: 1.0
Content-Type: multipart/related;
	type="multipart/alternative";
	boundary="----_=_NextPart_001_01C5F76E.6DEAC5FB"
Message-ID: <A35A8D03A748B34A9DA2AB0335A3F93D40838F@rfsdmail.internal.rfmd.com>
From: "Jatin Nahar" <jnahar@rfmd.com>
To: <bluez-devel@lists.sourceforge.net>
Subject: [Bluez-devel] Vendor Specific Commands
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
Date: Fri, 2 Dec 2005 10:30:09 -0800

This is a multi-part message in MIME format.

------_=_NextPart_001_01C5F76E.6DEAC5FB
Content-Type: multipart/alternative;
	boundary="----_=_NextPart_002_01C5F76E.6DEAC5FB"


------_=_NextPart_002_01C5F76E.6DEAC5FB
Content-Type: text/plain;
	charset="us-ascii"
Content-Transfer-Encoding: quoted-printable

Hi Marcel,
Thanks for the response. I am using RFMD chipset, but I don't think it
matters. The reason I need vendor specific commands/events support is
for cases where there is no non volatile memory present and the host
needs to send down configurations using vendor specific commands. An
example of such a case would be mobile phone environment, where the host
uses these to do simple things like write Bluetooth address or
complicated things like configure registers.
I know that general framework for these commands/events are already
supported, but what I am trying to find is the right place to do this
(which is the first thing that should  happen) and for that I am trying
to understand the BlueZ model.

Thanks,
Jatin=20



From: Marcel Holtmann <marcel@ho...>=20
/mailarchive/message.php?msg_id=3D14048991 <<Picture (Metafile)>> Re:
vendor specific commands </mailarchive/message.php?msg_id=3D14048991> =20
2005-12-02 00:46 =09
Hi Jatin,

> I want to add support for few vendor specific commands to BlueZ, was
> wondering whats the best place in the source code to do that? I want
> to perform some hardware configuration before any other initialization
> happens.
> =20
> I am also trying to understand general BlueZ architecture for any
> enhancements or customizations, what would be the best place to start
> (I have been  looking at the code, but do not completely understand it
> especially the startup part).
> =20
> Also wondering whats BlueZ's policy regarding support for vendor
> specific commands/events? Is it possible to submit modifications for a
> particular vendor and get that incorporated in standard distributions.

this depends on, but in general it is no problem. However the Bluetooth
core inside the Linux kernel stays vendor free at any price. But you
should don't ask vague questions. Tell us what hardware you are talking
about and what vendor specific stuff is needed in detail.

Regards

Marcel=09



------_=_NextPart_002_01C5F76E.6DEAC5FB
Content-Type: text/html;
	charset="us-ascii"
Content-Transfer-Encoding: quoted-printable

<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 3.2//EN">
<HTML>
<HEAD>
<META HTTP-EQUIV=3D"Content-Type" CONTENT=3D"text/html; =
charset=3Dus-ascii">
<META NAME=3D"Generator" CONTENT=3D"MS Exchange Server version =
6.5.7226.0">
<TITLE>Vendor Specific Commands</TITLE>
</HEAD>
<BODY>
<!-- Converted from text/rtf format -->

<P><FONT SIZE=3D2 FACE=3D"Times New Roman">Hi Marcel,</FONT>

<BR><FONT SIZE=3D2 FACE=3D"Times New Roman">Thanks for the response. I =
am using RFMD chipset, but I don't think it matters. The reason I need =
vendor specific commands/events support is for cases where there is no =
non volatile memory present and the host needs to send down =
configurations using vendor specific commands. An example of such a case =
would be mobile phone environment, where the host uses these to do =
simple things like write Bluetooth address or complicated things like =
configure registers.</FONT></P>

<P><FONT SIZE=3D2 FACE=3D"Times New Roman">I know that general framework =
for these commands/events are already supported, but what I am trying to =
find is the right place to do this (which is the first thing that =
should&nbsp; happen) and for that I am trying to understand the BlueZ =
model.</FONT></P>

<P><FONT SIZE=3D2 FACE=3D"Times New Roman">Thanks,</FONT>

<BR><FONT SIZE=3D2 FACE=3D"Times New Roman">Jatin </FONT>
</P>
<BR>
<BR>

<P><FONT FACE=3D"Times New Roman">From: Marcel Holtmann =
&lt;marcel@ho...&gt;<BR>
/mailarchive/message.php?msg_id=3D14048991</FONT><FONT FACE=3D"Arial" =
SIZE=3D2 COLOR=3D"#000000">
<IMG SRC=3D"No%20AttachName" alt=3D"Picture =
(Metafile)"></FONT><B></B><B></B><B></B><A =
HREF=3D"file:///mailarchive/message.php?msg_id=3D14048991"><B><U><FONT =
COLOR=3D"#0000FF" FACE=3D"Times New Roman">Re: vendor specific =
commands</FONT></U></B></A><B></B><FONT FACE=3D"Times New Roman"><BR>
2005-12-02 00:46 &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;<BR>
</FONT><FONT SIZE=3D2 FACE=3D"Courier New">Hi Jatin,</FONT>
</P>

<P><FONT SIZE=3D2 FACE=3D"Courier New">&gt; I want to add support for =
few vendor specific commands to BlueZ, was</FONT>

<BR><FONT SIZE=3D2 FACE=3D"Courier New">&gt; wondering whats the best =
place in the source code to do that? I want</FONT>

<BR><FONT SIZE=3D2 FACE=3D"Courier New">&gt; to perform some hardware =
configuration before any other initialization</FONT>

<BR><FONT SIZE=3D2 FACE=3D"Courier New">&gt; happens.</FONT>

<BR><FONT SIZE=3D2 FACE=3D"Courier New">&gt;&nbsp; </FONT>

<BR><FONT SIZE=3D2 FACE=3D"Courier New">&gt; I am also trying to =
understand general BlueZ architecture for any</FONT>

<BR><FONT SIZE=3D2 FACE=3D"Courier New">&gt; enhancements or =
customizations, what would be the best place to start</FONT>

<BR><FONT SIZE=3D2 FACE=3D"Courier New">&gt; (I have been&nbsp; looking =
at the code, but do not completely understand it</FONT>

<BR><FONT SIZE=3D2 FACE=3D"Courier New">&gt; especially the startup =
part).</FONT>

<BR><FONT SIZE=3D2 FACE=3D"Courier New">&gt;&nbsp; </FONT>

<BR><FONT SIZE=3D2 FACE=3D"Courier New">&gt; Also wondering whats =
BlueZ's policy regarding support for vendor</FONT>

<BR><FONT SIZE=3D2 FACE=3D"Courier New">&gt; specific commands/events? =
Is it possible to submit modifications for a</FONT>

<BR><FONT SIZE=3D2 FACE=3D"Courier New">&gt; particular vendor and get =
that incorporated in standard distributions.</FONT>
</P>

<P><FONT SIZE=3D2 FACE=3D"Courier New">this depends on, but in general =
it is no problem. However the Bluetooth</FONT>

<BR><FONT SIZE=3D2 FACE=3D"Courier New">core inside the Linux kernel =
stays vendor free at any price. But you</FONT>

<BR><FONT SIZE=3D2 FACE=3D"Courier New">should don't ask vague =
questions. Tell us what hardware you are talking</FONT>

<BR><FONT SIZE=3D2 FACE=3D"Courier New">about and what vendor specific =
stuff is needed in detail.</FONT>
</P>

<P><FONT SIZE=3D2 FACE=3D"Courier New">Regards</FONT>
</P>

<P><FONT SIZE=3D2 FACE=3D"Courier New">Marcel&nbsp;<BR>
</FONT>
</P>

</BODY>
</HTML>
------_=_NextPart_002_01C5F76E.6DEAC5FB--

------_=_NextPart_001_01C5F76E.6DEAC5FB
Content-Type: image/bmp;
	name="ole0.bmp"
Content-Transfer-Encoding: base64
Content-Description: Picture (Metafile)
Content-Location: No%20AttachName

Qk1qAAAAAAAAADoAAAAoAAAACgAAAAwAAAABAAEAAAAAAAAAAAAAAAAAAAAAAAEAAAAAAAAA////
AAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAA==

------_=_NextPart_001_01C5F76E.6DEAC5FB--


-------------------------------------------------------
This SF.net email is sponsored by: Splunk Inc. Do you grep through log files
for problems?  Stop!  Download the new AJAX search engine that makes
searching your log files as easy as surfing the  web.  DOWNLOAD SPLUNK!
http://ads.osdn.com/?ad_id=7637&alloc_id=16865&op=click
_______________________________________________
Bluez-devel mailing list
Bluez-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-devel
