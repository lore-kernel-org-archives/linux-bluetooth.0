Return-Path: <bluez-devel-admin@lists.sourceforge.net>
MIME-Version: 1.0
Content-Type: multipart/alternative;
	boundary="----_=_NextPart_001_01C49732.D7407CA2"
Message-ID: <A1F0D47583A2D711919F00600819B3A4028BBF@goofy.vitronics.com>
From: "Williams, Richard" <Richard.Williams@VITRONICS.com>
To: "Bluez-Devel (E-mail)" <bluez-devel@lists.sourceforge.net>
Subject: [Bluez-devel] pand vs. rfcomm
Sender: bluez-devel-admin@lists.sourceforge.net
Errors-To: bluez-devel-admin@lists.sourceforge.net
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-devel>,
	<mailto:bluez-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Id: <bluez-devel.lists.sourceforge.net>
List-Post: <mailto:bluez-devel@lists.sourceforge.net>
List-Help: <mailto:bluez-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-devel>,
	<mailto:bluez-devel-request@lists.sourceforge.net?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=bluez-devel>
Date: Fri, 10 Sep 2004 08:36:48 -0400

This is a multi-part message in MIME format.

------_=_NextPart_001_01C49732.D7407CA2
Content-Type: text/plain;
	charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable

Hello,

I have rfcomm working among a few small embedded devices for =
transferring small amounts of data - less than 100 bytes of data per =
second. I have a master and four slaves in a small piconet.=20

Now I'm adding a higher bandwidth connection between my master and =
another device with pand. The master is an embedded xScale single board =
computer Linux 2.4.26 with the latest patches. The other device here is =
an iPAQ 5550 with built in bluetooth - running Familiar Linux. A single =
bnep connection is established OK and seems to work pretty well. If I =
establish a bnep connection, I can do all the usual TCP/IP stuff between =
the two - ping, telnet, ftp work just fine. But I'm wondering if the =
bnep connection interferes with the rfcomm's that are used in the =
piconet. Can I have multiple asynchronous processes using bnep and =
rfcomm without interfering with each other ?=20

Here's what happens:
- I start up my system and the four rfcomm's are bound and transferring =
data. I've had this running for hours with no problems.

- Then I start the pand and this establishes the bnep connection OK. I =
can ping, ftp, etc.

- After a few minutes, the bnep connection fails to transmit any more =
data.

Is this to be expected ?=20


thanks, and best regards,

Rich Williams



Richard B. Williams
Vitronics, Inc.
An MTC Technologies Company
3 Corbett Way
Eatontown, NJ 07724-2262
732-389-0244 x29
Richard.Williams@vitronics.com


------_=_NextPart_001_01C49732.D7407CA2
Content-Type: text/html;
	charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable

<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 3.2//EN">
<HTML>
<HEAD>
<META HTTP-EQUIV=3D"Content-Type" CONTENT=3D"text/html; =
charset=3Diso-8859-1">
<META NAME=3D"Generator" CONTENT=3D"MS Exchange Server version =
6.0.6249.1">
<TITLE>pand vs. rfcomm</TITLE>
</HEAD>
<BODY>
<!-- Converted from text/rtf format -->

<P><FONT SIZE=3D2 FACE=3D"Arial">Hello,</FONT>
</P>

<P><FONT SIZE=3D2 FACE=3D"Arial">I have rfcomm working among a few small =
embedded devices for transferring small amounts of data - less than 100 =
bytes of data per second. I have a master and four slaves in a small =
piconet. </FONT></P>

<P><FONT SIZE=3D2 FACE=3D"Arial">Now I'm adding a higher bandwidth =
connection between my master and another device with pand. The master is =
an embedded xScale single board computer Linux 2.4.26 with the latest =
patches. The other device here is an iPAQ 5550 with built in bluetooth - =
running Familiar Linux. A single bnep connection is established OK and =
seems to work pretty well. If I establish a bnep connection, I can do =
all the usual TCP/IP stuff between the two - ping, telnet, ftp work just =
fine. But I'm wondering if the bnep connection interferes with the =
rfcomm's that are used in the piconet. Can I have multiple asynchronous =
processes using bnep and rfcomm without interfering with each other ? =
</FONT></P>

<P><FONT SIZE=3D2 FACE=3D"Arial">Here's what happens:</FONT>

<BR><FONT SIZE=3D2 FACE=3D"Arial">- I start up my system and the four =
rfcomm's are bound and transferring data. I've had this running for =
hours with no problems.</FONT></P>

<P><FONT SIZE=3D2 FACE=3D"Arial">- Then I start the pand and this =
establishes the bnep connection OK. I can ping, ftp, etc.</FONT>
</P>

<P><FONT SIZE=3D2 FACE=3D"Arial">- After a few minutes, the bnep =
connection fails to transmit any more data.</FONT>
</P>

<P><FONT SIZE=3D2 FACE=3D"Arial">Is this to be expected ? </FONT>
</P>
<BR>

<P><FONT SIZE=3D2 FACE=3D"Arial">thanks, and best regards,</FONT>
</P>

<P><FONT SIZE=3D2 FACE=3D"Arial">Rich Williams</FONT>
</P>
<BR>
<BR>

<P><FONT SIZE=3D2 FACE=3D"Arial">Richard B. Williams</FONT>

<BR><FONT SIZE=3D2 FACE=3D"Arial">Vitronics, Inc.</FONT>

<BR><FONT SIZE=3D2 FACE=3D"Arial">An MTC Technologies Company</FONT>

<BR><FONT SIZE=3D2 FACE=3D"Arial">3 Corbett Way</FONT>

<BR><FONT SIZE=3D2 FACE=3D"Arial">Eatontown, NJ 07724-2262</FONT>

<BR><FONT SIZE=3D2 FACE=3D"Arial">732-389-0244 x29</FONT>

<BR><FONT SIZE=3D2 FACE=3D"Arial">Richard.Williams@vitronics.com</FONT>
</P>

</BODY>
</HTML>
------_=_NextPart_001_01C49732.D7407CA2--


-------------------------------------------------------
This SF.Net email is sponsored by: YOU BE THE JUDGE. Be one of 170
Project Admins to receive an Apple iPod Mini FREE for your judgement on
who ports your project to Linux PPC the best. Sponsored by IBM. 
Deadline: Sept. 13. Go here: http://sf.net/ppc_contest.php
_______________________________________________
Bluez-devel mailing list
Bluez-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-devel
