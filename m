Return-Path: <bluez-devel-admin@lists.sourceforge.net>
MIME-Version: 1.0
Content-Type: multipart/alternative;
	boundary="----_=_NextPart_001_01C5FAAC.4CFEDA63"
Message-ID: <A35A8D03A748B34A9DA2AB0335A3F93D408837@rfsdmail.internal.rfmd.com>
From: "Jatin Nahar" <jnahar@rfmd.com>
To: <bluez-devel@lists.sourceforge.net>
Subject: [Bluez-devel] Corrections in hciattach code
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
Date: Tue, 6 Dec 2005 13:30:41 -0800

This is a multi-part message in MIME format.

------_=_NextPart_001_01C5FAAC.4CFEDA63
Content-Type: text/plain;
	charset="us-ascii"
Content-Transfer-Encoding: quoted-printable

The hciattach code when used with swave option (RFMD) would not work
since there are 2 bugs in that code, infact it will return with
"Initialization timeout" every single time. Here are fixes for those
(let me know if you would like me to send that to you in some other
form). The base file used for the diff is hciattach.c in
bluez-utils-2.22.

691c691
< 	if (write(fd, cmd, 9) !=3D 9) {
---
> 	if (write(fd, cmd, 10) !=3D 10) {
723c723,724
< 	// we probably got the reply. Now we must send the "soft reset":
---
> 	// we probably got the reply. Now we must send the "soft reset":
which
> 	// is standard HCI RESET.
725,728c726,728
< 	cmd[1] =3D 0x0B;			// OCF 0x0B	=3D param access
set=09
< 	cmd[2] =3D 0xfc;			// OGF bx111111 =3D vendor
specific
< 	cmd[3] =3D 0x01;			// 1 byte of data following=20
< 	cmd[4] =3D 0x03;			// HCI Reset Subcommand
---
> 	cmd[1] =3D 0x03;			=09
> 	cmd[2] =3D 0x0c;	=09
> 	cmd[3] =3D 0x00;	=09
730,731c730,731
< 	// Send initialization command
< 	if (write(fd, cmd, 5) !=3D 5) {
---
> 	// Send command
> 	if (write(fd, cmd, 4) !=3D 4) {

Regards,
Jatin

------_=_NextPart_001_01C5FAAC.4CFEDA63
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
<TITLE>Corrections in hciattach code</TITLE>
</HEAD>
<BODY>
<!-- Converted from text/rtf format -->

<P><FONT SIZE=3D2 FACE=3D"Arial">The hciattach code when used with swave =
option (RFMD) would not work since there are 2 bugs in that code, infact =
it will return with &quot;Initialization timeout&quot; every single =
time. Here are fixes for those (let me know if you would like me to send =
that to you in some other form). The base file used for the diff is =
hciattach.c in bluez-utils-2.22.</FONT></P>

<P><FONT SIZE=3D2 FACE=3D"Courier New">691c691</FONT>

<BR><FONT SIZE=3D2 FACE=3D"Courier New">&lt; =
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (write(fd, cmd, 9) !=3D 9) {</FONT>

<BR><FONT SIZE=3D2 FACE=3D"Courier New">---</FONT>

<BR><FONT SIZE=3D2 FACE=3D"Courier New">&gt; =
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (write(fd, cmd, 10) !=3D 10) {</FONT>

<BR><FONT SIZE=3D2 FACE=3D"Courier New">723c723,724</FONT>

<BR><FONT SIZE=3D2 FACE=3D"Courier New">&lt; =
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; // we probably got the reply. Now we must =
send the &quot;soft reset&quot;:</FONT>

<BR><FONT SIZE=3D2 FACE=3D"Courier New">---</FONT>

<BR><FONT SIZE=3D2 FACE=3D"Courier New">&gt; =
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; // we probably got the reply. Now we must =
send the &quot;soft reset&quot;: which</FONT>

<BR><FONT SIZE=3D2 FACE=3D"Courier New">&gt; =
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; // is standard HCI RESET.</FONT>

<BR><FONT SIZE=3D2 FACE=3D"Courier New">725,728c726,728</FONT>

<BR><FONT SIZE=3D2 FACE=3D"Courier New">&lt; =
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; cmd[1] =3D 0x0B;&nbsp; =
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; // OCF =
0x0B&nbsp;&nbsp;&nbsp;&nbsp; =3D param access =
set&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; </FONT>

<BR><FONT SIZE=3D2 FACE=3D"Courier New">&lt; =
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; cmd[2] =3D 0xfc;&nbsp; =
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; // OGF bx111111 =3D vendor =
specific</FONT>

<BR><FONT SIZE=3D2 FACE=3D"Courier New">&lt; =
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; cmd[3] =3D 0x01;&nbsp; =
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; // 1 byte of data following =
</FONT>

<BR><FONT SIZE=3D2 FACE=3D"Courier New">&lt; =
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; cmd[4] =3D 0x03;&nbsp; =
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; // HCI Reset =
Subcommand</FONT>

<BR><FONT SIZE=3D2 FACE=3D"Courier New">---</FONT>

<BR><FONT SIZE=3D2 FACE=3D"Courier New">&gt; =
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; cmd[1] =3D 0x03;&nbsp; =
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; </FONT>

<BR><FONT SIZE=3D2 FACE=3D"Courier New">&gt; =
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; cmd[2] =3D 0x0c;&nbsp; =
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; </FONT>

<BR><FONT SIZE=3D2 FACE=3D"Courier New">&gt; =
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; cmd[3] =3D 0x00;&nbsp; =
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; </FONT>

<BR><FONT SIZE=3D2 FACE=3D"Courier New">730,731c730,731</FONT>

<BR><FONT SIZE=3D2 FACE=3D"Courier New">&lt; =
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; // Send initialization command</FONT>

<BR><FONT SIZE=3D2 FACE=3D"Courier New">&lt; =
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (write(fd, cmd, 5) !=3D 5) {</FONT>

<BR><FONT SIZE=3D2 FACE=3D"Courier New">---</FONT>

<BR><FONT SIZE=3D2 FACE=3D"Courier New">&gt; =
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; // Send command</FONT>

<BR><FONT SIZE=3D2 FACE=3D"Courier New">&gt; =
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (write(fd, cmd, 4) !=3D 4) {</FONT>
</P>

<P><FONT SIZE=3D2 FACE=3D"Arial">Regards,</FONT>

<BR><FONT SIZE=3D2 FACE=3D"Arial">Jatin</FONT>
</P>

</BODY>
</HTML>
------_=_NextPart_001_01C5FAAC.4CFEDA63--


-------------------------------------------------------
This SF.net email is sponsored by: Splunk Inc. Do you grep through log files
for problems?  Stop!  Download the new AJAX search engine that makes
searching your log files as easy as surfing the  web.  DOWNLOAD SPLUNK!
http://ads.osdn.com/?ad_id=7637&alloc_id=16865&op=click
_______________________________________________
Bluez-devel mailing list
Bluez-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-devel
