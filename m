Return-Path: <bluez-users-admin@lists.sourceforge.net>
From: nicolas <n1c0l4s.l3@wanadoo.fr>
To: bluez-users@lists.sourceforge.net
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Message-Id: <200406151155.09370.n1c0l4s.l3@wanadoo.fr>
Subject: [Bluez-users] probleme installing Wireless IntelliMouse and optical desktop
Sender: bluez-users-admin@lists.sourceforge.net
Errors-To: bluez-users-admin@lists.sourceforge.net
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-users>,
	<mailto:bluez-users-request@lists.sourceforge.net?subject=unsubscribe>
List-Id: <bluez-users.lists.sourceforge.net>
List-Post: <mailto:bluez-users@lists.sourceforge.net>
List-Help: <mailto:bluez-users-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-users>,
	<mailto:bluez-users-request@lists.sourceforge.net?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=bluez-users>
Date: Tue, 15 Jun 2004 11:55:09 +0200

hi,=20

i have some questions =A0because i have kernel 2.6.7Rc2mdk and my bluetooth=
 is=20
recognise


$ hcitool inq
Inquiring ...
=A0 =A0 =A0 =A0 00:50:F2:7F:C4:E8 =A0 =A0 =A0 clock offset: 0x6892 =A0 =A0c=
lass: 0x002580
=A0 =A0 =A0 =A0 00:50:F2:80:A1:2B =A0 =A0 =A0 clock offset: 0x6d26 =A0 =A0c=
lass: 0x002540
$ hcitool scan
Scanning ...
=A0 =A0 =A0 =A0 00:50:F2:7F:C4:E8 =A0 =A0 =A0 Microsoft Mouse
=A0 =A0 =A0 =A0 00:50:F2:80:A1:2B =A0 =A0 =A0 Microsoft Keyboard
# hcitool info 00:50:F2:80:A1:2B
Requesting information ...
=A0 =A0 =A0 =A0 BD Address: =A000:50:F2:80:A1:2B
=A0 =A0 =A0 =A0 Device Name: Microsoft Keyboard
=A0 =A0 =A0 =A0 LMP Version: 1.1 (0x1) LMP Subversion: 0x1df
=A0 =A0 =A0 =A0 Manufacturer: Cambridge Silicon Radio (10)
=A0 =A0 =A0 =A0 Features: 0xfc 0xfb 0x0f 0x00 0x00 0x00 0x00 0x00
=A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 <encryption> <slot offset> <timing accuracy=
> <role switch>
=A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 <hold mode> <sniff mode> <park state> <RSSI=
> <SCO link>
=A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 <HV2 packets> <HV3 packets> <u-law log> <A-=
law log> <CVSD>
=A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 <paging scheme> <power control> <transparen=
t SCO>
# hcitool info 00:50:F2:7F:C4:E8
Requesting information ...
=A0 =A0 =A0 =A0 BD Address: =A000:50:F2:7F:C4:E8
=A0 =A0 =A0 =A0 Device Name: Microsoft Mouse
=A0 =A0 =A0 =A0 LMP Version: 1.1 (0x1) LMP Subversion: 0x1d0
=A0 =A0 =A0 =A0 Manufacturer: Cambridge Silicon Radio (10)
=A0 =A0 =A0 =A0 Features: 0xfc 0xfb 0x0f 0x00 0x00 0x00 0x00 0x00
=A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 <encryption> <slot offset> <timing accuracy=
> <role switch>
=A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 <hold mode> <sniff mode> <park state> <RSSI=
> <SCO link>
=A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 <HV2 packets> <HV3 packets> <u-law log> <A-=
law log> <CVSD>
=A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 <paging scheme> <power control> <transparen=
t SCO>
#

but how to connecte it =A0 to use it?

i don't understand =A0 i have look at=20
http://www.holtmann.org/linux/bluetooth/microsoft.html but it doesn't

there is someone using it and which have the solution?

thanks=20
=2D-=20
Ce mail a =E9t=E9 =E9crit sous linux mandrake cooker (www.linux-mandrake.co=
m/fr)
avec KMail 1.6.2 (www.kde.org)


-------------------------------------------------------
This SF.Net email is sponsored by The 2004 JavaOne(SM) Conference
Learn from the experts at JavaOne(SM), Sun's Worldwide Java Developer
Conference, June 28 - July 1 at the Moscone Center in San Francisco, CA
REGISTER AND SAVE! http://java.sun.com/javaone/sf Priority Code NWMGYKND
_______________________________________________
Bluez-users mailing list
Bluez-users@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-users
