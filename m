Return-Path: <bluez-users-admin@lists.sourceforge.net>
MIME-Version: 1.0
Content-Type: multipart/alternative;
	boundary="----_=_NextPart_001_01C5FC29.560FD2D1"
Subject: RE: [Bluez-users] UART bluetooth chip problem
Message-ID: <EFCD68F7BFDB06468769D4D9EAAA938709B202E6@scsmsx401.amr.corp.intel.com>
From: "Pering, Trevor" <trevor.pering@intel.com>
To: <bluez-users@lists.sourceforge.net>
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
Date: Thu, 8 Dec 2005 10:58:11 -0800

This is a multi-part message in MIME format.

------_=_NextPart_001_01C5FC29.560FD2D1
Content-Type: text/plain;
	charset="us-ascii"
Content-Transfer-Encoding: quoted-printable

You might try "noflow" instead of "flow" to see if there is some problem
with the UART flow control setup/signals.
=20
    Trevor
=20

________________________________

From: bluez-users-admin@lists.sourceforge.net
[mailto:bluez-users-admin@lists.sourceforge.net] On Behalf Of Arthur
Chiu
Sent: Thursday, December 08, 2005 10:20 AM
To: bluez-users@lists.sourceforge.net
Subject: Re: [Bluez-users] UART bluetooth chip problem


Hi Marcel, thanks for your reply.

Since I can change the setting on the bluetooth chip, I am currently
using UART H4 and baudrate 115200. As for what chip they are using, I
suppose they manufacture their own bluetooh chip?=20

Thanks,

  Arthur


On 12/7/05, Marcel Holtmann <marcel@holtmann.org> wrote:=20

	Hi Arthur,
=09
	> I am currently using a bluetooth chip by bluegiga
(www.bluegiga.com),
	> called WRAP THOR 2022-1-B2B.
	> I set the configurations on the chip so that it is running at
115200=20
	> baud rate. After, I tried doing the following:
	>
	> # hcid
	> # hciattach -s 115200 /dev/ttyS1 any 115200 flow
	> # hciconfig
	> hci0:   Type: UART
	>         BD Address: 00:00:00:00:00:00 ACL MTU: 0:0 SCO MTU:
0:0=20
	>         DOWN INIT RUNNING
	>         RX bytes:0 acl:0 sco:0 events:0 errors:0
	>         TX bytes:4 acl:0 sco:0 commands:1 errors:0
	> # hciconfig hci0 up
	> Can't init device hci0: Connection timed out (145)=20
	>
	> I checked and error code 145 indeed means Connection timed out
on my
	> header files (errno.h).
	> What might be wrong?
=09
	first, you should ask you module manufacturer what chip they are
using=20
	and then what transport they use.
=09
	Regards
=09
	Marcel
=09
=09
=09
=09
	-------------------------------------------------------
	This SF.net email is sponsored by: Splunk Inc. Do you grep
through log files=20
	for problems?  Stop!  Download the new AJAX search engine that
makes
	searching your log files as easy as surfing the  web.  DOWNLOAD
SPLUNK!
	http://ads.osdn.com/?ad_id=3D7637&alloc_id=3D16865&op=3Dclick
	_______________________________________________
	Bluez-users mailing list
	Bluez-users@lists.sourceforge.net=20
	https://lists.sourceforge.net/lists/listinfo/bluez-users
=09



------_=_NextPart_001_01C5FC29.560FD2D1
Content-Type: text/html;
	charset="us-ascii"
Content-Transfer-Encoding: quoted-printable

<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.0 Transitional//EN">
<HTML><HEAD>
<META http-equiv=3DContent-Type content=3D"text/html; =
charset=3Dus-ascii">
<META content=3D"MSHTML 6.00.2900.2769" name=3DGENERATOR></HEAD>
<BODY>
<DIV dir=3Dltr align=3Dleft><SPAN class=3D410005718-08122005><FONT =
face=3DArial=20
color=3D#0000ff size=3D2>You might try "noflow" instead of "flow" to see =
if there is=20
some problem with the UART flow control =
setup/signals.</FONT></SPAN></DIV>
<DIV dir=3Dltr align=3Dleft><SPAN class=3D410005718-08122005><FONT =
face=3DArial=20
color=3D#0000ff size=3D2></FONT></SPAN>&nbsp;</DIV>
<DIV dir=3Dltr align=3Dleft><SPAN =
class=3D410005718-08122005>&nbsp;&nbsp;&nbsp; <FONT=20
face=3DArial color=3D#0000ff size=3D2>Trevor</FONT></SPAN></DIV>
<DIV dir=3Dltr align=3Dleft><SPAN class=3D410005718-08122005><FONT =
face=3DArial=20
color=3D#0000ff size=3D2></FONT></SPAN>&nbsp;</DIV><BR>
<DIV class=3DOutlookMessageHeader lang=3Den-us dir=3Dltr align=3Dleft>
<HR tabIndex=3D-1>
<FONT face=3DTahoma size=3D2><B>From:</B> =
bluez-users-admin@lists.sourceforge.net=20
[mailto:bluez-users-admin@lists.sourceforge.net] <B>On Behalf Of =
</B>Arthur=20
Chiu<BR><B>Sent:</B> Thursday, December 08, 2005 10:20 AM<BR><B>To:</B>=20
bluez-users@lists.sourceforge.net<BR><B>Subject:</B> Re: [Bluez-users] =
UART=20
bluetooth chip problem<BR></FONT><BR></DIV>
<DIV></DIV>Hi Marcel, thanks for your reply.<BR><BR>Since I can change =
the=20
setting on the bluetooth chip, I am currently using UART H4 and baudrate =
115200.=20
As for what chip they are using, I suppose they manufacture their own =
bluetooh=20
chip? <BR><BR>Thanks,<BR><BR>&nbsp; Arthur<BR><BR>
<DIV><SPAN class=3Dgmail_quote>On 12/7/05, <B =
class=3Dgmail_sendername>Marcel=20
Holtmann</B> &lt;<A=20
href=3D"mailto:marcel@holtmann.org">marcel@holtmann.org</A>&gt; =
wrote:</SPAN>
<BLOCKQUOTE class=3Dgmail_quote=20
style=3D"PADDING-LEFT: 1ex; MARGIN: 0pt 0pt 0pt 0.8ex; BORDER-LEFT: =
rgb(204,204,204) 1px solid">Hi=20
  Arthur,<BR><BR>&gt; I am currently using a bluetooth chip by bluegiga =
(<A=20
  href=3D"http://www.bluegiga.com">www.bluegiga.com</A>),<BR>&gt; called =
WRAP THOR=20
  2022-1-B2B.<BR>&gt; I set the configurations on the chip so that it is =
running=20
  at 115200 <BR>&gt; baud rate. After, I tried doing the=20
  following:<BR>&gt;<BR>&gt; # hcid<BR>&gt; # hciattach -s 115200 =
/dev/ttyS1 any=20
  115200 flow<BR>&gt; # hciconfig<BR>&gt; hci0:&nbsp;&nbsp; Type:=20
  UART<BR>&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; BD =
Address:=20
  00:00:00:00:00:00 ACL MTU: 0:0 SCO MTU: 0:0=20
  <BR>&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; DOWN INIT=20
  RUNNING<BR>&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; RX =
bytes:0=20
  acl:0 sco:0 events:0=20
  errors:0<BR>&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; TX =
bytes:4=20
  acl:0 sco:0 commands:1 errors:0<BR>&gt; # hciconfig hci0 up<BR>&gt; =
Can't init=20
  device hci0: Connection timed out (145) <BR>&gt;<BR>&gt; I checked and =
error=20
  code 145 indeed means Connection timed out on my<BR>&gt; header files=20
  (errno.h).<BR>&gt; What might be wrong?<BR><BR>first, you should ask =
you=20
  module manufacturer what chip they are using <BR>and then what =
transport they=20
  =
use.<BR><BR>Regards<BR><BR>Marcel<BR><BR><BR><BR><BR>--------------------=
-----------------------------------<BR>This=20
  SF.net email is sponsored by: Splunk Inc. Do you grep through log =
files=20
  <BR>for problems?&nbsp;&nbsp;Stop!&nbsp;&nbsp;Download the new AJAX =
search=20
  engine that makes<BR>searching your log files as easy as surfing=20
  the&nbsp;&nbsp;web.&nbsp;&nbsp;DOWNLOAD SPLUNK!<BR><A=20
  =
href=3D"http://ads.osdn.com/?ad_id=3D7637&amp;alloc_id=3D16865&amp;op=3Dc=
lick">http://ads.osdn.com/?ad_id=3D7637&amp;alloc_id=3D16865&amp;op=3Dcli=
ck</A><BR>_______________________________________________<BR>Bluez-users =

  mailing list<BR><A=20
  =
href=3D"mailto:Bluez-users@lists.sourceforge.net">Bluez-users@lists.sourc=
eforge.net=20
  </A><BR><A=20
  =
href=3D"https://lists.sourceforge.net/lists/listinfo/bluez-users">https:/=
/lists.sourceforge.net/lists/listinfo/bluez-users</A><BR></BLOCKQUOTE></D=
IV><BR></BODY></HTML>

------_=_NextPart_001_01C5FC29.560FD2D1--


-------------------------------------------------------
This SF.net email is sponsored by: Splunk Inc. Do you grep through log files
for problems?  Stop!  Download the new AJAX search engine that makes
searching your log files as easy as surfing the  web.  DOWNLOAD SPLUNK!
http://ads.osdn.com/?ad_id=7637&alloc_id=16865&op=click
_______________________________________________
Bluez-users mailing list
Bluez-users@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-users
