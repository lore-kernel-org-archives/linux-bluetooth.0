Return-Path: <Albert.Rybalkin@Fiserv.com>
Message-ID: <CF8C38B8FA1ED511A92400508BE37F0B0A961D04@exchange_corp.bhcsecurities.com>
From: "Rybalkin, Albert" <Albert.Rybalkin@Fiserv.com>
To: "'Marcel Holtmann'" <marcel@holtmann.org>,
   "Rybalkin, Albert"
	 <Albert.Rybalkin@Fiserv.com>
Cc: "'bluez-users@lists.sourceforge.net'"
	 <bluez-users@lists.sourceforge.net>,
   "'albertr@iral.com'"
	 <albertr@iral.com>
Subject: RE: [Bluez-users] panu question
Date: Mon, 22 Mar 2004 09:00:49 -0600
MIME-Version: 1.0
Content-Type: multipart/alternative;
	boundary="----_=_NextPart_001_01C4101E.7619E1CC"
List-ID: <bluez-users.lists.sourceforge.net>

This message is in MIME format. Since your mail reader does not understand
this format, some or all of this message may not be legible.

------_=_NextPart_001_01C4101E.7619E1CC
Content-Type: text/plain

Sorry for HTML message, didn't want to offend you...

On a subject matter, I tracked down the problem to BlueSoeil.
There's a possibility to set up NAT on incoming connections to
PAN profile, which doesn't seem to work on my Win2K PC. Basic
PAN (without NAT) works fine, even has a lame DHCP server.
Thanks,
--
Albert Rybalkin


-----Original Message-----
From: Marcel Holtmann [mailto:marcel@holtmann.org] 
Sent: Sunday, March 21, 2004 12:41 PM
To: Rybalkin, Albert
Cc: 'bluez-users@lists.sourceforge.net'; 'albertr@iral.com'
Subject: Re: [Bluez-users] panu question


Hi Albert,

> The NAP server is win2k box running BlueSoleil 1.4.2. PANU client is 
> linux 2.4.18 with latest BlueZ kernel patches and recent userland. The 
> client was trying to connect with:

first stop sending HTML emails, because they are ugly to read and second
create a binary hcidump with the -w option.

Regards

Marcel


------_=_NextPart_001_01C4101E.7619E1CC
Content-Type: text/html
Content-Transfer-Encoding: quoted-printable

<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 3.2//EN">
<HTML>
<HEAD>
<META HTTP-EQUIV=3D"Content-Type" CONTENT=3D"text/html; =
charset=3Dus-ascii">
<META NAME=3D"Generator" CONTENT=3D"MS Exchange Server version =
5.5.2657.73">
<TITLE>RE: [Bluez-users] panu question</TITLE>
</HEAD>
<BODY>

<P><FONT SIZE=3D2>Sorry for HTML message, didn't want to offend =
you...</FONT>
</P>

<P><FONT SIZE=3D2>On a subject matter, I tracked down the problem to =
BlueSoeil.</FONT>
<BR><FONT SIZE=3D2>There's a possibility to set up NAT on incoming =
connections to</FONT>
<BR><FONT SIZE=3D2>PAN profile, which doesn't seem to work on my Win2K =
PC. Basic</FONT>
<BR><FONT SIZE=3D2>PAN (without NAT) works fine, even has a lame DHCP =
server.</FONT>
<BR><FONT SIZE=3D2>Thanks,</FONT>
<BR><FONT SIZE=3D2>--</FONT>
<BR><FONT SIZE=3D2>Albert Rybalkin</FONT>
</P>
<BR>

<P><FONT SIZE=3D2>-----Original Message-----</FONT>
<BR><FONT SIZE=3D2>From: Marcel Holtmann [<A =
HREF=3D"mailto:marcel@holtmann.org">mailto:marcel@holtmann.org</A>] =
</FONT>
<BR><FONT SIZE=3D2>Sent: Sunday, March 21, 2004 12:41 PM</FONT>
<BR><FONT SIZE=3D2>To: Rybalkin, Albert</FONT>
<BR><FONT SIZE=3D2>Cc: 'bluez-users@lists.sourceforge.net'; =
'albertr@iral.com'</FONT>
<BR><FONT SIZE=3D2>Subject: Re: [Bluez-users] panu question</FONT>
</P>
<BR>

<P><FONT SIZE=3D2>Hi Albert,</FONT>
</P>

<P><FONT SIZE=3D2>&gt; The NAP server is win2k box running BlueSoleil =
1.4.2. PANU client is </FONT>
<BR><FONT SIZE=3D2>&gt; linux 2.4.18 with latest BlueZ kernel patches =
and recent userland. The </FONT>
<BR><FONT SIZE=3D2>&gt; client was trying to connect with:</FONT>
</P>

<P><FONT SIZE=3D2>first stop sending HTML emails, because they are ugly =
to read and second create a binary hcidump with the -w option.</FONT>
</P>

<P><FONT SIZE=3D2>Regards</FONT>
</P>

<P><FONT SIZE=3D2>Marcel</FONT>
</P>

</BODY>
</HTML>
------_=_NextPart_001_01C4101E.7619E1CC--
