Return-Path: <bluez-users-admin@lists.sourceforge.net>
MIME-Version: 1.0
Content-Type: multipart/alternative;
	boundary="----_=_NextPart_001_01C55D48.74EF1542"
Subject: RE: [Bluez-users] Bluetooth PCMCIA progress...
Message-ID: <B7A120329D087840A54E2A221FCCE8D074733A@PSCMAIL01.rochester.itsphoenix.com>
From: "John G. Moose" <jmoose@itsphoenix.com>
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
Date: Fri, 20 May 2005 10:30:23 -0400

This is a multi-part message in MIME format.

------_=_NextPart_001_01C55D48.74EF1542
Content-Type: text/plain;
	charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable

Hi Marcel,
=20
I wish I could migrate to a 2.6 kernel but the hardware vendor for this
platform only ships/supports their patched 2.4.27.vrs1 kernel. It looks =
like
you had drivers for this card (and a few others) posted on holtmann.org =
but
removed them?? Are these possibly still available to someone like =
myself? I
came onto this project a few weeks ago and am stuck with the H/W =
platform but
still do need to demo Bluetooth dial-up networking via the PCMCIA slot =
of
this platform in the next couple of weeks. Do you have access to an
ARM/XScale PXA255 based system with a 16-bit PCMCIA slot? I could FedEx
overnight a card to you (and yes, you could then keep it ) for driver
testing!? This card seems to work fine in an x86-based Linux system. Any
ideas here?
=20
Thanks,
John=20

________________________________

From: bluez-users-admin@lists.sourceforge.net on behalf of Marcel =
Holtmann
Sent: Fri 5/20/2005 5:35 AM
To: bluez-users@lists.sourceforge.net
Subject: Re: [Bluez-users] Bluetooth PCMCIA progress...



Hi John,

> I am using the 3COM 3CRWB6096B ver 3 card in a arm-linux system. I
> insert the card and see two serial ports come online  ttyS03 and
> ttyS04. When I   "hciattach ttyS3 any" and then "hciconfig -a" I can
> see that the hci_uart driver has attached as an hci0 device...but the
> card BD address is all zeros. If I try to "hciattach ttyS3 3com"  the
> command always returns with "Initialization timed out". Do I need to
> update/enter a CIS somewhere for this device?   "cardctl ident"
> returns with correct info for this card.  "hciconfig hci0 up" fails
> with "Can't init device hci0: Connection timed out (110) "

that is no progress. The "any" method is only dump. What about trying a
2.6 kernel?

Regards

Marcel




-------------------------------------------------------
This SF.Net email is sponsored by Oracle Space Sweepstakes
Want to be the first software developer in space?
Enter now for the Oracle Space Sweepstakes!
http://ads.osdn.com/?ad_id=3D7412&alloc_id=3D16344&op=3Dclick
_______________________________________________
Bluez-users mailing list
Bluez-users@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-users



------_=_NextPart_001_01C55D48.74EF1542
Content-Type: text/html;
	charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable

<META HTTP-EQUIV=3D"Content-Type" CONTENT=3D"text/html; =
charset=3Diso-8859-1">=0A=
<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 3.2//EN">=0A=
<HTML>=0A=
<HEAD>=0A=
=0A=
<META NAME=3D"Generator" CONTENT=3D"MS Exchange Server version =
6.5.7226.0">=0A=
<TITLE>Re: [Bluez-users] Bluetooth PCMCIA progress...</TITLE>=0A=
</HEAD>=0A=
<BODY>=0A=
<DIV id=3DidOWAReplyText48868 dir=3Dltr>=0A=
<DIV dir=3Dltr><FONT face=3DArial color=3D#000000 size=3D2>Hi =
Marcel,</FONT></DIV>=0A=
<DIV dir=3Dltr>&nbsp;</DIV>=0A=
<DIV dir=3Dltr><FONT face=3DArial size=3D2>I wish I could migrate to a =
2.6 kernel but =0A=
the hardware vendor for this platform only ships/supports their patched =0A=
2.4.27.vrs1 kernel. It looks like you had drivers for this card (and a =
few =0A=
others) posted on holtmann.org but removed them?? Are these possibly =
still =0A=
available to someone like myself? I came onto this project a few weeks =
ago and =0A=
am stuck with the H/W platform but still do need to demo Bluetooth =
dial-up =0A=
networking via the PCMCIA slot of this platform in the next couple of =
weeks. Do =0A=
you have access to an ARM/XScale PXA255 based system with a 16-bit =
PCMCIA slot? =0A=
I could FedEx overnight a card to you&nbsp;(and yes, you could then keep =0A=
it&nbsp;) for driver testing!? This card seems to work fine in an =
x86-based =0A=
Linux system. Any ideas here?</FONT></DIV>=0A=
<DIV dir=3Dltr><FONT face=3DArial size=3D2></FONT>&nbsp;</DIV>=0A=
<DIV dir=3Dltr><FONT face=3DArial size=3D2>Thanks,</FONT></DIV>=0A=
<DIV dir=3Dltr><FONT face=3DArial size=3D2>John </FONT></DIV></DIV>=0A=
<DIV dir=3Dltr><BR>=0A=
<HR tabIndex=3D-1>=0A=
<FONT face=3DTahoma size=3D2><B>From:</B> =
bluez-users-admin@lists.sourceforge.net on =0A=
behalf of Marcel Holtmann<BR><B>Sent:</B> Fri 5/20/2005 5:35 =
AM<BR><B>To:</B> =0A=
bluez-users@lists.sourceforge.net<BR><B>Subject:</B> Re: [Bluez-users] =
Bluetooth =0A=
PCMCIA progress...<BR></FONT><BR></DIV>=0A=
<DIV>=0A=
<P><FONT size=3D2>Hi John,<BR><BR>&gt; I am using the 3COM 3CRWB6096B =
ver 3 card =0A=
in a arm-linux system. I<BR>&gt; insert the card and see two serial =
ports come =0A=
online&nbsp; ttyS03 and<BR>&gt; ttyS04. When I&nbsp;&nbsp; "hciattach =
ttyS3 any" =0A=
and then "hciconfig -a" I can<BR>&gt; see that the hci_uart driver has =
attached =0A=
as an hci0 device...but the<BR>&gt; card BD address is all zeros. If I =
try to =0A=
"hciattach ttyS3 3com"&nbsp; the<BR>&gt; command always returns with =0A=
"Initialization timed out". Do I need to<BR>&gt; update/enter a CIS =
somewhere =0A=
for this device?&nbsp;&nbsp; "cardctl ident"<BR>&gt; returns with =
correct info =0A=
for this card.&nbsp; "hciconfig hci0 up" fails<BR>&gt; with "Can't init =
device =0A=
hci0: Connection timed out (110) "<BR><BR>that is no progress. The "any" =
method =0A=
is only dump. What about trying a<BR>2.6 =0A=
kernel?<BR><BR>Regards<BR><BR>Marcel<BR><BR><BR><BR><BR>-----------------=
--------------------------------------<BR>This =0A=
SF.Net email is sponsored by Oracle Space Sweepstakes<BR>Want to be the =
first =0A=
software developer in space?<BR>Enter now for the Oracle Space =0A=
Sweepstakes!<BR><A =0A=
href=3D"http://ads.osdn.com/?ad_id=3D7412&amp;alloc_id=3D16344&amp;op=3Dc=
lick">http://ads.osdn.com/?ad_id=3D7412&amp;alloc_id=3D16344&amp;op=3Dcli=
ck</A><BR>_______________________________________________<BR>Bluez-users =0A=
mailing list<BR>Bluez-users@lists.sourceforge.net<BR><A =0A=
href=3D"https://lists.sourceforge.net/lists/listinfo/bluez-users">https:/=
/lists.sourceforge.net/lists/listinfo/bluez-users</A><BR></FONT></P></DIV=
>=0A=
=0A=
</BODY>=0A=
</HTML>
------_=_NextPart_001_01C55D48.74EF1542--


-------------------------------------------------------
This SF.Net email is sponsored by Oracle Space Sweepstakes
Want to be the first software developer in space?
Enter now for the Oracle Space Sweepstakes!
http://ads.osdn.com/?ad_id=7412&alloc_id=16344&op=click
_______________________________________________
Bluez-users mailing list
Bluez-users@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-users
