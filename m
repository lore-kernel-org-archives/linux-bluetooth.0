Return-Path: <bluez-devel-bounces@lists.sourceforge.net>
MIME-Version: 1.0
Date: Tue, 12 Jun 2007 17:41:50 +0200
Message-ID: <39D0ED4A56B05A409DB3C01F8DCEFB54F3281C@CORPAPPL021.corp.saab.se>
From: "Bengtsson Mikael" <mikael.bengtsson@saabgroup.com>
To: <bluez-devel@lists.sourceforge.net>
Subject: [Bluez-devel] SCO with BlueZ 2.15?
Reply-To: BlueZ development <bluez-devel@lists.sourceforge.net>
List-Id: BlueZ development <bluez-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-devel>,
	<mailto:bluez-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=bluez-devel>
List-Post: <mailto:bluez-devel@lists.sourceforge.net>
List-Help: <mailto:bluez-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-devel>,
	<mailto:bluez-devel-request@lists.sourceforge.net?subject=subscribe>
Content-Type: multipart/mixed; boundary="===============1805174264=="
Sender: bluez-devel-bounces@lists.sourceforge.net
Errors-To: bluez-devel-bounces@lists.sourceforge.net

This is a multi-part message in MIME format.

--===============1805174264==
Content-class: urn:content-classes:message
Content-Type: multipart/alternative;
	boundary="----_=_NextPart_001_01C7AD08.31CE67D3"

This is a multi-part message in MIME format.

------_=_NextPart_001_01C7AD08.31CE67D3
Content-Type: text/plain;
	charset="us-ascii"
Content-Transfer-Encoding: quoted-printable

I'm developing an application on an Intel Xscale PXA 255 platform. I
have installed BlueZ utils and libs 2.15 that was included on the
software CD.

The application opens some ACL connections and a few SCO connections.
The ACL connections starts up fine, but the SCO connections doesn't
start at all. When inspecting the loaded modules with lsmod, SCO is not
loaded.

The question is, is SCO working with version 2.15?=20

I have compiled the same application on an ordinary PC with version 3.9
and 3.11. ACL and SCO works fine. lsmod shows that SCO is loaded.

I'm using a USB dongle for the moment, but shall use UART instead,
because more than one SCO channel is not working on USB. However, it is
possible to open two SCO connections on the PC with USB dongle, but not
communicating it seems.

How do I load SCO on the Xscale?







------_=_NextPart_001_01C7AD08.31CE67D3
Content-Type: text/html;
	charset="us-ascii"
Content-Transfer-Encoding: quoted-printable

<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 3.2//EN">
<HTML>
<HEAD>
<META HTTP-EQUIV=3D"Content-Type" CONTENT=3D"text/html; =
charset=3Dus-ascii">
<META NAME=3D"Generator" CONTENT=3D"MS Exchange Server version =
6.5.7652.24">
<TITLE>SCO with BlueZ 2.15?</TITLE>
</HEAD>
<BODY>
<!-- Converted from text/rtf format -->

<P><SPAN LANG=3D"sv"><FONT SIZE=3D2 FACE=3D"Arial">I'm developing an =
application on an Intel Xscale PXA 255 platform. I have installed BlueZ =
utils and libs 2.15 that was included on the software =
CD.</FONT></SPAN></P>

<P><SPAN LANG=3D"sv"><FONT SIZE=3D2 FACE=3D"Arial">The application opens =
some ACL connections and a few SCO connections. The ACL connections =
starts up fine, but the SCO connections doesn't start at all. When =
inspecting the loaded modules with lsmod, SCO is not =
loaded.</FONT></SPAN></P>

<P><SPAN LANG=3D"sv"><FONT SIZE=3D2 FACE=3D"Arial">The question is, is =
SCO working with version 2.15? </FONT></SPAN>
</P>

<P><SPAN LANG=3D"sv"><FONT SIZE=3D2 FACE=3D"Arial">I have compiled the =
same application on an ordinary PC with version 3.9 and 3.11. ACL and =
SCO works fine. lsmod shows that SCO is loaded.</FONT></SPAN></P>

<P><SPAN LANG=3D"sv"><FONT SIZE=3D2 FACE=3D"Arial">I'm using a USB =
dongle for the moment, but shall use UART instead, because more than one =
SCO channel is not working on USB. However, it is possible to open two =
SCO connections on the PC with USB dongle, but not communicating it =
seems.</FONT></SPAN></P>

<P><SPAN LANG=3D"sv"><FONT SIZE=3D2 FACE=3D"Arial">How do I load SCO on =
the Xscale?</FONT></SPAN>
</P>
<BR>
<BR>
<BR>
<BR>
<BR>

</BODY>
</HTML>
------_=_NextPart_001_01C7AD08.31CE67D3--


--===============1805174264==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

-------------------------------------------------------------------------
This SF.net email is sponsored by DB2 Express
Download DB2 Express C - the FREE version of DB2 express and take
control of your XML. No limits. Just data. Click to get it now.
http://sourceforge.net/powerbar/db2/
--===============1805174264==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Bluez-devel mailing list
Bluez-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-devel

--===============1805174264==--
