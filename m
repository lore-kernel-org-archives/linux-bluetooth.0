Return-Path: <bluez-users-admin@lists.sourceforge.net>
MIME-Version: 1.0
Content-Type: multipart/alternative;
	boundary="----_=_NextPart_001_01C55C81.BB644758"
Message-ID: <B7A120329D087840A54E2A221FCCE8D0747334@PSCMAIL01.rochester.itsphoenix.com>
From: "John G. Moose" <jmoose@itsphoenix.com>
To: <bluez-users@lists.sourceforge.net>
Subject: [Bluez-users] Bluetooth PCMCIA progress...
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
Date: Thu, 19 May 2005 10:47:51 -0400

This is a multi-part message in MIME format.

------_=_NextPart_001_01C55C81.BB644758
Content-Type: text/plain;
	charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable

I am using the 3COM 3CRWB6096B ver 3 card in a arm-linux system. I =
insert the
card and see two serial ports come online  ttyS03 and ttyS04. When I
"hciattach ttyS3 any" and then "hciconfig -a" I can see that the =
hci_uart
driver has attached as an hci0 device...but the card BD address is all =
zeros.
If I try to "hciattach ttyS3 3com"  the command always returns with
"Initialization timed out". Do I need to update/enter a CIS somewhere =
for
this device?   "cardctl ident"  returns with correct info for this card.
"hciconfig hci0 up" fails with "Can't init device hci0: Connection timed =
out
(110) "
=20
John=20

------_=_NextPart_001_01C55C81.BB644758
Content-Type: text/html;
	charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable

<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.0 Transitional//EN"><HTML =
DIR=3Dltr><HEAD><META HTTP-EQUIV=3D"Content-Type" CONTENT=3D"text/html; =
charset=3Diso-8859-1"></HEAD><BODY><DIV><FONT face=3D'Arial' =
color=3D#000000 size=3D2>I am using the 3COM 3CRWB6096B ver 3 card in a =
arm-linux =0A=
system. I insert the card and see two serial ports come online&nbsp; =
ttyS03 and =0A=
ttyS04. When I&nbsp;&nbsp; "hciattach ttyS3 any" and then "hciconfig -a" =
I can =0A=
see that the hci_uart driver has attached as an hci0 device...but the =
card BD =0A=
address is all zeros. If I try to "hciattach ttyS3 3com"&nbsp; the =
command =0A=
always&nbsp;returns with&nbsp;"Initialization timed out". Do I need to =0A=
update/enter a CIS somewhere for this device?&nbsp;&nbsp; "cardctl =
ident"&nbsp; =0A=
returns with correct info for this card.&nbsp; "hciconfig hci0 up" fails =
with =0A=
"Can't init device hci0: Connection timed out (110) "</FONT></DIV>=0A=
<DIV>&nbsp;</DIV>=0A=
<DIV><FONT face=3DArial size=3D2>John</FONT>&nbsp;</DIV></BODY></HTML>
------_=_NextPart_001_01C55C81.BB644758--


-------------------------------------------------------
This SF.Net email is sponsored by Oracle Space Sweepstakes
Want to be the first software developer in space?
Enter now for the Oracle Space Sweepstakes!
http://ads.osdn.com/?ad_id=7412&alloc_id=16344&op=click
_______________________________________________
Bluez-users mailing list
Bluez-users@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-users
